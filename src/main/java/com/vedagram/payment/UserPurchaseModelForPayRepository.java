package com.vedagram.payment;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.deity.Deity;

public interface UserPurchaseModelForPayRepository extends MongoRepository<UserPurchaseModelForPay,Integer>{

	List<UserPurchaseModelForPay> findByCartPayRefId(String cartPayRefId);

	UserPurchaseModelForPay findById(String Id);
	



}
