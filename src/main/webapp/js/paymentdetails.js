var searchListData = [];
var searchData;
var currDate;
var totAmntToPay;
var alreadyPaidAmount;
var remainingAmount;
var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
$(document).ready(function(){
	
	$("html, body").animate({ scrollTop: 0 }, "slow");
	loadUserList();
	$('#locSelCls').change(function() {
		loadUserList();
	});
	
	$('#billCyclePend').change(function() {
		loadUserList();
	});
	
	$("#userNameSrchSel").change(function() {
		$('#branchSrchSel').html('');
		var userName = $(this).val();
		if($('.branchRowCls[businessName="'+userName+'"]').find('.branchCls').length > 0) {
			var opt="",headid="";
			if(userName != '') {
				$('.branchRowCls[businessName="'+userName+'"]').find('.branchCls').each(function(index, elem) {
					if(index == 0 || $(elem).attr('hflag') == true) {
						headid = $(elem).attr('id');
					}
					opt+="<option value='"+$(elem).attr('id')+"'>"+$(elem).val()+"</option>";
				});
			}
			var opt1="<option value='"+headid+"' allFlg='true'>All Branch</option>";
			opt = opt1 + opt;
			$('#branchSrchSel').html(opt);
			$('#branchSrchSel').removeAttr('disabled');
		} else {
			var opt="<option value=''>No Branch</option>";
			$('#branchSrchSel').html(opt);
			$('#branchSrchSel').attr('disabled', 'disabled');
		}
		
		$('#branchSrchSel').trigger('change');
	});
	
	$("#branchSrchSel").change(function() {
		$("#billingCycle").html('');
		$("#billingCycle").attr('disabled', 'disabled');
		
		var pendingFlag = false;
		if($('#billCyclePend').val() == '1') {
			pendingFlag = true;
		}
		var userId = $(this).val();
		var allFlg = $(this).find('option:selected').attr('allFlg');
		var vendorGrpName = '';
		if(allFlg == true || allFlg == 'true') {
			userId = '';
			vendorGrpName = $('#userNameSrchSel').val();
		}
		
		var userRole = $('#rad_roleSelect_cls').val();
		
		$.ajax({
			url : $("#contextPath").val()+'/adm/getBillingCycleToPaySettlementToVendor',
			type : 'POST',
			data : {userRole : userRole, userId: userId, pendingFlag: pendingFlag, vendorGrpName: vendorGrpName },
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
							opt += '<option cflg="false" style="background: #ffffff;" fromDate="'+val.fromDate+'" toDate="'+val.toDate+'" billId="'+val.ids+'" userId="'+userId+'" billidx="'+i+'" compflag="'+val.payCompleteFlag+'" value="'+val.ids+'">'+billingCycleVar + addTxt + '</option>';
						} else {
							addTxt = ' (Completed)';
							opt += '<option cflg="true" style="background: #ffffff;" fromDate="'+val.fromDate+'" toDate="'+val.toDate+'" billId="'+val.ids+'" userId="'+userId+'" billidx="'+i+'" compflag="'+val.payCompleteFlag+'" value="'+val.ids+'">'+billingCycleVar + addTxt + '</option>';
						}
					});
					$("#billingCycle").append(opt);
				} else {
					$("#billingCycle").append("<option value=''>No Billing Cycle</option>");
					$("#billingCycle").trigger('change');
				}
				
//				$("#billingCycle").chosen();
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
	
	$("#paidOn").datepicker({
		dateFormat: 'yy-mm-dd',
		maxDate: new Date()
	});
	
	$(document).on('click', '.showHistoryCls', function() {
		if($('#tableDiv2').is(':visible')) {
			$('#tableDiv2').slideUp();
		} else {
			$('#tableDiv2').slideDown();
		}
	});
	
	$(document).on('click', '.showDelvTblCls', function() {
		if($('#tableDiv1').is(':visible')) {
			$('#tableDiv1').slideUp();
		} else {
			$('#tableDiv1').slideDown();
			$('html, body').animate({
		        scrollTop: $("#tableDiv1").offset().top - 50
		    }, 1000);
		}
	});
	
	$(document).on('click', '.saveBtn', function() {
		if(!$(this).hasClass('saveDisableBtn')) {
			savePaymentDetails();
		}
	});
	
	$(document).on('click', '.saveInvBtn', function() {
		if(!$(this).hasClass('saveDisableBtn')) {
			saveInvoiceDetails();
		}
	});
	
	$(".dateSearch").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	$('#rad_roleSelect_cls').change(function() {
		if($(this).val() == 'ROLE_VENDOR') {
			$('.nameLblCls').html('Vendor Name');
		} else {
			$('.nameLblCls').html('Deliverer Name');
		}
		
		loadUserList();
	});
	
	$(".rad_periodSelect_cls").click(function(){
		if($(this).val()=="d") {
			$(".dateSearch").attr("disabled",false);
			$(".monthSearch").attr("disabled",true);
			$(".monthSearch").val("");
			
			$(".dateSearch").removeClass('required');
			$(".monthSearch").removeClass('required');
			
			$('.periodMonthLblCls').removeClass('required-label');
			$('.periodDayLblCls').removeClass('required-label');
		} else if($(this).val()=="m") {
			$(".dateSearch").attr("disabled",true);
			$(".monthSearch").attr("disabled",false);
			$(".dateSearch").val("");
			
			$(".monthSearch").removeClass('required');
			$(".dateSearch").removeClass('required');
			
			$('.periodDayLblCls').removeClass('required-label');
			$('.periodMonthLblCls').removeClass('required-label');
		}
	});
	
	$('.cancelbtn').click(function(){
		$('.mainContentCls1').hide();
//		$('.srchMainCls').show();
		$('#billingCycle').val('');
		$("html, body").animate({ scrollTop: 0 }, "slow");
	});
	
	$('#admin_search').click(function(){
		$('.loadCmnCls').show();
		$('#tableDiv1').show();
		$('#tableDiv2').show();
		$('.generateExcel').hide();
		$('.mainContentCls').hide();
		
		searchData = null;
		var userRole = $('#rad_roleSelect_cls').val();
		var userId = $('#branchSrchSel').val();
		var memberBillingCycleId = $('#billingCycle').val();
		
		if(memberBillingCycleId == '') {
			alert('Please Select Billing Cycle');
			$('.loadCmnCls').hide();
			return false;
		}
		
		searchListData = [];
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getTaxDetailsForBillingCycleId",
			data : {userRole : userRole, userId: userId, memberBillingCycleId: memberBillingCycleId },
			success : function(json){
				if(json != null){
					loadBillingInfo(json);
				}
				$('.loadCmnCls').hide();
			}
		});
		
	});
	
	$('#billingCycle').change(function() {
		searchBillingInfo();
	});
	
	function searchBillingInfo() {
		$('.loadCmnCls').show();
		$('#tableDiv1').show();
		$('#tableDiv2').show();
		$('.generateExcel').hide();
		$('.mainContentCls').hide();
		
		searchData = null;
		var userRole = $('#rad_roleSelect_cls').val();
		var userId = $('#branchSrchSel').val();
		var memberBillingCycleId = $('#billingCycle').val();
		
		if(memberBillingCycleId == '') {
//			alert('Please Select Billing Cycle');
			$('.loadCmnCls').hide();
			$('.cancelbtn').trigger('click');
			return false;
		}
		
		searchListData = [];
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getTaxDetailsForBillingCycleId",
			data : {userRole : userRole, userId: userId, memberBillingCycleId: memberBillingCycleId },
			success : function(json){
				if(json != null){
					loadBillingInfo(json);
				}
				$('.loadCmnCls').hide();
			}
		});
	}
	
	$('#admin_search1').click(function(){
		$('.loadCmnCls').show();
		$('#payHistryTbl').show();
		$('.generateExcel').hide();
		$('.mainContentCls').hide();
		
		searchData = null;
		var searchFromdate, searchTodate;
		if($("input[name='periodSelect']:checked").val()=="d"){
			 searchFromdate =$("#from_date_id").val();
			 searchTodate =$("#to_date_id").val();
		} else {
			if($(".mnth_datepicker").val() != '') {
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
			} else {
				searchFromdate = '';
				searchTodate = '';
			}
		}
		
		var userRole = $('#rad_roleSelect_cls').val();
		var userId = $('#branchSrchSel').val();
		var billingCycle = $('#billingCycle').val();
		var pendingBill = $('#billCyclePend').val();
		
		currDate = new Date();
		
		var firstDay = new Date(currDate.getFullYear(), currDate.getMonth(), 1).getDate();
		var lastDay = new Date(currDate.getFullYear(), currDate.getMonth() + 1, 0).getDate();
		var currMonth = currDate.getMonth() + 1;
		currMonth = prefixPattern(currMonth+"", 2, "0");
		
		if(billingCycle == 1) {
			searchFromdate = currDate.getFullYear() + "-" + currMonth + "-" + prefixPattern(firstDay+"", 2, "0");
			searchTodate = currDate.getFullYear() + "-" + currMonth + "-" + "10";
		} else if(billingCycle == 2) {
			searchFromdate = currDate.getFullYear() + "-" + currMonth + "-" + "11";
			searchTodate = currDate.getFullYear() + "-" + currMonth + "-" + "20";
		} else if(billingCycle == 3) {
			searchFromdate = currDate.getFullYear() + "-" + currMonth + "-" + "21";
			searchTodate = currDate.getFullYear() + "-" + currMonth + "-" + prefixPattern(lastDay+"", 2, "0");
		}
		
		$('#currFromDate').val(searchFromdate);
		$('#currToDate').val(searchTodate);
		
		searchListData = [];
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getTaxDetails",
			data : {userRole : userRole, userId: userId, searchFromdate: searchFromdate, searchTodate: searchTodate, pendingBill: pendingBill },
		  success : function(json){
			  $('.mainContentCls').show();
			  $("html, body").animate({ scrollTop: 0 }, "slow");
			  
			  if(json != null){
				 for (var i = 0; i < json.length; i++) {
					 var obj = json[i];
					 searchListData[obj.receivedUserModel.id] = obj;
				}
				 
				loadMainTableList(json);
			  }
			  $('.loadCmnCls').hide();
		  },
			
		});
		
	});
	
	$(document.body).on('click', '.viewdelivercls', function() {
		
		if ($(".actionCls").is(":checked")){
		
		$('.addrsDtlsCls').html('');
		
		var data	= deliveryDtlsTbl.row($('.actionCls:checked').parents('tr')).data();
	    console.log(data);
	    
	    var city = data.userModel.city;
	    var vendorGroupName = data.userModel.vendorGroupName;
	    
	    var userAddress = '<div>';
	    
	    userAddress += '<span>' + (data.userModel.address != null ? data.userModel.address : '') + '</span>';
	    userAddress += '<a class="tblTelLblCls" href="tel:'+data.userModel.mobileNumber+'">Tel: ' + data.userModel.mobileNumber + '</a>';
	    userAddress += '</div>';
	    $('.addrsDtlsCls').html(userAddress);
	    
	    
	    var bankDetails = '<div class="row">';
	    bankDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Bank Name</div><div class="delvSubHdrValCls col-md-6">' + ((data.userModel.bankAccountNumber != null && data.userModel.bankAccountNumber != '') ? data.userModel.bankAccountNumber : '0123')+ '</div></div>';
	    bankDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Bank Name</div><div class="delvSubHdrValCls col-md-6">' + ((data.userModel.bankName != null && data.userModel.bankName != '') ? data.userModel.bankName : 'State Bank')+ '</div></div>';
	    bankDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Bank Branch Name</div><div class="delvSubHdrValCls col-md-6">' + ((data.bankBranchname != null && data.bankBranchname != '') ? data.bankBranchname : 'Sholinganallur')+ '</div></div>';
	    bankDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Bank Name</div><div class="delvSubHdrValCls col-md-6">' + ((data.userModel.ifscCode != null && data.userModel.ifscCode != '') ? data.userModel.ifscCode : 'SBINO0123')+ '</div></div>';
	    
	    bankDetails += '</div>';
	    $('.bankDtlsCls').html(bankDetails);
	    
	    $('#userModal').modal('show');
		}else{
			alert("Please Select One User")
		}
	});
	
	$(document.body).on('click', '.generateExcel', function() {
		if(searchData != null && searchData != undefined && searchData.length > 0) {
			var newForm = jQuery('<form>', { 'action': $("#contextPath").val()+'/adm/generateTaxReportExcel', 'target': '_top', 'method': 'post' });
			for (var i = 0; i < searchData.length; i++) {
				var obj = searchData[i];
				newForm.append(jQuery('<input>', { 'name': 'taxIds', 'value': obj.id, 'type': 'hidden' }));
			}
			
			var userRole = $('#roleNmFrm').val();
			var employeeFlag = $('#employeeFlag').val();
			if(userRole == 'ROLE_VENDOR') {
				newForm.append(jQuery('<input>', { 'name': 'reportFor', 'value': 1, 'type': 'hidden' }));
			} else if(userRole == 'ROLE_DELIVER') {
				if(employeeFlag == 'true') {
					newForm.append(jQuery('<input>', { 'name': 'reportFor', 'value': 5, 'type': 'hidden' }));
				} else {
					newForm.append(jQuery('<input>', { 'name': 'reportFor', 'value': 4, 'type': 'hidden' }));
				}
			}
			newForm.appendTo('body').submit();
		} else {
			alert('No details to download');
			return false;
		}
	});
	
	$(document.body).on('click', '.generatePDF', function() {
		var fromDate = $('#billingCycle').find('option:selected').attr('fromdate');
		var toDate = $('#billingCycle').find('option:selected').attr('todate');
		var userId = $('#billingCycle').find('option:selected').attr('userId');
		var userRole = $('#rad_roleSelect_cls').val();
		var memBillId = $('#billingCycle').find('option:selected').attr('billId');
		
		var optLen = $('#billingCycle').find('option').length;
		if(memBillId == '' && optLen > 0) {
			$('#billingCycle').find('option').each(function(index, elem) {
				memBillId += $(elem).attr('value');
				if((index+1) < optLen) {
					memBillId += ',';
				}
			});
		}
		
		if(fromDate == "" || toDate == ""){
			alert("Select From Date and To Date");
			return false;
		}
		
		/*if(userRole == "" || userId == "") {
			alert("Invalid Input");
			return false;
		}*/
		
		downloadReportUrl = $("#contextPath").val()+"/adm/generatePDF?userId="+userId+"&memBillId="+memBillId;
		window.open(downloadReportUrl, '_blank');
	});
	
	$(document.body).on('change', '#billCycleFrm', function() {
		var userId = $(this).find('option:selected').attr('userId');
		var billidx = $(this).find('option:selected').attr('billidx');
		var billId = $(this).find('option:selected').attr('billId');
		var fromDate = $(this).find('option:selected').attr('fromDate');
		var currIdx = $(this).find('option:selected').index();
		var cflg = $(this).find('option:selected').attr('cflg');
		
		loadBillingInfo(userId, billidx, billId, fromDate, cflg);
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

function loadBillingCycle() {
	$('#billingCycle').html("");
	var firstDay = new Date(currDate.getFullYear(), currDate.getMonth(), 1).getDate();
	var lastDay = new Date(currDate.getFullYear(), currDate.getMonth() + 1, 0).getDate();
	var currMonth = months[currDate.getMonth()];
	
	searchFromdate = firstDay + "st " + currMonth;
	searchTodate = "10th " + currMonth;
	$('#billingCycle').append('<option value="1">' + searchFromdate + ' - ' + searchTodate + '</option>');
	
	searchFromdate = "11th " + currMonth;
	searchTodate = "20th " + currMonth;
	$('#billingCycle').append('<option value="2">' + searchFromdate + ' - ' + searchTodate + '</option>');

	searchFromdate = "21st " + currMonth;
	searchTodate = (lastDay == 31 ? lastDay + "st" : lastDay + "th") + " " + currMonth;
	$('#billingCycle').append('<option value="3">' + searchFromdate + ' - ' + searchTodate + '</option>');
}

function loadUserList() {
	$("#userNameSrchSel").html('');
	var pendingFlag = false;
	if($('#billCyclePend').val() == '1') {
		pendingFlag = true;
	}
	
	$('#branchMainCls').html('');
	$.ajax({
		url : $("#contextPath").val()+'/adm/userDetailsByRoleToPayAmount?roleName=' + $('#rad_roleSelect_cls').val() + '&location=' + $('#locSelCls').val() + '&pendingFlag=' + pendingFlag,
		type : 'POST',
		success:function(data){
			$("#userNameSrchSel").removeAttr('disabled');
			if(data.length > 0) {
				var opt="<option value=''>Select One</option>";
				$.each(data,function(i,val){
					if($('#rad_roleSelect_cls').val() == 'ROLE_VENDOR') {
//						opt+="<option value='"+val.id+"'>"+val.vendorGroupName + "(" + val.vendorName +")</option>";
						var htmlVar = '<input type="hidden" id="'+val.id+'" value="'+val.vendorName+'" hflag="'+val.hoFlag+'" class="branchCls">';
						
						if($('.branchRowCls[businessName="'+val.vendorGroupName+'"]').length > 0) {
							$('.branchRowCls[businessName="'+val.vendorGroupName+'"]').append(htmlVar);
						} else {
							$('#branchMainCls').append('<div class="branchRowCls" businessName="'+val.vendorGroupName+'">' + htmlVar + '</div>');
						}
					}
				});
				
				$('.branchRowCls').each(function(index, elem) {
					opt+="<option value='"+$(elem).attr('businessName')+"'>"+$(elem).attr('businessName')+"</option>";
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

function saveInvoiceDetails() {
	
	var invoiceDtHdn = $('#invoiceDtHdn').val();
	var invoiceNmHdn = $('#invoiceNmHdn').val();
	
	if(invoiceDtHdn != '' && invoiceDtHdn != 'undefined' && invoiceDtHdn != null 
			&& invoiceNmHdn != '' && invoiceNmHdn != 'undefined' && invoiceNmHdn != null) {
		alert('Invoice details already stored');
		return false;
	}
	
	var invoiceDt = $('#invoiceDt').val();
	var invoiceNm = $('#invoiceNm').val();
	var memberBillingCycleId = $('#billCycleFrm').val();
	
	if(invoiceDt == null || invoiceDt == '' || invoiceNm == null || invoiceNm == '') {
		alert('Please fill invoice mandatory fields');
		return false;
	}
	
	var memberBillingCycleDto = new Object();
	memberBillingCycleDto.invoiceDate = invoiceDt;
	memberBillingCycleDto.invoiceNum = invoiceNm;
	memberBillingCycleDto.id = memberBillingCycleId;
	
	$.ajax({
		url : $("#contextPath").val()+'/adm/saveInvoiceDetails',
		contentType : "application/json",
		type : 'POST',
		data : JSON.stringify(memberBillingCycleDto),
		success:function(data){
			if(data == true) {
				$('#invoiceDtHdn').val(invoiceDt);
				$('#invoiceNmHdn').val(invoiceNm);
				$('#invoiceDt').attr('disabled', 'disabled');
				$('#invoiceNm').attr('disabled', 'disabled');
				
				var userId = $('#billCycleFrm').find('option:selected').attr('userId');
				var billidx = $('#billCycleFrm').find('option:selected').attr('billidx');
				searchListData[userId].compMemberBillingCycleDtos[billidx].invoiceNum = invoiceNm;
				searchListData[userId].compMemberBillingCycleDtos[billidx].invoiceDate = invoiceDt;
				$('.saveInvBtn').addClass('saveDisableBtn');
				$('.generatePDF').show();
				alert('Invoice Details Stored Successfully');
			} else {
				alert('Problem in storing invoice details');
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function savePaymentDetails() {
	var paymentType = $('#paymentType').val();
	var paidOn = $('#paidOn').val();
	var paidAmount = $('#paidAmnt').val();
	var refNo = $('#refNo').val();
	var payRemarks = $('#payRemarks').val();
	var memberBillingCycleId = $('#billingCycle').val();
	var invoiceDt = $('#invoiceDt1').val();
	var invoiceNm = $('#invoiceNm1').val();
	
	var errMsg = '';
	var errFlag = false;
	if(paidOn == null || paidOn.trim() == '') {
		errFlag = true;
	}
	if(invoiceDt == null || invoiceDt.trim() == '' || invoiceNm == null || invoiceNm.trim() == '') {
		errFlag = true;
	}
	if(paidAmount == null || paidAmount.trim() == '') {
		errFlag = true;
	} else {
		paidAmount = parseFloat(paidAmount);
		if(isNaN(parseFloat(paidAmount))) {
			errFlag = true;
			errMsg = 'Paid amount should be numeric only';
		} else if(paidAmount == 0) {
			errFlag = true;
			errMsg = 'Paid amount should be greater than 0';
		}
		
		if(remainingAmount < 0) {
			if(paidAmount > (remainingAmount * -1)) {
				errMsg = 'Paid amount greater than pending amount. Do you want to proceed?';
			}
		} else {
			if(paidAmount > remainingAmount) {
				errMsg = 'Paid amount greater than pending amount. Do you want to proceed?';
			}
		}
	}
	
	if(refNo == null || refNo.trim() == '') {
		errFlag = true;
	}
	
	if(errFlag == true) {
		if(errMsg != '') {
			alert(errMsg);
		} else {
			alert('Please fill mandatory fields');
		}
		return false;
	}
	
	if(errMsg != '') {
		if(!confirm(errMsg)) {
			return false;
		}
	}
		
	var paymentDetailsDto = new Object();
	paymentDetailsDto.fromDate = $('#currFromDate').val();
	paymentDetailsDto.toDate = $('#currToDate').val();
	paymentDetailsDto.receivedUserId = $('#branchSrchSel').val();
	paymentDetailsDto.paymentType = paymentType;
	paymentDetailsDto.paidOn = paidOn;
	paymentDetailsDto.paidAmount = paidAmount;
	paymentDetailsDto.refNo = refNo;
	paymentDetailsDto.payRemarks = payRemarks;
	paymentDetailsDto.memberBillingCycleId = memberBillingCycleId;
	paymentDetailsDto.invoiceDate = invoiceDt;
	paymentDetailsDto.invoiceNum = invoiceNm;
	
	$('.loadCmnCls').show();
	$.ajax({
		url : $("#contextPath").val()+'/adm/savePaymentDetails',
		contentType : "application/json",
		type : 'POST',
		data : JSON.stringify(paymentDetailsDto),
		success:function(data){
			$("html, body").animate({ scrollTop: 0 }, "slow");

			if($('#billCyclePend').val() == '2') {
				$('#billingCycle').find('option:selected').attr('cflg', 'true');
				$('#billingCycle').find('option:selected').attr('compflag', 'true');
				var selOpt = $('#billingCycle').find('option:selected').html();
				$('#billingCycle').find('option:selected').html(selOpt.replace('Pending', 'Completed'));
			} else {
				$('#billingCycle').find('option:selected').remove();
			}
			
			$('.cancelbtn').trigger('click');
			alert('Payment Details Stored Successfully');
			$('.loadCmnCls').hide();
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function loadSettlementDetails(userId, payFlag) {
	$("html, body").animate({ scrollTop: 0 }, "slow");
	$('#payFlag').val(payFlag);
	$('#receivedUserId').val(userId);
	searchData = null;
	var obj = searchListData[userId];
//	$('.srchMainCls').hide();
	$('.mainContentCls1').show();
	
	var roleName = "";
	if(obj.receivedUserModel.role == 'ROLE_VENDOR') {
		roleName = "Vendor";
	} else if(obj.receivedUserModel.role == 'ROLE_DELIVER') {
		roleName = "Deliverer";
	}
	var userName = obj.receivedUserModel.firstName;
	var vendorGroupName = obj.receivedUserModel.vendorGroupName;
	var vendorName = obj.receivedUserModel.vendorName;
	
	var pendingBillingCnt = obj.pendingBillingCnt;
	var completedBillingCnt = obj.completedBillingCnt;
	var pendingBillingAmnt = obj.pendingBillingAmnt;
	var completedBillingAmnt = obj.completedBillingAmnt;
	
	var pendMemberBillingCycleDtos = obj.pendMemberBillingCycleDtos;
	var compMemberBillingCycleDtos = obj.compMemberBillingCycleDtos;
	
	var optHtmlVar = '';
	for (var i = 0; i < pendMemberBillingCycleDtos.length; i++) {
		var pendMemberBillingCycleDto = pendMemberBillingCycleDtos[i];
		var billingCycleVar = pendMemberBillingCycleDto.fromDate + " To " + pendMemberBillingCycleDto.toDate;
		var addTxt = '';
		if(pendMemberBillingCycleDto.payCompleteFlag != true) addTxt = ' - [Pending]';
		optHtmlVar += '<option cflg="false" style="color:red;background: #ffffff;" fromDate="'+pendMemberBillingCycleDto.fromDate+'" toDate="'+pendMemberBillingCycleDto.toDate+'" billId="'+pendMemberBillingCycleDto.id+'" userId="'+userId+'" billidx="'+i+'" compflag="'+pendMemberBillingCycleDto.payCompleteFlag+'" value="'+pendMemberBillingCycleDto.id+'">'+billingCycleVar + addTxt + '</option>';
	}
	
	if($('#billCyclePend').val() == "2") {
		for (var i = 0; i < compMemberBillingCycleDtos.length; i++) {
			var compMemberBillingCycleDto = compMemberBillingCycleDtos[i];
			var billingCycleVar = compMemberBillingCycleDto.fromDate + " To " + compMemberBillingCycleDto.toDate;
			var addTxt = '';
			if(compMemberBillingCycleDto.payCompleteFlag != true) addTxt = ' - [Pending]';
			optHtmlVar += '<option cflg="true" style="color:green;background: #ffffff;" fromDate="'+compMemberBillingCycleDto.fromDate+'" toDate="'+compMemberBillingCycleDto.toDate+'" billId="'+compMemberBillingCycleDto.id+'" userId="'+userId+'" billidx="'+i+'" compflag="'+compMemberBillingCycleDto.payCompleteFlag+'" value="'+compMemberBillingCycleDto.id+'">'+billingCycleVar + addTxt + '</option>';
		}
	}
	
	$('#roleNameFrm').html(roleName);
	$('#roleNmFrm').val(obj.receivedUserModel.role);
	$('#employeeFlag').val(obj.receivedUserModel.employee);
	
	if(obj.receivedUserModel.role == 'ROLE_VENDOR') {
		$('#userNameFrm').html(vendorGroupName);
	} else if(obj.receivedUserModel.role == 'ROLE_DELIVER') {
		$('#userNameFrm').html(userName);
	}
	$('#billCycleFrm').html(optHtmlVar).trigger('change');
	
//	$("#billCycleFrm").selectmenu();
}

function loadBillingInfo(memberBillingCycleDto) {
	var fromDate = $('#billingCycle').find('option:selected').attr('fromDate');
	$('#payFlag').val('true');
	$('#invoiceDt1').datepicker({
		dateFormat: 'yy-mm-dd',
		maxDate: new Date()
	});
	$('.mainContentCls1').show();
	
	var userRole = $('#rad_roleSelect_cls').val();
	var data = memberBillingCycleDto.taxationDetailsDtos;
	var data1 = memberBillingCycleDto.paymentDetailsDtos;
	searchData = data;
	var cflg = false;
	
	var userName = memberBillingCycleDto.receivedUserModel.firstName;
	var vendorGroupName = memberBillingCycleDto.receivedUserModel.vendorGroupName + " (" + memberBillingCycleDto.receivedUserModel.vendorName + ")";
	var vendorName = memberBillingCycleDto.receivedUserModel.vendorName;
	if(userRole == 'ROLE_VENDOR') {
		$('#roleNameFrm').html("Vendor");
		$('#userNameFrm').html(vendorGroupName);
	} else if(userRole == 'ROLE_DELIVER') {
		$('#roleNameFrm').html("Deliverer");
		$('#userNameFrm').html(userName);
	}
	
	$('#roleNmFrm').val(memberBillingCycleDto.receivedUserModel.role);
	$('#employeeFlag').val(memberBillingCycleDto.receivedUserModel.employee);
	
	if(memberBillingCycleDto.payCompleteFlag == true) {
		$('.payFormCls').hide();
		$('.saveBtn').hide();
		cflg = true;
	} else {
		$('.payFormCls').show();
		$('.saveBtn').show();
		cflg = false;
	}
	
	loadVmanagementDataTbl(data, userRole);
	loadPayHistryTbl(data1);
	
	if($("#billingCycle").find('option:selected').attr('cflg') == 'true') {
		$('#paidOn').val('');
		$('#refNo').val('');
		$('#payRemarks').val('');
		$('#paymentType').val('1');
		$('#invoiceDt1').val('');
		$('#invoiceNm1').val('');
		
		if(data1.length > 0) {
			var paymentDetails = data1[data1.length - 1];
			$('#paidOn').val(paymentDetails.paidOn);
			$('#refNo').val(paymentDetails.refNo);
			$('#payRemarks').val(paymentDetails.payRemarks);
			$('#paymentType').val(paymentDetails.paymentType);
			$('#invoiceDt1').val(memberBillingCycleDto.invoiceDate);
			$('#invoiceNm1').val(memberBillingCycleDto.invoiceNum);
		}
		
		$('#paidOn').attr('disabled', 'disabled');
		$('#refNo').attr('disabled', 'disabled');
		$('#payRemarks').attr('disabled', 'disabled');
		$('#paymentType').attr('disabled', 'disabled');
		$('#invoiceDt1').attr('disabled', 'disabled');
		$('#invoiceNm1').attr('disabled', 'disabled');
		
		$('.saveBtn').hide();
	} else {
		$('#paidOn').val('');
		$('#refNo').val('');
		$('#payRemarks').val('');
		$('#paymentType').val('1');
		$('#invoiceDt1').val('');
		$('#invoiceNm1').val('');
		
		$('#paidOn').removeAttr('disabled');
		$('#refNo').removeAttr('disabled');
		$('#payRemarks').removeAttr('disabled');
		$('#paymentType').removeAttr('disabled');
		$('#invoiceDt1').removeAttr('disabled');
		$('#invoiceNm1').removeAttr('disabled');
		
		$('.saveBtn').show();
	}
	
	var totAmnt = parseInt($('#totAmntFrmHdn').val());
	if(totAmnt >= 0) {
		$('.amntPaidReceiveCls').html('Amount Settled');
		$('#paymentType').val('1');
	} else {
		$('.amntPaidReceiveCls').html('Amount Collected');
		$('#paymentType').val('2');
	}
	
	if ($.fn.DataTable.isDataTable('#payHistryTbl') ) {
		$("#payHistryTbl").DataTable().destroy();
	  	$("#payHistryTbl").empty();
	}
	
	$('.showHistoryCls').trigger('click');
	$('.showDelvTblCls').trigger('click');
	
	$('#invoiceDtHdn').val(memberBillingCycleDto.invoiceDate);
	$('#invoiceNmHdn').val(memberBillingCycleDto.invoiceNum);
	$('#invoiceDt').val(memberBillingCycleDto.invoiceDate);
	$('#invoiceNm').val(memberBillingCycleDto.invoiceNum);
	
	$('.generateExcel').show();
	
	$('.payFormCls').show();
	$('.saveTempBtn').show();
	$('.prevBillErrCls').hide();
	$('.generatePDF').hide();
	$('.invFormCls').hide();
	$('.saveInvBtn').hide();
	$('.saveInvBtn').removeClass('saveDisableBtn');
	
	if(cflg != true) {
		if($('#payFlag').val() == 'true') {
			$('#billingCycle').find('option').each(function(index, elem) {
				var frmDate = $(elem).attr('fromDate');
				var cflg1 = $(elem).attr('cflg');
				if(frmDate != undefined && cflg1 != undefined && cflg1 != 'true') {
					if(Date.parse(frmDate) < Date.parse(fromDate)) {
						$('.payFormCls').hide();
						$('.saveTempBtn').addClass('saveDisableBtn');
						$('.saveBtn').hide();
						$('.prevBillErrCls').show();
						alert('Complete previous billing payment(s)');
						return false;
					} else {
						$('.payFormCls').show();
						$('.saveTempBtn').removeClass('saveDisableBtn');
						$('.saveBtn').show();
						$('.prevBillErrCls').hide();
					}
				}
			});
		} else {
			$('.payFormCls').hide();
			$('.saveTempBtn').hide();
		}
	} else {
		var amountPaid = parseFloat($("#paidAmnt").val());
		if(amountPaid > 0) {
			$('.payFormCls').show();
			$('.generatePDF').show();
		} else {
			$('.payFormCls').hide();
		}
		
		/*$('.payFormCls').hide();
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
		}*/
	}
}

function loadBillingInfo1(userId, billidx, billId, fromDate, cflg) {
	$('#invoiceDt1').datepicker({
		dateFormat: 'yy-mm-dd',
		maxDate: new Date()
	});
	
	var obj = searchListData[userId];
	var pendingBillingCnt = obj.pendingBillingCnt;
	var completedBillingCnt = obj.completedBillingCnt;
	var pendingBillingAmnt = obj.pendingBillingAmnt;
	var completedBillingAmnt = obj.completedBillingAmnt;
	
	var memberBillingCycleDto;
	if(cflg == 'true') {
		memberBillingCycleDto = obj.compMemberBillingCycleDtos[billidx];
	} else {
		memberBillingCycleDto = obj.pendMemberBillingCycleDtos[billidx];
	}
	
	var data = memberBillingCycleDto.taxationDetailsDtos;
	var data1 = memberBillingCycleDto.paymentDetailsDtos;
	searchData = data;
	
	if(memberBillingCycleDto.payCompleteFlag == true) {
		$('.payFormCls').hide();
		$('.saveBtn').hide();
	} else {
		$('.payFormCls').show();
		$('.saveBtn').show();
	}
	
	loadVmanagementDataTbl(data, obj.receivedUserModel.role);
	loadPayHistryTbl(data1);
	
	$('#invoiceDtHdn').val(memberBillingCycleDto.invoiceDate);
	$('#invoiceNmHdn').val(memberBillingCycleDto.invoiceNum);
	$('#invoiceDt').val(memberBillingCycleDto.invoiceDate);
	$('#invoiceNm').val(memberBillingCycleDto.invoiceNum);
	
	$('.generateExcel').show();
	
	$('.payFormCls').show();
	$('.saveTempBtn').show();
	$('.prevBillErrCls').hide();
	$('.generatePDF').hide();
	$('.invFormCls').hide();
	$('.saveInvBtn').hide();
	$('.saveInvBtn').removeClass('saveDisableBtn');
	
	if(cflg != 'true') {
		if($('#payFlag').val() == 'true') {
			$('#billCycleFrm').find('option').each(function(index, elem) {
				var frmDate = $(elem).attr('fromDate');
				var cflg1 = $(elem).attr('cflg');
				if(cflg1 != 'true') {
					if(Date.parse(frmDate) < Date.parse(fromDate)) {
						$('.payFormCls').hide();
						$('.saveTempBtn').addClass('saveDisableBtn');
						$('.prevBillErrCls').show();
						return false;
					} else {
						$('.payFormCls').show();
						$('.saveTempBtn').removeClass('saveDisableBtn');
						$('.prevBillErrCls').hide();
					}
				}
			});
		} else {
			$('.payFormCls').hide();
			$('.saveTempBtn').hide();
		}
	} else {
		$('.payFormCls').hide();
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
	}
}

function loadMainTableList(data){
	if ($.fn.DataTable.isDataTable('#mainListTbl') ) {
		$("#mainListTbl").DataTable().destroy();
	  	$("#mainListTbl").empty();
	}
	
	var userTbl ="";
	userTbl ='<thead><tr>';
	userTbl += '<th>S.No.</th>';
	userTbl += '<th>Role Name</th>';
	userTbl += '<th>Receiver Name</th>';
	userTbl += '<th>No. Of Completed Cycle</th>';
	userTbl += '<th>Total Amount Settled</th>';
	userTbl += '<th>No. Of Pending Cycle</th>';
	userTbl += '<th>Total Amount To Settle</th>';
	userTbl += '<th></th>';
	userTbl += '</tr></thead>';
		 
	$('#mainListTbl').append(userTbl);
	
	mainListTbl = $("#mainListTbl").DataTable({
		"data" : data,
		"autoWidth": false,
		"oLanguage" : {
			"sEmptyTable" : "No Data Available"
		},
		"order" : [ [ 0, "asc" ] ],
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
		"columns" : [{
			"data" : "",
			"render" : function(data, type, row, meta) {
				var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
				if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
			}
		},{
			"data" : "receivedUserModel",
			"render" : function(data, type, row) {
				var roleName = '';
				var role = data.role;
				if(role == "ROLE_VENDOR") roleName = "Vendor";
				if(role == "ROLE_DELIVER") roleName = "Deliverer";
			    if(type === "sort" || type === "type") return roleName;
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + roleName + "</span>";
			}
		},{
			"data" : "receivedUserModel",
			"render" : function(data, type, row) {
				var userName = "";
				if(data.role == "ROLE_VENDOR") userName = data.vendorGroupName;
				if(data.role == "ROLE_DELIVER") userName = data.firstName;
				
			    if(type === "sort" || type === "type") return userName;
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + userName + "</span>";
			}
		},{
			"data" : "completedBillingCnt",
		},{
			"data" : "completedBillingAmnt",
		},{
			"data" : "pendingBillingCnt",
		},{
			"data" : "pendingBillingAmnt",
		},{
			"data" : "receivedUserModel",
			"render" : function(data, type, row) {
				var userId = data.id;
			    if(type === "sort" || type === "type") return "";
			    if(row.pendingBillingAmnt > 0) {
			    	var htmlVar = "<span style='float:left;width: 113px;'>";
			    	htmlVar += "<span class='tblcolumnlbl tblActionCls settlebtncls viewcls' style='height: 20px;font-size: 0.7rem;background: #808080;float:left;margin-right: 10px;' onclick='return loadSettlementDetails(\""+userId+"\", false);' dId='"+userId+"'>View</span>";
			    	htmlVar += "<span class='tblcolumnlbl tblActionCls settlebtncls paycls' style='height: 20px;font-size: 0.7rem;float:left;' onclick='return loadSettlementDetails(\""+userId+"\", true);' dId='"+userId+"'>Pay Now</span>";
			    	htmlVar += "</span>";
			    	return htmlVar;
			    } else {
			    	return "<span class='tblcolumnlbl tblActionCls settlebtncls viewcls' style='height: 20px;font-size: 0.7rem;margin-right: 10px;background: #808080;' onclick='return loadSettlementDetails(\""+userId+"\", false);' dId='"+userId+"'>View</span>";
			    }
			}
		}],
		"pageLength" : 5,
		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
	});
	
	mainListTbl.on('draw', function () {
		var body = $(mainListTbl.table().body());
		body.unhighlight();
		body.highlight(mainListTbl.search());  
	});
}

function loadVmanagementDataTbl(data, userRole){
	
	if(data != null && data != undefined){
		$('#totDelivFrm').html(data.length); 
	} else {
		$('#totDelivFrm').html(0);
	}
  
	var totAmntToDelv = 0;
	var totAmntToVend = 0;
	var totGst = 0;
	var totServChrg = 0;
	if(data != null && data != undefined){
		for (var i = 0; i < data.length; i++) {
			totAmntToVend += data[i].vendorCreditAmount - data[i].vendorDebitAmount;
			totAmntToDelv += data[i].riderCommission + data[i].riderTravelAllowance;
			
			totGst += data[i].deliveryGst + data[i].cardServChrgGst + data[i].cardServChrgGst;
			totServChrg += data[i].deliveryChargeExcluGst + data[i].cardServChrgExclGst + data[i].purchaseCommisExclGst;
		}
	}
	
	var totAmntHdr = 0;
	var totDelvHdr = 0;
	var totItemAmntHdr = 0;
	var totDelvChargeHdr = 0;
	var totCardChargeHdr = 0;
	var totPurcCommHdr = 0;
	var totChargeHdr = 0;
	if(data != null && data != undefined){
		totDelvHdr = data.length;
		for (var i = 0; i < data.length; i++) {
			var taxTblDataObj = data[i];
			
			if(taxTblDataObj.senderRequestModel.itemPayAmount != '' && 
					taxTblDataObj.senderRequestModel.itemPayAmount != 'undefined' && 
					taxTblDataObj.senderRequestModel.itemPayAmount != undefined) {
				totItemAmntHdr += parseFloat(taxTblDataObj.senderRequestModel.itemPayAmount);
			}
			if((taxTblDataObj.senderRequestModel.codFlag == false && taxTblDataObj.senderRequestModel.noPayFlag == true) || 
					taxTblDataObj.senderRequestModel.deliveryChargeInclu == true) {
				totDelvChargeHdr += parseFloat(taxTblDataObj.deliveryChargeIncluGst);
			}
			
			totCardChargeHdr += parseFloat(taxTblDataObj.cardServiceCharges);
			totPurcCommHdr += parseFloat(taxTblDataObj.purchaseCommission);
			totChargeHdr += parseFloat(taxTblDataObj.cardServiceCharges) + parseFloat(taxTblDataObj.purchaseCommission);
		}
	}
	totAmntHdr = totItemAmntHdr - totDelvChargeHdr - totChargeHdr;
	totAmntHdr = Math.ceil(totAmntHdr);
	if(totAmntHdr < 0) {
		totAmntHdr = totAmntHdr * -1;
	}
	
	$('#totDelvHdr').html(Number.isInteger(totDelvHdr)? totDelvHdr : totDelvHdr.toFixed(2));
	$('#totItemAmntHdr').html(Number.isInteger(totItemAmntHdr)? totItemAmntHdr : totItemAmntHdr.toFixed(2));
	$('#totDelvChargeHdr').html(Number.isInteger(totDelvChargeHdr)? totDelvChargeHdr : totDelvChargeHdr.toFixed(2));
	$('#totCardChargeHdr').html(Number.isInteger(totCardChargeHdr)? totCardChargeHdr : totCardChargeHdr.toFixed(2));
	$('#totPurcCommHdr').html(Number.isInteger(totPurcCommHdr)? totPurcCommHdr : totPurcCommHdr.toFixed(2));
	$('#totAmntHdr').html(Number.isInteger(totAmntHdr)? totAmntHdr : totAmntHdr.toFixed(2));
	$('#totChargeHdr').html(Number.isInteger(totChargeHdr)? totChargeHdr : totChargeHdr.toFixed(2));
	
	
	totAmntToVend = Math.ceil(totAmntToVend);
	totAmntToDelv = Math.ceil(totAmntToDelv);
	totGst = Math.ceil(totGst);
	totServChrg = Math.ceil(totServChrg);
	
	$('#totGstFrm').html(totGst);
	$('#totServChrgFrm').html(totServChrg);
	
	if(userRole == 'ROLE_VENDOR') {
		$('#totAmntFrmHdn').val(totAmntToVend);
		
		if(totAmntToVend < 0) {
			$('#totAmntFrm').html(totAmntToVend * -1);
		} else {
			$('#totAmntFrm').html(totAmntToVend);
		}
		totAmntToPay = totAmntToVend;
		
		if(totAmntToPay < 0) {
			$('.totAmntLbl').html('Total Amount To Receive');
			$('#paymentType').val(2);
		} else {
			$('.totAmntLbl').html('Total Amount To Pay');
			$('#paymentType').val(1);
		}
		
		if(isNaN(parseFloat(totAmntToVend)) || parseFloat(totAmntToVend) <= 0) {
			$('.saveBtn').hide();
		} else {
			$('.saveBtn').show();
		}
	} else if(userRole == 'ROLE_DELIVER') {
		$('#totAmntFrm').html(totAmntToDelv);
		totAmntToPay = totAmntToDelv;
		
		if(totAmntToPay < 0) {
			$('.totAmntLbl').html('Total Amount To Receive');
			$('#paymentType').val(2);
		} else {
			$('.totAmntLbl').html('Total Amount To Pay');
			$('#paymentType').val(1);
		}
		
		if(isNaN(parseFloat(totAmntToDelv)) || parseFloat(totAmntToDelv) <= 0) {
			$('.saveBtn').hide();
		} else {
			$('.saveBtn').show();
		}
	}
	remainingAmount = totAmntToPay;
	
	var reportFor = 1;
	var userRole = $('#roleNmFrm').val();
	var employeeFlag = $('#employeeFlag').val();
	if(userRole == 'ROLE_VENDOR') {
		reportFor = 1;
	} else if(userRole == 'ROLE_DELIVER') {
		if(employeeFlag == 'true') {
			reportFor = 5;
		} else {
			reportFor = 4;
		}
	}
	loadDelvTableList(data, reportFor, '#deliveryDtlsTbl');
}

function loadPayHistryTbl(data1){
	
	var oldPaidAmntFrm = 0;
	if(data1 != null && data1 != undefined){
		for (var i = 0; i < data1.length; i++) {
			oldPaidAmntFrm += data1[i].paidAmount;
		}
	}
	$('#oldPaidAmntFrm').html(oldPaidAmntFrm);
	alreadyPaidAmount = oldPaidAmntFrm;
	remainingAmount = remainingAmount - alreadyPaidAmount;
	$('#amntToPay').val(remainingAmount);
	
	var totAmntHdn = parseInt($('#totAmntFrmHdn').val());
	if(totAmntHdn < 0) {
		$('#paidAmnt').val(totAmntHdn * -1);
	} else {
		$('#paidAmnt').val(totAmntHdn);
	}
	
	var userTbl ="";
	userTbl ='<thead><tr>';
	userTbl += '<th>S.No.</th>';
	userTbl += '<th>Payment Type</th>';
	userTbl += '<th>Paid On</th>';
	userTbl += '<th>Paid Amount</th>';
	userTbl += '<th>Reference No.</th>';
	userTbl += '<th>Payment Remarks</th>';
	userTbl += '<th>Payment Done By</th>';
	userTbl += '</tr></thead>';
		 
	$('#payHistryTbl').append(userTbl);
	
	payHistryTbl = $("#payHistryTbl").DataTable({
		
		"data" : data1,
		"autoWidth": false,
		"oLanguage" : {
			"sEmptyTable" : "No Data Available"
		},
		"order" : [ [ 0, "asc" ] ],
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
		
		"columns" : [{
			"data" : "",
			"render" : function(data, type, row, meta) {
				var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
				if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
			}
		},{
			"data" : "paymentType",
			"render" : function(data, type, row) {
				if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    var payType = data == 1 ? "Sent" : "Received";
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + payType + "</span>";
			}
		},{
			"data" : "paidOn",
			"render" : function(data, type, row) {
				if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    var d = new Date(data);
			    var datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
			}
		},{
			"data" : "paidAmount",
		},{
			"data" : "refNo",
		},{
			"data" : "payRemarks",
		},{
			"data" : "paidByUserModel.firstName",
		}],
		"pageLength" : 5,
		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]

	});
	
	payHistryTbl.on('draw', function () {
		var body = $(payHistryTbl.table().body());
		body.unhighlight();
		body.highlight(payHistryTbl.search());  
	});
}