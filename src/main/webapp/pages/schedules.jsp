<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<title>Vedagram : Track Deliveries</title>
<script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script>
<script src="<%=request.getContextPath()%>/js/googlemap.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyChv9TXatYolUD1DLrnzTuRni4xYvhsRNQ&callback=initMap&libraries=places&v=weekly" async></script>


<style type="text/css">
.pickUpTxtCls, .DropTxtCls {
	cursor: pointer;
}
::-webkit-input-placeholder { /* Edge */
  color: #cdcdcd;
}
:-ms-input-placeholder { /* Internet Explorer 10-11 */
  color: #cdcdcd;
}
::placeholder {
  color: #cdcdcd;
}
.confirmBookingMainCls {
	float: left;
    width: 100%;
    margin-top: 20px;
}
.confirmBookingCls {
	font-size: 12px;
    font-weight: normal;
    padding: 6px 15px;
    background: rgba(0,148,205,1);
    color: rgba(255,255,255,1);
    border-radius: 3px;
    cursor: pointer;
    float: left;
    line-height: 20px;
}
.addMoreMainCls {
    float: left;
    width: 100%;
}
.addMoreCls {
	font-size: 10px;
    font-weight: normal;
    padding: 4px 8px;
    background: rgba(48,197,143,0.2);
    color: rgba(48,197,143,1);
    border-radius: 3px;
    cursor: pointer;
}

/* Set the size of the div element that contains the map */
#map {
  height: 300px;
  /* The height is 400 pixels */
  width: 100%;
  /* The width is the width of the web page */
}
.removeDropCls {
	font-size: 16px;
    color: rgba(220,52,52,1);
    position: absolute;
    right: 0;
    top: 6px;
    cursor: pointer;
}
.formInputCls {
    border-left: 1px !important;
    border-right: 1px !important;
    border-top: 1px !important;
    border-radius: 0px !important;
    padding: 4px 0px 4px 0px !important;
	height: 30px;
	margin-bottom: 0px !important;
}
.mapFormInputCls {
    border-left: 1px !important;
    border-right: 1px !important;
    border-top: 1px !important;
    border-radius: 0px !important;
    padding: 4px 0px 4px 0px !important;
}
.formHdrCls {
	font-size: 10px;
    color: gray;
}
.favVedagramCls {
    position: absolute;
    right: 0;
    top: 0px;
    font-size: 10px;
    background: #cdcdcd;
    padding: 2px 6px;
    border-radius: 4px;
    color: white;
}
.priorityCls {
	background: #5fe1cf;
    color: white;
}
.searchResultMainCls {
    font-size: 11px;
    float: left;
    width: 100%;
    margin-bottom: 20px;
}
.searchResultBodyCls {
    font-size: 13px;
}
.recentSearchMainCls {
    font-size: 11px;
    float: left;
    width: 100%;
    margin-bottom: 20px;
}
.recentSearchBodyCls {
    font-size: 13px;
}
.favouriteMainCls {
    font-size: 11px;
    float: left;
    width: 100%;
    margin-bottom: 20px;
}
.favouriteBodyCls {
    font-size: 13px;
}
.iconCls {
	float: left;
    width: 20px;
    line-height: 20px;
    font-size: 14px;
    color: gray;
}
.mapResultRowCls, .favouriteResultRowCls {
    float: left;
    width: 100%;
    position: relative;
    cursor: pointer;
}
.mapResultRowCls:hover, .favouriteResultRowCls:hover, .mapResultRowCls:hover .iconCls, .favouriteResultRowCls:hover .iconCls {
    color: #3dab9b;
}
.searchResultHdrCls, .recentSearchHdrCls {
    margin-bottom: 10px;
}
.mapRsultCls, .favouriteRsultCls {
	min-height: 30px;
}
.modal-body {
    height: 70vh;
    overflow-y: auto;
}


