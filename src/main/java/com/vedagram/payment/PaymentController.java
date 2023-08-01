/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.payment;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Refund;
import com.vedagram.admin.adm.Grammerce;
import com.vedagram.admin.adm.IAdminService;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.user.CancelOrderDto;
import com.vedagram.user.CanceledOrderDetails;
import com.vedagram.user.DonationOrders;
import com.vedagram.user.GrammerceOrders;
import com.vedagram.user.GrammerceOrdersRepository;
import com.vedagram.user.GrammercePurchaseDto;
import com.vedagram.user.MaterialPurchaseDto;
import com.vedagram.user.MultiPurchaseDetails;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.PoojaMaterialOrdersRepository;
import com.vedagram.user.PoojaMaterialOrdersStatus;
import com.vedagram.user.ProjectDonation;
import com.vedagram.user.UserCartDetails;
import com.vedagram.user.UserCartDetailsDto;
import com.vedagram.user.UserCartRepository;
import com.vedagram.user.UserService;
import com.vedagram.user.VedaCart;
import com.vedagram.user.VedaCartDto;
import com.vedagram.user.VedaCartRepository;
import com.vedagram.vendor.PoojaMaterial;

@Controller
@RequestMapping(path = "/pay")
public class PaymentController {

	@Autowired
	IPaymentService paymentService;

	@Value("${pg.base.url}")
	String pgBaseUrl;

	@Autowired
	UserService userService;

	@Autowired
	MongoTemplate mongoTemplate;

	@Autowired
	Utility utility;
	@Autowired
	VedaCartRepository vedaCartRepository;
	@Autowired
	UserPurchaseModelForPayRepository userPurchaseModelForPayRepository;
	@Autowired
	UserCartRepository userCartRepository;
	@Autowired
	PoojaMaterialOrdersRepository poojaMaterialOrdersRepository;
	@Autowired
	GrammerceOrdersRepository grammerceOrdersRepository;
	@Value("${razorpay.key}")
    private String razorpayKey;
    
    @Value("${razorpay.secret.key}")
    private String razorpaySecretKey;
    
    @Value("${cancelorderpercentage}")
    private String cancelorderpercentage;
    
    @Value("${returnorderpercentage}")
    private String returnorderpercentage;
    @Autowired
    IAdminService adminService;
    

	// @RequestMapping("/payinitmulti")
	// public ResponseEntity<Object> payinit() {
	// PaymentInitResDto paymentInitResDto = paymentService.saveSenderRequestTemp();
	// return ResponseEntity.ok(paymentInitResDto);
	// }

	// @RequestMapping("/payresmulti")
	// public ResponseEntity<Object> payres() {
	// List<UserPurchaseResponse> userPurchaseResponseLst = new
	// ArrayList<UserPurchaseResponse>();
	// String userId = utility.getUserId();
	// Query qry = new Query(Criteria.where("userModel").is(userId));
	// List<UserCartDetails> userCartDetailsList = mongoTemplate.find(qry,
	// UserCartDetails.class);
	//
	// paymentService.saveSenderRequestTemp();
	// for (UserCartDetails userCartDetailsDto : userCartDetailsList) {
	// UserPurchaseResponse userPurchaseResponse =
	// userService.savePoojaOfferingsOrder(userCartDetailsDto);
	// userPurchaseResponseLst.add(userPurchaseResponse);
	//
	// Query updateQuery = new
	// Query(Criteria.where("_id").is(userCartDetailsDto.getId()));
	// Update update = new Update();
	//
	// update.set("delFlag", 0);
	// mongoTemplate.findAndModify(updateQuery, update, new
	// FindAndModifyOptions().returnNew(true),
	// UserCartDetails.class);
	// }
	// return ResponseEntity.ok(userPurchaseResponseLst);
	// }
	//
	// @RequestMapping("/payresmulti1")
	// public ResponseEntity<Object> payres1(@RequestBody MultiPurchaseDetails
	// multiPurchaseDetails) {
	// List<UserPurchaseResponse> userPurchaseResponseLst = new
	// ArrayList<UserPurchaseResponse>();
	//// if (paymentService.isPaymentSuccess(multiPurchaseDetails.getOrderId(),
	// multiPurchaseDetails.getPaymentId(), multiPurchaseDetails.getSignature())) {
	// if(multiPurchaseDetails.getOrderId()!=null &&
	// multiPurchaseDetails.getOrderId()!=""){
	// paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(),
	// "PAY_DONE");
	//
	// boolean isMultiReq = (multiPurchaseDetails.getUserCartDetailDtoLst() != null
	// && multiPurchaseDetails.getUserCartDetailDtoLst().size() > 1) ? true : false;
	// int index = 0;
	// String multiReqOrdId = genarateUniqueId();
	//
	// for (UserCartDetailsDto userCartDetailsDto :
	// multiPurchaseDetails.getUserCartDetailDtoLst()) {
	//
	// userCartDetailsDto.setPaymentId(multiPurchaseDetails.getPaymentId());
	//
	// UserPurchaseResponse userPurchaseResponse = null;
	// userPurchaseResponse =
	// userService.savePoojaOfferingsOrder(userCartDetailsDto);
	//
	// userPurchaseResponseLst.add(userPurchaseResponse);
	//
	//
	// multiPurchaseDetails.setAmount(multiPurchaseDetails.getAmount());
	// Query updateQuery = new
	// Query(Criteria.where("_id").is(userCartDetailsDto.getId()));
	// Update update = new Update();
	//
	// update.set("delFlag", 0);
	// mongoTemplate.findAndModify(updateQuery, update, new
	// FindAndModifyOptions().returnNew(true),
	// UserCartDetails.class);
	// }
	//
	// String poojaOfferingOrderId = "";
	// String multiReqId = "";
	// if(isMultiReq) {
	// poojaOfferingOrderId = "";
	// multiReqId = multiReqOrdId;
	// } else {
	// poojaOfferingOrderId = userPurchaseResponseLst.get(0).getId();
	// multiReqId = "";
	// }
	//
	// paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount()+"",
	// multiPurchaseDetails.getOrderId(),
	// multiPurchaseDetails.getPaymentId(), multiPurchaseDetails.getResOrderId(),
	// multiPurchaseDetails.getSignature(),
	// poojaOfferingOrderId, multiReqId, false);
	// } else {
	// paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(),
	// "PAY_FAILED");
	// }
	//
	// return ResponseEntity.ok(userPurchaseResponseLst);
	// }
	//

