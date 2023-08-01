/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.payment;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.SignatureException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mongodb.client.result.UpdateResult;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.vedagram.admin.adm.Grammerce;
import com.vedagram.admin.adm.GrammerceDto;
import com.vedagram.admin.adm.GrammerceRepository;
import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.projectadm.ProjectModel;
import com.vedagram.projectadm.ProjectRepository;
import com.vedagram.repository.UserRepository;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.TempleRepository;
import com.vedagram.tempadmin.Temples;
import com.vedagram.user.DonationOrders;
import com.vedagram.user.GrammercePurchaseDto;
import com.vedagram.user.MaterialDeityDto;
import com.vedagram.user.MaterialPurchaseDto;
import com.vedagram.user.ProjectDonation;
import com.vedagram.user.UserCartDetails;
import com.vedagram.user.UserCartRepository;
import com.vedagram.user.UserProductDetailsRepository;
import com.vedagram.user.VedaCart;
import com.vedagram.user.VedaCartDto;
import com.vedagram.user.VedaCartRepository;
import com.vedagram.vendor.PoojaMaterial;
import com.vedagram.vendor.PoojaMaterialDto;

@Service
public class PaymentServiceImpl implements IPaymentService {

    @Autowired
    MongoTemplate mongoTemplate;

    @Autowired
    Utility utility;
    @Value("${razorpay.key}")
    private String razorpayKey;
    
    @Value("${razorpay.secret.key}")
    private String razorpaySecretKey;
    @Autowired
	private Environment env;
    
    @Autowired
    UserProductDetailsRepository userProductDetailsRepository;
    @Autowired
    VedaCartRepository vedaCartRepository;
    @Autowired
    CartPayRefRepository cartPayRefRepository;
    @Autowired
    UserPurchaseModelForPayRepository userPurchaseModelForPayRepository;
    @Autowired
   UserCartRepository userCartRepository;
    @Autowired
    TempleRepository templeRepository;
    @Autowired
    GrammerceRepository grammerceRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ProjectRepository projectRepository;
	//@Override
//	public PaymentInitResDto saveSenderRequestTemp() {
//		String userId = utility.getUserId();
//		Query qry = new Query(Criteria.where("userModel").is(userId));
//		List<UserCartDetails> userCartDetailsList = mongoTemplate.find(qry, UserCartDetails.class);
//		
//    	PaymentInitResDto paymentInitResDto = null;
//    	double totAmountInPaise = 0d;
//    	UserModel userModel = null;
//		if (userCartDetailsList.get(0).getMobileNumber() != null
//				&& !userCartDetailsList.get(0).getMobileNumber().isEmpty()) {
//			Query query = new Query(Criteria.where("mobileNumber")
//					.is(userCartDetailsList.get(0).getMobileNumber()));
//			userModel = mongoTemplate.findOne(query, UserModel.class);
//		}
//		
//		if (userModel == null)
//			return paymentInitResDto;
//		
//		List<String> senderRequestModelForPayIds = new ArrayList<String>();
//    	for (UserCartDetails userCartDetails : userCartDetailsList) {
//    		if (userCartDetails != null) {
//    			try {
//    				
//    					UserPurchaseModelForPay userPurchaseModelForPay = new UserPurchaseModelForPay();
//    					userCartDetails.setLastModifiedDate(new Date());
//    					userPurchaseModelForPay.setCreateDate(new Date());
//    					BeanUtils.copyProperties(userCartDetails, userPurchaseModelForPay);
//    					userPurchaseModelForPay.setLoginUserId(utility.getUserId());
//    					userPurchaseModelForPay.setCreateDate(new Date());
//    					userPurchaseModelForPay.setPaymentStatus("PAY_INIT");
//    					UserProductDetails userProductDetails=	userProductDetailsRepository.findByuserCartDetailsId(userCartDetails.getId());
//    					Double totAmt=(double) 0;
//    					double amountInPaise=0;
//    					if(userCartDetails.getDakshinaAmountForPriest()!=null){
//    						totAmt+=userCartDetails.getDakshinaAmountForPriest();
//    						amountInPaise+=userCartDetails.getDakshinaAmountForPriest() * 100;
//    					}
//    					 if(userCartDetails.getDakshinaAmountToTemple()!=null){
//    						 totAmt+=userCartDetails.getDakshinaAmountToTemple();
//    						 amountInPaise+=userCartDetails.getDakshinaAmountToTemple() * 100;
//    					}
//    					 totAmt+=userProductDetails.getBookedQuantity()*userCartDetails.getPoojaOfferings().getPrice();
//    					userPurchaseModelForPay.setTotalAmount(totAmt);
//    					amountInPaise+=userProductDetails.getBookedQuantity()*userCartDetails.getPoojaOfferings().getPrice() * 100;
//    					mongoTemplate.insert(userPurchaseModelForPay);
//    					
//    					
//    					 
//    					totAmountInPaise += amountInPaise;
//    					senderRequestModelForPayIds.add(userPurchaseModelForPay.getId());
//    				
//    			} catch (Exception e) {
//    				e.printStackTrace();
//    			}
//    		}
//		}
////    	Order order = null;
////    	try {
////    		JSONObject orderRequest = new JSONObject();
////    		orderRequest.put("amount", totAmountInPaise);
////    		orderRequest.put("currency", "INR");
////    		orderRequest.put("receipt", multiPurchaseDetails.getMultiPurchOrdId());
////
////    		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
////    		order = razorpayClient.Orders.create(orderRequest);
////		} catch (RazorpayException e) {
////			paymentInitResDto.setInitResMsg(e.getMessage());
////		} catch (JSONException e) {
////			e.printStackTrace();
////		}
//    	
////    	if(order == null) {
////    		paymentInitResDto.setInitResMsg("Amount Incorrect");
////			return paymentInitResDto;
////    	}
//    	String orderId="";
//		for (String senderRequestModelForPayId : senderRequestModelForPayIds) {
//			Query query = new Query(Criteria.where("_id").is(senderRequestModelForPayId));
//			 Random rnd = new Random();
//			    int number = rnd.nextInt(999999);
//			    orderId="ORD_"+String.format("%06d", number);
//			Update update = new Update().set("orderId", "ORD_"+String.format("%06d", number));
//			mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
//		}
//		
//		UserModel loginMem = utility.getUser();
//		String memberName = "";
//		if(loginMem != null) {
//			if(loginMem.getFirstName() != null) {
//				memberName = loginMem.getFirstName();
//			}
//			
//			if(loginMem.getLastName() != null) {
//				if(!memberName.trim().isEmpty()) {
//					memberName += " ";
//				}
//				memberName += loginMem.getLastName();
//			}
//		}
//		
//		String email = loginMem.getEmail() == null ? "" : loginMem.getEmail();
//		String mobileNumber = loginMem.getMobileNumber();
//		
//		Map<String, Object> pgOption = new HashMap<String, Object>();
//		pgOption.put("description", "Vedagram Purchase Charge");
//		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
//		pgOption.put("currency", "INR");
//		pgOption.put("key", razorpayKey);
//		//pgOption.put("order_id", order.get("id"));
//		pgOption.put("amount", totAmountInPaise);
//		pgOption.put("name", memberName);
//		
//		paymentInitResDto = new PaymentInitResDto();
//		//paymentInitResDto.setDescription("PickDrop Delivery Charge");
//	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
//		paymentInitResDto.setCurrency("INR");
//		paymentInitResDto.setKey(razorpayKey);
//		paymentInitResDto.setAmount(totAmountInPaise + "");
//		paymentInitResDto.setName(memberName);
//		paymentInitResDto.setTheme("#30c58f");
//		paymentInitResDto.setEmail(email);
//		paymentInitResDto.setContact(mobileNumber);
//		paymentInitResDto.setOrderId(orderId);
//		paymentInitResDto.setPgOption(pgOption);
//		
//		return paymentInitResDto;
//	
//	}
	
