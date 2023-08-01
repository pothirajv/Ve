package com.vedagram.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.vedagram.domainmodel.UserModel;

public interface UserRepository extends MongoRepository < UserModel, String > {

	public UserModel findByEmailIgnoreCase(String email);

	public UserModel findByEmail(String email);
	
	public UserModel findByResetPwdToken(String resetPwdToken);
	
	public UserModel findByEmailIgnoreCaseAndResetPwdToken(String email, String resetPwdToken);

	public UserModel findByResetNumTokenAndId(String resetNumToken, String userId);

	public UserModel findByResetNumToken(String resetNumToken);

	public List<UserModel> findByRoleAndUflag(String roleTempadmin, String string);

}
