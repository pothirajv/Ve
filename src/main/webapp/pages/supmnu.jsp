<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script>
$(document).ready(function(){
	$("#details").hide();
$("#loc").change(function() {
var loc=$("#loc").val().toUpperCase();
$.ajax({
	url : $("#contextPath").val()+'/adm/getBusTime',
	type : 'POST',
	data :{'loc':loc} ,
	success:function(data){
		
	var cutofftime=data["DELV_"+loc+"_CUT_OFF_TIME"];
	var starttime=data["DELV_"+loc+"_BUSINESS_HOUR_START"];
	var endtime=data["DELV_"+loc+"_BUSINESS_HOUR_END"];
	
		$("#busscutofftimehr").val(cutofftime.split(":")[0]).attr("disabled","disabled");
		$("#busscutofftimemin").val(cutofftime.split(":")[1]).attr("disabled","disabled");
		$("#busstarttimehr").val(starttime.split(":")[0]).attr("disabled","disabled");
		$("#busstarttimemin").val(starttime.split(":")[1]).attr("disabled","disabled");
		$("#bussendtimehr").val(endtime.split(":")[0]).attr("disabled","disabled");
		$("#bussendtimemin").val(endtime.split(":")[1]).attr("disabled","disabled");
		$("#taxrdrcmsn").val(data["TAX_RIDER_CMSN_PERC_"+loc]).attr("disabled","disabled");
		$("#taxrdrallw").val(data["TAX_RIDER_ALLOWANCE_PER_KM_"+loc]).attr("disabled","disabled");
		$("#cutoffflag").val(data["DELV_"+loc+"_CUT_OFF_FLG"]).attr("disabled","disabled");
		$("#priceincrminfrq").val(data["DELV_"+loc+"_PRICE_INCR_MINUTES_FREQ"]).attr("disabled","disabled");
		$("#priceincrperc").val(data["DELV_"+loc+"_PRICE_INCR_PERC"]).attr("disabled","disabled");
		$('#buscutoff').prop('checked', false);
		$('#busstarttime').prop('checked', false);
		$('#bussendtime').prop('checked', false);
		$('#taxrdrcmsnperc').prop('checked', false);
		$('#taxrdrallwperkm').prop('checked', false);
		$('#cutoffflg').prop('checked', false);
		$('#priceincrminfreq').prop('checked', false);
		$('#priceincper').prop('checked', false);
		$("#details").slideDown();
		
	}
	});
});
$("#time_update").click(function() {
	var loc=$("#loc").val().toUpperCase();
	 var jsonObj = [];
	if($('#buscutoff').is(':checked')){
		
		jsonObj.push("DELV_"+loc+"_CUT_OFF_TIME");
		jsonObj.push($("#busscutofftimehr").val()+":"+$("#busscutofftimemin").val());
	}
	if($('#busstarttime').is(':checked')){
		jsonObj.push("DELV_"+loc+"_BUSINESS_HOUR_START");
		jsonObj.push($("#busstarttimehr").val()+":"+$("#busstarttimemin").val());
	}
	if($('#bussendtime').is(':checked')){
		
		jsonObj.push("DELV_"+loc+"_BUSINESS_HOUR_END");
		jsonObj.push($("#bussendtimehr").val()+":"+$("#bussendtimemin").val());
		
	}
	if($('#taxrdrcmsnperc').is(':checked')){
		
		jsonObj.push("TAX_RIDER_CMSN_PERC_"+loc);
		jsonObj.push($("#taxrdrcmsn").val());
	}
	if($('#taxrdrallwperkm').is(':checked')){
		
		jsonObj.push("TAX_RIDER_ALLOWANCE_PER_KM_"+loc);
		jsonObj.push($("#taxrdrallw").val());
	
	}
	if($('#cutoffflg').is(':checked')){
	
		jsonObj.push("DELV_"+loc+"_CUT_OFF_FLG");
		jsonObj.push($("#cutoffflag").val());
		
	}
	if($('#priceincrminfreq').is(':checked')){
	
		jsonObj.push("DELV_"+loc+"_PRICE_INCR_MINUTES_FREQ");
		jsonObj.push($("#priceincrminfrq").val());
	
	}
	if($('#priceincper').is(':checked')){
	
		jsonObj.push("DELV_"+loc+"_PRICE_INCR_PERC");
		jsonObj.push($("#priceincrperc").val());
	
	}
	//alert(JSON.stringify(jsonObj));
	$.ajax({
		url : $("#contextPath").val()+'/adm/setFields',
		type : 'POST',
		data :{"jsonObj":jsonObj},
		success:function(data){
		alert("Successfully Updated!!");
		}
	});
});
$('#buscutoff').click(function() {
	if($('#buscutoff').is(':checked')){
	$("#busscutofftimehr").removeAttr("disabled");
	$("#busscutofftimemin").removeAttr("disabled");
	}
	else{
		$("#busscutofftimehr").attr("disabled","disabled");
	$("#busscutofftimemin").attr("disabled","disabled");
	}
});
$('#busstarttime').click(function() {
	if($('#busstarttime').is(':checked')){
	$("#busstarttimehr").removeAttr("disabled");
	$("#busstarttimemin").removeAttr("disabled");
	}
	else{$("#busstarttimehr").attr("disabled","disabled");
	$("#busstarttimemin").attr("disabled","disabled");
	}
});
$('#bussendtime').click(function() {
	if($('#bussendtime').is(':checked')){
	$("#bussendtimehr").removeAttr("disabled");
	$("#bussendtimemin").removeAttr("disabled");
	}
	else{$("#bussendtimehr").attr("disabled","disabled");
	$("#bussendtimemin").attr("disabled","disabled");
	}
});
$('#taxrdrcmsnperc').click(function() {
	if($('#taxrdrcmsnperc').is(':checked')){
	$("#taxrdrcmsn").removeAttr("disabled");
	}
	else{
		$("#taxrdrcmsn").attr("disabled","disabled");
		}
});
$('#taxrdrallwperkm').click(function() {
	if($('#taxrdrallwperkm').is(':checked')){
	$("#taxrdrallw").removeAttr("disabled");
	}
	else{
		$("#taxrdrallw").attr("disabled","disabled");
	}
});
$('#cutoffflg').click(function() {
	if($('#cutoffflg').is(':checked')){
	$("#cutoffflag").removeAttr("disabled");
	}
	else{
		$("#cutoffflag").attr("disabled","disabled");
	}
});
$('#priceincrminfreq').click(function() {
	if($('#priceincrminfreq').is(':checked')){
	$("#priceincrminfrq").removeAttr("disabled");
	}
	else{
		$("#priceincrminfrq").attr("disabled","disabled");
	}
});
$('#priceincper').click(function() {
	if($('#priceincper').is(':checked')){
	$("#priceincrperc").removeAttr("disabled");
	}
	else{
		$("#priceincrperc").attr("disabled","disabled");
	}
});
$(".styled-checkbox").click(function(){
	$("#time_update").hide();
	$( ".styled-checkbox" ).each(function() {
		  if($(this).is(':checked')){
			 $("#time_update").show();
		  }
		});
		 
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
.formcls input {
	border-radius: 3px;
	border: 1px solid #dedede;
	margin-bottom: 15px;
	width: 100%;
/* 	height: 37px; */
	float: left;
	padding: 6px 15px;
}

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
								<span>Support Menu</span>
							</h5>
						</div>
						</div>
						<div class="row formcls srchCls">
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="row">

								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Location</label><br> 
									<select id="loc">
										<option value="">All Location</option>
										<c:forEach items="${allowedLocation}" var="allowedLoc">
											<option value="${allowedLoc}">${allowedLoc}</option>
										</c:forEach>
									</select>
								</div>
								</div>
								</div>
								</div>
								<div class="row formcls srchCls" id="details">
								
								<div class="col-md-1"></div>
						<div class="col-md-10 mr-auto" style="margin-top: 20px;">
							<div class="row">
								
								
								
								<div class="col-md-6 form-group">
								<div class="radio">
											<input class="styled-checkbox" id="busstarttime" type="checkbox" value="1">
    										<label for="busstarttime"><b>Configure Business Start Time</b></label>
										</div>
									
									<div class="row">
									<div class="col-md-6 form-group">
								<label for="pickdrop">Hours</label> 
									<select id="busstarttimehr" >
								<option value="00">00</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									</select>
									</div><div class="col-md-6 form-group">
									<label for="pickdrop">Mins</label>
									<select id="busstarttimemin">
									<option value="00">00</option>
									<option value="15">15</option>
									<option value="30">30</option>
									<option value="45">45</option>
									</select>
								</div>
								</div></div>
								
								<div class="col-md-6 form-group">
								<div class="radio">
											<input class="styled-checkbox" id="bussendtime" type="checkbox" value="1">
    										<label for="bussendtime"><b>Configure Business End Time</b></label>
										</div>
									
									
									<div class="row">
								<div class="col-md-6 form-group">
								<label for="pickdrop">Hours</label>
									<select id="bussendtimehr">
									<option value="00">00</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									</select></div>
									<div class="col-md-6 form-group">
									<label for="pickdrop">Mins</label>
									<select id="bussendtimemin">
									<option value="00">00</option>
									<option value="15">15</option>
									<option value="30">30</option>
									<option value="45">45</option></select>
									</div>
								</div></div>
								
								<div class="col-md-6 form-group">
								<div class="radio">
											<input class="styled-checkbox" id="buscutoff" type="checkbox" value="1">
    										<label for="buscutoff"><b>Configure Business CutOff Time</b></label>
										</div>
								
									<div class="row">
								<div class="col-md-6 form-group">
								<label for="pickdrop">Hours</label> 
									<select id="busscutofftimehr">
									<option value="00">00</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									</select>
									</div>
									<div class="col-md-6 form-group">
									<label for="pickdrop">Mins</label>
									<select id="busscutofftimemin">
									<option value="00">00</option>
									<option value="15">15</option>
									<option value="30">30</option>
									<option value="45">45</option></select>
									</div></div>
									</div>
								
								<div class="col-md-6 form-group">
								<div class="radio">
<!-- 											<input class="styled-checkbox" id="cutoffflg" type="checkbox" value="1"> -->
    										<label for="cutoffflg"><b>Cut Off Flag</b></label>
										</div>
								
									<label style="color: transparent"><b>Cut Off Flag</b></label>
									<input type="text" id="cutoffflag"></input>
									</div>
								
								
								<div class="col-md-6 form-group">
								<div class="radio">
<!-- 											<input class="styled-checkbox" id="taxrdrcmsnperc" type="checkbox" value="1"> -->
    										<label for="taxrdrcmsnperc"><b>Tax Rider Commission Percentage</b></label>
										</div>
								
									<input type="text" id="taxrdrcmsn"></input>
									</div>
									
						
								<div class="col-md-6 form-group">
								<div class="radio">
<!-- 											<input class="styled-checkbox" id="taxrdrallwperkm" type="checkbox" value="1"> -->
    										<label for="taxrdrallwperkm"><b>Tax Rider Allowance per Km Percentage</b></label>
										</div>
								
									<input type="text" id="taxrdrallw"></input>
									</div>
								<div class="col-md-6 form-group">
								<div class="radio">
<!-- 											<input class="styled-checkbox" id="priceincrminfreq" type="checkbox" value="1"> -->
    										<label for="priceincrminfreq"><b>Price Increment Minimum Frequency</b></label>
										</div>
								
									<input type="text" id="priceincrminfrq"></input>
									</div>
									
								<div class="col-md-6 form-group">
								<div class="radio">
<!-- 											<input class="styled-checkbox" id="priceincper" type="checkbox" value="1"> -->
    										<label for="priceincper"><b>Price Increment Percentage</b></label>
										</div>
									
									<input type="text" id="priceincrperc"></input>
									</div>
									
								<div class="col-md-12 form-group" style="text-align: center">
								
								
								<br>
									<button class=" btn btn-primary" id="time_update" style="display:none;">
										Update</button>
								
							</div>

				</div>
			</div></div></div></div>
			</section>
		</div>

	</div>


</body>
</html>