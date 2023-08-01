<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<title>Vedagram : Track Deliveries</title>
<script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script>

<link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.css" rel="stylesheet" />
<script src="https://momentjs.com/downloads/moment.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyChv9TXatYolUD1DLrnzTuRni4xYvhsRNQ&libraries=places&v=weekly"></script>
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyChv9TXatYolUD1DLrnzTuRni4xYvhsRNQ&callback=initMap&libraries=places&v=weekly"></script> -->
<script src="<%=request.getContextPath()%>/js/googlemap.js"></script>

<style type="text/css">
.favouriteCls {
    cursor: pointer;
    color: #b7b2b2;
    font-size: 20px;
}
.favouriteCls.activeCls {
    color: #f57c35;
}
.favouriteCls:hover {
    color: #f57c35;
}
.favouriteNameNumCls {
	font-weight: bold;
	margin-bottom: 2px;
}
.formcls input {
    padding-right: 15px !important;
    margin-bottom: 8px;
}
.distanceRowCls {
    color: rgba(48,197,143,1);
    font-size: 10px;
    font-weight: normal;
    margin-left: 10px;
}
.mapDivCls {
	position: relative;
}
.markerIconCls {
	position: absolute;
    top: calc(50% - 40px);
    left: calc(50% - 12px);
    font-size: 40px;
    width: 24px;
    z-index: 1;
    color: #ff4444;
}
#pickDropFormModal .modal-header .close, #searchVedagramModal .modal-header .close {
    background: transparent;
    opacity: 1;
    font-size: 19px;
    position: absolute !important;
    right: 16px;
    top: 16px;
    width: 40px;
    height: 40px;
    color: white;
    z-index: 1;
    padding: 0;
}
#pickDropFormModal .modal-dialog, #searchVedagramModal .modal-dialog {
	height: calc(100% - 20px);
    margin: 10px auto !important;
}
#pickDropFormModal .modal-content, #searchVedagramModal .modal-content {
	height: 100%;
}
.schedulePackageCls {
	display: none;
}
.bookPackageCls, .schedulePackageCls {
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
.dashCls {
	margin-left: 7px;
    margin-right: 6px;
    line-height: 7px;
    margin-top: 9px;
    color: #d9d1d1;
}
.mainBodyDivVend {
	background-color: rgba(241,251,255,1);
}
.schedulePickupTitleCls {
	color: rgba(0,148,205,1);
    text-align: center;
    margin-top: 30px;
    margin-bottom: 30px;
}
.totalSummaryCls {
    position: absolute;
    width: 100%;
    left: 0;
    bottom: 5px;
}
.summaryHdrMainCls {
    white-space: nowrap;
    line-height: 18px;
    margin-top: -2.5px;
    text-align: left;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    color: rgba(67,94,119,1);
	margin-top: 5px;
    margin-bottom: 10px;
}
.summaryValMainCls {
    white-space: nowrap;
    line-height: 45px;
    margin-top: -12.5px;
    text-align: left;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    color: rgba(0,148,205,1);
    text-align: right;
}
.dropSummaryCls {
    color: rgba(48,197,143,1);
    font-weight: bold;
    margin-top: 10px;
    margin-bottom: 10px;
}
.paySummaryMainCls {
    white-space: nowrap;
    text-align: left;
    font-family: Poppins;
    font-style: normal;
    font-weight: normal;
    font-size: 16px;
    color: rgba(0,148,205,1);
}
.dropBoxDummyCls {
    display: none;
}
.summaryDivCls {
	display: none;
}
.homeDivCls {
	display: flex;
}
.delvChargeMainCls {
	position: absolute;
    top: -5px;
    right: 0px;
    color: rgba(48,197,143,1);
    font-size: 11px;
    background: #d2f3ed;
    border-radius: 4px;
    padding: 2px;
    line-height: 20px;
    text-align: center;
    width: 100px;
}
.delvInstructionCls {
	font-size: 11px;
    background: rgba(67,94,119,1);
    padding: 1px 8px;
    line-height: 18px;
    color: white;
    border-radius: 4px;
    margin-top: 11px;
    float: right;
    width: 100%;
    position: absolute;
    bottom: 0;
}
.dropBoxCls {
    background: rgba(240,251,254,1);
    padding-top: 20px;
    padding-bottom: 20px;
    margin-bottom: 10px;
    margin-top: 10px;
    box-shadow: 3px 3px 8px #c3c3c3;
    border-radius: 4px;
}
#Drop_Point {
    overflow: visible;
    white-space: nowrap;
    line-height: 18px;
    margin-top: -2.5px;
    text-align: left;
    font-style: normal;
    font-weight: bold;
    font-size: 13px;
    color: rgba(0,148,205,1);
}
#Sender_Details {
    overflow: visible;
    white-space: nowrap;
    text-align: left;
    font-style: normal;
    font-weight: bold;
    font-size: 18px;
    color: rgba(48,197,143,1);
}
#Receiver_Details {
	overflow: visible;
    white-space: nowrap;
    text-align: left;
    font-style: normal;
    font-weight: bold;
    font-size: 18px;
    color: rgba(48,197,143,1);
}
.scheduleDtMainCls {
    background: rgba(241,251,255,1);
    padding: 0px 10px;
    border-radius: 4px;
    line-height: 29px;
    margin-top: 10px;
    cursor: pointer;
}
.summaryBoxCls {
    box-shadow: 1px 0px 12px #ebe9e9;
    border-radius: 5px;
    padding-top: 10px;
    padding-bottom: 20px;
    margin-bottom: 20px;
}
.lblHdrCls {
    float: left;
    width: 100%;
    font-size: 9px;
    color: #c3bcbc;
}
.lblValCls {
	float: left;
    width: 100%;
    overflow: visible;
    white-space: nowrap;
    line-height: 18px;
    margin-top: -3px;
    text-align: left;
    font-style: normal;
    font-weight: normal;
    font-size: 12px;
    color: rgba(67,94,119,1);
    overflow: hidden;
    white-space: normal;
}
.editPickBtnCls {
	font-size: 9px;
    background: rgba(48,197,143,0.2);
    padding: 3px 6px;
    color: rgba(48,197,143,1);
    border-radius: 4px;
    cursor: pointer;
    line-height: 5px;
    height: 17px;
    margin-left: 10px;
    font-weight: normal;
    margin-top: 8px;
}
.editDropBtnCls {
	font-size: 9px;
    background: rgb(193 238 255);
    padding: 3px 6px;
    color: rgba(0,148,205,1);
    border-radius: 4px;
    cursor: pointer;
    line-height: 5px;
    margin-left: 10px;
    font-weight: normal;
}
.dropRowCls {
    float: left;
    width: 100%;
}
.frmAddressCls {
    float: left;
    width: 80%;
    margin: auto;
    text-align: left;
    margin-bottom: 16px;
    margin-top: 0px;
    padding: 5px 10px;
    background: rgba(0,148,205,0.2);
    border-radius: 4px;
    color: rgba(0,148,205,1);
    font-size: 11px;
}
.pac-container {
	z-index: 1050;
}
.dropTxtCls, .pickUpTxtCls {
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
.scheduleBookingCls {
	font-size: 12px;
    font-weight: normal;
    padding: 6px 15px;
    background: rgba(255,255,255,1);
    color: rgba(0,148,205,1);
    box-shadow: inset 0 0 2px #027aa9;
    border-radius: 3px;
    cursor: pointer;
    float: left;
    line-height: 20px;
    margin-left: 10px;
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
  height: 230px;
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
    font-size: 9px;
    color: #2c0404;
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
    width: 36px;
    text-align: center;
}
.favouriteRsultCls {
	padding-right: 38px;
}
.priorityCls {
	background: #5fe1cf;
    color: white;
}
.searchResultMainCls {
	display: block;
    font-size: 11px;
    float: left;
    width: 100%;
    margin-bottom: 20px;
}
.searchResultBodyCls {
    font-size: 13px;
    display: block !important;
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
.mapResultRowCls, .favouriteResultRowCls, .mapRecentResultRowCls {
    float: left;
    width: 100%;
    position: relative;
    cursor: pointer;
	margin-bottom: 10px;
}
.mapResultRowCls:hover, .mapRecentResultRowCls:hover, .favouriteResultRowCls:hover, .mapResultRowCls:hover .iconCls, .mapRecentResultRowCls:hover .iconCls, .favouriteResultRowCls:hover .iconCls {
    color: #3dab9b;
}
.searchResultHdrCls, .recentSearchHdrCls {
    margin-bottom: 10px;
}
.mapLocationNameCls {
	float: left;
    width: 100%;
    font-weight: bold;
}
.mapRsultCls, .favouriteRsultCls {
	min-height: 30px;
	margin-left: 20px;
	font-size: 11px;
}
.modal-body {
    height: 70vh;
    overflow-y: auto;
}

#scheduleModal .modal-body {
    height: auto;
    overflow-y: auto;
}

#Pick_up, #Drop {
    overflow: visible;
    width: 47px;
    white-space: nowrap;
    line-height: 19px;
    margin: 10px 0 5px 0;
    text-align: left;
    font-style: normal;
    font-weight: bold;
    font-size: 14px;
    color: rgb(175 175 175);
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
    text-align: left;
    font-family: Poppins;
    font-style: normal;
    font-weight: normal;
    color: rgba(0,148,205,1);
    border-radius: 10px;
}
.box1Cls {
	background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 3px 3px 8px #e9e9e9;
}
.layout_padding {
    padding: 35px 20px 100px 20px !important;
}
</style>
<script>
var srchFor = 1;//1:Pick 2: Drop
var dropIdx = 0;
var pickUpObj;
var dropObjArr = [];
var scheduleDt;
var scheduleTm;
var pageNum = 1;
$(document).ready(function() {
	
	$('#scheduleDt').datetimepicker({
	    format: 'YYYY-MM-DD hh:mm A',
	    formatTime: 'hh:mm A',
	    lang: 'en',
	    startDate: moment().toDate(),
	    minDate: moment().toDate(),
	    maxDate: moment().add(5, "days").toDate(),
	});

	$.datetimepicker.setDateFormatter({
	    parseDate: function(date, format) {
	      var d = moment(date, format);
	      return d.isValid() ? d.toDate() : false;
	    },
	    formatDate: function(date, format) {
	      return moment(date).format(format);
	    },
	});
	
	$('.pickUpTxtCls').click(function() {
		srchFor = 1;
		loadMapSrchContainer();
	});
	
	$('.scheduleBtnCls').click(function() {
		scheduleDt = $('#scheduleDt').val().split(' ')[0];
		scheduleTm = $('#scheduleDt').val().split(' ')[1] + ' ' + $('#scheduleDt').val().split(' ')[2];
		pickUpObj.scheduleDt = scheduleDt;
		pickUpObj.scheduleTm = scheduleTm;
		
		$('#scheduleModal').modal('hide');
		$('.bookPackageCls').hide();
		$('.schedulePackageCls').show();
		
		refereshPrice();
	});
	
	$(document.body).on('click', '.dropTxtCls', function() {
		srchFor = 2;
		dropIdx = $(this).closest('.dropRowCls').index();
		loadMapSrchContainer();
	});
	
	$('.addMoreCls').click(function() {
		var htmlVar = '';
		
		htmlVar += '<div class="dropRowCls">';
		htmlVar += '<div id="Drop">';
		htmlVar += '<span class="dropIdxPosCls">Drop at<span class="distanceRowCls">(0 km)</span></span>';
		htmlVar += '</div>';
		htmlVar += '<div style="float: left; width: 100%; position: relative;">';
		htmlVar += '<i class="fa fa-minus-circle removeDropCls"></i>';
		htmlVar += '<input type="text" class="dropTxtCls formInputCls" readonly="readonly" placeholder="Select Drop location">';
		htmlVar += '<div style="float: left; width: 100%; font-weight: normal; font-size: 11px; color: gray !important;">';
		htmlVar += '<div style="float: left; width: auto;">';
		htmlVar += '<i class="fa fa-phone" style="color: inherit;"></i> <span class="mainDropMobileCls">0000000000</span>';
		htmlVar += '</div>';
		htmlVar += '<div style="float: left; width: auto; margin-left: 15px;">';
		htmlVar += '<i class="fa fa-user" style="color: inherit;"></i> <span class="mainDropNameCls">xxxxxxx xxxxx</span>';
		htmlVar += '</div>';
		htmlVar += '<div style="float: right; width: auto; color: rgba(48,197,143,1);">';
		htmlVar += '<i class="fa fa-inr" style="color: inherit;"></i> <span class="delvAmountCls">0</span>';
		htmlVar += '</div>';
		htmlVar += '</div>';
		htmlVar += '</div>';
		htmlVar += '</div>';
		
		$('.dropMainCls').append(htmlVar);
	});
	
	$(document.body).on('click', '.mapResultRowCls, .mapRecentResultRowCls', function() {
		$('#searchVedagramModal').modal('hide');
		resetForm();
		
		var cookieName = '';
		if(srchFor == 1) {
			cookieName = 'pickHistory';
			$('.onlyDropCls').hide();
		} else if(srchFor == 2) {
			cookieName = 'dropHistory';
			$('.onlyDropCls').show();
		}
		
		if($(this).hasClass('mapResultRowCls')) {
			var cloneElem = new Object();
			cloneElem.lat = $(this).attr('lat');
			cloneElem.lng = $(this).attr('lng');
			cloneElem.address = $(this).attr('addr');
			cloneElem.formatAddress = $(this).attr('formatAddr');
			cloneElem.area = $(this).attr('area');
			cloneElem.city = $(this).attr('city');
			cloneElem.state = $(this).attr('state');
			cloneElem.country = $(this).attr('country');
			
			var availableFlag = false;
			var pickDropHistoryArr = getCookie(cookieName);
			if(pickDropHistoryArr == null || pickDropHistoryArr == '' || pickDropHistoryArr == undefined) {
				pickDropHistoryArr = [];
			} else {
				for (var i = 0; i < pickDropHistoryArr.length; i++) {
					var elem = pickDropHistoryArr[i];
					if(elem.address == cloneElem.address) {
						availableFlag = true;
					}
				}
			}
			if(availableFlag == false) {
				pickDropHistoryArr.push(cloneElem);
				setCookie(cookieName, JSON.stringify(pickDropHistoryArr), '');
			}
		}
		
		var address = $(this).attr('addr');
		var lat = $(this).attr('lat');
		var lng = $(this).attr('lng');
		var mobileNumber = '';
		var name = '';
		var houseNo = '';
		var area = $(this).attr('area');
		var city = $(this).attr('city');
		var state = $(this).attr('state');
		var country = $(this).attr('country');
		
		$('.frmAreaCls').val(area);
		$('.frmCityCls').val(city);
		$('.frmStateCls').val(state);
		$('.frmCountryCls').val(country);
		$('.frmNameCls').val(name);
		$('.frmPhoneCls').val(mobileNumber);
		$('.frmLandmarkCls').val(houseNo);
		$('.frmLatCls').val(lat);
		$('.frmLngCls').val(lng);
		$('.frmAddressCls').html(address);
		$('.frmAddressInputCls').val(address);
		$('.favouriteCls').removeClass('activeCls');
		
		$('.backBtnCls').show();
		$('#pickDropFormModal').modal({
			show: true,
		});
	});
	
	$(document.body).on('click', '.editDropBtnCls, .editPickBtnCls', function() {
		$('#searchVedagramModal').modal('hide');
		resetForm();
		
		if($(this).hasClass('editPickBtnCls')) {
			srchFor = 1;
		} else {
			srchFor = 2;
		}
		
		if(srchFor == 1) {
			$('.onlyDropCls').hide();
			
			var address = pickUpObj.packagePickupAddress;
			var lat = pickUpObj.latitude;
			var lng = pickUpObj.longitude;
			var mobileNumber = pickUpObj.contactPhone;
			var name = pickUpObj.name;
			var houseNo = pickUpObj.pickUpHouseNo;
			var area = pickUpObj.area;
			var city = pickUpObj.city;
			var state = pickUpObj.state;
			var country = pickUpObj.country;
			var favFlag = pickUpObj.favFlag;
			
			$('.frmAreaCls').val(area);
			$('.frmCityCls').val(city);
			$('.frmStateCls').val(state);
			$('.frmCountryCls').val(country);
			$('.frmNameCls').val(name);
			$('.frmPhoneCls').val(mobileNumber);
			$('.frmLandmarkCls').val(houseNo);
			$('.frmLatCls').val(lat);
			$('.frmLngCls').val(lng);
			$('.frmAddressCls').html(address);
			$('.frmAddressInputCls').val(address);
			
			if(favFlag == true) {
				$('.favouriteCls').addClass('activeCls');
			} else {
				$('.favouriteCls').removeClass('activeCls');
			}
		} else if(srchFor == 2) {
			$('.onlyDropCls').show();
			
			var dropObjIdx = $(this).attr('dropIdx');
			var dropObj = dropObjArr[parseInt(dropObjIdx)];
			
			var address = dropObj.recieverAddress;
			var lat = dropObj.toLat;
			var lng = dropObj.toLong;
			var mobileNumber = dropObj.recieverContact;
			var name = dropObj.recieverName;
			var houseNo = dropObj.recieverHouseNo;
			var area = dropObj.area;
			var city = dropObj.city;
			var state = dropObj.state;
			var country = dropObj.country;
			var area = dropObj.area;
			var city = dropObj.city;
			var state = dropObj.state;
			var country = dropObj.country;
			var paidAt = dropObj.paidAt;
			var delvInstruction = dropObj.instruction;
			var weight = dropObj.weight;
			var favFlag = dropObj.favFlag;
			var taskPrice = dropObj.taskPrice;
			
			$('.frmAreaCls').val(area);
			$('.frmCityCls').val(city);
			$('.frmStateCls').val(state);
			$('.frmCountryCls').val(country);
			$('.frmNameCls').val(name);
			$('.frmPhoneCls').val(mobileNumber);
			$('.frmLandmarkCls').val(houseNo);
			$('.frmLatCls').val(lat);
			$('.frmLngCls').val(lng);
			$('.frmAddressCls').html(address);
			$('.frmAddressInputCls').val(address);
			$('.frmPaymentTypeCls').val(paidAt)
			$('.frmInstructionCls').val(delvInstruction);
			$('.frmWeightCls').val(weight);
			$('.frmTaskPriceCls').val(taskPrice);
			
			if(favFlag == true) {
				$('.favouriteCls').addClass('activeCls');
			} else {
				$('.favouriteCls').removeClass('activeCls');
			}
		}
		
		if(pageNum == 1) {
			$('.backBtnCls').show();
		} else {
			$('.backBtnCls').hide();
		}
		$('#pickDropFormModal').modal({
			show: true,
		});
	});
	
	$('.favouriteCls').click(function() {
		if($(this).hasClass('activeCls')) {
			$(this).removeClass('activeCls')
		} else {
			$(this).addClass('activeCls')
		}
	});
	
	$(document.body).on('click', '.favouriteResultRowCls', function() {
		$('#searchVedagramModal').modal('hide');
		resetForm();
		
		if(srchFor == 1) {
			$('.onlyDropCls').hide();
		} else if(srchFor == 2) {
			$('.onlyDropCls').show();
		}
		
		var address = $(this).find('.favAddressHdnCls').val();
		var lat = $(this).find('.favLatHdnCls').val();
		var lng = $(this).find('.favLngHdnCls').val();
		var mobileNumber = $(this).find('.favMobileHdnCls').val();
		var name = $(this).find('.favNameHdnCls').val();
		var houseNo = $(this).find('.favHouseNoHdnCls').val();
		var area = $(this).find('.favAreaHdnCls').val();
		var city = $(this).find('.favCityHdnCls').val();
		var state = $(this).find('.favStateHdnCls').val();
		var country = $(this).find('.favCountryHdnCls').val();
		
		$('.frmAreaCls').val(area);
		$('.frmCityCls').val(city);
		$('.frmStateCls').val(state);
		$('.frmCountryCls').val(country);
		$('.frmNameCls').val(name);
		$('.frmPhoneCls').val(mobileNumber);
		$('.frmLandmarkCls').val(houseNo);
		$('.frmLatCls').val(lat);
		$('.frmLngCls').val(lng);
		$('.frmAddressCls').html(address);
		$('.frmAddressInputCls').val(address);
		$('.favouriteCls').removeClass('activeCls');
		
		$('.backBtnCls').show();
		$('#pickDropFormModal').modal({
			show: true,
		});
	});
	
	function resetForm() {
		$('.frmAreaCls').val('');
		$('.frmCityCls').val('');
		$('.frmStateCls').val('');
		$('.frmCountryCls').val('');
		$('.frmNameCls').val('');
		$('.frmPhoneCls').val('');
		$('.frmLandmarkCls').val('');
		$('.frmLatCls').val('');
		$('.frmLngCls').val('');
		$('.frmAddressCls').html('');
		$('.frmAddressInputCls').val('');
		$('.frmInstructionCls').val('');
		$('.frmWeightCls').val('1');
		$('.frmTaskPriceCls').val('');
	}
	
// 	$(document.body).on('change', '#srchMapLoc', function() {
// 		if($(this).val() != '') {
// 			$('.searchResultMainCls').show();
// 		} else {
// 			$('.searchResultMainCls').hide();
// 			$('.searchResultBodyCls').html('');
// 		}
// 	});

	$('.backBtnCls').click(function() {
		$('#pickDropFormModal').modal('hide');
		$('#searchVedagramModal').modal({
			show: true,
		});
	});
	
	$('.backToHomeBtnCls').click(function() {
		$('.summaryDivCls').hide();
		$('.homeDivCls').css('display', 'flex');
		pageNum = 1;
	});
	
	$('.scheduleBookingCls').click(function() {
		$('#scheduleModal').modal({
			show: true,
		});
	});
	
	$('.confirmBookingCls').click(function() {
		scheduleDt = '';
		scheduleTm = '';
		pickUpObj.scheduleDt = scheduleDt;
		pickUpObj.scheduleTm = scheduleTm;
		
		$('.bookPackageCls').show();
		$('.schedulePackageCls').hide();
		
		refereshPrice();
		confirmBook();
	});
	
	$('.removeDropCls').click(function() {
		confirm("Do you want to remove this drop?");
		if (confirm(text) == true) {
			var rmvDropIdx = $(this).closest('.dropRowCls').index();
			if(dropObjArr[rmvDropIdx] != null && dropObjArr[rmvDropIdx] != undefined) {
				var dropObjArrTemp = [];
				var tempIdx = 0;
				for (var i = 0; i < dropObjArr.length; i++) {
					var dropObj = dropObjArr[i];
					if(rmvDropIdx != i) {
						dropObjArrTemp[tempIdx] = dropObj;
						tempIdx++;
					}
				}
				dropObjArr = dropObjArrTemp;
			}
			$(this).closest('.dropRowCls').remove();
		}
	});
	
	$('.bookPackageCls, .schedulePackageCls').click(function() {
		var senderDetailsList = [];
		for (var i = 0; i < dropObjArr.length; i++) {
			var dropObj = dropObjArr[i];
			
			var senderDetails = new Object();
			senderDetails.distance = dropObj.distance;
			senderDetails.weight = dropObj.weight;
			senderDetails.parcelType = "Others";
			senderDetails.latitude = pickUpObj.latitude;
			senderDetails.longitude = pickUpObj.longitude;
			senderDetails.packagePickupAddress = pickUpObj.packagePickupAddress;
			senderDetails.name = pickUpObj.name;
			senderDetails.pickUpHouseNo = pickUpObj.pickUpHouseNo;
			senderDetails.recieverAddress = dropObj.recieverAddress;
			senderDetails.recieverHouseNo = dropObj.recieverHouseNo;
			senderDetails.recieverName = dropObj.recieverName;
			senderDetails.contactPhone = pickUpObj.contactPhone;
			senderDetails.recieverContact = dropObj.recieverContact;
// 			senderDetails.deliveryDate = "";
			senderDetails.packageAvailableTime = scheduleTm;
			senderDetails.packagePickupTime = scheduleDt;
			senderDetails.sendFrom = pickUpObj.sendFrom;
			senderDetails.recieverLocation = dropObj.recieverLocation;
			senderDetails.senderLocation = pickUpObj.senderLocation;
			senderDetails.codFlag = true;
			senderDetails.itemPayFlag = false;
			senderDetails.deliveryChargeInclu = false;
			senderDetails.routeDir = "NorthWest";
			senderDetails.sendTo = dropObj.sendTo;
			senderDetails.toLat = dropObj.toLat;
			senderDetails.toLong = dropObj.toLong;
			senderDetails.senderName = pickUpObj.name;
			senderDetails.senderPhone = $('#senderPhoneHdn').val();
			senderDetails.senderName = $('#senderNameHdn').val();
			senderDetails.vendorGroupName = $('#vendorGroupNameHdn').val();
			senderDetails.vendorName = $('#vendorNameHdn').val();
			
			senderDetails.taskPrice = dropObj.taskPrice;
			senderDetails.paidPoint = dropObj.paidAt;
			senderDetails.fromFavFlag =  false;
			senderDetails.toFavFlag =  false;
			senderDetails.paymentId =  "";
			senderDetails.orderId =  "";
			senderDetails.signature =  "";
			senderDetails.resOrderId =  "";
			senderDetails.couponCode = "";
			
			if(pickUpObj.favFlag == true)
				senderDetails.fromFavFlag = true;
			if(dropObj.favFlag == true)
				senderDetails.toFavFlag = true;
			
			if($(this).hasClass('schedulePackageCls')) {
				senderDetails.scheduleDt = scheduleDt;
				senderDetails.scheduleTm = scheduleTm;
			} else {
				senderDetails.scheduleDt = '';
				senderDetails.scheduleTm = '';
			}
			
			senderDetailsList.push(senderDetails);
		}
		
		var bookUrl = '';
		if($(this).hasClass('schedulePackageCls')) {
			bookUrl = '/c/sch';
		} else {
			bookUrl = '/c/ab';
		}
		
		var multiSenderDetails = new Object();
		multiSenderDetails.senderDetailsList = senderDetailsList;
		
		$.ajax({
			url : $("#contextPath").val()+bookUrl,
			contentType : "application/json",
			type : 'POST',
			data : JSON.stringify(multiSenderDetails),
			success:function(data){
				console.log(data);
				window.location.reload();
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
		        alert("Status: " + textStatus);
		    }
		});
	});
	
	function confirmBook() {
		$('#searchVedagramModal').modal('hide');
		
		$('.senderNmCls').html(pickUpObj.name);
		$('.senderMobileCls').html(pickUpObj.contactPhone);
		$('.senderAddrCls').html(pickUpObj.packagePickupAddress);
		$('.scheduleDtCls').html(scheduleDt);
		$('.editPickBtnCls').attr('lat', pickUpObj.latitude);
		$('.editPickBtnCls').attr('lng', pickUpObj.longitude);
		
		if(scheduleDt == '') {
			$('.scheduleDtMainCls').hide();
		} else {
			$('.scheduleDtMainCls').show();
		}
		
		var totDistance = 0;
		var payCodCount = 0;
		var payCodAmount = 0;
		var payOnlineCount = 0;
		var payOnlineAmount = 0;
		var offerApplied = 0;
		var totAmount = 0;
		var taskPriceCount = 0;
		var taskPriceAmount = 0;
		
		$('.dropBoxMainCls').html('');
		for (var i = 0; i < dropObjArr.length; i++) {
			var dropObj = dropObjArr[i];
			
			totDistance += parseFloat(dropObj.distance);
			totAmount += parseInt(dropObj.delvAmount);
			
			if(dropObj.paidAt == 1 || dropObj.paidAt == 2) {
				payCodCount++;
				payCodAmount += parseInt(dropObj.delvAmount);
			} else if(dropObj.paidAt == 3) {
				payOnlineCount++;
				payOnlineAmount += parseInt(dropObj.delvAmount);
			}
			
			if(dropObj.taskPrice != '' && dropObj.taskPrice != '0' && parseInt(dropObj.taskPrice) > 0) {
				taskPriceCount++;
				taskPriceAmount += parseInt(dropObj.taskPrice);
				
				totAmount += parseInt(dropObj.taskPrice);
			}
			
			var dropBoxVar =  $('.dropBoxDummyCls').clone();
			$(dropBoxVar).find('.receiverNmCls').html(dropObj.recieverName);
			$(dropBoxVar).find('.receiverMobileCls').html(dropObj.recieverContact);
			$(dropBoxVar).find('.receiverAddrCls').html(dropObj.recieverAddress);
			$(dropBoxVar).find('.inclDelvChrgCls').html('');
			$(dropBoxVar).find('.inclDelvChrgDivCls').hide();
			$(dropBoxVar).find('.dropPointLblCls').html('Drop Point ' + (i+1));
			$(dropBoxVar).find('.editDropBtnCls').attr('dropIdx', i);
			$(dropBoxVar).find('.editDropBtnCls').attr('lat', dropObj.toLat);
			$(dropBoxVar).find('.editDropBtnCls').attr('lng', dropObj.toLong);
			
			var paymentType = '';
			if(dropObj.paidAt == 1) {
				paymentType = 'Cash at Pickup';
			} else if(dropObj.paidAt == 2) {
				paymentType = 'Cash at Drop';
			} else if(dropObj.paidAt == 3) {
				paymentType = 'Online Payment';
			}
			$(dropBoxVar).find('.payTypeCls').html(paymentType);
			$(dropBoxVar).find('.itemAmntCls').html('');
			$(dropBoxVar).find('.itemAmntDivCls').hide();
			$(dropBoxVar).find('.instructionCls').html(dropObj.instruction);
			
			if(dropObj.taskPrice == '' || dropObj.taskPrice == '0' || dropObj.taskPrice == 0) {
				$(dropBoxVar).find('.taskPriceCls').html('');
				$(dropBoxVar).find('.taskPriceDivCls').hide();
			} else {
				$(dropBoxVar).find('.taskPriceCls').html(dropObj.taskPrice);
				$(dropBoxVar).find('.taskPriceDivCls').show();
			}
			
			if(dropObj.instruction == '') {
				$(dropBoxVar).find('.delvInstructionCls').hide();
			} else {
				$(dropBoxVar).find('.delvInstructionCls').show();
			}
			
			$(dropBoxVar).find('.dropDelvAmount').html(dropObj.delvAmount);
			$(dropBoxVar).addClass('dropBoxCls').removeClass('dropBoxDummyCls');
			$(dropBoxVar).show();
			
			$('.dropBoxMainCls').append($(dropBoxVar));
		}
		
		$('.totDistCls').html(totDistance.toFixed(2) + ' Km');
		$('.payCodCountCls').html('x'+payCodCount);
		$('.payCodAmountCls').html(payCodAmount);
		
		$('.taskPriceCountCls').html('x'+taskPriceCount);
		$('.taskPriceAmountCls').html(taskPriceAmount);
		
		if(payCodCount == 0) {
			$('.payCodMainCls').hide();
		} else {
			$('.payCodMainCls').show();
		}
		
		if(taskPriceCount == 0) {
			$('.taskPriceSummaryCmnDivCls').hide();
		} else {
			$('.taskPriceSummaryCmnDivCls').show();
		}
		
		$('.payOnlineCountCls').html('x'+payOnlineCount);
		$('.payOnlineAmountCls').html(payOnlineAmount);
		if(payOnlineCount == 0) {
			$('.payOnlineMainCls').hide();
		} else {
			$('.payOnlineMainCls').show();
		}
		
		$('.offerAppliedAmountCls').html(offerApplied);
		if(offerApplied == 0) {
			$('.offerAppliedMainCls').hide();
		} else {
			$('.offerAppliedMainCls').hide();
		}
		
		$('.totAmountCls').html(totAmount);
		
		$('.homeDivCls').hide();
		$('.summaryDivCls').css('display', 'flex');
		pageNum = 2;
	}
	
	$('.favouriteSrchTxtCls').keyup(function() {
		var txt = $(this).val().toLowerCase();
		$('.favouriteResultRowCls').each(function() {
			if($(this).find('.favouriteRsultCls').attr('name').toLowerCase().indexOf(txt) != -1
					|| $(this).find('.favouriteRsultCls').attr('mobileNumber').toLowerCase().indexOf(txt) != -1
					|| $(this).find('.favouriteRsultCls').attr('address').toLowerCase().indexOf(txt) != -1) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	});
	
	$('.cnfrmLocBtnCls').click(function() {
		var name = $('.frmNameCls').val();
		var mobileNumber = $('.frmPhoneCls').val();
		var houseNo = $('.frmLandmarkCls').val();
		var lat = $('.frmLatCls').val();
		var lng = $('.frmLngCls').val();
		var address = $('.frmAddressInputCls').val();
		var instruction = $('.frmInstructionCls').val();
		var taskPrice = $('.frmTaskPriceCls').val();
		var paidAt = $('.frmPaymentTypeCls').val();
		var weight = $('.frmWeightCls').val();
		var area = $('.frmAreaCls').val();
		var city = $('.frmCityCls').val();
		var state = $('.frmStateCls').val();
		var country = $('.frmCountryCls').val();
		var favFlag = false;
		if($('.favouriteCls').hasClass('activeCls'))
			favFlag = true;
		
		if(srchFor == 1) {
			pickUpObj = new Object();
			pickUpObj.packagePickupAddress = address;
			pickUpObj.pickUpHouseNo = houseNo;
			pickUpObj.name = name;
			pickUpObj.latitude = lat;
			pickUpObj.longitude = lng;
			pickUpObj.senderLocation = area;
			pickUpObj.sendFrom = city;
			pickUpObj.contactPhone = mobileNumber;
			pickUpObj.area = area;
			pickUpObj.city = city;
			pickUpObj.state = state;
			pickUpObj.country = country;
			pickUpObj.favFlag = favFlag;
			
			$('.pickUpTxtCls').val(address);
			$('.mainPickMobileCls').html(mobileNumber);
			$('.mainPickNameCls').html(name);
		} else if(srchFor == 2) {
			dropObj = new Object();
			dropObj.recieverAddress = address;
			dropObj.recieverHouseNo = houseNo;
			dropObj.recieverName = name;
			dropObj.toLat = lat;
			dropObj.toLong = lng;
			dropObj.recieverContact = mobileNumber;
			dropObj.instruction = instruction;
			dropObj.taskPrice = taskPrice;
			dropObj.paidAt = paidAt;
			dropObj.weight = weight;
			dropObj.sendTo = city;
			dropObj.recieverLocation = area;
			dropObj.area = area;
			dropObj.city = city;
			dropObj.state = state;
			dropObj.country = country;
			dropObj.favFlag = favFlag;
			
			$('.dropMainCls .dropRowCls:nth-child('+(dropIdx+1)+')').find('.dropTxtCls').val(address);
			$('.dropMainCls .dropRowCls:nth-child('+(dropIdx+1)+')').find('.mainDropMobileCls').html(mobileNumber);
			$('.dropMainCls .dropRowCls:nth-child('+(dropIdx+1)+')').find('.mainDropNameCls').html(name);
			
			dropObjArr[dropIdx] = dropObj;
		}
		
		if(pickUpObj != null && dropObjArr.length > 0) {
			var dashboardRequests = [];
			for (var i = 0; i < dropObjArr.length; i++) {
				var dropObj = dropObjArr[i];
				
				var pickDropObj = new Object();
				pickDropObj.sendFrom = pickUpObj.sendFrom;
				pickDropObj.weight = dropObj.weight;
				pickDropObj.fromLat = pickUpObj.latitude;
				pickDropObj.fromLong = pickUpObj.longitude;
				pickDropObj.latitude = dropObj.toLat;
				pickDropObj.longitude = dropObj.toLong;
				
				dashboardRequests.push(pickDropObj);
			}
			
			var dashboardMultiRequest = new Object();
			dashboardMultiRequest.dashboardRequests = dashboardRequests;
			
			$.ajax({
				url : $("#contextPath").val()+'/b/r',
				contentType : "application/json",
				type : 'POST',
				data : JSON.stringify(dashboardMultiRequest),
				success:function(data){
					for (var i = 0; i < data.rateCardList.length; i++) {
						var elem = data.rateCardList[i];
						var rateCard = elem;
						
						$('.dropMainCls .dropRowCls:nth-child('+(i+1)+')').find('.distanceRowCls').html("("+rateCard.distance+" km)");
						$('.dropMainCls .dropRowCls:nth-child('+(i+1)+')').find('.delvAmountCls').html(rateCard.rate);
						
						dropObjArr[i].delvAmount = rateCard.rate;
						dropObjArr[i].distance = rateCard.distance;
						dropObjArr[i].delvAlertText = rateCard.delvAlertText;
					}
					
					if(pageNum == 2) {
	// 					pickUpObj.scheduleDt = scheduleDt;
	// 					pickUpObj.scheduleTm = scheduleTm;
						$('.bookPackageCls').show();
						$('.schedulePackageCls').hide();
						confirmBook();
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) { 
			        alert("Status: " + textStatus);
			    }
			});
		}
		
		$('#pickDropFormModal').modal('hide');
	});
	
	function refereshPrice() {
		if(pickUpObj != null && dropObjArr.length > 0) {
			var dashboardRequests = [];
			for (var i = 0; i < dropObjArr.length; i++) {
				var dropObj = dropObjArr[i];
				
				var pickDropObj = new Object();
				pickDropObj.sendFrom = pickUpObj.sendFrom;
				pickDropObj.weight = dropObj.weight;
				pickDropObj.fromLat = pickUpObj.latitude;
				pickDropObj.fromLong = pickUpObj.longitude;
				pickDropObj.latitude = dropObj.toLat;
				pickDropObj.longitude = dropObj.toLong;
				
				dashboardRequests.push(pickDropObj);
			}
			
			var dashboardMultiRequest = new Object();
			dashboardMultiRequest.dashboardRequests = dashboardRequests;
			dashboardMultiRequest.scheduleDt = pickUpObj.scheduleDt;
			dashboardMultiRequest.scheduleTm = pickUpObj.scheduleTm;
			dashboardMultiRequest.scheduleFlag = true;
			
			$.ajax({
				url : $("#contextPath").val()+'/b/r',
				contentType : "application/json",
				type : 'POST',
				data : JSON.stringify(dashboardMultiRequest),
				success:function(data){
					for (var i = 0; i < data.rateCardList.length; i++) {
						var elem = data.rateCardList[i];
						var rateCard = elem;
						
						$('.dropMainCls .dropRowCls:nth-child('+(i+1)+')').find('.distanceRowCls').html("("+rateCard.distance+" km)");
						$('.dropMainCls .dropRowCls:nth-child('+(i+1)+')').find('.delvAmountCls').html(rateCard.rate);
						
						dropObjArr[i].delvAmount = rateCard.rate;
						dropObjArr[i].distance = rateCard.distance;
						dropObjArr[i].delvAlertText = rateCard.delvAlertText;
					}
					confirmBook();
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) { 
			        alert("Status: " + textStatus);
			    }
			});
		}
	}
	
	function loadMapSrchContainer() {
		$('#srchMapLoc').val('').trigger('change');
		
		var cookieName = '';
		if(srchFor == 1) {
			cookieName = 'pickHistory';
			$('#myModalLabel').html('Search Pickup Location');
		} else if(srchFor == 2) {
			cookieName = 'dropHistory';
			$('#myModalLabel').html('Search Drop Location');
		}
		
		$('.recentSearchBodyCls').html('');
		var pickDropHistoryArr = getCookie(cookieName);
		if(pickDropHistoryArr != null && pickDropHistoryArr != undefined && pickDropHistoryArr.length > 0) {
			for (var i = 0; i < pickDropHistoryArr.length; i++) {
				var elem = pickDropHistoryArr[i];
				
				var htmlVar = '<div class="mapRecentResultRowCls"  lat="'+elem.lat+'" lng="'+elem.lng+'" addr="'+elem.formatAddress+'" formatAddr="'+elem.formatAddress+'" area="'+elem.area+'" city="'+elem.city+'" state="'+elem.state+'" country="'+elem.country+'">';
				htmlVar += '<i class="fa fa-search srchIconCls iconCls"></i>';
				htmlVar += '<div class="mapRsultCls">';
				htmlVar += '<div class="mapLocationCls">'+elem.address+'</div>';
				htmlVar += '</div>';
				htmlVar += '</div>';
				
				$('.recentSearchBodyCls').append(htmlVar);
			}
		} else {
			$('.recentSearchBodyCls').html('<span>No recent search</span>');
		}
		
		$('.searchResultBodyCls').html('');
		$('#searchVedagramModal').modal({
			show: true,
		});
		
		loadFavourites();
	}
	
	function loadFavourites() {
		var primeFavType = 1;
		if(srchFor == 1) {
			primeFavType = 1;
		} else if(srchFor == 2) {
			primeFavType = 2;
		}
		
		$('.favouriteBodyCls').html('');
		$.ajax({
			type: 'GET',
			url: $('#contextPath').val() + '/c/c',
			dataType: 'json',
			data: {
				'favType': 3,
				'primeFavType': primeFavType
			},
			success: function (data) {
				for (var i = 0; i < data.length; i++) {
					var elem = data[i];
					
					var priorityClsVar = '';
					if(srchFor == elem.favType) {
						priorityClsVar = ' priorityCls';
					}
					
					var address = '';
					var lat = '';
					var lng = '';
					var mobileNumber = '';
					var name = '';
					var houseNo = '';
					var area = '';
					var city = '';
					var state = '';
					var country = '';
					
					var labelVar = '';
					if(elem.favType == 1) {
						address = elem.packagePickupAddress;
						lat = elem.latitude;
						lng = elem.longitude;
						mobileNumber = elem.contactPhone;
						name = elem.name;
						houseNo = elem.pickUpHouseNo;
						area = elem.senderLocation;
						city = elem.sendFrom;
						state = '';
						country = '';

						labelVar = '<span class="favVedagramCls'+priorityClsVar+'">Pick</span>';
					} else {
						address = elem.recieverAddress;
						lat = elem.toLat;
						lng = elem.toLong;
						mobileNumber = elem.recieverContact;
						name = elem.recieverName;
						houseNo = elem.recieverAddress;
						area = elem.receiverLocation;
						city = elem.sendTo;
						state = '';
						country = '';
						
						labelVar = '<span class="favVedagramCls'+priorityClsVar+'">Drop</span>';
					}
					
					var htmlVar = '<div class="favouriteResultRowCls" lat="'+lat+'" lng="'+lng+'" addr="'+address+'" formatAddr="'+address+'" area="'+area+'" city="'+city+'" state="'+state+'" country="'+country+'">';
					
					htmlVar += '<input type="hidden" class="favNameHdnCls" value="'+name+'">';
					htmlVar += '<input type="hidden" class="favMobileHdnCls" value="'+mobileNumber+'">';
					htmlVar += '<input type="hidden" class="favAddressHdnCls" value="'+address+'">';
					htmlVar += '<input type="hidden" class="favLatHdnCls" value="'+lat+'">';
					htmlVar += '<input type="hidden" class="favLngHdnCls" value="'+lng+'">';
					htmlVar += '<input type="hidden" class="favHouseNoHdnCls" value="'+houseNo+'">';
					htmlVar += '<input type="hidden" class="favAreaHdnCls" value="'+area+'">';
					htmlVar += '<input type="hidden" class="favCityHdnCls" value="'+city+'">';
					htmlVar += '<input type="hidden" class="favStateHdnCls" value="'+state+'">';
					htmlVar += '<input type="hidden" class="favCountryHdnCls" value="'+country+'">';
					
					htmlVar += '<i class="fa fa-bookmark srchIconCls iconCls"></i>';
					htmlVar += '<div class="favouriteRsultCls" name="'+name+'" mobileNumber="'+mobileNumber+'" address="'+address+'">';
					htmlVar += '<div class="favouriteNameNumCls"><span class="favouriteNameCls">'+name+'</span><span class="favouriteNumCls">, '+mobileNumber+'</span></div>';
					htmlVar += '<div class="favouriteLocationCls">'+address+'</div>';
					htmlVar += '</div>';
					htmlVar += labelVar;
					htmlVar += '</div>';
					
					$('.favouriteBodyCls').append(htmlVar);
				}
				console.log(data);
			}
		});
	}
});

function setCookie(cname, cvalue, exdays) {
	var expires = '';
	if(exdays != '' && exdays != undefined) {
	    var d = new Date();
	    d.setTime(d.getTime() + (exdays*24*60*60*1000));
	    expires = "expires="+d.toUTCString();
	}
    document.cookie = cname + "=" + cvalue + "; " + expires + "; path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return $.parseJSON(c.substring(name.length,c.length));
    }
    return "";
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
			<section class="layout_padding">
				<div class="container">
					<h5 class="font-weight-bold" style="margin-bottom: 20px;">
						<span>Send Package</span>
						<input type="hidden" id="senderPhoneHdn" value="${senderPhone}">
						<input type="hidden" id="senderNameHdn" value="${senderName}">
						<input type="hidden" id="vendorGroupNameHdn" value="${vendorGroupName}">
						<input type="hidden" id="vendorNameHdn" value="${vendorName}">
					</h5>
					<div class="row formcls homeDivCls">
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
															<i class="fa fa-phone" style="color: inherit;"></i> <span class="mainPickMobileCls">0000000000</span>
														</div>
														<div style="float: left; width: auto; margin-left: 15px;">
															<i class="fa fa-user" style="color: inherit;"></i> <span class="mainPickNameCls">xxxxxxx xxxxx</span>
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
														<span class="dropIdxPosCls">Drop at<span class="distanceRowCls">(0 km)</span></span>
													</div>
													<div style="float: left; width: 100%; position: relative;">
														<i class="fa fa-minus-circle removeDropCls"></i>
														<input type="text" class="dropTxtCls formInputCls" readonly="readonly" placeholder="Select Drop location">
														<div style="float: left; width: 100%; font-weight: normal; font-size: 11px; color: gray !important;">
															<div style="float: left; width: auto;">
																<i class="fa fa-phone" style="color: inherit;"></i> <span class="mainDropMobileCls">0000000000</span>
															</div>
															<div style="float: left; width: auto; margin-left: 15px;">
																<i class="fa fa-user" style="color: inherit;"></i> <span class="mainDropNameCls">xxxxxxx xxxxx</span>
															</div>
															<div style="float: right; width: auto; color: rgba(48,197,143,1);">
																<i class="fa fa-inr" style="color: inherit;"></i> <span class="delvAmountCls">0</span>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="addMoreMainCls">
												<span class="addMoreCls"><i class="fa fa-plus" style="color: inherit;"></i> Add Drop location</span>
											</div>
											
											<div class="confirmBookingMainCls">
												<span class="confirmBookingCls">
													<i class="fa fa-check"></i> Book Now</span>
												<span class="scheduleBookingCls">
													<i class="fa fa-clock-o"></i> Schedule</span>
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
					
					
					<div class="row formcls summaryDivCls">
						<div class="col-md-8 mr-auto" style="">
							<div class="reqwisecls box1Cls" id="sendPackage">
								<div class="col-md-12 mr-auto">
									<div class="row">
										<div class="col-md-12 mr-auto" style="margin-bottom: 10px;">
											<h6><i class="fa fa-arrow-left backToHomeBtnCls" style="color: inherit;margin-right: 10px;cursor: pointer;"></i>Booking Summary</h6>
										</div>
										
										<div class="col-md-12 mr-auto">
											<div class="col-md-12 mr-auto summaryBoxCls">
												
												<div class="col-md-12 mr-auto">
													<div id="Sender_Details" class="row">
														<span>Sender Details</span>
														<span class="editPickBtnCls" lat="" lng=""><i class="fa fa-edit" style="color: inherit;margin-right: 5px;"></i>Edit</span>
													</div>
												</div>
												
												<div class="col-md-12 mr-auto">
													<div class="row">
														<div class="col-md-3 mr-auto">
															<div class="row">
																<span class="lblHdrCls">Sender Name</span>
																<span class="lblValCls senderNmCls">Test</span>
															</div>
														</div>
														<div class="col-md-3 mr-auto">
															<div class="row">
																<span class="lblHdrCls">Sender Contact</span>
																<span class="lblValCls senderMobileCls">Test</span>
															</div>
														</div>
														<div class="col-md-3 mr-auto">
															<div class="row">
																<span class="lblHdrCls">Sender Address</span>
																<span class="lblValCls senderAddrCls">Test</span>
															</div>
														</div>
														<div class="col-md-3 mr-auto">
															<div class="row">
																<span class="scheduleDtMainCls">
																	<i class="fa fa-calendar" style="color: inherit;"></i>
																	<span class="scheduleDtCls">Test</span>
																</span>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										
										<div class="col-md-12 mr-auto">
											<div class="col-md-12 mr-auto summaryBoxCls">
												<span id="Receiver_Details">
													<span>Receiver Details</span>
												</span>
												
												<div class="col-md-12 mr-auto">
													<div class="row dropBoxMainCls"></div>
												</div>
											</div>
										</div>
										
										
										
										
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-4 mr-auto" style="">
							<div class="box1Cls card sticky-top" style="padding-bottom: 150px;">
								<div class="col-md-12 mr-auto paySummaryMainCls">
									<div class="row">
										<span>Payment Summary</span>
									</div>
								</div>
								<div class="col-md-12 mr-auto">
									<div class="row">
										<div class="col-md-12 mr-auto dropSummaryCls">
											<div class="row">
												<span>Drop Summary</span>
											</div>
										</div>
										<div class="col-md-12 mr-auto distanceSummaryCls">
											<div class="row">
												<div class="col-md-6 mr-auto summaryHdrMainCls">
													<div class="row">
														<span class="summaryHdrCLs">Total Distance Covered</span>
													</div>
												</div>
												<div class="col-md-6 mr-auto summaryValMainCls">
													<div class="row float-right">
														<span class="summaryValCLs totDistCls">0 Km</span>
													</div>
												</div>
											</div>
											<div class="row payCodMainCls">
												<div class="col-md-6 mr-auto summaryHdrMainCls">
													<div class="row">
														<span class="summaryHdrCLs">Cash on Delivery</span>
														<span class="dashCls">---</span>
														<span class="payCodCountCls">x2</span>
													</div>
												</div>
												<div class="col-md-6 mr-auto summaryValMainCls">
													<div class="row float-right">
														<span class="summaryValCLs">
															<i class="fa fa-inr" style="color: inherit;"></i>
															<span class="payCodAmountCls">00.00</span>
														</span>
													</div>
												</div>
											</div>
											
											<div class="row taskPriceSummaryCmnDivCls">
												<div class="col-md-6 mr-auto summaryHdrMainCls">
													<div class="row">
														<span class="summaryHdrCLs">Total Task Price</span>
														<span class="dashCls">---</span>
														<span class="taskPriceCountCls">x2</span>
													</div>
												</div>
												<div class="col-md-6 mr-auto summaryValMainCls">
													<div class="row float-right">
														<span class="summaryValCLs">
															<i class="fa fa-inr" style="color: inherit;"></i>
															<span class="taskPriceAmountCls">00.00</span>
														</span>
													</div>
												</div>
											</div>
											
											<div class="row payOnlineMainCls">
												<div class="col-md-6 mr-auto summaryHdrMainCls">
													<div class="row">
														<span class="summaryHdrCLs">Online</span>
														<span class="dashCls">---</span>
														<span class="payOnlineCountCls">x2</span>
													</div>
												</div>
												<div class="col-md-6 mr-auto summaryValMainCls">
													<div class="row float-right">
														<span class="summaryValCLs">
															<i class="fa fa-inr" style="color: inherit;"></i>
															<span class="payOnlineAmountCls">00.00</span>
														</span>
													</div>
												</div>
											</div>
											<div class="row offerAppliedMainCls">
												<div class="col-md-6 mr-auto summaryHdrMainCls">
													<div class="row">
														<span class="summaryHdrCLs">Offer applied</span>
													</div>
												</div>
												<div class="col-md-6 mr-auto summaryValMainCls">
													<div class="row float-right">
														<span class="summaryValCLs">
															- 
															<i class="fa fa-inr" style="color: inherit;"></i>
															<span class="offerAppliedAmountCls">00.00</span>
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="totalSummaryCls">
									<div class="" style="background: rgba(241,251,255,1);padding: 22px 20px 10px 20px;float: left;width: 100%;">
										<div class="summaryValMainCls" style="float: left; width: 100%; font-size: 14px;">
											<div class="float-right">
												<span class="summaryValCLs" style="float: left; width: 100%; line-height: 20px; font-weight: bold;">
													<span>Total Amount</span>
												</span>
												<span class="summaryValCLs" style="float: left; width: 100%; line-height: 20px;">
													<i class="fa fa-inr" style="color: inherit;"></i>
													<span class="totAmountCls">00</span>
												</span>
											</div>
										</div>
									</div>
									<div class="row float-right" style="padding: 10px 35px;">
										<div class="col-md-12 mr-auto dropSummaryCls">
											<div class="row">
													<span class="bookPackageCls">
														<i class="fa fa-check"></i> Book Package</span>
													<span class="schedulePackageCls">
														<i class="fa fa-clock-o"></i> Schedule Package</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	
	<div class="modal formcls" id="scheduleModal" tabindex="-1" role="dialog" aria-labelledby="scheduleModal" aria-hidden="true" style="">
		<div class="modal-dialog">
			<div class="modal-content content_1" style="border-radius: 0px; border: none;">
		          <div class="modal-body">
		              <div class="row1">
							<div class="col-md-12 col-sm-12 col-ms-12">
								<div class="schedulePickupTitleCls">
									<span>Schedule Pick up</span>
								</div>
								
								<div class="col-md-12 col-sm-12 col-ms-12">
									 <div class="row">
									 	<div class="col-md-6 col-sm-6 col-ms-6">
									 		<span style="line-height: 34px;">Select Date & Time</span>
									 	</div>
									 	<div class="col-md-6 col-sm-6 col-ms-6">
									 		<input type="text" id="scheduleDt">
									 	</div>
									 </div>
									 <div class="row" style="display: none;">
									 	<div class="col-md-6 col-sm-6 col-ms-6">
									 		<span>Select Time</span>
									 	</div>
									 	<div class="col-md-6 col-sm-6 col-ms-6">
									 		<input type="text" id="scheduleTm">
									 	</div>
									 </div>
								</div>
								
								<div class="col-md-12 col-sm-12 col-ms-12" style="margin-bottom: 30px;">
									<div class="row">
										 <div class="col-md-6 col-sm-6 col-ms-6">
									 	 </div>
									 	 <div class="col-md-6 col-sm-6 col-ms-6">
									 		 <button class="btn btn-primary scheduleBtnCls"><i class="fa fa-clock-o"></i> Schedule</button>
									 	 </div>
									 </div>
								</div>
							</div>
		              </div>
		          </div>
		      </div>
		</div>
	</div>
	
	<div class="modal formcls" id="searchVedagramModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content content_1" style="border-radius: 0px; border: none;">
		          <div class="modal-header" style="display: block;background: rgba(0,148,205,1);border-radius: 0px;">
		              <button type="button" class="close" data-dismiss="modal" style="position:relative;"><span class="fa fa-times-circle"></span></button>
		              <div class="modal-title" id="myModalLabel" style="float: left; width: 100%;color: white;">Search Drop Location</div>
		              <div style="float: left;width: 100%;position: relative;margin-top: 20px;">
		              	<i class="fa fa-search" style="position: absolute;color: rgba(48,197,143,1);line-height: 35px;width: 30px;text-align: center;"></i>
		              	<input type="text" placeholder="Search your location" id="srchMapLoc" style="padding-left: 30px;margin: 0;">
		              </div>
		          </div>
		          <div class="modal-body">
		              <div class="row1">
							<div class="col-md-12 col-sm-12 col-ms-12">
								<div class="searchResultMainCls">
									<div class="searchResultHdrCls">
										<div>Search Results</div>
									</div>
									<div class="searchResultBodyCls" id="searchResultBody">
									</div>
								</div>
								
								<div class="recentSearchMainCls">
									<div class="recentSearchHdrCls">
										<div class="recentSrchLblCls">Recent Search Result</div>
									</div>
									<div class="recentSearchBodyCls"></div>
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
	
	<div class="modal formcls" id="pickDropFormModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static" style="display: none;">
		<div class="modal-dialog" style="margin-top: 0; margin-bottom: 0;">
			<div class="modal-content content_1" style="border-radius: 10px; border: none;">
		          <div class="modal-header" style="display: block;background: rgba(0,148,205,1);padding: 0;">
		              <button type="button" class="close" data-dismiss="modal" style="position:relative;color: gray;"><span class="fa fa-times-circle"></span></button>
		              <div class="mapDivCls">
		              	<span class="markerIconCls fa fa-map-marker"></span>
		              	<div id="map"></div>
		              </div>
		          </div>
		          <div class="modal-body" style="border-radius: 10px; background: white; margin-top: -10px;">
		              <div class="row1" style="margin-bottom: 50px;">
		              		<div class="col-md-12 col-sm-12 col-ms-12">
								<div class="row">
									<div class="frmAddressCls">no address</div>
									<span class="fa fa-heart favouriteCls"></span>
									<input type="hidden" class="frmAddressInputCls">
									<input type="hidden" class="frmLatCls">
									<input type="hidden" class="frmLngCls">
									<input type="hidden" class="frmAreaCls">
									<input type="hidden" class="frmCityCls">
									<input type="hidden" class="frmStateCls">
									<input type="hidden" class="frmCountryCls">
								</div>
							</div>
							
							<div class="col-md-12 col-sm-12 col-ms-12">
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6">
										<span class="formHdrCls">Contact Name</span>
										<input type="text" class="frmNameCls mapFormInputCls">
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6">
										<span class="formHdrCls">Contact Number</span>
										<input type="text" class="frmPhoneCls mapFormInputCls">
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<span class="formHdrCls">Landmark</span>
										<input type="text" class="frmLandmarkCls mapFormInputCls">
									</div>
								</div>
								<div class="row onlyDropCls">
									<div class="col-md-12">
										<span class="formHdrCls">Instructions to Delivery Agent [ Eg: Beware of Dogs]</span>
										<input type="text" class="frmInstructionCls mapFormInputCls">
									</div>
								</div>
								
								<div class="row" style="display: none;">
									<div class="col-md-4 col-sm-4 col-ms-4">
										<input type="checkbox" name="frmCodFlag" id="frmCodFlag" class="frmCodFlagCls" style="float: left; width: auto; margin: 2px 5px 0px 0px;">
										<label for="frmCodFlag">COD</label>
									</div>
									<div class="col-md-4 col-sm-4 col-ms-4">
										<input type="checkbox" name="frmInclDelvChargeFlag" id="frmInclDelvChargeFlag" class="frmInclDelvChargeFlagCls" style="float: left; width: auto; margin: 2px 5px 0px 0px;">
										<label for="frmInclDelvChargeFlag">Includes Delivery Charges</label>
									</div>
									<div class="col-md-4 col-sm-4 col-ms-4" style="display: none;">
										<span class="formHdrCls">COD Amount</span>
										<input type="text" class="frmCodAmntCls mapFormInputCls">
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6 onlyDropCls">
										<span class="formHdrCls">Weight</span>
										<select class="frmWeightCls mapFormInputCls">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
										</select>
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6 onlyDropCls">
										<span class="formHdrCls">Payment Type</span>
										<select class="frmPaymentTypeCls mapFormInputCls">
											<option value="1">Cash at Pickup</option>
											<option value="2">Cash at Drop</option>
										</select>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6 onlyDropCls">
										<span class="formHdrCls">Task Price</span>
										<input type="number" class="frmTaskPriceCls mapFormInputCls">
									</div>
								</div>
							</div>
		              </div>
		              
		              <div class="btnMainCls" style="position: fixed;bottom: 0px;left: 0;width: 100%;background: white;">
			              <div class="col-md-12 col-sm-12 col-ms-12">
			              <div class="col-md-12 col-sm-12 col-ms-12">
				              <div class="row">
									<div class="col-md-6 col-sm-6 col-ms-6">
										<input type="button" value="Back" class="btn btn-secondary backBtnCls">
									</div>
									<div class="col-md-6 col-sm-6 col-ms-6">
										<input type="button" value="Confirm Location" class="btn btn-primary cnfrmLocBtnCls">
									</div>
							  </div>
						  </div>
						  </div>
					  </div>
		          </div>
		      </div>
		</div>
	</div>
	
	<div class="col-md-12 mr-auto dropBoxDummyCls">
		<div class="col-md-12 mr-auto">
			<div id="Drop_Point" class="row">
				<span class="dropPointLblCls">Drop Point 1</span>
				<span class="editDropBtnCls" lat="" lng=""><i class="fa fa-edit" style="color: inherit;margin-right: 5px;"></i>Edit</span>
			</div>
			
			<div class="delvChargeMainCls">
				<span style="float: left; width: 100%;">Delivery Charge</span>
				<span style="float: left; width: 100%; font-weight: bold;">
					<i class="fa fa-inr" style="color: inherit;"></i>
					<span class="dropDelvAmount">0.00</span>
				</span>
			</div>
		</div>
		<div class="col-md-12 mr-auto">
			<div class="row">
				<div class="col-md-3 mr-auto">
					<div class="row">
						<span class="lblHdrCls">Receiver Name</span>
						<span class="lblValCls receiverNmCls">Test</span>
					</div>
				</div>
				<div class="col-md-3 mr-auto">
					<div class="row">
						<span class="lblHdrCls">Receiver Contact</span>
						<span class="lblValCls receiverMobileCls">00000000000</span>
					</div>
				</div>
				<div class="col-md-6 mr-auto">
					<div class="row">
						<span class="lblHdrCls">Receiver Address</span>
						<span class="lblValCls receiverAddrCls">Test</span>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-12 mr-auto">
			<div class="row">
				<div class="col-md-3 mr-auto inclDelvChrgDivCls">
					<div class="row">
						<span class="lblHdrCls">Incl. Delivery Charge</span>
						<span class="lblValCls inclDelvChrgCls">Yes</span>
					</div>
				</div>
				<div class="col-md-3 mr-auto">
					<div class="row">
						<span class="lblHdrCls">Payment Type</span>
						<span class="lblValCls payTypeCls">Test</span>
					</div>
				</div>
				<div class="col-md-2 mr-auto itemAmntDivCls">
					<div class="row">
						<span class="lblHdrCls">Item Amount</span>
						<span class="lblValCls itemAmntCls">000</span>
					</div>
				</div>
				<div class="col-md-4 mr-auto">
					<div class="row">
						<div class="delvInstructionCls">
							<i class="fa fa-comment" style="color: inherit;"></i>
							<span class="instructionCls">Do not Ring the doorbell!</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-12 mr-auto taskPriceDivCls">
			<div class="row">
				<div class="col-md-3 mr-auto">
					<div class="row">
						<span class="lblHdrCls">Task Price<span class="addChargeCls" style="color: red;"> (Additional Charge)</span></span>
						<span class="lblValCls"><span class="fa fa-inr"></span><span class="taskPriceCls"></span></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>