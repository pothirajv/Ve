package com.vedagram.user;

import java.util.Date;
import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface UserCartRepository extends MongoRepository<UserCartDetails,String> {

	List<UserCartDetails> findByUserModelIdAndDelFlag(String userId, int i);

	//@Modifying
	//@Transactional
//	@Query("Update UserCartDetails g set g.delFlag=1, g.lastModifiedDate=:modifiedDate where g.id IN(:userCartDetailsIdsLst)")
//	void removeMember(@Param("userCartDetailsIdsLst") List<String> userCartDetailsIdsLst,
//			@Param("modifiedDate") Date date);

	
}
