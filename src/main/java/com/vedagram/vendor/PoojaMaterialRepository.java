package com.vedagram.vendor;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface PoojaMaterialRepository extends MongoRepository<PoojaMaterial,String>{

	PoojaMaterial findByProductName(String productName);
	Optional<PoojaMaterial> findById(String id);
	PoojaMaterial findByProductNameAndIdNot(String productName, String id);
	List<PoojaMaterial> findByCreatedById(String userId);
	List<PoojaMaterial> findByAdminCreatedId(String userId);
	PoojaMaterial findByProductNameAndVendorId(String productName, String userId);
	PoojaMaterial findByProductNameAndVendorIdAndIdNot(String productName, String vendorId, String id);

	
}
