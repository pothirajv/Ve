<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/delvtbl.js"></script>

<style>
#billCycleFrm {
    padding: 10px;
    width: 253px;
    border: 1px solid #007bff;
    border-radius: 4px;
    margin-bottom: 30px;
    cursor: pointer;
    color: #007bff;
    text-align: center;
    font-size: 10px;
}

.defTbl td {
	border: 1px solid #d8d8d8;
    padding: 10px;
	color: #007bff;
}

.saveDisableBtn {
    background: #cecbcb;
    border-color: #cecbcb;
    cursor: default !important;
}

.saveDisableBtn:hover {
	background: #cecbcb !important;
	border-color: #cecbcb !important;
}

.prevBillErrCls {
    color: red;
    font-size: 12px;
    margin-bottom: 10px;
}

</style>

<script type="text/javascript">
var selMonth;
var selYear;
var searchData;
$(document).ready(function(){
	$("html, body").animate({ scrollTop: 0 }, "slow");
	loadUserList();
	
	$("#from_date_id").datepicker({
		dateFormat: 'yy-mm-dd',
		maxDate: new Date()
	});
	
	$("#to_date_id").datepicker({
		dateFormat: 'yy-mm-dd',
		maxDate: new Date()
	});
	
	$("#from_date_id").change(function() {
		$("#to_date_id").datepicker("option", "minDate", $(this).val());
		$("#to_date_id").datepicker("option", "maxDate", new Date());
	});
	
	$("#to_date_id").change(function() {
		$("#from_date_id").datepicker("option", "maxDate", $(this).val());
	});
	
	$(".mnth_datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'MM yy',
        onClose: function(dateText, inst) {
        	selMonth = inst.selectedMonth;
        	selYear = inst.selectedYear;
            $(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1)).trigger('change');
        }	
	});
	
	$(".mnth_datepicker").focus(function () {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });
    });
	
	$(".mnth_datepicker").change(function() {
		$('#weekSel').html('');
		if($(this).val() != '') {
			var year = selYear;
			var month = selMonth;
			month++;
			var noOfWeek = weekCount(year, month);
			
			var firstOfMonth = new Date(year, month-1, 1);
			var lastOfMonth = new Date(year, month, 0);
			var lastDate = lastOfMonth.getDate();
			var dayOfWeek = firstOfMonth.getDay();
			
			var daysArr = [];
			var daysInWeek = 6 - dayOfWeek;
			var startDay = 1;
			var nextDay = startDay + daysInWeek;
			daysArr[0] = year + "-" + month + "-" + prefixPattern(startDay, 2, "0") + ":" + year + "-" + month + "-" + prefixPattern(nextDay, 2, "0")
			for (var i = 1; i <= (noOfWeek-1); i++) {
				startDay = nextDay + 1;
				nextDay = (nextDay + 7 <= lastDate) ? nextDay + 7 : lastDate;
				daysArr[i] = year + "-" + month + "-" + prefixPattern(startDay, 2, "0") + ":" + year + "-" + month + "-" + prefixPattern(nextDay, 2, "0")
			}
			
			var htmlVar = '<option value="0">All Weeks</option>';
			for (var i = 1; i <= noOfWeek; i++) {
				var startEndDayArr = daysArr[i-1].split(':');
				var startDay = startEndDayArr[0];
				var endDay = startEndDayArr[1];
				htmlVar += '<option value="'+i+'" startday="'+startDay+'" endday="'+endDay+'">Week ' + i + ' ('+ startDay + ' To ' + endDay +')</option>';
			}
			$('#weekSel').html(htmlVar);
			$('.weekSelCls').show();
		} else {
			$('.weekSelCls').hide();
		}
	});
	
	$('#locSelCls').change(function() {
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
	
	$(document.body).on('click', '.generateExcel', function() {
		if(searchData != null && searchData != undefined && searchData.length > 0) {
			var newForm = jQuery('<form>', { 'action': $("#contextPath").val()+'/adm/generateTaxReportExcel', 'target': '_top', 'method': 'post' });
			for (var i = 0; i < searchData.length; i++) {
				var obj = searchData[i];
				newForm.append(jQuery('<input>', { 'name': 'taxIds', 'value': obj.id, 'type': 'hidden' }));
			}
			newForm.append(jQuery('<input>', { 'name': 'reportFor', 'value': 6, 'type': 'hidden' }));
			newForm.appendTo('body').submit();
		} else {
			alert('No details to download');
			return false;
		}
	});
	
	$(".rad_periodSelect_cls").click(function(){
		if($(this).val()=="d") {
			$(".dateSearch").attr("disabled",false);
			$(".monthSearch").attr("disabled",true);
			$(".monthSearch").val("");
			$(".weekSelCls").hide();
			
			$(".dateSearch").addClass('required');
			$(".monthSearch").removeClass('required');
			
			$('.periodMonthLblCls').removeClass('required-label');
			$('.periodDayLblCls').addClass('required-label');
		} else if($(this).val()=="m") {
			$(".dateSearch").attr("disabled",true);
			$(".monthSearch").attr("disabled",false);
			$(".dateSearch").val("");
			
			$(".monthSearch").addClass('required');
			$(".dateSearch").removeClass('required');
			
			$('.periodDayLblCls').removeClass('required-label');
			$('.periodMonthLblCls').addClass('required-label');
		}
	});
	
	$('#admin_search').click(function() {
		$('.validation').html('');
		var flag = true;
		$(".required").each(
			function(index) {
				if ($(this).val() === null || $(this).val() === "") {
					$(this).parent().find("div").addClass("showVal");
					$(this).parent().find("div").html("This field is mandatory");
					flag = false;
				} else {
					$(this).parent().find("div").removeClass("showVal");
					$(this).parent().find("div").html("");
				}
			}
		);
		
		if (flag == false) {
			return false;
		} else {
			var location = $("#locSelCls").val();
			var roleName = $("#rad_roleSelect_cls").val();
			var userId = $("#userNameSrchSel").val();
			
			getAllTaxDetails(location, roleName, userId);
		}
	});
});

