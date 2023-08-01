package com.vedagram.payment;

import java.util.Date;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.PoojaOfferings;

public class UserPurchaseResponse {
	String id;
	UserModel userModel;
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
	//private List<Date> listOfDates;
	private boolean payDakshinaToPriestFlag;
	private Integer dakshinaAmountForPriest;
	private boolean payDakshinaToTempleFlag;
	private Integer dakshinaAmountToTemple;
	private int delFlag;
	private Date lastModifiedDate;
	private Double totalAmount;
	private String packageStatus;
	private Date createDate;
	private String paymentStatus;//PAY_INIT,PAY_COMP
	private String loginUserId;
	private String poojaOfferingOrdersId;
	public String getPoojaOfferingOrdersId() {
		return poojaOfferingOrdersId;
	}
	public void setPoojaOfferingOrdersId(String poojaOfferingOrdersId) {
		this.poojaOfferingOrdersId = poojaOfferingOrdersId;
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
	public Double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getPackageStatus() {
		return packageStatus;
	}
	public void setPackageStatus(String packageStatus) {
		this.packageStatus = packageStatus;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
}
