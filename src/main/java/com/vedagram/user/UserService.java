package com.vedagram.user;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vedagram.deity.Deity;
import com.vedagram.deity.DeityDto;
import com.vedagram.payment.UserPurchaseModelForPay;
import com.vedagram.payment.UserPurchaseResponse;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.tempadmin.Temples;
import com.vedagram.vendor.PoojaMaterial;
import com.vedagram.vendor.PoojaMaterialDto;

@Service
public interface UserService {
	public List<PoojaOfferingDeityDto> showPoojaOffering(String deityId, String tempId);

	public List<Temples> showTempleList(TempleSearchDto templeSearchDto);

	public List<DeityDto> showAllDeity();

	public void addToCart(VedaCartDto vedaCartDto, String userId);

	public List<UserCartDetails> getByUserId(String userId);

	public boolean removeFromCart(String userCartDetailsIds, String userId);

	public UserPurchaseResponse saveUserPurchaseDetail(UserCartDetailsDto userCartDetailsDto);

	public UserPurchaseResponse savePoojaOfferingsOrder(UserCartDetails userCartDetails);

	public UserPurchaseResponse savePoojaOfferingsOrder(UserCartDetails userCartDetails,
			UserPurchaseModelForPay userPurchaseModelForPay) throws ParseException;

	public List<PoojaOfferingOrders> getMyOrders(String userId);

	public UserPurchaseResponse savePoojaMaterialOrder(PoojaMaterialOrders poojaMaterialOrders);

	public List<PoojaMaterialOrders> getMyOrdersMaterials(String userId);

	public UserPurchaseResponse saveGrammerceOrders(GrammerceOrders grammerceOrders);

	public List<GrammerceOrders> getMyGrammerceOrders(String userId);

	public UserPurchaseResponse saveDonationOrders(DonationOrders donationOrders);

	public UserPurchaseResponse donateToProject(ProjectDonation projectDonation);

	public List<DonationOrders> getMyDonations(String userId);

	public List<ProjectDonation> myProjectDonations(String userId);

	public Double getDeliveryCharge(UserCartDetails memdt);

	public void savePDDelvCharge(UserCartDetails memdt);

	public MaterialPurchaseDto calcDelcChargeFroPoojaMaterials(MaterialPurchaseDto materialPurchaseDto);

	public GrammercePurchaseDto calcDelcChargeForGrmmaerce(GrammercePurchaseDto grammercePurchaseDtoDto);

	public VedaCartDto calcDelcChargeForOffering(VedaCartDto vedaCartDto);

	Double getDeliveryCharge(UserCartDetailsDto userCartDetailsDto);

	public String addOffer(Offer offer);

	List<Offer> showAllOffer();

	public Offer viewOffer(String offerId);

	public String updateOffer(Offer offer);

	public UserPurchaseResponse saveOfferingsOrder(UserCartDetailsDto userCartDetailsDto,
			UserPurchaseModelForPay userPurchaseModelForPay) throws ParseException;

	public List<String> ShowAllStates();

	public List<String> showAllDistrict(LocationDto locationDto);

	public List<String> showAllPinCode(LocationDto locationDto);
	
	public Map<String, Object> pincodeValForGram(PincodeValid pincodeValid);
	
	public String pincodeValForPoojaOff(PincodeValid pincodeValid);
	
	public Map<String, List<String>> getStateDistricts(LocationDto locationDto);
}
