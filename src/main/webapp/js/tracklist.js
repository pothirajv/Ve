var availableTags = [];
$(document).ready(function() {
	var btchuplid = getUrlParameter('btchuplid');
	if(btchuplid != null && btchuplid != undefined && btchuplid != null && btchuplid != '') {
		$('#batch_id').val(btchuplid);
	}
	getAllBatchIds();
	getVendorList();
	searchFn();
	datePickFn();
	
	//$("#sender_search").trigger("click");
	$('.branchdivCls').hide();
	
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
	
	$(document.body).on('change', '#sel_vendor_id', function() {
		getVendorBranchList($(this).val());
	});
	
	$(document.body).on('click', '.viewdelivercls', function() {
		$('.pckgDtlsCls').html('');
		var data = senderRequestTbl.row($(this).parents('tr')).data();
	    console.log(data);
	    
	    var codFlag = data.codFlag;
	    var amount = data.amount;
	    
	    var pickupAddress = '<div>';
	    if(data.senderUserModel.vendorGroupName != null && data.senderUserModel.vendorGroupName)
	    	pickupAddress += '<span>' + data.senderUserModel.vendorGroupName + ', ' + '</span>';
	    
	    pickupAddress += '<span>' + (data.packagePickupAddress != null ? data.packagePickupAddress : '') + '</span>';
	    pickupAddress += '</div>';
	    $('.pickDtlsCls').html(pickupAddress);
	    
	    var dropAddress = '<div>';
	    dropAddress += '<span>' + data.recieverName + ', </span>';
	    dropAddress += '<span>' + data.recieverAddress + '.</span>';
	    dropAddress += '<a class="tblTelLblCls" href="tel:'+data.recieverContact+'">Tel: ' + data.recieverContact + '</a>';
	    dropAddress += '</div>';
	    $('.dropDtlsCls').html(dropAddress);
	    
	    var pckgDetails = '<div class="row">';
	    pckgDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Create At</div><div class="delvSubHdrValCls col-md-6">' + data.createdAt + '</div></div>';
	    pckgDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Delivered At</div><div class="delvSubHdrValCls col-md-6">' + ((data.deliveredDate != null && data.deliveredDate != '') ? data.deliveredDate : 'Not Delivered Yet')+ '</div></div>';
	    pckgDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Parcel Type</div><div class="delvSubHdrValCls col-md-6" style="text-transform: capitalize;">' + data.parcelType + '</div></div>';
	    pckgDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Deliverer Name</div><div class="delvSubHdrValCls col-md-6" style="text-transform: capitalize;">' + data.delivererName + '</div></div>';
	    
	    var packageStatus = '';
	    if(data.packageStatus != '') {
			if(data.packageStatus == 'ASSIGNED')packageStatus='Assigned';
			if(data.packageStatus == 'PICKEDUP')packageStatus='Pickedup';
			if(data.packageStatus == 'DELIVERED')packageStatus='Delivered';
			if(data.packageStatus == 'CANCEL')packageStatus='Cancelled';
			if(data.packageStatus == 'RETURN')packageStatus='Return Initiated';
			if(data.packageStatus == 'RETURNED')packageStatus='Returned';
			if(data.packageStatus == 'ACKNOWLEDGED')packageStatus='Acknowledged';
		}
	    pckgDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Package Status</div><div class="delvSubHdrValCls col-md-6">' + packageStatus + '</div></div>';
	    
	    var paymentStatus = 'Payment Gateway';
	    if(data.codFlag == true) {
	    	paymentStatus = 'COD';
	    }
	    pckgDetails += '<div class="delvRowCls col-md-12"><div class="delvSubHdrCls col-md-6">Payment Type</div><div class="delvSubHdrValCls col-md-6">' + paymentStatus + '</div></div>';
	    pckgDetails += '</div>';
	    $('.pckgDtlsCls').html(pckgDetails);
	    
	    $('#delvModal').modal('show');
	});
});

