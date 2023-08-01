package com.vedagram.deity;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public interface DeityService {

	public String saveDeity(Deity diety,MultipartFile img)throws IOException;
	public DeityDto showDeity(String dietyId) throws IOException;
	//public String actInactDeity(String id,String activeFlag);
	public String updateDeity(Deity deity,MultipartFile img) throws IOException;
	public List<DeityDto>showAllDeity() throws IOException;
}