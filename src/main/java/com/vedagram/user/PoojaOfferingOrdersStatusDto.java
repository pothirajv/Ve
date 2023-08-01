package com.vedagram.user;

import java.util.Date;


public class PoojaOfferingOrdersStatusDto {

	private String id;
	private PoojaOfferingOrders poojaOfferingOrders;
	private Date orderedDate;
	private String awbNumber;
	private String status;
	private String receipt;
	private String shipmentDate;
	private String shipmentTime;
	private boolean offeringFlag;
	private Date lastUpdatedDate;

	
	public String getShipmentDate() {
		return shipmentDate;
	}
	public String getShipmentTime() {
		return shipmentTime;
	}
	public boolean isOfferingFlag() {
		return offeringFlag;
	}
	public Date getLastUpdatedDate() {
		return lastUpdatedDate;
	}
	public void setShipmentDate(String shipmentDate) {
		this.shipmentDate = shipmentDate;
	}
	public void setShipmentTime(String shipmentTime) {
		this.shipmentTime = shipmentTime;
	}
	public void setOfferingFlag(boolean offeringFlag) {
		this.offeringFlag = offeringFlag;
	}
	public void setLastUpdatedDate(Date lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}
	public String getReceipt() {
		return receipt;
	}
	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}
	public String getId() {
		return id;
	}
	public PoojaOfferingOrders getPoojaOfferingOrders() {
		return poojaOfferingOrders;
	}	
	public Date getOrderedDate() {
		return orderedDate;
	}
	public String getAwbNumber() {
		return awbNumber;
	}
	public String getStatus() {
		return status;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPoojaOfferingOrders(PoojaOfferingOrders poojaOfferingOrders) {
		this.poojaOfferingOrders = poojaOfferingOrders;
	}
	
	public void setOrderedDate(Date orderedDate) {
		this.orderedDate = orderedDate;
	}
	
	public void setAwbNumber(String awbNumber) {
		this.awbNumber = awbNumber;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
