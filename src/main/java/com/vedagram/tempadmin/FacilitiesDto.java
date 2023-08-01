/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.tempadmin;



import java.io.Serializable;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;


public class FacilitiesDto  {
	
	String id;
	int parkingLot;
	String security;
	String restRooms;
	String cloakCounters;
	String poojaProvisions;
	String cabAvailablity;
	List<String> shops;
	String auditorium;
	String bus;
	String car;
	String train;
	String flight;
	Temples temples;
	public List<String> getShops() {
		return shops;
	}
	public void setShops(List<String> shops) {
		this.shops = shops;
	}
	
	public String getBus() {
		return bus;
	}
	public void setBus(String bus) {
		this.bus = bus;
	}
	public String getCar() {
		return car;
	}
	public void setCar(String car) {
		this.car = car;
	}
	public String getTrain() {
		return train;
	}
	public void setTrain(String train) {
		this.train = train;
	}
	public String getFlight() {
		return flight;
	}
	public void setFlight(String flight) {
		this.flight = flight;
	}
	public String getAuditorium() {
		return auditorium;
	}

	public Temples getTemples() {
		return temples;
	}
	public void setTemples(Temples temples) {
		this.temples = temples;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getParkingLot() {
		return parkingLot;
	}
	public void setParkingLot(int parkingLot) {
		this.parkingLot = parkingLot;
	}
	public String getSecurity() {
		return security;
	}
	public void setSecurity(String security) {
		this.security = security;
	}
	public String getRestRooms() {
		return restRooms;
	}
	public void setRestRooms(String restRooms) {
		this.restRooms = restRooms;
	}
	public String getCloakCounters() {
		return cloakCounters;
	}
	public void setCloakCounters(String cloakCounters) {
		this.cloakCounters = cloakCounters;
	}
	public String getPoojaProvisions() {
		return poojaProvisions;
	}
	public void setPoojaProvisions(String poojaProvisions) {
		this.poojaProvisions = poojaProvisions;
	}
	public String getCabAvailablity() {
		return cabAvailablity;
	}
	public void setCabAvailablity(String cabAvailablity) {
		this.cabAvailablity = cabAvailablity;
	}
	
	public void setAuditorium(String auditorium) {
		this.auditorium = auditorium;
	}
	
	
	
	
}	 

