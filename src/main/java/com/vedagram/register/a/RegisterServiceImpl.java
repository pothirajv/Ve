package com.vedagram.register.a;

import static com.vedagram.support.constant.SecurityConstants.SECRET;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.repository.UserRepository;
import com.vedagram.sms.SmsService;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class RegisterServiceImpl implements IRegisterService {

	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	private final UserRepository userRepository;

	@Autowired
	private RegisterMapper registerMapper;

	@Autowired
	private MongoTemplate mongotemplate;

	@Autowired
	Utility utility;

	@Autowired
	SmsService smsService;

	@Autowired
	HttpServletRequest request;

	@Autowired
	Environment env;

	public RegisterServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	/**
	 * Generates a JWT token containing username as subject and role as additional
	 * claims. These properties are taken from the specified User object. Tokens
	 * validity is infinite.
	 *
	 * @param u
	 * @return
	 */
	private String doGenerateToken(String mobileNumber, String email, String userId, String role) {
		Claims claims = Jwts.claims().setSubject(mobileNumber);
		claims.put("mobileNumber", mobileNumber);
		claims.put("email", email);
		claims.put("userID", userId);
		claims.put("role", role);
		return Jwts.builder().setClaims(claims).setIssuedAt(new Date(System.currentTimeMillis()))
				.signWith(SignatureAlgorithm.HS256, SECRET).compact();
	}

	public String generateRandomString() {
		int length = 7;
		boolean useLetters = true;
		boolean useNumbers = true;
		String generatedString = RandomStringUtils.random(length, useLetters, useNumbers);
		return generatedString;
	}

	@Override
	@Transactional
	public UsernamePasswordAuthenticationToken validateLogin(UserDto userDto) {
		String user = null;
		UserModel userModel = null;
		boolean emailAuthFlg = false;
		if (userDto.getEmail() != null && !userDto.getEmail().isEmpty() && userDto.getPassword() != null
				&& !userDto.getPassword().isEmpty()) {
			emailAuthFlg = true;
			userModel = userRepository.findByEmailIgnoreCase(userDto.getEmail());
			if (userModel == null) {
				throw new UsernameNotFoundException(userDto.getEmail() + " Not found");
			}
		}
		// else {
		// userModel =
		// userRepository.findByMobileNumber(registerModel.getMobileNumber());
		// if (userModel == null) {
		// throw new UsernameNotFoundException(registerModel.getMobileNumber() + " Not
		// found");
		// }
		// }

		/*
		 * if (!userModel.getRole().equals(GeneralConstants.ROLE_ADMIN) &&
		 * (userModel.getUflag() == null || userModel.getUflag().isEmpty() ||
		 * userModel.getUflag().equals("false"))) { throw new
		 * UsernameNotFoundException("Account not approved yet"); }
		 */

		String roleName = userModel.getRole();
		// Chari: to set userid for session
		String uid = userModel.getId();

		if ((emailAuthFlg == false) || (userModel.getPassword().equals(userDto.getPassword()))) {
			if (userModel.getUserToken() == null || userModel.getUserToken().isEmpty()) {
				user = doGenerateToken(userModel.getMobileNumber(), userDto.getEmail(), userModel.getId(), roleName);
				userModel.setUserToken(user);
				userModel.setRole(roleName);
			} else {
				user = userModel.getUserToken();
			}

			request.getSession().setAttribute("LoggedIn", "TRUE");
			request.getSession().setAttribute("UserName", userModel.getFirstName());
			request.getSession().setAttribute("Role", roleName);
			// Chari: to set userid for session
			request.getSession().setAttribute("UserId", uid);

			// userModel.setUserStatus(USERSTATUS_CONFIRMED);
			userRepository.save(userModel);
			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(roleName));
			User principal = new User(user, "", authorities);
			return new UsernamePasswordAuthenticationToken(principal, null, authorities);
		}

		if (emailAuthFlg == false) {
			throw new UsernameNotFoundException("Incorrect OTP");
		} else {
			throw new UsernameNotFoundException("Password mismatch");
		}
	}

	@Override
	@Transactional
	public UsernamePasswordAuthenticationToken validateLoginForApi(RegisterModel registerModel) {
		String user = null;
		UserModel userModel = null;
		boolean emailAuthFlg = false;
		if (registerModel.getEmail() != null && !registerModel.getEmail().isEmpty()
				&& registerModel.getPassword() != null && !registerModel.getPassword().isEmpty()) {
			emailAuthFlg = true;
			userModel = userRepository.findByEmailIgnoreCase(registerModel.getEmail());
			if (userModel == null) {
				throw new UsernameNotFoundException(registerModel.getEmail() + " Not found");
			}
		} else {
			throw new UsernameNotFoundException(registerModel.getMobileNumber() + " Not found");
		}

		String roleName = userModel.getRole();
		// Chari: to set userid for session
		String uid = userModel.getId();

		if ((emailAuthFlg == false)
				|| (emailAuthFlg == true && userModel.getPassword().equals(registerModel.getPassword()))) {
			if (userModel.getUserToken() == null || userModel.getUserToken().isEmpty()) {
				user = doGenerateToken(userModel.getMobileNumber(), registerModel.getEmail(), userModel.getId(),
						roleName);
				userModel.setUserToken(user);
				userModel.setRole(roleName);
				// userModel.setBalance(balance);
			} else {
				user = userModel.getUserToken();
			}

			request.getSession().setAttribute("LoggedIn", "TRUE");
			request.getSession().setAttribute("UserName", userModel.getFirstName());
			request.getSession().setAttribute("Role", roleName);
			// Chari: to set userid for session
			request.getSession().setAttribute("UserId", uid);

			// userModel.setUserStatus(USERSTATUS_CONFIRMED);
			userRepository.save(userModel);
			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(roleName));
			User principal = new User(user, "", authorities);
			return new UsernamePasswordAuthenticationToken(principal, null, authorities);
		}

		if (emailAuthFlg == false) {
			throw new UsernameNotFoundException("Incorrect OTP");
		} else {
			throw new UsernameNotFoundException("Password mismatch");
		}
	}

	int generateOtp() {
		int randomToken = new Random().nextInt(1000000) % 1000000;
		return randomToken;
	}

	@Override
	@Transactional
	public UsernamePasswordAuthenticationToken updateUserDetails(RegisterModel registerModel) {
		// String mobileNumber = utility.getMobileNumber();
		// if (registerModel.getEmail() != null && !registerModel.getEmail().isEmpty())
		// {
		// UserModel um = mongotemplate.findOne(new
		// Query(Criteria.where("email").is(registerModel.getEmail())),
		// UserModel.class);
		// if (um != null) {
		// List<GrantedAuthority> authorities = new ArrayList<>();
		// authorities.add(new SimpleGrantedAuthority(GeneralConstants.ROLE_USER));
		// User principal = new User("ERROR:Email Id Already Exist", "", authorities);
		// return new UsernamePasswordAuthenticationToken(principal, null, null);
		// }
		// }

		UserModel um = mongotemplate.findOne(new Query(Criteria.where("id").is(utility.getUserId())), UserModel.class);
		if (um != null) {
			String user = null;
			if (um.getUserToken() == null) {
				user = doGenerateToken(registerModel.getMobileNumber(), registerModel.getEmail(), um.getId(),
						um.getRole());
			} else {
				user = um.getUserToken();
			}

			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(um.getRole()));
			User principal = new User(user, "", authorities);
			// return new UsernamePasswordAuthenticationToken(principal, null, null);

			Query searchUserQuery = new Query(Criteria.where("id").is(utility.getUserId()));
			// RegisterModel registerModelResp = null;
			registerModel.setMobileNumber(registerModel.getMobileNumber());
			Update update;

			update = registerMapper.mapForRegisterUpdate(registerModel);

			UsernamePasswordAuthenticationToken authenticationToken = null;
			UserModel userModel;

			userModel = mongotemplate.findAndModify(searchUserQuery, update, new FindAndModifyOptions().returnNew(true),
					UserModel.class);

			authenticationToken = refreshToken(registerModel, userModel.getRole(), userModel.getUserToken());

			// registerModelResp = registerMapper.mapUserModelForForm(userModel);

			return authenticationToken;
		} else {
			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(""));
			User principal = new User("ERROR:Account doesn't exists", "", authorities);
			return new UsernamePasswordAuthenticationToken(principal, null, null);
		}

	}

	@Transactional
	public UsernamePasswordAuthenticationToken refreshToken(RegisterModel registerModel, String role, String token) {
		UserModel userModel = userRepository.findByEmailIgnoreCase(registerModel.getEmail());
		String user = null;
		if (token == null) {
			user = doGenerateToken(registerModel.getMobileNumber(), registerModel.getEmail(), userModel.getId(), role);
		} else {
			user = token;
		}
		mongotemplate.updateFirst(new Query(Criteria.where("mobileNumber").is(registerModel.getMobileNumber())),
				new Update().set("userToken", user).set("role", role), UserModel.class);
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(role));
		User principal = new User(user, "", authorities);
		return new UsernamePasswordAuthenticationToken(principal, null, null);
	}

	@Override
	public String insertUserDetails(RegisterModel registerModel) {
		if (registerModel != null) {
			UserModel userModel = null;
			if (registerModel.getEmail() != null && !registerModel.getEmail().isEmpty()) {
				userModel = userRepository.findByEmail(registerModel.getEmail());
				if (userModel != null) {
					return "ERROR:Email Id already exist";
				}
			}
			if(registerModel.getMobileNumber()!=null && !registerModel.getMobileNumber().isEmpty()) {
				userModel= mongoTemplate.findOne(new Query(Criteria.where("mobileNumber").is(registerModel.getMobileNumber())), UserModel.class);
				if (userModel != null) {
					return "ERROR:MobileNumber already exist";
				}
			}

			userModel = registerMapper.mapUserForDB(registerModel, null);
			userModel.setCreatedDate(new Date());
			userModel.setLastUpdatedDate(new Date());

			String flag = "false";
			if (registerModel.getRoleId() == 2) {
				userModel.setRole(GeneralConstants.ROLE_USER);
				flag = "true";
			} else if (registerModel.getRoleId() == 3) {
				userModel.setRole(GeneralConstants.ROLE_VENDOR);
			} else if (registerModel.getRoleId() == 4) {
				userModel.setRole(GeneralConstants.ROLE_TEMPADMIN);
			} else if (registerModel.getRoleId() == 5) {
				userModel.setRole(GeneralConstants.ROLE_PROJECTADMIN);
			}

			userModel.setUflag(flag);

			mongotemplate.insert(userModel);

			return "SUCCESS";
		}
		return "ERROR:Invalid data";
	}

	public boolean editUserDetails(RegisterModel registerModel) {
		Query q = new Query(Criteria.where("_id").is(utility.getUserId()));
		UserModel oldUsrModel = mongotemplate.findOne(q, UserModel.class);
		if (oldUsrModel != null) {
			oldUsrModel = registerMapper.mapUserForDBUpdate(registerModel, oldUsrModel);
			oldUsrModel.setLastUpdatedDate(new Date());
			oldUsrModel.setId(oldUsrModel.getId());
			userRepository.save(oldUsrModel);
			return true;
		}
		return false;
	}

	public UserModel myProfile(String userId) {
		Query q = new Query(Criteria.where("_id").is(userId));
		UserModel userModel = mongotemplate.findOne(q, UserModel.class);
		return userModel;
	}

	@Override
	public String chanePassword(UserDto userDto) {
		if (userDto.getPassword() != null && !userDto.getPassword().isEmpty() && userDto.getConfirmPassword() != null
				&& !userDto.getConfirmPassword().isEmpty() && userDto.getOldPassword() != null
				&& !userDto.getOldPassword().isEmpty()) {
			if (userDto.getPassword().equals(userDto.getConfirmPassword())) {
				UserModel userModel = mongotemplate.findOne(new Query(Criteria.where("_id").is(utility.getUserId())),
						UserModel.class);
				if (userModel != null) {
					if (userModel.getPassword().equals(userDto.getOldPassword())) {
						Update update = new Update();
						update.set("password", userDto.getPassword());
						Query userIdQuery = new Query(Criteria.where("_id").is(utility.getUserId()));
						mongoTemplate.findAndModify(userIdQuery, update, UserModel.class);
						return "SUCCESS:Password Changed";
					} else {
						return "ERROR:Old Password is wrong";
					}
				} else {
					return "ERROR:User not available";
				}
			} else {
				return "ERROR:Password does not match";
			}
		}

		return "ERROR:Password Required";
	}

	@Override
	public String forgotPassword(UserDto userDto) {
		if (userDto.getEmail() != null && !userDto.getEmail().isEmpty()) {
			UserModel userModel = userRepository.findByEmail(userDto.getEmail());
			if (userModel != null) {
				String resetPwdToken = generateUniqueId();
				userModel.setResetPwdToken(resetPwdToken);
				userRepository.save(userModel);

				String mailSubject = env.getProperty("forgetPasswordSubject");
				String mailContent = env.getProperty("forgetPasswordContents");

				String userName = (userModel.getFirstName() == null ? "" : userModel.getFirstName() + " ")
						+ (userModel.getLastName() == null ? "" : userModel.getLastName());

				String modifiedContent = mailContent.replace("[memberName]", userName).replace("[reset_token]",
						resetPwdToken);

				sendEmail(userModel.getEmail(), mailSubject, modifiedContent);
				return "SUCCESS:Reset password link sent to your Email Id!";
			} else {
				return "ERROR:Email Id Required";
			}
		} else {
			return "ERROR:Email Id Required";
		}
	}

	@Override
	public String verifyPasswordToken(String resetPwdToken) {
		if (resetPwdToken != null && !resetPwdToken.isEmpty()) {
			UserModel userModel = userRepository.findByResetPwdToken(resetPwdToken);
			if (userModel != null) {
				return "SUCCESS:Link is active";
			} else {
				return "ERROR:Invalid Link";
			}
		} else {
			return "ERROR:Reset Password Token is Required";
		}
	}

	@Override
	public String changePasswordByResetPwdToken(UserDto userDto) {

		if (userDto.getResetPwdToken() == null || userDto.getResetPwdToken().isEmpty() || userDto.getEmail() == null
				|| userDto.getEmail().isEmpty() || userDto.getPassword() == null || userDto.getPassword().isEmpty()
				|| userDto.getConfirmPassword() == null || userDto.getConfirmPassword().isEmpty()) {
			return "ERROR:Token, Email Id, Password and Confirm Password is required";
		}

		UserModel userModel = userRepository.findByResetPwdToken(userDto.getResetPwdToken());
		if (userModel != null) {
			if (!userModel.getEmail().equalsIgnoreCase(userDto.getEmail())) {
				return "ERROR:Invalid Email Id";
			}

			if (userDto.getPassword().equals(userDto.getConfirmPassword())) {
				userModel.setResetPwdToken("");
				userModel.setPassword(userDto.getPassword());
				userRepository.save(userModel);
				return "SUCCESS:Password updated successfully!";
			} else {
				return "ERROR:Password does not match";
			}
		} else {
			return "ERROR:Invalid Token";
		}
	}

	public String generateUniqueId() {
		Random rand = new Random();
		String rndm = Integer.toString(rand.nextInt()) + (System.currentTimeMillis() / 1000L);

		final String uuid = hashCal("SHA-256", rndm).substring(0, 20);
		return uuid;
	}

	public String hashCal(String type, String str) {
		byte[] hashseq = str.getBytes();
		StringBuffer hexString = new StringBuffer();
		try {
			MessageDigest algorithm = MessageDigest.getInstance(type);
			algorithm.reset();
			algorithm.update(hashseq);
			byte messageDigest[] = algorithm.digest();

			for (int i = 0; i < messageDigest.length; i++) {
				String hex = Integer.toHexString(0xFF & messageDigest[i]);
				if (hex.length() == 1)
					hexString.append("0");
				hexString.append(hex);
			}

		} catch (NoSuchAlgorithmException nsae) {
		}

		return hexString.toString();

	}

	public void sendEmailWhenForgetPassword(UserModel userModel) {

		String mailSubject = env.getProperty("forgetPasswordSubject");
		String mailContent = env.getProperty("forgetPasswordContents");

		String userName = (userModel.getFirstName() == null ? "" : userModel.getFirstName() + " ")
				+ (userModel.getLastName() == null ? "" : userModel.getLastName());

		String modifiedContent = mailContent.replace("[userName]", userName).replace("[password]",
				userModel.getPassword());

		sendEmail(userModel.getEmail(), mailSubject, modifiedContent);
	}

	@Async
	public String sendEmail(final String toMailAddress, final String subject, final String content) {

		String sendMail = env.getProperty("sendMail");
		if (sendMail == null || !sendMail.equalsIgnoreCase("yes")) {
			System.out.println("MAIL IGNORED");
			return "SENT";
		}

		new Thread(new Runnable() {

			public void run() {
				Message message = new MimeMessage(getSession());
				try {
					message.addRecipient(RecipientType.TO, new InternetAddress(toMailAddress));
				} catch (AddressException e) {
					e.printStackTrace();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
				try {
					String fromAddress = env.getProperty("fromAddress");
					message.addFrom(new InternetAddress[] { new InternetAddress(fromAddress) });
				} catch (AddressException e) {
					e.printStackTrace();
				} catch (MessagingException e) {
					e.printStackTrace();
				}

				try {
					message.setSubject(subject);

					message.setContent(content, "text/html");
					Transport.send(message);
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}).start();

		return "SENT";
	}

	private Session getSession() {

		String hostName = env.getProperty("hostName");
		String portNumber = env.getProperty("mailPort");

		Authenticator authenticator = new Authenticator();

		Properties properties = new Properties();
		properties.setProperty("mail.smtp.submitter", authenticator.getPasswordAuthentication().getUserName());
		properties.setProperty("mail.smtp.auth", "true");

		properties.setProperty("mail.smtp.host", hostName);
		properties.setProperty("mail.smtp.port", portNumber);

		// properties.put("mail.smtp.socketFactory.port", portNumber); // SSL
		// Port

		// SSL Start
		// properties.put("mail.smtp.socketFactory.class",
		// "javax.net.ssl.SSLSocketFactory");
		// properties.setProperty("mail.smtp.starttls.enable", "true");
		// SSL End

		return Session.getInstance(properties, authenticator);
	}

	private class Authenticator extends javax.mail.Authenticator {
		private PasswordAuthentication authentication;

		public Authenticator() {

			String fromEmail = env.getProperty("authAddress");
			String fromEmailPwd = env.getProperty("authPassword");

			authentication = new PasswordAuthentication(fromEmail, fromEmailPwd);
		}

		protected PasswordAuthentication getPasswordAuthentication() {
			return authentication;
		}
	}

	@Override
	public String changeMobileNumber(UserDto userDto) {
		if (userDto.getMobileNumber() != null && !userDto.getMobileNumber().isEmpty()) {
			Query query = new Query(Criteria.where("id").is(utility.getUserId()));
			UserModel userModel = mongoTemplate.findOne(query, UserModel.class);
			if (userModel != null) {
				
				Query query1 = new Query();  
				Criteria criteria = new Criteria();  
				criteria.orOperator(Criteria.where("mobileNumber").is(userDto.getMobileNumber()), 
				    Criteria.where("refMobileNumber").is(userDto.getMobileNumber()));
				query1.addCriteria(criteria);
				List<UserModel>	users=mongoTemplate.find(query1,UserModel.class);
				if(users.size()>0) {
					return "Mobile Number Already Exist";
				}
				String resetNumToken = generateUniqueId();
				userModel.setResetNumToken(resetNumToken);
				userModel.setRefMobileNumber(userDto.getMobileNumber());
				userRepository.save(userModel);

				String mailSubject = env.getProperty("changeMobileNumSubject");
				String mailContent = env.getProperty("changeMobileNumContents");

				String userName = (userModel.getFirstName() == null ? "" : userModel.getFirstName() + " ")
						+ (userModel.getLastName() == null ? "" : userModel.getLastName());

				String modifiedContent = mailContent.replace("[memberName]", userName).replace("[token]",
						resetNumToken);

				sendEmail(userModel.getEmail(), mailSubject, modifiedContent);
				return "SUCCESS:Link sent to your Email Id!";
				
			} else {
				return "ERROR:User Not Found";
			}
		} else {
			return "ERROR:Mobile Number Required";
		}
	}

	@Override
	public String changeNumberByResetNumToken(String resetNumToken) {
		if (resetNumToken == null || resetNumToken.isEmpty()) {
			return "ERROR:Token is required";
		}
		Query query = new Query(Criteria.where("id").is(utility.getUserId()));
		UserModel userModel= mongoTemplate.findOne(query,UserModel.class);
		if(userModel.getRefMobileNumber().equals(null) ||userModel.getRefMobileNumber().isEmpty()) {
			return "ERROR:Number Already Updated";
		}
		UserModel userModel1 = userRepository.findByResetNumTokenAndId(resetNumToken,utility.getUserId());
		if (userModel1 != null) {
			
			userModel1.setMobileNumber(userModel1.getRefMobileNumber());
			userModel1.setRefMobileNumber("");
			userModel1.setResetNumToken("");
				userRepository.save(userModel1);
				return "SUCCESS:Number Updated successfully!";
			
		} else {
			return "ERROR:Invalid User";
		}
	}

	@Override
	public List<UserModel> showAllUsers(String role) {
		List<UserModel> userModels =new ArrayList<>();
		if(role.equals(GeneralConstants.ROLE_TEMPADMIN)) {
		   userModels= userRepository.findByRoleAndUflag(GeneralConstants.ROLE_TEMPADMIN,"true");
		}
		else if(role.equals(GeneralConstants.ROLE_PROJECTADMIN)) {
			 userModels= userRepository.findByRoleAndUflag(GeneralConstants.ROLE_PROJECTADMIN,"true");
		}
		else if(role.equals(GeneralConstants.ROLE_VENDOR)) {
			 userModels= userRepository.findByRoleAndUflag(GeneralConstants.ROLE_VENDOR,"true");
		}
		
		return userModels;
	}

	@Override
	@Transactional
	public UsernamePasswordAuthenticationToken validateLogin(String mobileNumber) {
		String user = null;
		UserModel userModel = null;
		
			userModel= mongoTemplate.findOne(new Query(Criteria.where("mobileNumber").is(mobileNumber)), UserModel.class);
			if (userModel == null) {
				throw new UsernameNotFoundException( "Mobile Number Not found");
			}
		
			String roleName = userModel.getRole();
			String uid = userModel.getId();

			if (userModel.getUserToken() == null || userModel.getUserToken().isEmpty()) {
				user = doGenerateToken(userModel.getMobileNumber(), userModel.getEmail(), userModel.getId(), roleName);
				userModel.setUserToken(user);
				userModel.setRole(roleName);
			} else {
				user = userModel.getUserToken();
			}

			request.getSession().setAttribute("LoggedIn", "TRUE");
			request.getSession().setAttribute("UserName", userModel.getFirstName());
			request.getSession().setAttribute("Role", roleName);
			request.getSession().setAttribute("UserId", uid);

			userRepository.save(userModel);
			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(roleName));
			User principal = new User(user, "", authorities);
			return new UsernamePasswordAuthenticationToken(principal, null, authorities);
	}
}