	@Override
	public boolean isPaymentSuccess(String orderId, String paymentId, String signature) {
		try {
			String generatedSignature = hmacSha256(orderId + "|" + paymentId, razorpaySecretKey);
			if (generatedSignature.equals(signature)) {
				return true;
			}
		} catch (SignatureException e) {
			e.printStackTrace();
		}
    	return false;
    }

	@Override
	public UserPurchaseModelForPay updateUserPurchaseModelForPay(String orderId, String paymentStatus) {
		// TODO Auto-generated method stub
		Query query = new Query(Criteria.where("orderId").is(orderId));
		Update update= new Update();
		update.set("paymentStatus", paymentStatus);
		UserPurchaseModelForPay userPurchaseModelForPay  =	mongoTemplate.findAndModify(query,update,UserPurchaseModelForPay.class);
		return userPurchaseModelForPay;
	}
	@Override
	public List<UserPurchaseModelForPay> updateUserPurchaseModelForPay1(String orderId, String paymentStatus) {
		// TODO Auto-generated method stub
		List<UserPurchaseModelForPay> userPurchaseModelForPay=new ArrayList<>();
		Query query = new Query(Criteria.where("orderId").is(orderId));
		List<UserPurchaseModelForPay> modelForPays= mongoTemplate.find(query, UserPurchaseModelForPay.class);
		for(UserPurchaseModelForPay forPay:modelForPays) {
			Query query1 = new Query(Criteria.where("id").is(forPay.getId()));
			Update update= new Update();
			update.set("paymentStatus", paymentStatus);
			UserPurchaseModelForPay modelForPay  =	mongoTemplate.findAndModify(query1,update,new FindAndModifyOptions(),UserPurchaseModelForPay.class);
			userPurchaseModelForPay.add(modelForPay);
		}
		
		return userPurchaseModelForPay;
	}
	public static String hmacSha256(String data, String secret) throws java.security.SignatureException {
		String result;
		try {
			SecretKeySpec signingKey = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(data.getBytes());
			result = DatatypeConverter.printHexBinary(rawHmac).toLowerCase();
		} catch (Exception e) {
			throw new SignatureException("Failed to generate HMAC : " + e.getMessage());
		}
		return result;
	}

	@Override
	public UserPurchaseDetail saveUserPurchaseDetail(String amount, String orderId, String paymentId, String resOrderId,
			String signature, String poojaOfferingOrderId, String multiReqId,UserModel user, boolean b) {

    	UserModel userModel = null;
    	if(user!=null) {
    		userModel=user;
    	}
    	String userName = "";
    	if(userModel!=null) {
    	if(userModel.getFirstName() != null) {
    		userName = userModel.getFirstName();
    	}
    	if(userModel.getLastName() != null) {
    		if(!userName.isEmpty())
    			userName += " ";
    		userName += userModel.getLastName();
    	}
    	}
    	
    	UserPurchaseDetail userPurchaseDetail = new UserPurchaseDetail();
		userPurchaseDetail.setErrorText("");
		userPurchaseDetail.setErrorNumber("");
		userPurchaseDetail.setTransResult("success");
		userPurchaseDetail.setPostDate("");
		userPurchaseDetail.setTransId(orderId);
		userPurchaseDetail.setTrackId("");
		userPurchaseDetail.setAuthCode("");
		userPurchaseDetail.setTransAvr("");
		userPurchaseDetail.setReferenceNo("");
		userPurchaseDetail.setTransAmount(amount + "");
		userPurchaseDetail.setUdf1("");
		userPurchaseDetail.setUdf2("");
		userPurchaseDetail.setUdf3("");
		userPurchaseDetail.setUdf4("");
		userPurchaseDetail.setUdf5("");
		userPurchaseDetail.setUserName(userName);
		userPurchaseDetail.setUserModel(userModel);
		userPurchaseDetail.setUserPurchaseReqId("");
		userPurchaseDetail.setCreatedDate(new Date());
		userPurchaseDetail.setPoojaOfferingOrderId(poojaOfferingOrderId);
		userPurchaseDetail.setMultiRequestId(multiReqId);
		userPurchaseDetail.setPaymentId(paymentId);
		userPurchaseDetail.setOrderId(resOrderId);
		userPurchaseDetail.setSignature(signature);
		
		mongoTemplate.insert(userPurchaseDetail);
		
		
		return userPurchaseDetail;
		
		
		
	
		
	}

	//@Override
//	public PaymentInitResDto saveSenderRequestTemp(MultiPurchaseDetails multiPurchaseDetails) {
//
//    	PaymentInitResDto paymentInitResDto = new PaymentInitResDto();
//    	double totAmountInPaise = 0d;
//    	UserModel userModel = null;
//		if (multiPurchaseDetails.getUserCartDetailDtoLst().get(0).getMobileNumber() != null
//				&& !multiPurchaseDetails.getUserCartDetailDtoLst().get(0).getMobileNumber().isEmpty()) {
//			Query query = new Query(Criteria.where("mobileNumber")
//					.is(multiPurchaseDetails.getUserCartDetailDtoLst().get(0).getMobileNumber()));
//			userModel = mongoTemplate.findOne(query, UserModel.class);
//		}
//		
//		if (userModel == null)
//			return paymentInitResDto;
//		
//		List<String> senderRequestModelForPayIds = new ArrayList<String>();
//    	for (UserCartDetailsDto userCartDetailsDto : multiPurchaseDetails.getUserCartDetailDtoLst()) {
//    		if (userCartDetailsDto != null) {
//    			try {
//    				
//    					UserPurchaseModelForPay userPurchaseModelForPay = new UserPurchaseModelForPay();
//    					userCartDetailsDto.setLastModifiedDate(new Date());
//    					userPurchaseModelForPay.setCreateDate(new Date());
//    					BeanUtils.copyProperties(userCartDetailsDto, userPurchaseModelForPay);
//    					userPurchaseModelForPay.setLoginUserId(utility.getUserId());
//    					userPurchaseModelForPay.setCreateDate(new Date());
//    					userPurchaseModelForPay.setPaymentStatus("PAY_INIT");
//    					UserProductDetails userProductDetails=	userProductDetailsRepository.findByuserCartDetailsId(userCartDetailsDto.getId());
//    					Double totAmt=(double) 0;
//    					double amountInPaise=0;
//    					if(userCartDetailsDto.getDakshinaAmountForPriest()!=null){
//    						totAmt+=userCartDetailsDto.getDakshinaAmountForPriest();
//    						amountInPaise+=userCartDetailsDto.getDakshinaAmountForPriest() * 100;
//    					}
//    					 if(userCartDetailsDto.getDakshinaAmountToTemple()!=null){
//    						 totAmt+=userCartDetailsDto.getDakshinaAmountToTemple();
//    						 amountInPaise+=userCartDetailsDto.getDakshinaAmountToTemple() * 100;
//    					}
//    					 totAmt+=userProductDetails.getBookedQuantity()*userCartDetailsDto.getPoojaOfferings().getPrice();
//    					userPurchaseModelForPay.setTotalAmount(totAmt);
//    					amountInPaise+=userProductDetails.getBookedQuantity()*userCartDetailsDto.getPoojaOfferings().getPrice() * 100;
//    					mongoTemplate.insert(userPurchaseModelForPay);
//    					
//    					
//    					 
//    					totAmountInPaise += amountInPaise;
//    					senderRequestModelForPayIds.add(userPurchaseModelForPay.getId());
//    				
//    			} catch (Exception e) {
//    				e.printStackTrace();
//    			}
//    		}
//		}
//    	Order order = null;
//    	try {
//    		JSONObject orderRequest = new JSONObject();
//    		orderRequest.put("amount", totAmountInPaise);
//    		orderRequest.put("currency", "INR");
//    		orderRequest.put("receipt", multiPurchaseDetails.getMultiPurchOrdId());
//
//    		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
//    		order = razorpayClient.Orders.create(orderRequest);
//		} catch (RazorpayException e) {
//			paymentInitResDto.setInitResMsg(e.getMessage());
//		} catch (JSONException e) {
//			e.printStackTrace();
//		}
//    	
//    	if(order == null) {
//    		paymentInitResDto.setInitResMsg("Amount Incorrect");
//			return paymentInitResDto;
//    	}
//    	String orderId="";
//		for (String senderRequestModelForPayId : senderRequestModelForPayIds) {
//			Query query = new Query(Criteria.where("_id").is(senderRequestModelForPayId));
//			 Random rnd = new Random();
//			    int number = rnd.nextInt(999999);
//			    orderId="ORD_"+String.format("%06d", number);
//			Update update = new Update().set("orderId", "ORD_"+String.format("%06d", number));
//			mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
//		}
//		
//		UserModel loginMem = utility.getUser();
//		String memberName = "";
//		if(loginMem != null) {
//			if(loginMem.getFirstName() != null) {
//				memberName = loginMem.getFirstName();
//			}
//			
//			if(loginMem.getLastName() != null) {
//				if(!memberName.trim().isEmpty()) {
//					memberName += " ";
//				}
//				memberName += loginMem.getLastName();
//			}
//		}
//		
//		String email = loginMem.getEmail() == null ? "" : loginMem.getEmail();
//		String mobileNumber = loginMem.getMobileNumber();
//		
//		Map<String, Object> pgOption = new HashMap<String, Object>();
//		pgOption.put("description", "Vedagram Purchase Charge For Pooja Offerings!!!");
//		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
//		pgOption.put("currency", "INR");
//		pgOption.put("key", razorpayKey);
//		//pgOption.put("order_id", order.get("id"));
//		pgOption.put("amount", totAmountInPaise);
//		pgOption.put("name", memberName);
//		
//		paymentInitResDto.setDescription("Vedagram Purchase Charge For Pooja Offerings!!!");
//	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
//		paymentInitResDto.setCurrency("INR");
//		paymentInitResDto.setKey(razorpayKey);
//		paymentInitResDto.setAmount(totAmountInPaise + "");
//		paymentInitResDto.setName(memberName);
//		paymentInitResDto.setTheme("#30c58f");
//		paymentInitResDto.setEmail(email);
//		paymentInitResDto.setContact(mobileNumber);
//		paymentInitResDto.setOrderId(orderId);
//		paymentInitResDto.setPgOption(pgOption);
//		
//		return paymentInitResDto;
//	
//	}

