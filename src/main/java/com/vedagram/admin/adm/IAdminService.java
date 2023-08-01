/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.admin.adm;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.tempadmin.PoojaOfferings;
import com.vedagram.user.CancelOrderDto;
import com.vedagram.user.DonationModelDto;
import com.vedagram.user.GrammerceOrdersDto;
import com.vedagram.user.LocationDto;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.ProjectDonation;

/**
 *
 * @author Winston
 */
@Service
public interface IAdminService {

	public UsernamePasswordAuthenticationToken switchToUser(String userId, HttpServletRequest request);

	public List<UserModel> listOfUsers();

	String actInactUser(String userId, String uflag,String comment);

	public List<PoojaOfferings> showAllPoojaOffering();

	public PoojaOfferings viewPoojaInfo(String poojaId);

	public String setTempleFlag(String templeId, String activeFlag,String comment);

	String addGrammerce(Grammerce grammerce, List<MultipartFile> imgList) throws IOException;

	GrammerceDto viewGrammerce(String grammerceId) throws IOException;

	String updateGrammerce(Grammerce grammerce,  List<MultipartFile> imgList) throws IOException;

	public List<GrammerceDto> showAllGrammerce(String pincode) throws IOException;

	public List<PoojaOfferingOrders> getAllOrdersForPoojaOfferings();

	public List<PoojaMaterialOrders> getAllOrdersForPoojaMaterials();

	public List<GrammerceOrdersDto> getAllOrdersForGrammerce();

	public List<DonationModelDto> getAllDonations();

	public List<ProjectDonation> getAllProjectDonations();

	public PickDropShipmentResDto initShippmentForGrammrce(String orderId, String scheduleDt, String scheduleTm);

	String changerGrammerceOrdersStatus(GrammerceOrdersDto grammerceOrdersDto);

	public String setGrammerceFlag(String grammerceId, String activeFlag,String comment);

	public List<GrammerceDto> showAllGrammerceForAdmin() throws IOException;

	public boolean actInactDeity(@Valid String id, @Valid boolean activeFlag, String comment);
	
	public List<UserModel> showTempleAdminsList(AdminsSearchDto templeAdminsSearchDto);
	
	public List<UserModel> showProjectAdminsList(AdminsSearchDto projectAdminsSearchDto);
	
	public List<UserModel> showVendorsList(AdminsSearchDto vendorsSearchDto);
	

	public PickDropShipmentResDto returnShipmentForGrammerce(CancelOrderDto cancelOrderDto);

	public PickDropShipmentResDto replaceGrammerceShipmentFromUser(CancelOrderDto cancelOrderDto);
}

