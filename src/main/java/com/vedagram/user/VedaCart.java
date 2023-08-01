package com.vedagram.user;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.PoojaOfferings;

@Document(collection = "VedaCart")
public class VedaCart implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
    @Indexed
	String id;
	@DBRef
	UserCartDetails userCartDetails;
	@DBRef
	PoojaOfferings poojaOfferings;
	public UserProductDetails getUserProductDetails() {
		return userProductDetails;
	}
	public void setUserProductDetails(UserProductDetails userProductDetails) {
		this.userProductDetails = userProductDetails;
	}
	@DBRef
	UserProductDetails userProductDetails;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public UserCartDetails getUserCartDetails() {
		return userCartDetails;
	}
	public void setUserCartDetails(UserCartDetails userCartDetails) {
		this.userCartDetails = userCartDetails;
	}
	public PoojaOfferings getPoojaOfferings() {
		return poojaOfferings;
	}
	public void setPoojaOfferings(PoojaOfferings poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
