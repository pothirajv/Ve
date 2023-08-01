package com.vedagram.tempadmin;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "TempleVideoLinks")
public class TempleVideoLinksDto {

	@Id
	@Indexed
	private String id;
	private String videoLink;
	private String videoName;
	private Integer type;
	private Temples temples;
	public Temples getTemples() {
		return temples;
	}
	public void setTemples(Temples temples) {
		this.temples = temples;
	}
	public String getId() {
		return id;
	}
	public String getVideoLink() {
		return videoLink;
	}
	public String getVideoName() {
		return videoName;
	}
	public Integer getType() {
		return type;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setVideoLink(String videoLink) {
		this.videoLink = videoLink;
	}
	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	
	
}
