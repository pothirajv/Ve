package com.vedagram.payment;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class PaymentInitResDto {

	private String description;
	private String image;
	private String currency;
	private String key;
	private String amount;
	private String name;
	private String email;
	private String contact;
	private String secretKey;
	private String theme;
	private String orderId;
	private String cartPayRefId;
	private Set<String> errors;

	

	public Set<String> getErrors() {
		return errors;
	}

	public void setErrors(Set<String> errors) {
		this.errors = errors;
	}

	public String getCartPayRefId() {
		return cartPayRefId;
	}

	public void setCartPayRefId(String cartPayRefId) {
		this.cartPayRefId = cartPayRefId;
	}

	private Map<String, Object> pgOption = new HashMap<String, Object>();
	private String initResMsg;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getSecretKey() {
		return secretKey;
	}

	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}

	public Map<String, Object> getPgOption() {
		return pgOption;
	}

	public void setPgOption(Map<String, Object> pgOption) {
		this.pgOption = pgOption;
	}

	public String getInitResMsg() {
		return initResMsg;
	}

	public void setInitResMsg(String initResMsg) {
		this.initResMsg = initResMsg;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

}
