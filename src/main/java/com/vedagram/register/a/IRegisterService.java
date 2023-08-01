/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.register.a;


import java.util.List;

import javax.validation.Valid;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import com.vedagram.domainmodel.UserModel;

/**
 *
 * @author Winston
 */
@Service
public interface IRegisterService {

    public String insertUserDetails(RegisterModel registerModel);
    
    public UsernamePasswordAuthenticationToken validateLogin(UserDto userDto);

    public UsernamePasswordAuthenticationToken validateLoginForApi(RegisterModel registerModel);

    public UsernamePasswordAuthenticationToken updateUserDetails(RegisterModel registerModel);

	public UserModel myProfile(String userId);
	
	public String chanePassword(UserDto userDto);
	
	public void sendEmailWhenForgetPassword(UserModel userModel);

	public String forgotPassword(UserDto userDto);

	public String verifyPasswordToken(String resetPwdToken);

	public String changePasswordByResetPwdToken(UserDto userDto);

	public String changeMobileNumber(UserDto userDto);
	
	public String changeNumberByResetNumToken(String resetNumToken);

	public List<UserModel> showAllUsers(String role);

	public UsernamePasswordAuthenticationToken validateLogin(@Valid String mobileNumber);

	
}
