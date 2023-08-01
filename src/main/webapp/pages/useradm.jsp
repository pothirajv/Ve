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
	var utype="ROLE_USER";
	$.ajax({
		url : $("#contextPath").val()+"/c/e",
		data: {'utype': utype,'loc':"All"},
		method : 'POST',
		success : function(data) {
			buildDataTable(data);
		},
		failure : function(response) {
			alert(response.responseText);
		}
	});
	$("#loc").change(function() {
		loc=$("#loc").val();
		//alert(loc);
		if(loc==="All Location")
			loc="All";
		
		$.ajax({
			url : $("#contextPath").val()+"/c/e",
//	 		contentType : 'application/json',
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
	
	$("#backbtn").click(function() {
		$("#tableDiv").show();
		$("#loc").show();
		$("#lochead").show();
		$("#um").slideDown();
		$("#userdetails").hide();
		$("#backbtn").hide();
	});
	
});
function editven(id){
	$("#tableDiv").slideUp();
	$("#um").slideUp();
	$("#backbtn").show();
	$("#loc").slideUp();
	$("#lochead").slideUp();
	$("#userdetails").slideDown();
	$.ajax({
		url : $("#contextPath").val()+"/adm/v",
		contentType : 'application/json',
		data:  id,
		method : 'POST',
		success : function(data) {
			$("#vname").html(data.firstName);
			$("#mobno").val(data.mobileNumber);
			$("#fname").val(data.firstName);
			$("#email").val(data.email);
			$("#city").val(data.city);
			$("#state").val(data.state);
			$("#aadhar").val(data.aadharNumberVerified);
			$("#createdat").val((data.createdDate).split("T")[0]);
			$("#usrrtperkg").val(data.userRatePerKg);
			$("#usrrtperkm").val(data.userRatePerKm);
			$("#usrmaxwt").val(data.userMaxWeight);
			$("#usrmaxdist").val(data.userMaxDistance);
			$("#usrfltrt").val(data.userFlatRate);
			$("#usrrbsert").val(data.userBaseRate);
			$("#usradddisbrkr").val(data.userAdditionalDistanceBreaker);
			$("#usraddrtperkg").val(data.userAdditionalRatePerKg);
			$("#usraddwtmul").val(data.userAdditionalWeightMultiplier);
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
	headers +="<th>First Name</th>";
	headers +="<th>Last Name</th>";
	headers +="<th>MobileNumber</th>";
	headers +="<th>EmailId</th>";
	headers +="<th>Action</th></tr>";

	
	

	
	for (var i = 0; i < data.length; i++) {
		var reqObj = data[i];
		body += "<tr role='row'>";
		var checked = reqObj.uflag;
		if(checked==="true")
			body+="<td><span style='float:left;width:80px;text-align: center;'><label class='switch1'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+reqObj.id+" checked onclick='return controlUser($(this).attr(\"id\"));'><span class='slider round'></span></label></span></td>";
	else
		body+="<td><span style='float:left;width:80px;text-align: center;'><label class='switch1'><input type='checkbox'  style='height: 20px;font-size: 0.7rem;' id="+reqObj.id+" onclick='return controlUser($(this).attr(\"id\"));'><span class='slider round'></span></label></span></td>";
		
		body += "<td>"+reqObj.firstName+"</td>";
		body += "<td>"+reqObj.lastName+"</td>";
		body += "<td>"+reqObj.mobileNumber+"</td>";
		body += "<td>"+reqObj.email+"</td>";
		body += "<td><button class='btn btn-primary editVendorInfo' id="+reqObj.id+" onClick='editven(\""+reqObj.id+"\");'>View</button></td>";
		
		

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
						<span id="um">User Management</span>
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
								</div></div>
						<div id="tableDiv" class="col-md-12 mr-auto" style="margin-top: 20px;"></div>
					
				</div>
			</section>
		</div>
		<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="userdetails" style="margin-bottom: 50px;display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center;"><span id="vname"></span></h5>
				<form id="vdet">
				
				
							<div class="row">
							<div class="col-md-6">
									<div class="form-group">
										<p>Registered Mobile number</p>
										<input type="text" class="nonedit" name="mobno" id="mobno" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>First Name</p>
										<input type="text" class="nonedit" name="fname" id="fname" disabled=true /> <br>
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
										<p>Email Id</p>
										<input type="text" class="nonedit" name="email" id="email" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Rate Per Kg</p>
										<input type="text" name="usrrtperkg" id="usrrtperkg" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Rate Per Km</p>
										<input type="text" name="usrrtperkm" id="usrrtperkm" disabled="disabled"/> <br>
									</div>
								</div>
							<div class="col-md-6">
									<div class="form-group">
										<p>User Maximum Weight</p>
										<input type="text" name="usrmaxwt" id="usrmaxwt" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Maximum Distance</p>
										<input type="text" name="usrmaxdist" id="usrmaxdist" disabled="disabled"/> <br>
									</div>
								</div>
							
								<div class="col-md-6">
									<div class="form-group">
										<p>User Flat Rate</p>
										<input type="text" name="usrfltrt" id="usrfltrt" disabled="disabled"/> <br>
									</div>
								</div>
							
								<div class="col-md-6">
									<div class="form-group">
										<p>User Base Rate</p>
										<input type="text" name="usrrbsert" id="usrbsert" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Base Rate</p>
										<input type="text" name="usrbsert" id="usrbsert" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Additional Distance Breaker</p>
										<input type="text" name="usradddisbrkr" id="usradddisbrkr" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Additional Rate Per Kg</p>
										<input type="text" name="usraddrtperkg" id="usraddrtperkg" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>User Additional Weight Multiplier</p>
										<input type="text" name="usraddwtmul" id="usraddwtmul" disabled="disabled"/> <br>
									</div>
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