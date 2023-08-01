package com.vedagram.tempadmin;

import java.util.List;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.domainmodel.UserModel;

public interface FacilitiesRepository extends MongoRepository < Facilities, String > {

	Facilities save(FacilitiesDto facilitesDto);

	FacilitiesDto findByTemplesId(String id);
	
}
