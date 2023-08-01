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
	
	$("#sender_search").trigger("click");
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
		var bId=$(this).attr("reqId");
		var dId=$(this).closest('td').prev().find('select').children('option:selected').attr("dId");
	//	alert(bId+","+dId);
		var dData=bId+","+dId;
		$.ajax({
			url : $("#contextPath").val()+'/c/changedeliverer',
			type : 'POST',
			data: dData,
			success:function(data){
				senderRequestTbl.ajax.reload(null, false);
				alert("Deliverer Changed Successfully");
				//buildDataTable();
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) { 
		        alert("Status: " + textStatus);
		    }
		});
		
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
			
			$('#senderdetails').DataTable().destroy();
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
				opt="<option value=''>All</option>";
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
	downloadReportUrl = $("#contextPath").val()+"/api/v1/genvenreport?vendorGroupName="+vendorGroupName.toString()+"&packageStatus="+packageStatus.toString()+"&senderId="+senderId.toString()+"&batchId="+batchId.toString()+'&searchFromdate='+searchFromdate.toString()+'&searchTodate='+searchTodate.toString();
	buildDataTable();
	
}
function buildDataTable(){
	$('#senderdetails').DataTable().destroy();
	senderRequestTbl = $("#senderdetails").DataTable({
		"ajax" : {
			"url" : $("#contextPath").val()+"/c/getAllSenderRequests",
			"contentType" : 'application/json',
			"method" : 'POST',
			"dataSrc" : function(json) {
				//console.log(JSON.stringify(json));
		        return json;
			}
		},
		"autoWidth": true,
		"oLanguage" : {
			"sEmptyTable" : "No Data Available"
		},
		"order" : [ [ 0, "desc" ] ],
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
			"data" : "senderUserModel.role",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span class='tblcolumnlbl'>" + data + "</span>";
			}
		},{
			"data" : "createdAt",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    var datestring = '';
			    if(data != '') {
			    	datestring = new Date(data).toLocaleString("en-US", {timeZone: 'Asia/Kolkata'});
			    }
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
			}
		},{
			"data" : "scheduleDate",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    var datestring = '';
			    if(data != '') {
			    	datestring = new Date(data).toLocaleString("en-US", {timeZone: 'Asia/Kolkata'});
			    }
			    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
			}
		},{
			"data" : "senderUserModel.firstName",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span class='tblcolumnlbl'>" + data + "</span>";
			}
		},{
			"data" : "packagePickupAddress",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span class='tblcolumnlbl addrTblCls' title='"+data+"'>" + data + "</span>";
			}
		},{
			"data" : "recieverAddress",
			"render" : function(data, type, row) {
				if(data == null)data = ""; if(type === "sort" || type === "type") return row.recieverName + ", " + row.recieverAddress + "." + row.recieverContact;
			    return "<span class='tblcolumnlbl addrTblCls' title='"+row.recieverName + ", " + row.recieverAddress + "." + row.recieverContact+"'><span>" + row.recieverName + "</span>, " + row.recieverAddress + ".<a class='tblTelLblCls' href='tel:"+row.recieverContact+"'>Tel: " + row.recieverContact + "</a></span>";
			}
		},{
			"data" : "amount",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span class='tblcolumnlbl'>" + data + "</span>";
			}
		},{
			"data" : "packageStatus",
			"render" : function(data, type, row) {
				if(data != '') {
					if(data == 'ASSIGNED')data='Assigned';
					if(data == 'PICKEDUP')data='Pickedup';
					if(data == 'DELIVERED')data='Delivered';
					if(data == 'CANCEL')data='Canceled';
					if(data == 'RETURN')data='Return Initiated';
					if(data == 'RETURNED')data='Returned';
					if(data == 'ACKNOWLEDGED')data='Acknowledged';
				}
				
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span class='tblcolumnlbl'>" + data + "</span>";
			}
		},{
			"data" : "delivererName",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span class='tblcolumnlbl'>" + data + "</span>";
			}
		},{
			"data" : {deliverers:"deliverers",sendTo:"sendTo"},
			"render" : function(data, type, row) {
				var options="";
				for(var i=0;i<data.deliverers.length;i++)
					{
					//alert(data.sendTo);
					if(data.deliverers[i].split("+")[2]==data.sendTo)
						options+="<option dId='"+data.deliverers[i].split("+")[1]+"'>"+data.deliverers[i].split("+")[0]+"</option>";
					}
			    if(data.deliverers == null)
			    	data = ""; 
			    if(type === "sort" || type === "type") 
			    	return data;
			    return "<span class='tblcolumnlbl'>" + "<select class='del'>"+options+"</select>"+ "</span>";
			}
		},{
			"data" : "id",
			"render" : function(data, type, row) {
			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
			    return "<span style='float:left;width:80px;text-align: center;'><span class='tblcolumnlbl tblActionCls viewdelivercls' style='height: 20px;font-size: 0.7rem;' reqid="+data+">Assign</span></span>";
			}
		}
		],
		"pageLength" : 5,
		"order" : [ [ 0, "desc" ] ],
		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]

	});
	
	senderRequestTbl.on('draw', function () {
		var body = $(senderRequestTbl.table().body());
		body.unhighlight();
		body.highlight(senderRequestTbl.search());  
	});
}

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