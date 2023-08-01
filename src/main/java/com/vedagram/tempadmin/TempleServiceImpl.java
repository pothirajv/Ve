package com.vedagram.tempadmin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.deity.Deity;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropService;
import com.vedagram.pddelv.PickDropShipmentReqDto;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.PoojaOfferingOrdersStatus;
import com.vedagram.user.PoojaOfferingOrdersStatusDto;
import com.vedagram.user.PoojaOfferingOrdersStatusRepository;

@Service
public class TempleServiceImpl implements ITempleService {
	@Autowired
	MongoTemplate mongoTemplate;

	@Autowired
	Utility utility;

	@Autowired
	TempleRepository templeRepository;
	@Autowired
	PoojaOfferingsRepository poojaOfferingsRepository;
	@Autowired
	PoojaOfferingOrdersStatusRepository poojaOfferingOrdersStatusRepository;
	@Autowired
	FacilitiesRepository facilitiesRepository;
	@Autowired
	FestivalsRepository festivalsRepository;
	@Autowired
	PoojaOfferingsAndSignificanceRepository poojaOfferingsAndSignificanceRepository;
	@Autowired
	TempleVideoLinksRepository templeVideoLinksRepository;
	@Autowired
	Environment env;
	@Autowired
	PickDropService pickDropService;

	@Override
	public List<Temples> listOfTemples() {
		List<Temples> listOfTemples = templeRepository.findAll();
		return listOfTemples;
	}

	@Override
	public String createTemple(CreateTempleDto createTempleDto, List<MultipartFile> imgList) throws IOException {
		// TODO Auto-generated method stub
		// Save temple details
		Temples temp = new Temples();
		UserModel userModel =new UserModel();
		temp.setActiveFlag("true");
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if(createTempleDto.getTempleAdminId()==null || createTempleDto.getTempleAdminId().isEmpty()) {
				return "TempleAdmin not available!";
			}
			userModel.setId(createTempleDto.getTempleAdminId());
			temp.setAdminCreatedId(utility.getUserId());
		}
		else {
		userModel.setId(utility.getUserId());
		}
		createTempleDto.getTemplesDto().setCreatedBy(userModel);
		BeanUtils.copyProperties(createTempleDto.getTemplesDto(), temp);
		mongoTemplate.insert(temp);

		// Save pooja offerings detail
		for (PoojaOfferingsDto poojaOfferingsDto : createTempleDto.getPoojaOfferingsDto()) {
			PoojaOfferings poojaOfferings = new PoojaOfferings();
			poojaOfferingsDto.setTemple(temp);
			BeanUtils.copyProperties(poojaOfferingsDto, poojaOfferings);
			mongoTemplate.insert(poojaOfferings);
		}
		for (TempleVideoLinksDto templeVideoLinksDto : createTempleDto.getTempleVideoLinksDto()) {
			TempleVideoLinks templeVideoLinks = new TempleVideoLinks();
			templeVideoLinksDto.setTemples(temp);
			BeanUtils.copyProperties(templeVideoLinksDto, templeVideoLinks);
			mongoTemplate.insert(templeVideoLinks);
		}
		// Save facility detail of the temple
		Facilities facilities = new Facilities();
		createTempleDto.getFacilitiesDto().setTemples(temp);
		facilities.setAuditorium(createTempleDto.getFacilitiesDto().getAuditorium());
		facilities.setCabAvailablity(createTempleDto.getFacilitiesDto().getCabAvailablity());
		facilities.setCloakCounters(createTempleDto.getFacilitiesDto().getCloakCounters());
		facilities.setParkingLot(createTempleDto.getFacilitiesDto().getParkingLot());
		facilities.setPoojaProvisions(createTempleDto.getFacilitiesDto().getPoojaProvisions());
		facilities.setRestRooms(createTempleDto.getFacilitiesDto().getRestRooms());
		facilities.setSecurity(createTempleDto.getFacilitiesDto().getSecurity());
		facilities.setTemples(createTempleDto.getFacilitiesDto().getTemples());
		facilities.setBus(createTempleDto.getFacilitiesDto().getBus());
		facilities.setCar(createTempleDto.getFacilitiesDto().getCar());
		facilities.setTrain(createTempleDto.getFacilitiesDto().getTrain());
		facilities.setFlight(createTempleDto.getFacilitiesDto().getFlight());
		StringBuilder sb1 = new StringBuilder();
		String separator = "||";
		for (String shop : createTempleDto.getFacilitiesDto().getShops()) {
			sb1.append(shop).append(separator);

		}
		facilities.setShops(sb1.toString());

