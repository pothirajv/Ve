package com.vedagram.tempadmin;

import java.util.List;

import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.PoojaOfferingOrdersStatusDto;

public class PoojaOfferingOrdersDto {
private PoojaOfferingOrders poojaOfferingOrders;
private List<PoojaOfferingOrdersStatusDto> poojaOfferingOrdersStatusList;

public PoojaOfferingOrders getPoojaOfferingOrders() {
	return poojaOfferingOrders;
}
public List<PoojaOfferingOrdersStatusDto> getPoojaOfferingOrdersStatusList() {
	return poojaOfferingOrdersStatusList;
}
public void setPoojaOfferingOrders(PoojaOfferingOrders poojaOfferingOrders) {
	this.poojaOfferingOrders = poojaOfferingOrders;
}
public void setPoojaOfferingOrdersStatusList(List<PoojaOfferingOrdersStatusDto> poojaOfferingOrdersStatusList) {
	this.poojaOfferingOrdersStatusList = poojaOfferingOrdersStatusList;
}


}
