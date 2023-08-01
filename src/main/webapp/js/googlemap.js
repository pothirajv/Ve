var geocoder = new google.maps.Geocoder();
$(document).ready(function(){
	$(document.body).on('click', '.mapResultRowCls, .favouriteResultRowCls, .mapRecentResultRowCls, .editDropBtnCls, .editPickBtnCls, .editAddrCls', function() {
		var center = new Object();
		center.lat = parseFloat($(this).attr('lat'));
		center.lng = parseFloat($(this).attr('lng'));
		
		deleteMarkers();
//        var marker = new google.maps.Marker({
//          position: center,
//          map: map
//        });
        addMarker(center);
        
        
        
	});
});

var autocompleteService, placesService, results, map;
let markers = [];

function initialize() {

  results = document.getElementById('searchResultBody');

  var mapOptions = {
    zoom: 18,
    center: new google.maps.LatLng(13.0827, 80.2707),
    disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    zoomControl: true
  };

  map = new google.maps.Map(document.getElementById('map'), mapOptions);

  var searcMapInterval;
  // Bind listener for address search
  google.maps.event.addDomListener(document.getElementById('srchMapLoc'), 'input', function() {
	  clearTimeout(searcMapInterval);
	  if(document.getElementById('srchMapLoc').value.length > 0) {
		  $('#searchResultBody').html('<span style="font-size: 10px; text-align: center;float: left;width: 100%;">loading...</span>');
		  searcMapInterval = setTimeout(searchMapLoc, 1000);
	  }
  });
  
  function searchMapLoc() {
	  results.style.display = 'block';
	  getPlacePredictions(document.getElementById('srchMapLoc').value); 
  }

  // Show results when address field is focused (if not empty)
//  google.maps.event.addDomListener(document.getElementById('srchMapLoc'), 'focus', function() {
//
//    if (document.getElementById('srchMapLoc').value !== '') {
//
//      results.style.display = 'block';
//      getPlacePredictions(document.getElementById('srchMapLoc').value);
//    }
//  });

  // Hide results when click occurs out of the results and inputs
  google.maps.event.addDomListener(document, 'click', function(e) {

    if ((e.target.parentElement.className !== 'pac-container') && (e.target.parentElement.className !== 'pac-item') && (e.target.tagName !== 'INPUT')) {

      results.style.display = 'none';
    }
  });
  
  google.maps.event.addListener(map, 'dragend', function () {
	//myMarker.setPosition(this.getCenter()); // set marker position to map center
	addMarker(this.getCenter());
	geocodePosition(this.getCenter());
	//updatePosition(this.getCenter().lat(), this.getCenter().lng()); // update position display
  });

  autocompleteService = new google.maps.places.AutocompleteService();
  placesService = new google.maps.places.PlacesService(map);
}

// Get place predictions
function getPlacePredictions(search) {
  autocompleteService.getPlacePredictions({
    input: search,
    componentRestrictions: {country: ['in']}
//    types: ['geocode']
  }, callback);
}

function geocodePosition(pos) {
  geocoder.geocode({
    latLng: pos
  }, function(responses) {
    if (responses && responses.length > 0) {
      updateMarkerAddress(responses[0]);
    } else {
      updateMarkerAddress('Cannot determine address at this location.');
    }
  });
}

function updateMarkerAddress(place) {
	var city = '';
	var state = '';
	var country = '';
	var area = '';
	var name = '';
	place.address_components.forEach(function(val) {
		if (val.types[0] == "locality") city = val.short_name;
		if (val.types[0] == "administrative_area_level_1") state = val.short_name;
		if (val.types[0] == "country") country = val.short_name;
		if (val.types[0] == "sublocality_level_1") area = val.short_name;
		if (val.types[0] == "name") name = val.short_name;
	});
	 
	var address = place.formatted_address;
	var lat = place.geometry.location.lat().toFixed(10);
	var lng = place.geometry.location.lng().toFixed(10);
	var area = area;
	var city = city;
	var state = state;
	var country = country;
	var placeName = place.name;
	
	$('.frmAreaCls').val(area);
	$('.frmCityCls').val(city);
	$('.frmStateCls').val(state);
	$('.frmCountryCls').val(country);
	$('.frmLatCls').val(lat);
	$('.frmLngCls').val(lng);
	$('.frmAddressCls').html(address);
	$('.frmAddressInputCls').val(address);
}

