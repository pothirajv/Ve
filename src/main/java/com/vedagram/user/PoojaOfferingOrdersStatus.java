package com.vedagram.user;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;

@Document(collection = "PoojaOfferingOrdersStatus")
public class PoojaOfferingOrdersStatus {
	@Id
	private String id;
	@DBRef
	private PoojaOfferingOrders poojaOfferingOrders;
	@DBRef
	private UserModel updatedBy;
	private Date orderedDate;
	private Date lastUpdatedDate;
	private String awbNumber;
	private String status;
	private String shipmentDate;
	private String shipmentTime;
	private boolean offeringFlag;
	@DBRef
	private UserModel updatedByAdmin;
	
	public String getId() {
		return id;
	}
	
	public UserModel getUpdatedByAdmin() {
		return updatedByAdmin;
	}

	public void setUpdatedByAdmin(UserModel updatedByAdmin) {
		this.updatedByAdmin = updatedByAdmin;
	}

	public PoojaOfferingOrders getPoojaOfferingOrders() {
		return poojaOfferingOrders;
	}
	
	public Date getOrderedDate() {
		return orderedDate;
	}
	public Date getLastUpdatedDate() {
		return lastUpdatedDate;
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
	public UserModel getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(UserModel updatedBy) {
		this.updatedBy = updatedBy;
	}
	public void setOrderedDate(Date orderedDate) {
		this.orderedDate = orderedDate;
	}
	public void setLastUpdatedDate(Date lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}
	public void setAwbNumber(String awbNumber) {
		this.awbNumber = awbNumber;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getShipmentDate() {
		return shipmentDate;
	}
	public String getShipmentTime() {
		return shipmentTime;
	}
	public boolean isOfferingFlag() {
		return offeringFlag;
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
	
	
}
