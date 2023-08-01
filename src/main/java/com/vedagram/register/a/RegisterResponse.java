/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.register.a;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 *
 * @author Winston
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RegisterResponse {
    
    String responseText;
    int otp;

    public String getResponseText() {
        return responseText;
    }

    public void setResponseText(String responseText) {
        this.responseText = responseText;
    }

    public int getOtp() {
        return otp;
    }

    public void setOtp(int otp) {
        this.otp = otp;
    }

    
    
    
}
