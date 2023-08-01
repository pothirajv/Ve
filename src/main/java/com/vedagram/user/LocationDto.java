package com.vedagram.user;

import java.util.List;

public class LocationDto {

	private List<String> State;
	private List<String> district;
	private String pincode;

	public List<String> getState() {
		return State;
	}

	public void setState(List<String> state) {
		State = state;
	}

	public List<String> getDistrict() {
		return district;
	}

	public void setDistrict(List<String> district) {
		this.district = district;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	
	

}
