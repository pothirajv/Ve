package com.vedagram.tempadmin;

import java.util.List;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.domainmodel.UserModel;

public interface PoojaOfferingsRepository extends MongoRepository < PoojaOfferings, String > {

	PoojaOfferings save(PoojaOfferingsDto poojaOfferingsDto);

	List<PoojaOfferingsDto> findByTempleId(String id);
	List<PoojaOfferings> findDistinctByTempleIdInAndDeityId(List<String> templeId,String DeityId);
}
