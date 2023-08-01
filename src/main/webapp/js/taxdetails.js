$(document).ready(function(){
	
	$(".dateSearch").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	$('#admin_search').click(function(){
		
		var userRole = $('.rad_roleSelect_cls:checked').val();
		
		$.ajax({
			type : 'POST',
			url : $("#contextPath").val()+"/adm/getUserDetails",
			data : {userRole : userRole },
		  success : function(data){
			  
			  if(data!=null){
				  
				  if ( $.fn.DataTable.isDataTable('#userManagementTbl') ) {
					  $("#userManagementTbl").DataTable().destroy();
					  $("#userManagementTbl").empty();
					}
				  var userTbl ="";
				 if(data[0].userRole == "v"){
					 userTbl ='<thead><tr><th></th><th>User Name</th><th>Delivery</th><th>Collect Customer Amount</th><th>PD Receivable Amount</th>'
							 +'<th>Credit To Vendor</th><th>Debit From Vendor</th><th>Vendor Invoice</th><th>Rider Commission</th><th>PD margin</th>'
							 +'<th>Billing Cycle</th><th>Active</th></tr></thead>'
							 
					 $('#userManagementTbl').append(userTbl);
					 
					 loadVmanagementDataTbl(data);
					 
				 }else if(data[0].userRole == "d"){
					 userTbl ='<thead><tr><th>User Name</th><th>Mobile No</th><th>Delivery</th><th>PayToDeliverer</th><th>PayToPickdrop</th><th>Active</th>'
						 +'<th>View</th><th>Generate PDF</th></tr></thead>'
						 
				     $('#userManagementTbl').append(userTbl);
					 
					// loadDmanagementDataTbl(data);
					 
				 }else if(data[0].userRole == "s"){
					 
					 userTbl ='<thead><tr><th>User Name</th><th>Mobile No</th><th>Initiate Delivery</th><th>Cancelled</th><th>Active</th>'
						 +'<th>View</th><th>Generate PDF</th></tr></thead>'
						 
						 $('#userManagementTbl').append(userTbl);
					 
					 loadSmanagementDataTbl(data);
				 }
				  
				 $('.generateDivCls').show();
				 $('.dateCls').show();
				 
			  }
			  
		  },
			
		});
		
	});
	
	
	
	$(document.body).on('click', '.viewdelivercls', function() {
		
		if ($(".actionCls").is(":checked")){
			
		
		$('.addrsDtlsCls').html('');
		
		var data	= userManagementTbl.row($('.actionCls:checked').parents('tr')).data();
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
		
		if ($(".actionCls").is(":checked")){
		var fromDate = $('#from_date_id').val();
		var toDate = $('#to_date_id').val();
		if(fromDate == "" || toDate == ""){
			alert("Select From Date and To Date");
			return false;
		}
		var userManagementDto	= userManagementTbl.row($('.actionCls:checked').parents('tr')).data();
		downloadReportUrl = $("#contextPath").val()+"/adm/generateExcel?userId="+userManagementDto.userModel.id+"&role="+userManagementDto.userRole+"&fromDate="+fromDate+"&toDate="+toDate;
		window.location = downloadReportUrl;
		}else{
			alert("Please Select One User")
		}
	});
	
	$(document.body).on('click', '.generatePDF', function() {
	
		if ($(".actionCls").is(":checked")){
		var fromDate = $('#from_date_id').val();
		var toDate = $('#to_date_id').val();
		if(fromDate == "" || toDate == ""){
			alert("Select From Date and To Date");
			return false;
		}
		var userManagementDto	= userManagementTbl.row($('.actionCls:checked').parents('tr')).data();
		
		downloadReportUrl = $("#contextPath").val()+"/adm/generatePDF?userId="+userManagementDto.userModel.id+"&role="+userManagementDto.userRole+"&fromDate="+fromDate+"&toDate="+toDate;
		
		window.location = downloadReportUrl;
		}else{
			alert("Please Select One User")
		}
	});
	
	
	
});

function loadSmanagementDataTbl(data){
	
	userManagementTbl = $("#userManagementTbl").DataTable({
			
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "desc" ] ],
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
				"data" : "userName",
			},{
				"data" : "mobileNumber",
			},{
				"data" : "senderInitDelivery",
			},{
				"data" : "senderCancelDelivery",
			},{
				"render" : function(data, type, row) {
					if(row.uflag == "true")
						return "<td><span style='float:left;width:80px;text-align: center;'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+row.id+" checked onclick='return controlUser($(this).attr(\"id\"));'></span></td>"
				else
					return "<td><span style='float:left;width:80px;text-align: center;'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+row.id+" onclick='return controlUser($(this).attr(\"id\"));'></span></td>"
					
				}
			},{
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span style='float:left;width:80px;text-align: center;'><span class='tblcolumnlbl tblActionCls viewdelivercls' style='height: 20px;font-size: 0.7rem;'>View</span></span>";
				}
			},{
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span style='float:left;width:80px;text-align: center;'><span class='tblcolumnlbl tblActionCls generatePDF' style='height: 20px;font-size: 0.7rem;'>PDF</span></span>";
				}
			}],
			"pageLength" : 5,
			"order" : [ [ 0, "desc" ] ],
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]

		});
	
	userManagementTbl.on('draw', function () {
		var body = $(userManagementTbl.table().body());
		body.unhighlight();
		body.highlight(userManagementTbl.search());  
	});
	
}

