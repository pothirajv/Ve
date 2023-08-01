<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<title>Vedagram : Track Deliveries</title>
<script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script>

<style type="text/css">
.viewreqdtlscls {
	text-decoration: underline;
	cursor: pointer;
}
#senderRequestModal .modal-header .close {
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
#senderRequestModal .modal-dialog {
	height: calc(100% - 20px);
    margin: 10px auto !important;
    max-width: 90%;
}
#senderRequestModal .modal-content {
	height: 100%;
}
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
	width: 100%;
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
	background: #f7f7f7;
    padding: 20px 0px;
    border-radius: 10px;
}
.frmValLblCls {
    font-size: 11px;
}










.dummyboxcls {
	cursor: default !important;
}
.reqwisehdncls, .mulreqwisehdncls {
	display: none;
	margin-bottom: 10px;
}
.reportContainerCls {
    min-height: 200px;
    border: 1px solid #e3e3e3;
    border-radius: 3px;
	margin-bottom: 10px;
	padding: 0.3rem;
}
.statusHdrCls {
	float: left;
	width: 100%;
}
.statusNmCls {
	font-size: 0.7rem;
    float: left;
    min-width: 130px;
    background: #e91e63;
    color: #ffffff;
    padding: 4px 8px;
    border-radius: 2px;
}
.boxKeyWiseCls .fa {
    margin-right: 4px;
    color: gray;
}
.boxKeyWiseNmCls {
    font-size: 0.6rem;
    float: left;
    width: 100%;
    margin-top: 5px;
}
.subboxlblcls {
    font-size: 12px;
    width: 30px;
    float: left;
    text-align: center;
    margin: auto;
    background: #f9f9f9;
    margin-bottom: 3px;
    cursor: pointer;
    border-radius: 2px;
}
.row {
    margin-right: 5px;
    margin-left: -15px;
}
</style>
<script>
var dashData;
var minsArr = [];
minsArr[0] = "10 min";
minsArr[1] = "30 min";
minsArr[2] = "60 min";
minsArr[3] = "90 min";
//	minsArr[4] = "5 min";

var minsArrColor = [];
minsArrColor[0] = "#a4ffaf";
minsArrColor[1] = "#fffb88";
minsArrColor[2] = "#ffbd79";
minsArrColor[3] = "#ffabab";
//	minsArrColor[4] = "#ffabab";