	private String genarateUniqueId() {
		Random rand = new Random();
		String rndm = Integer.toString(rand.nextInt()) + (System.currentTimeMillis() / 1000L);
		final String uuid = hashCal("SHA-256", rndm).substring(0, 20);
		return uuid;
	}

	private String hashCal(String type, String str) {
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

	
	@RequestMapping("/payInitPoojaOfferings")
	public ResponseEntity<Object> payinitOfferings(@RequestBody VedaCartDto vedaCartDto) {
		String userId = utility.getUserId();
		PaymentInitResDto paymentInitResDto = paymentService.payInitOffering(vedaCartDto,userId);
		return ResponseEntity.ok(paymentInitResDto);
	}
	@RequestMapping("/payResPoojaOfferings")
	public ResponseEntity<Object> payResOffering(@RequestBody MultiPurchaseDetails multiPurchaseDetails) throws ParseException {
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
//		
			if (multiPurchaseDetails.getOrderId() != null && multiPurchaseDetails.getOrderId() != "") {
				UserPurchaseModelForPay userPurchaseModelForPay= paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_DONE");
								// List<VedaCart> vedaCartList=
				// vedaCartRepository.findByUserCartDetailsUserModelIdAndUserCartDetailsDelFlag(utility.getUserId(),3);
				
				UserCartDetailsDto userCartDetailsDto = new UserCartDetailsDto();
				userPurchaseResponse = userService.saveOfferingsOrder(userCartDetailsDto,userPurchaseModelForPay);

					multiPurchaseDetails.setAmount(multiPurchaseDetails.getAmount());
					
				String poojaOfferingOrderId = "";
				String multiReqId = "";
				
				paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount() + "",
						multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
						multiPurchaseDetails.getResOrderId(), multiPurchaseDetails.getSignature(), poojaOfferingOrderId,
						multiReqId,utility.getUser(), false);
			}
		 else {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_FAILED");
		}

		return ResponseEntity.ok(userPurchaseResponse);
	}
	@RequestMapping("/payinitmultipoojaofferings")
	public ResponseEntity<Object> payinit() {
		String userId = utility.getUserId();
		PaymentInitResDto paymentInitResDto = paymentService.createCartPayRef(userId);
		return ResponseEntity.ok(paymentInitResDto);
	}
	@RequestMapping("/payresmultipoojaofferings")
	public ResponseEntity<Object> payres(@RequestBody MultiPurchaseDetails multiPurchaseDetails) throws ParseException {
		List<UserPurchaseResponse> userPurchaseResponseLst = new ArrayList<UserPurchaseResponse>();
			if (multiPurchaseDetails.getOrderId() != null && multiPurchaseDetails.getOrderId() != "") {
				List<UserPurchaseModelForPay> userPurchaseModelForPay= paymentService.updateUserPurchaseModelForPay1(multiPurchaseDetails.getOrderId(), "PAY_DONE");
				List<UserCartDetails> cartDetailsLst = userCartRepository
						.findByUserModelIdAndDelFlag(utility.getUserId(), 3);
				List<String> cartIds = new ArrayList<String>();
				for (UserCartDetails uIds : cartDetailsLst) {
					cartIds.add(uIds.getId());
				}
				Query query1 = new Query(Criteria.where("userCartDetails").in(cartIds));

				List<VedaCart> vedaCartList = mongoTemplate.find(query1, VedaCart.class);
				// List<VedaCart> vedaCartList=
				// vedaCartRepository.findByUserCartDetailsUserModelIdAndUserCartDetailsDelFlag(utility.getUserId(),3);
				boolean isMultiReq = (vedaCartList != null && vedaCartList.size() > 1) ? true : false;
				int index = 0;
				String multiReqOrdId = genarateUniqueId();
				int size = userPurchaseModelForPay.size();

				for (int i = 0; i < size; i++) {
					
					
					UserPurchaseResponse userPurchaseResponse = null;
					userPurchaseResponse = userService.savePoojaOfferingsOrder(vedaCartList.get(i).getUserCartDetails(),userPurchaseModelForPay.get(i));

					userPurchaseResponseLst.add(userPurchaseResponse);

					multiPurchaseDetails.setAmount(multiPurchaseDetails.getAmount());
					Query updateQuery = new Query(Criteria.where("_id").is(vedaCartList.get(i).getUserCartDetails().getId()));
					Update update = new Update();

					update.set("delFlag", 0);
					mongoTemplate.findAndModify(updateQuery, update, new FindAndModifyOptions().returnNew(true),
							UserCartDetails.class);
				}

				String poojaOfferingOrderId = "";
				String multiReqId = "";
				if (isMultiReq) {
					poojaOfferingOrderId = "";
					multiReqId = multiReqOrdId;
				} else {
					poojaOfferingOrderId = userPurchaseResponseLst.get(0).getId();
					multiReqId = "";
				}

				paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount() + "",
						multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
						multiPurchaseDetails.getResOrderId(), multiPurchaseDetails.getSignature(), poojaOfferingOrderId,
						multiReqId,utility.getUser(), false);
			}
		 else {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_FAILED");
		}

