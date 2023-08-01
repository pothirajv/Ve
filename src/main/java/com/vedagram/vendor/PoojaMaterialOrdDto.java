package com.vedagram.vendor;

import java.util.Date;

import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.tempadmin.Temples;

public class PoojaMaterialOrdDto {
	private String id;
	private Temples temples;
	private PoojaMaterialDto poojaMaterialDto;
	private UserModel userModel;
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
	private Double delChargePerDay;
	private int totalPaidAmount;

	
	public String getId() {
		return id;
	}

	public Double getDelChargePerDay() {
		return delChargePerDay;
	}

	public void setDelChargePerDay(Double delChargePerDay) {
		this.delChargePerDay = delChargePerDay;
	}

	public Temples getTemples() {
		return temples;
	}

	public PoojaMaterialDto getPoojaMaterialDto() {
		return poojaMaterialDto;
	}

	public UserModel getUserModel() {
		return userModel;
	}

	public Deity getDeity() {
		return deity;
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

	public int getQuantity() {
		return quantity;
	}

	public Double getPdAmt() {
		return pdAmt;
	}

	public int getTotalPaidAmount() {
		return totalPaidAmount;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setTemples(Temples temples) {
		this.temples = temples;
	}

	public void setPoojaMaterialDto(PoojaMaterialDto poojaMaterialDto) {
		this.poojaMaterialDto = poojaMaterialDto;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public void setDeity(Deity deity) {
		this.deity = deity;
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

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void setPdAmt(Double pdAmt) {
		this.pdAmt = pdAmt;
	}

	public void setTotalPaidAmount(int totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}

}
