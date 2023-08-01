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

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreateTempleDto {

	private FacilitiesDto facilitiesDto;
	private List<FestivalsDto> festivalsDto;
	private List<OfferingsAndSignificanceDto> offeringsAndSignificanceDto;
	private List<PoojaOfferingsDto> poojaOfferingsDto;
	private List<TempleVideoLinksDto> templeVideoLinksDto;
	private TemplesDto templesDto;
	private TempleGalleryDto templeGalleryDto;
	private List<String> templeImgsUrl; 
	private List<String> festivalId; 
	private List<String> offeringAndSigId;
	@JsonProperty("videoLinkId")
	private List<String> videoLinkId; 
	@JsonProperty("liveVideoLinkId")
	private List<String> liveVideoLinkId; 
	private String templeAdminId;
 
     
	
	public List<String> getLiveVideoLinkId() {
		return liveVideoLinkId;
	}

	public void setLiveVideoLinkId(List<String> liveVideoLinkId) {
		this.liveVideoLinkId = liveVideoLinkId;
	}

	public String getTempleAdminId() {
		return templeAdminId;
	}

	public void setTempleAdminId(String templeAdminId) {
		this.templeAdminId = templeAdminId;
	}

	public List<String> getFestivalId() {
		return festivalId;
	}

	public List<String> getOfferingAndSigId() {
		return offeringAndSigId;
	}

	public List<String> getVideoLinkId() {
		return videoLinkId;
	}

	public void setFestivalId(List<String> festivalId) {
		this.festivalId = festivalId;
	}

	public void setOfferingAndSigId(List<String> offeringAndSigId) {
		this.offeringAndSigId = offeringAndSigId;
	}

	public void setVideoLinkId(List<String> videoLinkId) {
		this.videoLinkId = videoLinkId;
	}

	public List<String> getTempleImgsUrl() {
		return templeImgsUrl;
	}

	public void setTempleImgsUrl(List<String> templeImgsUrl) {
		this.templeImgsUrl = templeImgsUrl;
	}

	public List<TempleVideoLinksDto> getTempleVideoLinksDto() {
		return templeVideoLinksDto;
	}

	public void setTempleVideoLinksDto(List<TempleVideoLinksDto> templeVideoLinksDto) {
		this.templeVideoLinksDto = templeVideoLinksDto;
	}

	public TempleGalleryDto getTempleGalleryDto() {
		return templeGalleryDto;
	}

	public void setTempleGalleryDto(TempleGalleryDto templeGalleryDto) {
		this.templeGalleryDto = templeGalleryDto;
	}

	public FacilitiesDto getFacilitiesDto() {
		return facilitiesDto;
	}

	public void setFacilitiesDto(FacilitiesDto facilitiesDto) {
		this.facilitiesDto = facilitiesDto;
	}

	public List<FestivalsDto> getFestivalsDto() {
		return festivalsDto;
	}

	public List<OfferingsAndSignificanceDto> getOfferingsAndSignificanceDto() {
		return offeringsAndSignificanceDto;
	}

	public void setFestivalsDto(List<FestivalsDto> festivalsDto) {
		this.festivalsDto = festivalsDto;
	}

	public void setOfferingsAndSignificanceDto(List<OfferingsAndSignificanceDto> offeringsAndSignificanceDto) {
		this.offeringsAndSignificanceDto = offeringsAndSignificanceDto;
	}

	public List<PoojaOfferingsDto> getPoojaOfferingsDto() {
		return poojaOfferingsDto;
	}

	public void setPoojaOfferingsDto(List<PoojaOfferingsDto> poojaOfferingsDto) {
		this.poojaOfferingsDto = poojaOfferingsDto;
	}

	public TemplesDto getTemplesDto() {
		return templesDto;
	}

	public void setTemplesDto(TemplesDto templesDto) {
		this.templesDto = templesDto;
	}
}
