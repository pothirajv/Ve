package com.vedagram.pddelv;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.user.GrammerceOrders;
import com.vedagram.user.PoojaMaterialOrdersStatus;
import com.vedagram.user.PoojaOfferingOrdersStatus;
import com.vedagram.user.RequestStatusDto;
import com.vedagram.user.RequestStatusMainDto;

@Service
public class PickDropServiceServiceImpl implements PickDropService {
	@Autowired
	MongoTemplate mongoTemplate;

	@Autowired
	Utility utility;
	@Autowired
	private Environment env;
	public static final Logger LOGGER =LoggerFactory.getLogger(PickDropServiceServiceImpl.class);

	@Override
	public PickDropShipmentResDto createDelivery(PickDropShipmentReqDto pickDropShipmentReqDto) {
		String url = env.getProperty("pd_createdelivery");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("weight", pickDropShipmentReqDto.getWeight());
		paramMap.put("parcelType", pickDropShipmentReqDto.getParcelType());
		paramMap.put("packagePickupAddress", pickDropShipmentReqDto.getPackagePickupAddress());
		paramMap.put("recieverAddress", pickDropShipmentReqDto.getRecieverAddress());
		paramMap.put("recieverName", pickDropShipmentReqDto.getRecieverName());
		paramMap.put("recieverContact", pickDropShipmentReqDto.getRecieverContact());
		paramMap.put("orderId", pickDropShipmentReqDto.getOrderId());
		paramMap.put("senderContact", pickDropShipmentReqDto.getSenderContact());
		paramMap.put("merchantName", pickDropShipmentReqDto.getMerchantName());
		paramMap.put("scheduleDt", pickDropShipmentReqDto.getScheduleDt());
		paramMap.put("scheduleTm", pickDropShipmentReqDto.getScheduleTm());

		paramMap.put("codFlag", pickDropShipmentReqDto.isCodFlag());
		paramMap.put("codAmount", pickDropShipmentReqDto.getCodAmount());

		String responseBody = httpPost(url, paramMap, pickDropShipmentReqDto.getPdToken());

		Gson gson = new Gson();
		PickDropShipmentResDto pickDropShipmentResDto = (PickDropShipmentResDto) gson.fromJson(responseBody,
				new TypeToken<PickDropShipmentResDto>() {
				}.getType());

		// {"packageStatus":"OPEN","trackingId":"1000002","traceId":"ff8935abe6c24875827414780c12597e","deliveryCharge":50.0}
//		String status=responseBody.substring((responseBody.lastIndexOf("packageStatus") + 4)).trim();
//		String s1=responseBody.split(":")[1];
//		String s2=s1.split(",")[0];
//		PickDropShipmentResDto pickDropShipmentResDto=new PickDropShipmentResDto();
//		pickDropShipmentResDto.setPackageStatus(s2);
		return pickDropShipmentResDto;
	}

