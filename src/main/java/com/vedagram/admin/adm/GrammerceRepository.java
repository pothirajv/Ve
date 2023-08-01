package com.vedagram.admin.adm;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface GrammerceRepository extends MongoRepository<Grammerce,String> {

	Grammerce findByProductName(String productName);

	Grammerce findByProductNameAndIdNot(String productName, String id);

}
