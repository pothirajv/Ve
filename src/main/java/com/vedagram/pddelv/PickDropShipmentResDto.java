/**
 * 
 */
package com.vedagram.pddelv;

import java.io.Serializable;

/**
 * @author Vadivel
 *
 */
public class PickDropShipmentResDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private String packageStatus;

	private String trackingId;

	private String traceId;

	private String transporterName;

	private String transporterContact;

	private String pickedUpDate;

	private String deliveredDate;

	private String status;

	private String timestamp;

	private String message;

	private String debugMessage;
	private String scheduleDt;
	private String scheduleTm;
	
    String errorMessage;

	public String getScheduleDt() {
		return scheduleDt;
	}

	public String getScheduleTm() {
		return scheduleTm;
	}

	public void setScheduleDt(String scheduleDt) {
		this.scheduleDt = scheduleDt;
	}

	public void setScheduleTm(String scheduleTm) {
		this.scheduleTm = scheduleTm;
	}

	public String getPackageStatus() {
		return packageStatus;
	}

	public void setPackageStatus(String packageStatus) {
		this.packageStatus = packageStatus;
	}

	public String getTrackingId() {
		return trackingId;
	}

	public void setTrackingId(String trackingId) {
		this.trackingId = trackingId;
	}

	public String getTraceId() {
		return traceId;
	}

	public void setTraceId(String traceId) {
		this.traceId = traceId;
	}

	public String getTransporterName() {
		return transporterName;
	}

	public void setTransporterName(String transporterName) {
		this.transporterName = transporterName;
	}

	public String getTransporterContact() {
		return transporterContact;
	}

	public void setTransporterContact(String transporterContact) {
		this.transporterContact = transporterContact;
	}

	public String getPickedUpDate() {
		return pickedUpDate;
	}

	public void setPickedUpDate(String pickedUpDate) {
		this.pickedUpDate = pickedUpDate;
	}

	public String getDeliveredDate() {
		return deliveredDate;
	}

	public void setDeliveredDate(String deliveredDate) {
		this.deliveredDate = deliveredDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getDebugMessage() {
		return debugMessage;
	}

	public void setDebugMessage(String debugMessage) {
		this.debugMessage = debugMessage;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

}
