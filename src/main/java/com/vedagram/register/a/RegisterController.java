/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.register.a;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.vedagram.admin.adm.IAdminService;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.repository.UserRepository;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;

/**
 *
 * @author Winston
 */

@RestController
@RequestMapping(path = "/user/")
public class RegisterController {

	private static final Logger LOGGER = LoggerFactory.getLogger(RegisterController.class);

	@Autowired
	private IRegisterService iRegisterService;

	@Autowired
	private IAdminService iAdminService;
	@Autowired
	UserRepository userRepository;
	@Autowired
	Utility utility;
	@Autowired
	MongoTemplate mongoTemplate;

	@RequestMapping(path = "register", method = RequestMethod.POST)
	ResponseEntity<Object> insertUserDetails(@RequestBody RegisterModel registerModel) {
		RegisterResponse registerResponse = new RegisterResponse();	
		String remMsg = iRegisterService.insertUserDetails(registerModel);
		registerResponse.setResponseText(remMsg);
		return ResponseEntity.ok(registerResponse);
	}

	@RequestMapping(path = "loginValidate", method = RequestMethod.POST)
	ResponseEntity<Object> loginValidate(@RequestBody @Valid UserDto userDto, HttpServletResponse response,HttpSession session) {
		String resMsg = "";
		UserModel um= userRepository.findByEmail(userDto.getEmail());
		try {
			final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = iRegisterService
					.validateLogin(userDto);
			session.setAttribute("Authorization", "Bearer " + usernamePasswordAuthenticationToken.getName());
			User principal = (User) usernamePasswordAuthenticationToken.getPrincipal();
			if (principal.getAuthorities() != null && principal.getAuthorities().size() > 0) {
				String roleName = principal.getAuthorities().toArray()[0].toString();
				LoginResponse loginResponse = new LoginResponse();
				if (roleName.equals(GeneralConstants.ROLE_USER)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_TEMPADMIN)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_VENDOR)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_ADMIN)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_PROJECTADMIN)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} 
			}
		} catch (UsernameNotFoundException e) {
			resMsg = "ERROR:" + e.getMessage();
			LoginResponse loginResponse = new LoginResponse();
			loginResponse.setResponseText(resMsg);
			loginResponse.setUserToken(null);
			loginResponse.setUserModel(null);
			return ResponseEntity.ok(loginResponse);
		}
		return ResponseEntity.ok(resMsg);
	}

	@RequestMapping(path = "loginValidate1", method = RequestMethod.POST)
	ResponseEntity<Object> loginValidate1(@RequestBody @Valid UserDto userDto, HttpServletResponse response,
			HttpSession session) {
		String resMsg = "";
		try {
			final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = iRegisterService
					.validateLogin(userDto);
			session.setAttribute("Authorization", "Bearer " + usernamePasswordAuthenticationToken.getName());
			resMsg = "SUCCESS:" + usernamePasswordAuthenticationToken.getName();
		} catch (UsernameNotFoundException e) {
			resMsg = "ERROR:" + e.getMessage();
		}
		return ResponseEntity.ok(resMsg);
	}

	@RequestMapping(path = "myProfile", method = RequestMethod.POST)
	@ResponseBody
	public UserModel myProfile() {
		String uid = utility.getUserId();
		return iRegisterService.myProfile(uid);
	}

	@RequestMapping(path = "update", method = RequestMethod.POST)
	ResponseEntity<Object> updateUser(@RequestBody @Valid RegisterModel registerModel, HttpServletResponse response,
			HttpSession session) {
		String resMsg = "";
		try {
			final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = iRegisterService
					.updateUserDetails(registerModel);
			session.setAttribute("Authorization", "Bearer " + usernamePasswordAuthenticationToken.getName());
			User principal = (User) usernamePasswordAuthenticationToken.getPrincipal();
			if (principal.getAuthorities() != null && principal.getAuthorities().size() > 0) {
				String roleName = principal.getAuthorities().toArray()[0].toString();

				if (roleName.equals(GeneralConstants.ROLE_USER)) {
					resMsg = "SUCCESS";
				} else if (roleName.equals(GeneralConstants.ROLE_TEMPADMIN)) {
					resMsg = "SUCCESS";
				} else if (roleName.equals(GeneralConstants.ROLE_VENDOR)) {
					resMsg = "SUCCESS";
				} else if (roleName.equals(GeneralConstants.ROLE_ADMIN)) {
					resMsg = "SUCCESS";
				}
				else if (roleName.equals(GeneralConstants.ROLE_PROJECTADMIN)) {
					resMsg = "SUCCESS";
				}
			}
		} catch (UsernameNotFoundException e) {
			resMsg = "ERROR:" + e.getMessage();
		}
		return ResponseEntity.ok(resMsg);
	}

	@RequestMapping(path = "changePassword", method = RequestMethod.POST)
	public String changePassword(@RequestBody UserDto userDto) {
		return iRegisterService.chanePassword(userDto);
	}

	@RequestMapping(value = "forgotpassword")
	@ResponseBody
	public String forgotPassword(@RequestBody UserDto userDto) {
		return iRegisterService.forgotPassword(userDto);
	}

	@RequestMapping(value = "{resetPwdToken}/pwdtkn")
	@ResponseBody
	public String verifyPasswordToken(@PathVariable(value = "resetPwdToken") String resetPwdToken) {
		return iRegisterService.verifyPasswordToken(resetPwdToken);
	}

	@RequestMapping(value = "changePasswordByTkn")
	@ResponseBody
	public String changePasswordByResetPwdToken(@RequestBody UserDto userDto) {
		return iRegisterService.changePasswordByResetPwdToken(userDto);
	}
	@RequestMapping(value = "changeMobileNumber")
	@ResponseBody
	public String changeMobileNumber(@RequestBody UserDto userDto) {
		return iRegisterService.changeMobileNumber(userDto);
	}
	@RequestMapping(value = "changeNumberByTkn")
	@ResponseBody
	public String changeNumberByResetNumToken(@RequestParam("resetNumToken") String resetNumToken ) {
		return iRegisterService.changeNumberByResetNumToken(resetNumToken);
	}
	@RequestMapping(value = "{role}/showAllUserByAdmin")
	@ResponseBody
	public List<UserModel> showAllUsersForAdmin(@PathVariable(value = "role") String role) {
		return iRegisterService.showAllUsers(role);
	}
	@RequestMapping(value = "verifyMobileNumber", method = RequestMethod.POST)
	public boolean verifyMobileNumber(@RequestParam String mobileNumber) {
		
		if(!mobileNumber.isEmpty()) {
			UserModel userModel = mongoTemplate.findOne(new Query(Criteria.where("mobileNumber").is(mobileNumber)), UserModel.class);
			if(userModel!=null) {
				return true;
			}
		}
		return false;
		
	}
	@RequestMapping(path = "loginViaMoblieNumber", method = RequestMethod.POST)
	ResponseEntity<Object> validateMobileNumber(@RequestParam @Valid String mobileNumber, HttpServletResponse response,HttpSession session) {
		String resMsg = "";
		UserModel um= mongoTemplate.findOne(new Query(Criteria.where("mobileNumber").is(mobileNumber)), UserModel.class);
		try {
			final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = iRegisterService
					.validateLogin(mobileNumber);
			session.setAttribute("Authorization", "Bearer " + usernamePasswordAuthenticationToken.getName());
			User principal = (User) usernamePasswordAuthenticationToken.getPrincipal();
			if (principal.getAuthorities() != null && principal.getAuthorities().size() > 0) {
				String roleName = principal.getAuthorities().toArray()[0].toString();
				LoginResponse loginResponse = new LoginResponse();
				if (roleName.equals(GeneralConstants.ROLE_USER)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_TEMPADMIN)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_VENDOR)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_ADMIN)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} else if (roleName.equals(GeneralConstants.ROLE_PROJECTADMIN)) {
					loginResponse.setResponseText("SUCCESS");
					loginResponse.setUserToken(usernamePasswordAuthenticationToken.getName());
					loginResponse.setUserModel(um);
					return ResponseEntity.ok(loginResponse);
				} 
			}
		} catch (UsernameNotFoundException e) {
			resMsg = "ERROR:" + e.getMessage();
			LoginResponse loginResponse = new LoginResponse();
			loginResponse.setResponseText(resMsg);
			loginResponse.setUserToken(null);
			loginResponse.setUserModel(null);
			return ResponseEntity.ok(loginResponse);
		}
		return ResponseEntity.ok(resMsg);
	}

}