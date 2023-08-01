<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
#vdet{
padding:10px;
}
#vdet input{
border:none!important;
background-color:transparent;
}
#vdet .form-group p{
font-weight:bold!important;
}
#vdet .col-md-6{
    padding: 20px;
    padding-left: 50px;
    border-bottom:2px solid #f1f1f1;

}
#vdet .col-md-6 p {
color:#007bff;
}

#vdetedit{

padding:10px;

}
#vdetedit .form-group p{
font-weight:bold!important;
}
.previous {
  background-color: #f1f1f1;
  color: black;
}
.round {
  border-radius: 50%;
}
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}
a:hover {
  background-color: #ddd;
  color: black;
}

.switch1 {
  position: relative;
  display: inline-block;
  width: 30px;
  height: 17px;
}

.switch1 input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 13px;
  width: 13px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #499018;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(13px);
  -ms-transform: translateX(13px);
  transform: translateX(13px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 17px;
}

.slider.round:before {
  border-radius: 50%;
}
#layid{
padding: 35px 0 0px 0 !important;
}
</style>
<script>
$(document).ready(function() {
	$("#vendetupdatebtn").hide();
	$("#cancelbtn").hide();
	var utype="ROLE_VENDOR";
	$.ajax({
		url : $("#contextPath").val()+"/c/e",
 		//contentType : 'application/json',
		data: {'loc':"All",'utype':utype},
		method : 'POST',
		success : function(data) {
			buildDataTable(data);
			$("#tableDiv").show();
		},
		failure : function(response) {
			alert(response.responseText);
		}
	});
	$("#loc").change(function() {
	loc=$("#loc").val();
	if(loc==="All Location")
		loc="All";
	
	$.ajax({
		url : $("#contextPath").val()+"/c/e",
// 		contentType : 'application/json',
		data: {'loc':loc,'utype':utype},
		method : 'POST',
		success : function(data) {
			buildDataTable(data);
			$("#tableDiv").show();
		},
		failure : function(response) {
			alert(response.responseText);
		}
	});
	});
	
	$("#vendetupdatebtn").click(function(){
		var vendorModel= new Object();
		vendorModel.id=$("#venid").val();
		vendorModel.billCycleId=$("#billCycleNum").val();
		vendorModel.accountNo=$("#acno").val();
		vendorModel.accountType=$("#actype").val();
		vendorModel.ifsc=$("#ifsc").val();
		vendorModel.bankname=$("#bankName").val();
		if($("#gst").is(':checked'))
			vendorModel.noGstFlag=true;
		else
			vendorModel.noGstFlag=false;
		if($("#cod").is(':checked'))
			vendorModel.defaultCodFlag=true;
		else
			vendorModel.defaultCodFlag=false;
		if($("#invoicecus").is(':checked'))
			vendorModel.invoiceCustomerFlag=true;
		else
			vendorModel.invoiceCustomerFlag=false;
				$.ajax({
			url : $("#contextPath").val()+"/adm/userUpdate",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(vendorModel),
			dataType : "json",
			success : function(data) {
				if($("#edituserinfo").is(':checked'))
					$("#edituserinfo").trigger("click");
				alert("Successfully Updated!!");
				
	},
		error : function(data) {
			if($("#edituserinfo").is(':checked'))
				$("#edituserinfo").trigger("click");
			alert("Successfully Updated!!");
}
		});
				var loc=$("#loc").val().toUpperCase();
				var utype="ROLE_VENDOR";
				$.ajax({
					url : $("#contextPath").val()+"/c/e",
					contentType : 'application/json',
					data: {'loc':loc,'utype':utype},
					method : 'POST',
					success : function(data) {
						$("#edituserinfo").trigger("click");
						buildDataTable(data);
					},
					failure : function(response) {
						alert(response.responseText);
					}
				});
				
				
});
	$("#edituserinfo").click(function() {
		if($("#edituserinfo").is(':checked')){
		$("#cod").removeAttr("disabled");
		$("#gst").removeAttr("disabled");
		$("#invoicecus").removeAttr("disabled");
		$("#billCycleNum").removeAttr("disabled");
		$("#coupon").removeAttr("disabled");
		$("#vendetupdatebtn").show();
		$("#cancelbtn").show();
		}
		else{
		$("#cod").attr("disabled","disabled");
		$("#gst").attr("disabled","disabled");
		$("#invoicecus").attr("disabled","disabled");
		$("#billCycleNum").attr("disabled","disabled");
		$("#coupon").attr("disabled","disabled");
		$("#vendetupdatebtn").hide();
		$("#cancelbtn").hide();
		
		}
	});
	$("#backbtn").click(function() {
		$("#tableDiv").show();
		$("#loc").show();
		$("#lochead").show();
		$("#vm").slideDown();
		$("#vendordetails").hide();
		$("#backbtn").hide();
		if($("#edituserinfo").is(':checked'))
			$("#edituserinfo").trigger("click");
	});
	$("#cancelbtn").click(function() {
		$("#tableDiv").show();
		$("#loc").show();
		$("#lochead").show();
		$("#vendordetails").hide();
		$("#backbtn").hide();
		$("#vm").show();
		if($("#edituserinfo").is(':checked'))
			$("#edituserinfo").trigger("click");
	});

	
});

