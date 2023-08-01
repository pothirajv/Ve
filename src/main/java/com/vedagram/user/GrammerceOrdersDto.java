package com.vedagram.user;

import java.util.Date;

import com.vedagram.admin.adm.Grammerce;
import com.vedagram.admin.adm.GrammerceDto;
import com.vedagram.domainmodel.UserModel;

public class GrammerceOrdersDto {

	private String id;
	private String name;
	private String contactNumber;
	private String emailId;
	private String deliveryAddress;
	private GrammerceDto grammerceDto;
	private UserModel userModel;
	private String orderNumber;
	private Date orderDate;
	private String totalPrice;
	private String quantity;
	private String awbNumber;
	private String status;
	private Double pdAmt;
	private boolean giftFlag;
	private String giftNote;
	private String giftedBy;
	private String shipmentDate;
	private String shipmentTime;
	private int totalPaidAmount;
	private Date expDeliveryDate;
	private double refundAmt;
	private double cancellationFee;
	private boolean refundFlag;
	private String cancelReason;
	private String returnReason;
	private String replaceReason;

	

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

	public boolean isRefundFlag() {
		return refundFlag;
	}

	public void setRefundFlag(boolean refundFlag) {
		this.refundFlag = refundFlag;
	}

	public double getRefundAmt() {
		return refundAmt;
	}

	public void setRefundAmt(double refundAmt) {
		this.refundAmt = refundAmt;
	}

	public double getCancellationFee() {
		return cancellationFee;
	}

	public void setCancellationFee(double cancellationFee) {
		this.cancellationFee = cancellationFee;
	}

	public int getTotalPaidAmount() {
		return totalPaidAmount;
	}

	public void setTotalPaidAmount(int totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}

	public boolean isGiftFlag() {
		return giftFlag;
	}

	public String getGiftNote() {
		return giftNote;
	}

	public String getGiftedBy() {
		return giftedBy;
	}

	public void setGiftFlag(boolean giftFlag) {
		this.giftFlag = giftFlag;
	}

	public void setGiftNote(String giftNote) {
		this.giftNote = giftNote;
	}

	public void setGiftedBy(String giftedBy) {
		this.giftedBy = giftedBy;
	}

	public String getId() {
		return id;
	}

	public GrammerceDto getGrammerceDto() {
		return grammerceDto;
	}

	public void setGrammerceDto(GrammerceDto grammerceDto) {
		this.grammerceDto = grammerceDto;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	

	public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getAwbNumber() {
		return awbNumber;
	}

	public void setAwbNumber(String awbNumber) {
		this.awbNumber = awbNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Double getPdAmt() {
		return pdAmt;
	}

	public void setPdAmt(Double pdAmt) {
		this.pdAmt = pdAmt;
	}

	public String getShipmentDate() {
		return shipmentDate;
	}

	public String getShipmentTime() {
		return shipmentTime;
	}

	public void setShipmentDate(String shipmentDate) {
		this.shipmentDate = shipmentDate;
	}

	public void setShipmentTime(String shipmentTime) {
		this.shipmentTime = shipmentTime;
	}

	public Date getExpDeliveryDate() {
		return expDeliveryDate;
	}

	public void setExpDeliveryDate(Date expDeliveryDate) {
		this.expDeliveryDate = expDeliveryDate;
	}
	

}
