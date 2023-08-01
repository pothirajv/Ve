package com.vedagram.tempadmin;




import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.domainmodel.UserModel;

@Document(collection = "OfferingsAndSignificance")
public class OfferingsAndSignificance implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
    @Indexed
	String id;
	 String offeringName;
	 String significance;
	 @DBRef
	 Temples temples;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOfferingName() {
		return offeringName;
	}
	public void setOfferingName(String offeringName) {
		this.offeringName = offeringName;
	}
	public String getSignificance() {
		return significance;
	}
	public void setSignificance(String significance) {
		this.significance = significance;
	}
	public Temples getTemples() {
		return temples;
	}
	public void setTemples(Temples temples) {
		this.temples = temples;
	}
	
}