#Pick_up, #Drop {
    overflow: visible;
    width: 47px;
    white-space: nowrap;
    line-height: 19px;
    margin: 10px 0 5px 0;
    text-align: left;
    font-family: Lato;
    font-style: normal;
    font-weight: bold;
    font-size: 14px;
    color: rgba(198,198,198,1);
}

#Select_Pick_up_Location {
	white-space: nowrap;
    text-align: left;
    font-family: Poppins;
    font-style: normal;
    font-weight: normal;
    font-size: 16px;
    color: rgba(0,148,205,1);
}
#Select_Drop_Location {
	white-space: nowrap;
    text-align: left;
    font-family: Poppins;
    font-style: normal;
    font-weight: normal;
    font-size: 16px;
    color: rgba(0,148,205,1);
}
#Safe_Secure__On_Demand {
	white-space: nowrap;
    line-height: 34px;
    margin-top: -3px;
    text-align: left;
    font-family: Poppins;
    font-style: normal;
    font-weight: bold;
    font-size: 28px;
    color: rgba(0,148,205,1);
    border-radius: 10px;
}
#sendPackage {
    white-space: nowrap;
    line-height: 34px;
    margin-top: -3px;
    text-align: left;
    font-family: Poppins;
    font-style: normal;
    font-weight: bold;
    color: rgba(0,148,205,1);
    border-radius: 10px;
}
.box1Cls {
	background: white;
    padding: 20px;
    border-radius: 10px;
}
</style>
<script>
$(document).ready(function() {
	$('.pickUpTxtCls').click(function() {
		$('#searchVedagramModal').modal({
			show: true,
		});
	});
	
	$('.dropTxtCls').click(function() {
		$('#searchVedagramModal').modal({
			show: true,
		});
	});
	
	$('.mapResultRowCls').click(function() {
		$('#searchVedagramModal').modal('hide');
		//initMap();
		$('#pickDropFormModal').modal({
			show: true,
		});
	});
	

});

//Initialize and add the map
function initMap1() {
  // The location of Uluru
  const uluru = { lat: -25.344, lng: 131.036 };
  // The map, centered at Uluru
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 4,
    center: uluru,
  });
  // The marker, positioned at Uluru
  const marker = new google.maps.Marker({
    position: uluru,
    map: map,
  });
}
</script>
</head>

