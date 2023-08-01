package com.vedagram.admin.adm;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropService;
import com.vedagram.pddelv.PickDropShipmentReqDto;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.projectadm.ProjectModel;
import com.vedagram.projectadm.ProjectRepository;
import com.vedagram.repository.UserRepository;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.constant.SecurityConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.PoojaOfferingsRepository;
import com.vedagram.tempadmin.TempleRepository;
import com.vedagram.tempadmin.Temples;
import com.vedagram.tempadmin.TemplesDto;
import com.vedagram.user.CancelOrderDto;
import com.vedagram.user.CanceledOrderDetails;
import com.vedagram.user.DonationModelDto;
import com.vedagram.user.DonationOrders;
import com.vedagram.user.GrammerceOrders;
import com.vedagram.user.GrammerceOrdersDto;
import com.vedagram.user.Location;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.ProjectDonation;
import com.vedagram.vendor.PoojaMaterial;
import com.vedagram.vendor.PoojaMaterialRepository;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
public class AdminServiceImpl implements IAdminService {

	@Autowired
	MongoTemplate mongoTemplate;

	@Autowired
	Utility utility;

	@Autowired
	Environment env;
	@Autowired
	PickDropService pickDropService;
	@Autowired
	UserRepository userRepository;
	@Autowired
	PoojaOfferingsRepository poojaOfferingsRepository;
	@Autowired
	PoojaMaterialRepository poojaMaterialRepository;
	@Autowired
	GrammerceRepository grammerceRepository;
	@Autowired
	TempleRepository templeRepository;
	@Autowired
	ProjectRepository projectRepository;

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	@Transactional

	public UsernamePasswordAuthenticationToken switchToUser(String userId, HttpServletRequest request) {
		Query query = new Query(Criteria.where("_id").is(userId));
		UserModel userModel = mongoTemplate.findOne(query, UserModel.class);
		if (userModel != null) {
			String roleName = userModel.getRole();
			String uid = userModel.getId();
			String user = null;

			if (!userModel.getRole().equals(GeneralConstants.ROLE_ADMIN) && (userModel.getUflag() == null
					|| userModel.getUflag().isEmpty() || userModel.getUflag().equals("false"))) {
				throw new UsernameNotFoundException("Account not approved yet");
			}

			if (userModel.getUserToken() == null || userModel.getUserToken().isEmpty()) {
				user = doGenerateToken(userModel.getMobileNumber(), userModel.getEmail(), userModel.getId(), roleName);
				userModel.setUserToken(user);
				userModel.setRole(roleName);
			} else {
				user = userModel.getUserToken();
			}

			if (userModel.getRole() == null || userModel.getRole().isEmpty()
					|| userModel.getRole().equals(GeneralConstants.ROLE_USER)
					|| userModel.getRole().equals(GeneralConstants.ROLE_DELIVER)) {
				throw new UsernameNotFoundException("Web portal is only for Vendor. Please use mobile app");
			}

			request.getSession().setAttribute("LoggedIn", "TRUE");
			request.getSession().setAttribute("UserName", userModel.getFirstName());
			request.getSession().setAttribute("Role", roleName);
			request.getSession().setAttribute("UserId", uid);
			request.getSession().setAttribute("adminId", utility.getUserId());

			// userModel.setUserStatus(GeneralConstants.USERSTATUS_CONFIRMED);
			userRepository.save(userModel);
			List<GrantedAuthority> authorities = new ArrayList<>();
			authorities.add(new SimpleGrantedAuthority(roleName));
			User principal = new User(user, "", authorities);
			return new UsernamePasswordAuthenticationToken(principal, null, authorities);
		} else {
			throw new UsernameNotFoundException("User not found");
		}
	}

	private String doGenerateToken(String mobileNumber, String email, String userId, String role) {
		Claims claims = Jwts.claims().setSubject(mobileNumber);
		claims.put("mobileNumber", mobileNumber);
		claims.put("email", email);
		claims.put("userID", userId);
		claims.put("role", role);
		return Jwts.builder().setClaims(claims).setIssuedAt(new Date(System.currentTimeMillis()))
				.signWith(SignatureAlgorithm.HS256, SecurityConstants.SECRET).compact();
	}

