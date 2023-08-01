package com.vedagram.vendor;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.pddelv.PickDropShipmentResDto;
import com.vedagram.user.PoojaMaterialDeityDto;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.PoojaMaterialOrdersStatusDto;

@Service
public interface VendorService {
	 String addPoojaMaterial(PoojaMaterial poojaMaterials,MultipartFile img)throws IOException;
	 PoojaMaterialDto viewPoojaMaterial(String materialId)throws IOException ;
	 List<PoojaMaterialDto> showAllPoojaMaterialForVendor(String vendorId)throws IOException, Exception;
	 String updatePoojaMaterial(PoojaMaterial poojaMaterial , MultipartFile img) throws IOException; 
	 public PoojaMaterialDeityDto showAllPoojaMaterial(String templeId) throws IOException;
	List<PoojaMaterialOrdersDto> getAllOrdersForPoojaMaterials(String vendorId) throws Exception;
	PickDropShipmentResDto initShippmentForPoojaMaterials(String orderId, String scheduleDt, String scheduleTm, String statusId);
	String changeMaterialOrdersStatus(PoojaMaterialOrdersStatusDto poojaMaterialOrdersStatusDto);
	List<PoojaMaterialDto> showAllPoojaMaterialForAdmin() throws IOException;
	String setMaterialFlag(String materialId, String activeFlag,String comment);
	
}
