package com.vedagram.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.deity.Deity;

public interface DeityRepository extends MongoRepository<Deity,Integer>{

	

	Deity findById(String id);

	Deity findByDeityName(String deityName);
	
	Deity findByDeityNameAndIdNot(String deityName,String id);

}
