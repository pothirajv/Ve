package com.vedagram.tempadmin;

import org.springframework.data.mongodb.core.query.Update;

public class TempleUpdateMapperForDB {
	public Update updateTemple(TemplesDto templesDto) {
		Update update = new Update();
		update.set("name", templesDto.getName());
		update.set("aerialView", templesDto.getAerialView());
		update.set("country", templesDto.getCountry());
		update.set("district", templesDto.getDistrict());
		update.set("state", templesDto.getState());
		update.set("villageorTown", templesDto.getVillageorTown());
		update.set("scheduleAndTimings", templesDto.getScheduleAndTimings());
		update.set("aboutAndHistory", templesDto.getAboutAndHistory());
		update.set("tempLat", templesDto.getTempLat());
		update.set("tempLong", templesDto.getTempLong() );
		update.set("shippingAddress", templesDto.getShippingAddress());
		update.set("committeeMembers", templesDto.getCommitteeMembers());

		
		return update;
	}

	public Update updatePoojaOfferings(PoojaOfferingsDto poojaOfferingsDto) {
		Update update = new Update();
		update.set("deity", poojaOfferingsDto.getDeity());
		update.set("description", poojaOfferingsDto.getDescription());
		update.set("name", poojaOfferingsDto.getName());
		update.set("price", poojaOfferingsDto.getPrice());
		update.set("offeringTime", poojaOfferingsDto.getOfferingTime());

		return update;
	}

	public Update updateFacility(FacilitiesDto facilitiesDto) {

		Update update = new Update();
		update.set("auditorium", facilitiesDto.getAuditorium());
		update.set("cabAvailablity", facilitiesDto.getCabAvailablity());
		update.set("cloakCounters", facilitiesDto.getCloakCounters());
		update.set("parkingLot", facilitiesDto.getParkingLot());
		update.set("poojaProvisions", facilitiesDto.getPoojaProvisions());
		update.set("restRooms", facilitiesDto.getRestRooms());
		update.set("security", facilitiesDto.getSecurity());
		update.set("bus",facilitiesDto.getBus());
		update.set("car",facilitiesDto.getCar());
		update.set("train",facilitiesDto.getTrain());
		update.set("flight",facilitiesDto.getFlight());

		StringBuilder sb1 = new StringBuilder();
		String separator = "||";
		for (String shop : facilitiesDto.getShops()) {
			sb1.append(shop).append(separator);

		}
		update.set("shops", sb1.toString());
		return update;

	}

	public Update updateFestival(FestivalsDto festivalsDto) {
		Update update = new Update();
		update.set("name", festivalsDto.getName());
		update.set("description", festivalsDto.getDescription());

		return update;

	}

	public Update updateOfferingsAndSignificance(OfferingsAndSignificanceDto offeringsAndSignificanceDto) {
		Update update = new Update();
		update.set("offeringName", offeringsAndSignificanceDto.getOfferingName());
		update.set("significance", offeringsAndSignificanceDto.getSignificance());
		return update;

	}
	public Update updateTempleVideoLinks(TempleVideoLinksDto templeVideoLinksDto) {
		Update update = new Update();
		update.set("videoName", templeVideoLinksDto.getVideoName());
		update.set("videoLink", templeVideoLinksDto.getVideoLink());	
		update.set("type", templeVideoLinksDto.getType());	
		return update;
		
	}
}
