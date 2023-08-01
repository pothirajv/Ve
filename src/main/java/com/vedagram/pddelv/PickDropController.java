/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.pddelv;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.deity.DeityDto;
import com.vedagram.deity.DeityService;
import com.vedagram.payment.UserPurchaseModelForPay;
import com.vedagram.support.util.Utility;
import com.vedagram.user.PoojaOfferingOrders;




@Controller
@RequestMapping(path = "/pd/")
public class PickDropController {
	@Autowired
	PickDropService pickDropService;
	private static final Logger LOGGER = LoggerFactory.getLogger(PickDropController.class);
	
	@RequestMapping(path="deliveryInit",method=RequestMethod.POST)
	public PickDropShipmentResDto createDelivery(PickDropShipmentReqDto pickDropShipmentReqDto) {
		return pickDropService.createDelivery(pickDropShipmentReqDto);
	}
	
}
