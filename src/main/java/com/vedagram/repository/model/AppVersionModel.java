package com.vedagram.repository.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AppVersion")
public class AppVersionModel {

	@Id
	@Indexed
	private String id;

	private String versionNo;

	private boolean forceUpdateFlg;

	private boolean activeFlg;

	private int platformFlag;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(String versionNo) {
		this.versionNo = versionNo;
	}

	public boolean isForceUpdateFlg() {
		return forceUpdateFlg;
	}

	public void setForceUpdateFlg(boolean forceUpdateFlg) {
		this.forceUpdateFlg = forceUpdateFlg;
	}

	public boolean isActiveFlg() {
		return activeFlg;
	}

	public void setActiveFlg(boolean activeFlg) {
		this.activeFlg = activeFlg;
	}

	public int getPlatformFlag() {
		return platformFlag;
	}

	public void setPlatformFlag(int platformFlag) {
		this.platformFlag = platformFlag;
	}

}