	@Override
	public PaymentInitResDto createCartPayRef(String userId) {
		// TODO Auto-generated method stub
		PaymentInitResDto paymentInitResDto = new PaymentInitResDto() ;
    	double totAmountInPaise = 0d;
    	UserModel userModel = new UserModel();
    	userModel.setId(userId);
    	List<UserCartDetails> cartDetailsLst=userCartRepository.findByUserModelIdAndDelFlag(userId, 3);
    	List<String> cartIds=new ArrayList<String>();
    	for(UserCartDetails uIds:cartDetailsLst){
    		cartIds.add(uIds.getId());
    	}
    	Query query1 =new Query(Criteria.where("userCartDetails").in(cartIds));
    	
    	List<VedaCart> vedaCartList=mongoTemplate.find(query1,VedaCart.class);
    	List<UserPurchaseModelForPay> cartPayRefDetailsList = new ArrayList<UserPurchaseModelForPay>();
    	Set<String>errors=new HashSet<>();
    	for(VedaCart vedaCart:vedaCartList){
    		if(vedaCart.getPoojaOfferings().getTemple().getActiveFlag().equals("false")) {
    			errors.add(vedaCart.getPoojaOfferings().getTemple().getName()+" is currently not available!");
    			
    		}
    		
    	}
    	if(errors!=null && !errors.isEmpty()) {
    		paymentInitResDto.setErrors(errors);
    		return paymentInitResDto;	
    	}
    	for(VedaCart vedaCart:vedaCartList){
    		UserPurchaseModelForPay userPurchaseModelForPay=new UserPurchaseModelForPay();
    		userPurchaseModelForPay.setUserModel(userModel);
    		userPurchaseModelForPay.setCreateDate(new Date());
    		userPurchaseModelForPay.setDakshinaAmountForPriest(vedaCart.getUserCartDetails().getDakshinaAmountForPriest());
    		userPurchaseModelForPay.setDakshinaAmountToTemple(vedaCart.getUserCartDetails().getDakshinaAmountToTemple());
    		userPurchaseModelForPay.setDeliveryAddress(vedaCart.getUserCartDetails().getDeliveryAddress());
    		userPurchaseModelForPay.setFirstName(vedaCart.getUserCartDetails().getFirstName());
    		userPurchaseModelForPay.setListOfDates(vedaCart.getUserCartDetails().getListOfDates());
    		userPurchaseModelForPay.setFromDate(vedaCart.getUserCartDetails().getFromDate());
    		userPurchaseModelForPay.setLastModifiedDate(new Date());
    		userPurchaseModelForPay.setLoginUserId(userId);
    		userPurchaseModelForPay.setMailId(vedaCart.getUserCartDetails().getMailId());
    		userPurchaseModelForPay.setMobileNumber(vedaCart.getUserCartDetails().getMobileNumber());
    		userPurchaseModelForPay.setNoOfMonths(vedaCart.getUserCartDetails().getNoOfMonths());
    		userPurchaseModelForPay.setPayDakshinaToPriestFlag(vedaCart.getUserCartDetails().isPayDakshinaToPriestFlag());
    		userPurchaseModelForPay.setPayDakshinaToTempleFlag(vedaCart.getUserCartDetails().isPayDakshinaToTempleFlag());
    		userPurchaseModelForPay.setPaymentStatus("PAY_INIT");
    		userPurchaseModelForPay.setPoojaOfferings(vedaCart.getUserCartDetails().getPoojaOfferings());
    		userPurchaseModelForPay.setPrasadhamDelFlag(vedaCart.getUserCartDetails().isPrasadhamDelFlag());
    		userPurchaseModelForPay.setStar(vedaCart.getUserCartDetails().getStar());
    		userPurchaseModelForPay.setToDate(vedaCart.getUserCartDetails().getToDate());
    		Double totAmt=(double) 0;
    		if(vedaCart.getUserCartDetails().getDakshinaAmountForPriest()!=null){
				totAmt+=vedaCart.getUserCartDetails().getDakshinaAmountForPriest();
				totAmountInPaise+=vedaCart.getUserCartDetails().getDakshinaAmountForPriest() * 100;
			}
			 if(vedaCart.getUserCartDetails().getDakshinaAmountToTemple()!=null){
				 totAmt+=vedaCart.getUserCartDetails().getDakshinaAmountToTemple();
				 totAmountInPaise+=vedaCart.getUserCartDetails().getDakshinaAmountToTemple() * 100;
			}
			if(vedaCart.getUserCartDetails().isPrasadhamDelFlag()){
					userPurchaseModelForPay.setPdAmt(vedaCart.getUserCartDetails().getPdDelCharge());
					totAmountInPaise+=vedaCart.getUserCartDetails().getPdDelCharge()*100;
			}
			Double itemTotalAmnt = (double) (vedaCart.getUserProductDetails().getBookedQuantity()*vedaCart.getUserCartDetails().getPoojaOfferings().getPrice());
    		totAmountInPaise+=(itemTotalAmnt) * 100;
    		userPurchaseModelForPay.setTotalAmount(itemTotalAmnt);
    		cartPayRefDetailsList.add(userPurchaseModelForPay);
    		
    		
    	}
    	if(totAmountInPaise/100>500000) {
    		paymentInitResDto.setInitResMsg("Amount can not exceed Rs. 5,00,000");
    		return paymentInitResDto;
    	}
    	CartPayRef cartPayRef = new CartPayRef();
    	cartPayRef.setUserModel(userModel);
    	cartPayRef.setTotalTransAmount((totAmountInPaise/100));
    	cartPayRef.setPaymentStatus("PAY_INIT");
    	cartPayRef.setPayDate(new Date());
    	 cartPayRef = cartPayRefRepository.save(cartPayRef);
    	for (UserPurchaseModelForPay cartPayRefDetails : cartPayRefDetailsList) {
		
		cartPayRefDetails.setCartPayRef(cartPayRef);
	}
    	List<UserPurchaseModelForPay> userPurchaseModelForPayLst=userPurchaseModelForPayRepository.insert(cartPayRefDetailsList);
    	//mongoTemplate.insert(cartPayRefDetailsList);
    	
    	Order order = null;
    	try {
    		JSONObject orderRequest = new JSONObject();
    		orderRequest.put("amount", totAmountInPaise);
    		orderRequest.put("currency", "INR");
    		orderRequest.put("receipt", cartPayRef.getId());

    		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
    		order = razorpayClient.Orders.create(orderRequest);
		} catch (RazorpayException e) {
			paymentInitResDto.setInitResMsg(e.getMessage());
		} catch (JSONException e) {
			e.printStackTrace();
		}
    	
    	if(order == null) {
    		paymentInitResDto.setInitResMsg("Amount Incorrect");
			return paymentInitResDto;
    	}
    	String orderId="";
		for (UserPurchaseModelForPay userPurchaseModelForPay : userPurchaseModelForPayLst) {
			Query query = new Query(Criteria.where("_id").is(userPurchaseModelForPay.getId()));
			Update update = new Update().set("orderId",  order.get("id"));
			mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
		}
		
		UserModel loginMem = utility.getUser();
		String memberName = "";
		if(loginMem != null) {
			if(loginMem.getFirstName() != null) {
				memberName = loginMem.getFirstName();
			}
			
			if(loginMem.getLastName() != null) {
				if(!memberName.trim().isEmpty()) {
					memberName += " ";
				}
				memberName += loginMem.getLastName();
			}
		}
		
		String email = loginMem.getEmail() == null ? "" : loginMem.getEmail();
		String mobileNumber = loginMem.getMobileNumber();
		
		Map<String, Object> pgOption = new HashMap<String, Object>();
		pgOption.put("description", "Vedagram Purchase Charge For Pooja Offerings!!!");
		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
		pgOption.put("currency", "INR");
		pgOption.put("key", razorpayKey);
		pgOption.put("order_id", order.get("id"));
		pgOption.put("amount", totAmountInPaise);
		pgOption.put("name", memberName);
		
		paymentInitResDto.setDescription("Vedagram Purchase Charge For Pooja Offerings!!!");
	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
		paymentInitResDto.setCurrency("INR");
		paymentInitResDto.setKey(razorpayKey);
		paymentInitResDto.setAmount(totAmountInPaise + "");
		paymentInitResDto.setName(memberName);
		paymentInitResDto.setTheme("#30c58f");
		paymentInitResDto.setEmail(email);
		paymentInitResDto.setContact(mobileNumber);
		paymentInitResDto.setOrderId(order.get("id"));
		paymentInitResDto.setPgOption(pgOption);
		paymentInitResDto.setCartPayRefId(cartPayRef.getId());
		return paymentInitResDto;
	}
	@Override
	public PaymentInitResDto payInitOffering(VedaCartDto vedaCartDto ,String userId) {
		// TODO Auto-generated method stub
		PaymentInitResDto paymentInitResDto = new PaymentInitResDto() ;
		UserModel userModel=new UserModel();
		PoojaOfferings poojaOfferings= new PoojaOfferings();
		UserCartDetails userCartDetails = new UserCartDetails();
		userModel.setId(userId);
		poojaOfferings.setId(vedaCartDto.getPoojaOfferings().getId());
		userCartDetails.setUserModel(userModel);
		userCartDetails.setPoojaOfferings(poojaOfferings);		
		userCartDetails.setStar(vedaCartDto.getStar());
		userCartDetails.setFirstName(vedaCartDto.getFirstName());
		userCartDetails.setMailId(vedaCartDto.getMailId());
		userCartDetails.setMobileNumber(vedaCartDto.getMobileNumber());
		userCartDetails.setDeliveryAddress(vedaCartDto.getDeliveryAddress());
		userCartDetails.setPrasadhamDelFlag(vedaCartDto.isPrasadhamDelFlag());
		userCartDetails.setFromDate(vedaCartDto.getFromDate());
		userCartDetails.setToDate(vedaCartDto.getToDate());
		userCartDetails.setNoOfMonths(vedaCartDto.getNoOfMonths());
		userCartDetails.setPayDakshinaToPriestFlag(vedaCartDto.isPayDakshinaToPriestFlag());
		userCartDetails.setDakshinaAmountForPriest(vedaCartDto.getDakshinaAmountForPriest());
		userCartDetails.setPayDakshinaToTempleFlag(vedaCartDto.isPayDakshinaToTempleFlag());
		userCartDetails.setDakshinaAmountToTemple(vedaCartDto.getDakshinaAmountToTemple());
		userCartDetails.setDelFlag(2);
		StringBuilder sb1 = new StringBuilder();
		String separator = "||";
		if(vedaCartDto.getListOfDates()!=null){
		for(String d:vedaCartDto.getListOfDates()){
			
			sb1.append(d).append(separator);
		}
		userCartDetails.setListOfDates(sb1.toString());
		}
		userCartRepository.save(userCartDetails);
		
    	double totAmountInPaise = 0d;
    	userModel.setId(userId);
   
    		UserPurchaseModelForPay userPurchaseModelForPay=new UserPurchaseModelForPay();
    		userPurchaseModelForPay.setUserModel(userModel);
    		userPurchaseModelForPay.setCreateDate(new Date());
    		userPurchaseModelForPay.setDakshinaAmountForPriest(vedaCartDto.getDakshinaAmountForPriest());
    		userPurchaseModelForPay.setDakshinaAmountToTemple(vedaCartDto.getDakshinaAmountToTemple());
    		userPurchaseModelForPay.setDeliveryAddress(vedaCartDto.getDeliveryAddress());
    		userPurchaseModelForPay.setFirstName(vedaCartDto.getFirstName());
    		if(vedaCartDto.getListOfDates()!=null){
    		userPurchaseModelForPay.setListOfDates(sb1.toString());
    		}
    		userPurchaseModelForPay.setFromDate(vedaCartDto.getFromDate());
    		userPurchaseModelForPay.setLastModifiedDate(new Date());
    		userPurchaseModelForPay.setLoginUserId(userId);
    		userPurchaseModelForPay.setMailId(vedaCartDto.getMailId());
    		userPurchaseModelForPay.setMobileNumber(vedaCartDto.getMobileNumber());
    		userPurchaseModelForPay.setNoOfMonths(vedaCartDto.getNoOfMonths());
    		userPurchaseModelForPay.setPayDakshinaToPriestFlag(vedaCartDto.isPayDakshinaToPriestFlag());
    		userPurchaseModelForPay.setPayDakshinaToTempleFlag(vedaCartDto.isPayDakshinaToTempleFlag());
    		userPurchaseModelForPay.setPaymentStatus("PAY_INIT");
    		userPurchaseModelForPay.setPoojaOfferings(vedaCartDto.getPoojaOfferings());
    		userPurchaseModelForPay.setPrasadhamDelFlag(vedaCartDto.isPrasadhamDelFlag());
    		userPurchaseModelForPay.setStar(vedaCartDto.getStar());
    		userPurchaseModelForPay.setToDate(vedaCartDto.getToDate());
    		Double totAmt=(double) 0;
    		if(vedaCartDto.getDakshinaAmountForPriest()!=null){
				totAmt+=vedaCartDto.getDakshinaAmountForPriest();
				totAmountInPaise+=vedaCartDto.getDakshinaAmountForPriest() * 100;
			}
			 if(vedaCartDto.getDakshinaAmountToTemple()!=null){
				 totAmt+=vedaCartDto.getDakshinaAmountToTemple();
				 totAmountInPaise+=vedaCartDto.getDakshinaAmountToTemple() * 100;
			}
			if(vedaCartDto.isPrasadhamDelFlag()){
					userPurchaseModelForPay.setPdAmt(vedaCartDto.getPdDelCharge());
					totAmountInPaise+=vedaCartDto.getPdDelCharge()*100;
			}
			int bookdQuantity=0;
			if(vedaCartDto.getFromDate()!=null && vedaCartDto.getToDate()!=null ){
				long diff = vedaCartDto.getToDate().getTime() - vedaCartDto.getFromDate().getTime();
				long diffDays = diff / (24 * 60 * 60 * 1000);
				
				bookdQuantity+=diffDays+1;
				
			}
			else if(vedaCartDto.getNoOfMonths()!=null){
				LocalDate today =  LocalDate.now().plusDays(1);    
				LocalDate futureDate=today.plusMonths(vedaCartDto.getNoOfMonths());
				bookdQuantity+=today.until(futureDate,ChronoUnit.DAYS);

			}
			else if(vedaCartDto.getListOfDates()!=null && vedaCartDto.getListOfDates().size()>0 ){
				bookdQuantity+=vedaCartDto.getListOfDates().size();
			}
			Double itemTotalAmnt = (double) (bookdQuantity*vedaCartDto.getPoojaOfferings().getPrice());
    		totAmountInPaise+=(itemTotalAmnt) * 100;
    		userPurchaseModelForPay.setTotalAmount(itemTotalAmnt);
    		userPurchaseModelForPay.setTotalPaidAmount(vedaCartDto.getTotalPaidAmount());
    		
    	
    	CartPayRef cartPayRef = new CartPayRef();
    	cartPayRef.setUserModel(userModel);
    	cartPayRef.setTotalTransAmount((totAmountInPaise/100));
    	cartPayRef.setPaymentStatus("PAY_INIT");
    	cartPayRef.setPayDate(new Date());
    	 cartPayRef = cartPayRefRepository.save(cartPayRef);
    	 userPurchaseModelForPay.setCartPayRef(cartPayRef);
    	 userPurchaseModelForPay=userPurchaseModelForPayRepository.insert(userPurchaseModelForPay);
    	//mongoTemplate.insert(cartPayRefDetailsList);
    	
    	Order order = null;
    	try {
    		JSONObject orderRequest = new JSONObject();
    		orderRequest.put("amount", totAmountInPaise);
    		orderRequest.put("currency", "INR");
    		orderRequest.put("receipt", cartPayRef.getId());

    		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
    		order = razorpayClient.Orders.create(orderRequest);
		} catch (RazorpayException e) {
			paymentInitResDto.setInitResMsg(e.getMessage());
		} catch (JSONException e) {
			e.printStackTrace();
		}
    	
    	if(order == null) {
    		paymentInitResDto.setInitResMsg("Amount Incorrect");
			return paymentInitResDto;
    	}
			Query query = new Query(Criteria.where("_id").is(userPurchaseModelForPay.getId()));
			Update update = new Update().set("orderId",  order.get("id"));
			mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
		
		UserModel loginMem = utility.getUser();
		String memberName = "";
		if(loginMem != null) {
			if(loginMem.getFirstName() != null) {
				memberName = loginMem.getFirstName();
			}
			
			if(loginMem.getLastName() != null) {
				if(!memberName.trim().isEmpty()) {
					memberName += " ";
				}
				memberName += loginMem.getLastName();
			}
		}
		
		String email = loginMem.getEmail() == null ? "" : loginMem.getEmail();
		String mobileNumber = loginMem.getMobileNumber();
		
		Map<String, Object> pgOption = new HashMap<String, Object>();
		pgOption.put("description", "Vedagram Purchase Charge For Pooja Offerings!!!");
		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
		pgOption.put("currency", "INR");
		pgOption.put("key", razorpayKey);
		pgOption.put("order_id", order.get("id"));
		pgOption.put("amount", totAmountInPaise);
		pgOption.put("name", memberName);
		
		paymentInitResDto.setDescription("Vedagram Purchase Charge For Pooja Offerings!!!");
	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
		paymentInitResDto.setCurrency("INR");
		paymentInitResDto.setKey(razorpayKey);
		paymentInitResDto.setAmount(totAmountInPaise + "");
		paymentInitResDto.setName(memberName);
		paymentInitResDto.setTheme("#30c58f");
		paymentInitResDto.setEmail(email);
		paymentInitResDto.setContact(mobileNumber);
		paymentInitResDto.setOrderId(order.get("id"));
		paymentInitResDto.setPgOption(pgOption);
		paymentInitResDto.setCartPayRefId(cartPayRef.getId());
	    
    	return paymentInitResDto;
	}
	@Override
	public PaymentInitResDto createCartPayRefForPoojaMaterials(MaterialPurchaseDto materialPurchaseDto) {
		// TODO Auto-generated method stub
		List<UserPurchaseModelForPay> cartPayRefDetailsList = new ArrayList<UserPurchaseModelForPay>();
		PaymentInitResDto paymentInitResDto = new PaymentInitResDto() ;
		UserModel userModel = new UserModel();
		userModel.setId(utility.getUserId());
		double totAmountInPaise = 0d;
		if(materialPurchaseDto.getDakshinaAmountForPriest()!=null){
			totAmountInPaise+=materialPurchaseDto.getDakshinaAmountForPriest() * 100;
		}
		 if(materialPurchaseDto.getDakshinaAmountToTemple()!=null){
			 totAmountInPaise+=materialPurchaseDto.getDakshinaAmountToTemple() * 100;
		}
		double noOfDates=materialPurchaseDto.getListOfdates().size();
		
    	Set<String>errors=new HashSet<>();
		for(MaterialDeityDto poojaMaterialDto:materialPurchaseDto.getMaterialDeityDto()){
		String error=null;
		Query query = new Query(Criteria.where("id").is(poojaMaterialDto.getMaterialId()));
		PoojaMaterial poojaMaterial = mongoTemplate.findOne(query,PoojaMaterial.class);
		 if(poojaMaterial.getActiveflag().equals("false")) {
			error=poojaMaterial.getProductName()+" Currently not available";
		}
		 else if(poojaMaterial.getMaterialStock()==0) {
			error="No stocks available for "+poojaMaterial.getProductName();
		}
		else if(poojaMaterial.getMaterialStock()<(poojaMaterialDto.getQuantity()*materialPurchaseDto.getListOfdates().size())) {
			error="Only "+poojaMaterial.getMaterialStock()+" stocks available for "+poojaMaterial.getProductName();
		}
		
		if(error!=null) {
			errors.add(error);
			paymentInitResDto.setErrors(errors);
			return paymentInitResDto;
		}
		}
		for(MaterialDeityDto materialDeityDto:materialPurchaseDto.getMaterialDeityDto()){
			UserPurchaseModelForPay userPurchaseModelForPay=new UserPurchaseModelForPay();
			userPurchaseModelForPay.setUserModel(userModel);
			userPurchaseModelForPay.setCreateDate(new Date());
			userPurchaseModelForPay.setPayDakshinaToPriestFlag(materialPurchaseDto.isPayDakshinaToPriestFlag());
			userPurchaseModelForPay.setPayDakshinaToTempleFlag(materialPurchaseDto.isPayDakshinaToTempleFlag());
			userPurchaseModelForPay.setDakshinaAmountForPriest(materialPurchaseDto.getDakshinaAmountForPriest());
			userPurchaseModelForPay.setDakshinaAmountToTemple(materialPurchaseDto.getDakshinaAmountToTemple());
			userPurchaseModelForPay.setFirstName(materialPurchaseDto.getName());
			userPurchaseModelForPay.setMobileNumber(utility.getMobileNumber());
			userPurchaseModelForPay.setStar(materialPurchaseDto.getStar());
			StringBuilder sb1 = new StringBuilder();
			String separator = "||";
			if(materialPurchaseDto.getListOfdates()!=null){
			for(String d:materialPurchaseDto.getListOfdates()){
				
				sb1.append(d).append(separator);
			}
			userPurchaseModelForPay.setListOfDates(sb1.toString());
			}
			userPurchaseModelForPay.setCreateDate(new Date());
			userPurchaseModelForPay.setLastModifiedDate(new Date());
			userPurchaseModelForPay.setLoginUserId(utility.getUserId());
			userPurchaseModelForPay.setPaymentStatus("PAY_INIT");
			Deity deity = new Deity();
			deity.setId(materialDeityDto.getDeityId());
			Temples temples = new Temples();
			temples.setId(materialPurchaseDto.getTempleId());
			userPurchaseModelForPay.setTemples(temples);
			userPurchaseModelForPay.setDeity(deity);
			PoojaMaterial poojaMaterial =new PoojaMaterial();
			poojaMaterial.setId(materialDeityDto.getMaterialId());
			userPurchaseModelForPay.setId(null);
			userPurchaseModelForPay.setPoojaMaterial(null);
			userPurchaseModelForPay.setPoojaMaterial(poojaMaterial);
			userPurchaseModelForPay.setQuantity(materialDeityDto.getQuantity());
			if(materialDeityDto.getPdDelCharge()!=null){
				totAmountInPaise+=materialDeityDto.getPdDelCharge()*100;
				userPurchaseModelForPay.setPdAmt(materialDeityDto.getPdDelCharge());
			}
			Double itemTotalAmnt = (double) (materialDeityDto.getQuantity()* noOfDates* materialDeityDto.getPrice());
			totAmountInPaise+= itemTotalAmnt * 100;
			userPurchaseModelForPay.setTotalAmount(itemTotalAmnt);
			cartPayRefDetailsList.add(userPurchaseModelForPay);
		}
		CartPayRef cartPayRef = new CartPayRef();
    	cartPayRef.setUserModel(userModel);
    	cartPayRef.setTotalTransAmount((totAmountInPaise/100));
    	cartPayRef.setPaymentStatus("PAY_INIT");
    	cartPayRef.setPayDate(new Date());
    	 cartPayRef = cartPayRefRepository.save(cartPayRef);
    		for (UserPurchaseModelForPay cartPayRefDetails : cartPayRefDetailsList) {
    			cartPayRefDetails.setCartPayRef(cartPayRef);
    	}
    		List<UserPurchaseModelForPay> userPurchaseModelForPayLst=userPurchaseModelForPayRepository.insert(cartPayRefDetailsList);
        	//mongoTemplate.insert(cartPayRefDetailsList);
        	
        	Order order = null;
        	try {
        		JSONObject orderRequest = new JSONObject();
        		orderRequest.put("amount", totAmountInPaise);
        		orderRequest.put("currency", "INR");
        		orderRequest.put("receipt", cartPayRef.getId());

        		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
        		order = razorpayClient.Orders.create(orderRequest);
    		} catch (RazorpayException e) {
    			paymentInitResDto.setInitResMsg(e.getMessage());
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}
        	
        	if(order == null) {
        		paymentInitResDto.setInitResMsg("Amount Incorrect");
    			return paymentInitResDto;
        	}
        	String orderId="";
    		for (UserPurchaseModelForPay userPurchaseModelForPay1 : userPurchaseModelForPayLst) {
    			Query query = new Query(Criteria.where("_id").is(userPurchaseModelForPay1.getId()));
    			Update update = new Update().set("orderId",  order.get("id"));
    			mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
    		}
    		
    		UserModel loginMem = utility.getUser();
    		String memberName = "";
    		if(loginMem != null) {
    			if(loginMem.getFirstName() != null) {
    				memberName = loginMem.getFirstName();
    			}
    			
    			if(loginMem.getLastName() != null) {
    				if(!memberName.trim().isEmpty()) {
    					memberName += " ";
    				}
    				memberName += loginMem.getLastName();
    			}
    		}
    		
    		String email = loginMem.getEmail() == null ? "" : loginMem.getEmail();
    		String mobileNumber = loginMem.getMobileNumber();
    		
    		Map<String, Object> pgOption = new HashMap<String, Object>();
    		pgOption.put("description", "Vedagram Purchase Charge For Pooja Materials!!!");
    		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
    		pgOption.put("currency", "INR");
    		pgOption.put("key", razorpayKey);
    		pgOption.put("order_id", order.get("id"));
    		pgOption.put("amount", totAmountInPaise);
    		pgOption.put("name", memberName);
    		
    		paymentInitResDto.setDescription("Vedagram Purchase Charge For Pooja Materials!!!");
    	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
    		paymentInitResDto.setCurrency("INR");
    		paymentInitResDto.setKey(razorpayKey);
    		paymentInitResDto.setAmount(totAmountInPaise + "");
    		paymentInitResDto.setName(memberName);
    		paymentInitResDto.setTheme("#30c58f");
    		paymentInitResDto.setEmail(email);
    		paymentInitResDto.setContact(mobileNumber);
    		paymentInitResDto.setOrderId(order.get("id"));
    		paymentInitResDto.setPgOption(pgOption);
    		paymentInitResDto.setCartPayRefId(cartPayRef.getId());
    		return paymentInitResDto;
	}