<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding" style="background-color: rgba(241,251,255,1);">
				<div class="container">
					<h5 class="font-weight-bold">
						<span>Send Package</span>
					</h5>
					<div class="row formcls">
						<div class="col-md-8 mr-auto" style="">
							<div class="reqwisecls box1Cls" id="sendPackage">
								<div class="col-md-12 mr-auto">
									<div class="row">
										<div class="col-md-6 mr-auto" style="">
											<div id="Select_Pick_up_Location">
												<span>Select Pick up Location</span>
											</div>
											<div>
												<div id="Pick_up">
													<span>Pick up</span>
												</div>
												<div>
													<input type="text" class="pickUpTxtCls formInputCls" readonly="readonly" placeholder="Select Pickup location">
													<div style="float: left; width: 100%; font-weight: normal; font-size: 11px; color: gray !important;">
														<div style="float: left; width: auto;">
															<i class="fa fa-phone" style="color: inherit;"></i> <span>9500140084</span>
														</div>
														<div style="float: left; width: auto; margin-left: 15px;">
															<i class="fa fa-user" style="color: inherit;"></i> <span>Winston</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-md-6 mr-auto" style="">
											<div id="Select_Drop_Location">
												<span>Select Drop Location</span>
											</div>
											<div class="dropMainCls">
												<div class="dropRowCls">
													<div id="Drop">
														<span>Drop</span>
													</div>
													<div style="float: left; width: 100%; position: relative;">
														<i class="fa fa-minus-circle removeDropCls"></i>
														<input type="text" class="dropTxtCls formInputCls" readonly="readonly" placeholder="Select Drop location">
														<div style="float: left; width: 100%; font-weight: normal; font-size: 11px; color: gray !important;">
															<div style="float: left; width: auto;">
																<i class="fa fa-phone" style="color: inherit;"></i> <span>9500140084</span>
															</div>
															<div style="float: left; width: auto; margin-left: 15px;">
																<i class="fa fa-user" style="color: inherit;"></i> <span>Winston</span>
															</div>
															<div style="float: right; width: auto; color: rgba(48,197,143,1);">
																<i class="fa fa-inr" style="color: inherit;"></i> <span>50</span>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="addMoreMainCls">
												<span class="addMoreCls"><i class="fa fa-plus" style="color: inherit;"></i> Add Drop location</span>
											</div>
											
											<div class="confirmBookingMainCls">
												<span class="confirmBookingCls">Confirm Booking</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4 mr-auto" style="">
							<div class="box1Cls">
								<div id="Safe_Secure__On_Demand">
									<span>Safe Secure &amp;<br>On Demand</span>
								</div>
								<div>
									<div>
										<ul style="padding-left: 20px; margin-top: 20px;">
											<li>Select Pick up Location</li>
											<li>Add Multiple Drop Locations</li>
											<li>Enjoy affordable & Hassle free deliveries</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	
	<div class="modal formcls" id="searchVedagramModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content content_1" style="border-radius: 10px; border: none;">
		          <div class="modal-header" style="display: block;background: rgba(0,148,205,1);border-radius: 10px;">
		              <button type="button" class="close" data-dismiss="modal" style="position:relative;"><span class="sr-only">Close</span></button>
		              <div class="modal-title" id="myModalLabel" style="float: left; width: 100%;color: white;">Search Drop Location</div>
		              <div style="float: left;width: 100%;position: relative;margin-top: 20px;">
		              	<i class="fa fa-search" style="position: absolute;color: rgba(48,197,143,1);line-height: 35px;width: 30px;text-align: center;"></i>
		              	<input type="text" placeholder="Search your location" id="srchMapLoc" style="padding-left: 30px;margin: 0;">
		              	<div id="map"></div>
		              </div>
		          </div>
		          <div class="modal-body">
		              <div class="row1">
							<div class="col-md-12 col-sm-12 col-ms-12">
								<div class="searchResultMainCls">
									<div class="searchResultHdrCls">
										<div>Search Results</div>
									</div>
									<div class="searchResultBodyCls">
										<div class="mapResultRowCls">
											<i class="fa fa-map-marker mapIconCls iconCls"></i>
											<div class="mapRsultCls">
												<div class="mapLocationCls">Billroth Hospital</div>
											</div>
										</div>
										<div class="mapResultRowCls">
											<i class="fa fa-map-marker mapIconCls iconCls"></i>
											<div class="mapRsultCls">
												<div class="mapLocationCls">Billroth Hospital 1</div>
											</div>
										</div>
										<div class="mapResultRowCls">
											<i class="fa fa-map-marker mapIconCls iconCls"></i>
											<div class="mapRsultCls">
												<div class="mapLocationCls">Billroth Hospital 2</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="recentSearchMainCls">
									<div class="recentSearchHdrCls">
										<div class="recentSrchLblCls">Recent Search Result</div>
									</div>
									<div class="recentSearchBodyCls">
										<div class="mapResultRowCls">
											<i class="fa fa-search srchIconCls iconCls"></i>
											<div class="mapRsultCls">
												<div class="mapLocationCls">Billroth Hospital</div>
											</div>
										</div>
										<div class="mapResultRowCls">
											<i class="fa fa-search srchIconCls iconCls"></i>
											<div class="mapRsultCls">
												<div class="mapLocationCls">Billroth Hospital 1</div>
											</div>
										</div>
										<div class="mapResultRowCls">
											<i class="fa fa-search srchIconCls iconCls"></i>
											<div class="mapRsultCls">
												<div class="mapLocationCls">Billroth Hospital 2</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="favouriteMainCls">
									<div class="favouriteHdrCls">
										<div class="favouriteLblCls">Favourites</div>
										<div style="float: left;width: 100%;position: relative;margin-top: 10px;margin-bottom: 20px;">
							              	<i class="fa fa-search" style="position: absolute;color: rgba(48,197,143,1);line-height: 35px;width: 30px;text-align: center;"></i>
							              	<input type="text" class="favouriteSrchTxtCls" placeholder="Search your location" style="padding-left: 30px;margin: 0;border-color: #5fe1cf;">
										</div>
									</div>
									<div class="favouriteBodyCls">
										<div class="favouriteResultRowCls">
											<i class="fa fa-bookmark srchIconCls iconCls"></i>
											<div class="favouriteRsultCls">
												<div class="favouriteLocationCls">Billroth Hospital</div>
											</div>
											<span class="favVedagramCls priorityCls">Pick</span>
										</div>
										<div class="favouriteResultRowCls">
											<i class="fa fa-bookmark srchIconCls iconCls"></i>
											<div class="favouriteRsultCls">
												<div class="favouriteLocationCls">Billroth Hospital 1</div>
											</div>
											<span class="favVedagramCls">Pick</span>
										</div>
										<div class="favouriteResultRowCls">
											<i class="fa fa-bookmark srchIconCls iconCls"></i>
											<div class="favouriteRsultCls">
												<div class="favouriteLocationCls">Billroth Hospital 2</div>
											</div>
											<span class="favVedagramCls">Pick</span>
										</div>
									</div>
								</div>
							</div>
		              </div>
		          </div>
		      </div>
		</div>
	</div>
	
	<div class="modal formcls" id="pickDropFormModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content content_1" style="border-radius: 10px; border: none;">
		          <div class="modal-header" style="display: block;background: rgba(0,148,205,1);padding: 0;">
		              <button type="button" class="close" data-dismiss="modal" style="position:relative;"><span class="sr-only">Close</span></button>
		              <div class="mapDivCls">
		              	<div id="map"></div>
		              </div>
		          </div>
		          <div class="modal-body" style="border-radius: 10px; background: white; margin-top: -10px;height: 57vh;">
		              <div class="row1">
							<div class="col-md-12 col-sm-12 col-ms-12">
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6">
										<span class="formHdrCls">Contact Name</span>
										<input type="text" class="name mapFormInputCls">
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6">
										<span class="formHdrCls">Contact Number</span>
										<input type="text" class="phone mapFormInputCls">
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<span class="formHdrCls">Landmark</span>
										<input type="text" class="landmark mapFormInputCls">
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<span class="formHdrCls">Instructions to Delivery Agent [ Eg: Beware of Dogs]</span>
										<input type="text" class="instruction mapFormInputCls">
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6">
										<input type="checkbox" name="codFlag" id="codFlag" style="float: left; width: auto; margin: 2px 5px 0px 0px;">
										<label for="codFlag">COD</label>
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6">
										<input type="checkbox" name="inclDelvChargeFlag" id="inclDelvChargeFlag" style="float: left; width: auto; margin: 2px 5px 0px 0px;">
										<label for="inclDelvChargeFlag">Includes Delivery Charges</label>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6">
										<span class="formHdrCls">Payment Type</span>
										<select class="paymentType mapFormInputCls">
											<option value="1">COD</option>
											<option value="2">Online</option>
										</select>
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6">
										<span class="formHdrCls">COD Amount</span>
										<input type="text" class="codAmnt mapFormInputCls">
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6">
										<input type="button" value="Go Back" class="backBtnCls">
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6">
										<input type="button" value="Confirm Location" class="cnfrmLocBtnCls">
									</div>
								</div>
							</div>
		              </div>
		          </div>
		      </div>
		</div>
	</div>
</body>

