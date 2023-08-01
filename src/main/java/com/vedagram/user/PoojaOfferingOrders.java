package com.vedagram.user;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.PoojaOfferings;

@Document(collection = "PoojaOfferingOrders")
public class PoojaOfferingOrders {
	
	@DBRef
	private PoojaOfferings poojaOfferings;
	
	@DBRef
	private UserModel userModel;
	private int totalPaidAmount;
	
	
	
	public int getTotalPaidAmount() {
		return totalPaidAmount;
	}
	public void setTotalPaidAmount(int totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	
	public UserCartDetails getUserCartDetails() {
		return userCartDetails;
	}
	public void setUserCartDetails(UserCartDetails userCartDetails) {
		this.userCartDetails = userCartDetails;
	}
	@Id
	private String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	private String orderNumber;
	
	private double pdAmt;
	public double getPdAmt() {
		return pdAmt;
	}
	public void setPdAmt(double pdAmt) {
		this.pdAmt = pdAmt;
	}
	private Date orderDate;
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	private UserCartDetails userCartDetails;

	public PoojaOfferings getPoojaOfferings() {
		return poojaOfferings;
	}
	public void setPoojaOfferings(PoojaOfferings poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
	}
	public UserModel getUserModel() {
		return userModel;
	}
	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	
	
}
	
	
	
	
	