		// BeanUtils.copyProperties(createTempleDto.getFacilitiesDto(),facilities);
		mongoTemplate.insert(facilities);

		// Save festival detail of the temple
		for (FestivalsDto festivalsDto : createTempleDto.getFestivalsDto()) {
			Festivals festivals = new Festivals();
			festivalsDto.setTemples(temp);
			BeanUtils.copyProperties(festivalsDto, festivals);
			mongoTemplate.insert(festivals);
		}
		// Save poojaofferings and significance
		for (OfferingsAndSignificanceDto offeringsAndSignificanceDto : createTempleDto
				.getOfferingsAndSignificanceDto()) {
			OfferingsAndSignificance offeringsAndSignificance = new OfferingsAndSignificance();
			offeringsAndSignificanceDto.setTemples(temp);
			BeanUtils.copyProperties(offeringsAndSignificanceDto, offeringsAndSignificance);
			mongoTemplate.insert(offeringsAndSignificance);
		}

		String extUrl = env.getProperty("ext.app.img.dir");
		String templeUrl = extUrl + "/temple/";
		File newFolder = new File(templeUrl + temp.getId());
		// FileUtils.cleanDirectory(newFolder);
		if (!newFolder.exists()) {
			newFolder.mkdirs();
		}
		for (MultipartFile mf : imgList) {

			byte[] bytes = mf.getBytes();
			Path path = Paths.get(newFolder + "/" + mf.getOriginalFilename());
			Files.write(path, bytes);
		}
		return "Temple created Successfully";
	}

	@Override
	public List<CreateTempleDto> getAllTemplesForTempAdmin(String tempAdmId) throws Exception {
		// TODO Auto-generated method stub
		List<CreateTempleDto> createTempleDtos = new ArrayList<CreateTempleDto>();
		List<TemplesDto> templeDtos= new ArrayList<>();
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
	        if(tempAdmId==null || tempAdmId.isEmpty()) {
	        	throw new Exception("TempleAdminId Required");
	        }
			templeDtos = templeRepository.findByCreatedBy(tempAdmId);
		}
		else {
			 templeDtos = templeRepository.findByCreatedBy(utility.getUserId());
		}
		
		for (TemplesDto templeDto : templeDtos) {
			CreateTempleDto createTempleDto = new CreateTempleDto();
			List<PoojaOfferingsDto> poojaOfferingsDto = poojaOfferingsRepository.findByTempleId(templeDto.getId());
			FacilitiesDto facilitiesDto = facilitiesRepository.findByTemplesId(templeDto.getId());
			List<FestivalsDto> festivalsDto = festivalsRepository.findByTemplesId(templeDto.getId());
			List<TempleVideoLinksDto> templeVideoLinksDto = templeVideoLinksRepository
					.findByTemplesId(templeDto.getId());
			List<OfferingsAndSignificanceDto> offeringsAndSignificanceDto = poojaOfferingsAndSignificanceRepository
					.findByTemplesId(templeDto.getId());
			createTempleDto.setPoojaOfferingsDto(poojaOfferingsDto);
			createTempleDto.setFacilitiesDto(facilitiesDto);
			createTempleDto.setFestivalsDto(festivalsDto);
			createTempleDto.setOfferingsAndSignificanceDto(offeringsAndSignificanceDto);
			createTempleDto.setTemplesDto(templeDto);
			createTempleDto.setTempleVideoLinksDto(templeVideoLinksDto);
			String extUrl = env.getProperty("ext.app.img.dir");
			String tempUrl = extUrl + "/temple/" + templeDto.getId();

			File tempImg = new File(tempUrl);
			if (tempImg.exists()) {
				File[] files = tempImg.listFiles();
				List<File> sortedFiles = new ArrayList<>();

		        Arrays.sort(files, Comparator.comparingLong(File::lastModified));

		        sortedFiles.addAll(Arrays.asList(files));

				List<String> imageFilesList = new ArrayList<String>();
				for (File file : sortedFiles) {
					imageFilesList.add(env.getProperty("app.img.dir") + "/temple/" + templeDto.getId() + "/" + file.getName());
				}
				createTempleDto.setTempleImgsUrl(imageFilesList);
			}
			createTempleDtos.add(createTempleDto);
		}

		return createTempleDtos;
	}

	@Override
	public CreateTempleDto getTempleDetails(String templeId) throws IOException {
		// TODO Auto-generated method stub
		List<CreateTempleDto> createTempleDtos = new ArrayList<CreateTempleDto>();
		TemplesDto templeDto = new TemplesDto();
		List<Temples> temple = mongoTemplate.find(new Query(Criteria.where("_id").is(templeId)), Temples.class);
		BeanUtils.copyProperties(temple.get(0), templeDto);
		CreateTempleDto createTempleDto = new CreateTempleDto();
		List<PoojaOfferingsDto> poojaOfferingsDto = poojaOfferingsRepository.findByTempleId(temple.get(0).getId());
		FacilitiesDto facilitiesDto = facilitiesRepository.findByTemplesId(templeDto.getId());
		List<FestivalsDto> festivalsDto = festivalsRepository.findByTemplesId(templeDto.getId());
		List<TempleVideoLinksDto> templeVideoLinksDto = templeVideoLinksRepository.findByTemplesId(templeDto.getId());
		List<OfferingsAndSignificanceDto> offeringsAndSignificanceDto = poojaOfferingsAndSignificanceRepository
				.findByTemplesId(templeDto.getId());
		createTempleDto.setPoojaOfferingsDto(poojaOfferingsDto);
		createTempleDto.setFacilitiesDto(facilitiesDto);
		createTempleDto.setFestivalsDto(festivalsDto);
		createTempleDto.setOfferingsAndSignificanceDto(offeringsAndSignificanceDto);
		createTempleDto.setTemplesDto(templeDto);
		createTempleDto.setTempleVideoLinksDto(templeVideoLinksDto);

		String extUrl = env.getProperty("ext.app.img.dir");
		String tempUrl = extUrl + "/temple/" + templeDto.getId();
		File tempImg = new File(tempUrl);
		if (tempImg.exists()) {
			List<String> fileList = Arrays.asList(tempImg.list());
			List<String> imageFilesList = new ArrayList<String>();
			for (String s : fileList) {
				imageFilesList.add(env.getProperty("app.img.dir") + "/temple/" + templeDto.getId() + "/" + s);
			}

			createTempleDto.setTempleImgsUrl(imageFilesList);
		}

		return createTempleDto;
	}

	@Override
	public boolean updateTemple(CreateTempleDto createTempleDto, List<MultipartFile> imgList) throws IOException {
		// TODO Auto-generated method stub
		if(!createTempleDto.getVideoLinkId().equals(null)) {
			for(String VideoLinkId:createTempleDto.getVideoLinkId()) {
			templeVideoLinksRepository.deleteById(VideoLinkId);
			}
		}
		if(!createTempleDto.getLiveVideoLinkId().equals(null)) {
			for(String liveVideoLinkId:createTempleDto.getLiveVideoLinkId()) {
			templeVideoLinksRepository.deleteById(liveVideoLinkId);
			}
		}
		if(!createTempleDto.getFestivalId().equals(null)) {
			for(String festivalId:createTempleDto.getFestivalId()) {
			festivalsRepository.deleteById(festivalId);
			}
		}
		if(!createTempleDto.getOfferingAndSigId().equals(null)) {
			for(String OfferingAndSigId:createTempleDto.getOfferingAndSigId()) {
				Query query = new Query(Criteria.where("_id").is(OfferingAndSigId));
				mongoTemplate.findAndRemove(query, OfferingsAndSignificance.class);
			}
		}
		if(!createTempleDto.getTempleImgsUrl().equals(null)) {
			for(String templeImgsUrl:createTempleDto.getTempleImgsUrl()) {
				String[] arrOfStr = templeImgsUrl.split("vedaresources",2);
				String url= env.getProperty("ext.app.img.dir")+arrOfStr[1];
				File file = new File(url);
				if(file.exists()) {
					file.delete();
				}
			}
		}
		
		TempleUpdateMapperForDB templeUpdateMapperForDB = new TempleUpdateMapperForDB();
		Query templeQuery = new Query(Criteria.where("_id").is(createTempleDto.getTemplesDto().getId()));
		Update update = templeUpdateMapperForDB.updateTemple(createTempleDto.getTemplesDto());
		Temples updateTemple;
		updateTemple = mongoTemplate.findAndModify(templeQuery, update, new FindAndModifyOptions().returnNew(true),
				Temples.class);

		for (PoojaOfferingsDto poojaOfferingsDto : createTempleDto.getPoojaOfferingsDto()) {
			if (poojaOfferingsDto.getId() != null && !poojaOfferingsDto.getId().isEmpty()) {
				Query poojaOfferingsQuery = new Query(Criteria.where("_id").is(poojaOfferingsDto.getId()));
				Update updatePoojaOfferings = templeUpdateMapperForDB.updatePoojaOfferings(poojaOfferingsDto);
				PoojaOfferings poojaOfferingsUpdate;
				poojaOfferingsUpdate = mongoTemplate.findAndModify(poojaOfferingsQuery, updatePoojaOfferings,
						new FindAndModifyOptions().returnNew(true), PoojaOfferings.class);
			} else {
				Temples temp = new Temples();
				temp.setId(createTempleDto.getTemplesDto().getId());
				PoojaOfferings poojaOfferings = new PoojaOfferings();
				poojaOfferingsDto.setTemple(temp);
				BeanUtils.copyProperties(poojaOfferingsDto, poojaOfferings);
				mongoTemplate.insert(poojaOfferings);
			}
		}

		Query faclitiesQuery = new Query(Criteria.where("_id").is(createTempleDto.getFacilitiesDto().getId()));
		Update updateFacilities = templeUpdateMapperForDB.updateFacility(createTempleDto.getFacilitiesDto());

		Facilities facilitesUpdate = new Facilities();
		facilitesUpdate = mongoTemplate.findAndModify(faclitiesQuery, updateFacilities,
				new FindAndModifyOptions().returnNew(true), Facilities.class);

		for (FestivalsDto festivalsDto : createTempleDto.getFestivalsDto()) {
			if (festivalsDto.getId() != null && !festivalsDto.getId().isEmpty()) {
				Query festivalQuery = new Query(Criteria.where("_id").is(festivalsDto.getId()));
				Update updateFestival = templeUpdateMapperForDB.updateFestival(festivalsDto);
				// update.set("festivalsDto", createTempleDto.getTemplesDto());
				Festivals festivalsUpdate;
				festivalsUpdate = mongoTemplate.findAndModify(festivalQuery, updateFestival,
						new FindAndModifyOptions().returnNew(true), Festivals.class);
			} else {
				Temples temp = new Temples();
				temp.setId(createTempleDto.getTemplesDto().getId());
				festivalsDto.setTemples(temp);
				Festivals festivals = new Festivals();
				BeanUtils.copyProperties(festivalsDto, festivals);
				mongoTemplate.insert(festivals);
			}

		}

		for (TempleVideoLinksDto templeVideoLinksDto : createTempleDto.getTempleVideoLinksDto()) {
			if (templeVideoLinksDto.getId() != null && !templeVideoLinksDto.getId().isEmpty()) {
				Query videLinkQuery = new Query(Criteria.where("_id").is(templeVideoLinksDto.getId()));
				Update updateTempVideoLink = templeUpdateMapperForDB.updateTempleVideoLinks(templeVideoLinksDto);
				// update.set("festivalsDto", createTempleDto.getTemplesDto());
				TempleVideoLinks templeVideoLinks;
				templeVideoLinks = mongoTemplate.findAndModify(videLinkQuery, updateTempVideoLink,
						new FindAndModifyOptions().returnNew(true), TempleVideoLinks.class);
			} else {
				Temples temp = new Temples();
				temp.setId(createTempleDto.getTemplesDto().getId());
				TempleVideoLinks templeVideoLinks = new TempleVideoLinks();
				templeVideoLinksDto.setTemples(temp);
				BeanUtils.copyProperties(templeVideoLinksDto, templeVideoLinks);
				mongoTemplate.insert(templeVideoLinks);
			}
		}

		for (OfferingsAndSignificanceDto offeringsAndSignificanceDto : createTempleDto
				.getOfferingsAndSignificanceDto()) {
			if (offeringsAndSignificanceDto.getId() != null && !offeringsAndSignificanceDto.getId().isEmpty()) {
				Query offeringsAndSignificanceQuery = new Query(
						Criteria.where("_id").is(offeringsAndSignificanceDto.getId()));
				Update updateOfferingsAndSignificance = templeUpdateMapperForDB
						.updateOfferingsAndSignificance(offeringsAndSignificanceDto);
				// update.set("offeringsAndSignificanceDto",
				// createTempleDto.getOfferingsAndSignificanceDto());
				OfferingsAndSignificance offeringsAndSignificanceUpdate;
				offeringsAndSignificanceUpdate = mongoTemplate.findAndModify(offeringsAndSignificanceQuery,
						updateOfferingsAndSignificance, new FindAndModifyOptions().returnNew(true),
						OfferingsAndSignificance.class);
			} else {
				Temples temp = new Temples();
				temp.setId(createTempleDto.getTemplesDto().getId());
				OfferingsAndSignificance offeringsAndSignificance = new OfferingsAndSignificance();
				offeringsAndSignificanceDto.setTemples(temp);
				BeanUtils.copyProperties(offeringsAndSignificanceDto, offeringsAndSignificance);
				mongoTemplate.insert(offeringsAndSignificance);
			}

		}

		if (imgList != null && !imgList.isEmpty()) {
			String extUrl = env.getProperty("ext.app.img.dir");
			String templeUrl = extUrl + "/temple/";
			File newFolder = new File(templeUrl + createTempleDto.getTemplesDto().getId());

			for (MultipartFile mf : imgList) {

				byte[] bytes = mf.getBytes();
				Path path = Paths.get(newFolder + "/" + mf.getOriginalFilename());
				Files.write(path, bytes);
			}
		}
		return true;
	}

	@Override
	public List<PoojaOfferingOrdersDto> getAllOrdersForPoojaOfferings(String tempAdmId) throws Exception {
		// TODO Auto-generated method stub
		List<PoojaOfferingOrders> poojaOfferingOrdersList = new ArrayList<PoojaOfferingOrders>();
		List<PoojaOfferingOrdersDto> offeringOrdersDtos = new ArrayList<PoojaOfferingOrdersDto>();
		List<PoojaOfferings> poojaOfferingsLst = new ArrayList<PoojaOfferings>();
		if (utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if(tempAdmId==null || tempAdmId.isEmpty()) {
	        	throw new Exception("TempleAdminId Required");
	        }
			List<TemplesDto> templeDtos = templeRepository.findByCreatedBy(tempAdmId);
			List<String> tIds = new ArrayList<String>();
			for (TemplesDto t : templeDtos) {
				tIds.add(t.getId());
			}
			Query templeQuery = new Query(Criteria.where("temple").in(tIds));
			poojaOfferingsLst = mongoTemplate.find(templeQuery, PoojaOfferings.class);

			List<String> poojaIds = new ArrayList<String>();
			for (PoojaOfferings poojaOffering : poojaOfferingsLst) {
				poojaIds.add(poojaOffering.getId());
			}
			Query orderQuery = new Query(Criteria.where("poojaOfferings").in(poojaIds));
			orderQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));

			poojaOfferingOrdersList = mongoTemplate.find(orderQuery, PoojaOfferingOrders.class);
		} else if (utility.getUserRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
			List<TemplesDto> templeDtos = templeRepository.findByCreatedBy(utility.getUserId());
			List<String> tIds = new ArrayList<String>();
			for (TemplesDto t : templeDtos) {
				tIds.add(t.getId());
			}
			Query templeQuery = new Query(Criteria.where("temple").in(tIds));
			poojaOfferingsLst = mongoTemplate.find(templeQuery, PoojaOfferings.class);

			List<String> poojaIds = new ArrayList<String>();
			for (PoojaOfferings poojaOffering : poojaOfferingsLst) {
				poojaIds.add(poojaOffering.getId());
			}
			Query orderQuery = new Query(Criteria.where("poojaOfferings").in(poojaIds));
			orderQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));

			poojaOfferingOrdersList = mongoTemplate.find(orderQuery, PoojaOfferingOrders.class);
		} else if (utility.getUserRole().equals(GeneralConstants.ROLE_USER)) {
			Query myOrderQuery = new Query(Criteria.where("userModel").is(utility.getUserId()));
			myOrderQuery.with(new Sort(Sort.Direction.DESC, "orderDate"));
			poojaOfferingOrdersList = mongoTemplate.find(myOrderQuery, PoojaOfferingOrders.class);
		}
		for (PoojaOfferingOrders poojaOfferingOrders : poojaOfferingOrdersList) {
			PoojaOfferingOrdersDto poojaOfferingOrdersDto = new PoojaOfferingOrdersDto();
			Query query = new Query(Criteria.where("poojaOfferingOrders").is(poojaOfferingOrders.getId()));
			List<PoojaOfferingOrdersStatus> poojaOfferingOrdersStatus = mongoTemplate.find(query,
					PoojaOfferingOrdersStatus.class);
			double totalOrderAmount=0d;
			double price=(double)poojaOfferingOrders.getPoojaOfferings().getPrice();
			totalOrderAmount=(double)(poojaOfferingOrders.getPdAmt()+(price*poojaOfferingOrdersStatus.size()));
			if(poojaOfferingOrders.getUserCartDetails().isPayDakshinaToPriestFlag() && poojaOfferingOrders.getUserCartDetails().isPayDakshinaToTempleFlag()) {
				totalOrderAmount=totalOrderAmount+poojaOfferingOrders.getUserCartDetails().getDakshinaAmountForPriest()+poojaOfferingOrders.getUserCartDetails().getDakshinaAmountToTemple();
			}
			int totalOrderAmount1=(int)totalOrderAmount;
			int totalAmt=(int)(totalOrderAmount1);
			poojaOfferingOrders.setTotalPaidAmount(totalAmt);
			poojaOfferingOrdersDto.setPoojaOfferingOrders(poojaOfferingOrders);
			
			List<PoojaOfferingOrdersStatusDto> statusDtos = new ArrayList<>(); 
			for(PoojaOfferingOrdersStatus ordersStatus: poojaOfferingOrdersStatus) {
				PoojaOfferingOrdersStatusDto statusDto = new PoojaOfferingOrdersStatusDto();
				statusDto.setId(ordersStatus.getId());
				statusDto.setAwbNumber(ordersStatus.getAwbNumber());
				statusDto.setPoojaOfferingOrders(ordersStatus.getPoojaOfferingOrders());
				statusDto.setShipmentDate(ordersStatus.getShipmentDate());
				statusDto.setShipmentTime(ordersStatus.getShipmentTime());
				statusDto.setOfferingFlag(ordersStatus.isOfferingFlag());
				statusDto.setOrderedDate(ordersStatus.getOrderedDate());
				statusDto.setStatus(ordersStatus.getStatus());
				statusDto.setLastUpdatedDate(ordersStatus.getLastUpdatedDate());
			String extUrl = env.getProperty("ext.app.img.dir");
			String receiptUrl = extUrl + "/receipt/" + ordersStatus.getId() + '/' + ordersStatus.getId() + ".jpg";
			File img = new File(receiptUrl);
			if (img.exists()) {
				String imgUrl = env.getProperty("app.img.dir") + "/receipt/" + ordersStatus.getId() + "/" + ordersStatus.getId() + ".jpg";
				statusDto.setReceipt(imgUrl);		
				}
			statusDtos.add(statusDto);
			}			
			poojaOfferingOrdersDto.setPoojaOfferingOrdersStatusList(statusDtos);
			offeringOrdersDtos.add(poojaOfferingOrdersDto);
		}
		return offeringOrdersDtos;
	}

	@Override
	public PickDropShipmentResDto initShippmentForPoojaOfferings(String orderId, String scheduleDt, String scheduleTm,
			String statusId) {
		// TODO Auto-generated method stub
		String pdToken = env.getProperty("pickdroptoken");
		PoojaOfferingOrders poojaOfferingOrders = mongoTemplate.findById(orderId, PoojaOfferingOrders.class);
		PickDropShipmentReqDto pickDropShipmentReqDto = new PickDropShipmentReqDto();
		pickDropShipmentReqDto.setMerchantName("VEDAGRAM");
		pickDropShipmentReqDto.setOrderId(statusId);
		pickDropShipmentReqDto
				.setPackagePickupAddress(poojaOfferingOrders.getPoojaOfferings().getTemple().getShippingAddress());
		pickDropShipmentReqDto.setParcelType("others");
		pickDropShipmentReqDto.setPdToken(pdToken);
		pickDropShipmentReqDto.setRecieverAddress(poojaOfferingOrders.getUserCartDetails().getDeliveryAddress());
		pickDropShipmentReqDto.setRecieverContact(poojaOfferingOrders.getUserCartDetails().getMobileNumber());
		pickDropShipmentReqDto.setScheduleDt(scheduleDt);
		pickDropShipmentReqDto.setScheduleTm(scheduleTm);
		pickDropShipmentReqDto.setSenderContact((utility.getUser().getMobileNumber()));
		pickDropShipmentReqDto.setWeight("1");
		pickDropShipmentReqDto.setRecieverName(poojaOfferingOrders.getUserCartDetails().getFirstName());
		PickDropShipmentResDto pickDropShipmentResDto = pickDropService.createDelivery(pickDropShipmentReqDto);
		if (pickDropShipmentResDto.getPackageStatus() != null
				&& pickDropShipmentResDto.getPackageStatus().contains("OPEN")) {
			Query query = new Query(Criteria.where("id").is(statusId));
			Update update = new Update();
			update.set("shipmentDate", scheduleDt);
			update.set("shipmentTime", scheduleTm);
			update.set("status", GeneralConstants.POOJASTATUS_SCHEDULED);
			update.set("awbNumber", pickDropShipmentResDto.getTrackingId());
			UserModel userModel = new UserModel();
			if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
				userModel.setId(utility.getUserId());
				update.set("updatedByAdmin",userModel);
			}
			else if(utility.getUserRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
				userModel.setId(utility.getUserId());
				update.set("updatedBy",userModel);
			}
			mongoTemplate.findAndModify(query, update, PoojaOfferingOrdersStatus.class);
		}
		return pickDropShipmentResDto;
	}

	@Override
	public String changePoojaOrdersStatus(PoojaOfferingOrdersStatusDto offeringOrdersStatusDto) {

		Update update = new Update();
		if (offeringOrdersStatusDto.getStatus().equals("SHIPPED")) {
			update.set("status", GeneralConstants.POOJASTATUS_SHIPPED);
			update.set("lastUpdatedDate", new Date());
		} else if (offeringOrdersStatusDto.getStatus().equals("COMPLETED")) {
			update.set("status", GeneralConstants.POOJASTATUS_COMPLETED);
			update.set("lastUpdatedDate", new Date());
		}
		UserModel userModel = new UserModel();
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			userModel.setId(utility.getUserId());
			update.set("updatedByAdmin",userModel);
		}
		else if(utility.getUserRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
			userModel.setId(utility.getUserId());
			update.set("updatedBy",userModel);
		}
		Criteria offeringCriteria = new Criteria();
		offeringCriteria.andOperator(Criteria.where("id").is(offeringOrdersStatusDto.getId()));
		Query query = new Query(offeringCriteria);
		PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = mongoTemplate.findAndModify(query, update,
				PoojaOfferingOrdersStatus.class);

		return poojaOfferingOrdersStatus.getStatus();
	}

	@Override
	public String poojaOfferingDone(String id, boolean poojaFlag) {
		if (poojaFlag == true) {
			Query query = new Query(Criteria.where("id").is(id));
			Update update = new Update();
			update.set("offeringFlag", poojaFlag);
			UserModel userModel = new UserModel();
			if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
				userModel.setId(utility.getUserId());
				update.set("updatedByAdmin",userModel);
			}
			else if(utility.getUserRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
				userModel.setId(utility.getUserId());
				update.set("updatedBy",userModel);
			}
			mongoTemplate.findAndModify(query, update, PoojaOfferingOrdersStatus.class);
			return "PoojaOfferingDone";
		}
		return "false";
	}

	@Override
	public String uploadReceipt(String offeringId, MultipartFile receipt) throws IOException {
		if(offeringId!=null&& receipt!=null) {
		String extUrl = env.getProperty("ext.app.img.dir");
		String receiptUrl = extUrl + "/receipt/";

		File newFolder = new File(receiptUrl + offeringId);
		if (!newFolder.exists()) {
			newFolder.mkdirs();
		}
		byte[] bytes = receipt.getBytes();
		Path path = Paths.get(newFolder + "/" + offeringId + ".jpg");
		Files.write(path, bytes);
		
		Query query = new Query(Criteria.where("id").is(offeringId));
		PoojaOfferingOrdersStatus ordersStatus= mongoTemplate.findOne(query, PoojaOfferingOrdersStatus.class);
		if(ordersStatus.getPoojaOfferingOrders().getUserCartDetails().isPrasadhamDelFlag()==false) {
			Update update = new Update();
			update.set("status", GeneralConstants.POOJASTATUS_COMPLETED);
			update.set("lastUpdatedDate", new Date());
			mongoTemplate.findAndModify(query, update, PoojaOfferingOrdersStatus.class);

		}
		return "Receipt uploaded";
		
	}
		return "upload failed";

	}

}
