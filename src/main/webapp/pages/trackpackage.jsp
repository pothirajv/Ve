<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<title>Vedagram : Track Deliveries</title>
<script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script>

<style type="text/css">
.amountSplitInnerCls {
    float: left;
    width: 100%;
}
.amountSplitInnerRowCls {
    float: left;
    width: 100%;
}
.amountSplitCls {
    float: left;
    font-size: 9px;
}
.amountSplitInnerCls .fa {
    float: initial !important;
    line-height: 18px !important;
    margin-right: 0px !important;
    color: gray !important;
}
.mulReqExpandCls {
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 19px;
    font-weight: bold;
    cursor: pointer;
    z-index: 1;
}
.mulreqwisecls .childReqCls {
	display: none;
}
.delvAmountMainCls .fa {
    float: left;
    color: rgba(0,148,205,1);
    line-height: 18px;
    margin-right: 2px;
}
.statusStageDotCls {
    float: left;
    width: 10px !important;
    accent-color: green;
    margin-top: 2px;
}
.statusStageMainDummyCls {
    display: none;
}
.packageStatusMainCls {
    margin-left: 15px !important;
}
.packageStatusInfoCls {
    float: left;
    width: 100%;
}
.packageStatusDateCls {
    font-size: 9px;
}
.statusStageMainCls {
	display: none;
    position: relative;
    margin-bottom: 15px;
}
.statusStageContainerCls .statusStageMainCls {
	display: block;
	float: left;
    width: 100%;
}
.statusStageLineCls {
    width: 30px;
    border: 1px solid #30c58f;
    position: absolute;
    left: -10px;
    top: 30px;
    transform: rotate(90deg);
}
.delvAmountCls {
	float: left;
	width: auto;
	color: rgba(0,148,205,1);
}
.distanceCls {
    color: rgba(0,148,205,1);
}
.reqwisehdncls, .mulreqwisehdncls {
	display: none;
	margin-bottom: 10px;
}
.reqwisecls, .mulreqwisecls {
	margin-bottom: 10px;
	position: relative;
}
.hideRowCls {
	margin-top: 20px;
}
.scheduleDtMainCls {
    background: rgba(241,251,255,1);
    padding: 0px 10px;
    border-radius: 4px;
    cursor: pointer;
    color: rgba(0,148,205,1);
}
.mainBodyDivVend {
	background-color: rgba(241,251,255,1);
}
.layout_padding {
    padding: 35px 20px 100px 20px !important;
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
    padding: 20px 0px;
    border-radius: 10px;
}
.frmValLblCls {
    font-size: 11px;
}
</style>
<script>
$(document).ready(function() {
	$('.reqmaincls').html('');
	$.ajax({
		url : $("#contextPath").val()+'/b/a',
		contentType : "application/json",
		type : 'POST',
		success:function(data){
			console.log(data);
			for (var i = 0; i < data.length; i++) {
				var reqWiseObj = addReqContainer(data[i]);
				$('.reqmaincls').append(reqWiseObj);
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
	
	$(document).on('click', '.mulReqExpandCls', function() {
		if($(this).closest('.mulreqwisecls').find('.childReqCls').is(':visible')) {
			$(this).removeClass('fa-angle-up').addClass('fa-angle-down');
			$(this).closest('.mulreqwisecls').find('.reqHeaderCls').slideDown();
			$(this).closest('.mulreqwisecls').find('.childReqCls').slideUp();
		} else {
			$(this).removeClass('fa-angle-down').addClass('fa-angle-up');
			$(this).closest('.mulreqwisecls').find('.reqHeaderCls').slideUp();
			$(this).closest('.mulreqwisecls').find('.childReqCls').slideDown();
		}
	});
});

function addReqContainer(rowObj) {
	
	if(rowObj.multiRequestList != null && rowObj.multiRequestList.length > 0) {
		var childOneObj = rowObj.multiRequestList[0];
		var reqWiseObj1 = $('.mulreqwisehdncls').clone().removeClass('mulreqwisehdncls').addClass('mulreqwisecls');
		$(reqWiseObj1).find('.senderNameCls').html(childOneObj.senderFirstName);
		$(reqWiseObj1).find('.senderMobileCls').html(childOneObj.senderPhoneNumber);
		$(reqWiseObj1).find('.senderAddrCls').html(childOneObj.pickUpHouseNo);
		$(reqWiseObj1).find('.noOfReqCls').html(rowObj.multiRequestList.length);
		$(reqWiseObj1).find('.createdOnCls').html(new Date(childOneObj.createdDt).toShortFormat());
		
		for (var i = 0; i < rowObj.multiRequestList.length; i++) {
			var childReqObj = rowObj.multiRequestList[i];
			var reqWiseObj = addReqContainer(childReqObj);
			$(reqWiseObj1).find('.childReqCls').append(reqWiseObj);
		}
		return reqWiseObj1;
	}
	
	var ackFlag = rowObj.ackFlag;
	var actualAmount = rowObj.actualAmount;
	var amount = rowObj.amount;
	var taskPrice = rowObj.taskPrice;
	var assignedToPhoneNumber = rowObj.assignedToPhoneNumber;
	var assignedUserId = rowObj.assignedUserId;
	var awbNumber = rowObj.awbNumber;
	var codFlag = rowObj.codFlag;
	var receiverPhone = rowObj.contactPhone;
	var createdDate = rowObj.createdDt;
	var deliverName = rowObj.deliverFirstName;
	var deliveredDate = rowObj.deliveredDate;
	var deliveryChargeInclu = rowObj.deliveryChargeInclu;
	var distance = rowObj.distance;
	var itemPayFlag = rowObj.itemPayFlag;
	var latitude = rowObj.latitude;
	var longitude = rowObj.longitude;
	var noPayFlag = rowObj.noPayFlag;
	var packagePickupAddress = rowObj.packagePickupAddress;
	var packageStatus = rowObj.packageStatus;
	var paidPoint = rowObj.paidPoint;
	var parcelType = rowObj.parcelType;
	var pickedUpDate = rowObj.pickedUpDate;
	var pickUpHouseNo = rowObj.pickUpHouseNo;
	var receiverLocation = rowObj.receiverLocation;
	var recieverAddress = rowObj.recieverAddress;
	var recieverContact = rowObj.recieverContact;
	var recieverHouseNo = rowObj.recieverHouseNo;
	var recieverName = rowObj.recieverName;
	var requestId = rowObj.requestId;
	var scheduleDate = rowObj.scheduleDate;
	var scheduleReqId = rowObj.scheduleReqId;
	var senderFirstName = rowObj.senderFirstName;
	var senderPhoneNumber = rowObj.senderPhoneNumber;
	var toLat = rowObj.toLat;
	var toLong = rowObj.toLong;
	var totAmount = rowObj.totAmount;
	var vendorGroupName = rowObj.vendorGroupName;
	var vendorName = rowObj.vendorName;
	var weight = rowObj.weight;
	var multiDelvNoOfReq = rowObj.multiDelvNoOfReq;
	var multiReqFlg = rowObj.multiReqFlg;
	var multiTotNoOfReq = rowObj.multiTotNoOfReq;
	var multiUndelvNoOfReq = rowObj.multiUndelvNoOfReq;
	
	var reqWiseObj = $('.reqwisehdncls').clone().removeClass('reqwisehdncls').addClass('reqwisecls');
	$(reqWiseObj).find('.senderNameCls').html(senderFirstName);
	$(reqWiseObj).find('.receiverNameCls').html(recieverName);
	$(reqWiseObj).find('.distanceCls').html(distance);
	$(reqWiseObj).find('.delvAmountCls').html(totAmount);
	$(reqWiseObj).find('.packageStatusCls').html(packageStatus);
	$(reqWiseObj).find('.senderMobileCls').html(senderPhoneNumber);
	$(reqWiseObj).find('.senderAddrCls').html(pickUpHouseNo);
	$(reqWiseObj).find('.receiverMobileCls').html(receiverPhone);
	$(reqWiseObj).find('.receiverAddrCls').html(recieverHouseNo);
	
	if(taskPrice > 0) {
		var htmlVar1 = '<span class="amountSplitInnerCls">';
		htmlVar1 += '<span class="amountSplitInnerRowCls">Delivery Charge: <span class="fa fa-inr"></span> <span>'+amount+'</span></span>';
		htmlVar1 += '<span class="amountSplitInnerRowCls">Task Price: <span class="fa fa-inr"></span> <span>'+taskPrice+'</span></span>';
		htmlVar1 += '</span>';
		
		$(reqWiseObj).find('.amountSplitCls').html(htmlVar1);
	} else {
		$(reqWiseObj).find('.amountSplitCls').html('');
	}
	
	if(scheduleDate != '' && scheduleDate != undefined) {
		$(reqWiseObj).find('.scheduleDateCls').html(new Date(scheduleDate).toShortFormat());
	} else {
		$(reqWiseObj).find('.scheduleDateMainCls').find('.scheduleDtMainCls').html('NA').removeClass('scheduleDtMainCls');
		$(reqWiseObj).find('.scheduleDateCls').html('');
	}
	
	if(paidPoint == 1) {
		$(reqWiseObj).find('.paymentTypeCls').html('Cash At Pickup');
	} else if(paidPoint == 2) {
		$(reqWiseObj).find('.paymentTypeCls').html('Cash At Drop');
	} else if(paidPoint == 3) {
		$(reqWiseObj).find('.paymentTypeCls').html('Online');
	}
	
	$(reqWiseObj).find('.itemWeightCls').html(weight + ' Kg');
	
	$(reqWiseObj).find('.statusStageContainerCls').html('');
	
	if(createdDate != null && createdDate != '') {
		var statusStageContainerObj1 = $('.statusStageMainDummyCls').clone().removeClass('statusStageMainDummyCls').addClass('statusStageMainCls');
		$(statusStageContainerObj1).find('.packageStatusInfoCls').html("Package Created");
		$(statusStageContainerObj1).find('.packageStatusDateCls').html(new Date(createdDate).toShortFormat());
		if((pickedUpDate == null || pickedUpDate == '' || pickedUpDate == undefined) && 
				(deliveredDate == null || deliveredDate == '' || deliveredDate == undefined)) {
			$(statusStageContainerObj1).find('.statusStageLineCls').hide();
		}
		$(reqWiseObj).find('.statusStageContainerCls').append(statusStageContainerObj1);
	}
	
	if(pickedUpDate != null && pickedUpDate != '') {
		var statusStageContainerObj2 = $('.statusStageMainDummyCls').clone().removeClass('statusStageMainDummyCls').addClass('statusStageMainCls');
		$(statusStageContainerObj2).find('.packageStatusInfoCls').html("Package Picked up");
		$(statusStageContainerObj2).find('.packageStatusDateCls').html(new Date(pickedUpDate).toShortFormat());
		if(deliveredDate == null || deliveredDate == '' || deliveredDate == undefined) {
			$(statusStageContainerObj2).find('.statusStageLineCls').hide();
		}
		$(reqWiseObj).find('.statusStageContainerCls').append(statusStageContainerObj2);
	}
	
	if(deliveredDate != null && deliveredDate != '') {
		var statusStageContainerObj3 = $('.statusStageMainDummyCls').clone().removeClass('statusStageMainDummyCls').addClass('statusStageMainCls');
		$(statusStageContainerObj3).find('.packageStatusInfoCls').html("Package Delivered");
		$(statusStageContainerObj3).find('.packageStatusDateCls').html(new Date(deliveredDate).toShortFormat());
		$(statusStageContainerObj3).find('.statusStageLineCls').hide();
		$(reqWiseObj).find('.statusStageContainerCls').append(statusStageContainerObj3);
	}
	
	return reqWiseObj;
}

Date.prototype.toShortFormat = function() {
    var month_names =["Jan","Feb","Mar",
                      "Apr","May","Jun",
                      "Jul","Aug","Sep",
                      "Oct","Nov","Dec"];
    
    var day = this.getDate();
    var month_index = this.getMonth();
    var year = this.getFullYear();
    var hours = this.getHours();
    var minutes = this.getMinutes();
    var ampm = (hours < 12 || hours === 24) ? "AM" : "PM";
    var hours = hours % 12 || 12;
    
    return "" + day + "-" + month_names[month_index] + "-" + year + " " + hours + ":" + minutes + " " + ampm;
}

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
						<span>Track Package</span>
					</h5>
					<div class="row formcls">
						<div class="col-md-12 mr-auto reqmaincls" style="">
							
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

<div class="mulreqwisehdncls box1Cls">
	<span class="fa fa-angle-down mulReqExpandCls"></span>
	<div class="col-md-12 mr-auto reqHeaderCls">
		<div class="row">
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">Sender Details</div>
				<div class="frmValLblCls senderNameCls"></div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">Sender Contact</div>
				<div class="frmValLblCls senderMobileCls"></div>
			</div>
			<div class="col-md-2 mr-auto scheduleDateMainCls" style="">
				<div class="formHdrCls">Sender Address</div>
				<div class="frmValLblCls senderAddrCls"></div>
			</div>
			<div class="col-md-2 mr-auto scheduleDateMainCls" style="">
				<div class="formHdrCls">No. Of Req</div>
				<div class="frmValLblCls noOfReqCls"></div>
			</div>
			<div class="col-md-2 mr-auto scheduleDateMainCls" style="">
				<div class="formHdrCls">Created On</div>
				<div class="frmValLblCls createdOnCls"></div>
			</div>
		</div>
	</div>
	<div class="childReqCls"></div>
</div>

<div class="reqwisehdncls box1Cls">
	<div class="col-md-12 mr-auto">
		<div class="row">
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">Sender Details</div>
				<div class="frmValLblCls senderNameCls"></div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">Receiver Details</div>
				<div class="frmValLblCls receiverNameCls"></div>
			</div>
			<div class="col-md-2 mr-auto scheduleDateMainCls" style="">
				<div class="formHdrCls">Scheduled On</div>
				<div class="frmValLblCls createdDateMainCls" style="">
					<span class="scheduleDtMainCls" style="">
						<i class="fa fa-calendar" style="color: inherit;"></i>
						<span class="scheduleDateCls">yyyy-mm-dd</span>
					</span>
				</div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">&nbsp;</div>
				<div class="frmValLblCls distanceCls">0 Km</div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">&nbsp;</div>
				<div class="frmValLblCls senderDetailsCls">
					<div class="frmValLblCls">
						<div class="delvAmountMainCls">
							<i class="fa fa-inr"></i> <span class="delvAmountCls"></span>
							<span class="amountSplitCls"></span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">&nbsp;</div>
				<div class="frmValLblCls packageStatusCls"></div>
			</div>
		</div>
		
		<div class="row hideRowCls">
			<div class="col-md-2 mr-auto" style="">
				<div class="frmValLblCls senderMobileCls"></div>
				<div class="formHdrCls">&nbsp;</div>
				<div class="frmValLblCls senderAddrCls"></div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="frmValLblCls receiverMobileCls"></div>
				<div class="formHdrCls">&nbsp;</div>
				<div class="frmValLblCls receiverAddrCls"></div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">Payment Type</div>
				<div class="frmValLblCls paymentTypeCls"></div>
			</div>
			<div class="col-md-2 mr-auto" style="">
				<div class="formHdrCls">Weight</div>
				<div class="frmValLblCls itemWeightCls"></div>
			</div>
			<div class="col-md-4 mr-auto" style="">
				<div class="formHdrCls">Package Status</div>
				<div class="frmValLblCls statusStageContainerCls">
				</div>
			</div>
		</div>
	</div>
</div>

<div class="statusStageMainDummyCls">
	<input class="statusStageDotCls" type="radio" checked="checked">
	<div class="packageStatusMainCls">
	    <span class="packageStatusInfoCls">Package Created</span>
	    <span class="packageStatusDateCls">dd-mm-yyyy hh:mm aa</span>
	</div>
	<div class="statusStageLineCls"></div>
</div>