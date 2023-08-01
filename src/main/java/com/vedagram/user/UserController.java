package com.vedagram.user;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vedagram.admin.adm.GrammerceDto;
import com.vedagram.admin.adm.IAdminService;
import com.vedagram.deity.DeityDto;
import com.vedagram.deity.DeityService;
import com.vedagram.projectadm.ProjectModelDto;
import com.vedagram.projectadm.ProjectService;
import com.vedagram.support.util.Utility;
import com.vedagram.tempadmin.CreateTempleDto;
import com.vedagram.tempadmin.ITempleService;
import com.vedagram.tempadmin.PoojaOfferingOrdersDto;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.Temples;
import com.vedagram.vendor.PoojaMaterial;
import com.vedagram.vendor.PoojaMaterialOrdersDto;
import com.vedagram.vendor.VendorService;

@Controller
@RequestMapping(path = "/u/")
public class UserController {
	@Autowired
	private DeityService deityService;
	@Autowired
	private UserService userService;
	@Autowired
	private VendorService vendorService;
	@Autowired
	ITempleService templeService;
	@Autowired
	IAdminService adminService;
	@Autowired
	UserProductDetailsRepository userProductDetailsRepository;
	@Autowired
	Utility utility;
	@Autowired
	private ProjectService projectService;
	@Autowired
	MongoTemplate mongoTemplate;

	@RequestMapping(path = "showDeityInfo", method = RequestMethod.POST)
	@ResponseBody
	public DeityDto showDeityInfo(@RequestParam("deityId") String dietyId) throws IOException {
		return deityService.showDeity(dietyId);
	}

	@RequestMapping(path = "showAllDeity", method = RequestMethod.GET)
	@ResponseBody
	public List<DeityDto> showAllDeity() throws IOException {
		return userService.showAllDeity();
	}

	@RequestMapping(path = "showPoojaOffering", method = RequestMethod.POST)
	@ResponseBody
	public List<PoojaOfferingDeityDto> showPoojaOffering(@RequestParam("deityId") String deityId,
			@RequestParam("tempId") String tempId) {

		return userService.showPoojaOffering(deityId, tempId);

	}

	@RequestMapping(path = "searchTemple", method = RequestMethod.POST)
	@ResponseBody
	public List<Temples> showTemple(@RequestBody TempleSearchDto templeSearchDto) {
		List<Temples> listOfTemples = userService.showTempleList(templeSearchDto);
		return listOfTemples;

	}

	@RequestMapping(path = "viewTemple", method = RequestMethod.POST)
	@ResponseBody
	public CreateTempleDto viewTemple(@RequestParam String templeId) throws IOException {
		CreateTempleDto createTemplDtoLst = templeService.getTempleDetails(templeId);
		return createTemplDtoLst;

	}

	@RequestMapping(path = "showAllPoojaMaterial", method = RequestMethod.GET)
	@ResponseBody
	public PoojaMaterialDeityDto showAllPoojaMaterial(@RequestParam("templeId") String templeId) throws IOException {
		return vendorService.showAllPoojaMaterial(templeId);

	}

	@RequestMapping(path = "showAllGrammerce", method = RequestMethod.GET)
	@ResponseBody
	public List<GrammerceDto> showAllGrammerce(@RequestParam("pincode") String pincode) throws IOException {
		return adminService.showAllGrammerce(pincode);
	}

	@RequestMapping(value = "/addToCartInit", method = RequestMethod.POST)
	@ResponseBody
	public String addToCartInit(@RequestBody VedaCartDto vedaCartDto) {
		String userId = utility.getUserId();
		userService.addToCart(vedaCartDto, userId);
		return "Success";
	}

