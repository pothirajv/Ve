/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.tempadmin;



import java.io.Serializable;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.web.multipart.MultipartFile;


public class TempleGalleryDto  {
	List<String> videoLinks;
	
	public List<String> getVideoLinks() {
		return videoLinks;
	}
	public void setVideoLinks(List<String> videoLinks) {
		this.videoLinks = videoLinks;
	}
	
}
