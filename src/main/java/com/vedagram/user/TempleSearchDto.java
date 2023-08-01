package com.vedagram.user;

public class TempleSearchDto {
	
	private String deityId;
	private String country;
	private String state;
	public String getDeityId() {
		return deityId;
	}
	public void setDeityId(String deityId) {
		this.deityId = deityId;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getVillageOrTown() {
		return villageOrTown;
	}
	public void setVillageOrTown(String villageOrTown) {
		this.villageOrTown = villageOrTown;
	}
	public String getTempleName() {
		return templeName;
	}
	public void setTempleName(String templeName) {
		this.templeName = templeName;
	}
	private String district;
	private String villageOrTown;
	private String templeName;
	
}
