package com.vedagram.user;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProjectDonationRepository extends MongoRepository<ProjectDonation,String> {

}