		return ResponseEntity.ok(userPurchaseResponseLst);
	}

	@RequestMapping("/payinitmultipoojamaterials")
	public ResponseEntity<Object> payinit(@RequestBody MaterialPurchaseDto materialPurchaseDto) {
		PaymentInitResDto paymentInitResDto = paymentService.createCartPayRefForPoojaMaterials(materialPurchaseDto);
		return ResponseEntity.ok(paymentInitResDto);
	}

	@RequestMapping("/payresmultipoojamaterials")
	public ResponseEntity<Object> payrespoojamaterials(@RequestBody MultiPurchaseDetails multiPurchaseDetails)
			throws ParseException {

		List<UserPurchaseResponse> userPurchaseResponseLst = new ArrayList<UserPurchaseResponse>();
		if (paymentService.isPaymentSuccess(multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
				multiPurchaseDetails.getSignature())) {
			if (multiPurchaseDetails.getOrderId() != null && multiPurchaseDetails.getOrderId() != "") {
				paymentService.updateUserPurchaseModelForPay1(multiPurchaseDetails.getOrderId(), "PAY_DONE");
				List<UserPurchaseModelForPay> userPurchaseModelForPayLst = userPurchaseModelForPayRepository
						.findByCartPayRefId(multiPurchaseDetails.getCartPayRefId());
				boolean isMultiReq = (userPurchaseModelForPayLst != null && userPurchaseModelForPayLst.size() > 1)
						? true
						: false;
				int index = 0;
				String multiReqOrdId = genarateUniqueId();
				// List<PoojaMaterialOrders> poojaMaterialOrdersLst=new
				// ArrayList<PoojaMaterialOrders>();
				for (UserPurchaseModelForPay userPurchaseModelForPay : userPurchaseModelForPayLst) {
					PoojaMaterialOrders poojaMaterialOrders = new PoojaMaterialOrders();
					poojaMaterialOrders.setName(userPurchaseModelForPay.getFirstName());
					poojaMaterialOrders
							.setDakshinaAmountForPriest(userPurchaseModelForPay.getDakshinaAmountForPriest());
					poojaMaterialOrders.setDakshinaAmountToTemple(userPurchaseModelForPay.getDakshinaAmountToTemple());
					poojaMaterialOrders.setStar(userPurchaseModelForPay.getStar());
					poojaMaterialOrders.setPayDakshinaToPriestFlag(userPurchaseModelForPay.isPayDakshinaToPriestFlag());
					poojaMaterialOrders.setPayDakshinaToTempleFlag(userPurchaseModelForPay.isPayDakshinaToTempleFlag());
					poojaMaterialOrders.setOrderDate(new Date());
					poojaMaterialOrders.setTotalAmount(String.valueOf(userPurchaseModelForPay.getTotalAmount()));
					poojaMaterialOrders.setTemples(userPurchaseModelForPay.getTemples());
					poojaMaterialOrders.setUserModel(userPurchaseModelForPay.getUserModel());
					poojaMaterialOrders.setDeity(userPurchaseModelForPay.getDeity());
					poojaMaterialOrders.setListOfdates(userPurchaseModelForPay.getListOfDates());
					poojaMaterialOrders.setPoojaMaterial(userPurchaseModelForPay.getPoojaMaterial());
					poojaMaterialOrders.setQuantity(userPurchaseModelForPay.getQuantity());
					poojaMaterialOrders.setPdAmt(userPurchaseModelForPay.getPdAmt());
					// userService.savePoojaMaterialOrder(poojaMaterialOrders);
					UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
					PoojaMaterialOrders poojaMaterialOrders1 = new PoojaMaterialOrders();
					List<String> listOfdates= new ArrayList<>();
					poojaMaterialOrders1 = poojaMaterialOrdersRepository.save(poojaMaterialOrders);
					if (!poojaMaterialOrders.getListOfdates().isEmpty()
							|| poojaMaterialOrders.getListOfdates() != null) {
						 listOfdates = Arrays.asList(poojaMaterialOrders1.getListOfdates().split("\\|\\|"));
						for (String dates : listOfdates) {
							PoojaMaterialOrdersStatus poojaMaterialOrdersStatus = new PoojaMaterialOrdersStatus();
							poojaMaterialOrdersStatus.setPoojaMaterialOrders(poojaMaterialOrders1);
							poojaMaterialOrdersStatus.setLastUpdatedDate(new Date());
							String s = dates.split("T")[0];
							Date date = new SimpleDateFormat("yyyy-MM-dd").parse(s);
							Calendar cal = Calendar.getInstance();
							cal.setTime(date);
							cal.add(Calendar.DAY_OF_MONTH, 1);
							date = cal.getTime();
							poojaMaterialOrdersStatus.setOrderedDate(null);
							poojaMaterialOrdersStatus.setOrderedDate(date);
							poojaMaterialOrdersStatus.setStatus(GeneralConstants.MATERIALSTATUS_OPEN);
							mongoTemplate.save(poojaMaterialOrdersStatus);

						}
					}
					Query query = new Query();
					query.with(new Sort(Sort.Direction.DESC, "orderNumber"));
					query.limit(1);
					PoojaMaterialOrders maxObject = mongoTemplate.findOne(query, PoojaMaterialOrders.class);
					Long awb = 0l;
					if (maxObject.getOrderNumber() == null) {
						awb = (long) 100001;
					} else {
						String max = maxObject.getOrderNumber();
						String maxVal = max.replaceAll("[^0-9]", "");
						awb = Long.parseLong(maxVal);
						awb++;
					}

					Query materialQuery = new Query(Criteria.where("_id").is(poojaMaterialOrders1.getId()));
					Update update = new Update();
					update.set("orderNumber", "MAT_" + awb.toString());
					mongoTemplate.findAndModify(materialQuery, update, PoojaMaterialOrders.class);

					int stockToReduce = userPurchaseModelForPay.getQuantity()*listOfdates.size();
					Query query1 = new Query(
							Criteria.where("_id").is(userPurchaseModelForPay.getPoojaMaterial().getId()));
					Update update1 = new Update();
//					update1.set("materialStock", stockRemaining);
					update1.inc("materialStock", -stockToReduce);
					mongoTemplate.findAndModify(query1, update1, PoojaMaterial.class);

					userPurchaseResponse.setPoojaOfferingOrdersId(poojaMaterialOrders1.getId());
					userPurchaseResponseLst.add(userPurchaseResponse);

				}
				String poojaOfferingOrderId = "";
				String multiReqId = "";
				if (isMultiReq) {
					poojaOfferingOrderId = "";
					multiReqId = multiReqOrdId;
				} else {
					poojaOfferingOrderId = userPurchaseResponseLst.get(0).getId();
					multiReqId = "";
				}

				paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount() + "",
						multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
						multiPurchaseDetails.getResOrderId(), multiPurchaseDetails.getSignature(), poojaOfferingOrderId,
						multiReqId,utility.getUser(), false);
			}
		} else {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_FAILED");
		}

		return ResponseEntity.ok(userPurchaseResponseLst);
	}

	@RequestMapping("/payinitmultigrammerce")
	public ResponseEntity<Object> payinitgrammerce(@RequestBody GrammercePurchaseDto grammercePurchaseDtoDto) {
		PaymentInitResDto paymentInitResDto = paymentService.createCartPayRefForGrammerce(grammercePurchaseDtoDto);
		return ResponseEntity.ok(paymentInitResDto);
	}

	@RequestMapping("/payresmultigrammerce")
	public ResponseEntity<Object> payresgrammerce(@RequestBody MultiPurchaseDetails multiPurchaseDetails) {

		List<UserPurchaseResponse> userPurchaseResponseLst = new ArrayList<UserPurchaseResponse>();
		// if (paymentService.isPaymentSuccess(multiPurchaseDetails.getOrderId(),
		// multiPurchaseDetails.getPaymentId(), multiPurchaseDetails.getSignature())) {
		if (multiPurchaseDetails.getOrderId() != null && multiPurchaseDetails.getOrderId() != "") {
			paymentService.updateUserPurchaseModelForPay1(multiPurchaseDetails.getOrderId(), "PAY_DONE");
			List<UserPurchaseModelForPay> userPurchaseModelForPayLst = userPurchaseModelForPayRepository
					.findByCartPayRefId(multiPurchaseDetails.getCartPayRefId());
			boolean isMultiReq = (userPurchaseModelForPayLst != null && userPurchaseModelForPayLst.size() > 1) ? true
					: false;
			int index = 0;
			String multiReqOrdId = genarateUniqueId();
			// List<PoojaMaterialOrders> poojaMaterialOrdersLst=new
			// ArrayList<PoojaMaterialOrders>();
			for (UserPurchaseModelForPay userPurchaseModelForPay : userPurchaseModelForPayLst) {
				GrammerceOrders grammerceOrders = new GrammerceOrders();

				grammerceOrders.setName(userPurchaseModelForPay.getFirstName());
				grammerceOrders.setContactNumber(userPurchaseModelForPay.getMobileNumber());
				grammerceOrders.setDeliveryAddress(userPurchaseModelForPay.getDeliveryAddress());
				grammerceOrders.setEmailId(userPurchaseModelForPay.getMailId());
				grammerceOrders.setOrderDate(new Date());
				
//				Calendar calendar = Calendar.getInstance();
//		        calendar.setTime(grammerceOrders.getOrderDate());
//		        calendar.add(Calendar.DAY_OF_YEAR, userPurchaseModelForPay.getGrammerce().getDeliveryLeadTime());
//		        Date expectedDate = calendar.getTime();
//				grammerceOrders.setExpDeliveryDate(expectedDate);
				
				grammerceOrders.setExpDeliveryDate(userPurchaseModelForPay.getExpDeliveryDate());
				
		        double amt = userPurchaseModelForPay.getTotalAmount();
				grammerceOrders.setTotalPrice(String.valueOf(amt));
				grammerceOrders.setQuantity(String.valueOf(userPurchaseModelForPay.getQuantity()));
				grammerceOrders.setGrammerce(userPurchaseModelForPay.getGrammerce());
				UserModel userModel = new UserModel();
				userModel.setId(utility.getUserId());
				grammerceOrders.setUserModel(userModel);
				grammerceOrders.setStatus(GeneralConstants.GRAMMERCE_OPEN);
				grammerceOrders.setAwbNumber("");
				grammerceOrders.setGiftFlag(userPurchaseModelForPay.isGiftFlag());
				grammerceOrders.setGiftNote(userPurchaseModelForPay.getGiftNote());
				grammerceOrders.setGiftedBy(userPurchaseModelForPay.getGiftedBy());
				grammerceOrders.setPdAmt(userPurchaseModelForPay.getPdAmt());
				UserPurchaseResponse userPurchaseResponse = userService.saveGrammerceOrders(grammerceOrders);
                grammerceOrders.setId(userPurchaseResponse.getPoojaOfferingOrdersId());
				Query query = new Query(Criteria.where("id").is(userPurchaseModelForPay.getId()));
                Update update =new Update();
                update.set("grammerceOrders",grammerceOrders);
                mongoTemplate.findAndModify(query, update,UserPurchaseModelForPay.class);   
				userPurchaseResponseLst.add(userPurchaseResponse);

				int stockRemaining = userPurchaseModelForPay.getGrammerce().getStock()
						- userPurchaseModelForPay.getQuantity();
				Query query1 = new Query(Criteria.where("_id").is(userPurchaseModelForPay.getGrammerce().getId()));
				Update update1 = new Update();
				update1.set("stock", stockRemaining);
				mongoTemplate.findAndModify(query1, update1, Grammerce.class);
			}
			String poojaOfferingOrderId = "";
			String multiReqId = "";
			if (isMultiReq) {
				poojaOfferingOrderId = "";
				multiReqId = multiReqOrdId;
			} else {
				poojaOfferingOrderId = userPurchaseResponseLst.get(0).getId();
				multiReqId = "";
			}

			paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount() + "",
					multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
					multiPurchaseDetails.getResOrderId(), multiPurchaseDetails.getSignature(), poojaOfferingOrderId,
					multiReqId,utility.getUser(), false);
		}
		// }
		else {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_FAILED");
		}

		return ResponseEntity.ok(userPurchaseResponseLst);
	}

	@RequestMapping("/payinitdonate")
	public ResponseEntity<Object> payinitdonate(@RequestBody DonationOrders donationOrders) {
		PaymentInitResDto paymentInitResDto = paymentService.createCartPayRefForDonation(donationOrders);
		return ResponseEntity.ok(paymentInitResDto);
	}

	@RequestMapping("/payresdonate")
	public ResponseEntity<Object> payresdonate(@RequestBody MultiPurchaseDetails multiPurchaseDetails) {

		List<UserPurchaseResponse> userPurchaseResponseLst = new ArrayList<UserPurchaseResponse>();
		// if (paymentService.isPaymentSuccess(multiPurchaseDetails.getOrderId(),
		// multiPurchaseDetails.getPaymentId(), multiPurchaseDetails.getSignature())) {
		if (multiPurchaseDetails.getOrderId() != null && multiPurchaseDetails.getOrderId() != "") {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_DONE");
			UserPurchaseModelForPay userPurchaseModelForPay = userPurchaseModelForPayRepository
					.findById(multiPurchaseDetails.getCartPayRefId());
			boolean isMultiReq = (userPurchaseModelForPay != null) ? true : false;
			int index = 0;
			String multiReqOrdId = genarateUniqueId();
			// List<PoojaMaterialOrders> poojaMaterialOrdersLst=new
			// ArrayList<PoojaMaterialOrders>();

			DonationOrders donationOrders = new DonationOrders();
			donationOrders.setAddress(userPurchaseModelForPay.getDeliveryAddress());
			donationOrders.setContactNumber(userPurchaseModelForPay.getMobileNumber());
			donationOrders.setContributionAmount(userPurchaseModelForPay.getContributionAmount() / 100);
			donationOrders.setDonationDate(userPurchaseModelForPay.getCreateDate());
			donationOrders.setDonorName(userPurchaseModelForPay.getFirstName());
			donationOrders.setEmailId(userPurchaseModelForPay.getMailId());
			donationOrders.setPurpose(userPurchaseModelForPay.getPurpose());
			donationOrders.setRemarks(userPurchaseModelForPay.getRemarks());
			donationOrders.setRevealFlag(userPurchaseModelForPay.isRevealFlag());
			if(userPurchaseModelForPay.getUserModel()!=null) {
				donationOrders.setUserModel(userPurchaseModelForPay.getUserModel());
			}
			UserPurchaseResponse userPurchaseResponse = userService.saveDonationOrders(donationOrders);

			userPurchaseResponseLst.add(userPurchaseResponse);

			String poojaOfferingOrderId = "";
			String multiReqId = "";
			if (isMultiReq) {
				poojaOfferingOrderId = "";
				multiReqId = multiReqOrdId;
			} else {
				poojaOfferingOrderId = userPurchaseResponseLst.get(0).getId();
				multiReqId = "";
			}

			paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount() + "",
					multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
					multiPurchaseDetails.getResOrderId(), multiPurchaseDetails.getSignature(), poojaOfferingOrderId,
					multiReqId,donationOrders.getUserModel(), false);
		}
		// }
		else {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_FAILED");
		}

		return ResponseEntity.ok(userPurchaseResponseLst);
	}

	@RequestMapping("/payinitprojectDonate")
	public ResponseEntity<Object> payinitprojectDonate(@RequestBody ProjectDonation projectDonation) {
		PaymentInitResDto paymentInitResDto = paymentService.createCartPayRefForProjectDonation(projectDonation);
		return ResponseEntity.ok(paymentInitResDto);
	}

	@RequestMapping("/payresprojectDonate")
	public ResponseEntity<Object> payresprojectDonate(@RequestBody MultiPurchaseDetails multiPurchaseDetails) {

		List<UserPurchaseResponse> userPurchaseResponseLst = new ArrayList<UserPurchaseResponse>();
		if (paymentService.isPaymentSuccess(multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
				multiPurchaseDetails.getSignature())) {
			if (multiPurchaseDetails.getOrderId() != null && multiPurchaseDetails.getOrderId() != "") {
				paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_DONE");
				UserPurchaseModelForPay userPurchaseModelForPay = userPurchaseModelForPayRepository
						.findById(multiPurchaseDetails.getCartPayRefId());
				boolean isMultiReq = (userPurchaseModelForPay != null) ? true : false;
				int index = 0;
				String multiReqOrdId = genarateUniqueId();
				// List<PoojaMaterialOrders> poojaMaterialOrdersLst=new
				// ArrayList<PoojaMaterialOrders>();

				ProjectDonation projectDonation = new ProjectDonation();
				projectDonation.setAddress(userPurchaseModelForPay.getDeliveryAddress());
				projectDonation.setContactNumber(userPurchaseModelForPay.getMobileNumber());
				projectDonation.setContributionAmount(userPurchaseModelForPay.getContributionAmount() / 100);
				projectDonation.setDonationDate(userPurchaseModelForPay.getCreateDate());
				projectDonation.setDonorName(userPurchaseModelForPay.getFirstName());
				projectDonation.setEmailId(userPurchaseModelForPay.getMailId());
				projectDonation.setProjectModel(userPurchaseModelForPay.getProjectModel());
				projectDonation.setRemarks(userPurchaseModelForPay.getRemarks());
				if (userPurchaseModelForPay.getUserModel() != null) {
				projectDonation.setUserModel(userPurchaseModelForPay.getUserModel());
				}
				UserPurchaseResponse userPurchaseResponse = userService.donateToProject(projectDonation);
				userPurchaseResponseLst.add(userPurchaseResponse);
				String poojaOfferingOrderId = "";
				String multiReqId = "";
				if (isMultiReq) {
					poojaOfferingOrderId = "";
					multiReqId = multiReqOrdId;
				} else {
					poojaOfferingOrderId = userPurchaseResponseLst.get(0).getId();
					multiReqId = "";
				}

				paymentService.saveUserPurchaseDetail(multiPurchaseDetails.getAmount() + "",
						multiPurchaseDetails.getOrderId(), multiPurchaseDetails.getPaymentId(),
						multiPurchaseDetails.getResOrderId(), multiPurchaseDetails.getSignature(), poojaOfferingOrderId,
						multiReqId,projectDonation.getUserModel(), false);
			}
		} else {
			paymentService.updateUserPurchaseModelForPay(multiPurchaseDetails.getOrderId(), "PAY_FAILED");
		}

		return ResponseEntity.ok(userPurchaseResponseLst);
	}
	@RequestMapping("/cancelGrammerceOrder")
	public ResponseEntity<CanceledOrderDetails> cancelGrammerceOrder(@RequestBody CancelOrderDto cancelOrderDto) throws JSONException {
		  CanceledOrderDetails canceledOrderDetails = new CanceledOrderDetails();
		  Refund refund=null;
		Query query = new Query(Criteria.where("id").is(cancelOrderDto.getGrammerceOrdId()));
		GrammerceOrders grammerceOrders = mongoTemplate.findOne(query, GrammerceOrders.class);
		
		
			UserPurchaseModelForPay modelForPay = mongoTemplate.findOne(new Query(Criteria.where("grammerceOrders").is(grammerceOrders.getId())), UserPurchaseModelForPay.class);
		
			UserPurchaseDetail purchaseDetail = mongoTemplate.findOne(new Query(Criteria.where("transId").is(modelForPay.getOrderId())), UserPurchaseDetail.class);
		
			String paymentId = purchaseDetail.getPaymentId();
		 
			 Double refundAmt=modelForPay.getTotalAmount()+(modelForPay.getPdAmt());
			 Double refundAmount=refundAmt-(refundAmt/Integer.parseInt(cancelorderpercentage));
		
			 JSONObject refundRequest = new JSONObject();
			 refundRequest.put("amount",refundAmount*100);
			 refundRequest.put("currency", "INR");
			 refundRequest.put("speed","normal");
			 
			 try {
			  RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
			   refund = razorpayClient.Payments.refund(paymentId,refundRequest);
			 }
			 catch (RazorpayException e) {
				 canceledOrderDetails.setStatus("refund request unsuccessful");
				e.printStackTrace();
				return ResponseEntity.ok(canceledOrderDetails);
				
			}

			  canceledOrderDetails.setStatus(refund.get("status"));
			  canceledOrderDetails.setCurrency(refund.get("currency"));
			  canceledOrderDetails.setEntity(refund.get("entity"));
			  canceledOrderDetails.setPaymentId(refund.get("payment_id"));
			  canceledOrderDetails.setRefundAmount(refundAmount);
			  canceledOrderDetails.setRefundId(refund.get("id"));
			  canceledOrderDetails.setSpeedRequested(refund.get("speed_requested"));
			  canceledOrderDetails.setCreatedAt(LocalDate.now());
			  canceledOrderDetails.setUserDetails(utility.getUser());
			  canceledOrderDetails.setCancellationFee(refundAmt/10);
			  GrammerceOrders orders = new GrammerceOrders();
			  orders.setId(cancelOrderDto.getGrammerceOrdId());
			  canceledOrderDetails.setGrammerceOrders(orders);
			  mongoTemplate.save(canceledOrderDetails);
			  if(grammerceOrders!=null) {
					Update update = new Update();
					update.set("status",GeneralConstants.GRAMMERCE_CANCELLED);
					update.set("cancelReason",cancelOrderDto.getCancelReason());
					update.set("refundFlag", true);
					mongoTemplate.findAndModify(query,update, GrammerceOrders.class);
					
					Query query1 = new Query(Criteria.where("id").is(grammerceOrders.getGrammerce().getId()));
					Update update1 = new Update();
					update1.inc("stock", Integer.parseInt(grammerceOrders.getQuantity()));
					mongoTemplate.findAndModify(query1, update1, Grammerce.class);
				}
		
	            return ResponseEntity.ok(canceledOrderDetails);
		
	}
	@RequestMapping("/returnGrammerceOrder")
	public ResponseEntity<PickDropShipmentResDto> returnGrammerceOrder(@RequestBody CancelOrderDto cancelOrderDto) throws JSONException {
		
	           return ResponseEntity.ok(adminService.returnShipmentForGrammerce(cancelOrderDto));
		
		
	}
	@RequestMapping("/initRefundForGrammerceOrder")
	public ResponseEntity<CanceledOrderDetails> initRefundForGrammerceOrder(@RequestBody CancelOrderDto cancelOrderDto) throws JSONException {
		 CanceledOrderDetails canceledOrderDetails = new CanceledOrderDetails();
			if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {

		  Refund refund=null;
		  Query query = new Query(Criteria.where("id").is(cancelOrderDto.getGrammerceOrdId()));
	   	  GrammerceOrders grammerceOrders = mongoTemplate.findOne(query, GrammerceOrders.class);
		
		
			UserPurchaseModelForPay modelForPay = mongoTemplate.findOne(new Query(Criteria.where("grammerceOrders").is(grammerceOrders.getId())), UserPurchaseModelForPay.class);
		
			UserPurchaseDetail purchaseDetail = mongoTemplate.findOne(new Query(Criteria.where("transId").is(modelForPay.getOrderId())), UserPurchaseDetail.class);
		
			String paymentId = purchaseDetail.getPaymentId();
		    int qnty =Integer.parseInt(grammerceOrders.getQuantity());
			 Double refundAmt=(double) (qnty*(grammerceOrders.getGrammerce().getPrice()));
			 Double refundAmount=refundAmt-(refundAmt/Integer.parseInt(returnorderpercentage));

			 JSONObject refundRequest = new JSONObject();
			 refundRequest.put("amount",refundAmount*100);
			 refundRequest.put("currency", "INR");
			 refundRequest.put("speed","normal");
			 
			 try {
			  RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
			   refund = razorpayClient.Payments.refund(paymentId,refundRequest);

			 }
			 catch (RazorpayException e) {
				 canceledOrderDetails.setStatus("refund request unsuccessful");
				e.printStackTrace();
				return ResponseEntity.ok(canceledOrderDetails);
				
			}
			
			  canceledOrderDetails.setStatus(refund.get("status"));
			  canceledOrderDetails.setCurrency(refund.get("currency"));
			  canceledOrderDetails.setEntity(refund.get("entity"));
			  canceledOrderDetails.setPaymentId(refund.get("payment_id"));
			  canceledOrderDetails.setRefundAmount(refundAmount);
			  canceledOrderDetails.setRefundId(refund.get("id"));
			  canceledOrderDetails.setSpeedRequested(refund.get("speed_requested"));
			  canceledOrderDetails.setCreatedAt(LocalDate.now());
			  canceledOrderDetails.setUserDetails(utility.getUser());
			  canceledOrderDetails.setCancellationFee(refundAmt/10);
			  GrammerceOrders orders = new GrammerceOrders();
			  orders.setId(cancelOrderDto.getGrammerceOrdId());
			  canceledOrderDetails.setGrammerceOrders(orders);
			  mongoTemplate.save(canceledOrderDetails);			
			  if(grammerceOrders!=null) {
					Update update = new Update();
					update.set("refundFlag", true);
					mongoTemplate.findAndModify(query,update, GrammerceOrders.class);
				}
			}

	          return ResponseEntity.ok(canceledOrderDetails);
		
		
		
	}
	@RequestMapping(value = "/replaceGrammerceOrder",method =RequestMethod.POST)
	public ResponseEntity<PickDropShipmentResDto> replaceGrammerceOrder(@RequestBody CancelOrderDto cancelOrderDto) {
		
		return ResponseEntity.ok(adminService.replaceGrammerceShipmentFromUser(cancelOrderDto));
		
		
	}
	
	

}