	@Override
	public List<UserModel> listOfUsers() {
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "createdDate"));
		List<UserModel> listOfUsers = mongoTemplate.find(query, UserModel.class);
		List<UserModel> listUsers = new ArrayList<UserModel>();
		for (UserModel list : listOfUsers) {
			if (!list.getRole().equals("ROLE_ADMIN")) {
				listUsers.add(list);
			}
		}
		return listUsers;
	}

	@Override
	public String actInactUser(String userId, String activeFlag, String comment) {
		Query query = new Query(Criteria.where("_id").is(userId));
		UserModel userModel = mongoTemplate.findOne(query, UserModel.class);

		if (userModel != null) {
			Update update = new Update();
			update.set("uflag", activeFlag);
			if (activeFlag.equals("true")) {
				update.set("activeComment", comment);
			} else {
				update.set("inactiveComment", comment);
			}
			userModel = mongoTemplate.findAndModify(query, update, new FindAndModifyOptions().returnNew(true),
					UserModel.class);
		}
		if (userModel.getRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
			List<TemplesDto> temples = templeRepository.findByCreatedBy(userModel.getId());
			for (TemplesDto temple : temples) {

				Query query1 = new Query(Criteria.where("id").in(temple.getId()));
				if (userModel.getUflag().equals("true")) {
					Update update = new Update();
					update.set("activeFlag", "true");
					mongoTemplate.findAndModify(query1, update, Temples.class);
				}
				if (userModel.getUflag().equals("false")) {
					Update update = new Update();
					update.set("activeFlag", "false");
					mongoTemplate.findAndModify(query1, update, Temples.class);
				}

			}

		}
		if (userModel.getRole().equals(GeneralConstants.ROLE_PROJECTADMIN)) {
			List<ProjectModel> projects = projectRepository.findByCreatedById(userModel.getId());
			for (ProjectModel project : projects) {
				Update update = new Update();
				Query query1 = new Query(Criteria.where("id").in(project.getId()));
				if (userModel.getUflag().equals("false")) {
					update.set("projectStatus", GeneralConstants.PROJECT_STATUS_PENDING);
					mongoTemplate.findAndModify(query1, update, ProjectModel.class);
				}
				if (userModel.getUflag().equals("true")) {
					update.set("projectStatus", GeneralConstants.PROJECT_STATUS_ACTIVE);
					mongoTemplate.findAndModify(query1, update, ProjectModel.class);
				}

			}
		}
		if (userModel.getRole().equals(GeneralConstants.ROLE_VENDOR)) {
			List<PoojaMaterial> poojaMaterials = poojaMaterialRepository.findByCreatedById(userModel.getId());
			for (PoojaMaterial poojaMaterial : poojaMaterials) {

				Query query1 = new Query(Criteria.where("id").in(poojaMaterial.getId()));
				if (userModel.getUflag().equals("false")) {
					Update update = new Update();
					update.set("activeflag", "false");
					mongoTemplate.findAndModify(query1, update, PoojaMaterial.class);
				}
				if (userModel.getUflag().equals("true")) {
					Update update = new Update();
					update.set("activeflag", "true");
					mongoTemplate.findAndModify(query1, update, PoojaMaterial.class);
				}

			}
		}
		return userModel.getUflag();
	}

	public List<PoojaOfferings> showAllPoojaOffering() {
		List<PoojaOfferings> listOfpoojaOfferigs = poojaOfferingsRepository.findAll();
		return listOfpoojaOfferigs;

	}

	public PoojaOfferings viewPoojaInfo(String poojaId) {
		Query poojaQuery = new Query(Criteria.where("_id").is(poojaId));
		PoojaOfferings poojaInfo = mongoTemplate.findOne(poojaQuery, PoojaOfferings.class);
		return poojaInfo;

	}

	@Override
	public String setTempleFlag(String templeId, String activeFlag, String comment) {
		Query templeQuery = new Query(Criteria.where("_id").is(templeId));
		Temples temples = mongoTemplate.findOne(templeQuery, Temples.class);
		if (temples != null) {
			Update update = new Update();
			update.set("activeFlag", activeFlag);
			if (activeFlag.equals("true")) {
				update.set("activeComment", comment);
			} else {
				update.set("inactiveComment", comment);
			}
			mongoTemplate.findAndModify(templeQuery, update, Temples.class);

		}
		return activeFlag;
	}

	public String addGrammerce(Grammerce grammerce, List<MultipartFile> imgList) throws IOException {

		if (grammerce != null && imgList != null) {
			Grammerce grammerceModel = grammerceRepository.findByProductName(grammerce.getProductName());
			if (grammerceModel == null) {
				grammerce.setActiveFlag("true");

				mongoTemplate.insert(grammerce);

				for (MultipartFile mf : imgList) {
					String extUrl = env.getProperty("ext.app.img.dir");
					String grammerceUrl = extUrl + "/grammerce/";
					File newFolder = new File(grammerceUrl + grammerce.getId());
					if (!newFolder.exists()) {
						newFolder.mkdirs();
					}
					byte[] bytes = mf.getBytes();
					Path path = Paths.get(newFolder + "/" + mf.getOriginalFilename());
					Files.write(path, bytes);
				}
				return "SUCCESS";
			}

			else {
				return "ERROR:Product Name Already Exist";
			}

		}

		return "ERROR:Invalid data";

	}

	public GrammerceDto viewGrammerce(String grammerceId) throws IOException {

		Query q = new Query(Criteria.where("_id").is(grammerceId));
		Grammerce grammerce = mongoTemplate.findOne(q, Grammerce.class);

		GrammerceDto grammerceDto = new GrammerceDto();
		grammerceDto.setId(grammerce.getId());
		grammerceDto.setBrandName(grammerce.getBrandName());
		grammerceDto.setPrice(grammerce.getPrice());
		grammerceDto.setStock(grammerce.getStock());
		grammerceDto.setProductName(grammerce.getProductName());
		grammerceDto.setSignificance(grammerce.getSignificance());
		grammerceDto.setDeliveryLeadTime(grammerce.getDeliveryLeadTime());
		grammerceDto.setActiveFlag(grammerce.getActiveFlag());
		grammerceDto.setActiveComment(grammerce.getActiveComment());
		grammerceDto.setInactiveComment(grammerce.getInactiveComment());
		grammerceDto.setCountry(grammerce.getCountry());
		grammerceDto.setState(grammerce.getState());
		grammerceDto.setDistrict(grammerce.getDistrict());

		String extUrl = env.getProperty("ext.app.img.dir");
		String grammerceUrl = extUrl + "/grammerce/" + grammerceDto.getId();
		File grammerceImg = new File(grammerceUrl);
		if (grammerceImg.exists()) {
			List<String> fileList = Arrays.asList(grammerceImg.list());
			List<String> imageFilesList = new ArrayList<String>();
			for (String s : fileList) {
				imageFilesList.add(env.getProperty("app.img.dir") + "/grammerce/" + grammerceDto.getId() + "/" + s);
			}

			grammerceDto.setGrammerceImgsUrl(imageFilesList);
		}
		return grammerceDto;
	}

	public List<GrammerceDto> showAllGrammerce(String pincode) throws IOException {

		List<Criteria> criteriaList = new ArrayList<>();
		List<GrammerceDto> grammerceDtoList = new ArrayList<GrammerceDto>();

		if (pincode != null && !pincode.isEmpty()) {
			Criteria criteria1 = Criteria.where("pincode")
					.regex(Pattern.compile(pincode, Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria1);
		}

		Criteria queryCriteria = new Criteria().orOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria).with(new Sort(Sort.Direction.ASC, "pincode"));
		List<Location> pcList = mongoTemplate.find(query, Location.class);
		if (!CollectionUtils.isEmpty(pcList)) {
			List<String> statesOld = pcList.stream().map(Location::getStateName).distinct().collect(Collectors.toList());
			List<String> states = new ArrayList<>();
			for (String state : statesOld) {
				states.add(state.toUpperCase());
			}
			
			List<String> districtsOld = pcList.stream().map(Location::getDistrict).distinct().collect(Collectors.toList());
			List<String> districts = new ArrayList<>();
			for (String district : districtsOld) {
				districts.add(district.toUpperCase());
			}
			
			List<String> districtsFinalList = new ArrayList<>();
			for (String state : states) {
				for (String district : districts) {
					districtsFinalList.add(state + "||" + district);
				}
//				districtsFinalList.add(state + "||ALL");
			}

			Criteria queryCriteriaAnd1 = new Criteria();
			Criteria queryCriteriaOr1 = new Criteria();
			Criteria queryCriteriaAnd2 = new Criteria();
			
			queryCriteriaAnd2.andOperator(Criteria.where("state").exists(false), Criteria.where("country").in(Arrays.asList("India")));
			queryCriteriaOr1.orOperator(Criteria.where("state").in(states), queryCriteriaAnd2);
			queryCriteriaAnd1.andOperator(Criteria.where("activeFlag").is("true"), queryCriteriaOr1);
			Query query1 = new Query(queryCriteriaAnd1);

			List<Grammerce> grammerceList = mongoTemplate.find(query1, Grammerce.class);
			
			for (Grammerce grammerce : grammerceList) {
				for (String state : states) {
					if(grammerce.getDistrict().stream().anyMatch(s -> s.contains(state))) {
						if(!Collections.disjoint(grammerce.getDistrict(), districtsFinalList)) {
							GrammerceDto grammerceDto = createGrammerceDto(grammerce);
							grammerceDtoList.add(grammerceDto);
						}
					} else {
						GrammerceDto grammerceDto = createGrammerceDto(grammerce);
						grammerceDtoList.add(grammerceDto);
					}
				}
			}
			
//			List<Grammerce> grammerceList = grammerceRepository.findAll();

//			for (Grammerce grammerce : grammerceList) {
//				if (grammerce.getActiveFlag().equals("true")) {
//					if (!CollectionUtils.isEmpty(grammerce.getDistrict())) {
//						for (String g : grammerce.getDistrict()) {
//							if (g.equalsIgnoreCase(districts.get(districts.size() - 1))) {
//
//								GrammerceDto grammerceDto = createGrammerceDto(grammerce);
//
//								grammerceDtoList.add(grammerceDto);
//							}
//						}
//					} else if (!CollectionUtils.isEmpty(grammerce.getState())) {
//						for (String s : grammerce.getState()) {
//							if (s.equalsIgnoreCase(states.get(states.size() - 1))) {
//
//								GrammerceDto grammerceDto = createGrammerceDto(grammerce);
//
//								grammerceDtoList.add(grammerceDto);
//							}
//						}
//					} else if (!CollectionUtils.isEmpty(grammerce.getCountry())) {
//						for (String s : grammerce.getCountry()) {
//							if (s.equalsIgnoreCase("India")) {
//
//								GrammerceDto grammerceDto = createGrammerceDto(grammerce);
//
//								grammerceDtoList.add(grammerceDto);
//
//							}
//						}
//
//					}
//
//				}
//
//			}
		}
		return grammerceDtoList;
	}

	private GrammerceDto createGrammerceDto(Grammerce grammerce) {
		GrammerceDto grammerceDto = new GrammerceDto();
		grammerceDto.setId(grammerce.getId());
		grammerceDto.setBrandName(grammerce.getBrandName());
		grammerceDto.setPrice(grammerce.getPrice());
		grammerceDto.setStock(grammerce.getStock());
		grammerceDto.setProductName(grammerce.getProductName());
		grammerceDto.setSignificance(grammerce.getSignificance());
		grammerceDto.setActiveFlag(grammerce.getActiveFlag());
		grammerceDto.setDeliveryLeadTime(grammerce.getDeliveryLeadTime());
		grammerceDto.setActiveComment(grammerce.getActiveComment());
		grammerceDto.setInactiveComment(grammerce.getInactiveComment());
		grammerceDto.setCountry(grammerce.getCountry());
		grammerceDto.setState(grammerce.getState());
		grammerceDto.setDistrict(grammerce.getDistrict());

		String extUrl = env.getProperty("ext.app.img.dir");
		String grammerceUrl = extUrl + "/grammerce/" + grammerceDto.getId();
		File grammerceImg = new File(grammerceUrl);
		if (grammerceImg.exists()) {
			List<String> fileList = Arrays.asList(grammerceImg.list());
			List<String> imageFilesList = new ArrayList<String>();
			for (String s1 : fileList) {
				imageFilesList.add(env.getProperty("app.img.dir") + "/grammerce/" + grammerceDto.getId() + "/" + s1);
			}

			grammerceDto.setGrammerceImgsUrl(imageFilesList);
		}

		return grammerceDto;
	}

	public List<GrammerceDto> showAllGrammerceForAdmin() throws IOException {

		List<Grammerce> grammerceList = grammerceRepository.findAll();
		List<GrammerceDto> grammerceDtoList = new ArrayList<GrammerceDto>();
		for (Grammerce grammerce : grammerceList) {
			GrammerceDto grammerceDto = new GrammerceDto();
			grammerceDto.setId(grammerce.getId());
			grammerceDto.setBrandName(grammerce.getBrandName());
			grammerceDto.setPrice(grammerce.getPrice());
			grammerceDto.setStock(grammerce.getStock());
			grammerceDto.setProductName(grammerce.getProductName());
			grammerceDto.setSignificance(grammerce.getSignificance());
			grammerceDto.setActiveFlag(grammerce.getActiveFlag());
			grammerceDto.setDeliveryLeadTime(grammerce.getDeliveryLeadTime());
			grammerceDto.setActiveComment(grammerce.getActiveComment());
			grammerceDto.setInactiveComment(grammerce.getInactiveComment());
			grammerceDto.setCountry(grammerce.getCountry());
			grammerceDto.setState(grammerce.getState());
			grammerceDto.setDistrict(grammerce.getDistrict());

			String extUrl = env.getProperty("ext.app.img.dir");
			String grammerceUrl = extUrl + "/grammerce/" + grammerceDto.getId();
			File grammerceImg = new File(grammerceUrl);
			if (grammerceImg.exists()) {
				List<String> fileList = Arrays.asList(grammerceImg.list());
				List<String> imageFilesList = new ArrayList<String>();
				for (String s : fileList) {
					imageFilesList.add(env.getProperty("app.img.dir") + "/grammerce/" + grammerceDto.getId() + "/" + s);
				}

				grammerceDto.setGrammerceImgsUrl(imageFilesList);
			}
			grammerceDtoList.add(grammerceDto);

		}
		return grammerceDtoList;
	}

	public String updateGrammerce(Grammerce grammerce, List<MultipartFile> imgList) throws IOException {
		Query query = new Query(Criteria.where("_id").is(grammerce.getId()));
		Grammerce grammerceModel = mongoTemplate.findOne(query, Grammerce.class);

		if (grammerceModel != null) {
			Grammerce otherGrammerceModel = grammerceRepository.findByProductNameAndIdNot(grammerce.getProductName(),
					grammerce.getId());
			if (otherGrammerceModel != null) {
				return "ERROR:productName Already Exist";
			}

			Query searchGrammerceQuery = new Query(Criteria.where("_id").is(grammerce.getId()));
			Update update = new Update();

			update.set("productName", grammerce.getProductName());
			update.set("brandName", grammerce.getBrandName());
			update.set("price", grammerce.getPrice());
			update.set("stock", grammerce.getStock());
			update.set("deliveryLeadTime", grammerce.getDeliveryLeadTime());
			update.set("significance", grammerce.getSignificance());
			update.set("country", grammerce.getCountry());
			update.set("state", grammerce.getState());
			update.set("district", grammerce.getDistrict());
			mongoTemplate.findAndModify(searchGrammerceQuery, update, new FindAndModifyOptions().returnNew(true),
					Grammerce.class);
			// String extUrl = env.getProperty("ext.app.img.dir");
			// String templeUrl = extUrl + "/grammerce/";
			// File newFolder = new File(templeUrl + grammerce.getId());
			if (imgList != null && !imgList.isEmpty()) {
				String extUrl = env.getProperty("ext.app.img.dir");
				String grammerceUrl = extUrl + "/grammerce/";
				File newFolder = new File(grammerceUrl + grammerce.getId());

				if(newFolder.exists())
					FileUtils.cleanDirectory(newFolder);
				else
					newFolder.mkdirs();
				
				for (MultipartFile mf : imgList) {

					byte[] bytes = mf.getBytes();
					Path path = Paths.get(newFolder + "/" + mf.getOriginalFilename());

					Files.write(path, bytes);
				}

				return "SUCCESS";
			}
			return "SUCCESS";
		}
		return "ERROR!";

	}

	@Override
	public List<PoojaOfferingOrders> getAllOrdersForPoojaOfferings() {
		Query orderQuery = new Query();
		orderQuery.with(new Sort(Sort.Direction.DESC, "createdDate"));
		return mongoTemplate.find(orderQuery, PoojaOfferingOrders.class);
	}

	@Override
	public List<PoojaMaterialOrders> getAllOrdersForPoojaMaterials() {
		Query materialQuery = new Query();
		materialQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
		return mongoTemplate.find(materialQuery, PoojaMaterialOrders.class);
	}

	@Override
	public List<GrammerceOrdersDto> getAllOrdersForGrammerce() {
		List<GrammerceOrders> grammerceOrdersList = new ArrayList<GrammerceOrders>();
		List<GrammerceOrdersDto> grammerceOrdersDtos = new ArrayList<GrammerceOrdersDto>();
		if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			Query grammerceQuery = new Query();
			grammerceQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
			grammerceOrdersList = mongoTemplate.find(grammerceQuery, GrammerceOrders.class);

		} else if (utility.getUserRole().equals(GeneralConstants.ROLE_USER)) {
			Query grammerceQuery = new Query(Criteria.where("userModel").is(utility.getUserId()));
			grammerceQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
			grammerceOrdersList = mongoTemplate.find(grammerceQuery, GrammerceOrders.class);

		}
		for (GrammerceOrders grammerceOrders : grammerceOrdersList) {
			GrammerceOrdersDto grammerceOrdersDto = new GrammerceOrdersDto();
			String amt = grammerceOrders.getTotalPrice();
			String amt1 = amt.split("\\.")[0];
			int totalPrice = Integer.parseInt(amt1);
			int totalOrderAmount = (int) (grammerceOrders.getPdAmt() + totalPrice);
			BeanUtils.copyProperties(grammerceOrders, grammerceOrdersDto);
			grammerceOrdersDto.setTotalPaidAmount(totalOrderAmount);
			grammerceOrdersDto.setExpDeliveryDate(grammerceOrders.getExpDeliveryDate());
			grammerceOrdersDto.setRefundFlag(grammerceOrders.isRefundFlag());
			if(grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_CANCELLED) ||grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_RETURNED)) {
			CanceledOrderDetails details =mongoTemplate.findOne(new Query(Criteria.where("grammerceOrders").is(grammerceOrders.getId())), CanceledOrderDetails.class);
			if(details!=null) {
			grammerceOrdersDto.setRefundAmt(details.getRefundAmount());
			grammerceOrdersDto.setCancellationFee(details.getCancellationFee());
			}
			}
			GrammerceDto grammerceDto = new GrammerceDto();
			BeanUtils.copyProperties(grammerceOrders.getGrammerce(), grammerceDto);
			String extUrl = env.getProperty("ext.app.img.dir");
			String grammerceUrl = extUrl + "/grammerce/" + grammerceOrders.getGrammerce().getId();
			File grammerceImg = new File(grammerceUrl);
			if (grammerceImg.exists()) {
				List<String> fileList = Arrays.asList(grammerceImg.list());
				List<String> imageFilesList = new ArrayList<String>();
				for (String s : fileList) {
					imageFilesList.add(env.getProperty("app.img.dir") + "/grammerce/"
							+ grammerceOrders.getGrammerce().getId() + "/" + s);
				}

				grammerceDto.setGrammerceImgsUrl(imageFilesList);
			}
			grammerceOrdersDto.setGrammerceDto(grammerceDto);
			grammerceOrdersDtos.add(grammerceOrdersDto);
		}
		return grammerceOrdersDtos;
	}

	@Override
	public List<DonationModelDto> getAllDonations() {
		Query donationQuery = new Query();
		donationQuery.with(new Sort(Sort.Direction.DESC, "donationDate"));
		List<DonationOrders> donationOrders = mongoTemplate.find(donationQuery, DonationOrders.class);
		List<DonationModelDto> donationModelDtoList = new ArrayList<DonationModelDto>();
		for (DonationOrders donationOrder : donationOrders) {
			DonationModelDto donationModelDto = new DonationModelDto();
			donationModelDto.setId(donationOrder.getId());
			donationModelDto.setContactNumber(donationOrder.getContactNumber());
			donationModelDto.setAddress(donationOrder.getAddress());
			donationModelDto.setContributionAmount(donationOrder.getContributionAmount());
			donationModelDto.setDonationDate(donationOrder.getDonationDate());
			donationModelDto.setDonationNumber(donationOrder.getDonationNumber());
			donationModelDto.setDonorName(donationOrder.getDonorName());
			donationModelDto.setEmailId(donationOrder.getEmailId());
			donationModelDto.setPurpose(donationOrder.getPurpose());
			donationModelDto.setRevealFlag(donationOrder.isRevealFlag());
			donationModelDto.setRemarks(donationOrder.getRemarks());
			donationModelDto.setUserModel(donationOrder.getUserModel());

			donationModelDto.setTotalSupporters(donationOrders.size());

			donationModelDtoList.add(donationModelDto);
		}
		return donationModelDtoList;
	}

	@Override
	public List<ProjectDonation> getAllProjectDonations() {
		Query donationQuery = new Query();
		donationQuery.with(new Sort(Sort.Direction.DESC, "donationDate"));
		return mongoTemplate.find(donationQuery, ProjectDonation.class);
	}

	@Override
	public PickDropShipmentResDto initShippmentForGrammrce(String orderId, String scheduleDt, String scheduleTm) {
		// TODO Auto-generated method stub
		String pdToken = env.getProperty("pickdroptoken");
		GrammerceOrders grammerceOrders = mongoTemplate.findById(orderId, GrammerceOrders.class);
		PickDropShipmentReqDto pickDropShipmentReqDto = new PickDropShipmentReqDto();
		pickDropShipmentReqDto.setMerchantName("VEDAGRAM");
		pickDropShipmentReqDto.setOrderId(orderId);
		pickDropShipmentReqDto.setPackagePickupAddress(utility.getUser().getAddress());
		pickDropShipmentReqDto.setParcelType("others");
		pickDropShipmentReqDto.setRecieverName(grammerceOrders.getName());
		pickDropShipmentReqDto.setRecieverAddress(grammerceOrders.getDeliveryAddress());
		pickDropShipmentReqDto.setRecieverContact(grammerceOrders.getContactNumber());
		pickDropShipmentReqDto.setSenderContact(utility.getUser().getMobileNumber());
		pickDropShipmentReqDto.setWeight(grammerceOrders.getQuantity());
		pickDropShipmentReqDto.setPdToken(pdToken);
		pickDropShipmentReqDto.setScheduleDt(scheduleDt);
		pickDropShipmentReqDto.setScheduleTm(scheduleTm);
		PickDropShipmentResDto pickDropShipmentResDto = pickDropService.createDelivery(pickDropShipmentReqDto);
		if (pickDropShipmentResDto.getPackageStatus() != null
				&& pickDropShipmentResDto.getPackageStatus().contains("OPEN")) {
			Query query = new Query(Criteria.where("id").is(grammerceOrders.getId()));
			Update update = new Update();
			update.set("shipmentDate", scheduleDt);
			update.set("shipmentTime", scheduleTm);
			update.set("status", GeneralConstants.GRAMMERCE_SCHEDULED);
			update.set("awbNumber", pickDropShipmentResDto.getTrackingId());
			mongoTemplate.findAndModify(query, update, GrammerceOrders.class);

		}
		return pickDropShipmentResDto;
	}

	@Override
	public String changerGrammerceOrdersStatus(GrammerceOrdersDto grammerceOrdersDto) {
		Update update = new Update();
		if (grammerceOrdersDto.getStatus().equals("SHIPPED")) {
			update.set("status", GeneralConstants.GRAMMERCE_SHIPPED);
			update.set("lastUpdatedDate", new Date());
		} else if (grammerceOrdersDto.getStatus().equals("COMPLETED")) {
			update.set("status", GeneralConstants.GRAMMERCE_COMPLETED);
			update.set("lastUpdatedDate", new Date());
		}

		Query query = new Query(Criteria.where("id").is(grammerceOrdersDto.getId()));
		GrammerceOrders grammerceOrders = mongoTemplate.findAndModify(query, update, GrammerceOrders.class);
		return grammerceOrders.getStatus();
	}

	@Override
	public String setGrammerceFlag(String grammerceId, String activeFlag, String comment) {
		Query grammerceQuery = new Query(Criteria.where("_id").is(grammerceId));
		Grammerce grammerce = mongoTemplate.findOne(grammerceQuery, Grammerce.class);
		if (grammerce != null) {
			Update update = new Update();
			update.set("activeFlag", activeFlag);
			if (activeFlag.equals("true")) {
				update.set("activeComment", comment);
			} else {
				update.set("inactiveComment", comment);
			}
			mongoTemplate.findAndModify(grammerceQuery, update, Grammerce.class);

		}
		return activeFlag;

	}

	@Override
	public boolean actInactDeity(@Valid String id, @Valid boolean activeFlag, String comment) {
		Query query = new Query(Criteria.where("_id").is(id));
		Deity deity = mongoTemplate.findOne(query, Deity.class);
		if (deity != null) {
			Update update = new Update();
			update.set("activeFlag", activeFlag);
			if (activeFlag) {
				update.set("activeComment", comment);
			} else {
				update.set("inactiveComment", comment);
			}
			mongoTemplate.findAndModify(query, update, Deity.class);
		}
		return activeFlag;
	}

	public List<UserModel> showTempleAdminsList(AdminsSearchDto templeAdminsSearchDto) {
		List<Criteria> criteriaList = new ArrayList<>();

		if (templeAdminsSearchDto.getTempleName() == null || templeAdminsSearchDto.getTempleName().isEmpty()) {
			if (templeAdminsSearchDto.getCountry() != null && !templeAdminsSearchDto.getCountry().isEmpty()) {
				Criteria criteria1 = Criteria.where("country").regex(Pattern.compile(templeAdminsSearchDto.getCountry(),
						Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria1);
			}

			if (templeAdminsSearchDto.getDistrict() != null && !templeAdminsSearchDto.getDistrict().isEmpty()) {
				Criteria criteria2 = Criteria.where("district").regex(Pattern
						.compile(templeAdminsSearchDto.getDistrict(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria2);

			}
			if (templeAdminsSearchDto.getState() != null && !templeAdminsSearchDto.getState().isEmpty()) {
				Criteria criteria3 = Criteria.where("state").regex(Pattern.compile(templeAdminsSearchDto.getState(),
						Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria3);

			}
			if (templeAdminsSearchDto.getCity() != null && !templeAdminsSearchDto.getCity().isEmpty()) {
				Criteria criteria4 = Criteria.where("villageorTown").regex(Pattern
						.compile(templeAdminsSearchDto.getCity(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria4);

			}

		} else {
			Criteria criteria5 = Criteria.where("name").regex(Pattern.compile(templeAdminsSearchDto.getTempleName(),
					Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria5);

		}
		Criteria queryCriteria = new Criteria().andOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria);
		List<Temples> templeList = mongoTemplate.find(query, Temples.class);
		List<String> tempAdm = new ArrayList<>();
		for (Temples temples : templeList) {
			if (temples.getActiveFlag().equals("true")
					&& temples.getCreatedBy().getRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
				tempAdm.add(temples.getCreatedBy().getId());
			}

		}
		Set<String> uniqueList = tempAdm.stream().collect(Collectors.toSet());

		Query query2 = new Query(Criteria.where("_id").in(uniqueList));
		List<UserModel> tempAdms = mongoTemplate.find(query2, UserModel.class);

		return tempAdms;

	}

	public List<UserModel> showProjectAdminsList(AdminsSearchDto projectAdminsSearchDto) {
		List<Criteria> criteriaList = new ArrayList<>();

		if (projectAdminsSearchDto.getCountry() != null && !projectAdminsSearchDto.getCountry().isEmpty()) {
			Criteria criteria1 = Criteria.where("country").regex(Pattern.compile(projectAdminsSearchDto.getCountry(),
					Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria1);
		}

		if (projectAdminsSearchDto.getCity() != null && !projectAdminsSearchDto.getCity().isEmpty()) {
			Criteria criteria4 = Criteria.where("city").regex(
					Pattern.compile(projectAdminsSearchDto.getCity(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria4);

		}
		if (projectAdminsSearchDto.getState() != null && !projectAdminsSearchDto.getState().isEmpty()) {
			Criteria criteria3 = Criteria.where("state").regex(Pattern.compile(projectAdminsSearchDto.getState(),
					Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria3);

		}

		Criteria queryCriteria = new Criteria().andOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria);
		List<UserModel> pAdmList = mongoTemplate.find(query, UserModel.class);
		List<UserModel> prjectAdmins = new ArrayList<>();
		for (UserModel projAdm : pAdmList) {
			if (projAdm.getUflag().equals("true") && projAdm.getRole().equals(GeneralConstants.ROLE_PROJECTADMIN)) {
				prjectAdmins.add(projAdm);
			}

		}

		return prjectAdmins;

	}

	public List<UserModel> showVendorsList(AdminsSearchDto vendorsSearchDto) {
		List<Criteria> criteriaList = new ArrayList<>();

		if (vendorsSearchDto.getCountry() != null && !vendorsSearchDto.getCountry().isEmpty()) {
			Criteria criteria1 = Criteria.where("country").regex(
					Pattern.compile(vendorsSearchDto.getCountry(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria1);
		}

		if (vendorsSearchDto.getCity() != null && !vendorsSearchDto.getCity().isEmpty()) {
			Criteria criteria4 = Criteria.where("city").regex(
					Pattern.compile(vendorsSearchDto.getCity(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria4);

		}
		if (vendorsSearchDto.getState() != null && !vendorsSearchDto.getState().isEmpty()) {
			Criteria criteria3 = Criteria.where("state").regex(
					Pattern.compile(vendorsSearchDto.getState(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria3);

		}

		Criteria queryCriteria = new Criteria().andOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria);
		List<UserModel> vendorList = mongoTemplate.find(query, UserModel.class);
		List<UserModel> vendors = new ArrayList<>();
		for (UserModel vndr : vendorList) {
			if (vndr.getUflag().equals("true") && vndr.getRole().equals(GeneralConstants.ROLE_VENDOR)) {
				vendors.add(vndr);
			}

		}
		return vendors;

	}

	@Override
	public PickDropShipmentResDto returnShipmentForGrammerce(CancelOrderDto cancelOrderDto) {
		
		String pdToken = env.getProperty("pickdroptoken");
		GrammerceOrders grammerceOrders = mongoTemplate.findById(cancelOrderDto.getGrammerceOrdId(), GrammerceOrders.class);
		List<UserModel> userModels =mongoTemplate.find(new Query(Criteria.where("role").is(GeneralConstants.ROLE_ADMIN)),UserModel.class);
		UserModel userModel =userModels.get(0);
		PickDropShipmentReqDto pickDropShipmentReqDto = new PickDropShipmentReqDto();
		pickDropShipmentReqDto.setMerchantName("VEDAGRAM");
		pickDropShipmentReqDto.setOrderId(cancelOrderDto.getGrammerceOrdId());
		pickDropShipmentReqDto.setPackagePickupAddress(grammerceOrders.getDeliveryAddress());
		pickDropShipmentReqDto.setParcelType("others");
		pickDropShipmentReqDto.setRecieverName(userModel.getFirstName()+userModel.getLastName()!=null?userModel.getLastName():"");
		pickDropShipmentReqDto.setRecieverAddress(userModel.getAddress());
		pickDropShipmentReqDto.setRecieverContact(userModel.getMobileNumber());
		pickDropShipmentReqDto.setSenderContact(grammerceOrders.getContactNumber());
		pickDropShipmentReqDto.setWeight(grammerceOrders.getQuantity());
		pickDropShipmentReqDto.setPdToken(pdToken);
		pickDropShipmentReqDto.setScheduleDt(cancelOrderDto.getScheduleDate());
		pickDropShipmentReqDto.setScheduleTm(cancelOrderDto.getScheduleTime());
		PickDropShipmentResDto pickDropShipmentResDto = pickDropService.createDelivery(pickDropShipmentReqDto);
		if (pickDropShipmentResDto.getPackageStatus() != null
				&& pickDropShipmentResDto.getPackageStatus().contains("OPEN")) {
			Query query = new Query(Criteria.where("id").is(grammerceOrders.getId()));
			Update update = new Update();
			update.set("shipmentDate", cancelOrderDto.getScheduleDate());
			update.set("shipmentTime", cancelOrderDto.getScheduleTime());
			update.set("status", GeneralConstants.GRAMMERCE_RETURNINIT);
			update.set("awbNumber", pickDropShipmentResDto.getTrackingId());
			update.set("returnReason",cancelOrderDto.getReturnReason());
			mongoTemplate.findAndModify(query, update, GrammerceOrders.class);

		}
		return pickDropShipmentResDto;
	}

	@Override
	public PickDropShipmentResDto replaceGrammerceShipmentFromUser(CancelOrderDto cancelOrderDto) {
		
		List<UserModel> userModels =mongoTemplate.find(new Query(Criteria.where("role").is(GeneralConstants.ROLE_ADMIN)),UserModel.class);
		UserModel userModel =userModels.get(0); 

		GrammerceOrders grammerceOrders = mongoTemplate.findById(cancelOrderDto.getGrammerceOrdId(), GrammerceOrders.class);
 
		 String status=null;
		 String pickupAddress=null;
		 String receiverName=null;
		 String recieverAddress=null;
		 String recieverContact=null;
		 String senderContact=null;
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			status=GeneralConstants.GRAMMERCE_REPLACEADMININIT;
			pickupAddress=utility.getUser().getAddress();
			receiverName=grammerceOrders.getName();
			recieverAddress=grammerceOrders.getDeliveryAddress();
			recieverContact=grammerceOrders.getContactNumber();
			senderContact=utility.getMobileNumber();
		}
		else {
			status=GeneralConstants.GRAMMERCE_REPLACEINIT;
			pickupAddress=grammerceOrders.getDeliveryAddress();
			receiverName=userModel.getFirstName()+userModel.getLastName()!=null?userModel.getLastName():"";
			recieverAddress=userModel.getAddress();
			recieverContact=userModel.getMobileNumber();
			senderContact=grammerceOrders.getContactNumber();
		}
		
		String pdToken = env.getProperty("pickdroptoken");
		
		PickDropShipmentReqDto pickDropShipmentReqDto = new PickDropShipmentReqDto();
		pickDropShipmentReqDto.setMerchantName("VEDAGRAM");
		pickDropShipmentReqDto.setOrderId(cancelOrderDto.getGrammerceOrdId());
		pickDropShipmentReqDto.setPackagePickupAddress(pickupAddress);
		pickDropShipmentReqDto.setParcelType("others");
		pickDropShipmentReqDto.setRecieverName(receiverName);
		pickDropShipmentReqDto.setRecieverAddress(recieverAddress);
		pickDropShipmentReqDto.setRecieverContact(recieverContact);
		pickDropShipmentReqDto.setSenderContact(senderContact);
		pickDropShipmentReqDto.setWeight(grammerceOrders.getQuantity());
		pickDropShipmentReqDto.setPdToken(pdToken);
		pickDropShipmentReqDto.setScheduleDt(cancelOrderDto.getScheduleDate());
		pickDropShipmentReqDto.setScheduleTm(cancelOrderDto.getScheduleTime());
		PickDropShipmentResDto pickDropShipmentResDto = pickDropService.createDelivery(pickDropShipmentReqDto);
		if (pickDropShipmentResDto.getPackageStatus() != null
				&& pickDropShipmentResDto.getPackageStatus().contains("OPEN")) {
			Query query = new Query(Criteria.where("id").is(grammerceOrders.getId()));
			Update update = new Update();
			update.set("shipmentDate", cancelOrderDto.getScheduleDate());
			update.set("shipmentTime", cancelOrderDto.getScheduleTime());
			update.set("status", status);
			update.set("awbNumber", pickDropShipmentResDto.getTrackingId());
			if(utility.getUserRole().equals(GeneralConstants.ROLE_USER)) {
			update.set("replaceReason",cancelOrderDto.getReplaceReason());
			}
			mongoTemplate.findAndModify(query, update, GrammerceOrders.class);

		}
		return pickDropShipmentResDto;	
		
	}

}
