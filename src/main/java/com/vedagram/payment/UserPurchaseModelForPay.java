package com.vedagram.payment;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vedagram.admin.adm.Grammerce;
import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.projectadm.ProjectModel;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.Temples;
import com.vedagram.user.GrammerceOrders;
import com.vedagram.vendor.PoojaMaterial;
@Document(collection = "UserPurchaseModelForPay")
public class UserPurchaseModelForPay {

	
	
	String id;
	@DBRef
	UserModel userModel;
	@DBRef
	PoojaOfferings poojaOfferings;
	@DBRef
	PoojaMaterial poojaMaterial;
	@DBRef
	Grammerce grammerce;
	@DBRef
	private Temples temples;
	@DBRef
	private Deity deity;
	@DBRef
	private ProjectModel projectModel;
	@DBRef
	GrammerceOrders grammerceOrders;
	@DBRef
	CartPayRef cartPayRef;
	private String firstName;
	private String star;
	private String mailId;
	private String mobileNumber;
	private String deliveryAddress;
	private boolean prasadhamDelFlag;
	private Date fromDate;
	private Date toDate;
	private Integer noOfMonths;
	private String listOfDates;
	private boolean payDakshinaToPriestFlag;
	private Integer dakshinaAmountForPriest;
	private boolean payDakshinaToTempleFlag;
	private Integer dakshinaAmountToTemple;
	private int delFlag;
	private Date lastModifiedDate;
	private Double totalAmount;
	private String packageStatus;
	private Date createDate;
	private String paymentStatus;//PAY_INIT,PAY_COMP
	private String loginUserId;
	private String orderId;
	private int quantity;
	private int contributionAmount;
	private String purpose;
	private String remarks;
	private boolean revealFlag;
	private Double pdAmt;
	private boolean giftFlag;
	private String giftNote;
	private String giftedBy;
	private Double totalPaidAmount;
	private Date expDeliveryDate;
	
	public GrammerceOrders getGrammerceOrders() {
		return grammerceOrders;
	}
	public void setGrammerceOrders(GrammerceOrders grammerceOrders) {
		this.grammerceOrders = grammerceOrders;
	}
	public ProjectModel getProjectModel() {
		return projectModel;
	}
	public void setProjectModel(ProjectModel projectModel) {
		this.projectModel = projectModel;
	}
	public Temples getTemples() {
		return temples;
	}
	public void setTemples(Temples temples) {
		this.temples = temples;
	}
	public Deity getDeity() {
		return deity;
	}
	public void setDeity(Deity deity) {
		this.deity = deity;
	}
	public PoojaMaterial getPoojaMaterial() {
		return poojaMaterial;
	}
	public void setPoojaMaterial(PoojaMaterial poojaMaterial) {
		this.poojaMaterial = poojaMaterial;
	}
	public Grammerce getGrammerce() {
		return grammerce;
	}
	public void setGrammerce(Grammerce grammerce) {
		this.grammerce = grammerce;
	}
	public CartPayRef getCartPayRef() {
		return cartPayRef;
	}
	public void setCartPayRef(CartPayRef cartPayRef) {
		this.cartPayRef = cartPayRef;
	}
	public String getListOfDates() {
		return listOfDates;
	}
	public void setListOfDates(String listOfDates) {
		this.listOfDates = listOfDates;
	}
	public boolean isPayDakshinaToPriestFlag() {
		return payDakshinaToPriestFlag;
	}
	public void setPayDakshinaToPriestFlag(boolean payDakshinaToPriestFlag) {
		this.payDakshinaToPriestFlag = payDakshinaToPriestFlag;
	}
	public Integer getDakshinaAmountForPriest() {
		return dakshinaAmountForPriest;
	}
	public void setDakshinaAmountForPriest(Integer dakshinaAmountForPriest) {
		this.dakshinaAmountForPriest = dakshinaAmountForPriest;
	}
	public boolean isPayDakshinaToTempleFlag() {
		return payDakshinaToTempleFlag;
	}
	public void setPayDakshinaToTempleFlag(boolean payDakshinaToTempleFlag) {
		this.payDakshinaToTempleFlag = payDakshinaToTempleFlag;
	}
	public Integer getDakshinaAmountToTemple() {
		return dakshinaAmountToTemple;
	}
	public void setDakshinaAmountToTemple(Integer dakshinaAmountToTemple) {
		this.dakshinaAmountToTemple = dakshinaAmountToTemple;
	}
	public int getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(int delFlag) {
		this.delFlag = delFlag;
	}
	public Date getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(Date lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public Date getExpDeliveryDate() {
		return expDeliveryDate;
	}
	public void setExpDeliveryDate(Date expDeliveryDate) {
		this.expDeliveryDate = expDeliveryDate;
	}
	public int getContributionAmount() {
		return contributionAmount;
	}
	public void setContributionAmount(int contributionAmount) {
		this.contributionAmount = contributionAmount;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getPackageStatus() {
		return packageStatus;
	}
	public void setPackageStatus(String packageStatus) {
		this.packageStatus = packageStatus;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public Double getTotalPaidAmount() {
		return totalPaidAmount;
	}
	public void setTotalPaidAmount(Double totalPaidAmount) {
		this.totalPaidAmount = totalPaidAmount;
	}
	public boolean isGiftFlag() {
		return giftFlag;
	}
	public String getGiftNote() {
		return giftNote;
	}
	public String getGiftedBy() {
		return giftedBy;
	}
	public void setGiftFlag(boolean giftFlag) {
		this.giftFlag = giftFlag;
	}
	public void setGiftNote(String giftNote) {
		this.giftNote = giftNote;
	}
	public void setGiftedBy(String giftedBy) {
		this.giftedBy = giftedBy;
	}
	public Double getPdAmt() {
		return pdAmt;
	}
	public void setPdAmt(Double pdAmt) {
		this.pdAmt = pdAmt;
	}
	public boolean isRevealFlag() {
		return revealFlag;
	}
	public void setRevealFlag(boolean revealFlag) {
		this.revealFlag = revealFlag;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	public Double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public UserModel getUserModel() {
		return userModel;
	}
	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}
	public PoojaOfferings getPoojaOfferings() {
		return poojaOfferings;
	}
	public void setPoojaOfferings(PoojaOfferings poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public String getMailId() {
		return mailId;
	}
	public void setMailId(String mailId) {
		this.mailId = mailId;
	}
	public String getMobileNumber() {
		return mobileNumber;
	}
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public boolean isPrasadhamDelFlag() {
		return prasadhamDelFlag;
	}
	public void setPrasadhamDelFlag(boolean prasadhamDelFlag) {
		this.prasadhamDelFlag = prasadhamDelFlag;
	}
	public Date getFromDate() {
		return fromDate;
	}
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}
	public Date getToDate() {
		return toDate;
	}
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	public Integer getNoOfMonths() {
		return noOfMonths;
	}
	public void setNoOfMonths(Integer noOfMonths) {
		this.noOfMonths = noOfMonths;
	}
	

}
