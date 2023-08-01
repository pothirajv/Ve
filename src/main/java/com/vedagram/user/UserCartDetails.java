package com.vedagram.user;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.PoojaOfferings;

@Document(collection = "UserCartDetails")
public class UserCartDetails implements Serializable {
	public String getListOfDates() {
		return listOfDates;
	}
	public void setListOfDates(String listOfDates) {
		this.listOfDates = listOfDates;
	}
	private static final long serialVersionUID = 1L;
	@Id
    @Indexed
	String id;
	@DBRef
	UserModel userModel;
	@DBRef
	PoojaOfferings poojaOfferings;
	private String firstName;
	private String star;
	private String mailId;
	private String mobileNumber;
	private String deliveryAddress;
	private boolean prasadhamDelFlag;
	private Date fromDate;
	private Date toDate;
	private Integer noOfMonths;
	private String listOfDates;
	private boolean payDakshinaToPriestFlag;
	private Integer dakshinaAmountForPriest;
	private boolean payDakshinaToTempleFlag;
	private Integer dakshinaAmountToTemple;
	private int delFlag;
	private Date lastModifiedDate;
	private Double pdDelCharge;
	public Double getPdDelCharge() {
		return pdDelCharge;
	}
	public void setPdDelCharge(Double pdDelCharge) {
		this.pdDelCharge = pdDelCharge;
	}
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
	public PoojaOfferings getPoojaOfferings() {
		return poojaOfferings;
	}
	public void setPoojaOfferings(PoojaOfferings poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
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
//	public List<Date> getListOfDates() {
//		return listOfDates;
//	}
//	public void setListOfDates(List<Date> listOfDates) {
//		this.listOfDates = listOfDates;
//	}
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
	public int getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(int delFlag) {
		this.delFlag = delFlag;
	}
	public Date getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(Date lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
