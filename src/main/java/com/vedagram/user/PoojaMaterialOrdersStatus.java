package com.vedagram.user;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;

@Document(collection = "PoojaMaterialOrdersStatus")
public class PoojaMaterialOrdersStatus {
	@Id
	private String id;
	@DBRef
	private PoojaMaterialOrders poojaMaterialOrders;
	@DBRef
	private UserModel updatedBy;
	private Date orderedDate;
	private Date lastUpdatedDate;
	private String awbNumber;
	private String status;
	private String shipmentDate;
	private String shipmentTime;
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

	public PoojaMaterialOrders getPoojaMaterialOrders() {
		return poojaMaterialOrders;
	}

	public void setPoojaMaterialOrders(PoojaMaterialOrders poojaMaterialOrders) {
		this.poojaMaterialOrders = poojaMaterialOrders;
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

	public void setShipmentDate(String shipmentDate) {
		this.shipmentDate = shipmentDate;
	}

	public void setShipmentTime(String shipmentTime) {
		this.shipmentTime = shipmentTime;
	}
	

}
