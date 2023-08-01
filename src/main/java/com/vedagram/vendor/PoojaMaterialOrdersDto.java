package com.vedagram.vendor;

import java.util.List;

import com.vedagram.user.PoojaMaterialOrdersStatus;

public class PoojaMaterialOrdersDto {
	private PoojaMaterialOrdDto poojaMaterialOrdDto;
	private List<PoojaMaterialOrdersStatus> poojaMaterialOrdersStatusList;
	
	
	public PoojaMaterialOrdDto getPoojaMaterialOrdDto() {
		return poojaMaterialOrdDto;
	}

	public void setPoojaMaterialOrdDto(PoojaMaterialOrdDto poojaMaterialOrdDto) {
		this.poojaMaterialOrdDto = poojaMaterialOrdDto;
	}

	public List<PoojaMaterialOrdersStatus> getPoojaMaterialOrdersStatusList() {
		return poojaMaterialOrdersStatusList;
	}
	
	public void setPoojaMaterialOrdersStatusList(List<PoojaMaterialOrdersStatus> poojaMaterialOrdersStatusList) {
		this.poojaMaterialOrdersStatusList = poojaMaterialOrdersStatusList;
	}
	
}
