package com.vedagram.tempadmin;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;

@Document(collection = "Temples")
public class Temples implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Indexed
	String id;
	String name;
	String scheduleAndTimings;
	String aerialView;
	@DBRef
	UserModel createdBy;
	String villageorTown;
	String district;
	String state;
	String country;
	String activeFlag;
	String aboutAndHistory;
	String tempLat;
	String tempLong;
	String shippingAddress;
	String committeeMembers;
	String activeComment;
	String inactiveComment;
	String adminCreatedId;
	

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

	public String getCommitteeMembers() {
		return committeeMembers;
	}

	public void setCommitteeMembers(String committeeMembers) {
		this.committeeMembers = committeeMembers;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public String getAboutAndHistory() {
		return aboutAndHistory;
	}

	public void setAboutAndHistory(String aboutAndHistory) {
		this.aboutAndHistory = aboutAndHistory;
	}

	public String getTempLat() {
		return tempLat;
	}

	public void setTempLat(String tempLat) {
		this.tempLat = tempLat;
	}

	public String getTempLong() {
		return tempLong;
	}

	public void setTempLong(String tempLong) {
		this.tempLong = tempLong;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getVillageorTown() {
		return villageorTown;
	}

	public void setVillageorTown(String villageorTown) {
		this.villageorTown = villageorTown;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getScheduleAndTimings() {
		return scheduleAndTimings;
	}

	public void setScheduleAndTimings(String scheduleAndTimings) {
		this.scheduleAndTimings = scheduleAndTimings;
	}

	public String getAerialView() {
		return aerialView;
	}

	public void setAerialView(String aerialView) {
		this.aerialView = aerialView;
	}

	public UserModel getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(UserModel createdBy) {
		this.createdBy = createdBy;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Temples other = (Temples) obj;
		return Objects.equals(id, other.id);
	}
}
