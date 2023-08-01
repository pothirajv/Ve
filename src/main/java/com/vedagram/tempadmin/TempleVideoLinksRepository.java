package com.vedagram.tempadmin;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface TempleVideoLinksRepository extends MongoRepository<TempleVideoLinks,String>{

	List<TempleVideoLinksDto> findByTemplesId(String id);

}
