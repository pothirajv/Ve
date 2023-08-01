package com.vedagram.user;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.vedagram.deity.Deity;
import com.vedagram.deity.DeityDto;
import com.vedagram.tempadmin.PoojaOfferings;

public class PoojaOfferingDeityDto implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private DeityDto deityDto;

	private List<PoojaOfferings> poojaOfferings;

	

	public DeityDto getDeityDto() {
		return deityDto;
	}
	public void setDeityDto(DeityDto deityDto) {
		this.deityDto = deityDto;
	}
	public List<PoojaOfferings> getPoojaOfferings() {
		return poojaOfferings;
	}
	public void setPoojaOfferings(List<PoojaOfferings> poojaOfferings) {
		this.poojaOfferings = poojaOfferings;
	}
	

}