	@Override
	public PaymentInitResDto createCartPayRefForGrammerce(GrammercePurchaseDto grammercePurchaseDtoDto) {
		// TODO Auto-generated method stub
		double totAmountInPaise = 0d;
		PaymentInitResDto paymentInitResDto = new PaymentInitResDto() ;
		List<UserPurchaseModelForPay> cartPayRefDetailsList = new ArrayList<UserPurchaseModelForPay>();
		UserModel userModel = new UserModel();
		userModel.setId(utility.getUserId());
    	Set<String>errors=new HashSet<>();
		for(GrammerceDto grammercedto:grammercePurchaseDtoDto.getListOfGrammerceDto()){
			String error=null;
			Query query = new Query(Criteria.where("id").is(grammercedto.getId()));
			Grammerce grammerce = mongoTemplate.findOne(query,Grammerce.class);
			
			if(grammerce.getActiveFlag().equals("false")) {
				error=grammerce.getProductName()+" Currently not available";
			}
			else if(grammerce.getStock()==0) {
				error="No stocks available for "+grammerce.getProductName();
			}
			else if(grammerce.getStock()<grammercedto.getStock()) {
				error="Only "+grammerce.getStock()+" stocks available for "+grammerce.getProductName();
			}
			
			if(error!=null) {
				errors.add(error);
				paymentInitResDto.setErrors(errors);
				return paymentInitResDto;
			}
			
		}
		for(GrammerceDto grammercedto:grammercePurchaseDtoDto.getListOfGrammerceDto())
		{
			UserPurchaseModelForPay userPurchaseModelForPay=new UserPurchaseModelForPay();
			userPurchaseModelForPay.setUserModel(userModel);
			userPurchaseModelForPay.setPaymentStatus("PAY_INIT");
			userPurchaseModelForPay.setCreateDate(new Date());
			userPurchaseModelForPay.setFirstName(grammercePurchaseDtoDto.getName());
			userPurchaseModelForPay.setMailId(grammercePurchaseDtoDto.getEmailId());
			userPurchaseModelForPay.setMobileNumber(grammercePurchaseDtoDto.getContactNumber());
			userPurchaseModelForPay.setDeliveryAddress(grammercePurchaseDtoDto.getDeliveryAddress());
			if(grammercePurchaseDtoDto.isGiftFlag()) {
				userPurchaseModelForPay.setGiftFlag(grammercePurchaseDtoDto.isGiftFlag());
				userPurchaseModelForPay.setGiftNote(grammercePurchaseDtoDto.getGiftNote());
				userPurchaseModelForPay.setGiftedBy(grammercePurchaseDtoDto.getGiftedBY());
			}
			Grammerce grammerce=new Grammerce();
			BeanUtils.copyProperties(grammercedto, grammerce);
			
			if(grammercedto.getPdDelCharge()!=null){
				totAmountInPaise+=grammercedto.getPdDelCharge()*100;
				userPurchaseModelForPay.setPdAmt(grammercedto.getPdDelCharge());
			}
			Double itemTotalAmnt = (double) (grammercedto.getQuantity() * grammercedto.getPrice());
			totAmountInPaise+= itemTotalAmnt * 100;
			
			userPurchaseModelForPay.setQuantity(grammercedto.getQuantity());
			userPurchaseModelForPay.setId(null);
			userPurchaseModelForPay.setGrammerce(null);
			userPurchaseModelForPay.setGrammerce(grammerce);
			userPurchaseModelForPay.setTotalAmount(itemTotalAmnt);
			
			Calendar calendar = Calendar.getInstance();
	        calendar.setTime(new Date());
	        calendar.add(Calendar.DAY_OF_YEAR, grammerce.getDeliveryLeadTime());
	        Date expectedDate = calendar.getTime();
			
			userPurchaseModelForPay.setExpDeliveryDate(expectedDate);
			cartPayRefDetailsList.add(userPurchaseModelForPay);
		}
		
		CartPayRef cartPayRef = new CartPayRef();
    	cartPayRef.setUserModel(userModel);
    	cartPayRef.setTotalTransAmount((totAmountInPaise/100));
    	cartPayRef.setPaymentStatus("PAY_INIT");
    	cartPayRef.setPayDate(new Date());
    	 cartPayRef = cartPayRefRepository.save(cartPayRef);
    		for (UserPurchaseModelForPay cartPayRefDetails : cartPayRefDetailsList) {
    			cartPayRefDetails.setCartPayRef(cartPayRef);
    	}
    		List<UserPurchaseModelForPay> userPurchaseModelForPayLst=userPurchaseModelForPayRepository.insert(cartPayRefDetailsList);
        	//mongoTemplate.insert(cartPayRefDetailsList);
        	
        	Order order = null;
        	try {
        		JSONObject orderRequest = new JSONObject();
        		orderRequest.put("amount", totAmountInPaise);
        		orderRequest.put("currency", "INR");
        		orderRequest.put("receipt", cartPayRef.getId());

        		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
        		order = razorpayClient.Orders.create(orderRequest);
    		} catch (RazorpayException e) {
    			paymentInitResDto.setInitResMsg(e.getMessage());
    		} catch (JSONException e) {
    			e.printStackTrace();
    		}
        	
        	if(order == null) {
        		paymentInitResDto.setInitResMsg("Amount Incorrect");
    			return paymentInitResDto;
        	}
        	String orderId="";
    		for (UserPurchaseModelForPay userPurchaseModelForPay1 : userPurchaseModelForPayLst) {
    			Query query = new Query(Criteria.where("_id").is(userPurchaseModelForPay1.getId()));
    			Update update = new Update().set("orderId", order.get("id"));
    			mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
    		}
    		
    		UserModel loginMem = utility.getUser();
    		String memberName = "";
    		if(loginMem != null) {
    			if(loginMem.getFirstName() != null) {
    				memberName = loginMem.getFirstName();
    			}
    			
    			if(loginMem.getLastName() != null) {
    				if(!memberName.trim().isEmpty()) {
    					memberName += " ";
    				}
    				memberName += loginMem.getLastName();
    			}
    		}
    		
    		String email = loginMem.getEmail() == null ? "" : loginMem.getEmail();
    		String mobileNumber = loginMem.getMobileNumber();
    		
    		Map<String, Object> pgOption = new HashMap<String, Object>();
    		pgOption.put("description", "Vedagram Purchase Charge For Pooja Materials!!!");
    		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
    		pgOption.put("currency", "INR");
    		pgOption.put("key", razorpayKey);
    		pgOption.put("order_id", order.get("id"));
    		pgOption.put("amount", totAmountInPaise);
    		pgOption.put("name", memberName);
    		
    		paymentInitResDto.setDescription("Vedagram Purchase Charge For Pooja Materials!!!");
    	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
    		paymentInitResDto.setCurrency("INR");
    		paymentInitResDto.setKey(razorpayKey);
    		paymentInitResDto.setAmount(totAmountInPaise + "");
    		paymentInitResDto.setName(memberName);
    		paymentInitResDto.setTheme("#30c58f");
    		paymentInitResDto.setEmail(email);
    		paymentInitResDto.setContact(mobileNumber);
    		paymentInitResDto.setOrderId(order.get("id"));
    		paymentInitResDto.setPgOption(pgOption);
    		paymentInitResDto.setCartPayRefId(cartPayRef.getId());
    		return paymentInitResDto;
	}