	@RequestMapping("/loadMyCart")
	@ResponseBody
	public List<UserCartDetailsDto> getMyCartForAjax(HttpServletRequest request)
			throws IllegalAccessException, InvocationTargetException, ParseException {
		List<UserCartDetailsDto> usrCartDetDtoLst = new ArrayList<UserCartDetailsDto>();
		String userId = utility.getUserId();
		List<UserCartDetails> md = userService.getByUserId(userId);
		for (UserCartDetails memdt : md) {
			// BeanUtils.copyProperties(memdt, membdetDto);
			UserCartDetailsDto usrCartDetDto = new UserCartDetailsDto();
			if (memdt.getListOfDates() != null) {
				List<String> listOfdates = Arrays.asList(memdt.getListOfDates().split("\\|\\|"));
				for (String dates : listOfdates) {
					String date = dates.split("[T]")[0];
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date now = new Date();
					String currentDate = format.format(now).toString();
					int date1 = currentDate.compareTo(date);
					if (date1 >= 0) {
						usrCartDetDto.setElapseFlag(true);
					}

				}

			} else if (memdt.getFromDate() != null) {
				SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
				Date now = new Date();
				String currentDate = format.format(now).toString();
				String date = format.format(memdt.getFromDate()).toString();

				int date1 = currentDate.compareTo(date);
				if (date1 >= 0) {
					usrCartDetDto.setElapseFlag(true);
				}

			}

			usrCartDetDto.setId(memdt.getId());
			usrCartDetDto.setDakshinaAmountForPriest(memdt.getDakshinaAmountForPriest());
			usrCartDetDto.setDakshinaAmountToTemple(memdt.getDakshinaAmountToTemple());
			usrCartDetDto.setDelFlag(memdt.getDelFlag());
			usrCartDetDto.setDeliveryAddress(memdt.getDeliveryAddress());
			usrCartDetDto.setFirstName(memdt.getFirstName());
			usrCartDetDto.setFromDate(memdt.getFromDate());
			usrCartDetDto.setLastModifiedDate(memdt.getLastModifiedDate());
			usrCartDetDto.setMailId(memdt.getMailId());
			usrCartDetDto.setMobileNumber(memdt.getMobileNumber());
			usrCartDetDto.setNoOfMonths(memdt.getNoOfMonths());
			usrCartDetDto.setPayDakshinaToPriestFlag(memdt.isPayDakshinaToPriestFlag());
			usrCartDetDto.setPayDakshinaToTempleFlag(memdt.isPayDakshinaToTempleFlag());
			usrCartDetDto.setPoojaOfferings(memdt.getPoojaOfferings());
			usrCartDetDto.setPrasadhamDelFlag(memdt.isPrasadhamDelFlag());
			usrCartDetDto.setStar(memdt.getStar());
			usrCartDetDto.setToDate(memdt.getToDate());
			usrCartDetDto.setUserModel(memdt.getUserModel());
			usrCartDetDto.setListOfDates(memdt.getListOfDates());

			UserProductDetails usrProdDets = userProductDetailsRepository.findByuserCartDetailsId(memdt.getId());
			Double totAmt = (double) (usrProdDets.getBookedQuantity() * memdt.getPoojaOfferings().getPrice());
			Double delAmount = 0D;
			if ((memdt.isPrasadhamDelFlag())) {
				delAmount = userService.getDeliveryCharge(memdt) * usrProdDets.getBookedQuantity();
				usrCartDetDto.setPdDelCharge(delAmount);
				usrCartDetDto.setDelChargePerDay(delAmount / usrProdDets.getBookedQuantity());
				memdt.setPdDelCharge(delAmount);
				userService.savePDDelvCharge(memdt);
			}

			usrCartDetDto.setTotalAmount(totAmt + delAmount);

			usrCartDetDtoLst.add(usrCartDetDto);

		}
		return usrCartDetDtoLst;
	}

	@RequestMapping("/removeFromCart")
	@ResponseBody
	public AjaxResponse removeFromCart(HttpServletRequest request, @RequestParam("vedaCartId") String vedaCartId) {
		String userId = utility.getUserId();
		AjaxResponse ajaxRespose = new AjaxResponse();

		List<String> userCartDetailsIdsLst = new ArrayList<String>();
//		for (String vedaCartId : vedaCartIds) {
//			userCartDetailsIdsLst.add(vedaCartId);
//		}

		boolean isSuccess = userService.removeFromCart(vedaCartId, userId);
		if (isSuccess == true) {
			ajaxRespose.setResposeSuccess(true);
		} else {
			ajaxRespose.setResposeSuccess(false);
		}
		return ajaxRespose;
	}

