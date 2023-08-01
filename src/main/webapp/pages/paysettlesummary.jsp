<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/delvtbl.js"></script>

<style>

td label {
    margin-bottom: 4px;
    line-height: 16px;
}

.hdrLblCls {
    font-weight: bold;
    color: black;
}

.saveDisableBtn {
    background: #cecbcb;
    border-color: #cecbcb;
    cursor: default !important;
}

#loginPageerrormsg {
	display: none;
	color: red;
    text-align: center;
    padding: 20px 0px;
}

.defTbl td {
	border: 1px solid #d8d8d8;
    padding: 5px;
	color: #007bff;
	font-weight: bold;
}

.loginPageerrormsg {
	color: red;
	font-size: 14px;
	text-align: center;
	padding: 10px;
}
#tableDiv1 {
	display: block;
}
.hdrCls {
    font-weight: bold;
    color: black;
}

.prevBillErrCls {
    color: red;
    font-size: 12px;
    margin-bottom: 10px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
var dataTable1;
var dataTable2;
var dataTable3;
var tblData;
var tblDataArr = [];
var pendAmount = 0;

var requestFor = 1;
var historyTblData;
var taxTblData;
var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];

$(document).ready(function() {
	
	loadBillCycleList();
	$('#locSelCls').change(function() {
		loadBillCycleList();
	});
	
	$('#settlementTo').change(function() {
		requestFor = $(this).val();
		loadBillCycleList();
	});
	
	$('#billCyclePend').change(function() {
		loadBillCycleList();
	});
	
	$("#billingCycle").change(function() {
		searchBillingInfo();
	});
	
	var delvAllowanceReportTbl;
	$(document.body).on('click', '.delvAllowanceCls', function() {
		var tblId = '#delvAllowanceDtlsTbl';
		if ($.fn.DataTable.isDataTable(tblId) ) {
			$(tblId).DataTable().destroy();
		  	$(tblId).empty();
		}
		
		var userTbl ="";
		userTbl ='<thead><tr>';
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer Name</th>';
		userTbl += '<th style="min-width: 130px;">Date</th>';
		userTbl += '<th style="min-width: 130px;">No. Of Delv.</th>';
		userTbl += '<th style="min-width: 130px;">Delv. Allowance</th>';
		userTbl += '</tr></thead>';
		
		userTbl += '<tbody>';
		
		var currIdx = 0;
		for (var i = 0; i < taxTblData.length; i++) {
			Object.keys(taxTblData[i].taxationDetailsDtosMap).forEach(function(key) {
				currIdx++;
				var value = taxTblData[i].taxationDetailsDtosMap[key];
				var delvAllowance = value.length * parseFloat(value.length <= taxTblData[i].perDayDelvCountMax ? taxTblData[i].ratePerDelvLow : taxTblData[i].ratePerDelvHigh);
				userTbl += '<tr>';
				userTbl += '<td>'+currIdx+'</td>';
				userTbl += '<td>'+key+'</td>';
				userTbl += '<td>'+taxTblData[i].delivererName+'</td>';
				userTbl += '<td>'+value.length+'</td>';
				userTbl += '<td>'+delvAllowance+'</td>';
				userTbl += '</tr>';
			});
		}
		userTbl += '</tbody>';
		$(tblId).append(userTbl);
		
		delvAllowanceReportTbl = $(tblId).dataTable({
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ],
			"show": function(event, ui) {
				var table = $.fn.dataTable.fnTables(true);
				if (table.length > 0) {
	                  $(table).dataTable().fnAdjustColumnSizing();
                }
			}
		});
		delvAllowanceReportTbl.on('draw', function () {
			var body = $(delvAllowanceReportTbl.table().body());
			body.unhighlight();
			body.highlight(delvAllowanceReportTbl.search());  
		});

		$('#delvAllowanceModal').modal('show');
	});
	
	function formateDate(d) {
		var dateStr = '';
		var weekday = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
		var monthname = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
		dateStr += (d.getDate().toString().length == 2 ? d.getDate() : ("0" + d.getDate())) + " ";
		dateStr += monthname[d.getMonth()] + " ";
		dateStr += d.getFullYear();
		return dateStr;
	}
	
	$("#sDetails").hide();
	
	function searchBillingInfo() {
		if(requestFor == '1') {
			$('.moreDtlsCls').hide();
		} else {
			$('.moreDtlsCls').show();
		}
		$('.loadCmnCls').show();
		var delivererId = $("#userNameSrchSel").val();

		if(dataTable1 != undefined)
			dataTable1.destroy();
		if(dataTable2 != undefined)
			dataTable2.destroy();
		if(dataTable3 != undefined)
			dataTable3.destroy();
		
		$('#tableDiv').html('');
		
		var userRole = $('#rad_roleSelect_cls').val();
		var userId = $('#userNameSrchSel').val();
		var memberBillingCycleId = $('#billingCycle').val();
		var pendingFlag = false;
		if($('#billCyclePend').val() == '1') {
			pendingFlag = true;
		}
		if(memberBillingCycleId == '') {
			$('.loadCmnCls').hide();
			$('#cancelbtn').trigger('click');
			return false;
		}
		var location = $('#locSelCls').val();
		if(location == '') {
			return false;
		}
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getSettleDetailsByBillingCycleIdForAll",
			data : {userRole : 'ROLE_DELIVER', location: location, memberBillingCycleId: memberBillingCycleId, pendingFlag: pendingFlag },
			success : function(json){
				if(json != null){
					taxTblData = json;
					loadBillingInfo(json);
				}
				$('.loadCmnCls').hide();
			}
		});
	}
	
	$(document.body).on('click', '.generateExcel', function() {
		var location = $('#locSelCls').val();
		var memberBillingCycleId = $('#billingCycle').val();
		var pendingFlag = false;
		if($('#billCyclePend').val() == '1') {
			pendingFlag = true;
		}
		if(memberBillingCycleId == '') {
			$('.loadCmnCls').hide();
			$('#cancelbtn').trigger('click');
			return false;
		}
		var location = $('#locSelCls').val();
		if(location == '') {
			return false;
		}
		
		if(taxTblData != null && taxTblData != undefined && taxTblData.length > 0) {
			var newForm = jQuery('<form>', { 'action': $("#contextPath").val()+'/adm/generateSummaryReportExcel', 'target': '_top', 'method': 'post' });
			newForm.append(jQuery('<input>', { 'name': 'reportFor', 'value': requestFor, 'type': 'hidden' }));
			newForm.append(jQuery('<input>', { 'name': 'userRole', 'value': 'ROLE_DELIVER', 'type': 'hidden' }));
			newForm.append(jQuery('<input>', { 'name': 'location', 'value': location, 'type': 'hidden' }));
			newForm.append(jQuery('<input>', { 'name': 'memberBillingCycleId', 'value': memberBillingCycleId, 'type': 'hidden' }));
			newForm.append(jQuery('<input>', { 'name': 'pendingFlag', 'value': pendingFlag, 'type': 'hidden' }));
			
			newForm.appendTo('body').submit();
		} else {
			alert('No details to download');
			return false;
		}
	});
	
	$('#cancelbtn').click(function() {
		$("html, body").animate({ scrollTop: 0 }, "slow");
		$('#dlvNameCls').html('');
		$('#dId').val('');
		$('#lastSettleDateCls').html('');
		$('#lastSettleAmountCls').html('');
		$('#pAmount').html('');
		$('#amountPaid').val('');
		
		$('.srchMainCls').show();
		$('.contentMainCls').hide();
		$('#billingCycle').val('');
	});
	
	function loadBillingInfo(currData) {
		var fromDate = $('#billingCycle').find('option:selected').attr('fromDate');
		$('#dlvNameCls').html('');
		$('#dId').val('');
		$('#lastSettleDateCls').html('');
		$('#lastSettleAmountCls').html('');
		$('#pAmount').html('');
		$('#amountPaid').val('');
		$('.contentMainCls').show();
		
		buildTaxTable(currData, requestFor);
	}
	
	function prefixPattern(val, maxNum, prefixVal) {
		if(maxNum > val.length) {
			for(var i = 0; i < (maxNum - val.length); i++) {
				val = prefixVal + val;
			}
		}
		return val;
	}
	
	function buildTaxTable(data, requestFor) {
		$('#perDayDelvCountMax').html('-');
		$('#ratePerDelvLow').html('-');
		$('#ratePerDelvHigh').html('-');
		$('#bonusDistPerDay').html('-');
		$('#pricePerKm').html('-');
		
		if(data!=null){
			var obj = data[0];
			$('#perDayDelvCountMax').html(obj.perDayDelvCountMax);
			$('#ratePerDelvLow').html(obj.ratePerDelvLow);
			$('#ratePerDelvHigh').html(obj.ratePerDelvHigh);
			$('#bonusDistPerDay').html(obj.bonusDistPerDay);
			$('#pricePerKm').html(obj.pricePerKm);
			
			loadDelvTableList(data, requestFor, '#deliveryDtlsTbl');
			$('.generateDivCls').show();
			$('.dateCls').show();
			$('.generateExcel').show();
		}
	}
	
	function loadBillCycleList() {
		$("#billingCycle").html('');
		$("#billingCycle").attr('disabled', 'disabled');
		$('.contentMainCls').hide();
		var pendingFlag = false;
		if($('#billCyclePend').val() == '1') {
			pendingFlag = true;
		}
		var location = $('#locSelCls').val();
		if(location == '') {
			return false;
		}
		$.ajax({
			url : $("#contextPath").val()+'/adm/getBillingCycleToGetSettlementForAll?pendingFlag=' + pendingFlag + '&location=' + location + '&requestFor=' + requestFor,
			type : 'POST',
			success:function(data){
				if(data.length > 0) {
					$("#billingCycle").removeAttr('disabled');
					var opt="<option value=''>Select One</option>";
					$.each(data,function(i,val){
						var fromDt = new Date(val.fromDate);
						var toDt = new Date(val.toDate);
						
						var billingCycleVar = formateDate(fromDt) + " To " + formateDate(toDt);
						var addTxt = '';
						if(val.payCompleteFlag != true) {
							addTxt = ' (Pending)';
							opt += '<option cflg="false" style="background: #ffffff;" fromDate="'+val.fromDate+'" toDate="'+val.toDate+'" billId="'+val.id+'" billidx="'+i+'" compflag="'+val.payCompleteFlag+'" value="'+val.id+'">'+billingCycleVar + addTxt + '</option>';
						} else {
							addTxt = ' (Completed)';
							opt += '<option cflg="true" style="background: #ffffff;" fromDate="'+val.fromDate+'" toDate="'+val.toDate+'" billId="'+val.id+'" billidx="'+i+'" compflag="'+val.payCompleteFlag+'" value="'+val.id+'">'+billingCycleVar + addTxt + '</option>';
						}
					});
					$("#billingCycle").append(opt);
				} else {
					$("#billingCycle").append("<option value=''>No Billing Cycle</option>");
					$("#billingCycle").trigger('change');
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
		        alert("Status: " + textStatus);
		    }
		});
	}
	
	function loadDelvTableList(data, reportFor, tblId){
		
		if ($.fn.DataTable.isDataTable(tblId) ) {
			$(tblId).DataTable().destroy();
		  	$(tblId).empty();
		}
		$('.delvAllowanceCls').hide();
		var userTbl ="";
		if(reportFor == 1) {
			userTbl ='<thead><tr>';
			userTbl += '<th>S.No.</th>';
			userTbl += '<th style="min-width: 130px;">Location</th>';
			userTbl += '<th style="min-width: 130px;">From Date</th>';
			userTbl += '<th style="min-width: 130px;">To Date</th>';
			userTbl += '<th style="min-width: 130px;">Deliverer<BR>Name</th>';
			userTbl += '<th style="min-width: 130px;">Total<BR>Deliveries</th>';
			userTbl += '<th style="min-width: 130px;">Amount<BR>To<BR>Sttlle<BR>By<BR>Deliverer</th>';
			userTbl += '</tr></thead>';
		} else if(reportFor == 2) {
			$('.delvAllowanceCls').show();
			var obj = data[0];
			
			userTbl ='<thead><tr>';
			userTbl += '<th>S.No.</th>';
			userTbl += '<th style="min-width: 130px;">Location</th>';
			userTbl += '<th style="min-width: 130px;">From Date</th>';
			userTbl += '<th style="min-width: 130px;">To Date</th>';
			userTbl += '<th style="min-width: 130px;">Deliverer<BR>Name</th>';
			userTbl += '<th style="min-width: 130px;">Total<BR>Deliveries</th>';
			userTbl += '<th style="min-width: 130px;">Delivery<BR>Allowance[If<BR>Delv.<BR>Count/day <= '+obj.perDayDelvCountMax+'<BR>=Rs. '+obj.ratePerDelvLow+'/day][If<BR>Delv.<BR>Count/day > '+obj.perDayDelvCountMax+'<BR>=Rs. '+obj.ratePerDelvHigh+'/day]</th>';
			userTbl += '<th style="min-width: 130px;">Days<BR>Worked</th>';
			userTbl += '<th style="min-width: 130px;">Distance<BR>Traveled<BR>[Actual]</th>';
			userTbl += '<th style="min-width: 130px;">Per Day<BR>KM<BR>Offer[Bonus]<BR>['+obj.bonusDistPerDay+'Km *<BR>No. of<BR>working days]</th>';
			userTbl += '<th style="min-width: 130px;">Total<BR>Distance<BR>[Actual]<BR>+<BR>[Bonus]</th>';
			userTbl += '<th style="min-width: 130px;">Petrol<BR>Allowance<BR>[Total Distance<BR>*<BR>Rs. '+obj.pricePerKm+']</th>';
			userTbl += '<th style="min-width: 130px;">Additional<BR>KM</th>';
			userTbl += '<th style="min-width: 130px;">Additional KM<BR>[Petrol<BR>Allowance]</th>';
			userTbl += '<th style="min-width: 130px;">Amount to<BR>Credit to<BR>Deliverer<BR>[Delivery Allowance<BR>+<BR>Petrol Allowance<BR>+<BR>Additional<BR>Petrol Allowance]</th>';
			userTbl += '</tr></thead>';
		}
		$(tblId).append(userTbl);

		loadDelvTblBody(data, reportFor, tblId);
	}
	

	var delvReportTbl;
	function loadDelvTblBody(data, reportFor, tblId) {
		if(reportFor == 1) {
			delvReportTbl = $(tblId).DataTable({
				"data" : data,
				"autoWidth": false,
				"oLanguage" : {
					"sEmptyTable" : "No Data Available"
				},
				"order" : [ [ 0, "asc" ] ],
				"bLengthChange" : true,
				"bInfo" : true,
				"bProcessing" : true,
				//"bServerSide" : true,
				"sort" : "position",
				"bStateSave" : false,
				"iDisplayStart" : 0,
				"searchable" : true,

					"oPaginate" : {
						"sFirst" : "First",
						"sLast" : "Last",
						"sNext" : "Next",
						"sPrevious" : "Previous"
					
				},
				"scrollX": true,
				"columns" : [{
					"data" : "",
					"render" : function(data, type, row, meta) {
						var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
						if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
					}
				},{
					"data" : "location"
				},{
					"data" : "fromDate",
					"render" : function(data, type, row) {
					    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					    var datestring = '';
					    if(data != '') {
					    	var d = new Date(data);
						    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
					    }
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
					}
				},{
					"data" : "toDate",
					"render" : function(data, type, row) {
					    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					    var datestring = '';
					    if(data != '') {
					    	var d = new Date(data);
						    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
					    }
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
					}
				},{
					"data" : "delivererName"
				},{
					"data" : "totNoOfDelv"
				},{
					"data" : "totAmountToPayToPD"
				}],
				"pageLength" : 5,
				"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
			});
		} else if(reportFor == 2) {
			delvReportTbl = $(tblId).DataTable({
				"data" : data,
				"autoWidth": false,
				"oLanguage" : {
					"sEmptyTable" : "No Data Available"
				},
				"order" : [ [ 0, "asc" ] ],
				"bLengthChange" : true,
				"bInfo" : true,
				"bProcessing" : true,
				//"bServerSide" : true,
				"sort" : "position",
				"bStateSave" : false,
				"iDisplayStart" : 0,
				"searchable" : true,

					"oPaginate" : {
						"sFirst" : "First",
						"sLast" : "Last",
						"sNext" : "Next",
						"sPrevious" : "Previous"
					
				},
				"scrollX": true,
				"columns" : [{
					"data" : "",
					"render" : function(data, type, row, meta) {
						var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
						if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
					}
				},{
					"data" : "location"
				},{
					"data" : "fromDate",
					"render" : function(data, type, row) {
					    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					    var datestring = '';
					    if(data != '') {
					    	var d = new Date(data);
						    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
					    }
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
					}
				},{
					"data" : "toDate",
					"render" : function(data, type, row) {
					    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					    var datestring = '';
					    if(data != '') {
					    	var d = new Date(data);
						    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
					    }
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
					}
				},{
					"data" : "delivererName"
				},{
					"data" : "totNoOfDelv"
				},{
					"data" : "delvAllowance",
					"render" : function(data, type, row) {
					    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + data + "</span>";
					}
				},{
					"data" : "totNoOfDays"
				},{
					"data" : "distTraveled"
				},{
					"data" : "bonusDistTraveled"
				},{
					"data" : "totDistTraveled"
				},{
					"data" : "totPetrolAllowance"
				},{
					"data" : "otherDistTraveled"
				},{
					"data" : "otherPetrolAllowance"
				},{
					"data" : "totAmountToCreditToDeliverer"
				}],
				"pageLength" : 5,
				"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
			});
		}
		
		delvReportTbl.on('draw', function () {
			var body = $(delvReportTbl.table().body());
			body.unhighlight();
			body.highlight(delvReportTbl.search());  
		});
	}
});

