package com.vedagram.payment;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;



@Document(collection = "CartPayRef")
public class CartPayRef implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Indexed
	private String id;
	@DBRef
	private UserModel userModel;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public UserModel getUserModel() {
		return userModel;
	}
	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public Double getTotalTransAmount() {
		return totalTransAmount;
	}
	public void setTotalTransAmount(Double totalTransAmount) {
		this.totalTransAmount = totalTransAmount;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	private String paymentStatus;
	private Date payDate;
	private Double totalTransAmount;
	 
	
}
