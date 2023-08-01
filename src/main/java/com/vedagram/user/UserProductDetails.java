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

@Document(collection = "UserProductDetails")
public class UserProductDetails implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
    @Indexed
	String id;
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
	public int getBookedQuantity() {
		return bookedQuantity;
	}
	public void setBookedQuantity(int bookedQuantity) {
		this.bookedQuantity = bookedQuantity;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@DBRef
	UserCartDetails userCartDetails;
	private int bookedQuantity;
	
}
