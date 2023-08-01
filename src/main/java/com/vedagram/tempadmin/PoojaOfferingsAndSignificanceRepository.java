package com.vedagram.tempadmin;

import java.util.List;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.domainmodel.UserModel;

public interface PoojaOfferingsAndSignificanceRepository extends MongoRepository < OfferingsAndSignificance, String > {

	OfferingsAndSignificance save(OfferingsAndSignificanceDto OffferingsAndSignificanceDto);

	List<OfferingsAndSignificanceDto> findByTemplesId(String id);
	
}
