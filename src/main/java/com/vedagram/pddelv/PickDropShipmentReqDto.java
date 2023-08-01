/**
 * 
 */
package com.vedagram.pddelv;

import java.io.Serializable;

public class PickDropShipmentReqDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private String weight;

	private String parcelType;

	private String packagePickupAddress;

	private String recieverAddress;

	private String recieverName;

	private String recieverContact;

	private String orderId;

	private String senderContact;

	private String trackingId;

	private String merchantName;

	private boolean codFlag;

	private String codAmount;
	
	private String pdToken;
	String scheduleDt;
	String scheduleTm;

	public String getScheduleDt() {
		return scheduleDt;
	}

	public void setScheduleDt(String scheduleDt) {
		this.scheduleDt = scheduleDt;
	}

	public String getScheduleTm() {
		return scheduleTm;
	}

	public void setScheduleTm(String scheduleTm) {
		this.scheduleTm = scheduleTm;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getParcelType() {
		return parcelType;
	}

	public void setParcelType(String parcelType) {
		this.parcelType = parcelType;
	}

	public String getPackagePickupAddress() {
		return packagePickupAddress;
	}

	public void setPackagePickupAddress(String packagePickupAddress) {
		this.packagePickupAddress = packagePickupAddress;
	}

	public String getRecieverAddress() {
		return recieverAddress;
	}

	public void setRecieverAddress(String recieverAddress) {
		this.recieverAddress = recieverAddress;
	}

	public String getRecieverName() {
		return recieverName;
	}

	public void setRecieverName(String recieverName) {
		this.recieverName = recieverName;
	}

	public String getRecieverContact() {
		return recieverContact;
	}

	public void setRecieverContact(String recieverContact) {
		this.recieverContact = recieverContact;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getSenderContact() {
		return senderContact;
	}

	public void setSenderContact(String senderContact) {
		this.senderContact = senderContact;
	}

	public String getTrackingId() {
		return trackingId;
	}

	public void setTrackingId(String trackingId) {
		this.trackingId = trackingId;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
	}

	public boolean isCodFlag() {
		return codFlag;
	}

	public void setCodFlag(boolean codFlag) {
		this.codFlag = codFlag;
	}

	public String getCodAmount() {
		return codAmount;
	}

	public void setCodAmount(String codAmount) {
		this.codAmount = codAmount;
	}

	public String getPdToken() {
		return pdToken;
	}

	public void setPdToken(String pdToken) {
		this.pdToken = pdToken;
	}

}