//function loadDmanagementDataTbl(data){
//	
//	userManagementTbl = $("#userManagementTbl").DataTable({
//		
//		"data" : data,
//		"autoWidth": false,
//		"oLanguage" : {
//			"sEmptyTable" : "No Data Available"
//		},
//		"order" : [ [ 0, "desc" ] ],
//		"bLengthChange" : true,
//		"bInfo" : true,
//		"bProcessing" : true,
//		"sort" : "position",
//		"bStateSave" : false,
//		"iDisplayStart" : 0,
//		"searchable" : true,
//
//			"oPaginate" : {
//				"sFirst" : "First",
//				"sLast" : "Last",
//				"sNext" : "Next",
//				"sPrevious" : "Previous"
//			
//		},
//		"scrollX": true,
//		
//		"columns" : [{
//			"data" : "userName",
//		},{
//			"data" : "mobileNumber",
//		},{
//			"data" : "totalDelivery",
//		},{
//			"data" : "payToDeliverer",
//		},{
//			"data" : "payToPickdrop",
//		},{
//			"render" : function(data, type, row) {
//				if(row.uflag == "true")
//					return "<td><span style='float:left;width:80px;text-align: center;'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+row.id+" checked onclick='return controlUser($(this).attr(\"id\"));'></span></td>"
//			else
//				return "<td><span style='float:left;width:80px;text-align: center;'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+row.id+" onclick='return controlUser($(this).attr(\"id\"));'></span></td>"
//				
//			}
//		},{
//			"render" : function(data, type, row) {
//			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
//			    return "<span style='float:left;width:80px;text-align: center;'><span class='tblcolumnlbl tblActionCls viewdelivercls' style='height: 20px;font-size: 0.7rem;'>View</span></span>";
//			}
//		},{
//			"render" : function(data, type, row) {
//			    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
//			    return "<span style='float:left;width:80px;text-align: center;'><span class='tblcolumnlbl tblActionCls generatePDF' style='height: 20px;font-size: 0.7rem;'>PDF</span></span>";
//			}
//		}],
//		"pageLength" : 5,
//		"order" : [ [ 0, "desc" ] ],
//		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
//
//	});
//}

function loadVmanagementDataTbl(data){
	
	
	userManagementTbl = $("#userManagementTbl").DataTable({
		
		"data" : data,
		"autoWidth": false,
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
			"render" : function(data, type, row) {
				
					return "<td><span style='float:left;width:80px;text-align: center;'><input type='radio'  style='height: 20px;font-size: 0.7rem;' id="+row.userModel.id+" class=actionCls></span></td>"
				
			}
		},{
			"data" : "userName",
		},{
			"data" : "totalDelivery",
		},{
			"data" : "collectCustomerAmount",
		},{
			"data" : "pdReceivableAmount",
		},{
			"data" : "vendorCreditAmount",
		},{
			"data" : "vendorDebitAmount",
		},{
			"data" : "vendorInvoiceAmount",
		},{
			"data" : "riderCommission",
		},{
			"data" : "pdMargin",
		},{
			"data" : "userModel.billingCycle",
		},{
			"render" : function(data, type, row) {
				if(row.userModel.uflag == "true")
					return "<td><span style='float:left;width:80px;text-align: center;'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+row.userModel.id+" checked onclick='return controlUser($(this).attr(\"id\"));'></span></td>"
			else
				return "<td><span style='float:left;width:80px;text-align: center;'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+row.userModel.id+" onclick='return controlUser($(this).attr(\"id\"));'></span></td>"
				
			}
		}],
		"pageLength" : 5,
		"order" : [ [ 0, "desc" ] ],
		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]

	});
	
	userManagementTbl.on('draw', function () {
		var body = $(userManagementTbl.table().body());
		body.unhighlight();
		body.highlight(userManagementTbl.search());  
	});
}

function controlUser(userId){
	var checked= $("#"+userId).is(":checked");
	var status="";
	if(checked===true)
		status="activate";
	else
		status="inactivate";
	if (confirm('Do you want to '+status+' the user?')) {
			$.ajax({
				url : $("#contextPath").val()+"/adm/a",
				contentType : 'application/json',
				method : 'POST',
				data: userId+","+checked,
				success : function(data) {
					
				},
				failure : function(response) {
					alert(response.responseText);
				}
			});
			return true;
	} else {
	    return false;
	}	
	
}