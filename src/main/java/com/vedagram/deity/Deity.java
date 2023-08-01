package com.vedagram.deity;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Deity")
public class Deity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String id;
	private String deityName;
	private String deityDescription;
	private boolean activeFlag;
	private String image;
	private String activeComment;
	private String inactiveComment;

	public String getId() {
		return id;
	}
	public String getDeityName() {
		return deityName;
	}
	public String getDeityDescription() {
		return deityDescription;
	}
	
	public String getImage() {
		return image;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setDeityName(String deityName) {
		this.deityName = deityName;
	}
	public void setDeityDescription(String deityDescription) {
		this.deityDescription = deityDescription;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getActiveComment() {
		return activeComment;
	}
	public void setActiveComment(String activeComment) {
		this.activeComment = activeComment;
	}
	public String getInactiveComment() {
		return inactiveComment;
	}
	public void setInactiveComment(String inactiveComment) {
		this.inactiveComment = inactiveComment;
	}
	public boolean isActiveFlag() {
		return activeFlag;
	}
	public void setActiveFlag(boolean activeFlag) {
		this.activeFlag = activeFlag;
	}
	
	
	}
