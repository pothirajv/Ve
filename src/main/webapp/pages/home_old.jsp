<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBR8gfXIcdX2P2xl43xrDV13hqCLbsl5zk&libraries=places"></script>

<script type="text/javascript">

var componentForm = {
	street_number : 'short_name',
	route : 'short_name',
	locality : 'short_name',
	sublocality_level_1 : 'short_name',
	administrative_area_level_1 : 'short_name',
	country : 'short_name',
	postal_code : 'short_name'
};

var distanceVar = 2;
var pckgWeightVar = 4;

$(document).ready(function() {
	getGoogleAddress1();
	getGoogleAddress2();
	
	$('#calccost').click(function() {
		calculateWeight();
	});
	
	/* $("#slider11").slider({
		range: false,
		orientation: "horizontal",
		min: 0,
		max: 100,
		value: 10,
		step: 5,
		slide: function (event, ui) {
			distanceVar = ui.values[1];
		}
	}); */
	
	/* $("#slider2").slider({
		range: false,
		orientation: "horizontal",
		min: 1,
		max: 10,
		value: 1,
		step: 1,
		slide: function (event, ui) {
			pckgWeightVar = ui.values[1];
		}
	}); */
	
	var valMap = [5, 10, 15, 20, 25, 30];
    $("#slider1").slider({
        min: 1,
        max: valMap.length - 1,
        value: distanceVar,
        slide: function(event, ui) {                        
        	distanceVar = valMap[ui.value];
        	$('#calLbl1').html(distanceVar + ' Km');
        	calPrice();
        }       
    });
    
    var valMap1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    $("#slider2").slider({
        min: 0,
        max: valMap1.length - 1,
        value: pckgWeightVar,
        slide: function(event, ui) {                        
        	pckgWeightVar = valMap1[ui.value];     
        	$('#calLbl2').html(pckgWeightVar + ' Kg');
        	calPrice();
        }       
    });
    
	$('#calccost1').click(function() {
		calPrice();
	});
	
	calPrice();
});

