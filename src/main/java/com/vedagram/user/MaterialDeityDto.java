package com.vedagram.user;

public class MaterialDeityDto {
	
	private String deityId;
	private String deityName;
	private String materialId;
	private String productName;
	private int quantity;
	private Double pdDelCharge;
	private float price;
	private String activeFlag;
	private Double delChargePerDay;
	private int materialStock;


	public String getDeityId() {
		return deityId;
	}
	public void setDeityId(String deityId) {
		this.deityId = deityId;
	}
	public String getMaterialId() {
		return materialId;
	}
	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Double getPdDelCharge() {
		return pdDelCharge;
	}
	public void setPdDelCharge(Double pdDelCharge) {
		this.pdDelCharge = pdDelCharge;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}
	public Double getDelChargePerDay() {
		return delChargePerDay;
	}
	public void setDelChargePerDay(Double delChargePerDay) {
		this.delChargePerDay = delChargePerDay;
	}
	public int getMaterialStock() {
		return materialStock;
	}
	public void setMaterialStock(int materialStock) {
		this.materialStock = materialStock;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getDeityName() {
		return deityName;
	}
	public void setDeityName(String deityName) {
		this.deityName = deityName;
	}
	
	
	


}