	@RequestMapping("/mycart")
	public List<UserCartDetailsDto> getMyCart(HttpServletRequest request)
			throws IllegalAccessException, InvocationTargetException, ParseException {
		List<UserCartDetailsDto> userCartDetailsDtoLst = getMyCartForAjax(request);
		return userCartDetailsDtoLst;
	}

	@RequestMapping("/myOrders")
	@ResponseBody
	public List<PoojaOfferingOrdersDto> getMyOrders(HttpServletRequest request) throws Exception {
		return templeService.getAllOrdersForPoojaOfferings(utility.getUserId());
	}

	@RequestMapping("/myOrdersMaterials")
	@ResponseBody
	public List<PoojaMaterialOrdersDto> getMyOrdersMaterials(HttpServletRequest request) throws Exception {
		List<PoojaMaterialOrdersDto> poojaMaterialsOrdersList = vendorService
				.getAllOrdersForPoojaMaterials(utility.getUserId());
		return poojaMaterialsOrdersList;
	}

	@RequestMapping("/myOrdersGrammerce")
	@ResponseBody
	public List<GrammerceOrdersDto> getMyGRammerceOrders(HttpServletRequest request)
			throws IllegalAccessException, InvocationTargetException {
		List<GrammerceOrdersDto> grammerceOrdersList = adminService.getAllOrdersForGrammerce();
		return grammerceOrdersList;
	}

	@RequestMapping("/myDonations")
	@ResponseBody
	public List<DonationOrders> getMyDonations(HttpServletRequest request)
			throws IllegalAccessException, InvocationTargetException {
		List<DonationOrders> donationOrdersList = userService.getMyDonations(utility.getUserId());
		return donationOrdersList;
	}

	@RequestMapping("/myProjectDonations")
	@ResponseBody
	public List<ProjectDonation> myProjectDonations(HttpServletRequest request)
			throws IllegalAccessException, InvocationTargetException {
		List<ProjectDonation> projectDonationOrdersList = userService.myProjectDonations(utility.getUserId());
		return projectDonationOrdersList;
	}

	@RequestMapping(path = "showAllProjects", method = RequestMethod.GET)
	@ResponseBody
	public List<ProjectModelDto> showAllProjects() throws IOException {
		return projectService.showAllProjectsForUser();
	}

	@RequestMapping(path = "calcDelcChargeForPoojaMaterials", method = RequestMethod.POST)
	@ResponseBody
	public MaterialPurchaseDto calcDelcChargeFroPoojaMaterials(@RequestBody MaterialPurchaseDto materialPurchaseDto)
			throws IOException {
		return userService.calcDelcChargeFroPoojaMaterials(materialPurchaseDto);
	}

	@RequestMapping(path = "calcDelcChargeForGrmmaerce", method = RequestMethod.POST)
	@ResponseBody
	public GrammercePurchaseDto calcDelcChargeForGrmmaerce(@RequestBody GrammercePurchaseDto grammercePurchaseDtoDto)
			throws IOException {
		return userService.calcDelcChargeForGrmmaerce(grammercePurchaseDtoDto);
	}

