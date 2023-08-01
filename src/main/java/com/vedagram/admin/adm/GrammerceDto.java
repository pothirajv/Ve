package com.vedagram.admin.adm;

import java.util.Date;
import java.util.List;

public class GrammerceDto {

	private String id;
	private String productName;
	private String brandName;
	private String significance;
	private float price;
	private int stock;
	private int deliveryLeadTime;
	private int quantity;
	private Double delChargePerDay;
	private Double pdDelCharge;
	private String activeFlag;
	private String activeComment;
	private String inactiveComment;
	private Date expDeliveryDate;
	private List<String> country;
	private List<String> state;
	private List<String> district;


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

	public int getDeliveryLeadTime() {
		return deliveryLeadTime;
	}

	public void setDeliveryLeadTime(int deliveryLeadTime) {
		this.deliveryLeadTime = deliveryLeadTime;
	}

	public Double getDelChargePerDay() {
		return delChargePerDay;
	}

	public void setDelChargePerDay(Double delChargePerDay) {
		this.delChargePerDay = delChargePerDay;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Double getPdDelCharge() {
		return pdDelCharge;
	}

	public void setPdDelCharge(Double pdDelCharge) {
		this.pdDelCharge = pdDelCharge;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	private List<String> grammerceImgsUrl;

	public List<String> getGrammerceImgsUrl() {
		return grammerceImgsUrl;
	}

	public void setGrammerceImgsUrl(List<String> grammerceImgsUrl) {
		this.grammerceImgsUrl = grammerceImgsUrl;
	}

	public String getId() {
		return id;
	}

	public String getProductName() {
		return productName;
	}

	public String getBrandName() {
		return brandName;
	}

	public String getSignificance() {
		return significance;
	}

	public float getPrice() {
		return price;
	}

	public int getStock() {
		return stock;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public void setSignificance(String significance) {
		this.significance = significance;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public Date getExpDeliveryDate() {
		return expDeliveryDate;
	}

	public void setExpDeliveryDate(Date expDeliveryDate) {
		this.expDeliveryDate = expDeliveryDate;
	}

	public List<String> getCountry() {
		return country;
	}

	public void setCountry(List<String> country) {
		this.country = country;
	}

	public List<String> getState() {
		return state;
	}

	public void setState(List<String> state) {
		this.state = state;
	}

	public List<String> getDistrict() {
		return district;
	}

	public void setDistrict(List<String> district) {
		this.district = district;
	}

	

}
