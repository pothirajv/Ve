package com.vedagram.user;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface VedaCartRepository extends MongoRepository<VedaCart,String> {

	void deleteByUserCartDetailsId(String userCartDetailsId);

	List<VedaCart> findByUserCartDetailsUserModelIdAndUserCartDetailsDelFlag(String userId, int i);

	List<VedaCart> findByUserCartDetailsIdIn(List<String> cartIds);

//	@Transactional
//	@Query("delete from VedaCart g  where g.userCartDetails.id IN(:userCartDetailsIdsLst)")
//	void deleteByUserCartDetailsId(@Param("userCartDetailsIdsLst") List<String> userCartDetailsIdsLst);

	
	

	
}
