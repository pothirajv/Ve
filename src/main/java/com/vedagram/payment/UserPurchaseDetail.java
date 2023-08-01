package com.vedagram.payment;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;



@Document(collection = "UserPurchaseDetail")
public class UserPurchaseDetail implements java.io.Serializable {

	public String getPoojaOfferingOrderId() {
		return poojaOfferingOrderId;
	}

	public void setPoojaOfferingOrderId(String poojaOfferingOrderId) {
		this.poojaOfferingOrderId = poojaOfferingOrderId;
	}

	private static final long serialVersionUID = 1L;

	@Id
	@Indexed
	private String id;

	@DBRef
	@Indexed
	private UserModel userModel;

	private String userName;
	
	private String trackId;

	private String paymentId;

	private String errorText;

	private String errorNumber;

	private String transResult;

	private String postDate;

	private String transId;

	private String authCode;

	private String transAvr;

	private String referenceNo;

	private String transAmount;

	private String udf1;

	private String udf2;

	private String udf3;

	private String udf4;

	private String udf5;

	private String userPurchaseReqId;

	private boolean successFlg;
	
	private Date createdDate;
	
	private String poojaOfferingOrderId;
	
	private String orderId;
	
	private String signature;
	
	private String multiRequestId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public String getTrackId() {
		return trackId;
	}

	public void setTrackId(String trackId) {
		this.trackId = trackId;
	}

	public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public String getErrorText() {
		return errorText;
	}

	public void setErrorText(String errorText) {
		this.errorText = errorText;
	}

	public String getErrorNumber() {
		return errorNumber;
	}

	public void setErrorNumber(String errorNumber) {
		this.errorNumber = errorNumber;
	}

	public String getTransResult() {
		return transResult;
	}

	public void setTransResult(String transResult) {
		this.transResult = transResult;
	}

	public String getPostDate() {
		return postDate;
	}

	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}

	public String getTransId() {
		return transId;
	}

	public void setTransId(String transId) {
		this.transId = transId;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getTransAvr() {
		return transAvr;
	}

	public void setTransAvr(String transAvr) {
		this.transAvr = transAvr;
	}

	public String getReferenceNo() {
		return referenceNo;
	}

	public void setReferenceNo(String referenceNo) {
		this.referenceNo = referenceNo;
	}

	public String getTransAmount() {
		return transAmount;
	}

	public void setTransAmount(String transAmount) {
		this.transAmount = transAmount;
	}

	public String getUdf1() {
		return udf1;
	}

	public void setUdf1(String udf1) {
		this.udf1 = udf1;
	}

	public String getUdf2() {
		return udf2;
	}

	public void setUdf2(String udf2) {
		this.udf2 = udf2;
	}

	public String getUdf3() {
		return udf3;
	}

	public void setUdf3(String udf3) {
		this.udf3 = udf3;
	}

	public String getUdf4() {
		return udf4;
	}

	public void setUdf4(String udf4) {
		this.udf4 = udf4;
	}

	public String getUdf5() {
		return udf5;
	}

	public void setUdf5(String udf5) {
		this.udf5 = udf5;
	}

	public String getUserPurchaseReqId() {
		return userPurchaseReqId;
	}

	public void setUserPurchaseReqId(String userPurchaseReqId) {
		this.userPurchaseReqId = userPurchaseReqId;
	}

	public boolean isSuccessFlg() {
		return successFlg;
	}

	public void setSuccessFlg(boolean successFlg) {
		this.successFlg = successFlg;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMultiRequestId() {
		return multiRequestId;
	}

	public void setMultiRequestId(String multiRequestId) {
		this.multiRequestId = multiRequestId;
	}

}