function calPrice() {
	if(distanceVar < 10) {
		distanceVar = 10;
	}
    var cost = 40 + Math.ceil((distanceVar - 10) / 10) * 20 + ((parseInt(pckgWeightVar) - 1) * 10);
    
    var dashboardRequest = new Object();
    dashboardRequest.distance = distanceVar + " km";
    dashboardRequest.weight = pckgWeightVar;
    dashboardRequest.sendFrom = 'Chennai';
	
	$.ajax({
		url : $("#contextPath").val()+'/adm/getRate',
		contentType : "application/json",
		type : 'POST',
		data : JSON.stringify(dashboardRequest),
		success:function(data){
			$('#cost1').html(data.rate);
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function getGoogleAddress1(){
	var autocomplete = new google.maps.places.Autocomplete(document.getElementById('pickFrom'));
	autocomplete.setFields(['address_component', 'geometry']);
	autocomplete.addListener('place_changed', function(){
		var place = autocomplete.getPlace();
		if($.type(place.geometry) !='undefined' && $.type(place.address_components)!='undefined') {
			$('#lat1').val(place.geometry.location.lat());
			$('#long1').val(place.geometry.location.lng());
			
			for (var i = 0; i < place.address_components.length; i++) {
				var d = place.formatted_address;
				var addressType = place.address_components[i].types[0];
				if (componentForm[addressType]) {
					var val = place.address_components[i][componentForm[addressType]];
					
					if(addressType == 'locality') {
						$('#city1').val(val);
					} else if(addressType == 'sublocality_level_1') {
						$('#area1').val(val);
					} else if(addressType == 'administrative_area_level_1') {
						$('#state1').val(val);
					} else if(addressType == 'country') {
						$('#country1').val(val);
					}
				}
			}
		 } else {
			 alert("Please Select valid address...")
			 $("#address").val("");
		 }
	});
}

function getGoogleAddress2(){
	var autocomplete = new google.maps.places.Autocomplete(document.getElementById('dropTo'));
	autocomplete.setFields(['address_component', 'geometry']);
	autocomplete.addListener('place_changed', function(){
		var place = autocomplete.getPlace();
		if($.type(place.geometry) !='undefined' && $.type(place.address_components)!='undefined') {
			$('#lat2').val(place.geometry.location.lat());
			$('#long2').val(place.geometry.location.lng());
			
			for (var i = 0; i < place.address_components.length; i++) {
				var d = place.formatted_address;
				var addressType = place.address_components[i].types[0];
				if (componentForm[addressType]) {
					var val = place.address_components[i][componentForm[addressType]];
					
					if(addressType == 'locality') {
						$('#city2').val(val);
					} else if(addressType == 'sublocality_level_1') {
						$('#area2').val(val);
					} else if(addressType == 'administrative_area_level_1') {
						$('#state2').val(val);
					} else if(addressType == 'country') {
						$('#country2').val(val);
					}
					
				}
			}
		} else {
			 alert("Please Select valid address...")
			 $("#address").val("");
		}
	});
}

function calculateWeight() {
	$('#cost').html('0');
	
	var lat1 = $('#lat1').val();
	var long1 = $('#long1').val();
	var lat2 = $('#lat2').val();
	var long2 = $('#long2').val();
	
	if(lat1 == null || lat1 == '' || long1 == null || long1 == '' || lat2 == null || lat2 == '' || long2 == null || long2 == '') {
		return false;
	}
	
	var fromLocation = {lat: parseFloat(lat1), lng: parseFloat(long1)};
	var toLocation = {lat: parseFloat(lat2), lng: parseFloat(long2)};
	
	var service = new google.maps.DistanceMatrixService();
	service.getDistanceMatrix(
	{
		origins: [fromLocation],
		destinations: [toLocation],
		travelMode: google.maps.TravelMode.DRIVING,
		unitSystem: google.maps.UnitSystem.METRIC,
		avoidHighways: false,
		avoidTolls: false,
	},
	function (response, status) {
		if(status == google.maps.DistanceMatrixStatus.OK && response.rows[0].elements[0].status != "ZERO_RESULTS") {
			var dist = response.rows[0].elements[0].distance.text;
			var tempDistance = response.rows[0].elements[0].distance.value / 1000;
			if(tempDistance < 10) {
				tempDistance = 10;
			}
	        var cost = 40 + Math.ceil((tempDistance - 10) / 10) * 20 + ((parseInt($('#parcelWeight').val()) - 1) * 10);
	        $('#cost').html(cost);
		}
	});
}

function geolocate() {
	/* if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var geolocation = {
				lat : position.coords.latitude,
				lng : position.coords.longitude
			};
			var circle = new google.maps.Circle({
				center : geolocation,
				radius : position.coords.accuracy
			});
			autocomplete.setBounds(circle.getBounds());
		});
	} */
}


</script>

<div id="main-body">

	<div class="hero-wrap js-fullheight" style="height: 657px; background-position: 50% 50%; background-size: 100%; background-image: none; background: white; " data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
		<div class="home-area" id="home">
			<div
				class="row no-gutters slider-text js-fullheight align-items-center justify-content-start"
				data-scrollax-parent="true" style="height: 329px;">
				<div class="col-xl-12 ftco-animate mb-5 pb-5 fadeInUp ftco-animated"
					data-scrollax=" properties: { translateY: '70%' }"
					style="transform: translateZ(0px) translateY(0%); padding: 0px 0%;">

					<h1 class="mb-5 extramargin"
						data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"
						style="opacity: 1; transform: translateZ(0px) translateY(0%); font-size: 30px; color: #0c0c0c; font-weight: 200; line-height: 60px; text-align: left; padding: 10px 20px; border-radius: 10px; width: 60%; min-width: 340px; float:">
						<span style="font-weight: 800;">Check your delivery cost</span><br>
						<span style="font-size: 30px;">in Vedagram</span>
					</h1>

					<div class="ftco-search" style="float: left; width: 100%;">
						<div class="row">
							<div class="col-md-12 nav-link-wrap">
								<div class="nav nav-pills text-center" id="v-pills-tab"
									role="tablist" aria-orientation="vertical">
											</div>
							</div>
							<div class="col-md-5 tab-wrap">

								<div class="tab-content p-4" id="v-pills-tabContent"
									style="background: #d2cfcf; -webkit-border-radius: 7px; -moz-border-radius: 7px; -ms-border-radius: 7px; border-radius: 7px; margin-top: -9px;">
									
									<div class="tab-pane fade show active" id="v-pills-1"
										role="tabpanel" aria-labelledby="v-pills-nextgen-tab">
										<div class="col-md-12">
											<div>
												<div style="">
													<span style="">Distance</span>
													<span id="calLbl1" style="font-weight: bold;">15 Km</span>
												</div>
												<div id="slider1" style="margin: 20px 0px;"></div>
											</div>
											<div>
												<div style="">
													<span style="">Parcel Weight</span>
													<span id="calLbl2" style="font-weight: bold;">4 Kg</span>
												</div>
												<div id="slider2" style="margin: 20px 0px;"></div>
											</div>
										</div>
										<div class="col-md-12">
											<!-- div class="form-group" style="float: left;">
												<div class="form-field">
													<input type="submit" id="calccost1" value="Calculate" class="form-control btn btn-primary">
												</div>
											</div-->
											<div style="font-size: 1.3rem;text-align:center;color: #499018;">
												<span>Your delivery charge :</span>
												<span class="fa fa-inr" style="font-size: 1.5rem;margin-left: 20px;"></span>
												<span id="cost1" style="font-size: 1.5rem;font-weight:bold;text-align:center;color:gray;line-height: 39px;color: #499018;">40</span>
											</div>
										</div>
									</div>
									<div class="tab-pane fade show active" id="v-pills-1"
										role="tabpanel" aria-labelledby="v-pills-nextgen-tab" style="display: none;">
										<div style="color: #E91E63; font-size: 0.75rem;margin-bottom: 5px;">* Inside Chennai & Salem only</div>
										<div class="row">
											<div class="col-md">
												<div class="form-group">
													<div class="form-field">
														<div class="icon">
															<span class="icon-briefcase"></span>
														</div>
														<input type="text" class="form-control"
															placeholder="Pick From" id="pickFrom" onFocus="geolocate()" style="font-size: inherit;">
														<input type="hidden" id="area1">
														<input type="hidden" id="city1">
														<input type="hidden" id="state1">
														<input type="hidden" id="country1">
														<input type="hidden" id="lat1">
														<input type="hidden" id="long1">
													</div>
												</div>
											</div>


											<div class="col-md">
												<div class="form-group">
													<div class="form-field">
														<div class="icon">
															<span class="icon-map-marker"></span>
														</div>
														<input type="text" class="form-control"
															placeholder="Drop To" id="dropTo" onFocus="geolocate()" style="font-size: inherit;">
														<input type="hidden" id="area2">
														<input type="hidden" id="city2">
														<input type="hidden" id="state2">
														<input type="hidden" id="country2">
														<input type="hidden" id="lat2">
														<input type="hidden" id="long2">
													</div>
												</div>
											</div>
											<div class="col-md">
												<div class="form-group">
													<div class="form-field">
														<div class="icon">
															<span class="icon-map-marker"></span>
														</div>
														<select id="parcelWeight" class="form-control" style="font-size: inherit;">
															<option value="1">1 Kg</option>
															<option value="2">2 Kg</option>
															<option value="3">3 Kg</option>
															<option value="4">4 Kg</option>
															<option value="5">5 Kg</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md">
												<div class="form-group">
													<div class="form-field">
														<input type="submit" id="calccost" value="Calculate"
															class="form-control btn btn-primary">
													</div>
												</div>
											</div>
										</div>
										<div style="font-size: 1.3rem; color: gray;">
											<span class="fa fa-inr" style="font-size: 1.2rem;"></span>
											<span id="cost">0</span>
										</div>
									</div>

									<div class="tab-pane fade" id="v-pills-2" role="tabpanel"
										aria-labelledby="v-pills-performance-tab">
										<form action="#" class="search-job">
											<div class="row">
												<div class="col-md">
													<div class="form-group">
														<div class="form-field">
															<div class="icon">
																<span class="icon-user"></span>
															</div>
															<input type="text" class="form-control"
																placeholder="eg. Adam Scott">
														</div>
													</div>
												</div>
												<div class="col-md">
													<div class="form-group">
														<div class="form-field">
															<div class="select-wrap">
																<div class="icon">
																	<span class="ion-ios-arrow-down"></span>
																</div>
																<select name="" id="" class="form-control">
																	<option value="">Category</option>
																	<option value="">Full Time</option>
																	<option value="">Part Time</option>
																	<option value="">Freelance</option>
																	<option value="">Internship</option>
																	<option value="">Temporary</option>
																</select>
															</div>
														</div>
													</div>
												</div>
												<div class="col-md">
													<div class="form-group">
														<div class="form-field">
															<div class="icon">
																<span class="icon-map-marker"></span>
															</div>
															<input type="text" class="form-control"
																placeholder="Location">
														</div>
													</div>
												</div>
												<div class="col-md">
													<div class="form-group">
														<div class="form-field">
															<input type="submit" value="Search"
																class="form-control btn btn-primary">
														</div>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	<!-- service section -->

	<section class="service_section layout_padding servicemargin">
		<div class="container">
			<h2 class="custom_heading">Our Services</h2>
			<p class="custom_heading-text"></p>
			<div class=" layout_padding2">
				<div class="card-deck">
					<div class="card">
<!-- 						<img class="card-img-top" src="images/card-item-1.png" -->
<!-- 							alt="Card image cap"> -->
						<span class="fa fa-gift" style="height: 100px;font-size: 35px;line-height: 130px;"></span>
						<div class="card-body">
							<h5 class="card-title">Vedagram Section</h5>
							<p class="card-text">Vedagram, a service that will change the way you send things across your city. We PICK anything you want to send to your loved ones from your doorstep and DROP them at their doorstep within two hours’ time. You can send Home Cooked food, Envelopes, Packages across in no time.
We deliver anything you have forgotten from your home to office or office to home, from a shop to your home – could be groceries, medicines, mobile spares, anything that can be carried on our Bikes to deliver.
Are you a Vendor, make use of our services to deliver your goods to your customers. We deliver across your city, grow your business with us. Deliver your products, goods, items across your city with us.</p>
						</div>
					</div>
					<div class="card">
<!-- 						<img class="card-img-top" src="images/card-item-2.png" -->
<!-- 							alt="Card image cap"> -->
						<span class="fa fa-globe" style="height: 100px;font-size: 35px;line-height: 130px;"></span>
						<div class="card-body">
							<h5 class="card-title">Vendor Section</h5>
							<p class="card-text">Vedagram is your partner for delivery. You need not employ anyone to deliver your goods to your Vendor Partners and Customers. We will deliver your goods safe and fast across your city within 2 hours of booking. We have delivery boys across your city who can deliver your products as well as pickup goods for you.
We take away the worry of delivering away from you and let you focus on your Business Goals. We also help you expand your reach beyond your location to across the city, now with us delivering your products across the city, onboard more customers to your business.
You can collect payments through our app along with your transactions which will be trackable, accountable and reportable at any point in time.</p>
						</div>
					</div>
					<div class="card">
<!-- 						<img class="card-img-top" src="images/card-item-3.png" -->
<!-- 							alt="Card image cap"> -->
						<span class="fa fa-user" style="height: 100px;font-size: 35px;line-height: 130px;"></span>
						<div class="card-body">
							<h5 class="card-title">Sender Section</h5>
							<p class="card-text">Vedagram is your dear friend in need! Do you have a habit of forgetting things back home? Do you want to send your spouse a hot home cooked meal right at lunch time? Do you want your ward to enjoy a hot meal cooked fresh in school? Do you plan to send a package to your father within the City? Do you want to collect medicines from your regular medical Shop?
We will help you do this all for you. Download our App and Let us know what you want to be done, it's easy and it's fast and it's dependable. Anywhere within your city we will deliver or pick your items within 2 hours of time. You also have the flexibility of paying through our App as well when you want us to bring you something from a shop. </p>
						</div>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-center">
				<a href="<%=request.getContextPath() %>/services" class="custom_link-btn"> Read More </a>
			</div>
		</div>
	</section>

	<!-- fruits section -->

	<section class="tasty_section">
		<div class="container_fluid">
			<h2>We Deliver</h2>
			<h3>Anything Anywhere Anytime</h3>
		</div>
	</section>

	<section class="client_section layout_padding" style="display: none;">
		<div class="container">
			<h2 class="custom_heading">Testimonial</h2>
			<p class="custom_heading-text">There are many variations of
				passages of Lorem Ipsum available, but the majority have</p>
			<div>
				<div id="carouselExampleControls-2" class="carousel slide"
					data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item">
							<div class="client_container layout_padding2">
								<div class="client_img-box">
									<img src="images/client.png" alt="">
								</div>
								<div class="client_detail">
									<h3>Johnhex</h3>
									<p class="custom_heading-text">
										There are many variations of passages of Lorem Ipsum
										available, but the majority have suffered alteration in some
										form, by injected humour, or randomised words which don't look
										even slightly believable. If you are <br> going to use a
										passage of Lorem Ipsum, you need to be sure
									</p>
								</div>
							</div>
						</div>
						<div class="carousel-item active">
							<div class="client_container layout_padding2">
								<div class="client_img-box">
									<img src="images/client.png" alt="">
								</div>
								<div class="client_detail">
									<h3>Johnhex</h3>
									<p class="custom_heading-text">
										There are many variations of passages of Lorem Ipsum
										available, but the majority have suffered alteration in some
										form, by injected humour, or randomised words which don't look
										even slightly believable. If you are <br> going to use a
										passage of Lorem Ipsum, you need to be sure
									</p>
								</div>
							</div>
						</div>
						<div class="carousel-item">
							<div class="client_container layout_padding2">
								<div class="client_img-box">
									<img src="images/client.png" alt="">
								</div>
								<div class="client_detail">
									<h3>Johnhex</h3>
									<p class="custom_heading-text">
										There are many variations of passages of Lorem Ipsum
										available, but the majority have suffered alteration in some
										form, by injected humour, or randomised words which don't look
										even slightly believable. If you are <br> going to use a
										passage of Lorem Ipsum, you need to be sure
									</p>
								</div>
							</div>
						</div>
					</div>
					<div class="custom_carousel-control">
						<a class="carousel-control-prev" href="#carouselExampleControls-2"
							role="button" data-slide="prev"> <span class=""
							aria-hidden="true"></span> <span class="sr-only">Previous</span>
						</a> <a class="carousel-control-next"
							href="#carouselExampleControls-2" role="button" data-slide="next">
							<span class="" aria-hidden="true"></span> <span class="sr-only">Next</span>
						</a>
					</div>

				</div>
			</div>
		</div>
	</section>

	<section class="fruit_section" style="display: none;">
		<div class="container">
			<div class="row layout_padding2">
				<div class="col-md-8">
					<div class="fruit_detail-box">
						<h3>Track Shipment</h3>
						<p class="mt-4 mb-5">Track your domestic shipments with
							pickdrop. Just enter trackingID or Order#.</p>
						<!-- 						<div> -->
						<!-- 							<a href="" class="custom_dark-btn"> Buy Now </a> -->
						<!-- 						</div> -->
					</div>
				</div>
				<div
					class="col-md-4 d-flex justify-content-center align-items-center">
					<div
						class="fruit_img-box d-flex justify-content-center align-items-center">
						<img src="images/img6.jpg" alt="" class="" width="300px" />
					</div>
				</div>
			</div>
			<div class="row layout_padding2">
				<div class="col-md-8">
					<div class="fruit_detail-box">
						<h3>Quick Quote</h3>
						<p class="mt-4 mb-5">Get FREE, no-obligation quick quotes from
							pickdropÂ® for your LTL and more!</p>
						<!-- 						<div> -->
						<!-- 							<a href="" class="custom_dark-btn"> Buy Now </a> -->
						<!-- 						</div> -->
					</div>
				</div>
				<div
					class="col-md-4 d-flex justify-content-center align-items-center">
					<div class="fruit_img-box d-flex justify-content-center ">
						<img src="images/calculate-1.jpg" alt="" class="" width="300px" />
					</div>
				</div>
			</div>
			<div class="row layout_padding2-top layout_padding-bottom">
				<div class="col-md-8">
					<div class="fruit_detail-box">
						<h3>More from Vedagram</h3>
						<p class="mt-4 mb-5">
						<h4>eNews</h4>
						Vedagram eNews provides you with the latest regulations,
						interesting insights on Vedagram products and services and useful
						shipping tips & tricks.
						</p>
						<!-- 						<div> -->
						<!-- 							<a href="" class="custom_dark-btn"> Buy Now </a> -->
						<!-- 						</div> -->
					</div>
				</div>
				<div
					class="col-md-4 d-flex justify-content-center align-items-center">
					<div
						class="fruit_img-box d-flex justify-content-center align-items-center">
						<img src="images/enews.jpg	" alt="" class="" width="300px" />
					</div>
				</div>
			</div>
			<div class="row layout_padding2-top layout_padding-bottom">
				<div class="col-md-8">
					<div class="fruit_detail-box">
						<h3>Recent News & Thought for the Day</h3>
						<p class="mt-4 mb-5">
							01. Vedagram sees good revenue growth in fiscal 2019 <br>
							02. Customs Made Easier <br> 03. Rate & Transit time


						</p>
						<!-- 						<div> -->
						<!-- 							<a href="" class="custom_dark-btn"> Buy Now </a> -->
						<!-- 						</div> -->
					</div>
				</div>
				<div
					class="col-md-4 d-flex justify-content-center align-items-center">
					<div
						class="fruit_img-box d-flex justify-content-center align-items-center">
						<img src="images/thought.jfif" alt="" class="" width="300px" />
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- end fruits section -->


	<!-- client section -->

	<!-- 	<section class="client_section layout_padding"> -->
	<!-- 		<div class="container"> -->
	<!-- 			<h2 class="custom_heading">Testimonial</h2> -->
	<!-- 			<p class="custom_heading-text">There are many variations of -->
	<!-- 				passages of Lorem Ipsum available, but the majority have</p> -->
	<!-- 			<div> -->
	<!-- 				<div id="carouselExampleControls-2" class="carousel slide" -->
	<!-- 					data-ride="carousel"> -->
	<!-- 					<div class="carousel-inner"> -->
	<!-- 						<div class="carousel-item active"> -->
	<!-- 							<div class="client_container layout_padding2"> -->
	<!-- 								<div class="client_img-box"> -->
	<!-- 									<img src="images/client.png" alt="" /> -->
	<!-- 								</div> -->
	<!-- 								<div class="client_detail"> -->
	<!-- 									<h3>Johnhex</h3> -->
	<!-- 									<p class="custom_heading-text"> -->
	<!-- 										There are many variations of passages of Lorem Ipsum -->
	<!-- 										available, but the majority have suffered alteration in some -->
	<!-- 										form, by injected humour, or randomised words which don't look -->
	<!-- 										even slightly believable. If you are <br /> going to use a -->
	<!-- 										passage of Lorem Ipsum, you need to be sure -->
	<!-- 									</p> -->
	<!-- 								</div> -->
	<!-- 							</div> -->
	<!-- 						</div> -->
	<!-- 						<div class="carousel-item"> -->
	<!-- 							<div class="client_container layout_padding2"> -->
	<!-- 								<div class="client_img-box"> -->
	<!-- 									<img src="images/client.png" alt="" /> -->
	<!-- 								</div> -->
	<!-- 								<div class="client_detail"> -->
	<!-- 									<h3>Johnhex</h3> -->
	<!-- 									<p class="custom_heading-text"> -->
	<!-- 										There are many variations of passages of Lorem Ipsum -->
	<!-- 										available, but the majority have suffered alteration in some -->
	<!-- 										form, by injected humour, or randomised words which don't look -->
	<!-- 										even slightly believable. If you are <br /> going to use a -->
	<!-- 										passage of Lorem Ipsum, you need to be sure -->
	<!-- 									</p> -->
	<!-- 								</div> -->
	<!-- 							</div> -->
	<!-- 						</div> -->
	<!-- 						<div class="carousel-item"> -->
	<!-- 							<div class="client_container layout_padding2"> -->
	<!-- 								<div class="client_img-box"> -->
	<!-- 									<img src="images/client.png" alt="" /> -->
	<!-- 								</div> -->
	<!-- 								<div class="client_detail"> -->
	<!-- 									<h3>Johnhex</h3> -->
	<!-- 									<p class="custom_heading-text"> -->
	<!-- 										There are many variations of passages of Lorem Ipsum -->
	<!-- 										available, but the majority have suffered alteration in some -->
	<!-- 										form, by injected humour, or randomised words which don't look -->
	<!-- 										even slightly believable. If you are <br /> going to use a -->
	<!-- 										passage of Lorem Ipsum, you need to be sure -->
	<!-- 									</p> -->
	<!-- 								</div> -->
	<!-- 							</div> -->
	<!-- 						</div> -->
	<!-- 					</div> -->
	<!-- 					<div class="custom_carousel-control"> -->
	<!-- 						<a class="carousel-control-prev" href="#carouselExampleControls-2" -->
	<!-- 							role="button" data-slide="prev"> <span class="" -->
	<!-- 							aria-hidden="true"></span> <span class="sr-only">Previous</span> -->
	<!-- 						</a> <a class="carousel-control-next" -->
	<!-- 							href="#carouselExampleControls-2" role="button" data-slide="next"> -->
	<!-- 							<span class="" aria-hidden="true"></span> <span class="sr-only">Next</span> -->
	<!-- 						</a> -->
	<!-- 					</div> -->

	<!-- 				</div> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
	<!-- 	</section> -->
	<section class="fruit_section">
		<div class="container">
			<div class="row layout_padding2">
				<div class="col-md-4">
					<div class="fruit_detail-box pdinfocls">
						<h3>Open a Vedagram account</h3>
						<p class="mt-4 mb-5">Take advantage of our services and
							solutions designed to meet all of your shipping requirements.
							Sign up for a Vedagram shipping account below. Letâs get
							started!</p>


						<div class="pdinfomorecls">
							<a href="" class="custom_link-btn"> more </a>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="fruit_detail-box pdinfocls">
						<h3>Returns Frequently Asked Questions</h3>
						<p class="mt-4 mb-5">Get all the queries answered here which
							includes Why to Choose Vedagram.</p>


						<div class="pdinfomorecls">
							<a href="<%=request.getContextPath() %>/faq" class="custom_link-btn"> more </a>
						</div>
					</div>
				</div>
				<div class="col-md-4">

					<div class="fruit_detail-box pdinfocls">
						<h3>The Vedagram difference</h3>
						<p class="mt-4 mb-5">Opportunity to anybody | Making the
							plateform open to public | Choice | Simplicity | Savings | Live
							support | Peace of mind | Reassurance | We are local players</p>


						<div class="pdinfomorecls">
							<a href="" class="custom_link-btn"> more </a>
						</div>
					</div>
				</div>


			</div>

		</div>
	</section>

	<section class="fruit_section"
		style="margin-top: 60px; margin-bottom: 60px; text-align: center;">
		<div class="container">
			<h2 class="custom_heading">
				<a href="<%=request.getContextPath() %>/partners"  style="color: #000000;">Our Partners</a>
			</h2>
			<div class="row layout_padding2">
				<div class="col-md-12">
					<img src="<%=request.getContextPath() %>/images/partner1.png"></img>
				</div>
				
				<div style="text-align: center;float: left;width: 100%;margin-top: 40px; display: none;">
					<a href="<%=request.getContextPath() %>/partners" class="custom_link-btn">Read More</a>
				</div>
			</div>
		</div>
	</section>
</div>
