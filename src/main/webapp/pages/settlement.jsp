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

var historyTblData;
var taxTblData;
var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];

$(document).ready(function() {
	
	loadUserList();
	$('#locSelCls').change(function() {
		loadUserList();
	});
	
	$('#billCyclePend').change(function() {
		loadUserList();
	});
	
	$('#rad_roleSelect_cls').change(function() {
		if($(this).val() == 'ROLE_VENDOR') {
			$('.nameLblCls').html('Vendor Name');
		} else {
			$('.nameLblCls').html('Deliverer Name');
		}
		loadUserList();
	});
	
	$("#billingCycle").change(function() {
		searchBillingInfo();
	});
	
	$("#userNameSrchSel").change(function() {
		$("#billingCycle").html('');
		$("#billingCycle").attr('disabled', 'disabled');
		
		var pendingFlag = false;
		if($('#billCyclePend').val() == '1') {
			pendingFlag = true;
		}
		var delivererId = $(this).val();
		if(delivererId == '') {
			$("#billingCycle").append("<option value=''>No Billing Cycle</option>");
			$("#billingCycle").trigger('change');
			return false;
		}
		
		$.ajax({
			url : $("#contextPath").val()+'/adm/getBillingCycleToGetSettlement?delivererId=' + delivererId + '&pendingFlag=' + pendingFlag,
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
							opt += '<option cflg="false" style="background: #ffffff;" fromDate="'+val.fromDate+'" toDate="'+val.toDate+'" billId="'+val.id+'" userId="'+delivererId+'" billidx="'+i+'" compflag="'+val.payCompleteFlag+'" value="'+val.id+'">'+billingCycleVar + addTxt + '</option>';
						} else {
							addTxt = ' (Completed)';
							opt += '<option cflg="true" style="background: #ffffff;" fromDate="'+val.fromDate+'" toDate="'+val.toDate+'" billId="'+val.id+'" userId="'+delivererId+'" billidx="'+i+'" compflag="'+val.payCompleteFlag+'" value="'+val.id+'">'+billingCycleVar + addTxt + '</option>';
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
	});
	
	function formateDate(d) {
		var dateStr = '';
		var weekday = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
		var monthname = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
// 		dateStr += weekday[d.getDay()] + " ";
		dateStr += (d.getDate().toString().length == 2 ? d.getDate() : ("0" + d.getDate())) + " ";
		dateStr += monthname[d.getMonth()] + " ";
		dateStr += d.getFullYear();
		return dateStr;
	}
	
	$("#sDetails").hide();
	$('#viewbtn').click(function() {
		$('.loadCmnCls').show();
		var delivererId = $("#userNameSrchSel").val();

		if(dataTable1 != undefined)
			dataTable1.destroy();
		if(dataTable2 != undefined)
			dataTable2.destroy();
		if(dataTable3 != undefined)
			dataTable3.destroy();
		
		$('#tableDiv').html('');
		$('#tableDiv2').html('');
		
		var userRole = $('#rad_roleSelect_cls').val();
		var userId = $('#userNameSrchSel').val();
		var memberBillingCycleId = $('#billingCycle').val();
		
		if(memberBillingCycleId == '') {
			alert('Please Select Billing Cycle');
			$('.loadCmnCls').hide();
			return false;
		}
		
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getSettleDetailsByBillingCycleId",
			data : {userRole : userRole, userId: userId, memberBillingCycleId: memberBillingCycleId },
			success : function(json){
				if(json != null){
					loadBillingInfo(json);
				}
				$('.loadCmnCls').hide();
			}
		});
	});
	
	function searchBillingInfo() {
		$('.loadCmnCls').show();
		var delivererId = $("#userNameSrchSel").val();

		if(dataTable1 != undefined)
			dataTable1.destroy();
		if(dataTable2 != undefined)
			dataTable2.destroy();
		if(dataTable3 != undefined)
			dataTable3.destroy();
		
		$('#tableDiv').html('');
		$('#tableDiv2').html('');
		
		var userRole = $('#rad_roleSelect_cls').val();
		var userId = $('#userNameSrchSel').val();
		var memberBillingCycleId = $('#billingCycle').val();
		
		if(memberBillingCycleId == '') {
// 			alert('Please Select Billing Cycle');
			$('.loadCmnCls').hide();
			$('#cancelbtn').trigger('click');
			return false;
		}
		
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getSettleDetailsByBillingCycleId",
			data : {userRole : userRole, userId: userId, memberBillingCycleId: memberBillingCycleId },
			success : function(json){
				if(json != null){
					loadBillingInfo(json);
				}
				$('.loadCmnCls').hide();
			}
		});
	}
	
	$('#viewbtn1').click(function() {
		$('.loadCmnCls').show();
		var delivererId = $("#userNameSrchSel").val();

		if(dataTable1 != undefined)
			dataTable1.destroy();
		if(dataTable2 != undefined)
			dataTable2.destroy();
		if(dataTable3 != undefined)
			dataTable3.destroy();
		
		$('#tableDiv').html('');
		$('#tableDiv2').html('');
		
		$.ajax({
			url : 'getSettleDetailsById?delivererId='+delivererId,
			contentType : "application/json",
			method : 'POST',
			data : $("#dname").val(),
			success : function(data) {
				tblData = '';
				if(data.length > 0) {
					tblData = data;
					buildDataTable(tblData);
				}
				$('.loadCmnCls').hide();
			}
		});
	});
	//$('#viewbtn').click();
	
	$(document.body).on('click', '.generateExcel', function() {
		if(taxTblData != null && taxTblData != undefined && taxTblData.length > 0) {
			var newForm = jQuery('<form>', { 'action': $("#contextPath").val()+'/adm/generateTaxReportExcel', 'target': '_top', 'method': 'post' });
			for (var i = 0; i < taxTblData.length; i++) {
				var obj = taxTblData[i];
				newForm.append(jQuery('<input>', { 'name': 'taxIds', 'value': obj.id, 'type': 'hidden' }));				
			}
			newForm.append(jQuery('<input>', { 'name': 'reportFor', 'value': 3, 'type': 'hidden' }));
			newForm.appendTo('body').submit();
		} else {
			alert('No details to download');
			return false;
		}
	});
	
	$(document).on('click', '.showHistoryCls', function() {
		if($('#tableDiv2').is(':visible')) {
			$('#tableDiv2').slideUp();
		} else {
			$('#tableDiv2').slideDown();
		}
	});
	
	$(document).on('click', '.delvHistoryCls', function() {
		if($('#tableDiv1').is(':visible')) {
			$('#tableDiv1').slideUp();
		} else {
			$('#tableDiv1').slideDown();
			$('html, body').animate({
		        scrollTop: $("#tableDiv1").offset().top - 50
		    }, 1000);
		}
	});
	
	$("#paidOn").datepicker({
		dateFormat: 'yy-mm-dd',
		maxDate: new Date()
	});
	
	$('#settlebtn').click(function() {
		var paidOn = $('#paidOn').val();
		var amountPaid = parseFloat($("#amountPaid").val());
		var refNo = $('#refNo').val();
		var payRemarks = $('#payRemarks').val();
		var memberBillingCycleId = $('#billingCycle').val();
		
		if(isNaN(amountPaid)) {
			alert('Please enter valid number in "Amount Received From Deliverer"');
			return false;
		}
		
		if(amountPaid <= 0) {
			alert('"Amount Received From Deliverer" should be greater than Rs. 0');
			return false;
		}
		
		if(amountPaid > pendAmount) {
			alert('"Amount Received From Deliverer" should be less than Rs.' + pendAmount);
			return false;
		}
		
		if(paidOn == null || paidOn.trim() == '') {
			alert('Please select paid on');
			return false;
		}
		
		var settlementDetailsDto = new Object();
		settlementDetailsDto.settledBy = $('#dId').val();
		settlementDetailsDto.paidOn = paidOn;
		settlementDetailsDto.paidAmount = amountPaid;
		settlementDetailsDto.refNo = refNo;
		settlementDetailsDto.payRemarks = payRemarks;
		settlementDetailsDto.memberBillingCycleId = memberBillingCycleId;
		
		$('.loadCmnCls').show();
		$.ajax({
			url : 'processsettlement',
			contentType : "application/json",
			method : 'POST',
			data : JSON.stringify(settlementDetailsDto),
			success : function(data) {
				$('.loadCmnCls').hide();
				if(data != null && data.id != '') {
					$("html, body").animate({ scrollTop: 0 }, "slow");
					
					if($('#billCyclePend').val() == '2') {
						$('#billingCycle').find('option:selected').attr('cflg', 'true');
						$('#billingCycle').find('option:selected').attr('compflag', 'true');
						var selOpt = $('#billingCycle').find('option:selected').html();
						$('#billingCycle').find('option:selected').html(selOpt.replace('Pending', 'Completed'));
					} else {
						$('#billingCycle').find('option:selected').remove();
					}
					
					$('#cancelbtn').trigger('click');
					alert("Settled Successfully");
					$('.loadCmnCls').hide();
				} else {
					alert("Problem in settlement");
				}
			}
		});
	});
	
	$(document).on('click', '.settlebtncls, .viewsettlecls', function() {
		$("html, body").animate({ scrollTop: 0 }, "slow");
		$('#tableDiv1').show();
		var info = dataTable1.page.info();
		$('#dlvNameCls').html('');
		$('#dId').val('');
		$('#lastSettleDateCls').html('');
		$('#lastSettleAmountCls').html('');
		$('#pAmount').html('');
		$('#amountPaid').val('');
		
		$('.srchMainCls').hide();
		$('.contentMainCls').show();
		
		var dId = $(this).attr('did');
		var currData = tblDataArr[dId];
		historyTblData = currData.settlementDetailsDtos;
		taxTblData = currData.taxationDetailsDtos;

		var pAmount = parseFloat(currData.pendingAmount);
		pendAmount = pAmount;
		if($(this).hasClass('viewsettlecls')) {
			$('.amntPaidCls').hide();
			$('#settlebtn').hide();
		} else {
			if(!isNaN(pAmount) && pAmount > 0) {
				$('.amntPaidCls').show();
				$('#settlebtn').show();
			} else {
				$('.amntPaidCls').hide();
				$('#settlebtn').hide();
			}
		}
		
		$('#dId').val(dId);
		$('#dlvNameCls').html(currData.delivererName);
		$('#lastSettleDateCls').html(currData.lastSettledDate != '' ? currData.lastSettledDate : "NA");
		$('#lastSettleAmountCls').html(currData.lastSettledAmount);
		$('#pAmount').html(currData.pendingAmount);
		$('#tableDiv2').html('');
		buildHistoryTable(historyTblData);
		buildTaxTable(taxTblData);
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
		$('#tableDiv1').show();
		$('#tableDiv2').show();
		$('#dlvNameCls').html('');
		$('#dId').val('');
		$('#lastSettleDateCls').html('');
		$('#lastSettleAmountCls').html('');
		$('#pAmount').html('');
		$('#amountPaid').val('');
		$('.contentMainCls').show();
		
		var cflg = false;
		
		historyTblData = currData.settlementDetailsDtos;
		taxTblData = currData.taxationDetailsDtos;

		var pAmount = parseFloat(currData.pendingAmount);
		pendAmount = pAmount;
		if($(this).hasClass('viewsettlecls')) {
			$('.amntPaidCls').hide();
			$('#settlebtn').hide();
		} else {
			if(!isNaN(pAmount) && pAmount > 0) {
				$('.amntPaidCls').show();
				$('#settlebtn').show();
			} else {
				$('.amntPaidCls').hide();
				$('#settlebtn').hide();
			}
		}
		var dId = currData.delivererId;
		$('#dId').val(dId);
		$('#dlvNameCls').html(currData.delivererName);
		$('#totDelivFrm').val(taxTblData.length);
		$('#totDelvHdr').html(taxTblData.length);
		$('#totAmntFrm').html(currData.pendingAmount);
		$('#amountPaid').val(currData.pendingAmount);
		
		$('#lastSettleDateCls').html(currData.lastSettledDate != '' ? currData.lastSettledDate : "NA");
		$('#lastSettleAmountCls').html(currData.lastSettledAmount);
		$('#pAmount').html(currData.pendingAmount);
		$('#tableDiv2').html('');
		
		var totDelvAmntHdr = 0;
		var totItemAmntHdr = 0;
		var totAmntHdr = 0;
		for (var i = 0; i < taxTblData.length; i++) {
			var taxTblDataObj = taxTblData[i];
			if(taxTblDataObj.senderRequestModel.codFlag == true && taxTblDataObj.deliveryChargeIncluGst != '' && 
					taxTblDataObj.deliveryChargeIncluGst != 'undefined' && 
					taxTblDataObj.deliveryChargeIncluGst != undefined) {
				totDelvAmntHdr += parseFloat(taxTblDataObj.deliveryChargeIncluGst);
			}
			
			if(taxTblDataObj.senderRequestModel.itemPayAmount != '' && 
					taxTblDataObj.senderRequestModel.itemPayAmount != 'undefined' && 
					taxTblDataObj.senderRequestModel.itemPayAmount != undefined) {
				totItemAmntHdr += parseFloat(taxTblDataObj.senderRequestModel.itemPayAmount);
			}
		}
		totAmntHdr = totDelvAmntHdr + totItemAmntHdr;
		$('#totDelvAmntHdr').html(Number.isInteger(totDelvAmntHdr)? totDelvAmntHdr : totDelvAmntHdr.toFixed(2));
		$('#totItemAmntHdr').html(Number.isInteger(totItemAmntHdr)? totItemAmntHdr : totItemAmntHdr.toFixed(2));
		$('#totAmntHdr').html(Number.isInteger(currData.pendingAmount)? currData.pendingAmount : currData.pendingAmount.toFixed(2));
		
		buildHistoryTable(historyTblData);
		buildTaxTable(taxTblData);
		
		if($("#billingCycle").find('option:selected').attr('cflg') == 'true') {
			$('#paidOn').val('');
			$('#refNo').val('');
			$('#payRemarks').val('');
			
			if(historyTblData.length > 0) {
				var settlementDetails = historyTblData[historyTblData.length - 1];
				$('#paidOn').val(settlementDetails.paidOn);
				$('#refNo').val(settlementDetails.refNo);
				$('#payRemarks').val(settlementDetails.payRemarks);
			}
			
			$('#paidOn').attr('disabled', 'disabled');
			$('#refNo').attr('disabled', 'disabled');
			$('#payRemarks').attr('disabled', 'disabled');
			
			$('#settlebtn').hide();
			
			cflg = true;
			$('#payFlag').val('false');
		} else {
			$('#paidOn').val('');
			$('#refNo').val('');
			$('#payRemarks').val('');
			
			$('#paidOn').removeAttr('disabled');
			$('#refNo').removeAttr('disabled');
			$('#payRemarks').removeAttr('disabled');
			
			$('#settlebtn').show();
			
			cflg = false;
			$('#payFlag').val('true');
		}
		
		$('#tableDiv1').hide();
		$('#tableDiv2').hide();
		
		if(cflg != true) {
			if($('#payFlag').val() == 'true') {
				$('#billingCycle').find('option').each(function(index, elem) {
					var frmDate = $(elem).attr('fromDate');
					var cflg1 = $(elem).attr('cflg');
					if(frmDate != undefined && cflg1 != undefined && cflg1 != 'true') {
						if(Date.parse(frmDate) < Date.parse(fromDate)) {
							$('.payFormCls').hide();
							//$('#settlebtn').addClass('saveDisableBtn');
							$('#settlebtn').hide();
							$('.prevBillErrCls').show();
							alert('Complete previous billing payment(s)');
							return false;
						} else {
							$('.payFormCls').show();
							//$('#settlebtn').removeClass('saveDisableBtn');
							$('#settlebtn').show();
							$('.prevBillErrCls').hide();
						}
					}
				});
			} else {
				$('.payFormCls').hide();
				$('.saveTempBtn').hide();
			}
		} else {
			var amountPaid = parseFloat($("#amountPaid").val());
			if(amountPaid > 0) {
				$('.payFormCls').show();
			} else {
				$('.payFormCls').hide();
			}
			$('.saveTempBtn').hide();
			$('.saveInvBtn').hide();
			
			var invoiceDtVar = $('#invoiceDtHdn').val();
			var invoiceNmVar = $('#invoiceNmHdn').val();
			
			$('#invoiceDt').removeAttr('disabled');
			$('#invoiceNm').removeAttr('disabled');
			if(invoiceDtVar != '') $('#invoiceDt').attr('disabled', 'disabled');
			if(invoiceNmVar != '') $('#invoiceNm').attr('disabled', 'disabled');
			
			if(invoiceDtVar != '' || invoiceNmVar != '') {
				$('.saveInvBtn').addClass('saveDisableBtn');
			}
			
			var userRole = $('#roleNmFrm').val();
			if(userRole == 'ROLE_VENDOR') {
				if(invoiceDtVar != '' && invoiceNmVar != '') {
					$('.generatePDF').show();
				}
				$('.invFormCls').show();
				$('.saveInvBtn').show();
			} else if(userRole == 'ROLE_DELIVER') {
				$('.generatePDF').hide();
				$('.invFormCls').hide();
				$('.saveInvBtn').hide();
			}
			$('.prevBillErrCls').hide();
		}
	}
	
	function buildDataTable(tblData){
		tblDataArr = [];
		var headers = "";
		var body ="";
		headers += "<tr role='row'>";
		headers +="<th style='text-align: center;'>Deliverer Name</th>";
		headers +="<th style='text-align: center;'>Last Settled Amount</th>";
		headers +="<th style='text-align: center;'>Last Settled Date</th>";
		headers +="<th style='width: 84px;text-align: center;'>Pending Amount To Pay</th>";
		headers +="<th style='text-align: center;'>Action</th>";
		headers += "</tr>";
		
		for (var i = 0; i < tblData.length; i++) {
			var reqObj = tblData[i];
			tblDataArr[reqObj.delivererId] = reqObj;
			body += "<tr role='row'>";
			body += "<td>"+reqObj.delivererName+"</td>";
			body += "<td>"+reqObj.lastSettledAmount+"</td>";
			body += "<td>"+(reqObj.lastSettledDate != '' ? reqObj.lastSettledDate : "NA")+"</td>";
			body += "<td>"+reqObj.pendingAmount+"</td>";
			
			var pAmount = parseFloat(reqObj.pendingAmount);
			if(!isNaN(pAmount) && pAmount > 0) {
				body += "<td style='text-align: left;'>";
				body += "<span style='float: left;width: 124px;'>";
				body += "<span class='tblcolumnlbl tblActionCls settlebtncls' style='height: 20px;font-size: 0.7rem;' dId='"+reqObj.delivererId+"'>Settle Now</span>";
				body += "</span>";
				body += "</td>"
			} else {
				body+="<td style='text-align: left;'><span class='tblcolumnlbl tblActionCls viewsettlecls' style='height: 20px;font-size: 0.7rem;background: #808080;' dId='"+reqObj.delivererId+"'>View</span></td>"
			}
			body += "</tr>";
		}
		$("#tableDiv")
		.append(
				"<table width='80%' class='table table-striped table-bordered dataTable no-footer' id='tableId'><thead>"
						+ headers
						+ "</thead><tbody>"
						+ body
						+ "</tbody></table>");
		dataTable1 = $('#tableId').DataTable({
		"autoWidth": false,
		"oLanguage" : {
			"sEmptyTable" : "No Data Available"
		},
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
		"pageLength" : 5,
		"order" : [ [ 4, "desc" ] ],
		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
		
		dataTable1.on('draw', function () {
			var body = $(dataTable1.table().body());
			body.unhighlight();
			body.highlight(dataTable1.search());  
		});
		
	}
	
	function prefixPattern(val, maxNum, prefixVal) {
		if(maxNum > val.length) {
			for(var i = 0; i < (maxNum - val.length); i++) {
				val = prefixVal + val;
			}
		}
		return val;
	}
	
	function buildTaxTable(data) {
		if(data!=null){
			loadDelvTableList(data, 3, '#deliveryDtlsTbl');
			$('.generateDivCls').show();
			$('.dateCls').show();
			$('.generateExcel').show();
		}
	}
	
	function loadUserList() {
		$("#userNameSrchSel").html('');
		var pendingFlag = false;
		if($('#billCyclePend').val() == '1') {
			pendingFlag = true;
		}
		$.ajax({
			url : $("#contextPath").val()+'/adm/userDetailsByRoleToGetAmount?roleName=' + $('#rad_roleSelect_cls').val() + '&location=' + $('#locSelCls').val() + '&pendingFlag=' + pendingFlag,
			type : 'POST',
			success:function(data){
				$("#userNameSrchSel").removeAttr('disabled');
				if(data.length > 0) {
					var opt="<option value=''>Select One</option>";
					$.each(data,function(i,val){
						if($('#rad_roleSelect_cls').val() == 'ROLE_VENDOR')
							opt+="<option value='"+val.id+"'>"+val.vendorGroupName+"</option>";
						if($('#rad_roleSelect_cls').val() == 'ROLE_DELIVER') {
							if(val.role == 'ROLE_ADMIN')
								opt+="<option value='"+val.id+"'>"+val.firstName + " - ADMIN (" + val.mobileNumber +")"+"</option>";
							else
								opt+="<option value='"+val.id+"'>"+val.firstName + " (" + val.mobileNumber +")"+"</option>";
						}
					});
					$("#userNameSrchSel").append(opt);
				} else {
					$("#userNameSrchSel").append("<option value=''>No User</option>");
					$("#userNameSrchSel").attr('disabled', 'disabled');
				}
				
				$("#userNameSrchSel").chosen();
				$('#userNameSrchSel').trigger("chosen:updated");
				$("#userNameSrchSel").trigger('change');
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
		        alert("Status: " + textStatus);
		    }
		});
	}
	
	function buildHistoryTable(tblData1) {
		var headers = "";
		headers += "<tr role='row'>";
		headers +="<th style='text-align: center;'>S.No.</th>";
		headers +="<th style='text-align: center;'>Settled Date</th>";
		headers +="<th style='text-align: center;'>Settled Amount</th>";
		headers +="<th style='width: 84px;text-align: center;'>Received By</th>";
		headers += "</tr>";
		
		body="";
		for (var i = 0; i < tblData1.length; i++) {
			var reqObj = tblData1[i];
			body += "<tr role='row'>";
			body += "<td>"+(i+1)+"</td>";
			body += "<td>"+reqObj.createdDate.split("T")[0]+"</td>";
			body += "<td>"+reqObj.settledAmount+"</td>";
			body += "<td>"+reqObj.receivedUser.firstName+"</td>";
			body += "</tr>";
		}
		
		$("#tableDiv2")
		.append(
				"<table width='80%' class='table table-striped table-bordered dataTable no-footer' id='tableId1'><thead>"
						+ headers
						+ "</thead><tbody>"
						+ body
						+ "</tbody></table>");
		dataTable2 = $('#tableId1').DataTable({
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 1, "desc" ] ],
			"bLengthChange" : true,
			"bInfo" : true,
			"bProcessing" : true,
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
			"pageLength" : 5,
			"order" : [ [ 0, "asc" ] ],
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
			});
		dataTable2.on('draw', function () {
			var body = $(dataTable2.table().body());
			body.unhighlight();
			body.highlight(dataTable2.search());  
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
						<span>Settlement To Vedagram</span>
					</h5>
					<div class="row">
						<div class="col-md-12 mr-auto formcls" style="margin-top: 20px;">
							<div class="row">
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
										<option value="">All Location</option>
										<c:forEach items="${allowedLocation}" var="allowedLoc">
											<option value="${allowedLoc}">${allowedLoc}</option>
										</c:forEach>
									</select>
								</div>
								
								<div class="col-md-3 form-group" style="display: none;">
									<label for="pickdrop" class="hdrLblCls">Role Name</label><br> 
									<select id="rad_roleSelect_cls">
										<!-- <option value="ROLE_VENDOR">Vendor</option> -->
										<option value="ROLE_DELIVER">Deliverer</option>
									</select>
								</div>
								
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls nameLblCls required-label">Deliverer Name</label><br> 
									<select id="userNameSrchSel"></select>
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
					
					<!-- <div class="row formcls">
						<div class="col-md-12 form-group">
							<table class="defTbl" style="width: auto;">
								<tr>
									<td style="width: 20%;">
										<label for="pickdrop" class="hdrLblCls">Total Deliveries</label><br> 
										<label id="totDelivFrm"></label>
									</td>
									<td style="width: 20%;">
										<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totAmntLbl">Total Amount</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
										<label id="totAmntFrm"></label>
									</td>
								</tr>
							</table>
						</div>
						<div class="col-md-12"></div>
					</div> -->
					
					<div class="row">
						<div class="col-md-12 mr-auto">
							<div class="row formcls">
								<div class="col-md-12 form-group">
									<table class="defTbl" style="">
										<tr>
											<td style="width: 180px;">
												<label for="pickdrop" class="hdrLblCls">Total Deliveries</label><br> 
												<label id="totDelvHdr">0</label>
											</td>
											<td style="display: none;">
												<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totAmntLbl">Total Delivery Amount (COD)</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
												<label id="totDelvAmntHdr">0</label>
											</td>
											<td style="display: none;">
												<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totGstLbl">Total Package Amount (COD)</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
												<label id="totItemAmntHdr">0</label>
											</td>
											<td style="width: 180px;">
												<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totServChrgLbl">Total Amount</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
												<label id="totAmntHdr">0</label>
											</td>
											<td style="display: none;">
												<label for="pickdrop" class="hdrLblCls">Already Paid Amount (<span class="fa fa-inr inrCls"></span>)</label><br> 
												<label id="oldPaidAmntFrm"></label>
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
									<div class="row formcls payFormCls" style="margin-bottom: 10px;">
										<div class="col-md-3 form-group">
											<label for="pickdrop" class="hdrLblCls">Amount Received</label><br> 
											<input type="text" id="amountPaid" disabled="disabled">
										</div>
										<div class="col-md-3 form-group" style="display: none;">
											<label for="pickdrop" class="hdrLblCls">Total Deliveries</label><br>
											<input type="text" id="totDelivFrm" disabled="disabled">
										</div>
										<div class="col-md-3 form-group">
											<label for="pickdrop" class="hdrLblCls required-label">Paid On</label><br> 
											<input type="text" id="paidOn">
										</div>
										<div class="col-md-3 form-group">
											<label for="pickdrop" class="hdrLblCls">Payment Reference No.</label><br> 
											<input type="text" id="refNo">
										</div>
										<div class="col-md-3 form-group">
											<label for="pickdrop" class="hdrLblCls">Payment Remarks</label><br>
											<input type="text" id="payRemarks">
<!-- 											<textarea id="payRemarks" rows="50" style="width: 100%"></textarea> -->
										</div>
										
										<!-- <div class="col-md-3 amntPaidCls">
											<label class="hdrCls required-label">Amount Received From Deliverer</label><br> 
											<input type="text" id="amountPaid" disabled="disabled">
										</div> -->
									</div>
									
									<div class="prevBillErrCls">Complete previous billing payment(s)</div>
									<button class="btn btn-primary" id="settlebtn">Settle Now</button>
									<button class="btn btn-primary" id="cancelbtn" style="margin-right: 20px;">Cancel</button>
									
									<button class="btn btn-primary delvHistoryCls" style="background: #ffffff;border-color: #007bff;color: #007bff;">View Deliveries</button>
									<button class="btn btn-primary generateExcel" style="display: none; background: #ffffff;border-color: #007bff;color: #007bff;">
										<span class="fa fa-file-excel-o btn-icon"></span> Download Deliveries
									</button>
									
									<input type="hidden" id="payFlag">
								</div>
								
								<div class="col-md-12 form-group" style="margin-top: 20px; margin-bottom: 0px;">
									<div class="row">
										<div class="col-md-12">
											<!-- <div class="" style="margin-top: 10px;margin-bottom: 10px;">
												<span class="delvHistoryCls" style="text-decoration: underline;color: blue;cursor: pointer;">View All Deliveries
													<span class="fa fa-angle-down"></span>
												</span>
											</div> -->
											
											<div id="tableDiv1" class="" style="width: 100%;">
												<table id="deliveryDtlsTbl" class="table table-striped table-bordered dataTable no-footer"></table>
											</div>
											
										</div>
											
										<div class="col-md-12" style="display: none;">
											<div class="" style="margin-top: 10px;margin-bottom: 10px;">
												<span class="showHistoryCls" style="text-decoration: underline;color: blue;cursor: pointer;">Settlement History 
													<span class="fa fa-angle-down"></span>
												</span>
											</div>
											<div id="tableDiv2" class=""></div>
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
	
	
<!-- <div class="" role="document">
	<div class="modal-content" style="border:none">
		<div class="loadCls"></div>
		<div class="modal-header">
			<h5 class="font-weight-bold col-12 modal-title text-center">Settlement Details</h5>
		</div>
		<div class="modal-body formcls">
			<div id="loginPageerrormsg"></div>
		

			<div class="ddiv">
				<div class="form-group">
					<label>Deliverer Name</label> <input type="text" class="form-control1"
						required="required" id="dname">
				</div>
				<div class="modal-footer" style="padding-right: 0px;">
					<button type="button" class="btn btn-primary" id="viewbtn">View</button>
				</div>
			</div>

		</div>

		<div id="tableDiv" class="col-md-12 mr-auto" style="margin-top: 20px;"></div>
	</div>
</div> -->
</body>
</html>