/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.register.a;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Component;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.support.util.Utility;

/**
 *
 * @author Winston
 */
@Component
public class RegisterMapper {

    @Autowired
    Utility utility;

    public UserModel mapUserForDB(RegisterModel registerModel, UserModel userModel) {
    	if(userModel == null)
    		userModel = new UserModel();
    	
        userModel.setFirstName(registerModel.getFirstName());
        userModel.setLastName(registerModel.getLastName());
        userModel.setAddress(registerModel.getAddress());
        userModel.setEmail(registerModel.getEmail());
        userModel.setMobileNumber(registerModel.getMobileNumber());
        userModel.setArea(registerModel.getArea());
        userModel.setCity(registerModel.getCity());
        userModel.setCountry(registerModel.getCountry());
        userModel.setAadharNumber(registerModel.getAadharNumber());
        userModel.setState(registerModel.getState());
        userModel.setPassword(registerModel.getPassword());
        userModel.setProductType(registerModel.getProductType());
        return userModel;
    }
    
    public UserModel mapUserForDBUpdate(RegisterModel registerModel, UserModel userModel) {
    	if(userModel == null)
    		userModel = new UserModel();
        userModel.setFirstName(registerModel.getFirstName());
        userModel.setLastName(registerModel.getLastName());
        userModel.setVendorName(registerModel.getVendorName());
        userModel.setAddress(registerModel.getAddress());
        userModel.setEmail(registerModel.getEmail());
        userModel.setMobileNumber(registerModel.getMobileNumber());  
        userModel.setArea(registerModel.getArea());
        userModel.setAadharNumber(registerModel.getAadharNumber());
        userModel.setCity(registerModel.getCity());
               userModel.setCountry(registerModel.getCountry());
        userModel.setState(registerModel.getState());
        userModel.setProductType(registerModel.getProductType());
       
        return userModel;
    }


    public Update mapForRegisterUpdate(RegisterModel registerModel) {
        Update update = new Update();
        if (registerModel.getAadharNumber() != null) {
            update.set("aadharNumber", registerModel.getAadharNumber());
        }
        if (registerModel.getEmail() != null) {
            update.set("email", registerModel.getEmail());
        }
        if (registerModel.getFirstName() != null) {
            update.set("firstName", registerModel.getFirstName());
        }
        if (registerModel.getLastName() != null) {
            update.set("lastName", registerModel.getLastName());
        }
        
        if (registerModel.getArea() != null) {
            update.set("area", registerModel.getArea());
        }
        if (registerModel.getCity() != null) {
            update.set("city", registerModel.getCity());
        }
        if (registerModel.getState() != null) {
            update.set("state", registerModel.getState());
        }
        if (registerModel.getCountry() != null) {
            update.set("country", registerModel.getCountry());
        }
       
        if (registerModel.getAddress() != null) {
            update.set("address", registerModel.getAddress());
        }
       
        update.set("lastUpdatedDate",new Date());
       
        
//        if (adminUser.contains(registerModel.getMobileNumber())) {
//            update.set("role", GeneralConstants.ROLE_ADMIN);
//            update.set("available", true);
//        }
//        if (registerModel.getRoleId()==3) {
//            update.set("role", GeneralConstants.ROLE_VENDOR);
//            update.set("vendorName", registerModel.getVendorName());
//            if (registerModel.getProductType() != null) {
//                update.set("productType", registerModel.getProductType());
//            }
//        } else {
//        	update.set("uflag", "true");
//        }
        return update;
    }
}
