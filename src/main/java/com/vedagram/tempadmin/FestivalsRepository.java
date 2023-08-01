package com.vedagram.tempadmin;

import java.util.List;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.domainmodel.UserModel;

public interface FestivalsRepository extends MongoRepository < Festivals, String > {

	Festivals save(FestivalsDto festivalsDto);

	List<FestivalsDto> findByTemplesId(String id);
	
}
