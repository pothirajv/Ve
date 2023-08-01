package com.vedagram.projectadm;

import java.io.Serializable;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;

@Document(collection = "project")
public class ProjectModel implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Indexed
	private String id;
	private String projectTitle;
	private String projectStatus;
	private String purpose;
	private Integer targetAmount;
	private Date startDate;
	private Date endDate;
	private Integer minAmountDonate;
	private Integer maxAmountDonate;
	@DBRef
	private UserModel createdBy;
	private Date createdDate;
	String activeComment;
	String inactiveComment;
	private String adminCreatedId;
	
	
	public String getAdminCreatedId() {
		return adminCreatedId;
	}

	public void setAdminCreatedId(String adminCreatedId) {
		this.adminCreatedId = adminCreatedId;
	}

	public String getActiveComment() {
		return activeComment;
	}

	public String getInactiveComment() {
		return inactiveComment;
	}

	public void setActiveComment(String activeComment) {
		this.activeComment = activeComment;
	}

	public void setInactiveComment(String inactiveComment) {
		this.inactiveComment = inactiveComment;
	}

	public UserModel getCreatedBy() {
		return createdBy;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedBy(UserModel createdBy) {
		this.createdBy = createdBy;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public String getId() {
		return id;
	}

	public String getProjectTitle() {
		return projectTitle;
	}

	public String getProjectStatus() {
		return projectStatus;
	}

	public String getPurpose() {
		return purpose;
	}

	public Integer getTargetAmount() {
		return targetAmount;
	}

	public Date getStartDate() {
		return startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public Integer getMinAmountDonate() {
		return minAmountDonate;
	}

	public Integer getMaxAmountDonate() {
		return maxAmountDonate;
	}

	public void setMinAmountDonate(Integer minAmountDonate) {
		this.minAmountDonate = minAmountDonate;
	}

	public void setMaxAmountDonate(Integer maxAmountDonate) {
		this.maxAmountDonate = maxAmountDonate;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}

	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public void setTargetAmount(Integer targetAmount) {
		this.targetAmount = targetAmount;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

}
