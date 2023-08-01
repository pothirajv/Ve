package com.vedagram.user;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.projectadm.ProjectModel;

@Document(collection="ProjectDonation")
public class ProjectDonation {

	@Id
	@Indexed
	private String id;
	private String donorName;
	private String emailId;
	private String contactNumber;
	private String Address;
	private Date donationDate;
	private String donationNumber;
	@DBRef
	private UserModel userModel;
	
	@DBRef
	private ProjectModel projectModel;
	private Integer contributionAmount;
	private String remarks;
	
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Integer getContributionAmount() {
		return contributionAmount;
	}
	public void setContributionAmount(Integer contributionAmount) {
		this.contributionAmount = contributionAmount;
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
	public Date getDonationDate() {
		return donationDate;
	}
	public String getDonationNumber() {
		return donationNumber;
	}
	public UserModel getUserModel() {
		return userModel;
	}
	public ProjectModel getProjectModel() {
		return projectModel;
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
	public void setDonationDate(Date donationDate) {
		this.donationDate = donationDate;
	}
	public void setDonationNumber(String donationNumber) {
		this.donationNumber = donationNumber;
	}
	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	public void setProjectModel(ProjectModel projectModel) {
		this.projectModel = projectModel;
	}
	
	
	
	
}
