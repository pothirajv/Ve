package com.vedagram.user;

import static org.mockito.ArgumentMatchers.startsWith;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.ArithmeticOperators.Add;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.vedagram.admin.adm.Grammerce;
import com.vedagram.admin.adm.GrammerceDto;
import com.vedagram.deity.Deity;
import com.vedagram.deity.DeityDto;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.payment.UserPurchaseModelForPay;
import com.vedagram.payment.UserPurchaseResponse;
import com.vedagram.repository.OfferRepository;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.PoojaOfferingsDto;
import com.vedagram.tempadmin.PoojaOfferingsRepository;
import com.vedagram.tempadmin.TempleRepository;
import com.vedagram.tempadmin.Temples;
import com.vedagram.vendor.PoojaMaterial;
import com.vedagram.vendor.PoojaMaterialDto;
import com.vedagram.vendor.PoojaMaterialRepository;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	PoojaOfferingsRepository poojaOfferingsRepository;
	@Autowired
	UserCartRepository userCartRepository;
	@Autowired
	VedaCartRepository vedaCartRepository;
	@Autowired
	PoojaOfferingOrdersRepository poojaOfferingOrdersRepository;
	@Autowired
	UserProductDetailsRepository userProductDetailsRepository;
	PoojaMaterialOrdersRepository poojaMaterialOrdersRepository;
	@Autowired
	GrammerceOrdersRepository grammerceOrdersRepository;
	@Autowired
	DonationOrdersRepository donationOrdersRepository;
	@Autowired
	ProjectDonationRepository projectDonationRepository;
	@Autowired
	Utility utility;
	@Autowired
	Environment env;
	@Autowired
	OfferRepository offerRepository;
	@Autowired
	TempleRepository templeRepository;
	@Autowired
	PoojaMaterialRepository poojaMaterialRepository;

	public List<PoojaOfferingDeityDto> showPoojaOffering(String deityId, String tempId) {
		List<PoojaOfferings> filteredVals = null;
		List<PoojaOfferingDeityDto> offeringDeityDto = new ArrayList<>();
		PoojaOfferingDeityDto poojaOfferingDeityDto = null;

		if (tempId != null) {

			Query query = new Query(Criteria.where("temple").is(tempId));

			filteredVals = mongoTemplate.find(query, PoojaOfferings.class);
			Set<String> deityIds1 = new HashSet<>();
			for (PoojaOfferings offering : filteredVals) {
				List<String> deityIds = new ArrayList<>();
				deityIds.add(offering.getDeity().getId());
				deityIds1.addAll(deityIds);
			}
			for (String deity : deityIds1) {
				Query query1 = new Query(
						Criteria.where("deity").is(deity).andOperator(Criteria.where("temple").is(tempId)));
				List<PoojaOfferings> filteredVals1 = mongoTemplate.find(query1, PoojaOfferings.class);
				for (PoojaOfferings offering1 : filteredVals1) {
					poojaOfferingDeityDto = new PoojaOfferingDeityDto();
					DeityDto deityDto = new DeityDto();
					deityDto.setId(deity);
					deityDto.setDeityName(offering1.getDeity().getDeityName());
					deityDto.setDeityDescription(offering1.getDeity().getDeityDescription());

					String extUrl = env.getProperty("ext.app.img.dir");
					String dietyUrl = extUrl + "/deity/" + deity + '/' + deity + ".jpg";

					File dietyImg = new File(dietyUrl);
					if (dietyImg.exists()) {
						String imgUrl = env.getProperty("app.img.dir") + "/deity/" + deity + "/" + deity + ".jpg";
						deityDto.setImage(imgUrl);
					}
					poojaOfferingDeityDto.setDeityDto(deityDto);
					poojaOfferingDeityDto.setPoojaOfferings(filteredVals1);
					offeringDeityDto.add(poojaOfferingDeityDto);
					break;
				}

			}

		}
		return offeringDeityDto;

	}

	public List<Temples> showTempleList(TempleSearchDto templeSearchDto) {
		List<Criteria> criteriaList = new ArrayList<>();

		if (templeSearchDto.getTempleName() == null || templeSearchDto.getTempleName().isEmpty()) {
			if (templeSearchDto.getCountry() != null && !templeSearchDto.getCountry().isEmpty()) {
				Criteria criteria1 = Criteria.where("country").regex(
						Pattern.compile(templeSearchDto.getCountry(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria1);
			}

			if (templeSearchDto.getDistrict() != null && !templeSearchDto.getDistrict().isEmpty()) {
				Criteria criteria2 = Criteria.where("district").regex(Pattern.compile(templeSearchDto.getDistrict(),
						Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria2);

			}
			if (templeSearchDto.getState() != null && !templeSearchDto.getState().isEmpty()) {
				Criteria criteria3 = Criteria.where("state").regex(
						Pattern.compile(templeSearchDto.getState(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria3);

			}
			if (templeSearchDto.getVillageOrTown() != null && !templeSearchDto.getVillageOrTown().isEmpty()) {
				Criteria criteria4 = Criteria.where("villageorTown").regex(Pattern
						.compile(templeSearchDto.getVillageOrTown(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(criteria4);

			}
		} else {
			Criteria criteria5 = Criteria.where("name").regex(
					Pattern.compile(templeSearchDto.getTempleName(), Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
			criteriaList.add(criteria5);

		}
		Criteria queryCriteria = new Criteria().andOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria);
		List<Temples> templeList = mongoTemplate.find(query, Temples.class);
		List<String> tempIdList = new ArrayList<String>();
		for (Temples temples : templeList) {
			if (temples.getActiveFlag().equals("true")) {
				tempIdList.add(temples.getId());
			}
		}

		Criteria offeringCriteria = new Criteria();
		offeringCriteria.andOperator(Criteria.where("temple").in(tempIdList),
				Criteria.where("deity").is(templeSearchDto.getDeityId()));
		Query PoojaOfferingyQuery = new Query(offeringCriteria);
		List<PoojaOfferings> PoojaOfferingList = mongoTemplate.find(PoojaOfferingyQuery, PoojaOfferings.class);
		Set<Temples> temples = new HashSet<Temples>();
		List<Temples> finalTempList = new ArrayList<Temples>();
		for (PoojaOfferings poojaOfferingLists : PoojaOfferingList) {
			temples.add(poojaOfferingLists.getTemple());
		}

		finalTempList.addAll(temples);

		return finalTempList;

	}

	@Override
	public List<DeityDto> showAllDeity() {
		List<PoojaOfferings> poojaOfferingsList = mongoTemplate.findAll(PoojaOfferings.class);

		Set<String> deityIds = new HashSet<String>();
		List<Deity> listOfDeity = new ArrayList<Deity>();
		for (PoojaOfferings poojaOfferings : poojaOfferingsList) {
			if (poojaOfferings.getTemple().getActiveFlag().equals("true")) {
				if (poojaOfferings.getDeity().isActiveFlag()) {
					deityIds.add(poojaOfferings.getDeity().getId());
				}
			}
		}
		List<String> deityId = new ArrayList<String>();
		deityId.addAll(deityIds);
		Query DeityQuery = new Query(Criteria.where("_id").in(deityId));
		listOfDeity = mongoTemplate.find(DeityQuery, Deity.class);
		// listOfDeity.addAll(deityList);
		List<DeityDto> deityDtoList = new ArrayList<DeityDto>();
		for (Deity deity : listOfDeity) {
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
			deityDtoList.add(deityDto);
		}

		return deityDtoList;
	}

	@Override
	public void addToCart(VedaCartDto vedaCartDto, String userId) {
		// TODO Auto-generated method stub
		UserModel userModel = new UserModel();
		PoojaOfferings poojaOfferings = new PoojaOfferings();
		UserCartDetails userCartDetails = new UserCartDetails();
		userModel.setId(userId);
		poojaOfferings.setId(vedaCartDto.getPoojaOfferings().getId());
		if (vedaCartDto.getId() != null && !vedaCartDto.getId().isEmpty()) {
			userCartDetails.setId(vedaCartDto.getId());
		}
		userCartDetails.setUserModel(userModel);
		userCartDetails.setPoojaOfferings(poojaOfferings);
		userCartDetails.setDelFlag(3);

		userCartDetails.setStar(vedaCartDto.getStar());
		userCartDetails.setFirstName(vedaCartDto.getFirstName());
		userCartDetails.setMailId(vedaCartDto.getMailId());
		userCartDetails.setMobileNumber(vedaCartDto.getMobileNumber());
		userCartDetails.setDeliveryAddress(vedaCartDto.getDeliveryAddress());
		userCartDetails.setPrasadhamDelFlag(vedaCartDto.isPrasadhamDelFlag());
		userCartDetails.setFromDate(vedaCartDto.getFromDate());
		userCartDetails.setToDate(vedaCartDto.getToDate());
		userCartDetails.setNoOfMonths(vedaCartDto.getNoOfMonths());
		userCartDetails.setPayDakshinaToPriestFlag(vedaCartDto.isPayDakshinaToPriestFlag());
		userCartDetails.setDakshinaAmountForPriest(vedaCartDto.getDakshinaAmountForPriest());
		userCartDetails.setPayDakshinaToTempleFlag(vedaCartDto.isPayDakshinaToTempleFlag());
		userCartDetails.setDakshinaAmountToTemple(vedaCartDto.getDakshinaAmountToTemple());
		StringBuilder sb1 = new StringBuilder();
		String separator = "||";
		if (vedaCartDto.getListOfDates() != null) {
			for (String d : vedaCartDto.getListOfDates()) {

				sb1.append(d).append(separator);
			}
			userCartDetails.setListOfDates(sb1.toString());
		}
		UserCartDetails m = userCartRepository.save(userCartDetails);
		String t = m.getId();

		if (vedaCartDto.getId() == null || vedaCartDto.getId().isEmpty()) {

			VedaCart vedacart = new VedaCart();
			UserCartDetails userdet = new UserCartDetails();
			PoojaOfferings prodserv = new PoojaOfferings();
			prodserv.setId(m.getPoojaOfferings().getId());
			userdet.setId(t);
			vedacart.setPoojaOfferings(prodserv);
			vedacart.setUserCartDetails(userdet);

			UserProductDetails memprodDet = new UserProductDetails();
			int bookdQuantity = 0;
			if (vedaCartDto.getFromDate() != null && vedaCartDto.getToDate() != null) {
				long diff = vedaCartDto.getToDate().getTime() - vedaCartDto.getFromDate().getTime();
				long diffDays = diff / (24 * 60 * 60 * 1000);

				bookdQuantity += diffDays + 1;

			} else if (vedaCartDto.getNoOfMonths() != null) {
				LocalDate today = LocalDate.now();
				LocalDate futureDate = today.plusMonths(vedaCartDto.getNoOfMonths());
				bookdQuantity += today.until(futureDate, ChronoUnit.DAYS);

			} else if (vedaCartDto.getListOfDates() != null && vedaCartDto.getListOfDates().size() > 0) {
				bookdQuantity += vedaCartDto.getListOfDates().size();
			}

			memprodDet.setBookedQuantity(bookdQuantity);
			memprodDet.setUserCartDetails(userdet);
			memprodDet = userProductDetailsRepository.insert(memprodDet);

			vedacart.setUserProductDetails(memprodDet);
			mongoTemplate.save(vedacart);
		}

	}

	@Override
	public List<UserCartDetails> getByUserId(String userId) {
		// TODO Auto-generated method stub
		List<UserCartDetails> userCartDetails = userCartRepository.findByUserModelIdAndDelFlag(userId, 3);
		return userCartDetails;
	}

	@Override
	public boolean removeFromCart(String userCartDetailsId, String userId) {
		// TODO Auto-generated method stub
		// userCartRepository.removeMember(userCartDetailsIdsLst, new Date());

		// Criteria criteria= new Criteria();

		Query query = new Query(Criteria.where("_id").is(userCartDetailsId));
		// query.addCriteria(criteria);
		Update update = new Update();
		update.set("delFlag", 1);
		update.set("modifiedDate", new Date());
		mongoTemplate.findAndModify(query, update, new FindAndModifyOptions().returnNew(true), UserCartDetails.class);

		// mongoTemplate.findAndRemove(query, VedaCart.class);

		vedaCartRepository.deleteByUserCartDetailsId(userCartDetailsId);
		return true;
	}

	@Override
	public UserPurchaseResponse saveUserPurchaseDetail(UserCartDetailsDto userCartDetailsDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserPurchaseResponse savePoojaOfferingsOrder(UserCartDetails userCartDetails) {
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		PoojaOfferingOrders poojaOfferingOrders = new PoojaOfferingOrders();
		poojaOfferingOrders.setUserCartDetails(userCartDetails);
		poojaOfferingOrders.setPoojaOfferings(userCartDetails.getPoojaOfferings());
		poojaOfferingOrders.setUserModel(userCartDetails.getUserModel());
		poojaOfferingOrders.setOrderDate(new Date());
		poojaOfferingOrders = poojaOfferingOrdersRepository.save(poojaOfferingOrders);
		Criteria criteria = new Criteria();
		criteria.where("id").equals(poojaOfferingOrders.getId());
		Query query = new Query();
		query.addCriteria(criteria);
		Update update = new Update();
		update.set("orderNumber", "ORD_" + poojaOfferingOrders.getId());
		mongoTemplate.findAndModify(query, update, PoojaOfferingOrders.class);

		userPurchaseResponse.setPoojaOfferingOrdersId(poojaOfferingOrders.getId());
		return userPurchaseResponse;
	}

	@Override
	public UserPurchaseResponse saveOfferingsOrder(UserCartDetailsDto userCartDetailsDto,
			UserPurchaseModelForPay userPurchaseModelForPay) throws ParseException {

		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		Query query = new Query(Criteria.where("userModel").is(utility.getUserId()).and("delFlag").is(2));
		UserCartDetails userCartDetails = mongoTemplate.findOne(query, UserCartDetails.class);
		PoojaOfferingOrders poojaOfferingOrders = new PoojaOfferingOrders();
		poojaOfferingOrders.setUserCartDetails(userCartDetails);
		poojaOfferingOrders.setOrderDate(new Date());
		poojaOfferingOrders.setPoojaOfferings(userPurchaseModelForPay.getPoojaOfferings());
		poojaOfferingOrders.setUserModel(userPurchaseModelForPay.getUserModel());
		if (userPurchaseModelForPay.getPdAmt() != null) {
			poojaOfferingOrders.setPdAmt(userPurchaseModelForPay.getPdAmt());
		}
		int totalPaidAmount = userPurchaseModelForPay.getTotalPaidAmount().intValue();
		poojaOfferingOrders.setTotalPaidAmount(totalPaidAmount);
		poojaOfferingOrders = poojaOfferingOrdersRepository.save(poojaOfferingOrders);

		Update update = new Update();
		update.set("delFlag", 0);
		mongoTemplate.findAndModify(new Query(Criteria.where("id").is(userCartDetails.getId())), update,
				UserCartDetails.class);

		Query query1 = new Query();
		query1.with(new Sort(Sort.Direction.DESC, "orderNumber"));
		query1.limit(1);
		PoojaOfferingOrders maxObject = mongoTemplate.findOne(query1, PoojaOfferingOrders.class);
		Long awb = 0l;
		if (maxObject.getOrderNumber() == null) {
			awb = (long) 100001;
		} else {
			String max = maxObject.getOrderNumber();
			String maxVal = max.replaceAll("[^0-9]", "");
			awb = Long.parseLong(maxVal);
			awb++;
		}

		Query query2 = new Query(Criteria.where("id").is(poojaOfferingOrders.getId()));
		// query.addCriteria(criteria);
		Update update1 = new Update();
		update1.set("orderNumber", "ORD_" + awb.toString());
		PoojaOfferingOrders poojaOfferingOrdersModel = mongoTemplate.findAndModify(query2, update1,
				PoojaOfferingOrders.class);

		if (userPurchaseModelForPay.getFromDate() != null && userPurchaseModelForPay.getToDate() != null) {
			LocalDate incrementingDate = userPurchaseModelForPay.getFromDate().toInstant()
					.atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate endDate = userPurchaseModelForPay.getToDate().toInstant().atZone(ZoneId.systemDefault())
					.toLocalDate();

			List<LocalDate> allDates = new ArrayList<>();

			while (!incrementingDate.isAfter(endDate)) {
				allDates.add(incrementingDate);
				incrementingDate = incrementingDate.plusDays(1);
			}
			for (LocalDate localDate : allDates) {
				PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = new PoojaOfferingOrdersStatus();
				poojaOfferingOrdersStatus.setPoojaOfferingOrders(poojaOfferingOrdersModel);
				poojaOfferingOrdersStatus.setLastUpdatedDate(new Date());
				poojaOfferingOrdersStatus.setOrderedDate(null);
				Date d = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
				Calendar cal = Calendar.getInstance();
				cal.setTime(d);
				cal.add(Calendar.DAY_OF_MONTH, 1);
				d = cal.getTime();
				poojaOfferingOrdersStatus.setOrderedDate(d);
				poojaOfferingOrdersStatus.setStatus(GeneralConstants.POOJASTATUS_OPEN);
				mongoTemplate.save(poojaOfferingOrdersStatus);
			}

		} else if (userPurchaseModelForPay.getListOfDates() != null) {
			List<String> listOfdates = Arrays.asList(userPurchaseModelForPay.getListOfDates().split("\\|\\|"));
			for (String dates : listOfdates) {
				PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = new PoojaOfferingOrdersStatus();
				poojaOfferingOrdersStatus.setPoojaOfferingOrders(poojaOfferingOrdersModel);
				poojaOfferingOrdersStatus.setLastUpdatedDate(new Date());
				String s = dates.split("T")[0];
				Date date = new SimpleDateFormat("yyyy-MM-dd").parse(s);
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, 1);
				date = cal.getTime();
				poojaOfferingOrdersStatus.setOrderedDate(null);
				poojaOfferingOrdersStatus.setOrderedDate(date);
				poojaOfferingOrdersStatus.setStatus(GeneralConstants.POOJASTATUS_OPEN);
				mongoTemplate.save(poojaOfferingOrdersStatus);

			}
		} else if (userPurchaseModelForPay.getNoOfMonths() != null) {
			LocalDate tomorrow = LocalDate.now().plusDays(1);
			LocalDate endDate = tomorrow.plusMonths(userPurchaseModelForPay.getNoOfMonths());

			List<LocalDate> allDates = new ArrayList<>();

			while (!tomorrow.isAfter(endDate)) {
				allDates.add(tomorrow);
				tomorrow = tomorrow.plusDays(1);
				if (tomorrow.equals(endDate)) {
					break;
				}
			}
			for (LocalDate localDate : allDates) {
				PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = new PoojaOfferingOrdersStatus();
				poojaOfferingOrdersStatus.setPoojaOfferingOrders(poojaOfferingOrdersModel);
				poojaOfferingOrdersStatus.setLastUpdatedDate(new Date());
				poojaOfferingOrdersStatus.setOrderedDate(null);
				Date d = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
				Calendar cal = Calendar.getInstance();
				cal.setTime(d);
				cal.add(Calendar.DAY_OF_MONTH, 1);
				d = cal.getTime();
				poojaOfferingOrdersStatus.setOrderedDate(d);
				poojaOfferingOrdersStatus.setStatus(GeneralConstants.POOJASTATUS_OPEN);
				mongoTemplate.save(poojaOfferingOrdersStatus);
			}
		}

		userPurchaseResponse.setPoojaOfferingOrdersId(poojaOfferingOrders.getId());
		return userPurchaseResponse;

	}

	@Override
	public UserPurchaseResponse savePoojaOfferingsOrder(UserCartDetails userCartDetails,
			UserPurchaseModelForPay userPurchaseModelForPay) throws ParseException {
		// TODO Auto-generated method stub
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		PoojaOfferingOrders poojaOfferingOrders = new PoojaOfferingOrders();

		poojaOfferingOrders.setUserCartDetails(userCartDetails);
		poojaOfferingOrders.setOrderDate(new Date());
		poojaOfferingOrders.setPoojaOfferings(userPurchaseModelForPay.getPoojaOfferings());
		poojaOfferingOrders.setUserModel(userPurchaseModelForPay.getUserModel());
		if (userPurchaseModelForPay.getPdAmt() != null) {
			poojaOfferingOrders.setPdAmt(userPurchaseModelForPay.getPdAmt());
		}
		if (userPurchaseModelForPay.getTotalPaidAmount() != null) {
			int totalPaidAmount = userPurchaseModelForPay.getTotalPaidAmount().intValue();
			poojaOfferingOrders.setTotalPaidAmount(totalPaidAmount);
		}
		poojaOfferingOrders = poojaOfferingOrdersRepository.save(poojaOfferingOrders);

		// Criteria criteria= new Criteria();
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "orderNumber"));
		query.limit(1);
		PoojaOfferingOrders maxObject = mongoTemplate.findOne(query, PoojaOfferingOrders.class);
		Long awb = 0l;
		if (maxObject.getOrderNumber() == null) {
			awb = (long) 100001;
		} else {
			String max = maxObject.getOrderNumber();
			String maxVal = max.replaceAll("[^0-9]", "");
			awb = Long.parseLong(maxVal);
			awb++;
		}

		Query query1 = new Query(Criteria.where("id").is(poojaOfferingOrders.getId()));
		// query.addCriteria(criteria);
		Update update = new Update();
		update.set("orderNumber", "ORD_" + awb.toString());
		PoojaOfferingOrders poojaOfferingOrdersModel = mongoTemplate.findAndModify(query1, update,
				PoojaOfferingOrders.class);

		if (userPurchaseModelForPay.getFromDate() != null && userPurchaseModelForPay.getToDate() != null) {
			LocalDate incrementingDate = userPurchaseModelForPay.getFromDate().toInstant()
					.atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate endDate = userPurchaseModelForPay.getToDate().toInstant().atZone(ZoneId.systemDefault())
					.toLocalDate();

			List<LocalDate> allDates = new ArrayList<>();

			while (!incrementingDate.isAfter(endDate)) {
				allDates.add(incrementingDate);
				incrementingDate = incrementingDate.plusDays(1);
			}
			for (LocalDate localDate : allDates) {
				PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = new PoojaOfferingOrdersStatus();
				poojaOfferingOrdersStatus.setPoojaOfferingOrders(poojaOfferingOrdersModel);
				poojaOfferingOrdersStatus.setLastUpdatedDate(new Date());
				poojaOfferingOrdersStatus.setOrderedDate(null);
				Date d = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
				Calendar cal = Calendar.getInstance();
				cal.setTime(d);
				cal.add(Calendar.DAY_OF_MONTH, 1);
				d = cal.getTime();
				poojaOfferingOrdersStatus.setOrderedDate(d);
				poojaOfferingOrdersStatus.setStatus(GeneralConstants.POOJASTATUS_OPEN);
				mongoTemplate.save(poojaOfferingOrdersStatus);
			}

		} else if (userPurchaseModelForPay.getListOfDates() != null) {
			List<String> listOfdates = Arrays.asList(userPurchaseModelForPay.getListOfDates().split("\\|\\|"));
			for (String dates : listOfdates) {
				PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = new PoojaOfferingOrdersStatus();
				poojaOfferingOrdersStatus.setPoojaOfferingOrders(poojaOfferingOrdersModel);
				poojaOfferingOrdersStatus.setLastUpdatedDate(new Date());
				String s = dates.split("T")[0];
				Date date = new SimpleDateFormat("yyy-MM-dd").parse(s);
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.DAY_OF_MONTH, 1);
				date = cal.getTime();
				poojaOfferingOrdersStatus.setOrderedDate(null);
				poojaOfferingOrdersStatus.setOrderedDate(date);
				poojaOfferingOrdersStatus.setStatus(GeneralConstants.POOJASTATUS_OPEN);
				mongoTemplate.save(poojaOfferingOrdersStatus);

			}
		} else if (userPurchaseModelForPay.getNoOfMonths() != null) {
			LocalDate tomorrow = LocalDate.now().plusDays(1);
			LocalDate endDate = tomorrow.plusMonths(userPurchaseModelForPay.getNoOfMonths());

			List<LocalDate> allDates = new ArrayList<>();

			while (!tomorrow.isAfter(endDate)) {
				allDates.add(tomorrow);
				tomorrow = tomorrow.plusDays(1);
				if (tomorrow.equals(endDate)) {
					break;
				}
			}
			for (LocalDate localDate : allDates) {
				PoojaOfferingOrdersStatus poojaOfferingOrdersStatus = new PoojaOfferingOrdersStatus();
				poojaOfferingOrdersStatus.setPoojaOfferingOrders(poojaOfferingOrdersModel);
				poojaOfferingOrdersStatus.setLastUpdatedDate(new Date());
				poojaOfferingOrdersStatus.setOrderedDate(null);
				Date d = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
				Calendar cal = Calendar.getInstance();
				cal.setTime(d);
				cal.add(Calendar.DAY_OF_MONTH, 1);
				d = cal.getTime();
				poojaOfferingOrdersStatus.setOrderedDate(d);
				poojaOfferingOrdersStatus.setStatus(GeneralConstants.POOJASTATUS_OPEN);
				mongoTemplate.save(poojaOfferingOrdersStatus);
			}
		}

		userPurchaseResponse.setPoojaOfferingOrdersId(poojaOfferingOrders.getId());
		return userPurchaseResponse;
	}

	@Override
	public List<PoojaOfferingOrders> getMyOrders(String userId) {
		Query myOrderQuery = new Query(Criteria.where("userModel").is(utility.getUserId()));
		myOrderQuery.with(new Sort(Sort.Direction.DESC, "createdDate"));
		List<PoojaOfferingOrders> poojaOfferingOrdersList = mongoTemplate.find(myOrderQuery, PoojaOfferingOrders.class);
		return poojaOfferingOrdersList;
	}

	@Override
	public List<PoojaMaterialOrders> getMyOrdersMaterials(String userId) {
		Query myMaterialQuery = new Query(Criteria.where("userModel").is(userId));
		myMaterialQuery.with(new Sort(Sort.Direction.DESC, "createdDate"));
		List<PoojaMaterialOrders> poojaMaterialsOrdersList = mongoTemplate.find(myMaterialQuery,
				PoojaMaterialOrders.class);
		return poojaMaterialsOrdersList;
	}

	@Override
	public List<GrammerceOrders> getMyGrammerceOrders(String userId) {
		Query grammerceQuery = new Query(Criteria.where("userModel").is(userId));
		grammerceQuery.with(new Sort(Sort.Direction.DESC, "createdDate"));
		List<GrammerceOrders> grammerceOrdersList = mongoTemplate.find(grammerceQuery, GrammerceOrders.class);
		return grammerceOrdersList;
	}

	@Override
	public UserPurchaseResponse saveDonationOrders(DonationOrders donationOrders) {
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		donationOrders.setDonationDate(new Date());
		if (donationOrders.getUserModel() != null) {
			donationOrders.setUserModel(donationOrders.getUserModel());
		}
		donationOrders = donationOrdersRepository.save(donationOrders);
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "donationNumber"));
		query.limit(1);
		DonationOrders maxObject = mongoTemplate.findOne(query, DonationOrders.class);
		Long awb = 0l;
		if (maxObject.getDonationNumber() == null) {
			awb = (long) 100001;
		} else {
			String max = maxObject.getDonationNumber();
			String maxVal = max.replaceAll("[^0-9]", "");
			awb = Long.parseLong(maxVal);
			awb++;
		}
		Query query1 = new Query(Criteria.where("_id").is(donationOrders.getId()));

		Update update = new Update();
		update.set("donationNumber", "DON_" + awb.toString());
		mongoTemplate.findAndModify(query1, update, DonationOrders.class);
		userPurchaseResponse.setPoojaOfferingOrdersId(donationOrders.getId());
		return userPurchaseResponse;
	}

	@Override
	public UserPurchaseResponse donateToProject(ProjectDonation projectDonation) {
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		projectDonation.setDonationDate(new Date());
		if (projectDonation.getUserModel() != null) {
			projectDonation.setUserModel(projectDonation.getUserModel());
		}
		projectDonation = projectDonationRepository.save(projectDonation);
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "donationNumber"));
		query.limit(1);
		ProjectDonation maxObject = mongoTemplate.findOne(query, ProjectDonation.class);
		Long awb = 0l;
		if (maxObject.getDonationNumber() == null) {
			awb = (long) 100001;
		} else {
			String max = maxObject.getDonationNumber();
			String maxVal = max.replaceAll("[^0-9]", "");
			awb = Long.parseLong(maxVal);
			awb++;
		}
		Query query1 = new Query(Criteria.where("_id").is(projectDonation.getId()));
		Update update = new Update();
		update.set("donationNumber", "PRD_" + awb.toString());
		mongoTemplate.findAndModify(query1, update, ProjectDonation.class);
		userPurchaseResponse.setPoojaOfferingOrdersId(projectDonation.getId());
		return userPurchaseResponse;
	}

	@Override
	public List<DonationOrders> getMyDonations(String userId) {
		Query DonationQuery = new Query(Criteria.where("userModel").is(userId));
		DonationQuery.with(new Sort(Sort.Direction.DESC, "donationDate"));
		List<DonationOrders> DonationOrdersList = mongoTemplate.find(DonationQuery, DonationOrders.class);
		return DonationOrdersList;

	}

	@Override
	public List<ProjectDonation> myProjectDonations(String userId) {
		Query projectDonationQuery = new Query(Criteria.where("userModel").is(userId));
		projectDonationQuery.with(new Sort(Sort.Direction.DESC, "donationDate"));
		List<ProjectDonation> projectDonationOrdersList = mongoTemplate.find(projectDonationQuery,
				ProjectDonation.class);
		return projectDonationOrdersList;
	}

	@Override
	public UserPurchaseResponse savePoojaMaterialOrder(PoojaMaterialOrders poojaMaterialOrders) {
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		// PoojaMaterialOrders poojaMaterialOrders1 = new PoojaMaterialOrders();

		poojaMaterialOrders = poojaMaterialOrdersRepository.save(poojaMaterialOrders);

		Query query = new Query(Criteria.where("_id").is(poojaMaterialOrders.getId()));
		Update update = new Update();
		update.set("orderNumber", "ORD_" + poojaMaterialOrders.getId());
		mongoTemplate.findAndModify(query, update, PoojaMaterialOrders.class);

		userPurchaseResponse.setPoojaOfferingOrdersId(poojaMaterialOrders.getId());

		return userPurchaseResponse;
	}

	@Override
	public UserPurchaseResponse saveGrammerceOrders(GrammerceOrders grammerceOrders) {
		UserPurchaseResponse userPurchaseResponse = new UserPurchaseResponse();
		// GrammerceOrders grammerceOrders1 = new GrammerceOrders();

		grammerceOrders = grammerceOrdersRepository.save(grammerceOrders);
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "orderNumber"));
		query.limit(1);
		GrammerceOrders maxObject = mongoTemplate.findOne(query, GrammerceOrders.class);
		Long awb = 0l;
		if (maxObject.getOrderNumber() == null) {
			awb = (long) 100001;
		} else {
			String max = maxObject.getOrderNumber();
			String maxVal = max.replaceAll("[^0-9]", "");
			awb = Long.parseLong(maxVal);
			awb++;
		}
		Query query1 = new Query(Criteria.where("_id").is(grammerceOrders.getId()));
		Update update = new Update();
		update.set("orderNumber", "GRA_" + awb.toString());
		mongoTemplate.findAndModify(query1, update, GrammerceOrders.class);

		userPurchaseResponse.setPoojaOfferingOrdersId(grammerceOrders.getId());

		return userPurchaseResponse;

	}

	@Override
	public Double getDeliveryCharge(UserCartDetails userCartDetails) {
		// TODO Auto-generated method stub
		String url = env.getProperty("pd_getrates");
		String pdToken = env.getProperty("pickdroptoken");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("packagePickupAddress", userCartDetails.getPoojaOfferings().getTemple().getShippingAddress());
		paramMap.put("recieverAddress", userCartDetails.getDeliveryAddress());
		paramMap.put("merchantName", "VEDAGRAM");
		paramMap.put("weight", 1);
		String responseBody = httpPost(url, paramMap, pdToken);
		Double amount = (double) 0;
		if (responseBody.contains("deliveryCharge")) {
			String s2 = responseBody.split("deliveryCharge")[1];
			String s = s2.split(":")[1];
			String s3 = s.split("}")[0];
			amount = Double.parseDouble(s3);
		} else {
			amount = (double) 100;
		}
		return amount;
	}

	@Override
	public Double getDeliveryCharge(UserCartDetailsDto userCartDetailsDto) {
		// TODO Auto-generated method stub
		Query query = new Query(Criteria.where("id").is(userCartDetailsDto.getPoojaOfferings().getId()));
		PoojaOfferings offerings = mongoTemplate.findOne(query, PoojaOfferings.class);
		String url = env.getProperty("pd_getrates");
		String pdToken = env.getProperty("pickdroptoken");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("packagePickupAddress", offerings.getTemple().getShippingAddress());
		paramMap.put("recieverAddress", userCartDetailsDto.getDeliveryAddress());
		paramMap.put("merchantName", "VEDAGRAM");
		paramMap.put("weight", 1);
		String responseBody = httpPost(url, paramMap, pdToken);
		Double amount = (double) 0;
		if (responseBody.contains("deliveryCharge")) {
			String s2 = responseBody.split("deliveryCharge")[1];
			String s = s2.split(":")[1];
			String s3 = s.split("}")[0];
			amount = Double.parseDouble(s3);
		} else {
			amount = (double) 100;
		}
		return amount;
	}

	private String httpPost(String url, Map<String, Object> paramMap, String pdToken) {

		if (url == null || url.isEmpty()) {
			return "ERROR: URL NOT EXIST";
		}

		String responseBody = null;
		HttpPost httpPost = null;
		try {
			HttpClient client = HttpClientBuilder.create().build();

			Gson gsonBuilder = new GsonBuilder().create();
			String jsonFromJavaMap = gsonBuilder.toJson(paramMap);

			HttpEntity stringEntity = new StringEntity(jsonFromJavaMap, "UTF-8");

			httpPost = new HttpPost(url);
			httpPost.setEntity(stringEntity);
			httpPost.addHeader(HttpHeaders.CONTENT_TYPE, "application/json");
			httpPost.addHeader("Authorization", "Bearer " + pdToken);

			HttpResponse response = client.execute(httpPost);

			StatusLine statusLine = response.getStatusLine();
			System.out.println("Status : " + statusLine);

			InputStream inputstream = response.getEntity().getContent();
			BufferedReader rd = new BufferedReader(new InputStreamReader(inputstream));
			StringBuilder sb = new StringBuilder();
			String line = null;

			while ((line = rd.readLine()) != null) {
				sb.append(line + "\n");
			}

			responseBody = sb.toString();
			System.out.println(responseBody);
		} catch (Exception e) {
			e.printStackTrace();

			return "ERROR";
		} finally {
			httpPost.releaseConnection();
		}

		return responseBody;
	}

	@Override
	public void savePDDelvCharge(UserCartDetails userCartDetails) {
		// TODO Auto-generated method stub

		Query cartQuery = new Query(Criteria.where("_id").is(userCartDetails.getId()));
		UserCartDetails userCartDetails1 = mongoTemplate.findOne(cartQuery, UserCartDetails.class);
		if (userCartDetails1 != null) {
			Update update = new Update();
			update.set("pdDelCharge", userCartDetails.getPdDelCharge());
			mongoTemplate.findAndModify(cartQuery, update, UserCartDetails.class);
		}
	}

	@Override
	public MaterialPurchaseDto calcDelcChargeFroPoojaMaterials(MaterialPurchaseDto materialPurchaseDto) {
		// TODO Auto-generated method stub

		List<MaterialDeityDto> poojaMaterialDtoLst = new ArrayList<MaterialDeityDto>();
		for (MaterialDeityDto materialDeityDto : materialPurchaseDto.getMaterialDeityDto()) {
			Query query = new Query(Criteria.where("id").is(materialDeityDto.getMaterialId()));
			PoojaMaterial poojaMaterial = mongoTemplate.findOne(query, PoojaMaterial.class);
			Temples temp = mongoTemplate.findById(materialPurchaseDto.getTempleId(), Temples.class);
			PoojaMaterial pm = mongoTemplate.findById(materialDeityDto.getMaterialId(), PoojaMaterial.class);
			UserModel um = mongoTemplate.findById(pm.getCreatedBy().getId(), UserModel.class);
			// Temples temp=templeRepository.findById(materialPurchaseDto.getTempleId());
			String url = env.getProperty("pd_getrates");
			String pdToken = env.getProperty("pickdroptoken");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("packagePickupAddress", um.getAddress());
			paramMap.put("recieverAddress", temp.getShippingAddress());
			paramMap.put("merchantName", "VEDAGRAM");
			paramMap.put("weight", pm.getPackageSize());
			String responseBody = httpPost(url, paramMap, pdToken);
			// {"deliveryCharge":0.0}
			String s1 = responseBody.split(":")[1];
			// {"packageStatus":"SUCCESS","deliveryCharge":50.0}

			String s2 = responseBody.split("deliveryCharge")[1];
			String s = s2.split(":")[1];
			String s3 = s.split("}")[0];
			Double amount = Double.parseDouble(s3);
			materialDeityDto.setProductName(poojaMaterial.getProductName());
			materialDeityDto.setActiveFlag(poojaMaterial.getActiveflag());
			materialDeityDto.setMaterialStock(poojaMaterial.getMaterialStock());
			materialDeityDto.setDelChargePerDay(amount);
			materialDeityDto.setPdDelCharge(amount * materialPurchaseDto.getListOfdates().size());
			poojaMaterialDtoLst.add(materialDeityDto);
			materialPurchaseDto.setMaterialDeityDto(poojaMaterialDtoLst);
		}
		return materialPurchaseDto;
	}

	@Override
	public GrammercePurchaseDto calcDelcChargeForGrmmaerce(GrammercePurchaseDto grammercePurchaseDtoDto) {
		// TODO Auto-generated method stub
		List<GrammerceDto> grammerceDtos = new ArrayList<GrammerceDto>();
		for (GrammerceDto grammercedto : grammercePurchaseDtoDto.getListOfGrammerceDto()) {
			Query query = new Query(Criteria.where("id").is(grammercedto.getId()));
			Grammerce grammerce = mongoTemplate.findOne(query, Grammerce.class);

			String url = env.getProperty("pd_getrates");
			String pdToken = env.getProperty("pickdroptoken");
			Map<String, Object> paramMap = new HashMap<String, Object>();

			Criteria criteria = Criteria.where("role").is(GeneralConstants.ROLE_ADMIN);

			Query admQuery = new Query(criteria);
			UserModel userModel = mongoTemplate.findOne(admQuery, UserModel.class);
			String addr = userModel.getAddress();

			paramMap.put("packagePickupAddress", addr);
			paramMap.put("recieverAddress", grammercePurchaseDtoDto.getDeliveryAddress());
			paramMap.put("merchantName", "VEDAGRAM");
			paramMap.put("weight", 1);

			String responseBody = httpPost(url, paramMap, pdToken);
			String s2 = responseBody.split("deliveryCharge")[1];
			String s = s2.split(":")[1];
			String s3 = s.split("}")[0];
			Double amount = Double.parseDouble(s3);
			grammercedto.setActiveFlag(grammerce.getActiveFlag());
			grammercedto.setStock(grammerce.getStock());
			grammercedto.setPdDelCharge(amount);

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			calendar.add(Calendar.DAY_OF_YEAR, grammerce.getDeliveryLeadTime());
			Date expectedDate = calendar.getTime();
			grammercedto.setExpDeliveryDate(expectedDate);

			grammerceDtos.add(grammercedto);

			grammercePurchaseDtoDto.setListOfGrammerceDto(grammerceDtos);

//			Calendar calendar = Calendar.getInstance();
//			calendar.setTime(new Date());
//			calendar.add(Calendar.DAY_OF_YEAR, grammerce.getDeliveryLeadTime());
//			Date expectedDate = calendar.getTime();
//			grammercePurchaseDtoDto.setExpDeliveryDate(expectedDate);
		}
		return grammercePurchaseDtoDto;
	}

	@Override
	public VedaCartDto calcDelcChargeForOffering(VedaCartDto vedaCartDto) {

		return null;
	}

	@Override
	public String addOffer(Offer offer) {
		if (offer.getType() == 0) {
			offer.setOfferType("All");
		}
		if (offer.getType() == 1) {
			offer.setOfferType("Individual");
		}
		UserModel model = new UserModel();
		model.setId(utility.getUserId());
		offer.setAddedBY(model);
		offerRepository.save(offer);
		return "Offer Added";
	}

	@Override
	public List<Offer> showAllOffer() {
		List<Offer> offer = offerRepository.findAll();
		return offer;
	}

	@Override
	public Offer viewOffer(String offerId) {

		Query query = new Query(Criteria.where("id").is(offerId));
		Offer offer = mongoTemplate.findOne(query, Offer.class);
		return offer;
	}

	@Override
	public String updateOffer(Offer offer) {
		Query query = new Query(Criteria.where("id").is(offer.getId()));
		Update update = new Update();
		update.set("description", offer.getDescription());
		update.set("maxDiscountPrice", offer.getMaxDiscountPrice());
		update.set("offerName", offer.getOfferName());
		if (offer.getType() == 0) {
			update.set("offerType", "All");
		}
		if (offer.getType() == 1) {
			update.set("offerType", "Individual");
		}
		update.set("fromDate", offer.getToDate());
		update.set("toDate", offer.getFromDate());
		mongoTemplate.findAndModify(query, update, Offer.class);
		return "Updated Successfully";
	}

	public List<String> ShowAllStates() {

//		Query donationQuery = new Query();
//		donationQuery.with(new Sort(Sort.Direction.ASC, "stateName"));
//		List<Location> locations = mongoTemplate.find(donationQuery, Location.class);
//		List<String> states = locations.stream().map(Location::getStateName).map(String::toUpperCase).distinct()
//				.collect(Collectors.toList());

		List<String> states = new ArrayList<>();
		states.add("ANDAMAN AND NICO.IN.");
		states.add("ANDHRA PRADESH");
		states.add("ARUNACHAL PRADESH");
		states.add("ASSAM");
		states.add("BIHAR");
		states.add("CHANDIGARH");
		states.add("CHATTISGARH");
		states.add("DADRA AND NAGAR HAV.");
		states.add("DAMAN AND DIU");
		states.add("DELHI");
		states.add("GOA");
		states.add("GUJARAT");
		states.add("HARYANA");
		states.add("HIMACHAL PRADESH");
		states.add("JAMMU AND KASHMIR");
		states.add("JHARKHAND");
		states.add("KARNATAKA");
		states.add("KERALA");
		states.add("LAKSHADWEEP");
		states.add("MADHYA PRADESH");
		states.add("MAHARASHTRA");
		states.add("MANIPUR");
		states.add("MEGALAYA");
		states.add("MIZORAM");
		states.add("NAGALAND");
		states.add("ODISHA");
		states.add("PONDICHERRY");
		states.add("PUNJAB");
		states.add("RAJASTHAN");
		states.add("SIKKIM");
		states.add("TAMIL NADU");
		states.add("TELANGANA");
		states.add("TRIPURA");
		states.add("UTTAR PRADESH");
		states.add("UTTARAKHAND");
		states.add("WEST BENGAL");
		
		return states;
	}

	public List<String> showAllDistrict(LocationDto locationDto) {

		List<Criteria> criteriaList = new ArrayList<>();

		if (locationDto.getState() != null && !locationDto.getState().isEmpty()) {
			List<String> stateNames = locationDto.getState();

			List<Criteria> stateCriteria = stateNames.stream() 
					.map(state -> Criteria.where("stateName")
							.regex(Pattern.compile(state, Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE)))
					.collect(Collectors.toList());

			Criteria criteria3 = new Criteria().orOperator(stateCriteria.toArray(new Criteria[0]));
			criteriaList.add(criteria3);
		}

		Criteria queryCriteria = new Criteria().andOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria).with(new Sort(Sort.Direction.ASC, "district"));
		List<Location> distList = mongoTemplate.find(query, Location.class);
		List<String> districts = distList.stream().map(Location::getDistrict).map(String::toUpperCase).map(String::trim)
				.distinct().collect(Collectors.toList());

		return districts;

	}

	public List<String> showAllPinCode(LocationDto locationDto) {

		List<Criteria> criteriaList = new ArrayList<>();

		if (locationDto.getDistrict() != null && !locationDto.getDistrict().isEmpty()) {
			List<String> districtNames = locationDto.getDistrict();

			List<Criteria> districtCriteria = districtNames.stream()
					.map(district -> Criteria.where("district")
							.regex(Pattern.compile(district, Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE)))
					.collect(Collectors.toList());

			Criteria criteria3 = new Criteria().orOperator(districtCriteria.toArray(new Criteria[0]));
			criteriaList.add(criteria3);
		}

		Criteria queryCriteria = new Criteria().orOperator(criteriaList.toArray(new Criteria[0]));

		Query query = new Query();
		query.addCriteria(queryCriteria).with(new Sort(Sort.Direction.ASC, "pincode"));
		List<Location> pcList = mongoTemplate.find(query, Location.class);
		List<String> pinCodes = pcList.stream().map(Location::getPincode).distinct().collect(Collectors.toList());

		return pinCodes;

	}

	public Map<String, Object> pincodeValForGram(PincodeValid pincodeValid) {

		Map<String, Object> msg = new HashMap<>();
		List<String> dlv = new ArrayList<>();
		List<String> nDlv = new ArrayList<>();

		if (pincodeValid.getPincode().length() == 6) {

			Query qry1 = new Query(Criteria.where("pincode").is(pincodeValid.getPincode()));
			Location pincd = mongoTemplate.findOne(qry1, Location.class);

			if (pincd != null) {

				for (String grm : pincodeValid.getGrammerces()) {

					Query qry2 = new Query(Criteria.where("_id").is(grm));
					Grammerce gram = mongoTemplate.findOne(qry2, Grammerce.class);
					if (!CollectionUtils.isEmpty(gram.getDistrict())) {
						if(gram.getDistrict().contains(pincd.getStateName().toUpperCase()+"||"+pincd.getDistrict().toUpperCase())) {
							dlv.add(gram.getId());
						} else {
							boolean districtForStateAvail = false;
							for (String dist : gram.getDistrict()) {
								if (dist.contains(pincd.getStateName().toUpperCase())) {
									districtForStateAvail = true;
									break;
								}
							}
							
							if(!districtForStateAvail && !CollectionUtils.isEmpty(gram.getState()) && gram.getState().contains(pincd.getStateName().toUpperCase())) {
								dlv.add(gram.getId());
							} else {
								nDlv.add(gram.getId());
							}
						}
						
//						for (String dist : gram.getDistrict()) {
//							if (dist.equalsIgnoreCase(pincd.getStateName()+"||"+pincd.getDistrict())) {
//								dlv.add(gram.getId());
//							} else {
//								nDlv.add(gram.getId());
//
//							}
//						}
					} else if (!CollectionUtils.isEmpty(gram.getState())) {
						if(gram.getState().contains(pincd.getStateName().toUpperCase())) {
							dlv.add(gram.getId());
						} else {
							nDlv.add(gram.getId());
						}
						
//						for (String sts : gram.getState()) {
//							if (sts.equalsIgnoreCase(pincd.getStateName())) {
//								dlv.add(gram.getId());
//							} else {
//								nDlv.add(gram.getId());
//
//							}
//						}
					} else if (!CollectionUtils.isEmpty(gram.getCountry())) {
						for (String cuntry : gram.getCountry()) {
							if (cuntry.equalsIgnoreCase("India")) {
								dlv.add(gram.getId());
							} else {
								nDlv.add(gram.getId());

							}
						}
					}

				}
				if (dlv.size() == pincodeValid.getGrammerces().size()) {
					msg.put("MESSAGE", "SUCCESS");
				} else {
					if (nDlv.size() > 0) {
						nDlv.removeIf(id -> dlv.stream().anyMatch(dId -> id.startsWith(dId)));
						List<String> nonDlvr = nDlv.stream().distinct().collect(Collectors.toList());
						msg.put("MESSAGE", "FAILURE");
						msg.put("DATA", nonDlvr);
					}

				}
			} else {
				msg.put("MESSAGE", "LOCATION NOT FOUND");

			}
		} else {
			msg.put("MESSAGE", "ENTER VALID PINCODE");
		}

		return msg;
	}

	public String pincodeValForPoojaOff(PincodeValid pincodeValid) {

		if (pincodeValid.getPincode().length() != 6) {

			return "ERROR:ENTER VALID PINCODE";
		}
		Query qry1 = new Query(Criteria.where("pincode").is(pincodeValid.getPincode()));
		Location pincd = mongoTemplate.findOne(qry1, Location.class);

		if (pincd != null) {

			return "SUCCESS:DELIVERY AVAILABLE";

		}

		return "ERROR:DELIVERY NOT AVAILABLE";
	}

	public Map<String, List<String>> getStateDistricts(LocationDto locationDto) {
		List<Criteria> criteriaList = new ArrayList<>();
		Map<String, List<String>> stateDistrictMap = new HashMap<>();

		if (locationDto.getState() != null && !locationDto.getState().isEmpty()) {
			List<String> stateNames = locationDto.getState();

			for (String state : stateNames) {
				Criteria stateCriteria = Criteria.where("stateName")
						.regex(Pattern.compile(state, Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE));
				criteriaList.add(stateCriteria);

				Query query = new Query(stateCriteria);
				query.with(new Sort(Sort.Direction.ASC, "district"));

				List<Location> distList = mongoTemplate.find(query, Location.class);
				List<String> districts = distList.stream().map(Location::getDistrict).map(String::toUpperCase)
						.map(String::trim).distinct().collect(Collectors.toList());

				stateDistrictMap.put(state, districts);
			}
		}

		return stateDistrictMap;
	}

}