function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
}

var downloadReportUrl = '';
function searchFn(){
	$("#sender_search").click(function(){
		downloadReportUrl = '';
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
			var packageStatus=$("#package_status").val();
			var senderId=$("#sel_vendorBranch_id").val();
			var vendorGroupName=$("#sel_vendor_id").val();
			var batchId=$("#batch_id").val();
			
			//$('#senderdetails').DataTable().destroy();
			senderRequestDataTbl(packageStatus,vendorGroupName,senderId,batchId);
		}
	});
	
	$("#sender_report").click(function(){
		window.location = downloadReportUrl;
	});
}

function getVendorList() {
	$.ajax({
		url : $("#contextPath").val()+'/api/v1/venl',
		type : 'POST',
		success:function(data){
			var opt="";
			if(data.vendorNameList.length > 1) {
				opt="<option value=''>All</option>";
			}
			
			$.each(data.vendorNameList,function(i,val){
				opt+="<option value='"+val+"'>"+val+"</option>";
			});
			$("#sel_vendor_id").append(opt);
			
			getVendorBranchList($("#sel_vendor_id").val());
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function getAllBatchIds() {
	availableTags = [];
	$.ajax({
		url : $("#contextPath").val()+'/c/allBatchIds',
		type : 'POST',
		success:function(data){
			if(data != null && data.batchIdList.length > 0) {
				$.each(data.batchIdList, function(i, val){
					availableTags[i] = val;
				});
				
				$("#batch_id").autocomplete({
					source: availableTags
			    });
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function getVendorBranchList(vendorName){
	$("#sel_vendorBranch_id").html('');
	
	if(vendorName == null || vendorName == undefined || vendorName == '') {
		$('.branchdivCls').hide();
		return;
	}
	var vendorDto = new Object();
	vendorDto.vendorName = vendorName;
	$.ajax({
		url : $("#contextPath").val()+'/api/v1/venbl',
		contentType : "application/json",
		type : 'POST',
		data : JSON.stringify(vendorDto),
		success:function(data){
			var opt="";
			if(data.vendorBranchDetailsList.length > 1) {
				opt="<option value=''>Select One</option>";
			}
			
			$.each(data.vendorBranchDetailsList,function(i,val){
				opt+="<option value='"+val.userId+"'>"+val.branchName+"</option>";
			});
			$("#sel_vendorBranch_id").append(opt);
			
			$('.branchdivCls').show();
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function senderRequestDataTbl(packageStatus,vendorGroupName,senderId,batchId){
	if(vendorGroupName == undefined || vendorGroupName == '' || vendorGroupName == null) {
		vendorGroupName = "";
	}
	if(senderId == undefined || senderId == '' || senderId == null) {
		senderId = "";
	}
	if(batchId == undefined || batchId == '' || batchId == null) {
		batchId = "";
	}
	
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
	
	$('#sender_report').hide();
	$('.loadCmnCls').show();
	$.ajax({
		type : 'POST',
		url : $("#contextPath").val()+"/c/searchSenderRequest",
		data : {vendorGroupName : vendorGroupName, packageStatus: packageStatus, senderId: senderId, batchId: batchId, searchFromdate: searchFromdate, searchTodate: searchTodate},
		success : function(json){
			if(json != null){
				$('#sender_report').show();
				searchData = json.senderList;
				loadDelvTableList(json, 1, '#senderdetails');
				
				downloadReportUrl = $("#contextPath").val()+"/api/v1/genvenreport?vendorGroupName="+vendorGroupName.toString()+"&senderId="+senderId.toString()+'&searchFromdate='+searchFromdate.toString()+'&searchTodate='+searchTodate.toString();
			}
			$('.loadCmnCls').hide();
		}
	});
}

var searchData = [];

function datePickFn(){
	
	$(".dateSearch").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	$(".mnth_datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'MM yy',
        onClose: function(dateText, inst) { 
            $(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
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
}