	@Override
	public PaymentInitResDto createCartPayRefForDonation(DonationOrders donationOrders) {
		// TODO Auto-generated method stub
		PaymentInitResDto paymentInitResDto = new PaymentInitResDto() ;
		double totAmountInPaise =donationOrders.getContributionAmount()*100;
		donationOrders.setDonationDate(new Date());
		UserPurchaseModelForPay cartPayRefDetails=new UserPurchaseModelForPay();
		cartPayRefDetails.setCreateDate(new Date());
		cartPayRefDetails.setFirstName(donationOrders.getDonorName());
		cartPayRefDetails.setDeliveryAddress(donationOrders.getAddress());
		cartPayRefDetails.setMailId(donationOrders.getEmailId());
		cartPayRefDetails.setMobileNumber(donationOrders.getContactNumber());
		if(donationOrders.getUserModel()!=null && donationOrders.getUserModel().getId()!=null) {
			cartPayRefDetails.setUserModel(donationOrders.getUserModel());
		}
		cartPayRefDetails.setRemarks(donationOrders.getRemarks());
		cartPayRefDetails.setPurpose(donationOrders.getPurpose());
		cartPayRefDetails.setContributionAmount(donationOrders.getContributionAmount()*100);
		cartPayRefDetails.setPaymentStatus("PAY_INIT");
		cartPayRefDetails.setRevealFlag(donationOrders.isRevealFlag());
		UserPurchaseModelForPay cartPayRefDetails1=userPurchaseModelForPayRepository.save(cartPayRefDetails);
		Order order = null;
    	try {
    		JSONObject orderRequest = new JSONObject();
    		orderRequest.put("amount", cartPayRefDetails1.getContributionAmount());
    		orderRequest.put("currency", "INR");
    		orderRequest.put("receipt", cartPayRefDetails1.getId());

    		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
    		order = razorpayClient.Orders.create(orderRequest);
		} catch (RazorpayException e) {
			paymentInitResDto.setInitResMsg(e.getMessage());
		} catch (JSONException e) {
			e.printStackTrace();
		}
    	
    	if(order == null) {
    		paymentInitResDto.setInitResMsg("Amount Incorrect");
			return paymentInitResDto;
    	}
    	String orderId="";
    	
    	Query query = new Query(Criteria.where("_id").is(cartPayRefDetails1.getId()));
		Update update = new Update().set("orderId",  order.get("id"));
		mongoTemplate.findAndModify(query, update, UserPurchaseModelForPay.class);
		UserModel loginMem=null;
	    if(donationOrders.getUserModel().getId()!=null && !donationOrders.getUserModel().getId().isEmpty()) {
	    	Query query2 = new Query(Criteria.where("id").is(donationOrders.getUserModel().getId()));
	    	loginMem = mongoTemplate.findOne(query2,UserModel.class);
	    }
		
		String memberName = "";
		if(loginMem != null) {
		
			if(loginMem.getFirstName() != null) {
				memberName = loginMem.getFirstName();
			}
			
			if(loginMem.getLastName() != null) {
				if(!memberName.trim().isEmpty()) {
					memberName += " ";
				}
				memberName += loginMem.getLastName();
			}
		}
		String email ="";
		String mobileNumber="";
		if(loginMem!=null) {
		 email = loginMem.getEmail();
		 mobileNumber = loginMem.getMobileNumber();
		}
		Map<String, Object> pgOption = new HashMap<String, Object>();
		pgOption.put("description", "Vedagram Purchase Charge For Donation!!!");
		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
		pgOption.put("currency", "INR");
		pgOption.put("key", razorpayKey);
		pgOption.put("order_id", order.get("id"));
		pgOption.put("amount", totAmountInPaise);
		pgOption.put("name", memberName);
		
		paymentInitResDto.setDescription("Vedagram Purchase Charge For Donation!!!");
	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
		paymentInitResDto.setCurrency("INR");
		paymentInitResDto.setKey(razorpayKey);
		paymentInitResDto.setAmount(totAmountInPaise + "");
		paymentInitResDto.setName(memberName);
		paymentInitResDto.setTheme("#30c58f");
		paymentInitResDto.setEmail(email);
		paymentInitResDto.setContact(mobileNumber);
		paymentInitResDto.setOrderId(order.get("id"));
		paymentInitResDto.setPgOption(pgOption);
		paymentInitResDto.setCartPayRefId(cartPayRefDetails.getId());
		return paymentInitResDto;
	}

