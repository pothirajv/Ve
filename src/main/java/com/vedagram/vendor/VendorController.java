/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.vendor;

import java.io.IOException;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.register.a.RegisterResponse;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.PoojaMaterialOrdersStatusDto;
import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.PoojaOfferingOrdersStatusDto;

/**
 *
 * @author Winston
 */
@RestController
@RequestMapping(path = "/ven/")
public class VendorController {

	@Autowired
	private VendorService vendorService;
	@Autowired
	Utility utility;
	@Autowired
	MongoTemplate mongoTemplate;

	private static final Logger LOGGER = LoggerFactory.getLogger(VendorController.class);

	@RequestMapping(path = "addPoojaMaterial", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> addPoojaMaterial(@ModelAttribute("material") @Valid PoojaMaterial poojaMaterial,
			BindingResult result, @RequestParam(value = "materialImage", required = false) MultipartFile multipartFile)
			throws IOException {
		RegisterResponse registerResponse = new RegisterResponse();
		String address = null;
		if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if (poojaMaterial.getVendorId() != null && !poojaMaterial.getVendorId().isEmpty()) {
				UserModel userModel = mongoTemplate
						.findOne(new Query(Criteria.where("_id").is(poojaMaterial.getVendorId())), UserModel.class);
				address = userModel.getAddress();
			}

		} else {
			address = utility.getUser().getAddress();
		}
		if (address == null || address.isEmpty()) {
			registerResponse.setResponseText("Add address in your profile and create material!");
			return ResponseEntity.ok(registerResponse);
		}

		if (result.hasFieldErrors("brandName")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("productName")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("price")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("materialStock")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("quantity")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("packageSize")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("packageUnit")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		}
		String msg = vendorService.addPoojaMaterial(poojaMaterial, multipartFile);
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);

	}

	@RequestMapping(path = "viewPoojaMaterial", method = RequestMethod.POST)
	@ResponseBody
	public PoojaMaterialDto viewPoojaMaterial(@RequestParam("materialId") String materialId) throws IOException {
		return vendorService.viewPoojaMaterial(materialId);
	}

	@RequestMapping(path = "showAllPoojaMaterial", method = RequestMethod.GET)
	@ResponseBody
	public List<PoojaMaterialDto> showAllPoojaMaterial(@RequestParam("vendorId") String vendorId) throws Exception {
		return vendorService.showAllPoojaMaterialForVendor(vendorId);
	}

	@RequestMapping(path = "setPoojaMaterialFlag", method = RequestMethod.POST)
	@ResponseBody
	public String setFlag(@RequestParam("materialId") String materialId, @RequestParam("activeFlag") String activeFlag,
			@RequestParam("comment") String comment) {
		return vendorService.setMaterialFlag(materialId, activeFlag, comment);

	}

	@RequestMapping(path = "updatePoojaMaterial", method = RequestMethod.POST)
	public ResponseEntity<RegisterResponse> updatePoojaMaterial(
			@ModelAttribute("material") @Valid PoojaMaterial poojaMaterial, BindingResult result,
			@RequestParam(value = "materialImage", required = false) MultipartFile multipartFile) throws IOException {

		RegisterResponse registerResponse = new RegisterResponse();
		if (result.hasFieldErrors("brandName")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("price")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("materialStock")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("quantity")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("packageSize")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("packageUnit")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		}
		String msg = vendorService.updatePoojaMaterial(poojaMaterial, multipartFile);
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);
	}

	@RequestMapping(path = "showAllOrders", method = RequestMethod.POST)
	@ResponseBody
	public List<PoojaMaterialOrdersDto> getAllOrdersForPoojaMaterials(@RequestParam("vendorId") String vendorId)
			throws Exception {
		return vendorService.getAllOrdersForPoojaMaterials(vendorId);

	}

	@RequestMapping(path = "initShippmentForPoojaMaterials", method = RequestMethod.POST)
	@ResponseBody
	public PickDropShipmentResDto initShippmentForPoojaMaterials(@RequestParam("orderId") String orderId,
			@RequestParam("scheduleDt") String scheduleDt, @RequestParam("scheduleTm") String scheduleTm,
			@RequestParam("statusId") String statusId) {
		return vendorService.initShippmentForPoojaMaterials(orderId, scheduleDt, scheduleTm, statusId);

	}

	@RequestMapping(path = "changeMaterialOrdersStatus", method = RequestMethod.POST)
	@ResponseBody
	public String changeMaterialOrdersStatus(@RequestBody PoojaMaterialOrdersStatusDto poojaMaterialOrdersStatusDto) {
		return vendorService.changeMaterialOrdersStatus(poojaMaterialOrdersStatusDto);

	}
}
