package com.vedagram.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.vedagram.user.Offer;

@Repository
public interface OfferRepository extends MongoRepository<Offer,String> {

}