	@Override
	public PaymentInitResDto createCartPayRefForProjectDonation(ProjectDonation projectDonation) {
		// TODO Auto-generated method stub
		PaymentInitResDto paymentInitResDto = new PaymentInitResDto() ;
		Query query = new Query(Criteria.where("id").is(projectDonation.getProjectModel().getId()));
		ProjectModel projectModel= mongoTemplate.findOne(query, ProjectModel.class);	
    	Set<String>errors=new HashSet<>();
		if(projectModel!=null) {
		if(projectModel.getProjectStatus().equals(GeneralConstants.PROJECT_STATUS_PENDING)) {
			errors.add(projectModel.getProjectTitle()+" is Currently not available!");
			paymentInitResDto.setErrors(errors);
			return paymentInitResDto;
		}
		}
		double totAmountInPaise =projectDonation.getContributionAmount()*100;
		UserPurchaseModelForPay cartPayRefDetails=new UserPurchaseModelForPay();
		cartPayRefDetails.setFirstName(projectDonation.getDonorName());
		cartPayRefDetails.setDeliveryAddress(projectDonation.getAddress());
		cartPayRefDetails.setMailId(projectDonation.getEmailId());
		cartPayRefDetails.setMobileNumber(projectDonation.getContactNumber());
		cartPayRefDetails.setUserModel(null);
		if(projectDonation.getUserModel()!=null && projectDonation.getUserModel().getId()!=null) {
			cartPayRefDetails.setUserModel(projectDonation.getUserModel());
		}
		cartPayRefDetails.setRemarks(projectDonation.getRemarks());
		cartPayRefDetails.setContributionAmount(projectDonation.getContributionAmount()*100);
		cartPayRefDetails.setProjectModel(projectDonation.getProjectModel());
		cartPayRefDetails.setPaymentStatus("PAY_INIT");
		cartPayRefDetails=userPurchaseModelForPayRepository.insert(cartPayRefDetails);
		Order order = null;
    	try {
    		JSONObject orderRequest = new JSONObject();
    		orderRequest.put("amount", cartPayRefDetails.getContributionAmount());
    		orderRequest.put("currency", "INR");
    		orderRequest.put("receipt", cartPayRefDetails.getId());

    		RazorpayClient razorpayClient = new RazorpayClient(razorpayKey, razorpaySecretKey);
    		order = razorpayClient.Orders.create(orderRequest);
		} catch (RazorpayException e) {
			paymentInitResDto.setInitResMsg(e.getMessage());
		} catch (JSONException e) {
			e.printStackTrace();
		}
    	
    	if(order == null) {
    		paymentInitResDto.setInitResMsg("Amount Incorrect");
			return paymentInitResDto;
    	}
    	String orderId="";
    	
    	Query query1 = new Query(Criteria.where("_id").is(cartPayRefDetails.getId()));
		Update update = new Update().set("orderId",  order.get("id"));
		mongoTemplate.findAndModify(query1, update, UserPurchaseModelForPay.class);
		UserModel loginMem=null;
		if(projectDonation.getUserModel().getId()!=null && !projectDonation.getUserModel().getId().isEmpty()) {
		Query query2 = new Query(Criteria.where("id").is(projectDonation.getUserModel().getId()));
		 	loginMem= mongoTemplate.findOne(query2, UserModel.class);
		}
		String memberName = "";
		if(loginMem != null) {
			if(loginMem.getFirstName() != null) {
				memberName = loginMem.getFirstName();
			}
			
			if(loginMem.getLastName() != null) {
				if(!memberName.trim().isEmpty()) {
					memberName += " ";
				}
				memberName += loginMem.getLastName();
			}
		}
		
		String email ="";
		String mobileNumber ="";
		if(loginMem!=null) {
			 email = loginMem.getEmail();
			 mobileNumber = loginMem.getMobileNumber();
			}
		
		Map<String, Object> pgOption = new HashMap<String, Object>();
		pgOption.put("description", "Vedagram Purchase Charge For Project Donation!!!");
		//pgOption.put("image", "https://pickdrop.in/images/pdlogo.png");
		pgOption.put("currency", "INR");
		pgOption.put("key", razorpayKey);
		pgOption.put("order_id", order.get("id"));
		pgOption.put("amount", totAmountInPaise);
		pgOption.put("name", memberName);
		
		paymentInitResDto.setDescription("Vedagram Purchase Charge For Project Donation!!!");
	//	paymentInitResDto.setImage("http://pickdrop.in/images/pdlogo.png");
		paymentInitResDto.setCurrency("INR");
		paymentInitResDto.setKey(razorpayKey);
		paymentInitResDto.setAmount(totAmountInPaise + "");
		paymentInitResDto.setName(memberName);
		paymentInitResDto.setTheme("#30c58f");
		paymentInitResDto.setEmail(email);
		paymentInitResDto.setContact(mobileNumber);
		paymentInitResDto.setOrderId(order.get("id"));
		paymentInitResDto.setPgOption(pgOption);
		paymentInitResDto.setCartPayRefId(cartPayRefDetails.getId());
		return paymentInitResDto;
	}
	
	
	private String httpPost(String url, Map<String, Object> paramMap, String pdToken) {

		if (url == null || url.isEmpty()) {
			return "ERROR: URL NOT EXIST";
		}

		String responseBody = null;
		HttpPost httpPost = null;
		try {
			HttpClient client = HttpClientBuilder.create().build();

			Gson gsonBuilder = new GsonBuilder().create();
			String jsonFromJavaMap = gsonBuilder.toJson(paramMap);

			HttpEntity stringEntity = new StringEntity(jsonFromJavaMap, "UTF-8");

			httpPost = new HttpPost(url);
			httpPost.setEntity(stringEntity);
			httpPost.addHeader(HttpHeaders.CONTENT_TYPE, "application/json");
			httpPost.addHeader("Authorization", "Bearer " + pdToken);

			HttpResponse response = client.execute(httpPost);

			StatusLine statusLine = response.getStatusLine();
			System.out.println("Status : " + statusLine);

			InputStream inputstream = response.getEntity().getContent();
			BufferedReader rd = new BufferedReader(new InputStreamReader(inputstream));
			StringBuilder sb = new StringBuilder();
			String line = null;

			while ((line = rd.readLine()) != null) {
				sb.append(line + "\n");
			}

			responseBody = sb.toString();
			System.out.println(responseBody);
		} catch (Exception e) {
			e.printStackTrace();

			return "ERROR";
		} finally {
			httpPost.releaseConnection();
		}

		return responseBody;
	}
}