function editven(id){
	$("#tableDiv").slideUp();
	$("#vm").slideUp();
	$("#backbtn").show();
	$("#loc").slideUp();
	$("#lochead").slideUp();
	$("#vendordetails").slideDown();
	$.ajax({
		url : $("#contextPath").val()+"/adm/v",
		contentType : 'application/json',
		data:  id,
		method : 'POST',
		success : function(data) {
			$("#vname").html(data.vendorName);
			$("#venid").val(data.id);
			$("#mobno").val(data.mobileNumber);
			$("#hoFlag").val(data.hoFlag);
			$("#fname").val(data.firstName);
			$("#lname").val(data.lastName);
			$("#email").val(data.email);
			$("#city").val(data.city);
			$("#state").val(data.state);
			$("#aadhar").val(data.aadharNumberVerified);
			$("#createdat").val((data.createdDate).split("T")[0]);
			$("#gst").val(data.noGstFlag);
			$("#gstnumber").val(data.gst);
			$("#billCycleNum").val(data.billCycleId);
			if(data.hoFlag==true){
				$("#hobran").val("Head Office");
			}
			
			else
				$("#hobran").val("Branch");
			//$("#coupon").val(data.billCycleId);
			
			$("#acno").val(data.accountNo);
			$("#acname").val(data.accountName);
			$("#actype").val(data.accountType);
			$("#ifsc").val(data.ifsc);
			$("#bankname").val(data.bankName);
			$("#bankbranch").val(data.bankBranch);
			
			if(data.defaultCodFlag===true)
				$("#cod").attr("checked","checked");
			else
				$("#cod").removeAttr("checked");
			
			if(data.noGstFlag===true)
				$("#gst").attr("checked","checked");
			else
				$("#gst").removeAttr("checked");
			if(data.invoiceCustomerFlag===true)
				$("#invoicecus").attr("checked","checked");
			else
				$("#invoicecus").removeAttr("checked");
			
			var userId=$("#venid").val();
			//alert(userId);
			$.ajax({
				url : $("#contextPath").val()+"/o/i",
// 				contentType : 'application/json',
				data: {"userId":userId},
				method : 'POST',
				success : function(data) {
				//	alert(JSON.stringify(data));
					$("#coupon").empty();
					var couponOptions="";
					for (var i = 0; i < data.offerUserModel.length; i++) {
						couponOptions+="<option value='"+data.offerUserModel[i].offerModel.offerName+"'>"+data.offerUserModel[i].offerModel.offerName+"</option>";
					}
					$("#coupon").append(couponOptions);
				},
				failure : function(response) {
					alert(response.responseText);
				}
			});
			
			
		},
		failure : function(response) {
			alert(response.responseText);
		}
	});
}

