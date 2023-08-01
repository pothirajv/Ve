package com.vedagram.vendor;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.deity.Deity;
import com.vedagram.deity.DeityDto;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropService;
import com.vedagram.pddelv.PickDropShipmentReqDto;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.Temples;
import com.vedagram.user.Location;
import com.vedagram.user.PoojaMaterialDeityDto;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.PoojaMaterialOrdersRepository;
import com.vedagram.user.PoojaMaterialOrdersStatus;
import com.vedagram.user.PoojaMaterialOrdersStatusDto;
import com.vedagram.user.PoojaMaterialOrdersStatusRepository;

@Service
public class VendorServiceImpl implements VendorService {
	@Autowired
	Environment env;
	@Autowired
	PoojaMaterialRepository poojaMaterialRepository;
	@Autowired
	Utility utility;
	@Autowired
	PoojaMaterialOrdersRepository poojaMaterialOrdersRepository;
	@Autowired
	PoojaMaterialOrdersStatusRepository poojaMaterialOrdersStatusRepository;
	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	PickDropService pickDropService;

	public String addPoojaMaterial(PoojaMaterial poojaMaterial, MultipartFile img) throws IOException {
		String extUrl = env.getProperty("ext.app.img.dir");
		String materialUrl = extUrl + "/poojaMaterials/";
		if (poojaMaterial != null && img != null) {
			PoojaMaterial materialModel = poojaMaterialRepository
					.findByProductNameAndVendorId(poojaMaterial.getProductName(), utility.getUserId());
			UserModel userModel = new UserModel();
			if (materialModel == null) {
				if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
					if (poojaMaterial.getVendorId() == null || poojaMaterial.getVendorId().isEmpty()) {
						return "Vendor not available!";
					}
					userModel.setId(poojaMaterial.getVendorId());
					poojaMaterial.setAdminCreatedId(utility.getUserId());
				} else {
					userModel.setId(utility.getUserId());
				}
				poojaMaterial.setCreatedBy(userModel);
				poojaMaterial.setActiveflag("true");
				mongoTemplate.insert(poojaMaterial);
				File newFolder = new File(materialUrl + poojaMaterial.getId());
				if (!newFolder.exists()) {
					newFolder.mkdirs();
				}
				byte[] bytes = img.getBytes();
				Path path = Paths.get(newFolder + "/" + poojaMaterial.getId() + ".jpg");
				Files.write(path, bytes);
				return "SUCCESS";
			} else {
				return "ERROR:Product Name Already Exist";
			}

		}

