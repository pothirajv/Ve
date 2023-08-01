package com.vedagram.user;

import java.util.Date;


public class PoojaMaterialOrdersStatusDto {

	private String id;
	private PoojaMaterialOrders poojaMaterialOrders;
	private Date orderedDate;
	private String awbNumber;
	private String status;
	
	public String getId() {
		return id;
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
	
	public PoojaMaterialOrders getPoojaMaterialOrders() {
		return poojaMaterialOrders;
	}

	public void setPoojaMaterialOrders(PoojaMaterialOrders poojaMaterialOrders) {
		this.poojaMaterialOrders = poojaMaterialOrders;
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
