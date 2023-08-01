package com.vedagram.user;

import java.util.ArrayList;
import java.util.List;

public class AjaxResponse {

	private Boolean resposeSuccess = new Boolean(false);

	private List<String> errorMsg = new ArrayList<String>();

	private String largeImgSrc;

	private String iconImgSrc;

	private String mediumImgSrc;

	private String mainImgSrc;

	private String redirectUrl;
	
	private Object resObj;

	public Boolean getResposeSuccess() {
		return resposeSuccess;
	}

	public void setResposeSuccess(Boolean resposeSuccess) {
		this.resposeSuccess = resposeSuccess;
	}

	public List<String> getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(List<String> errorMsg) {
		this.errorMsg = errorMsg;
	}

	public void clearErrorMsg() {
		this.errorMsg.clear();
	}

	public void addErrorMsg(String errorMsg) {
		this.errorMsg.add(errorMsg);
	}

	public String getLargeImgSrc() {
		return largeImgSrc;
	}

	public void setLargeImgSrc(String largeImgSrc) {
		this.largeImgSrc = largeImgSrc;
	}

	public String getIconImgSrc() {
		return iconImgSrc;
	}

	public void setIconImgSrc(String iconImgSrc) {
		this.iconImgSrc = iconImgSrc;
	}

	public String getMediumImgSrc() {
		return mediumImgSrc;
	}

	public void setMediumImgSrc(String mediumImgSrc) {
		this.mediumImgSrc = mediumImgSrc;
	}

	public String getMainImgSrc() {
		return mainImgSrc;
	}

	public void setMainImgSrc(String mainImgSrc) {
		this.mainImgSrc = mainImgSrc;
	}

	public String getRedirectUrl() {
		return redirectUrl;
	}

	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

	public Object getResObj() {
		return resObj;
	}

	public void setResObj(Object resObj) {
		this.resObj = resObj;
	}

}

