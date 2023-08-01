package com.vedagram.user;

import java.util.Date;
import java.util.List;

import com.vedagram.admin.adm.GrammerceDto;

public class GrammercePurchaseDto {
	
	
	private String name;
	private String contactNumber;
	private String emailId;
	private String deliveryAddress;
	private List<GrammerceDto> listOfGrammerceDto;
	private boolean giftFlag;
	private String giftNote;
	private String giftedBY;
	private Date expDeliveryDate;
	
	public boolean isGiftFlag() {
		return giftFlag;
	}
	public String getGiftNote() {
		return giftNote;
	}
	public String getGiftedBY() {
		return giftedBY;
	}
	public void setGiftFlag(boolean giftFlag) {
		this.giftFlag = giftFlag;
	}
	public void setGiftNote(String giftNote) {
		this.giftNote = giftNote;
	}
	public void setGiftedBY(String giftedBY) {
		this.giftedBY = giftedBY;
	}
	public List<GrammerceDto> getListOfGrammerceDto() {
		return listOfGrammerceDto;
	}
	public void setListOfGrammerceDto(List<GrammerceDto> listOfGrammerceDto) {
		this.listOfGrammerceDto = listOfGrammerceDto;
	}
	public String getName() {
		return name;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public String getEmailId() {
		return emailId;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	private String totalPrice;

	public Date getExpDeliveryDate() {
		return expDeliveryDate;
	}
	public void setExpDeliveryDate(Date expDeliveryDate) {
		this.expDeliveryDate = expDeliveryDate;
	}

	
	

}
