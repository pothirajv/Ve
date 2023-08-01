/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.register.a;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.vedagram.domainmodel.UserModel;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class LoginResponse {
    
    public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	String responseText;
    String userToken;
    UserModel userModel;
    

	public String getResponseText() {
        return responseText;
    }

    public void setResponseText(String responseText) {
        this.responseText = responseText;
    }

	public String getUserToken() {
		return userToken;
	}

	public void setUserToken(String userToken) {
		this.userToken = userToken;
	}

  

    
    
    
}
