/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.register.a;

public class UserDto {

	private String email;
	private String password;
	private String confirmPassword;
	private String oldPassword;
	private String resetPwdToken;
    private String mobileNumber;
	private String resetNumToken;


	public String getResetNumToken() {
		return resetNumToken;
	}

	public void setResetNumToken(String resetNumToken) {
		this.resetNumToken = resetNumToken;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getResetPwdToken() {
		return resetPwdToken;
	}

	public void setResetPwdToken(String resetPwdToken) {
		this.resetPwdToken = resetPwdToken;
	}

}
