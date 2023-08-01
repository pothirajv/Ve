/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.admin.adm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.deity.Deity;
import com.vedagram.deity.DeityDto;
import com.vedagram.deity.DeityService;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropService;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.projectadm.ProjectModelDto;
import com.vedagram.projectadm.ProjectService;
import com.vedagram.register.a.RegisterResponse;
import com.vedagram.support.util.Utility;
import com.vedagram.tempadmin.ITempleService;
import com.vedagram.tempadmin.PoojaOfferingOrdersDto;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.Temples;
import com.vedagram.user.DonationModelDto;
import com.vedagram.user.GrammerceOrders;
import com.vedagram.user.GrammerceOrdersDto;
import com.vedagram.user.GrammerceOrdersRepository;
import com.vedagram.user.LocationDto;
import com.vedagram.user.PoojaMaterialOrdersStatus;
import com.vedagram.user.PoojaMaterialOrdersStatusRepository;
import com.vedagram.user.PoojaOfferingOrdersStatus;
import com.vedagram.user.PoojaOfferingOrdersStatusRepository;
import com.vedagram.user.ProjectDonation;
import com.vedagram.user.RequestStatusDto;
import com.vedagram.user.RequestStatusMainDto;
import com.vedagram.vendor.PoojaMaterialDto;
import com.vedagram.vendor.PoojaMaterialOrdersDto;
import com.vedagram.vendor.VendorService;

/**
 *
 * @author Winston
 */