	@RequestMapping(path = "calcDelcChargeForOffering", method = RequestMethod.POST)
	@ResponseBody
	public UserCartDetailsDto calcDelcChargeForOffering(@RequestBody VedaCartDto vedaCartDto) throws IOException {
		UserCartDetailsDto usrCartDetDto = new UserCartDetailsDto();
		usrCartDetDto.setId(vedaCartDto.getId());
		usrCartDetDto.setDakshinaAmountForPriest(vedaCartDto.getDakshinaAmountForPriest());
		usrCartDetDto.setDakshinaAmountToTemple(vedaCartDto.getDakshinaAmountToTemple());
		usrCartDetDto.setDeliveryAddress(vedaCartDto.getDeliveryAddress());
		usrCartDetDto.setFirstName(vedaCartDto.getFirstName());
		usrCartDetDto.setFromDate(vedaCartDto.getFromDate());
		usrCartDetDto.setMailId(vedaCartDto.getMailId());
		usrCartDetDto.setMobileNumber(vedaCartDto.getMobileNumber());
		usrCartDetDto.setNoOfMonths(vedaCartDto.getNoOfMonths());
		usrCartDetDto.setPayDakshinaToPriestFlag(vedaCartDto.isPayDakshinaToPriestFlag());
		usrCartDetDto.setPayDakshinaToTempleFlag(vedaCartDto.isPayDakshinaToTempleFlag());
		Query query = new Query(Criteria.where("id").is(vedaCartDto.getPoojaOfferings().getId()));
		PoojaOfferings offerings = mongoTemplate.findOne(query, PoojaOfferings.class);
		usrCartDetDto.setPoojaOfferings(offerings);
		usrCartDetDto.setPrasadhamDelFlag(vedaCartDto.isPrasadhamDelFlag());
		usrCartDetDto.setStar(vedaCartDto.getStar());
		usrCartDetDto.setToDate(vedaCartDto.getToDate());
		int bookdQuantity = 0;
		if (vedaCartDto.getFromDate() != null && vedaCartDto.getToDate() != null) {
			long diff = vedaCartDto.getToDate().getTime() - vedaCartDto.getFromDate().getTime();
			long diffDays = diff / (24 * 60 * 60 * 1000);

			bookdQuantity += diffDays + 1;

		} else if (vedaCartDto.getNoOfMonths() != null) {
			LocalDate today = LocalDate.now();
			LocalDate futureDate = today.plusMonths(vedaCartDto.getNoOfMonths());
			bookdQuantity += today.until(futureDate, ChronoUnit.DAYS);

		} else if (vedaCartDto.getListOfDates() != null && vedaCartDto.getListOfDates().size() > 0) {
			bookdQuantity += vedaCartDto.getListOfDates().size();
		}
		double totalAmount = (double) (offerings.getPrice() * bookdQuantity);
		usrCartDetDto.setTotalAmount(totalAmount);
		Double delAmount = 0d;
		if ((vedaCartDto.isPrasadhamDelFlag())) {
			delAmount = userService.getDeliveryCharge(usrCartDetDto);

			usrCartDetDto.setDelChargePerDay(delAmount);
			Double totalCharge = delAmount * bookdQuantity;

			usrCartDetDto.setPdDelCharge(totalCharge);
		}
		usrCartDetDto.setTotalPaidAmount(totalAmount + delAmount);

		return usrCartDetDto;
	}

	@RequestMapping(path = "addOffer", method = RequestMethod.POST)
	@ResponseBody
	public String addOffer(@RequestBody Offer offer) {
		return userService.addOffer(offer);

	}

	@RequestMapping(path = "showAllOffer", method = RequestMethod.POST)
	@ResponseBody
	public List<Offer> showAllOffer() {
		return userService.showAllOffer();

	}

	@RequestMapping(path = "viewOffer", method = RequestMethod.POST)
	@ResponseBody
	public Offer viewOffer(@RequestParam("offerId") String offerId) {
		return userService.viewOffer(offerId);
	}

	@RequestMapping(path = "updateOffer", method = RequestMethod.POST)
	@ResponseBody
	public String updateOffer(@RequestBody Offer offer) {
		return userService.updateOffer(offer);
	}

	@RequestMapping(path = "allStates", method = RequestMethod.GET)
	@ResponseBody
	public List<String> ShowAllStates() {
		return userService.ShowAllStates();
	}
	
	@RequestMapping(path = "allDistricts", method = RequestMethod.POST)
	@ResponseBody
	public List<String> showAllDistrict(@RequestBody LocationDto locationDto){
		return userService.showAllDistrict(locationDto);
	}
	
	@RequestMapping(path = "allPincodes", method = RequestMethod.POST)
	@ResponseBody
	public List<String> showAllPinCode(@RequestBody LocationDto locationDto){
		return userService.showAllPinCode(locationDto);
	}
	
	@RequestMapping(path = "pincodeValid", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> pincodeValForGram(@RequestBody PincodeValid pincodeValid) {
		return userService.pincodeValForGram(pincodeValid);
	}
	
	@RequestMapping(path = "pinForPoojaOff", method = RequestMethod.POST)
	@ResponseBody
	public String pincodeValForPoojaOff(@RequestBody  PincodeValid pincodeValid) {
		return userService.pincodeValForPoojaOff(pincodeValid);
	}
	
	@RequestMapping(path = "districtsByState", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<String>> getStateDistricts(@RequestBody LocationDto locationDto) {
		return userService.getStateDistricts(locationDto);
	}


}
