<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script>
$(document).ready(function(){
$("#ven_search").click(function() {
	if($("#branchSrchSel").val()!=="")
		{
// 	alert($("#branchSrchSel").val());
	$.ajax({
		url : $("#contextPath").val()+'/adm/getVendorDetails',
		type : 'POST',
		data :{'vendorName':$("#branchSrchSel").val()} ,
		success:function(data){
	
			var venDet=data[0];
			var tableHTML="<table id='vendordetails' class='table table-striped table-bordered'>";
			tableHTML+="<thead><tr role='row'><th colspan=2 style='text-align:center'>"+venDet.vendorName+"</th></tr></thead><tbody>";
			tableHTML+="<tr role='row'><td>Vendor Name</td><td>"+venDet.vendorName+"</td></tr>";
			tableHTML+="<tr role='row'><td>MobileNumber</td><td>"+venDet.mobileNumber+"</td></tr>";
			tableHTML+="<tr role='row'><td>Account Type</td><td>"+venDet.accountType+"</td></tr>";
			tableHTML+="<tr role='row'><td>Account Number</td><td>"+venDet.accountNo+"</td></tr>";
			tableHTML+="<tr role='row'><td>Bank Name</td><td>"+venDet.bankName+"</td></tr>";
			tableHTML+="<tr role='row'><td>IFSC Code</td><td>"+venDet.ifsc+"</td></tr>";
			tableHTML+="<tr role='row'><td>Bank Branch Name</td><td>"+venDet.bankBranch+"</td></tr></tbody></table>";
			
			$("#tablecontainer").html(tableHTML);
			$("#vendordetails").dataTable();
		}
	});
		}
});
});

</script>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/paymentdetails.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/delvtbl.js"></script>

<style>

.empty-label::after {
	content: '*';
	color: white;
}

td label {
    margin-bottom: 4px;
    line-height: 16px;
}

.hdrLblCls {
    font-weight: bold;
    color: black;
}

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
    padding: 5px;
	color: #007bff;
	font-weight: bold;
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

</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
			<div class="container">
				<div class="srchMainCls">
					<div class="row formcls srchCls" style="margin-top: 0px;">
						<div class="col-md-12 mr-auto">
							<h5 class="font-weight-bold">
								<span>Vendor Details</span>
							</h5>
						</div>
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="row">

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
										<option value="ROLE_VENDOR">Vendor</option>
										</select>
								</div>
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls nameLblCls required-label">Vendor Name</label><br> 
									<select id="userNameSrchSel"></select>
								</div>
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls nameLblCls required-label">Branch Name</label><br> 
									<select id="branchSrchSel"></select>
								</div>
								<div class="col-md-2">
								<label for="pickdrop" class="hdrLblCls nameLblCls empty-label"></label>
								<br>
									<button class="btn btn-primary" id="ven_search">
										<span class="fa fa-search btn-icon"></span> Search</button>
								</div>
							</div>

				</div>
			</div>
			</section>
		</div>

	</div>
<div id="branchMainCls"></div>
<div class="row" style="margin-bottom:10px;margin-top:10px">
<div class="col-md-1"></div>
<div class="col-md-10" id="tablecontainer" style="margin-bottom: 50px;"></div>
<div class="col-md-1"></div>
</div>

</body>
</html>