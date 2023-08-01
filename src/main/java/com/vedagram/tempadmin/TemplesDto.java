/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.tempadmin;



import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.domainmodel.UserModel;


public class TemplesDto  {
	String id;
	String name;
String scheduleAndTimings;
String aerialView;
UserModel createdBy;
String villageorTown;
String district;
String state;
String country;
String aboutAndHistory;
String tempLat;
String tempLong;
String shippingAddress;
String committeeMembers;
String activeComment;
String inactiveComment;

public UserModel getCreatedBy() {
	return createdBy;
}
public void setCreatedBy(UserModel createdBy) {
	this.createdBy = createdBy;
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
MultipartFile tempImage;
	public MultipartFile getTempImage() {
	return tempImage;
}
public void setTempImage(MultipartFile tempImage) {
	this.tempImage = tempImage;
}
	public String getAerialView() {
	return aerialView;
}
public void setAerialView(String aerialView) {
	this.aerialView = aerialView;
}
	public String getScheduleAndTimings() {
	return scheduleAndTimings;
}
public void setScheduleAndTimings(String scheduleAndTimings) {
	this.scheduleAndTimings = scheduleAndTimings;
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
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	}