// Place search callback
function callback(predictions, status) {

  // Empty results container
  results.innerHTML = '';

  // Place service status error
  if (status != google.maps.places.PlacesServiceStatus.OK) {
//    results.innerHTML = '<div class="pac-item pac-item-error">Your search returned no result. Status: ' + status + '</div>';
	  results.innerHTML = '<div class="pac-item pac-item-error">Your search returned no result</div>';
    return;
  }

  // Build output for each prediction
  for (var i = 0, prediction; prediction = predictions[i]; i++) {

		// Get place details to inject more details in autocomplete results
    placesService.getDetails({
      placeId: prediction.place_id
    }, function(place, serviceStatus) {

      if (serviceStatus === google.maps.places.PlacesServiceStatus.OK) {
    	  
    	  var city = '';
    	  var state = '';
    	  var country = '';
    	  var area = '';
    	  var name = '';
    	  place.address_components.forEach((val) => {
    		  if (val.types[0] == "locality") city = val.short_name;
    		  if (val.types[0] == "administrative_area_level_1") state = val.short_name;
    		  if (val.types[0] == "country") country = val.short_name;
    		  if (val.types[0] == "sublocality_level_1") area = val.short_name;
    		  if (val.types[0] == "name") name = val.short_name;
		  });
    	  
				// Create a new result element
        var div = document.createElement('div');
        div.setAttribute('area', area);
        div.setAttribute('city', city);
        div.setAttribute('state', state);
        div.setAttribute('country', country);
        div.setAttribute('lat', place.geometry.location.lat().toFixed(10));
        div.setAttribute('lng', place.geometry.location.lng().toFixed(10));
        div.setAttribute('formatAddr', place.formatted_address);
        div.setAttribute('addr', place.formatted_address);
        div.setAttribute('name', place.name);
//        div.setAttribute('addr', place.adr_address);
        
        var nameVar = '<span class="mapLocationNameCls">'+place.name+'</span>';
        
        div.innerHTML += '<i class="fa fa-map-marker mapIconCls iconCls"></i>';
        div.innerHTML += '<div class="mapRsultCls"><div class="mapLocationCls">' + nameVar + place.formatted_address + '</div></div>';

        // Insert inner HTML
//        div.innerHTML += '<span class="pac-icon pac-icon-marker"></span>' + place.adr_address + '<div class="pac-item-details">Lat: ' + place.geometry.location.lat().toFixed(10) + ', Lng: ' + place.geometry.location.lng().toFixed(10) + '</div>';

        div.className = 'pac-item mapResultRowCls';
        
        // Bind a click event
//        div.onclick = function() {
//
//					var center = place.geometry.location;
//          var marker = new google.maps.Marker({
//            position: center,
//            map: map
//          });
//
//          map.setCenter(center);
//        }
        
        // Append new element to results
        results.appendChild(div);
      }
    });
  }
}

//Adds a marker to the map and push to the array.
function addMarker(position) {
//  const marker = new google.maps.Marker({
//    position,
//    map,
//  });
//
//  markers.push(marker);
  map.setCenter(position);
}

// Sets the map on all markers in the array.
function setMapOnAll(map) {
  for (let i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function hideMarkers() {
  setMapOnAll(null);
}

// Shows any markers currently in the array.
function showMarkers() {
  setMapOnAll(map);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  hideMarkers();
  markers = [];
}

google.maps.event.addDomListener(window, 'load', initialize);