function getAllTaxDetails(location, roleName, userId){
	if(location == undefined || location == '' || location == null) {
		location = "";
	}
	if(userId == undefined || userId == '' || userId == null) {
		userId = "";
	}
	
	var searchFromdate, searchTodate;
	if($("input[name='periodSelect']:checked").val()=="d"){
		 searchFromdate =$("#from_date_id").val();
		 searchTodate =$("#to_date_id").val();
	} else {
		if($(".mnth_datepicker").val() != '') {
			if($('#weekSel').val() != '0') {
				searchFromdate = $('#weekSel').find('option:selected').attr('startday');
				searchTodate = $('#weekSel').find('option:selected').attr('endday');
			} else {
				var date,month,year;
				var selectDate = new Date($(".mnth_datepicker").val());

				month = selectDate.getMonth();
				year = selectDate.getFullYear();

				firstDay = new Date(year, month, 1);
				lastDay = new Date(year, month + 1, 0);

				date = firstDay.getDate();
				month = firstDay.getMonth()+1;
				year =  firstDay.getFullYear();
		 
				searchFromdate = year + '-' + month + '-' + date;

				date = lastDay.getDate();
				month = lastDay.getMonth()+1;
				year =  lastDay.getFullYear();
		 
				searchTodate = year + '-' + month + '-' + date;
			}
		} else {
			searchFromdate = '';
			searchTodate = '';
		}
	}
	
	$('.totPdMarginAmntCls').html('0');
	var url = $("#contextPath").val()+"/adm/getAllTaxDetails?location="+location+"&roleName="+roleName+"&userId="+userId.toString()+'&searchFromdate='+searchFromdate+'&searchTodate='+searchTodate;
	$.ajax({
		url : url,
		type : 'POST',
		success:function(data){
			searchData = data;
			
			var totPdMargin = 0;
			for (var i = 0; i < data.length; i++) {
				var obj = data[i];
				totPdMargin += obj.pdMargin;
			}
			$('.totPdMarginAmntCls').html(Math.ceil(totPdMargin));
			
			loadDelvTableList(data, 6, '#deliveryDtlsTbl')
			$('.mainContentCls').show();
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
			
}

function loadUserList() {
	$("#userNameSrchSel").html('');
	$.ajax({
		url : $("#contextPath").val()+'/adm/userDetailsByRoleToPayAmount?roleName=' + $('#rad_roleSelect_cls').val() + '&location=' + $('#locSelCls').val() + '&pendingFlag=false',
		type : 'POST',
		success:function(data){
			var opt="<option value=''>All</option>";
			$.each(data,function(i,val){
				if($('#rad_roleSelect_cls').val() == 'ROLE_VENDOR')
					opt+="<option value='"+val.id+"'>"+val.vendorGroupName + "(" + val.vendorName +")</option>";
				if($('#rad_roleSelect_cls').val() == 'ROLE_DELIVER') {
					if(val.role == 'ROLE_ADMIN')
						opt+="<option value='"+val.id+"'>"+val.firstName + " - ADMIN (" + val.mobileNumber +")"+"</option>";
					else
						opt+="<option value='"+val.id+"'>"+val.firstName + " (" + val.mobileNumber +")"+"</option>";
				}
			});
			$("#userNameSrchSel").append(opt);
			
			$("#userNameSrchSel").chosen();
			$('#userNameSrchSel').trigger("chosen:updated");
			$("#userNameSrchSel").trigger('change');
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

var weekCount = function(year, month_number) {
    var firstOfMonth = new Date(year, month_number - 1, 1);
    var day = firstOfMonth.getDay() || 6;
    day = day === 1 ? 0 : day;
    if (day) { day-- }
    var diff = 7 - day;
    var lastOfMonth = new Date(year, month_number, 0);
    var lastDate = lastOfMonth.getDate();
    if (lastOfMonth.getDay() === 1) {
        diff--;
    }
    var result = Math.ceil((lastDate - diff) / 7);
    return result + 1;
};

function prefixPattern(val, maxNum, prefixVal) {
	if(maxNum > val.toString().length) {
		for(var i = 0; i < (maxNum - val.toString().length); i++) {
			val = prefixVal + val;
		}
	}
	return val;
}

</script>

</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
			<div class="container">
				<div class="srchMainCls">
					<div class="row formcls srchCls" style="margin-top: 20px;">
						<div class="col-md-12 mr-auto">
							<h5 class="font-weight-bold">
								<span>Settlement To Vendor/Deliverer</span>
							</h5>
						</div>
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="row">
								<div class="col-md-6" style="">
									<div class="row">
										<div class="col-md-12">
											<div class="radio">
												<input id="radio-1" type="radio" name="periodSelect" class="rad_periodSelect_cls" value="d" checked="checked">
												<label for="radio-1" class="radio-label hdrLblCls">Search By Date</label>
											</div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodDayLblCls hdrLblCls required-label">From</label><br> 
											<input type="text" class="dateSearch required" id="from_date_id" placeholder="Ex. YYYY-MM-DD" autocomplete="off"> 
											<div class="validation"></div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodDayLblCls hdrLblCls required-label">To Date</label><br> 
											<input type="text" class="dateSearch required" id="to_date_id" placeholder="Ex. YYYY-MM-DD" autocomplete="off">
											<div class="validation"></div>
										</div>
									</div>
								</div>
								
								<div class="col-md-6" style="">
									<div class="row">
										<div class="col-md-12">
											<div class="radio">
												<input id="radio-2" type="radio" name="periodSelect" class="rad_periodSelect_cls" value="m">
												<label for="radio-2" class="radio-label hdrLblCls">Search By Month / Week</label>
											</div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodMonthLblCls hdrLblCls">Month</label><br> 
											<input name="startDate" id="startDate" class="mnth_datepicker monthSearch" placeholder="Ex. May 2020" disabled autocomplete="off">
											<div class="validation"></div>
										</div>
										<div class="col-md-6 form-group weekSelCls" style="display: none;">
											<label for="pickdrop" class="periodDayLblCls hdrLblCls">Week</label><br> 
											<select name="weekSel" id="weekSel" class="monthSearch" disabled>
												<option value="0">All Weeks</option>
											</select>
										</div>
									</div>
								</div>
								
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls">Location</label><br> 
									<select id="locSelCls">
										<option value="">All Location</option>
										<c:forEach items="${allowedLocation}" var="allowedLoc">
											<option value="${allowedLoc}">${allowedLoc}</option>
										</c:forEach>
									</select>
								</div>
								
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls">Role Name</label><br> 
									<select id="rad_roleSelect_cls">
										<option value="ROLE_VENDOR">Vendor</option>
										<option value="ROLE_DELIVER">Deliverer</option>
									</select>
								</div>
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls nameLblCls">Vendor Name</label><br> 
									<select id="userNameSrchSel"></select>
								</div>

								<div class="col-md-12"></div>
			
								<div class="col-md-12">
									<button class="btn btn-primary" id="admin_search">
										<span class="fa fa-search btn-icon"></span> Search</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class="mainContentCls" style="margin-top: 30px; display: none;">
						<div class="row">
							<div class="col-md-12 table-responsive" >
								<h6 style="font-weight: bold;">Delivery Details</h6>
								
								<div style="float: left;width: 100%;margin-top: 10px;">
									<div style="float: left;background: #fdfdfd;padding: 10px;width: 200px;border-radius: 4px;border: 1px solid #E91E63;color: #E91E63;">
										<label class="hdrLblCls">Total Margin</label><br>
										<label class="totPdMarginCls"><span class="fa fa-inr"></span><span class="totPdMarginAmntCls">0</span></label>
									</div>
								</div>
								<div class="col-md-12">&nbsp;</div>
								<table id="deliveryDtlsTbl"
									class="table table-striped table-bordered dataTable no-footer">
								</table>
							</div>
							<div class="col-md-12 table-responsive" style="margin-top: 10px;">
								<button class="btn btn-primary generateExcel" style="float: right;">
									<span class="fa fa-file-excel-o btn-icon"></span> Download
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			</section>
		</div>

	</div>

	<input type="hidden" id="currFromDate">
	<input type="hidden" id="currToDate">
	<input type="hidden" id="receivedUserId">
</body>
</html>