$(document).ready(function() {
	//loadDashboard("01/02/2021");
	loadDashboard("");
	$(document.body).on('click', '.viewreqdtlscls', function () {
		var mainlistidx = $(this).attr('mainlistidx');
		var minskey = $(this).attr('minskey');
		var listidx = $(this).attr('listidx');
		
		var senderRequestModelList = [];
		if(mainlistidx == undefined && minskey == undefined && listidx == undefined) {
			for (var i = 0; i < dashData.dashboardPackageStatusWiseDtos.length; i++) {
				var dashboardPackageStatusWiseDto = dashData.dashboardPackageStatusWiseDtos[i]
				var senderRequestModelMap = dashboardPackageStatusWiseDto.senderRequestModelMap;
				for (var k = 0; k < minsArr.length; k++) {
					var key = minsArr[k]; 
					var senderRequestModelLst = senderRequestModelMap[key];
					if(senderRequestModelLst != undefined) {
						for (var j = 0; j < senderRequestModelLst.length; j++) {
							senderRequestModelList.push(senderRequestModelLst[j]);
						}
					}
				}
			}
		} else if(mainlistidx != undefined && minskey == undefined && listidx == undefined) {
			var dashboardPackageStatusWiseDto = dashData.dashboardPackageStatusWiseDtos[mainlistidx]
			var senderRequestModelMap = dashboardPackageStatusWiseDto.senderRequestModelMap;
			for (var k = 0; k < minsArr.length; k++) {
				var key = minsArr[k]; 
				var senderRequestModelLst = senderRequestModelMap[key];
				if(senderRequestModelLst != undefined) {
					for (var j = 0; j < senderRequestModelLst.length; j++) {
						senderRequestModelList.push(senderRequestModelLst[j]);
					}
				}
			}
		} else if(mainlistidx != undefined && minskey != undefined && listidx == undefined) {
			var dashboardPackageStatusWiseDto = dashData.dashboardPackageStatusWiseDtos[mainlistidx]
			var senderRequestModelMap = dashboardPackageStatusWiseDto.senderRequestModelMap;
			senderRequestModelList = senderRequestModelMap[minskey];
		} else if(mainlistidx != undefined && minskey != undefined && listidx != undefined) {
			var dashboardPackageStatusWiseDto = dashData.dashboardPackageStatusWiseDtos[mainlistidx]
			var senderRequestModelMap = dashboardPackageStatusWiseDto.senderRequestModelMap;
			var senderRequestModelLst = senderRequestModelMap[minskey];
			var senderRequestModel = senderRequestModelLst[listidx];
			senderRequestModelList.push(senderRequestModel);
		}
		
		$('.reqDtlsMainCls').html('');
		
		if(senderRequestModelList == undefined || senderRequestModelList.length == 0) {
			alert('No requests to show');
			return;
		}
		
		for (var i = 0; i < senderRequestModelList.length; i++) {
			var senderRequestModel = senderRequestModelList[i];
			var htmlElem = addReqContainer(senderRequestModel);
			$('.reqDtlsMainCls').append(htmlElem);
		}
		
		$('#senderRequestModal').modal({
			show: true,
		});
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

function loadDashboard(selDate) {
	if(selDate == null || selDate == undefined || selDate == 'undefined') {
		selDate = '';
	}
	
	$('.reqwisecls').html('');
	$.ajax({
		url : $("#contextPath").val()+'/adm/getDashDtls?selDate='+selDate,
		contentType : "application/json",
		type : 'POST',
		dataType: 'json',
		success:function(data){
			console.log(data);
			dashData = data;
			var htmlVar = '';
			var keyNum = 0;
			for (var i = 0; i < data.dashboardPackageStatusWiseDtos.length; i++) {
				var dashboardPackageStatusWiseDto = data.dashboardPackageStatusWiseDtos[i];
				var senderRequestModelMap = dashboardPackageStatusWiseDto.senderRequestModelMap;
				
				htmlVar = '<div class="col-md-4">';
				htmlVar += '<div class="reportContainerCls">';
				htmlVar += '<div class="statusHdrCls">'
				htmlVar += '<div class="statusNmCls viewreqdtlscls" mainListIdx="'+i+'">' + dashboardPackageStatusWiseDto.packageStatus + '</div>';
				htmlVar += '</div>';
				htmlVar += '<div class="boxCls row">';
				
				for (var k = 0; k < minsArr.length; k++) {
					var key = minsArr[k]; 
					var senderRequestModelList = senderRequestModelMap[key];
					htmlVar += '<div class="boxKeyWiseCls col-md-6">';
					htmlVar += '<div class="boxKeyWiseNmCls viewreqdtlscls" mainListIdx="'+i+'" minsKey="'+key+'"><i class="fa fa-clock-o"></i>' + key + '</div>';
					htmlVar += '<div class="boxItemMainCls row">';
					if(senderRequestModelList != null && senderRequestModelList != undefined) {
						for (var j = 0; j < senderRequestModelList.length; j++) {
							var senderRequestModel = senderRequestModelList[j];
							htmlVar += '<div class="subboxCls col-md-3"><span class="subboxlblcls viewreqdtlscls" style="background: '+minsArrColor[k]+';" mainListIdx="'+i+'" minsKey="'+key+'" listIdx="'+j+'">' + (j+1) + '</span></div>';
						}
					} else {
						for (var j = 0; j < 9; j++) {
							htmlVar += '<div class="subboxCls col-md-3"><span class="subboxlblcls dummyboxcls">&nbsp;</span></div>';
						}
					}
					htmlVar += '</div>';
					htmlVar += '</div>';
				}
				/* $.each(senderRequestModelMap, function (key, senderRequestModelList) {
					htmlVar += '<div class="boxKeyWiseCls col-md-6">';
					htmlVar += '<div class="boxKeyWiseNmCls"><i class="fa fa-clock-o"></i>' + key + '</div>';
					
					htmlVar += '<div class="boxItemMainCls row">';
					for (var j = 0; j < senderRequestModelList.length; j++) {
						var senderRequestModel = senderRequestModelList[j];
						htmlVar += '<div class="subboxCls col-md-3"><span class="subboxlblcls">' + (j+1) + '</span></div>';
					}
					htmlVar += '</div>';
					htmlVar += '</div>';
				}); */
				htmlVar += '</div>';
				htmlVar += '</div>';
				htmlVar += '</div>';
				
				$('.reqwisecls').append(htmlVar);
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
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
					<h5 class="font-weight-bold">
						<span>Track Deliveries</span>
					</h5>
					<div class="row">
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="reqwisecls row"></div>
						</div>
					</div>
				</div>
			</section>
		</div>
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
	
	<div class="modal formcls" id="senderRequestModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-keyboard="true" data-backdrop="static" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content content_1" style="border-radius: 0px; border: none;">
		          <div class="modal-header" style="display: block;background: rgba(0,148,205,1);border-radius: 0px;">
		              <button type="button" class="close" data-dismiss="modal" style="position:relative;"><span class="fa fa-times-circle"></span></button>
		              <div class="modal-title" id="myModalLabel" style="float: left; width: 100%;color: white;">Request Details</div>
		          </div>
		          <div class="modal-body">
		              <div class="row1 reqDtlsMainCls">
		              </div>
		          </div>
		      </div>
		</div>
	</div>
</body>