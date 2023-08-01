package com.vedagram.user;

import java.time.LocalDate;

public class CancelOrderDto {
	private String grammerceOrdId;
	private int totalPaidAmount;
	private String id;
	private String refundId;
	private String refundAmount;
	private String paymentId;
	private String status;
	private String speedRequested;
	private String entity;
	private String currency;
	private LocalDate createdAt;
	private String scheduleDate;
	private String scheduleTime;
	private String cancelReason;
	private String returnReason;
	private String replaceReason;
	
	
	public String getGrammerceOrdId() {
		return grammerceOrdId;
	}
	public void setGrammerceOrdId(String grammerceOrdId) {
		this.grammerceOrdId = grammerceOrdId;
	}
	public int getTotalPaidAmount() {
		return totalPaidAmount;
	}
	public void setTotalPaidAmount(int totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}
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
	public String getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(String refundAmount) {
		this.refundAmount = refundAmount;
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
	public String getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getScheduleTime() {
		return scheduleTime;
	}
	public void setScheduleTime(String scheduleTime) {
		this.scheduleTime = scheduleTime;
	}
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	public String getReturnReason() {
		return returnReason;
	}
	public void setReturnReason(String returnReason) {
		this.returnReason = returnReason;
	}
	public String getReplaceReason() {
		return replaceReason;
	}
	public void setReplaceReason(String replaceReason) {
		this.replaceReason = replaceReason;
	}
	

}
