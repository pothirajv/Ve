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
#vdet1{
padding:10px;
}
#vdet input{
border:none!important;
background-color:transparent;
}
#vdet1 input{
border:none!important;
background-color:transparent;
}
#vdet .form-group p{
font-weight:bold!important;
}
#vdet1 .form-group p{
font-weight:bold!important;
}
#vdet .col-md-6{
    padding: 20px;
    padding-left: 50px;
    border-bottom:2px solid #f1f1f1;

}
#vdet1 .col-md-6{
    padding: 20px;
    padding-left: 50px;
    border-bottom:2px solid #f1f1f1;

}
#vdet .col-md-6 p{
color:#007bff;
}
 #vdet1 .col-md-6 p {
color:#007bff;
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

</style>
<script>
$(document).ready(function() {
	var offerRequest= new Object();
	$.ajax({
		url : $("#contextPath").val()+"/o/h",
 		contentType : 'application/json',
 			data : JSON.stringify(offerRequest),
		method : 'POST',
		dataType : "json",
		success : function(data) {
			buildDataTable(data);
			$("#tableDiv").show();
		},
		failure : function(response) {
			alert(response.responseText);
		}
	});
	
	
	$("#createoff").click(function(event){
		var flag = true;

		$(".required").each(
				function(index) {
					if ($(this).val() === "") {
						$(this).parent().find(".validation").addClass("showVal");
						$(this).parent().find(".validation").html("This field is mandatory");
						flag = false;
					} else {
						$(this).parent().find(".validation").removeClass("showVal");
						$(this).parent().find(".validation").html("");
					}
				}
			);
		if (flag == false) {
			event.preventDefault();
			}
		else{
		
		var offerModel= new Object();
		offerModel.offerName=$("#offname").val();
		offerModel.offerDescription=$("#offdesc").val();
		offerModel.offerPercentage=$("#offperc").val();
		offerModel.couponCode=$("#brateccodewt1").val();
		offerModel.startDate=$("#sdate").val();
		offerModel.endDate=$("#edate").val();
		offerModel.activeFlag=$("#acflag").val();
		offerModel.numberOfDeliveries=$("#noofdelv").val();
		offerModel.maxAmount=$("#maxamt").val();
		offerModel.maxAmountPerTransaction=$("#maxamtpertrans").val();
		offerModel.global=$("#global").val();
		offerModel.url=$("#url").val();
		
		$.ajax({
			url : $("#contextPath").val()+"/o/a",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(offerModel),
			dataType : "json",
			success : function(data) {
				alert("Successfully Updated!!");
				$("#offerdetails").slideUp();
				$("#tableDiv").show();
				$("#createnewoff").slideDown();
				$("#ofrmgm").show();
				$([document.documentElement, document.body]).animate({
			        scrollTop: $("#createnewoff").offset().top
			    }, 100);
				
	},
		error : function(data) {
			alert("UnSuccessfull!!");
}
		});
		}

		});
	
	$("#createnewoff").click(function(event){
		$("#offerdetails").show();
		$("#createnewoff").slideUp();
		$("#tableDiv").hide();
	});
	
	
	$("#modifyoff").click(function(){
		var offerModel= new Object();
		offerModel.offerName=$("#offname1").val();
		offerModel.offerDescription=$("#offdesc1").val();
		offerModel.offerPercentage=$("#offperc1").val();
		offerModel.couponCode=$("#ccode1").val();
		offerModel.startDate=$("#sdate1").val();
		offerModel.endDate=$("#edate1").val();
		offerModel.activeFlag=$("#acflag1").val();
		offerModel.numberOfDeliveries=$("#noofdelv1").val();
		offerModel.maxAmount=$("#maxamt1").val();
		offerModel.global=$("#global1").val();
		offerModel.url=$("#url1").val();
				$.ajax({
			url : $("#contextPath").val()+"/o/c",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(offerModel),
			dataType : "json",
			success : function(data) {
				alert("Successfully Updated!!");
				$("#offerdetailsmodify").slideUp();
				$("#tableDiv").show();
				$("#createnewoff").slideDown();
				$("#ofrmgm").show();
				$([document.documentElement, document.body]).animate({
			        scrollTop: $("#createnewoff").offset().top
			    }, 100);
	},
		error : function(data) {
			alert("Successfully Updated!!");
	}
		});
	});
	$("#allocate").click(function(){
		var offerRequest= new Object();
		offerRequest.couponCode=$("#cpco").val();
		offerRequest.mobileNumber=$("#venmob").val();
				$.ajax({
			url : $("#contextPath").val()+"/o/e",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(offerRequest),
			dataType : "json",
			success : function(data) {
				alert("Successfully Allocated!!");
				$("#allocatecoupon").slideUp();
				$("#tableDiv").show();
				$("#createnewoff").slideDown();
				$("#ofrmgm").show();
				$([document.documentElement, document.body]).animate({
			        scrollTop: $("#createnewoff").offset().top
			    }, 100);
	},
		error : function(data) {
			alert("UnSuccessfull!!");
	}
		});
	});
	
	$("#deallocate").click(function(){
		var offerRequest= new Object();
		offerRequest.couponCode=$("#cc").val();
		offerRequest.mobileNumber=$("#venmob1").val();
				$.ajax({
			url : $("#contextPath").val()+"/o/g",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(offerRequest),
			dataType : "json",
			success : function(data) {
				alert("Successfully DeAllocated!!");
				$("#deallocatecoupon").slideUp();
				$("#tableDiv").show();
				$("#createnewoff").slideDown();
				$("#ofrmgm").show();
				$([document.documentElement, document.body]).animate({
			        scrollTop: $("#createnewoff").offset().top
			    }, 100);
	},
		error : function(data) {
			alert("UnSuccessfull!!");
	}
		});
	});
	
	$("#cancelbtn").click(function() {
		$("#tableDiv").show();
		$("#createnewoff").slideDown();
		$("#offerdetails").hide();
		$("#ofrmgm").show();
		$([document.documentElement, document.body]).animate({
	        scrollTop: $("#createnewoff").offset().top
	    }, 100);
	});
	$("#cancelbtn1").click(function() {
		$("#tableDiv").show();
		$("#createnewoff").slideDown();
		$("#offerdetailsmodify").hide();
		$("#ofrmgm").show();
		$([document.documentElement, document.body]).animate({
	        scrollTop: $("#createnewoff").offset().top
	    }, 100);
	});
	$("#cancelbtn2").click(function() {
		$("#tableDiv").show();
		$("#createnewoff").slideDown();
		$("#allocatecoupon").hide();
		$("#ofrmgm").show();
	});

	$("#cancelbtn3").click(function() {
		$("#tableDiv").show();
		$("#createnewoff").slideDown();
		$("#deallocatecoupon").hide();
		$("#ofrmgm").show();
	});
});
function editven(id){
	$("#tableDiv").slideUp();
	$("#ofrmgm").hide();
	$("#createnewoff").slideUp();
	$("#offerdetailsmodify").slideDown();
	$.ajax({
		url : $("#contextPath").val()+"/o/j",
		contentType : 'application/json',
		data : id,
		method : 'POST',
		success : function(data) {
			var offerModels=data;
			$("#offname1").val(offerModels.offerName);
			$("#offdesc1").val(offerModels.offerDescription);
			$("#offperc1").val(offerModels.offerPercentage);
			$("#ccode1").val(offerModels.couponCode);
			$("#sdate1").val(offerModels.startDate.split("T")[0]);
			$("#edate1").val(offerModels.endDate.split("T")[0]);
			$("#acflag1").val(offerModels.activeFlag);
			$("#noofdelv1").val(offerModels.numberOfDeliveries);
			$("#maxamt1").val(offerModels.maxAmount);
			$("#maxamtpertrans1").val(offerModels.maxAmountPerTransaction);
			$("#global1").val(offerModels.global);
			$("#url1").val(offerModels.url);
		
			
		},
		failure : function(response) {
			alert(response.responseText);
		}
	});
}
function alcop(couponCode){
	$("#tableDiv").slideUp();
	$("#createnewoff").slideUp();
	$("#cpco").val(couponCode);
	$("#cpco1").html(couponCode);
	$("#ofrmgm").hide();
	$("#allocatecoupon").show();
}
function delcop(couponCode){
	$("#tableDiv").slideUp();
	$("#createnewoff").slideUp();
	$("#cc").val(couponCode);
	$("#cpco2").html(couponCode);
	$("#ofrmgm").hide();
	$("#deallocatecoupon").show();
}
function buildDataTable(data){
	$("#tableDiv").empty();
	var headers = "";
	var body ="";
	headers += "<tr role='row'>";
	headers +="<th>Offer Name</th>";
	headers +="<th>Offer Code</th>";
	headers +="<th>Start Date</th>";
	headers +="<th>End Date</th>";
	
	headers +="<th></th>";
	headers +="<th></th>";
	headers +="<th></th></tr>";
	var offerModels= data.offerModel;
	for (var i = 0; i < offerModels.length; i++) {
		var reqObj = offerModels[i];
		body += "<tr role='row'>";

		body += "<td>"+reqObj.offerName+"</td>";
		body += "<td>"+reqObj.couponCode+"</td>";
		body += "<td>"+reqObj.startDate.split("T")[0]+"</td>";
		body += "<td>"+reqObj.endDate.split("T")[0]+"</td>";
		
		body += "<td><button class='btn btn-primary editVendorInfo' id="+reqObj.id+" onClick='editven(\""+reqObj.id+"\");'>Edit</button></td>";
		body += "<td><button class='btn btn-primary editVendorInfo' id="+reqObj.couponCode+" onClick='alcop(\""+reqObj.couponCode+"\");'>Allocate</button></td>";
		body += "<td><button class='btn btn-primary editVendorInfo' id="+reqObj.couponCode+" onClick='delcop(\""+reqObj.couponCode+"\");'>De-Allocate</button></td>";
		
		
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
</script>
</head>
<body>
<br>
<br>
	<div class="col-md-2 quote_btn-container" style="text-align:center;" id="crtbuttom">
				              <button type="button" class="btn btn-primary" id="createnewoff">Create New Offer</button>
				              
				            </div><br>
				            <div id="ofrmgm">
				            <h5 class="font-weight-bold" style="text-align: center; display:block;">Offer Management</h5></div>
				            <div id="tableDiv" class="col-md-12 mr-auto" style="margin-top: 20px;"></div>
<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="offerdetails" style="margin-bottom: 50px; display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center; display:none;">Create New Offer</h5>
				<form id="vdet">
				
				
							<div class="row">
							<div class="col-md-6">
									<div class="form-group">
										<p>Offer Name</p>
										<input type="text" class="nonedit" name="offname" id="offname"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Offer Description</p>
										<input type="text" class="nonedit" name="offdesc" id="offdesc"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Offer Percentage</p>
										<input type="text" class="nonedit" name="offperc" id="offperc" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Coupon Code</p>
										<input type="text" class="nonedit" name="ccode" id="ccode" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Start Date</p>
										<input type="date" class="nonedit" name="sdate" id="sdate" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>End Date</p>
										<input type="date" class="nonedit" name="edate" id="edate" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Active Flag(true/false)</p>
										<input type="text" class="nonedit" name="acflag" id="acflag" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Number Of Deliveries</p>
										<input type="text" class="nonedit" name="noofdelv" id="noofdelv" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Max Amount</p>
										<input type="text" class="nonedit" name="maxamt" id="maxamt" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Max Amount per Transaction</p>
										<input type="text" class="nonedit" name="maxamtpertrans" id="maxamtpertrans" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Global Flag(true/false)</p>
										<input type="text" class="nonedit" name="global" id="global" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>URL</p>
										<input type="text" class="nonedit" name="url" id="url" /> <br>
									</div>
								</div>
								</div></form>
				
						<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="createoff">Create Offer</button>
				               <button type="button" class="btn btn-primary" id="cancelbtn">Cancel</button>
				            </div>
						</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>

<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="offerdetailsmodify" style="margin-bottom: 50px; display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center; display:block;">Modify Offer</span></h5>
				<form id="vdet1">
				
				
							<div class="row">
							<div class="col-md-6">
									<div class="form-group">
										<p>Offer Name</p>
										<input type="text" class="nonedit" name="offname1" id="offname1"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Offer Description</p>
										<input type="text" class="nonedit" name="offdesc1" id="offdesc1"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Offer Percentage</p>
										<input type="text" class="nonedit" name="offperc1" id="offperc1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Coupon Code</p>
										<input type="text" class="nonedit" name="ccode1" id="ccode1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Start Date(YYYY-MM-DD)</p>
										<input type="text" class="nonedit" name="sdate1" id="sdate1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>End Date(YYYY-MM-DD)</p>
										<input type="text" class="nonedit" name="edate1" id="edate1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Active Flag(true/false)</p>
										<input type="text" class="nonedit" name="acflag1" id="acflag1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Number Of Deliveries</p>
										<input type="text" class="nonedit" name="noofdelv1" id="noofdelv1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Max Amount</p>
										<input type="text" class="nonedit" name="maxamt1" id="maxamt1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Max Amount per Transaction</p>
										<input type="text" class="nonedit" name="maxamtpertrans1" id="maxamtpertrans1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Global Flag(true/false)</p>
										<input type="text" class="nonedit" name="global1" id="global1" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>URL</p>
										<input type="text" class="nonedit" name="url1" id="url1" /> <br>
									</div>
								</div>
								</div></form>
				
						<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="modifyoff">Save Offer</button>
				               <button type="button" class="btn btn-primary" id="cancelbtn1">Cancel</button>
				            </div>
						</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>


<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="allocatecoupon" style="margin-bottom: 50px; display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center; display:block;">Allocate Offer "<span id="cpco1"></span>"</h5>
				<br>
				<form id="allo">
				
				
							<div class="row">
							<div class="col-md-5"></div>
							<div class="col-md-3">
									<div class="form-group">
										<p><b>Provide User Mobile Number</b></p>
										<input type="text" class="nonedit" name="venmob" id="venmob"/> <br>
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group" style="display:none;">
										<p>CCode</p>
										<input type="text" class="nonedit" name="cpco" id="cpco"/> <br>
									</div>
								</div>
								<div class="col-md-2"></div>
								
								</div></form>
				<br>
						<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="allocate">Allocate</button>
				               <button type="button" class="btn btn-primary" id="cancelbtn2">Cancel</button>
				            </div>
						</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>
<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="deallocatecoupon" style="margin-bottom: 50px; display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center; display:block;">De-Allocate Offer "<span id="cpco2"></span>"</h5>
				<form id="delallo">
				
				
							<div class="row">
							<div class="col-md-5"></div>
							<div class="col-md-3">
									<div class="form-group">
										<p><b>Provide User Mobile Number</b></p>
										<input type="text" class="nonedit" name="venmob1" id="venmob1"/> <br>
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group" style="display:none;">
										<p>CCode</p>
										<input type="text" class="nonedit" name="cc" id="cc"/> <br>
									</div>
								</div>
								<div class="col-md-2"></div>
								</div></form>
				<br>
						<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="deallocate">De-Allocate</button>
				               <button type="button" class="btn btn-primary" id="cancelbtn3">Cancel</button>
				            </div>
						</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>
</body>
</html>