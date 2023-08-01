package com.vedagram.admin.adm;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NegativeOrZero;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Grammerce")
public class Grammerce implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Indexed
	private String id;
	@NotNull(message = "ProductName Required")
	private String productName;
	@NotNull(message = "BrandName Required")
	private String brandName;
	@NotNull(message = "Significance Required")
	private String significance;
	@NotNull(message = "Price Required")
	private float price;
	@NotNull(message = "stock Required")
	private int stock;
	@NotNull(message = "DeliveryTime Required")
	private int deliveryLeadTime;
	private String activeFlag;
	private String activeComment;
	private String inactiveComment;
	@NotEmpty(message = "Country Required")
	private List<String> country;
	private List<String> state;
	private List<String> district;

	public void setPrice(float price) {
		this.price = price;
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

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
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

	public void setPrice(int price) {
		this.price = price;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getDeliveryLeadTime() {
		return deliveryLeadTime;
	}

	public void setDeliveryLeadTime(int deliveryLeadTime) {
		this.deliveryLeadTime = deliveryLeadTime;
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
