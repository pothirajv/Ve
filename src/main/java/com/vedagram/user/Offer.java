package com.vedagram.user;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.admin.adm.Grammerce;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.vendor.PoojaMaterial;

@Document(collection="Offer")
public class Offer {
	
	private String id;
	private String offerName;
	private String description;
	private Date fromDate;
	private Date toDate;
	private String offerType;
	private int type;
	private int percentage;
	private int maxDiscountPrice;
	@DBRef
	private UserModel addedBY;
	@DBRef
	private PoojaOfferings poojaOfferings;
	@DBRef
	private PoojaMaterial poojaMaterial;
	@DBRef
	private Grammerce grammerce;
	
	
	public UserModel getAddedBY() {
		return addedBY;
	}
	public void setAddedBY(UserModel addedBY) {
		this.addedBY = addedBY;
	}
	public String getId() {
		return id;
	}
	public String getOfferName() {
		return offerName;
	}
	public String getDescription() {
		return description;
	}
	public Date getFromDate() {
		return fromDate;
	}
	public Date getToDate() {
		return toDate;
	}
	public String getOfferType() {
		return offerType;
	}
	public int getType() {
		return type;
	}
	public int getPercentage() {
		return percentage;
	}
	public int getMaxDiscountPrice() {
		return maxDiscountPrice;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setOfferName(String offerName) {
		this.offerName = offerName;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public void setType(int type) {
		this.type = type;
	}
	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}
	public void setMaxDiscountPrice(int maxDiscountPrice) {
		this.maxDiscountPrice = maxDiscountPrice;
	}
	public PoojaOfferings getPoojaOfferings() {
		return poojaOfferings;
	}
	public PoojaMaterial getPoojaMaterial() {
		return poojaMaterial;
	}
	public Grammerce getGrammerce() {
		return grammerce;
	}
	public void setPoojaOfferings(PoojaOfferings poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
	}
	public void setPoojaMaterial(PoojaMaterial poojaMaterial) {
		this.poojaMaterial = poojaMaterial;
	}
	public void setGrammerce(Grammerce grammerce) {
		this.grammerce = grammerce;
	}
	
	
	

}
