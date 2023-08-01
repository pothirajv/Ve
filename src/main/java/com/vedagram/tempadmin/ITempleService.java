/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.tempadmin;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.pddelv.PickDropShipmentReqDto;
import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.user.PoojaOfferingOrders;
import com.vedagram.user.PoojaOfferingOrdersStatusDto;

@Service
public interface ITempleService {

	List<Temples> listOfTemples();

	String createTemple(CreateTempleDto createTempleDto, List<MultipartFile> imgList) throws IOException;

	List<CreateTempleDto> getAllTemplesForTempAdmin(String tempAdmId) throws IOException, Exception;

	CreateTempleDto getTempleDetails(String templeId) throws IOException;

	boolean updateTemple(CreateTempleDto createTempleDto, List<MultipartFile> imgList) throws IOException;

	PickDropShipmentResDto initShippmentForPoojaOfferings(String orderId, String scheduleDt, String scheduleTm,String statusId);

	String changePoojaOrdersStatus(PoojaOfferingOrdersStatusDto offeringOrdersStatusDto);

	List<PoojaOfferingOrdersDto> getAllOrdersForPoojaOfferings(String userId) throws Exception;

	String poojaOfferingDone(String id,boolean poojaFlag);

	String uploadReceipt(String offeringId, MultipartFile receipt) throws IOException;

}
