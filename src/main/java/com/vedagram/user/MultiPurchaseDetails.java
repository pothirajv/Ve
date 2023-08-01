package com.vedagram.user;

import java.util.ArrayList;
import java.util.List;

public class MultiPurchaseDetails {
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getResOrderId() {
		return resOrderId;
	}
	public void setResOrderId(String resOrderId) {
		this.resOrderId = resOrderId;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getMultiPurchOrdId() {
		return multiPurchOrdId;
	}
	public void setMultiPurchOrdId(String multiPurchOrdId) {
		this.multiPurchOrdId = multiPurchOrdId;
	}
	public String getCartPayRefId() {
		return cartPayRefId;
	}
	public void setCartPayRefId(String cartPayRefId) {
		this.cartPayRefId = cartPayRefId;
	}
	double amount;
	String paymentId;
	String orderId;
	String resOrderId;
	String signature;
	String multiPurchOrdId;
	String cartPayRefId;
}