</script>
</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
				<div class="container srchMainCls">
					<h5 class="font-weight-bold">
						<span>Settlement Summary</span>
					</h5>
					<div class="row">
						<div class="col-md-12 mr-auto formcls" style="margin-top: 20px;">
							<div class="row">
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Settlement To</label><br> 
									<select id="settlementTo">
										<option value="1">Vedagram</option>
										<option value="2">Deliverer</option>
									</select>
								</div>
								
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Billing Status</label><br> 
									<select id="billCyclePend">
										<option value="2">Show All</option>
										<option value="1" selected="selected">Show Pending</option>
									</select>
								</div>
								
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Location</label><br> 
									<select id="locSelCls">
										<option value="">Select Location</option>
										<c:forEach items="${allowedLocation}" var="allowedLoc">
											<option value="${allowedLoc}">${allowedLoc}</option>
										</c:forEach>
									</select>
								</div>
								
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls required-label">Billing Cycle</label><br> 
									<select id="billingCycle" disabled="disabled">
										<option value="">No Billing Cycle</option>
									</select>
								</div>
								<!-- <div class="col-md-12"></div>
			
								<div class="col-md-12">
									<button class="btn btn-primary" id="viewbtn">
										<span class="fa fa-search btn-icon"></span> Search</button>
								</div> -->
							</div>
						</div>
						
						<!-- <div id="tableDiv" class="col-md-12" style="margin-top: 20px;"></div> -->
					</div>
				</div>
				
				<div class="container contentMainCls" style="display: none; margin-top: 10px;">
					<div class="col-md-12 row mr-auto">
						<h5 class="font-weight-bold">
							<input type="hidden" id="roleNmFrm">
							<input type="hidden" id="employeeFlag">
							<input type="hidden" id="dId">
							<span id="dlvNameCls" style="color: #e91e63;"></span>
						</h5>
					</div>
					
					<div class="row">
						<div class="col-md-12 mr-auto">
							<div class="row formcls moreDtlsCls">
								<div class="col-md-12 form-group">
									<table class="defTbl" style="">
										<tr>
											<td style="width: 210px;">
												<label for="pickdrop" class="hdrLblCls">Max Delivery Count per Day</label><br> 
												<label id="perDayDelvCountMax">-</label>
											</td>
											<td style="width: 180px;">
												<label for="pickdrop" class="hdrLblCls">Rate Per Delv. [Low]</label><br> 
												<label id="ratePerDelvLow">-</label>
											</td>
											<td style="width: 180px;">
												<label for="pickdrop" class="hdrLblCls">Rate Per Delv. [High]</label><br> 
												<label id="ratePerDelvHigh">-</label>
											</td>
											<td style="width: 180px;">
												<label for="pickdrop" class="hdrLblCls">Bonus Distance per Day</label><br> 
												<label id="bonusDistPerDay">-</label>
											</td>
											<td style="width: 180px;">
												<label for="pickdrop" class="hdrLblCls">Price per KM</label><br> 
												<label id="pricePerKm">-</label>
											</td>
										</tr>
									</table>
								</div>
								<div class="col-md-12"></div>
							</div>
							
							<div class="row" style="margin-top: 20px;">
								<div class="col-md-12 form-group payFormCls" style="margin-top: 0px; margin-bottom: 0px;">
									<h6 style="font-weight: bold; float: left;">Payment Info</h6>
								</div>
								
								<div class="col-md-12 form-group" style="margin-top: 10px; margin-bottom: 0px;">
									<button class="btn btn-primary" id="cancelbtn" style="margin-right: 20px;">Cancel</button>
									<button class="btn btn-primary generateExcel" style="display: none; background: #ffffff;border-color: #007bff;color: #007bff;">
										<span class="fa fa-file-excel-o btn-icon"></span> Download Settlement Summary
									</button>
									
									<button class="btn btn-primary delvAllowanceCls" style="display: none; background: #ffffff;border-color: #007bff;color: #007bff;">
										View Delv. Allowance Details
									</button>
								</div>
								
								<div class="col-md-12 form-group" style="margin-top: 20px; margin-bottom: 0px;">
									<div class="row">
										<div class="col-md-12">
											<div id="tableDiv1" class="" style="width: 100%;">
												<table id="deliveryDtlsTbl" class="table table-striped table-bordered dataTable no-footer"></table>
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
	
	<div id="delvAllowanceModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document" style="max-width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Delv. Allowance Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="tableDiv2" class="" style="width: 100%;">
						<table id="delvAllowanceDtlsTbl" class="table table-striped table-bordered dataTable no-footer"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>