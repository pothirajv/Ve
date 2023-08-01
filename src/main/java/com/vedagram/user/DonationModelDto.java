package com.vedagram.user;

import java.util.Date;

import com.vedagram.domainmodel.UserModel;


public class DonationModelDto {

	private String id;
	private String donorName;
	private String emailId;
	private String contactNumber;
	private String Address;
	private Date donationDate;
	private String donationNumber;
	private UserModel userModel;
	private int contributionAmount;
	private String purpose;
	private String remarks;
	private Integer totalSupporters;
	public Integer getTotalSupporters() {
		return totalSupporters;
	}

	public void setTotalSupporters(Integer totalSupporters) {
		this.totalSupporters = totalSupporters;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	private boolean revealFlag;

	public int getContributionAmount() {
		return contributionAmount;
	}

	public String getPurpose() {
		return purpose;
	}

	public boolean isRevealFlag() {
		return revealFlag;
	}

	public void setContributionAmount(int contributionAmount) {
		this.contributionAmount = contributionAmount;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public void setRevealFlag(boolean revealFlag) {
		this.revealFlag = revealFlag;
	}

	public Date getDonationDate() {
		return donationDate;
	}

	public String getDonationNumber() {
		return donationNumber;
	}

	public UserModel getUserModel() {
		return userModel;
	}

	public void setDonationDate(Date donationDate) {
		this.donationDate = donationDate;
	}

	public void setDonationNumber(String donationNumber) {
		this.donationNumber = donationNumber;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public String getId() {
		return id;
	}

	public String getDonorName() {
		return donorName;
	}

	public String getEmailId() {
		return emailId;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public String getAddress() {
		return Address;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setDonorName(String donorName) {
		this.donorName = donorName;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public void setAddress(String address) {
		Address = address;
	}

}
