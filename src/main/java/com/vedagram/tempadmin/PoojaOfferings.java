package com.vedagram.tempadmin;




import java.io.Serializable;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;

@Document(collection = "PoojaOfferings")
public class PoojaOfferings implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
    @Indexed
	String id;
	String name;
	String description;
	String offeringTime;
	float price;
	@DBRef
	Temples temple;
	@DBRef
	Deity deity;
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
	public String getOfferingTime() {
		return offeringTime;
	}
	public void setOfferingTime(String offeringTime) {
		this.offeringTime = offeringTime;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}




