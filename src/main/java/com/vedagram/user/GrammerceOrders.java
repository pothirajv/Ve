package com.vedagram.user;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.admin.adm.Grammerce;
import com.vedagram.domainmodel.UserModel;

/**
 * @author info
 *
 */
@Document(collection = "GrammerceOrders")
public class GrammerceOrders {

	@Id
	@Indexed
	private String id;
	private String name;
	private String contactNumber;
	private String emailId;
	private String deliveryAddress;
	@DBRef
	private Grammerce grammerce;
	@DBRef
	private UserModel userModel;
	private String orderNumber;
	private Date orderDate;
	private String totalPrice;
	private String quantity;
	private String awbNumber;
	private String status;
	private double pdAmt;
	private boolean giftFlag;
	private String giftNote;
	private String giftedBy;
	private String shipmentDate;
	private String shipmentTime;
	private Date expDeliveryDate;
	private String cancelReason;
	private String returnReason;
	private String replaceReason;
	private boolean refundFlag=false;
	
	
	public boolean isRefundFlag() {
		return refundFlag;
	}

	public void setRefundFlag(boolean refundFlag) {
		this.refundFlag = refundFlag;
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

	public double getPdAmt() {
		return pdAmt;
	}

	public void setPdAmt(double pdAmt) {
		this.pdAmt = pdAmt;
	}

	public String getAwbNumber() {
		return awbNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setAwbNumber(String awbNumber) {
		this.awbNumber = awbNumber;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public String getEmailId() {
		return emailId;
	}

	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	public Grammerce getGrammerce() {
		return grammerce;
	}

	public UserModel getUserModel() {
		return userModel;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	public void setGrammerce(Grammerce grammerce) {
		this.grammerce = grammerce;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
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
