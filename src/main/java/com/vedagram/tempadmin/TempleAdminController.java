/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.tempadmin;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.admin.adm.IAdminService;
import com.vedagram.deity.DeityDto;
import com.vedagram.deity.DeityService;
import com.vedagram.payment.UserPurchaseModelForPay;
import com.vedagram.pddelv.PickDropShipmentReqDto;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.support.util.Utility;
import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.PoojaOfferingOrdersStatusDto;




@Controller
@RequestMapping(path = "/tempadm/")
public class TempleAdminController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TempleAdminController.class);
	
	@Autowired
	private DeityService deityService;
	
	@Autowired
	private ITempleService templeService;
	
	@Autowired
	Utility utility;
	
	@Autowired
	IAdminService adminService;
	
	
	
//	@RequestMapping(path = "createTemple1",method = RequestMethod.POST)
//	@ResponseBody
//	public boolean createTemple1(@RequestPart("createTempleDto") CreateTempleDto createTempleDto, @RequestPart("file") List<MultipartFile> fileList) throws IOException {
//		System.out.println("IN");
//		return true;
//	}
	
	@RequestMapping(path = "createTemple",method = RequestMethod.POST)
	@ResponseBody
	public String createTemple(@RequestPart("createTempleDto") CreateTempleDto createTempleDto,@RequestPart("imgList") List<MultipartFile> imgList) throws IOException {
		String status=templeService.createTemple(createTempleDto,imgList);
		return status;
	}
	@RequestMapping(path = "getAllTemples",method = RequestMethod.POST)
	@ResponseBody
	public List<CreateTempleDto> getAllTemplesForTempAdmin(@RequestParam(value="tempAdmId",required=false) String tempAdmId) throws Exception
	{
	List<CreateTempleDto> createTemplDtoLst	=templeService.getAllTemplesForTempAdmin(tempAdmId);
		return createTemplDtoLst;
		
	}
	@RequestMapping(path = "setTempleFlag", method = RequestMethod.POST)
	@ResponseBody
	public String setFlag(@RequestParam("templeId") String templeId, @RequestParam("activeFlag") String activeFlag, @RequestParam("comment") String comment) {
		return adminService.setTempleFlag(templeId, activeFlag,comment);

	}
	
	@RequestMapping(path = "showAllDeity", method = RequestMethod.GET)
	@ResponseBody
	public List<DeityDto> showAllDeity() throws IOException {
		return deityService.showAllDeity();
	}
	
	@RequestMapping(path = "viewTemple")
	@ResponseBody
	public CreateTempleDto viewTemple(@RequestParam  String templeId) throws IOException
	{
	CreateTempleDto createTemplDtoLst	=templeService.getTempleDetails(templeId);
		return createTemplDtoLst;
		
	}
	@RequestMapping(path = "updateTemple",method = RequestMethod.POST)
	@ResponseBody
	public boolean updateTemple(@RequestPart("createTempleDto") CreateTempleDto createTempleDto,@RequestPart("imgList") List<MultipartFile> imgList) throws IOException {
		boolean status=templeService.updateTemple(createTempleDto,imgList);
		return status;
	}
	@RequestMapping(path="showAllOrders",method=RequestMethod.POST)
	@ResponseBody
	public List<PoojaOfferingOrdersDto> getAllOrdersForPoojaOfferings(@RequestParam(value="tempAdmId") String tempAdmId) throws Exception {
		return templeService.getAllOrdersForPoojaOfferings(tempAdmId);
		
	}
	@RequestMapping(path="initShippmentForPoojaOfferings",method=RequestMethod.POST)
	@ResponseBody
	public PickDropShipmentResDto initShippmentForPoojaOfferings(@RequestParam("orderId") String orderId,@RequestParam("scheduleDt")String scheduleDt,
			@RequestParam("scheduleTm")String scheduleTm,@RequestParam("statusId") String statusId) {
		return templeService.initShippmentForPoojaOfferings(orderId,scheduleDt,scheduleTm,statusId);
		
	}
	@RequestMapping(path="changePoojaOfferingOrdersStatus",method=RequestMethod.POST)
	@ResponseBody
	public String changePoojaOrdersStatus(@RequestBody PoojaOfferingOrdersStatusDto offeringOrdersStatusDto) {
		return templeService.changePoojaOrdersStatus(offeringOrdersStatusDto);
		
	}
	@RequestMapping(path="offeringDone",method=RequestMethod.POST)
	@ResponseBody
	public String poojaOfferingDone(@RequestParam("id")String id,@RequestParam("poojaFlag") boolean poojaFlag) {
		return templeService.poojaOfferingDone(id,poojaFlag);
		
	}
	@RequestMapping(path="uploadReceipt",method=RequestMethod.POST)
	@ResponseBody
	public String poojaOfferingDone(@RequestParam("offeringId")String offeringId,@RequestParam("receiptFile") MultipartFile multipartFile) throws IOException {
		return templeService.uploadReceipt(offeringId,multipartFile);
		
	}
	
}