	@Override
	public String getDeliveryStatus(RequestStatusMainDto requestStatusMainDto) {
		String url = env.getProperty("pd_getDeliveryStatus");
        String pdToken=env.getProperty("pickdroptoken");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("requestStatusDtos", requestStatusMainDto.getRequestStatusDtos());
		
		String responseBody = httpPost(url, paramMap,pdToken);
		
		Gson gson = new Gson();
		requestStatusMainDto = (RequestStatusMainDto) gson.fromJson(responseBody,
				new TypeToken<RequestStatusMainDto>() {
				}.getType());
		
		for (RequestStatusDto statusDto : requestStatusMainDto.getRequestStatusDtos()) {
			if(statusDto.getStatus()==null ||statusDto.getStatus().isEmpty() ||statusDto.getStatus().equals("OPEN")||statusDto.getStatus().equals("ASSIGNED")||statusDto.getStatus().equals("RETURN")) {
				continue;
			}
			Query query = new Query(Criteria.where("awbNumber").is(statusDto.getAwbNumber()));
			GrammerceOrders grammerceOrders =mongoTemplate.findOne(query, GrammerceOrders.class);
			
			if(grammerceOrders!=null) {
				String status=grammerceOrders.getStatus();
			if(statusDto.getStatus().equals("PICKEDUP")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_SCHEDULED)) {
				status=GeneralConstants.GRAMMERCE_SHIPPED;
			}
			else if (statusDto.getStatus().equals("DELIVERED")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_SHIPPED) ||grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_SCHEDULED)) {
				status=GeneralConstants.GRAMMERCE_COMPLETED;
			}
			else if (statusDto.getStatus().equals("PICKEDUP")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_RETURNINIT)) {
				status=GeneralConstants.GRAMMERCE_RETURNSHIPPED;
			}
			else if (statusDto.getStatus().equals("DELIVERED")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_RETURNSHIPPED)||grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_RETURNINIT)) {
				status=GeneralConstants.GRAMMERCE_RETURNED;
			}
			else if (statusDto.getStatus().equals("PICKEDUP")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_REPLACEINIT)) {
				status=GeneralConstants.GRAMMERCE_REPLACESHIPPED;
			}
			else if (statusDto.getStatus().equals("DELIVERED")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_REPLACESHIPPED)||grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_REPLACEINIT)) {
				status=GeneralConstants.GRAMMERCE_REPLACERETURNED;
			}
			else if (statusDto.getStatus().equals("PICKEDUP")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_REPLACEADMININIT)) {
				status=GeneralConstants.GRAMMERCE_REPLACEADMINSHIPPED;
			}
			else if (statusDto.getStatus().equals("DELIVERED")&&grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_REPLACEADMINSHIPPED)||grammerceOrders.getStatus().equals(GeneralConstants.GRAMMERCE_REPLACEADMININIT)) {
				status=GeneralConstants.GRAMMERCE_REPLACED;
			}
			Update update = new Update();
			update.set("status",status);
			mongoTemplate.findAndModify(query, update, GrammerceOrders.class);
		
			}						
		}
		for (RequestStatusDto statusDto : requestStatusMainDto.getRequestStatusDtos()) {
			if(statusDto.getStatus()==null ||statusDto.getStatus().isEmpty() ||statusDto.getStatus().equals("OPEN")||statusDto.getStatus().equals("ASSIGNED")||statusDto.getStatus().equals("RETURN")) {
				continue;
			}
			Query query = new Query(Criteria.where("awbNumber").is(statusDto.getAwbNumber()));
			PoojaOfferingOrdersStatus OrdersStatus =mongoTemplate.findOne(query, PoojaOfferingOrdersStatus.class);
			
			if(OrdersStatus!=null) {
				String status=OrdersStatus.getStatus();
				if(statusDto.getStatus().equals("PICKEDUP")&&OrdersStatus.getStatus().equals(GeneralConstants.POOJASTATUS_SCHEDULED)) {
					status="SHIPPED";
				}
				else if(statusDto.getStatus().equals("DELIVERED")&&OrdersStatus.getStatus().equals("SHIPPED") ||OrdersStatus.getStatus().equals(GeneralConstants.POOJASTATUS_SCHEDULED)) {
					status="COMPLETED";
				}
				Update update = new Update();
				update.set("status",status);
				mongoTemplate.findAndModify(query, update,PoojaOfferingOrdersStatus.class);
			}
		}
		for (RequestStatusDto statusDto : requestStatusMainDto.getRequestStatusDtos()) {
			if(statusDto.getStatus()==null ||statusDto.getStatus().isEmpty() ||statusDto.getStatus().equals("OPEN")||statusDto.getStatus().equals("ASSIGNED")||statusDto.getStatus().equals("RETURN")) {
				continue;
			}
			Query query = new Query(Criteria.where("awbNumber").is(statusDto.getAwbNumber()));
			PoojaMaterialOrdersStatus OrdersStatus =mongoTemplate.findOne(query, PoojaMaterialOrdersStatus.class);
			
			if(OrdersStatus!=null) {
				String status=OrdersStatus.getStatus();
				if(statusDto.getStatus().equals("PICKEDUP")&&OrdersStatus.getStatus().equals(GeneralConstants.MATERIALSTATUS_SCHEDULED)) {
					status=GeneralConstants.MATERIALSTATUS_SHIPPED;
				}
				else if(statusDto.getStatus().equals("DELIVERED")&&OrdersStatus.getStatus().equals(GeneralConstants.MATERIALSTATUS_SHIPPED) ||OrdersStatus.getStatus().equals(GeneralConstants.MATERIALSTATUS_SCHEDULED)) {
					status=GeneralConstants.MATERIALSTATUS_COMPLETED;
				}
				Update update = new Update();
				update.set("status",status);
				mongoTemplate.findAndModify(query, update,PoojaMaterialOrdersStatus.class);
			}
		}
		return "Status changed for all orders";
		
		
		
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
