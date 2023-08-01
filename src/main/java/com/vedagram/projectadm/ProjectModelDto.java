package com.vedagram.projectadm;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.user.ProjectDonation;

/**
 * @author Winston
 *
 */
public class ProjectModelDto {
	private String id;
	@NotNull(message = "projectTitle Required")
	private String projectTitle;
	private String projectStatus;
	private String purpose;
	@NotNull(message = "targetAmount Required")
	private Integer targetAmount;
	@NotNull(message = "startDate Required")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy")
	private Date startDate;
	@NotNull(message = "endDate Required")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy")
	private Date endDate;
	private Long NoOfDaysLeft;
	private Integer minAmountDonate;
	private Integer maxAmountDonate;
	private Integer TotalAmountCollected;
	private Integer TotalSupporters;
	private UserModel createdBy;
	String activeComment;
	String inactiveComment;
	private String projectAdminId;

	
	public String getProjectAdminId() {
		return projectAdminId;
	}


	public void setProjectAdminId(String projectAdminId) {
		this.projectAdminId = projectAdminId;
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


	public void setCreatedBy(UserModel createdBy) {
		this.createdBy = createdBy;
	}


	public Integer getTotalSupporters() {
		return TotalSupporters;
	}

	
	public Integer getTotalAmountCollected() {
		return TotalAmountCollected;
	}


	public void setTotalAmountCollected(Integer totalAmountCollected) {
		TotalAmountCollected = totalAmountCollected;
	}


	public void setTotalSupporters(Integer totalSupporters) {
		TotalSupporters = totalSupporters;
	}

	public Long getNoOfDaysLeft() {
		return NoOfDaysLeft;
	}

	public void setNoOfDaysLeft(Long noOfDaysLeft) {
		NoOfDaysLeft = noOfDaysLeft;
	}

	public String getId() {
		return id;
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