@Controller
@RequestMapping(path = "/adm/")
public class AdminController {
	@Autowired
	private IAdminService adminService;
	@Autowired
	private DeityService deityService;
	@Autowired
	private ITempleService templeService;
	@Autowired
	private VendorService vendorService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private Utility utility;
	@Autowired
	GrammerceOrdersRepository grammerceOrdersRepository;
	@Autowired
	PickDropService pickDropService;
	@Autowired
	PoojaOfferingOrdersStatusRepository offeringOrdersStatusRepository;
	@Autowired
	PoojaMaterialOrdersStatusRepository materialOrdersStatusRepository;
	@Autowired
	MongoTemplate mongoTemplate;
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminController.class);

	@RequestMapping(path = "showAllUsers", method = RequestMethod.POST)
	@ResponseBody
	public List<UserModel> showAllUsers() {
		List<UserModel> userModelList = adminService.listOfUsers();
		return userModelList;
	}

	@RequestMapping(path = "actInact", method = RequestMethod.POST)
	@ResponseBody
	public String actInactiveUser(@RequestParam("id") @Valid String id,
			@RequestParam("activeFlag") @Valid String activeFlag, @RequestParam("comment") String comment) {
		return adminService.actInactUser(id, activeFlag, comment);

	}

	@RequestMapping(path = "addDeity", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> addDeity(@ModelAttribute("deity") Deity deity,
			@RequestParam(value = "deityImage") @Valid MultipartFile multipartFile) throws Exception {
		String msg = deityService.saveDeity(deity, multipartFile);
		RegisterResponse registerResponse = new RegisterResponse();
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);

	}

	@RequestMapping(path = "showDeity", method = RequestMethod.POST)
	@ResponseBody
	public DeityDto showDeity(@RequestParam("deityId") String dietyId) throws IOException {
		return deityService.showDeity(dietyId);
	}

	@RequestMapping(path = "showAllDeity", method = RequestMethod.GET)
	@ResponseBody
	public List<DeityDto> showAllDeity() throws IOException {
		return deityService.showAllDeity();
	}

	// @RequestMapping(path = "actInactDeity", method = RequestMethod.POST)
	// @ResponseBody
	// public String actInactiveDeity(@RequestParam("deityId") @Valid String
	// deityId,
	// @RequestParam("activeFlag") @Valid String activeFlag) {
	// return deityService.actInactDeity(deityId, activeFlag);
	//
	// }

	@RequestMapping(path = "updateDeity", method = RequestMethod.POST)
	public ResponseEntity<RegisterResponse> update(@ModelAttribute("deity") Deity deity,
			@RequestParam(value = "deityImage", required = false) MultipartFile multipartFile) throws IOException {
		String msg = deityService.updateDeity(deity, multipartFile);
		RegisterResponse registerResponse = new RegisterResponse();
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);
	}

	@RequestMapping(path = "actInactDeity", method = RequestMethod.POST)
	@ResponseBody
	public boolean actInactiveDeity(@RequestParam("id") @Valid String id,
			@RequestParam("activeFlag") @Valid boolean activeFlag, @RequestParam("comment") String comment) {
		return adminService.actInactDeity(id, activeFlag, comment);

	}

	@RequestMapping(path = "showAllPoojaOffering", method = RequestMethod.GET)
	@ResponseBody
	public List<PoojaOfferings> showAllPoojaOffering() {
		return adminService.showAllPoojaOffering();
	}

	@RequestMapping(path = "viewPoojaInfo", method = RequestMethod.GET)
	@ResponseBody
	public PoojaOfferings viewPoojaInfo(@RequestParam("poojaId") String poojaId) {
		return adminService.viewPoojaInfo(poojaId);

	}

	@RequestMapping(path = "showAllTemples", method = RequestMethod.GET)
	@ResponseBody
	public List<Temples> showAllTemples() {
		List<Temples> templeList = templeService.listOfTemples();
		return templeList;
	}

	@RequestMapping(path = "setTempleFlag", method = RequestMethod.POST)
	@ResponseBody
	public String setFlag(@RequestParam("templeId") String templeId, @RequestParam("activeFlag") String activeFlag,
			@RequestParam("comment") String comment) {
		return adminService.setTempleFlag(templeId, activeFlag, comment);

	}

	@RequestMapping(path = "showAllPoojaMaterial", method = RequestMethod.GET)
	@ResponseBody
	public List<PoojaMaterialDto> showAllPoojaMaterial() throws IOException {
		return vendorService.showAllPoojaMaterialForAdmin();

	}

	@RequestMapping(path = "viewPoojaMaterial", method = RequestMethod.GET)
	@ResponseBody
	public PoojaMaterialDto viewPoojaMaterial(@RequestParam("materialId") String materialId) throws IOException {
		return vendorService.viewPoojaMaterial(materialId);
	}

	@RequestMapping(path = "addGrammerce", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> addGrammerce(@ModelAttribute("grammerce") @Valid Grammerce grammerce,
			BindingResult result, @RequestParam(value = "grammerceImage") @Valid List<MultipartFile> imgList)
			throws IOException {
		RegisterResponse registerResponse = new RegisterResponse();

		if (result.hasFieldErrors("brandName")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("productName")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("price")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("stock")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("deliveryLeadTime")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("significance")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("country")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		}

		String msg = adminService.addGrammerce(grammerce, imgList);
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);

	}

	@RequestMapping(path = "viewGrammerce", method = RequestMethod.GET)
	@ResponseBody
	public GrammerceDto viewGrammerce(@RequestParam("grammerceId") String grammerceId) throws IOException {
		return adminService.viewGrammerce(grammerceId);
	}

	@RequestMapping(path = "showAllGrammerce", method = RequestMethod.GET)
	@ResponseBody
	public List<GrammerceDto> showAllGrammerce() throws IOException {
		return adminService.showAllGrammerceForAdmin();
	}

	@RequestMapping(path = "updateGrammerce", method = RequestMethod.POST)
	public ResponseEntity<RegisterResponse> updateGrammerce(@ModelAttribute("grammerce") @Valid Grammerce grammerce,
			BindingResult result, @RequestParam(value = "grammerceImage") List<MultipartFile> imgList)
			throws IOException {

		RegisterResponse registerResponse = new RegisterResponse();
		if (result.hasFieldErrors("brandName")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("price")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("stock")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("deliveryLeadTime")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("significance")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("country")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		}

		String msg = adminService.updateGrammerce(grammerce, imgList);
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);
	}

	@RequestMapping(path = "showAllProjects", method = RequestMethod.GET)
	@ResponseBody
	public List<ProjectModelDto> showAllProjects() throws IOException {
		return projectService.showAllProjectsForAdmin();
	}

	@RequestMapping(path = "setProjectStatus", method = RequestMethod.GET)
	@ResponseBody
	public String setProjectStatus(@RequestParam("projectId") String projectId,
			@RequestParam("projectStatus") String projectStatus, @RequestParam("comment") String comment) {
		return projectService.setProjectStatus(projectId, projectStatus, comment);

	}

	@RequestMapping(path = "showAllOrders", method = RequestMethod.POST)
	@ResponseBody
	public List<PoojaOfferingOrdersDto> getAllOrdersForPoojaOfferings() throws Exception {
		return templeService.getAllOrdersForPoojaOfferings(utility.getUserId());

	}

	@RequestMapping(path = "showAllMaterialsOrders", method = RequestMethod.POST)
	@ResponseBody
	public List<PoojaMaterialOrdersDto> getAllMaterialsOrders() throws Exception {
		return vendorService.getAllOrdersForPoojaMaterials(utility.getUserId());

	}

	@RequestMapping(path = "showAllGrammerceOrders", method = RequestMethod.POST)
	@ResponseBody
	public List<GrammerceOrdersDto> getAllGrammerceOrders() {
		return adminService.getAllOrdersForGrammerce();

	}

	@RequestMapping(path = "showAllDonations", method = RequestMethod.POST)
	@ResponseBody
	public List<DonationModelDto> getAllDonations() {
		return adminService.getAllDonations();

	}

	@RequestMapping(path = "showAllProjectDonations", method = RequestMethod.POST)
	@ResponseBody
	public List<ProjectDonation> getAllProjectDonations() {
		return adminService.getAllProjectDonations();

	}

	@RequestMapping(path = "initShippmentForGrammrce", method = RequestMethod.POST)
	@ResponseBody
	public PickDropShipmentResDto initShippmentForGrammrce(@RequestParam("orderId") String orderId,
			@RequestParam("scheduleDt") String scheduleDt, @RequestParam("scheduleTm") String scheduleTm) {
		return adminService.initShippmentForGrammrce(orderId, scheduleDt, scheduleTm);

	}

	@RequestMapping(path = "changeGrammerceOrdersStatus", method = RequestMethod.POST)
	@ResponseBody
	public String changeGrammerceOrdersStatus(@RequestBody GrammerceOrdersDto grammerceOrdersDto) {
		return adminService.changerGrammerceOrdersStatus(grammerceOrdersDto);

	}

	@RequestMapping(path = "setGrammerceFlag", method = RequestMethod.POST)
	@ResponseBody
	public String setGrammerceFlag(@RequestParam("grammerceId") String grammerceId,
			@RequestParam("activeFlag") String activeFlag, @RequestParam("comment") String comment) {
		return adminService.setGrammerceFlag(grammerceId, activeFlag, comment);

	}

	@RequestMapping(path = "showTempleAdm", method = RequestMethod.POST)
	@ResponseBody
	public List<UserModel> showTempleAdminsList(@RequestBody AdminsSearchDto templeAdminsSearchDto) {
		return adminService.showTempleAdminsList(templeAdminsSearchDto);

	}

	@RequestMapping(path = "showProjectAdm", method = RequestMethod.POST)
	@ResponseBody
	public List<UserModel> showProjectAdminsList(@RequestBody AdminsSearchDto projectAdminsSearchDto) {
		return adminService.showProjectAdminsList(projectAdminsSearchDto);
	}

	@RequestMapping(path = "showVendors", method = RequestMethod.POST)
	@ResponseBody
	public List<UserModel> showVendorsList(@RequestBody AdminsSearchDto vendorsSearchDto) {
		return adminService.showVendorsList(vendorsSearchDto);
	}
	@Scheduled(cron ="0 */5 * ? * *")
	@ResponseBody
	public String  updateOrdersStatus() {
		RequestStatusMainDto requestStatusMainDto = new RequestStatusMainDto();
		List<String> awbNumbers=new ArrayList<>();
		List<String> awbNumbers1=new ArrayList<>(); 
		List<String> awbNumbers2=new ArrayList<>();
		
		Query query = new Query(Criteria.where("status").nin("OPEN","REPLACED","CANCELLED","COMPLETED","RETURNED","REPLACE_RETURNED","POOJA_DONE"));
		
		List<GrammerceOrders> grammerceOrders = mongoTemplate.find(query,GrammerceOrders.class);
		
		List<PoojaOfferingOrdersStatus> poojaOfferingOrdersStatus = mongoTemplate.find(query,PoojaOfferingOrdersStatus.class);
		
		List<PoojaMaterialOrdersStatus> poojaMaterialOrdersStatus = mongoTemplate.find(query,PoojaMaterialOrdersStatus.class);
		
		if(grammerceOrders.size()>0) {
		 awbNumbers = grammerceOrders.stream().map(GrammerceOrders::getAwbNumber)
				.collect(Collectors.toList());
		}
		if(poojaOfferingOrdersStatus.size()>0) {
		 awbNumbers1 = poojaOfferingOrdersStatus.stream().map(PoojaOfferingOrdersStatus::getAwbNumber)
				.collect(Collectors.toList());
		}
		if(poojaMaterialOrdersStatus.size()>0) {
		 awbNumbers2 = poojaMaterialOrdersStatus.stream().map(PoojaMaterialOrdersStatus::getAwbNumber)
				.collect(Collectors.toList());
		}
		awbNumbers.addAll(awbNumbers1);
		awbNumbers.addAll(awbNumbers2);

		List<RequestStatusDto> requestStatusDtos = new ArrayList<>();
	    
		for (String awbNumber : awbNumbers) {
			RequestStatusDto requestStatusDto = new RequestStatusDto();
			requestStatusDto.setAwbNumber(awbNumber);
			requestStatusDtos.add(requestStatusDto);

		}
	    
		requestStatusMainDto.setRequestStatusDtos(requestStatusDtos);
		if(requestStatusDtos.size()==0) {
			return "No orders available";

		}
		 return pickDropService.getDeliveryStatus(requestStatusMainDto);


	}
	@RequestMapping(path = "changeOrdersStatus", method = RequestMethod.POST)
	@ResponseBody
	public String  updateOrdersStatus1() {
		RequestStatusMainDto requestStatusMainDto = new RequestStatusMainDto();
		List<String> awbNumbers=new ArrayList<>();
		List<String> awbNumbers1=new ArrayList<>(); 
		List<String> awbNumbers2=new ArrayList<>();
		
		Query query = new Query(Criteria.where("status").nin("OPEN","REPLACED","CANCELLED","COMPLETED","RETURNED","REPLACE_RETURNED","POOJA_DONE"));
		
		List<GrammerceOrders> grammerceOrders = mongoTemplate.find(query,GrammerceOrders.class);
		
		List<PoojaOfferingOrdersStatus> poojaOfferingOrdersStatus = mongoTemplate.find(query,PoojaOfferingOrdersStatus.class);
		
		List<PoojaMaterialOrdersStatus> poojaMaterialOrdersStatus = mongoTemplate.find(query,PoojaMaterialOrdersStatus.class);
		
		if(grammerceOrders.size()>0) {
		 awbNumbers = grammerceOrders.stream().map(GrammerceOrders::getAwbNumber)
				.collect(Collectors.toList());
		}
		if(poojaOfferingOrdersStatus.size()>0) {
		 awbNumbers1 = poojaOfferingOrdersStatus.stream().map(PoojaOfferingOrdersStatus::getAwbNumber)
				.collect(Collectors.toList());
		}
		if(poojaMaterialOrdersStatus.size()>0) {
		 awbNumbers2 = poojaMaterialOrdersStatus.stream().map(PoojaMaterialOrdersStatus::getAwbNumber)
				.collect(Collectors.toList());
		}
		awbNumbers.addAll(awbNumbers1);
		awbNumbers.addAll(awbNumbers2);

		List<RequestStatusDto> requestStatusDtos = new ArrayList<>();
	    
		for (String awbNumber : awbNumbers) {
			RequestStatusDto requestStatusDto = new RequestStatusDto();
			requestStatusDto.setAwbNumber(awbNumber);
			requestStatusDtos.add(requestStatusDto);

		}
	    
		requestStatusMainDto.setRequestStatusDtos(requestStatusDtos);
		if(requestStatusDtos.size()==0) {
			return "No orders available";

		}
		 return pickDropService.getDeliveryStatus(requestStatusMainDto);


	}

}