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
var delvReportTbl;
var paymentDetailsData;
var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];

$(document).ready(function() {
	
	$("#fromDateSrch").datepicker({
		dateFormat: 'dd-mm-yy'
	});
	
	$("#toDateSrch").datepicker({
		dateFormat: 'dd-mm-yy'
	});
	
	$("#searchBtn").click(function() {
		searchPaymentDetails();
	});
	
	function searchPaymentDetails() {
		$('.loadCmnCls').show();
		var payStatus = $('#payStatus').val();
		var fromDate = $('#fromDateSrch').val();
		var toDate = $('#toDateSrch').val();
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getPayDetailsList",
			data : {payStatus : payStatus, fromDate: fromDate, toDate: toDate},
			success : function(json){
				if(json != null){
					paymentDetailsData = json;
					loadTransTable(json, payStatus, '#paymentDtlsTbl');
				}
				$('.loadCmnCls').hide();
			}
		});
	}
	
	$('.approveDenyRefund').click(function() {
		var approveFlg = false;
		if($(this).hasClass('approveRefund')) {
			approveFlg = true;
		}
// 		var refundMsg = $('#refundMsg').val();
		var refundMsg = '';
		$('.loadCmnCls').show();
		var payStatus = $('#payStatus').val();
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/refundPaymentForIncompleteTrans",
			data : {refundApproveFlag : approveFlg, refundMsg: refundMsg},
			success : function(json){
				if(json != null){
					alert(json);
				} else {
					alert('Problem in Approve / Deny Refund process');
				}
				$('.loadCmnCls').hide();
			}
		});
	});
	
	function prefixPattern(val, maxNum, prefixVal) {
		if(maxNum > val.length) {
			for(var i = 0; i < (maxNum - val.length); i++) {
				val = prefixVal + val;
			}
		}
		return val;
	}
	
	function loadTransTable(data, payStatus, tblId){
		if ($.fn.DataTable.isDataTable(tblId) ) {
			$(tblId).DataTable().destroy();
		  	$(tblId).empty();
		}
		
		var userTbl ="";
		userTbl ='<thead><tr>';
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Paid On</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
		userTbl += '<th style="min-width: 130px;">Paid Amount</th>';
		userTbl += '<th style="min-width: 130px;">Approve / Deny</th>';
		userTbl += '</tr></thead>';
		$(tblId).append(userTbl);

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
				"data" : "createDate",
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
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == null) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'></span>";
				    } else {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + data.firstName + "</span>";
				    }
				}
			},{
				"data" : "amount"
			},{
				"data" : "payStatus",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(payStatus == 'PAY_INIT') {
				    	var htmlVar = "<input type='button' value='Refund' id='approveRefund' class='approveDenyRefund'>";
				    	htmlVar += "<input type='button' value='Deny' id='denyRefund' class='approveDenyRefund'>";
				    	return htmlVar;
				    } else {
				    	return "";
				    }
				}
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
		
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
									<label for="pickdrop" class="hdrLblCls">Payment Status</label><br> 
									<select id="payStatus">
										<option value="PAY_INIT">Payment Initialized</option>
										<option value="PAY_RES">Payment Completed</option>
									</select>
								</div>
								
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">From Date</label><br> 
									<input type="text" id="fromDateSrch" name="fromDateSrch">
								</div>
								
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">To Date</label><br> 
									<input type="text" id="toDateSrch" name="toDateSrch">
								</div>
							</div>
						</div>
						
						<div class="col-md-12 mr-auto formcls" style="margin-top: 20px;">
							<div class="row">
								<div class="col-md-2 form-group">
									<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="container contentMainCls" style="margin-top: 10px;">
					<div class="row">
						<div class="col-md-12 mr-auto">
							<div class="row" style="margin-top: 20px;">
								<div class="col-md-12 form-group payFormCls" style="margin-top: 0px; margin-bottom: 0px;">
									<h6 style="font-weight: bold; float: left;">Payment Info</h6>
								</div>
								
								<div class="col-md-12 form-group" style="margin-top: 20px; margin-bottom: 0px;">
									<div class="row">
										<div class="col-md-12">
											<div id="tableDiv1" class="" style="width: 100%;">
												<table id="paymentDtlsTbl" class="table table-striped table-bordered dataTable no-footer"></table>
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
</body>
</html>