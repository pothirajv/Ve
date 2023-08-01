package com.vedagram.vendor;

import java.io.Serializable;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;

@Document(collection = "PoojaMaterials")
public class PoojaMaterial implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Indexed
	private String id;
	@NotNull(message="BrandName Required")
	private String brandName;
	@NotNull(message="ProductName Required")
	private String productName;
	@NotNull(message="Price Required")
	private float price;
	@NotNull(message="MaterialStock Required")
	private int materialStock;
	@NotNull(message="Quantity Required")
	private int quantity;
	@NotNull(message="PackageSize Required")
	private String packageSize;
	@NotNull(message="PackageUnit Required")
	private String packageUnit;
	private String activeflag;
	private String activeComment;
    private	String inactiveComment;
    private String adminCreatedId;
    private String vendorId;
    
    
	public String getAdminCreatedId() {
		return adminCreatedId;
	}

	public String getVendorId() {
		return vendorId;
	}

	public void setAdminCreatedId(String adminCreatedId) {
		this.adminCreatedId = adminCreatedId;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
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

	public String getActiveflag() {
		return activeflag;
	}

	public void setActiveflag(String activeflag) {
		this.activeflag = activeflag;
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

	@DBRef
	private UserModel createdBy;

	public String getId() {
		return id;
	}

	public String getBrandName() {
		return brandName;
	}

	public String getProductName() {
		return productName;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
