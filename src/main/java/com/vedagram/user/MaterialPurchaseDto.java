package com.vedagram.user;

import java.util.List;

import com.vedagram.vendor.PoojaMaterialDto;

public class MaterialPurchaseDto {
	
	private String templeId;
    private String name;
    private String star;
    private List<String> listOfdates;
    private List<MaterialDeityDto> materialDeityDto;
    private List<PoojaMaterialDto> listOfMaterialsDto;
	private boolean payDakshinaToPriestFlag;
	private Integer dakshinaAmountForPriest;
	private boolean payDakshinaToTempleFlag;
	private Integer dakshinaAmountToTemple;
	private String totalAmount;
	
    public String getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getTempleId() {
		return templeId;
	}
	public String getName() {
		return name;
	}
	public String getStar() {
		return star;
	}
	public List<String> getListOfdates() {
		return listOfdates;
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
	public void setTempleId(String templeId) {
		this.templeId = templeId;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public void setListOfdates(List<String> listOfdates) {
		this.listOfdates = listOfdates;
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
	public List<MaterialDeityDto> getMaterialDeityDto() {
		return materialDeityDto;
	}
	public void setMaterialDeityDto(List<MaterialDeityDto> materialDeityDto) {
		this.materialDeityDto = materialDeityDto;
	}
	public List<PoojaMaterialDto> getListOfMaterialsDto() {
		return listOfMaterialsDto;
	}
	public void setListOfMaterialsDto(List<PoojaMaterialDto> listOfMaterialsDto) {
		this.listOfMaterialsDto = listOfMaterialsDto;
	}
	
	
}
