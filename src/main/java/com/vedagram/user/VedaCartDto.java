/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.user;



import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.PoojaOfferings;


public class VedaCartDto  {
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public String getMailId() {
		return mailId;
	}
	public void setMailId(String mailId) {
		this.mailId = mailId;
	}
	public String getMobileNumber() {
		return mobileNumber;
	}
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public boolean isPrasadhamDelFlag() {
		return prasadhamDelFlag;
	}
	public void setPrasadhamDelFlag(boolean prasadhamDelFlag) {
		this.prasadhamDelFlag = prasadhamDelFlag;
	}
	public UserModel getUserModel() {
		return userModel;
	}
	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	public PoojaOfferings getPoojaOfferings() {
		return poojaOfferings;
	}
	public void setPoojaOfferings(PoojaOfferings poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
	}
	public Date getFromDate() {
		return fromDate;
	}
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	public Date getToDate() {
		return toDate;
	}
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	public Integer getNoOfMonths() {
		return noOfMonths;
	}
	public void setNoOfMonths(Integer noOfMonths) {
		this.noOfMonths = noOfMonths;
	}
	public List<String> getListOfDates() {
		return listOfDates;
	}
	public void setListOfDates(List<String> listOfDates) {
		this.listOfDates = listOfDates;
	}
	public boolean isPayDakshinaToPriestFlag() {
		return payDakshinaToPriestFlag;
	}
	public void setPayDakshinaToPriestFlag(boolean payDakshinaToPriestFlag) {
		this.payDakshinaToPriestFlag = payDakshinaToPriestFlag;
	}
	public Integer getDakshinaAmountForPriest() {
		return dakshinaAmountForPriest;
	}
	public void setDakshinaAmountForPriest(Integer dakshinaAmountForPriest) {
		this.dakshinaAmountForPriest = dakshinaAmountForPriest;
	}
	public boolean isPayDakshinaToTempleFlag() {
		return payDakshinaToTempleFlag;
	}
	public void setPayDakshinaToTempleFlag(boolean payDakshinaToTempleFlag) {
		this.payDakshinaToTempleFlag = payDakshinaToTempleFlag;
	}
	public Integer getDakshinaAmountToTemple() {
		return dakshinaAmountToTemple;
	}
	public void setDakshinaAmountToTemple(Integer dakshinaAmountToTemple) {
		this.dakshinaAmountToTemple = dakshinaAmountToTemple;
	}
	
	public Double getPdDelCharge() {
		return pdDelCharge;
	}
	public void setPdDelCharge(Double pdDelCharge) {
		this.pdDelCharge = pdDelCharge;
	}

	public Double getTotalPaidAmount() {
		return totalPaidAmount;
	}
	public void setTotalPaidAmount(Double totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}

	private String id;
	private String firstName;
	private String star;
	private String mailId;
	private String mobileNumber;
	private String deliveryAddress;
	private boolean prasadhamDelFlag;
	private UserModel userModel;
	private PoojaOfferings poojaOfferings;
	private Date fromDate;
	private Date toDate;
	private Integer noOfMonths;
	private List<String> listOfDates;
	private boolean payDakshinaToPriestFlag;
	private Integer dakshinaAmountForPriest;
	private boolean payDakshinaToTempleFlag;
	private Integer dakshinaAmountToTemple;
	private Double pdDelCharge;
	private Double totalPaidAmount;
	
}
