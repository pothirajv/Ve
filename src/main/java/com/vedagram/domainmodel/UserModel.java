package com.vedagram.domainmodel;




import java.io.Serializable;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Document(collection = "UserDetails")
public class UserModel implements Serializable {
	
	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	private static final long serialVersionUID = 1L;
	@Id
    @Indexed
	private String id;
	private String email;
	private String firstName;
    private String lastName;
    private String area;
    private String city;
    private String state;
    private String country;
	private String mobileNumber;
	private String address;
	private int roleId;
	private Date createdDate;
	private Date lastUpdatedDate;
	private String uflag;
	private String role;
	@JsonIgnore
	private String password;
	private String userToken;
    private String aadharNumber;
    private String vendorName;
    private String productType;
    private String resetPwdToken;
    private String activeComment;
    private String inactiveComment;
    private String resetNumToken;
    private String refMobileNumber;



	public String getResetNumToken() {
		return resetNumToken;
	}

	public String getRefMobileNumber() {
		return refMobileNumber;
	}

	public void setResetNumToken(String resetNumToken) {
		this.resetNumToken = resetNumToken;
	}

	public void setRefMobileNumber(String refMobileNumber) {
		this.refMobileNumber = refMobileNumber;
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

	public String getVendorName() {
			return vendorName;
		}

		public void setVendorName(String vendorName) {
			this.vendorName = vendorName;
		}

	public String getAadharNumber() {
			return aadharNumber;
		}

		public void setAadharNumber(String aadharNumber) {
			this.aadharNumber = aadharNumber;
		}

	public String getUserToken() {
		return userToken;
	}

	public void setUserToken(String userToken) {
		this.userToken = userToken;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getLastUpdatedDate() {
		return lastUpdatedDate;
	}

	public void setLastUpdatedDate(Date lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}

	public String getUflag() {
		return uflag;
	}

	public void setUflag(String uflag) {
		this.uflag = uflag;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int rollId) {
		this.roleId = rollId;
	}
	
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
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

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getResetPwdToken() {
		return resetPwdToken;
	}

	public void setResetPwdToken(String resetPwdToken) {
		this.resetPwdToken = resetPwdToken;
	}

}