function buildDataTable(data){
	$("#tableDiv").empty();
	var headers = "";
	var body ="";
	headers += "<tr role='row'>";
	headers += "<th>Active</th>";
	headers +="<th>Registred Mobile Number</th>";
	headers +="<th>Vendor Name</th>";
	headers +="<th>City</th>";
	headers +="<th>Head Office/Branch</th>";
	headers +="<th>InvoiceCustomer</th>";
	headers +="<th>Action	</th></tr>";
	

	
	for (var i = 0; i < data.length; i++) {
		var reqObj = data[i];
		body += "<tr role='row'>";
		var checked = reqObj.uflag;
		if(checked==="true")
				body+="<td><span style='float:left;width:80px;text-align: center;'><label class='switch1'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+reqObj.id+" checked onclick='return controlUser($(this).attr(\"id\"));'><span class='slider round'></span></label></span></td>";
		else
			body+="<td><span style='float:left;width:80px;text-align: center;'><label class='switch1'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+reqObj.id+" onclick='return controlUser($(this).attr(\"id\"));'><span class='slider round'></span></label></span></td>";
			

		body += "<td>"+reqObj.mobileNumber+"</td>";
		body += "<td>"+reqObj.vendorName+"</td>";
		body += "<td>"+reqObj.city+"</td>";
		if(reqObj.hoFlag==true){
			body += "<td>"+'Head Office'+"</td>";
		}
		else
			body += "<td>"+'Branch'+"</td>";
		if(reqObj.invoiceCustomerFlag==true){
			body += "<td>"+'Yes'+"</td>";
		}
		else
		body += "<td>"+'No'+"</td>";
		body += "<td><button class='btn btn-primary editVendorInfo' id="+reqObj.id+" onClick='editven(\""+reqObj.id+"\");'>View/Edit</button></td>";
		
		
		
		body += "</tr>";
	}
	$("#tableDiv")
	.append(
			"<table width='80%' class='table table-striped table-bordered dataTable no-footer' id='tableId'><thead>"
					+ headers
					+ "</thead><tbody>"
					+ body
					+ "</tbody></table>");

var dataTable1 = $('#tableId').DataTable({
"autoWidth": false,
"oLanguage" : {
	"sEmptyTable" : "No Data Available"
},
"order" : [ [ 1, "desc" ] ],
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
"pageLength" : 10,
"order" : [ [ 0, "asc" ] ],
"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
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


</script>
</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding" id="layid">
				<div class="container">
				
					<h5 class="font-weight-bold">
						<span id="vm">Vendor Management</span>
					</h5>
					<div id="backbtn" style="display:none;"><a  class="previous round">&#8249;</a><b>Back</b></div>	
					<div class="row formcls srchCls">
					
					<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls" id="lochead">Location</label><br> 
									<select id="loc">
										<option value="">All Location</option>
										<c:forEach items="${allowedLocation}" var="allowedLoc">
											<option value="${allowedLoc}">${allowedLoc}</option>
										</c:forEach>
									</select>
								</div>
						
					
				</div>
				<div id="tableDiv" class="col-md-12 mr-auto" style="margin-top: 20px;"></div>
				</div>
			</section>
		</div>
		
<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="vendordetails" style="margin-bottom: 50px;display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center;"><span id="vname"></span></h5>
				<form id="vdet">
				
				
							<div class="row">
							<div class="col-md-6" style="display:none;">
									<div class="form-group">
										<p>Id</p>
										<input type="text" class="nonedit" name="venid" id="venid" disabled=true/> <br>
									</div>
								</div>
							<div class="col-md-6">
									<div class="form-group">
										<p>First Name</p>
										<input type="text" class="nonedit" name="fname" id="fname" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Last Name</p>
										<input type="text" class="nonedit" name="lname" id="lname" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Email</p>
										<input type="text" class="nonedit" name="email" id="email" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Head Office/Branch</p>
										<input type="text" class="nonedit" name="hobran" id="hobran" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>City</p>
										<input type="text" class="nonedit" name="city" id="city" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>State</p>
										<input type="text" class="nonedit" name="state" id="state" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>UsingFrom</p>
										<input type="text" class="nonedit" name="createdat" id="createdat" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Aadhar Verified</p>
										<input type="text" class="nonedit" name="aadhar" id="aadhar" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>GST</p>
										<input type="text" class="nonedit" name="aadhar" id="gstnumber" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Account Number</p>
										<input type="text" name="acno" id="acno" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Account Name</p>
										<input type="text" name="acname" id="acname" disabled="disabled"/> <br>
									</div>
								</div>
							<div class="col-md-6">
									<div class="form-group">
										<p>Account Type</p>
										<input type="text" name="actype" id="actype" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>IFSC</p>
										<input type="text" name="ifsc" id="ifsc" disabled="disabled"/> <br>
									</div>
								</div>
							
								<div class="col-md-6">
									<div class="form-group">
										<p>Bank Name</p>
										<input type="text" name="bankname" id="bankname" disabled="disabled"/> <br>
									</div>
								</div>
							
								<div class="col-md-6">
									<div class="form-group">
										<p>Bank Branch</p>
										<input type="text" name="bankbranch" id="bankbranch" disabled="disabled"/> <br>
									</div>
								</div>
								</div></form>
				
					<div style="margin-top: 50px; margin-left: 40px;">
						<input class="styled-checkbox" id="edituserinfo" type="checkbox" value="1">
    										<label for="edituserinfo"><b>Edit Details</b></label></div>
						
						<form id=vdetedit>
							<div class="contentform row formcls">
								<div class="col-md-4">
									<div class="form-group">
										<input class="styled-checkbox" id="cod" type="checkbox" value="1" disabled="disabled">
    										<label for="cod"><b>COD</b></label>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<input class="styled-checkbox" id="gst" type="checkbox" value="1" disabled="disabled">
    										<label for="gst"><b>GST</b></label>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<input class="styled-checkbox" id="invoicecus" type="checkbox" value="1" disabled="disabled">
    										<label for="invoicecus"><b>Invoice Customer</b></label>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Billing Cycle</p>
										<select id="billCycleNum" class="required" disabled="disabled">
											<option value="" >Select One</option>
											<c:forEach items="${billCycleList.billingCycleMasterDtos}" var="billCycle">
												<option value="${billCycle.id}">${billCycle.billingCycleName}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Coupon</p>
										<select id="coupon" class="required" disabled="disabled">
											<option value="">Select One</option>
											<option>test1</option>
											<option>test2</option>
										</select>
									</div>
								</div>
								<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="vendetupdatebtn">Update</button>
				              <button type="button" class="btn btn-primary" id="cancelbtn">Cancel</button>
				            </div>
								</div></form>
							
					
					
						</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>
		
	</div>
</body>
</html>