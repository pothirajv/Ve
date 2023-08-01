package com.vedagram.user;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.Temples;
import com.vedagram.vendor.PoojaMaterial;

@Document(collection = "PoojaMaterialOrders")
public class PoojaMaterialOrders {
    @Id
    @Indexed
	private String id;
	@DBRef
	private Temples temples;
	@DBRef
	private PoojaMaterial poojaMaterial;
	@DBRef
	private UserModel userModel;
	@DBRef
	private Deity deity;
	
	private String name;
	private String star;
	private String listOfdates;
	private String orderNumber;
	private Date orderDate;
	private boolean payDakshinaToPriestFlag;
	private Integer dakshinaAmountForPriest;
	private boolean payDakshinaToTempleFlag;
	private Integer dakshinaAmountToTemple;
	private String totalAmount;
	private int quantity;
	private Double pdAmt;
	private int totalPaidAmount;
	
	
	public int getTotalPaidAmount() {
		return totalPaidAmount;
	}
	public void setTotalPaidAmount(int totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}
	public Double getPdAmt() {
		return pdAmt;
	}
	public void setPdAmt(Double pdAmt) {
		this.pdAmt = pdAmt;
	}
	public Deity getDeity() {
		return deity;
	}
	public void setDeity(Deity deity) {
		this.deity = deity;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getId() {
		return id;
	}
	public Temples getTemples() {
		return temples;
	}
	public PoojaMaterial getPoojaMaterial() {
		return poojaMaterial;
	}
	public UserModel getUserModel() {
		return userModel;
	}
	public String getName() {
		return name;
	}
	public String getStar() {
		return star;
	}
	public String getListOfdates() {
		return listOfdates;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public boolean isPayDakshinaToPriestFlag() {
		return payDakshinaToPriestFlag;
	}
	public Integer getDakshinaAmountForPriest() {
		return dakshinaAmountForPriest;
	}
	public boolean isPayDakshinaToTempleFlag() {
		return payDakshinaToTempleFlag;
	}
	public Integer getDakshinaAmountToTemple() {
		return dakshinaAmountToTemple;
	}
	public String getTotalAmount() {
		return totalAmount;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setTemples(Temples temples) {
		this.temples = temples;
	}
	public void setPoojaMaterial(PoojaMaterial poojaMaterial) {
		this.poojaMaterial = poojaMaterial;
	}
	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public void setListOfdates(String listOfdates) {
		this.listOfdates = listOfdates;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public void setPayDakshinaToPriestFlag(boolean payDakshinaToPriestFlag) {
		this.payDakshinaToPriestFlag = payDakshinaToPriestFlag;
	}
	public void setDakshinaAmountForPriest(Integer dakshinaAmountForPriest) {
		this.dakshinaAmountForPriest = dakshinaAmountForPriest;
	}
	public void setPayDakshinaToTempleFlag(boolean payDakshinaToTempleFlag) {
		this.payDakshinaToTempleFlag = payDakshinaToTempleFlag;
	}
	public void setDakshinaAmountToTemple(Integer dakshinaAmountToTemple) {
		this.dakshinaAmountToTemple = dakshinaAmountToTemple;
	}
	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	
}
