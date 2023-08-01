package com.vedagram.user;

import java.util.List;

import com.vedagram.deity.DeityDto;
import com.vedagram.vendor.PoojaMaterialDto;

public class PoojaMaterialDeityDto {

	private List<DeityDto> deityList;
	private List<PoojaMaterialDto> materialList;
	public List<DeityDto> getDeityList() {
		return deityList;
	}
	public List<PoojaMaterialDto> getMaterialList() {
		return materialList;
	}
	public void setDeityList(List<DeityDto> deityList) {
		this.deityList = deityList;
	}
	public void setMaterialList(List<PoojaMaterialDto> materialList) {
		this.materialList = materialList;
	}
	
}
