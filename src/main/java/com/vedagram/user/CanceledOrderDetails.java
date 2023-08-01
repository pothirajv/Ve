package com.vedagram.user;

import java.time.LocalDate;

import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.admin.adm.Grammerce;
import com.vedagram.domainmodel.UserModel;

@Document(collection ="CanceledOrderDetails")
public class CanceledOrderDetails {
	
	private String id;
	private String refundId;
	private double refundAmount;
	private double cancellationFee;
	private String paymentId;
	private String status;
	private String speedRequested;
	private String entity;
	private String currency;
	private LocalDate createdAt;
	@DBRef
	private UserModel userDetails;
	@DBRef
	private GrammerceOrders grammerceOrders;
	private double returnedDelCharge;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getRefundId() {
		return refundId;
	}
	public void setRefundId(String refundId) {
		this.refundId = refundId;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String getEntity() {
		return entity;
	}
	public void setEntity(String entity) {
		this.entity = entity;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	public String getSpeedRequested() {
		return speedRequested;
	}
	public void setSpeedRequested(String speedRequested) {
		this.speedRequested = speedRequested;
	}
	public LocalDate getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDate createdAt) {
		this.createdAt = createdAt;
	}
	public UserModel getUserDetails() {
		return userDetails;
	}
	public void setUserDetails(UserModel userDetails) {
		this.userDetails = userDetails;
	}
	public GrammerceOrders getGrammerceOrders() {
		return grammerceOrders;
	}
	public void setGrammerceOrders(GrammerceOrders grammerceOrders) {
		this.grammerceOrders = grammerceOrders;
	}
	public double getReturnedDelCharge() {
		return returnedDelCharge;
	}
	public void setReturnedDelCharge(double returnedDelCharge) {
		this.returnedDelCharge = returnedDelCharge;
	}
	public double getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(double refundAmount) {
		this.refundAmount = refundAmount;
	}
	public double getCancellationFee() {
		return cancellationFee;
	}
	public void setCancellationFee(double cancellationFee) {
		this.cancellationFee = cancellationFee;
	}
	

	
	

}
