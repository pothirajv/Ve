/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.support.util;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.vedagram.config.PrincipalDetails;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.support.constant.GeneralConstants;

/**
 *
 * @author vijay
 */
@Component
public class Utility {

	@Autowired
	MongoTemplate mongoTemplate;

	public String getMobileNumber() {
		// PrincipalDetails principalDetails = (PrincipalDetails)
		// SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserModel userModel = getUserById(getUserId());
		return userModel.getMobileNumber();
	}

	public String getVendorName() {
		PrincipalDetails principalDetails = (PrincipalDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		return principalDetails.getVendorName();
	}

	public String getUserId() {
		try {
			PrincipalDetails principalDetails = (PrincipalDetails) SecurityContextHolder.getContext()
					.getAuthentication().getPrincipal();
			return principalDetails.getUserId();
		} catch (Exception e) {
			return null;
		}
	}

	public UserModel getUser() {
		PrincipalDetails principalDetails = (PrincipalDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		UserModel userModel = null;
		if (principalDetails != null && principalDetails.getUserId() != null) {
			Query query = new Query(Criteria.where("_id").is(principalDetails.getUserId()));
			userModel = mongoTemplate.findOne(query, UserModel.class);
		}
		return userModel;
	}

	public String getUserRole() {
		PrincipalDetails principalDetails = (PrincipalDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		return principalDetails.getRole();
	}

	public String generateRandom() {
		int randomToken = new Random().nextInt(1000000) % 1000000;
		return String.valueOf(String.format("%06d", randomToken));
	}

	public String generateRequestRandom() {
		int randomToken = new Random().nextInt(10000) % 10000;
		return String.valueOf(String.format("%04d", randomToken));
	}

	public String getRecieverUserId(String phoneNumber) {
		Query query = new Query(Criteria.where("mobileNumber").is(phoneNumber));
		UserModel userModel = mongoTemplate.findOne(query, UserModel.class);
		return userModel != null ? userModel.getId() : null;
	}

	public UserModel getUserById(String userId) {
		Query query = new Query(Criteria.where("_id").is(userId));
		UserModel userModel = mongoTemplate.findOne(query, UserModel.class);
		return userModel;
	}

	// Chari added for getting Sender address
	public String getFromAddress(String userId) {
		Query query = new Query(Criteria.where("_id").is(userId));
		UserModel userModel = mongoTemplate.findOne(query, UserModel.class);
		return userModel != null ? userModel.getAddress() : null;
	}
	// end of getting Sender address

	public boolean checkUserAndTokenStatus(String mobileNumber, String token) {
		UserModel um = null;
		try {
			um = mongoTemplate.findOne(new Query(Criteria.where("mobileNumber").is(mobileNumber)), UserModel.class);
			System.out.println("um" + um);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return um != null 
				&& um.getUserToken().equals(token);
	}
}
