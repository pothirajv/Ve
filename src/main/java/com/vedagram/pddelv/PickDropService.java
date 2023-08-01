/**
 * 
 */
package com.vedagram.pddelv;

import com.vedagram.user.RequestStatusMainDto;

/**
 * @author Winston
 * 
 */
public interface PickDropService {

	public PickDropShipmentResDto createDelivery(PickDropShipmentReqDto pickDropShipmentReqDto);

	public String getDeliveryStatus(RequestStatusMainDto requestStatusMainDto);

//	public PickDropShipmentResDto cancelDelivery(PickDropShipmentReqDto pickDropShipmentReqDto);
//	
//	public PickDropShipmentResDto getDeliveryStatus(PickDropShipmentReqDto pickDropShipmentReqDto);

}
