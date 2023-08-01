package com.vedagram.tempadmin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.domainmodel.UserModel;

public interface TempleRepository extends MongoRepository < Temples, String > {

	Temples save(TemplesDto templesDto);

	List<TemplesDto> findByCreatedBy(String id);

	List<TemplesDto> findByAdminCreatedId(String userId);

	
	
}
