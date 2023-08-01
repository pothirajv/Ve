package com.vedagram.vendor;

import com.vedagram.domainmodel.UserModel;

public class PoojaMaterialDto {
	private String id;
	private String brandName;
	private String productName;
	private float price;
	private int materialStock;
	private int quantity;
	private String packageSize;
	private String packageUnit;
	private UserModel createdBy;
	private String image;
	private Double pdDelCharge;
	private Double delChargePerDay;
	private String activeFlag;
	private String activeComment;
    private	String inactiveComment;
    
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
	public String getId() {
		return id;
	}
	public String getBrandName() {
		return brandName;
	}
	public String getPackageSize() {
		return packageSize;
	}
	public String getPackageUnit() {
		return packageUnit;
	}
	public void setPackageSize(String packageSize) {
		this.packageSize = packageSize;
	}
	public void setPackageUnit(String packageUnit) {
		this.packageUnit = packageUnit;
	}
	public String getProductName() {
		return productName;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public float getPrice() {
		return price;
	}
	public int getMaterialStock() {
		return materialStock;
	}
	public UserModel getCreatedBy() {
		return createdBy;
	}
	public String getImage() {
		return image;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public void setMaterialStock(int materialStock) {
		this.materialStock = materialStock;
	}
	public void setCreatedBy(UserModel createdBy) {
		this.createdBy = createdBy;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
