/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.tempadmin;



import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.deity.Deity;


public class PoojaOfferingsDto  {
	String id;
	String name;
	String description;
	String offeringTime;
	
	float price;
	Temples temple;
	Deity deity;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public Temples getTemple() {
		return temple;
	}
	public void setTemple(Temples temple) {
		this.temple = temple;
	}
	public Deity getDeity() {
		return deity;
	}
	public void setDeity(Deity deity) {
		this.deity = deity;
	}
	public String getOfferingTime() {
		return offeringTime;
	}
	public void setOfferingTime(String offeringTime) {
		this.offeringTime = offeringTime;
	}
	
}