		return "ERROR:Invalid data";

	}

	public PoojaMaterialDto viewPoojaMaterial(String materialId) throws IOException {

		Query q = new Query(Criteria.where("_id").is(materialId));
		PoojaMaterial poojaMaterial = mongoTemplate.findOne(q, PoojaMaterial.class);

		PoojaMaterialDto poojaMaterialDto = new PoojaMaterialDto();
		poojaMaterialDto.setId(poojaMaterial.getId());
		poojaMaterialDto.setBrandName(poojaMaterial.getBrandName());
		poojaMaterialDto.setPrice(poojaMaterial.getPrice());
		poojaMaterialDto.setMaterialStock(poojaMaterial.getMaterialStock());
		poojaMaterialDto.setCreatedBy(poojaMaterial.getCreatedBy());
		poojaMaterialDto.setProductName(poojaMaterial.getProductName());
		poojaMaterialDto.setQuantity(poojaMaterial.getQuantity());
		poojaMaterialDto.setPackageSize(poojaMaterial.getPackageSize());
		poojaMaterialDto.setPackageUnit(poojaMaterial.getPackageUnit());
		poojaMaterialDto.setActiveComment(poojaMaterial.getActiveComment());
		poojaMaterialDto.setInactiveComment(poojaMaterial.getInactiveComment());

		String extUrl = env.getProperty("ext.app.img.dir");
		String materialUrl = extUrl + "/poojaMaterials/" + poojaMaterial.getId() + '/' + poojaMaterial.getId() + ".jpg";

		File materialImg = new File(materialUrl);
		if (materialImg.exists()) {
			String imgUrl = env.getProperty("app.img.dir") + "/poojaMaterials/" + poojaMaterial.getId() + "/"
					+ poojaMaterial.getId() + ".jpg";
			poojaMaterialDto.setImage(imgUrl);
		}

		return poojaMaterialDto;
	}

	public List<PoojaMaterialDto> showAllPoojaMaterialForVendor(String vendorId) throws Exception {
		List<PoojaMaterial> poojaMaterialList = new ArrayList<>();
		if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if (vendorId == null || vendorId.isEmpty()) {
				throw new Exception("VendorId Required");
			}
			poojaMaterialList = poojaMaterialRepository.findByCreatedById(vendorId);
		} else {
			poojaMaterialList = poojaMaterialRepository.findByCreatedById(utility.getUserId());
		}

		List<PoojaMaterialDto> poojaMateriaDtolList = new ArrayList<PoojaMaterialDto>();
		for (PoojaMaterial poojaMaterial : poojaMaterialList) {
			PoojaMaterialDto poojaMaterialDto = new PoojaMaterialDto();
			poojaMaterialDto.setId(poojaMaterial.getId());
			poojaMaterialDto.setBrandName(poojaMaterial.getBrandName());
			poojaMaterialDto.setPrice(poojaMaterial.getPrice());
			poojaMaterialDto.setMaterialStock(poojaMaterial.getMaterialStock());
			poojaMaterialDto.setCreatedBy(poojaMaterial.getCreatedBy());
			poojaMaterialDto.setProductName(poojaMaterial.getProductName());
			poojaMaterialDto.setQuantity(poojaMaterial.getQuantity());
			poojaMaterialDto.setPackageSize(poojaMaterial.getPackageSize());
			poojaMaterialDto.setPackageUnit(poojaMaterial.getPackageUnit());
			poojaMaterialDto.setActiveFlag(poojaMaterial.getActiveflag());
			poojaMaterialDto.setActiveComment(poojaMaterial.getActiveComment());
			poojaMaterialDto.setInactiveComment(poojaMaterial.getInactiveComment());

			String extUrl = env.getProperty("ext.app.img.dir");
			String materialUrl = extUrl + "/poojaMaterials/" + poojaMaterial.getId() + '/' + poojaMaterial.getId()
					+ ".jpg";

			File dietyImg = new File(materialUrl);
			if (dietyImg.exists()) {
				String imgUrl = env.getProperty("app.img.dir") + "/poojaMaterials/" + poojaMaterial.getId() + "/"
						+ poojaMaterial.getId() + ".jpg";
				poojaMaterialDto.setImage(imgUrl);
			} else {
				String imgUrl = env.getProperty("app.url") + "/images/noimage.png";
				poojaMaterialDto.setImage(imgUrl);
			}
			poojaMateriaDtolList.add(poojaMaterialDto);
		}

		return poojaMateriaDtolList;
	}

	public String updatePoojaMaterial(PoojaMaterial poojaMaterial, MultipartFile img) throws IOException {
		Query query = new Query(Criteria.where("_id").is(poojaMaterial.getId()));
		PoojaMaterial materialModel = mongoTemplate.findOne(query, PoojaMaterial.class);

		if (materialModel != null) {
			String vendorId = null;
			if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
				if (poojaMaterial.getVendorId() == null || poojaMaterial.getVendorId().isEmpty()) {
					return "Vendor not available!";
				}
				vendorId = poojaMaterial.getVendorId();
			} else {
				vendorId = utility.getUserId();
			}
			PoojaMaterial otherMaterialModel = poojaMaterialRepository.findByProductNameAndVendorIdAndIdNot(
					poojaMaterial.getProductName(), vendorId, poojaMaterial.getId());
			if (otherMaterialModel != null) {
				return "ERROR:productName Already Exist";
			}

			Query searchMaterialQuery = new Query(Criteria.where("_id").is(poojaMaterial.getId()));
			Update update = new Update();

			update.set("brandName", poojaMaterial.getBrandName());
			update.set("price", poojaMaterial.getPrice());
			update.set("materialStock", poojaMaterial.getMaterialStock());
			update.set("quantity", poojaMaterial.getQuantity());
			update.set("packageSize", poojaMaterial.getPackageSize());
			update.set("packageUnit", poojaMaterial.getPackageUnit());
			mongoTemplate.findAndModify(searchMaterialQuery, update, new FindAndModifyOptions().returnNew(true),
					PoojaMaterial.class);

			if (img != null && !img.isEmpty()) {
				String extUrl = env.getProperty("ext.app.img.dir");
				String materialUrl = extUrl + "/poojaMaterials/";

				File newFolder = new File(materialUrl + poojaMaterial.getId());
				byte[] bytes = img.getBytes();
				Path path = Paths.get(newFolder + "/" + poojaMaterial.getId() + ".jpg");

				if (Files.exists(path)) {
					Files.delete(path);
				}

				if (!newFolder.exists()) {
					newFolder.mkdirs();
				}

				Files.write(path, bytes);
			}

			return "SUCCESS";
		}

		return "ERROR:Invalid data";

	}

	// for user to view all PoojaMaterial
	public PoojaMaterialDeityDto showAllPoojaMaterial(String templeId) throws IOException {
		PoojaMaterialDeityDto materialDeityDto = new PoojaMaterialDeityDto();
		Query query = new Query(Criteria.where("temple").is(templeId));
		List<PoojaOfferings> filteredVals = mongoTemplate.find(query, PoojaOfferings.class);
		Set<String> deityIds1 = new HashSet<>();
		for (PoojaOfferings offering : filteredVals) {
			List<String> deityIds = new ArrayList<>();
			if (offering.getDeity().isActiveFlag()) {
				deityIds.add(offering.getDeity().getId());
				deityIds1.addAll(deityIds);
			}
		}
		Query query1 = new Query(Criteria.where("id").in(deityIds1));
		List<Deity> deities = mongoTemplate.find(query1, Deity.class);
		List<DeityDto> deityList = new ArrayList<>();
		for (Deity deity : deities) {
			DeityDto deityDto = new DeityDto();
			deityDto.setId(deity.getId());
			deityDto.setDeityName(deity.getDeityName());
			deityDto.setDeityDescription(deity.getDeityDescription());

			String extUrl = env.getProperty("ext.app.img.dir");
			String dietyUrl = extUrl + "/deity/" + deity.getId() + '/' + deity.getId() + ".jpg";

			File dietyImg = new File(dietyUrl);
			if (dietyImg.exists()) {
				String imgUrl = env.getProperty("app.img.dir") + "/deity/" + deity.getId() + "/" + deity.getId()
						+ ".jpg";
				deityDto.setImage(imgUrl);
			}
			deityList.add(deityDto);
		}
		materialDeityDto.setDeityList(deityList);

//		Show pooja materials
//		List<PoojaMaterial> poojaMaterialList = poojaMaterialRepository.findAll();
		List<PoojaMaterialDto> poojaMateriaDtolList = new ArrayList<PoojaMaterialDto>();

		Query qry1 = new Query(Criteria.where("_id").is(templeId));
		Temples templ = mongoTemplate.findOne(qry1, Temples.class);

		Query q = new Query(Criteria.where("district").is(templ.getDistrict())
				.regex(Pattern.compile(templ.getDistrict(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE)));
		List<Location> pin = mongoTemplate.find(q, Location.class);
		List<String> pinCodes = pin.stream().map(Location::getPincode).distinct().collect(Collectors.toList());

		Query qry2 = new Query(Criteria.where("role").is(GeneralConstants.ROLE_VENDOR));
		List<UserModel> vndrs = mongoTemplate.find(qry2, UserModel.class);

		for (UserModel ven : vndrs) {

			if (ven.getAddress() == null) {
				continue;
			}
			String pc = splitAddress(ven.getAddress());

			if (pinCodes.contains(pc)) {

				Query qry3 = new Query(Criteria.where("createdBy").is(ven));
				List<PoojaMaterial> poojsMaterials = mongoTemplate.find(qry3, PoojaMaterial.class);
				if (!CollectionUtils.isEmpty(poojsMaterials)) {

					for (PoojaMaterial poojaMaterial : poojsMaterials) {
						if (poojaMaterial.getActiveflag().equals("true")) {
							PoojaMaterialDto poojaMaterialDto = new PoojaMaterialDto();
							poojaMaterialDto.setId(poojaMaterial.getId());
							poojaMaterialDto.setBrandName(poojaMaterial.getBrandName());
							poojaMaterialDto.setPrice(poojaMaterial.getPrice());
							poojaMaterialDto.setMaterialStock(poojaMaterial.getMaterialStock());
							poojaMaterialDto.setCreatedBy(poojaMaterial.getCreatedBy());
							poojaMaterialDto.setProductName(poojaMaterial.getProductName());
							poojaMaterialDto.setQuantity(poojaMaterial.getQuantity());
							poojaMaterialDto.setPackageSize(poojaMaterial.getPackageSize());
							poojaMaterialDto.setPackageUnit(poojaMaterial.getPackageUnit());

							String extUrl = env.getProperty("ext.app.img.dir");
							String materialUrl = extUrl + "/poojaMaterials/" + poojaMaterial.getId() + '/'
									+ poojaMaterial.getId() + ".jpg";

							File dietyImg = new File(materialUrl);
							if (dietyImg.exists()) {
								String imgUrl = env.getProperty("app.img.dir") + "/poojaMaterials/"
										+ poojaMaterial.getId() + "/" + poojaMaterial.getId() + ".jpg";
								poojaMaterialDto.setImage(imgUrl);
							} else {
								String imgUrl = env.getProperty("app.url") + "/images/noimage.png";
								poojaMaterialDto.setImage(imgUrl);
							}
							poojaMateriaDtolList.add(poojaMaterialDto);

						}
					}
				}
			}

		}
		materialDeityDto.setMaterialList(poojaMateriaDtolList);

		return materialDeityDto;
	}

	public String splitAddress(String address) {

		String addr = address;
		String pincodeRegex = "\\b\\d{6}\\b";
		String st = null;

		String[] addrCmp = addr.split(",");
		String[] splitedAddr = new String[addrCmp.length];

		for (int i = 0; i < addrCmp.length; i++) {
			String component = addrCmp[i].trim();
			splitedAddr[i] = component;

			Pattern pattern = Pattern.compile(pincodeRegex);
			Matcher matcher = pattern.matcher(component);
			if (matcher.find()) {

				splitedAddr[i] = component.substring(0, matcher.start()).trim();
				st = splitedAddr[addrCmp.length - 1] = component.substring(matcher.start(), matcher.end());
				break;
			}
		}

		return st;
	}

	public List<PoojaMaterialDto> showAllPoojaMaterialForAdmin() throws IOException {

		List<PoojaMaterial> poojaMaterialList = poojaMaterialRepository.findAll();
		List<PoojaMaterialDto> poojaMateriaDtolList = new ArrayList<PoojaMaterialDto>();
		for (PoojaMaterial poojaMaterial : poojaMaterialList) {
			PoojaMaterialDto poojaMaterialDto = new PoojaMaterialDto();
			poojaMaterialDto.setId(poojaMaterial.getId());
			poojaMaterialDto.setBrandName(poojaMaterial.getBrandName());
			poojaMaterialDto.setPrice(poojaMaterial.getPrice());
			poojaMaterialDto.setMaterialStock(poojaMaterial.getMaterialStock());
			poojaMaterialDto.setCreatedBy(poojaMaterial.getCreatedBy());
			poojaMaterialDto.setProductName(poojaMaterial.getProductName());
			poojaMaterialDto.setQuantity(poojaMaterial.getQuantity());
			poojaMaterialDto.setPackageSize(poojaMaterial.getPackageSize());
			poojaMaterialDto.setPackageUnit(poojaMaterial.getPackageUnit());
			poojaMaterialDto.setActiveFlag(poojaMaterial.getActiveflag());
			poojaMaterialDto.setActiveComment(poojaMaterial.getActiveComment());
			poojaMaterialDto.setInactiveComment(poojaMaterial.getInactiveComment());

			String extUrl = env.getProperty("ext.app.img.dir");
			String materialUrl = extUrl + "/poojaMaterials/" + poojaMaterial.getId() + '/' + poojaMaterial.getId()
					+ ".jpg";

			File dietyImg = new File(materialUrl);
			if (dietyImg.exists()) {
				String imgUrl = env.getProperty("app.img.dir") + "/poojaMaterials/" + poojaMaterial.getId() + "/"
						+ poojaMaterial.getId() + ".jpg";
				poojaMaterialDto.setImage(imgUrl);
			} else {
				String imgUrl = env.getProperty("app.url") + "/images/noimage.png";
				poojaMaterialDto.setImage(imgUrl);
			}
			poojaMateriaDtolList.add(poojaMaterialDto);

		}
		return poojaMateriaDtolList;
	}

	@Override
	public List<PoojaMaterialOrdersDto> getAllOrdersForPoojaMaterials(String vendorId) throws Exception {

		List<PoojaMaterialOrders> poojaMaterialOrdersList = new ArrayList<PoojaMaterialOrders>();
		List<PoojaMaterialOrdersDto> poojaMaterialOrdersDtos = new ArrayList<PoojaMaterialOrdersDto>();
		if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if (vendorId == null || vendorId.isEmpty()) {
				throw new Exception("VendorId Required");
			}
			List<PoojaMaterial> materialDtos = poojaMaterialRepository.findByCreatedById(vendorId);
			List<String> materialIds = new ArrayList<String>();
			for (PoojaMaterial poojaOffering : materialDtos) {
				materialIds.add(poojaOffering.getId());
			}
			Query materialQuery = new Query(Criteria.where("poojaMaterial").in(materialIds));
			materialQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
			poojaMaterialOrdersList = mongoTemplate.find(materialQuery, PoojaMaterialOrders.class);

		} else if (utility.getUserRole().equals(GeneralConstants.ROLE_USER)) {
			Query myMaterialQuery = new Query(Criteria.where("userModel").is(utility.getUserId()));
			myMaterialQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
			poojaMaterialOrdersList = mongoTemplate.find(myMaterialQuery, PoojaMaterialOrders.class);
		} else if (utility.getUserRole().equals(GeneralConstants.ROLE_VENDOR)) {
			List<PoojaMaterial> materialDtos = poojaMaterialRepository.findByCreatedById(utility.getUserId());
			List<String> materialIds = new ArrayList<String>();
			for (PoojaMaterial poojaOffering : materialDtos) {
				materialIds.add(poojaOffering.getId());
			}
			Query materialQuery = new Query(Criteria.where("poojaMaterial").in(materialIds));
			materialQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
			poojaMaterialOrdersList = mongoTemplate.find(materialQuery, PoojaMaterialOrders.class);
		}
		for (PoojaMaterialOrders poojaMaterialOrders : poojaMaterialOrdersList) {
			PoojaMaterialOrdersDto poojaMaterialOrdersDto = new PoojaMaterialOrdersDto();

			Query query = new Query(Criteria.where("poojaMaterialOrders").is(poojaMaterialOrders.getId()));
			List<PoojaMaterialOrdersStatus> poojaMaterialOrdersStatus = mongoTemplate.find(query,
					PoojaMaterialOrdersStatus.class);
			String amt = poojaMaterialOrders.getTotalAmount();
			String amt1 = amt.split("\\.")[0];
			int totalAmount = Integer.parseInt(amt1);
			double totalOrderAmount = 0;
			totalOrderAmount = poojaMaterialOrders.getPdAmt() + totalAmount;
			if (poojaMaterialOrders.isPayDakshinaToPriestFlag() && poojaMaterialOrders.isPayDakshinaToTempleFlag()) {
				totalOrderAmount = totalOrderAmount + poojaMaterialOrders.getDakshinaAmountForPriest()
						+ poojaMaterialOrders.getDakshinaAmountToTemple();
			}

			int totalOrderAmount1 = (int) totalOrderAmount;

			PoojaMaterialDto poojaMaterialDto = new PoojaMaterialDto();
			poojaMaterialDto.setActiveComment(poojaMaterialOrders.getPoojaMaterial().getActiveComment());
			poojaMaterialDto.setActiveFlag(poojaMaterialOrders.getPoojaMaterial().getActiveflag());
			poojaMaterialDto.setCreatedBy(poojaMaterialOrders.getPoojaMaterial().getCreatedBy());
			poojaMaterialDto.setBrandName(poojaMaterialOrders.getPoojaMaterial().getBrandName());
			poojaMaterialDto.setId(poojaMaterialOrders.getPoojaMaterial().getId());
			poojaMaterialDto.setPrice(poojaMaterialOrders.getPoojaMaterial().getPrice());
			poojaMaterialDto.setProductName(poojaMaterialOrders.getPoojaMaterial().getProductName());
			poojaMaterialDto.setPackageSize(poojaMaterialOrders.getPoojaMaterial().getPackageSize());
			poojaMaterialDto.setPackageUnit(poojaMaterialOrders.getPoojaMaterial().getPackageUnit());

			String extUrl = env.getProperty("ext.app.img.dir");
			String materialUrl = extUrl + "/poojaMaterials/" + poojaMaterialOrders.getPoojaMaterial().getId() + '/'
					+ poojaMaterialOrders.getPoojaMaterial().getId() + ".jpg";

			File materialImg = new File(materialUrl);
			if (materialImg.exists()) {
				String imgUrl = env.getProperty("app.img.dir") + "/poojaMaterials/"
						+ poojaMaterialOrders.getPoojaMaterial().getId() + "/"
						+ poojaMaterialOrders.getPoojaMaterial().getId() + ".jpg";
				poojaMaterialDto.setImage(imgUrl);
			}
			PoojaMaterialOrdDto poojaMaterialOrdDto = new PoojaMaterialOrdDto();
			poojaMaterialOrdDto.setDakshinaAmountForPriest(poojaMaterialOrders.getDakshinaAmountForPriest());
			poojaMaterialOrdDto.setDakshinaAmountToTemple(poojaMaterialOrders.getDakshinaAmountToTemple());
			poojaMaterialOrdDto.setDeity(poojaMaterialOrders.getDeity());
			poojaMaterialOrdDto.setId(poojaMaterialOrders.getId());
			poojaMaterialOrdDto.setListOfdates(poojaMaterialOrders.getListOfdates());
			poojaMaterialOrdDto.setName(poojaMaterialOrders.getName());
			poojaMaterialOrdDto.setOrderNumber(poojaMaterialOrders.getOrderNumber());
			poojaMaterialOrdDto.setPayDakshinaToPriestFlag(poojaMaterialOrders.isPayDakshinaToPriestFlag());
			poojaMaterialOrdDto.setPayDakshinaToTempleFlag(poojaMaterialOrders.isPayDakshinaToTempleFlag());
			poojaMaterialOrdDto.setPdAmt(poojaMaterialOrders.getPdAmt());
			poojaMaterialOrdDto.setPoojaMaterialDto(poojaMaterialDto);
			poojaMaterialOrdDto.setQuantity(poojaMaterialOrders.getQuantity());
			poojaMaterialOrdDto.setStar(poojaMaterialOrders.getStar());
			poojaMaterialOrdDto.setTemples(poojaMaterialOrders.getTemples());
			poojaMaterialOrdDto.setTotalPaidAmount(totalOrderAmount1);
			poojaMaterialOrdDto.setTotalAmount(poojaMaterialOrders.getTotalAmount());
			poojaMaterialOrdDto.setUserModel(poojaMaterialOrders.getUserModel());
			poojaMaterialOrdDto.setOrderDate(poojaMaterialOrders.getOrderDate());
			poojaMaterialOrdDto.setPoojaMaterialDto(poojaMaterialDto);
			List<String> listOfdates = Arrays.asList(poojaMaterialOrders.getListOfdates().split("\\|\\|"));
			poojaMaterialOrdDto.setDelChargePerDay(poojaMaterialOrders.getPdAmt() / listOfdates.size());

			poojaMaterialOrdersDto.setPoojaMaterialOrdDto(poojaMaterialOrdDto);
			poojaMaterialOrdersDto.setPoojaMaterialOrdersStatusList(poojaMaterialOrdersStatus);
			poojaMaterialOrdersDtos.add(poojaMaterialOrdersDto);
		}
		return poojaMaterialOrdersDtos;
	}

	@Override
	public PickDropShipmentResDto initShippmentForPoojaMaterials(String orderId, String scheduleDt, String scheduleTm,
			String statusId) {
		String pdToken = env.getProperty("pickdroptoken");
		PoojaMaterialOrders poojaMaterialOrders = mongoTemplate.findById(orderId, PoojaMaterialOrders.class);
		PickDropShipmentReqDto pickDropShipmentReqDto = new PickDropShipmentReqDto();
		pickDropShipmentReqDto.setMerchantName("VEDAGRAM");
		pickDropShipmentReqDto.setOrderId(statusId);
		pickDropShipmentReqDto.setPackagePickupAddress(utility.getUser().getAddress());
		pickDropShipmentReqDto.setParcelType("others");
		pickDropShipmentReqDto.setPdToken(pdToken);
		pickDropShipmentReqDto.setRecieverAddress(poojaMaterialOrders.getTemples().getShippingAddress());
		pickDropShipmentReqDto.setRecieverContact(poojaMaterialOrders.getTemples().getCreatedBy().getMobileNumber());
		pickDropShipmentReqDto.setRecieverName(poojaMaterialOrders.getTemples().getCreatedBy().getFirstName());
		pickDropShipmentReqDto.setScheduleDt(scheduleDt);
		pickDropShipmentReqDto.setScheduleTm(scheduleTm);
		pickDropShipmentReqDto.setSenderContact((utility.getUser().getMobileNumber()));
		pickDropShipmentReqDto.setWeight("1");
		PickDropShipmentResDto pickDropShipmentResDto = pickDropService.createDelivery(pickDropShipmentReqDto);
		if (pickDropShipmentResDto.getPackageStatus() != null
				&& pickDropShipmentResDto.getPackageStatus().contains("OPEN")) {

			Query query = new Query(Criteria.where("id").is(statusId));
			Update update = new Update();
			update.set("shipmentDate", scheduleDt);
			update.set("shipmentTime", scheduleTm);
			update.set("status", GeneralConstants.MATERIALSTATUS_SCHEDULED);
			update.set("awbNumber", pickDropShipmentResDto.getTrackingId());
			UserModel userModel = new UserModel();
			if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
				userModel.setId(utility.getUserId());
				update.set("updatedByAdmin", userModel);
			} else if (utility.getUserRole().equals(GeneralConstants.ROLE_VENDOR)) {
				userModel.setId(utility.getUserId());
				update.set("updatedBy", userModel);
			}
			mongoTemplate.findAndModify(query, update, PoojaMaterialOrdersStatus.class);

		}
		return pickDropShipmentResDto;
	}

	@Override
	public String changeMaterialOrdersStatus(PoojaMaterialOrdersStatusDto poojaMaterialOrdersStatusDto) {

		Update update = new Update();
		if (poojaMaterialOrdersStatusDto.getStatus().equals("SHIPPED")) {
			update.set("status", GeneralConstants.MATERIALSTATUS_SHIPPED);
			update.set("lastUpdatedDate", new Date());
		} else if (poojaMaterialOrdersStatusDto.getStatus().equals("COMPLETED")) {
			update.set("status", GeneralConstants.MATERIALSTATUS_COMPLETED);
			update.set("lastUpdatedDate", new Date());
		}
		UserModel userModel = new UserModel();
		if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			userModel.setId(utility.getUserId());
			update.set("updatedByAdmin", userModel);
		} else if (utility.getUserRole().equals(GeneralConstants.ROLE_VENDOR)) {
			userModel.setId(utility.getUserId());
			update.set("updatedBy", userModel);
		}
		Criteria materialCriteria = new Criteria();
		materialCriteria.andOperator(Criteria.where("id").is(poojaMaterialOrdersStatusDto.getId()));
		Query query = new Query(materialCriteria);
		PoojaMaterialOrdersStatus poojaMaterialOrdersStatus = mongoTemplate.findAndModify(query, update,
				PoojaMaterialOrdersStatus.class);

		return poojaMaterialOrdersStatus.getStatus();

	}

	@Override
	public String setMaterialFlag(String materialId, String activeFlag, String comment) {
		Query materialQuery = new Query(Criteria.where("_id").is(materialId));
		PoojaMaterial poojaMaterial = mongoTemplate.findOne(materialQuery, PoojaMaterial.class);
		if (poojaMaterial != null) {
			Update update = new Update();
			update.set("activeflag", activeFlag);
			if (activeFlag.equals("true")) {
				update.set("activeComment", comment);
			} else {
				update.set("inactiveComment", comment);
			}

			mongoTemplate.findAndModify(materialQuery, update, PoojaMaterial.class);

		}
		return activeFlag;
	}

}
