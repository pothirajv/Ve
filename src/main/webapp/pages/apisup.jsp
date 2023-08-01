<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>

<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBR8gfXIcdX2P2xl43xrDV13hqCLbsl5zk&libraries=places"></script>
<style>
.table-striped tbody tr:nth-of-type(odd){background-color:rgba(0,0,0,.05)}
.tablediv
{
border-radius: 2px;
    position: relative;
    border: 1px solid #eee;
    font-size: 13px;
    }
    dt
    {
    position: relative;
    border: 0;
    background: none;
    font-weight: bold;
    word-break: break-word;
    margin: 0 !important;
    width:auto;   
    float: left;
    clear: both;
    max-width: 48%;
    overflow: auto;
    padding-top: 20px;
    padding-left: 20px;
    line-height: 26px;
    }
      dd{
        line-height: 1.75;
    margin: 0;
    padding: 20px 40px 20px 50%;
    border-bottom: 1px solid #eee;
    font-size: 14px;
    }
#loginPageerrormsg {
	display: none;
	color: red;
    text-align: center;
    padding: 20px 0px;
}
#token {
	display: none;
	color: green;
    text-align: left;
    padding: 20px 0px;
}
.loginPageerrormsg {
	color: red;
	font-size: 14px;
	text-align: center;
	padding: 10px;
}
.row {
    display: flex;
    justify-content: space-around;
}
.col-md-6:nth-child(2){
  background: #333;
  width:100%;
}
#lname1{
background: transparent!important;
}
.col-md-6:nth-child(2) td:nth-child(2){
  word-break:break-all;
}
.col-md-6:nth-child(2) p span
{
color:#a2fca2!important
}
.col-md-6:nth-child(2) td:nth-child(1) p span,
.col-md-6:nth-child(2) h6
{
color:rgba(255,255,255,0.75)!important
}
.col-md-6:nth-child(2) tr:nth-child(5) td:nth-child(2) p span
{
color:#d36363!important
}
.col-md-6:nth-child(2) tr:nth-child(3) td:nth-child(2) p span
{
color:white!important
}
.col-md-6:nth-child(2) tr:nth-child(2) td:nth-child(2) p span,
.col-md-6:nth-child(2) tr:nth-child(6) td:nth-child(2) p span
{
color:#fcc28c!important
}

.col-md-6:nth-child(2) td
{
border:none!important;
 padding-top: 1em!important;
    padding-bottom: 1em!important;
}

.row div{
  padding:8px;
}
/* .row,.col-md-6:nth-child(2) */
/* {margin-left:8px;} */
.datatype{
background-color:#f1f1f1;
white-space: pre-wrap;
margin-right:10px;
color:#007bff;
font-weight:700;
font-size:larger!important;}
.mand{
color:red!important;}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
$(document).ready(function() {
	var autocomplete;
	$('#sendOtpBtn').click(function() {
		
		var mobNo = $('#u_pagemobno').val();
		if(mobNo == '') {
			$('#loginPageerrormsg').html('Enter mobile no.');
			$('#loginPageerrormsg').slideDown();
			return false;
		}
		
		$('#loginPageerrormsg').html('');
		$('#loginPageerrormsg').slideUp();
		
		var otpCnt = getCookie("otpcnt");
		if(otpCnt != undefined && otpCnt != null && otpCnt != '') {
			otpCnt = parseInt(otpCnt);
			if(otpCnt > 3) {
				alert('You have attempted 3 times. Please try after 2 minutes');
				return false;
			}
		}
		
		var registerModel = new Object();
		registerModel.mobileNumber = $('#u_pagemobno').val();
		$('.loadCls').show();
		$.ajax({
			url : 'a/sendotp',
			contentType : "application/json",
			method : 'POST',
			data : JSON.stringify(registerModel),
			success : function(data) {
				$('.loadCls').hide();
				$('#u_pageotp').val('');
				if (data != null) {
					if(data.responseText != null && data.responseText != '') {
						alert(data.responseText);
						if(data.responseText=="Mobile No. not registered yet")
							{
							$("#apiregister").slideDown();
							$("#login").slideUp();
							}
					} else {
						$('#sendOtpBtn').html('Resend OTP');
						var otpCnt = getCookie("otpcnt");
						if(otpCnt != undefined && otpCnt != null && otpCnt != '') {
							otpCnt = parseInt(otpCnt) + 1;
						} else {
							otpCnt = 1;
						}
						createCookie("otpcnt", otpCnt, 2)
						if(data.otp != 0)
							$('#u_pageotp').val(data.otp);
						alert('OTP sent');
							
						$("#otpdiv").slideDown();
					}
				}
			}
		});
	});
	
	$('#loginpageBtn').click(function() {
		
		var mobNo = $('#u_pagemobno').val();
		if(mobNo == '') {
			$('#loginPageerrormsg').html('Please enter mobile no.');
			$('#loginPageerrormsg').slideDown();
			return false;
		}
		
		var otpVar = $('#u_pageotp').val();
		if(otpVar == '') {
			$('#loginPageerrormsg').html('Please enter otp');
			$('#loginPageerrormsg').slideDown();
			return false;
		}
		
		$('#loginPageerrormsg').html('');
		$('#loginPageerrormsg').slideUp();
		
		$('.loadCls').show();
		var registerModel = new Object();
		registerModel.mobileNumber = $('#u_pagemobno').val();
		registerModel.otp = parseInt($('#u_pageotp').val());
	
		$.ajax({
			url : 'a/loginValidate1',
			contentType : "application/json",
			method : 'POST',
			data : JSON.stringify(registerModel),
			success : function(data) {
				if (data != null) {
					if (data.startsWith("SUCCESS")) {
						var viewName = data.split(":")[1];
						$('#loinbymobdiv').hide();
						document.querySelector('#tkn').scrollIntoView({
							  behavior: 'smooth' 
							});
						
						$('#token').html("<h6><b>Your Generated Token is:</b></h6>"+viewName);
						$('#token').slideDown();
						
						
						
						
					    $("#login").slideUp();
					} else {
						var errMsg = data.split(":")[1];
						$('#loginPageerrormsg').html(errMsg);
						$('#loginPageerrormsg').slideDown();
					}
				}
				$('.loadCls').hide();
			}
		});
	});
	$('#regbtn').click(
			function(event) {
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
				
				
				if($('#email').val() != '') {
					if(!validateEmail($('#email').val())) {
						$('#email').parent().find(".validation").addClass("showVal");
						$('#email').parent().find(".validation").html("Invalid email address");
						flag = false;
					} else {
						$('#email').parent().find(".validation").removeClass("showVal");
						$('#email').parent().find(".validation").html("");
					}
				}
				
				if($('#mobileNoId').val() != '') {
					if(!validateMobileNo($('#mobileNoId').val())) {
						$('#mobileNoId').parent().find(".validation").addClass("showVal");
						$('#mobileNoId').parent().find(".validation").html("Required 10 digits Only");
						flag = false;
					} else {
						$('#mobileNoId').parent().find(".validation").removeClass("showVal");
						$('#mobileNoId').parent().find(".validation").html("");
					}
				}
				
				
				if (flag == false) {
					event.preventDefault();
				} else {
					$('.loadCmnCls').show();
					
					var registerModel = new Object();
					registerModel.vendorFlag = true;
					registerModel.firstName = $('#fname').val();
					registerModel.lastName = $('#lname').val();
					registerModel.vendorName = $('#branhnm').val();
					registerModel.houseNo = $('#stname').val();
					registerModel.vendorGroupName = $('#nom').val();
					registerModel.streetName = $('#stname').val();
					registerModel.email = $('#email').val();
					registerModel.address = $('#address').val();
					registerModel.area = $('#area').val();
					registerModel.city = $('#city').val();
					registerModel.state = $('#state').val();
					registerModel.country = $('#country').val();
					registerModel.latitude = $('#lat').val();
					registerModel.longitude = $('#long').val();
					registerModel.mobileNumber = $('#mobileNoId').val();
					registerModel.hoFlag = false;
					$.ajax({
						url : "a/q1",
						contentType : 'application/json',
						method : 'POST',
						data : JSON.stringify(registerModel),
						success : function(data) {
							$('.loadCmnCls').hide();
							$('#email').parent().find(".validation").removeClass("showVal");
							$('#email').parent().find(".validation").html("");
							
							$('#mobileNoId').parent().find(".validation").removeClass("showVal");
							$('#mobileNoId').parent().find(".validation").html("");
							
							if (data != null) {
								
									if (data.startsWith("SUCCESS")) {
										var viewName = data.split(":")[1];
										//alert(viewName);
// 										$('#token').html("<h6><b>Your Generated Token is:</b></h6>"+viewName);
// 										$('#token').slideDown();
										alert("Our Team will contact you after validating your information!!!")
										$("#apiregister").slideUp();
									} else {
										var errMsg = data.split(":")[1];
										$('#loginPageerrormsg').html(errMsg);
										$('#loginPageerrormsg').slideDown();
									}
									
									if(errMsg == "Email already exist"){
										$('#email').parent().find(".validation").addClass("showVal");
										$('#email').parent().find(".validation").html(errMsg);
									}else if(errMsg == "Mobile no. already exist"){
										$('#mobileNoId').parent().find(".validation").addClass("showVal");
										$('#mobileNoId').parent().find(".validation").html(errMsg);
									}
									
							}
							},
						error : function(data,status,er) {
							alert('Problem in register');
							$('.loadCmnCls').hide();
						}
					});
				}
			});
	
	function validateEmail(mail) {
		if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
			return (true)
		}
		return (false)
	}
	$('#generatetoken').click(function(){
		$("#login").slideDown();
		$([document.documentElement, document.body]).animate({
	        scrollTop: $(".modal-header").offset().top
	    }, 100);
		$("#generatetoken").slideUp();
	});
});

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function createCookie(name,value,minutes) {
    if (minutes) {
        var date = new Date();
        date.setTime(date.getTime()+(minutes*60*1000));
        var expires = "; expires="+date.toGMTString();
    } else {
        var expires = "";
    }
    document.cookie = name+"="+value+expires+"; path=/";
}
function getGoogleAddress(){
	var autocomplete;
	 autocomplete = new google.maps.places.Autocomplete(document
				.getElementById('address'));

		autocomplete.setFields(['address_component', 'geometry']);
		
		autocomplete.addListener('place_changed', function(){
			var place = autocomplete.getPlace();
			
			 if ($.type(place.geometry) !='undefined' && $.type(place.address_components)!='undefined') {
				 
					$('#lat').val(place.geometry.location.lat());
					$('#long').val(place.geometry.location.lng());
					
					for (var i = 0; i < place.address_components.length; i++) {
						var d = place.formatted_address;
						var addressType = place.address_components[i].types[0];
						if (componentForm[addressType]) {
							var val = place.address_components[i][componentForm[addressType]];
							
							if(addressType == 'locality') {
								$('#city').val(val);
							} else if(addressType == 'sublocality_level_1') {
								$('#area').val(val);
							} else if(addressType == 'administrative_area_level_1') {
								$('#state').val(val);
							} else if(addressType == 'country') {
								$('#country').val(val);
							}
							
						}
					}
			 }else{
				 alert("Please Select valid address...")
				 $("#address").val("");
			 }
		});
}

function geolocate() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var geolocation = {
				lat : position.coords.latitude,
				lng : position.coords.longitude
			};
			var circle = new google.maps.Circle({
				center : geolocation,
				radius : position.coords.accuracy
			});
			autocomplete.setBounds(circle.getBounds());
		});
	}
}
function validateMobileNo(mobile) {
	if (mobile.length!=10) {
		return (false)
	}
	return (true)
}

</script>


<style type="text/css">
html {
  scroll-behavior: smooth;
}
table
{
width:100%;
}
p span
{
color:black!important;
}
</style>
</head>

   <body lang=EN-IN link=blue vlink=purple style='word-wrap:break-word'>
      <div class="split left">
         <div class=row>
            <div class="col-md-1"></div>
            <div class="col-md-10">
               <div class=WordSection1>
                  <p class=MsoNormal><span style='line-height:115%;font-family:
                     '>&nbsp;</span></p>
                  
                  <br>
                  <p>
                  Vedagram APIs  are based on REST and  uses JWT authentication for all the api request and all the responses are returned as JSON.
                  </p><br>
                  <p>Unique API Token is generated for each customer to avail the API services provided by Vedagram. Customers  are requested to Generate API token first with the TEST mode, Once successfully connected to the Test Mode, they need to send mail to <b>pickdrop24*7@gmail.com</b> for creating Unique API Token for the Live Mode.
                  </p><br>
                   <p id="tkn"><b>Generate API Token</b></p>
                  <br>
                  <aside>
                     <div><button type="button" class="btn btn-primary" id="generatetoken">Generate Token</button></div>
                  </aside>
                  <div class="modal-dialog" role="document" id="login" style="display:none; margin-left: 0px!important">
                     <div class="modal-content" style="border:none">
                        <div class="loadCls"></div>
                        <div class="modal-header" style="border-bottom:none">
                           <h5 class="font-weight-bold col-12 modal-title text-left">Generate Token</h5>
                        </div>
                        <div class="modal-body formcls">
                           <div id="loginPageerrormsg"></div>
                           <div class="form-group row1" style="font-size: 14px;">
                           </div>
                           <div class="loinbymobdiv" style="display: block;">
<!--                               <div class="form-group"> -->
<!-- 								<label>Mobile No.</label><div><input type="text" class="form-control" -->
<!--                                     required="required" id="u_pagemobno" style="width:50%!important; margin-right:10%"><span class="mobile-pre-ex">+91</span><button type="button" class="btn btn-primary" id="sendOtpBtn">Send -->
<!--                                  OTP</button></div> -->
<!--                               </div> -->
										<div class="form-group">
										<p>Mobile No</p>
										<input type="number" name="" style="padding-left: 40px;" id="u_pagemobno" class="required" minlength="10" maxlength="10" placeholder="Ex. 9696969696" />
										<span class="mobile-pre-ex">+91</span>
										<br><div class="validation"></div>
										<button type="button" class="btn btn-primary" id="sendOtpBtn">Send OTP</button>
									</div>
                              <div class="form-group" id="otpdiv" style="display:none">
                                 <div class="clearfix">
                                    <label>OTP</label>
                                 </div><div>
                                 <input type="password" class="form-control" required="required"
                                    id="u_pageotp" style="width:50%!important ; margin-right:10%"> <button type="button" class="btn btn-primary" id="loginpageBtn">Generate Token</button></div>
                              </div> 
                           </div>
                        </div>
                     </div>
                  </div>
                  <div id="token"></div>
                  <div class="wrapper" id="apiregister" style="display:none">
                     <div class="top-strip ">
                        <!-- contact section -->
                        <section class="layout_padding">
                           <div class="container">
                              <h5 class="font-weight-bold" style="text-align: left;">Vendor Registration for Token Generation</h5>
                              <form>
                                 <div class="contentform row formcls">
                                   
                                    <div class="col-md-10">
                                       <div class="row">
                                          <div class="col-md-6">
                                             <div class="form-group">
                                                <p>First Name <span>*</span></p>
                                                <input type="text" name="fname" id="fname" class="required" placeholder="First Name" /> <br>
                                                <div class="validation"></div>
                                             </div>
                                          </div>
                                          <div class="col-md-6" id="lname1">
                                             <div class="form-group">
                                                <p>Last Name</p>
                                                <input type="text" name="lname" id="lname" placeholder="Last Name"/> <br>
                                                <div class="validation"></div>
                                             </div>
                                          </div>
                                          <div class="col-md-6">
                                             <div class="form-group">
                                                <p>Business / Shop Name <span>*</span></p>
                                                <div id="nomDiv" style="padding:0px!important">
                                                   <input type="text" name="nom" id="nom" class="required" placeholder="Business/Shop Name" />
                                                   <div class="validation"></div>
                                                </div>
                                             </div>
                                          </div>
                                          <div class="col-md-6">
                                             <div class="form-group">
                                                <p>House / Street Name <span>*</span></p>
                                                <input type="text" name="stname" id="stname" class="required" placeholder="Street Name" /> <br>
                                                <div class="validation"></div>
                                             </div>
                                          </div>
                                          <div class="col-md-6">
                                             <div class="form-group">
                                                <p>Mobile No <span>*</span></p>
                                                <input type="number" name="" style="padding-left: 40px;" id="mobileNoId" class="required" minlength="10" maxlength="10" placeholder="Ex. 9696969696" />
                                                <span class="mobile-pre-ex">+91</span>
                                                <br>
                                                <div class="validation"></div>
                                             </div>
                                          </div>
                                          <div class="col-md-6">
                                             <div class="form-group">
                                                <p>E-mail <span>*</span></p>
                                                <input type="text" name="email" id="email" class="required" placeholder="Ex. test@test.com" />
                                                <br>
                                                <div class="validation"></div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                      <div class="col-md-1"></div>
                                         <div class="col-md-1"></div>
                                    <div class="col-md-6">
                                       <div class="quote_btn-container">
                                          <!-- 				              <a href="" onclick="return false;" id="regbtn" style="font-size: 16px;">Register</a> -->
                                          <button type="button" class="btn btn-primary" id="regbtn">Register</button>
                                       </div>
                                    </div>
                                  
                                 
                                    <div class="col-md-5"></div>
                                    
                                    <div class="col-md-1"></div>
                                 </div>
                              </form>
                           </div>
                        </section>
                     </div>
                  </div>
                  
                  <br>
                 
                  <h4><b>API REFERENCE GUIDE</b> </h4>
                  <p>API URL for the Test mode is <b> https://groupnpay.com/pickdrop/</b>
                  </p><br>
                  <p class=MsoNormal>
                  <h6><b><span style='line-height:115%;
                     font-family:'>API Authorization:</span></b></h6>
                  </p>
                  <p>
                  All Pickdrop API are authorized using Basic authorization, it requires Key and Value as below  in the Header</p><br>
                  <p><b>
                  "key":"Authorization"</b></p><br>
                  <p><b>"value":"Bearer COPY_PASTE_THE_GIVEN_TOKEN"</b></p><br>
                  <br>
                 <p><b>Note:Fields with <span class="mand">*</span> are mandatory.</b></p>
                  <br>
<div class="row">


	<div class="col-md-6">
	<p><h5> <b>Get Rates</b></h5></p><br>
<p>GetRates API: Endpoint calculates the Rate for the Given PickUp and Drop address and returns the DeliveryCharge as response. If the given address is not under the Serivce limit, error message will be returned with deliveryCharge as '0'.
Following are the parameters which needs to be sent to calculate the rate.</p>
</p><br>
<h6><span
                              style='font-family:'><b>Field
                           Specification for Get Rates</b></span></h6></b></p>

<div class="tablediv">
<article>

<dt>sendFrom<span class="mand">*</span></dt><dd><code class="datatype">Text</code>15 character length, Value can be one of the below Chennai,Salem,Bengaluru,Coimbatore</dd>
<dt>weight</dt><dd><code class="datatype">Number</code>Maximum 15 kg</dd>
<dt>pickupLatitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address latitude</dd>
<dt>pickupLongitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address longitude</dd>
<dt>dropLatitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address latitude</dd>
<dt>dropLongitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address longitude</dd>
<dt>distance</dt><dd><code class="datatype">Number</code>If not given then we will calculate with latitude and longitude</dd></article></div> <br>
<div class="tablediv">
<article>
<dt>Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Success</dd>
<dt>deliveryCharge</dt><dd><code class="datatype">Number</code>Provides the calculated delivery charge for the given pickup and drop address</dd>
<dt>Error Message</dt><dd><code class="datatype">Text</code></dd>

</article>
</div>




	</div>
					 
					 
					 
					 
					 	<div class="col-md-6">
						<p class=MsoNormal>
                     <b>
                  <h6><span id="getrates" style='line-height:115%;font-family:
                     '>Sample Request for Get Rates</span></h6></b></p> 
	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                     style='border-collapse:collapse;border:none'>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td valign=top style='border:solid black 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Get Rates</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              /api/v1/getRates</span>
                           </p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;sendFrom&quot;:&quot;Bengaluru&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;weight&quot;:&quot;3&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLatitude&quot;:&quot;13.0567009&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLongitude&quot;:&quot;80.1426371&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLatitude&quot;:&quot;12.9929222&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLongitude&quot;:&quot;80.2197077&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>"distance":"10
                              KM"</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;packageStatus&quot;:
                              &quot;SUCCESS&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;deliveryCharge&quot;:
                              80.0</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border-top:none;border-left:solid black 1.0pt;
                           border-bottom:solid windowtext 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;errorMessage&quot;:
                              &quot;We are sorry.We don't have service in 'dfsa'. Current service areas are
                              Chennai,Salem,Bengaluru,Coimbatore&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;deliveryCharge&quot;:
                              0.0</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr style='height:4.0cm'>
                        <td valign=top style='border-top:none;border-left:solid black 1.0pt;
                           border-bottom:solid windowtext 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&quot;}]</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
					 </table>
	</div>
	</div>
	
	
	
	
	
	
	


	
<div class="row">	
	<div class="col-md-6">
	<p><b><h5>	Create Delivery</h5></b></p><br>
<p>CreateDelivery books a package with the Order id and other required details given by the customer
and returns  Success response as OPEN or NOT CREATED otherwise error response as CONFLICT with appropriate error message.

Following are the parameters which needs to be sent to book the package</p><br>


</p>
<h6><span style='line-height:115%;
                     font-family:'><b>Field Specification for Create Delivery</b></span></h6>
<div class="tablediv">
<article>

<dt>sendFrom<span class="mand">*</span></dt><dd><code class="datatype">Text</code>15 character length, Value can be one of the below Chennai,Salem,Bengaluru,Coimbatore</dd>
<dt>weight</dt><dd><code class="datatype">Number</code>Maximum 15 kg</dd>
<dt>pickupLatitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address latitude</dd>
<dt>pickupLongitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address longitude</dd>
<dt>dropLatitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address latitude</dd>
<dt>dropLongitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address longitude</dd>
<dt>parcelType<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Parcel type can be any one of the below Document/Books,Electronics,Food/Medicine/Vegetables,Metal,Dress,Others</dd>
<dt>packagePickupAddress<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Maximum 150char,Address should always end with pincode (6 digits)</dd>
<dt>receiverAddress<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Maximum 150char,Address should always end with pincode (6 digits)</dd>
<dt>receiverName<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Text 25 character length Name of the receiver</dd>
<dt>receiverContact<span class="mand">*</span></dt><dd><code class="datatype">Number</code>Number 10 digit Contact Number of the receiver</dd>
<dt>orderId</dt><dd><code class="datatype">Text</code>Merchants Order id</dd>
<dt>senderContact</dt><dd><code class="datatype">Number</code>10 digit sender contact number</dd>
<dt>merchantName</dt><dd><code class="datatype">Text</code>15 character length merchant BusinessNname</dd>
<dt>codFlag</dt><dd><code class="datatype">Text</code>True/False</dd>
<dt>codAmount</dt><dd><code class="datatype">Number</code>Amount to be collected</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Success Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either OPEN or NOTCREATED</dd>
<dt>trackingId</dt><dd><code class="datatype">Text</code>Tracking Id</dd>
<dt>traceId	</dt><dd><code class="datatype">Text</code>Trace Id</dd>
<dt>deliveryCharge</dt><dd><code class="datatype">Number</code>Delivery charge for the delivery</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Error Response</dt><dd></dd>
<dt>Status</dt><dd><code class="datatype">Text</code>if any of the mandatory field is missing corresponding error message will be sent</dd>
<dt>timeStamp</dt><dd><code class="datatype">Text</code>Date and time</dd>
<dt>Message</dt><dd><code class="datatype">Text</code>Error Message</dd>
<dt>debugMessage</dt><dd><code class="datatype">Text</code>Error Message</dd>


</article>
</div>
	</div>
	<div class="col-md-6">
<h6><span id="createdelivery"
                              style=''><b>Sample Request for Create Delivery</b><br></span></h6>
							  <table class=MsoTableGrid cellspacing=0 cellpadding=0
                     style='border-collapse:collapse; margin-bottom:40px;
                     '>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>CreateDelivery</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>/api/v1/createDelivery</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;sendFrom&quot;:&quot;Bengaluru&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;weight&quot;:&quot;3&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLatitude&quot;:&quot;13.0567009&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLongitude&quot;:&quot;80.1426371&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLatitude&quot;:&quot;12.9929222&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLongitude&quot;:&quot;80.2197077&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;parcelType&quot;:&quot;Groceries&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;packagePickupAddress&quot;:&quot;No.
                              425/A, 11th Cross, Peenya 4th Phase Peenya Industrial Area, Yeswanthpur,
                              Bengaluru, Karnataka, 560058&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;recieverAddress&quot;:&quot;No.
                              425/A, 11th Cross, Peenya 4th Phase Peenya Industrial Area, Yeswanthpur,
                              Bengaluru, Karnataka, 560057&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;recieverName&quot;:&quot;abcd&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;recieverContact&quot;:&quot;2309824933&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;orderId&quot;:&quot;12134567890&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;senderContact&quot;:&quot;9876543210&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;merchantName&quot;:&quot;Saukhya&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;codFlag&quot;:true,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;codAmount&quot;:&quot;500&quot;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;OPEN&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;trackingId&quot;: &quot;5bd9631db009fb2ff8815375&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;8d78a78a9c5e4e06b4ff8c0dfcd4a541&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;<span
                              class=p-name><span >deliveryCharge</span></span>
                              &quot;: &quot;<span class=number><span >100.0</span></span>&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>OR</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;NOTCREATED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;a8c799247d9e46f2bbc110927c0345e9&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:409</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;status&quot;: &quot;CONFLICT&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;<b>timestamp</b>&quot;:
                              &quot;31-10-2018 04:12:35&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;message&quot;: &quot;packagePickupAddress must not be null&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;debugMessage&quot;: null</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer&lt;<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&gt;"}</span></p>
                        </td>
                     </tr>
                  </table>
	</div>
</div>

<div class="row">	
	<div class="col-md-6">
	<p><b><h5>
	Cancel Delivery</h5></b></p><br>
<p>Cancel delivery, cancels the package already booked with trackingId as the input and returns successful response as CANCEL OR RETURN and error is returned as response if PACKAGE_NOT_FOUND or if the package is already been DELIVERED.
Following are the parameters which needs to be sent to cancel the package</p><br>

</p><h6><span style='line-height:115%;
                     font-family:'><b>Field Specification for Cancel Delivery</b></span></h6>
<div class="tablediv">
<article>

<dt>trackingId</dt><dd><code class="datatype">Text</code>Tracking ID as input</dd>
<dt>Success Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either CANCEL or RETURN</dd>
<dt>traceId</dt><dd><code class="datatype">Text</code>Trace Id</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Error Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either PACKAGE_NOT_FOUND or DELIVERED</dd>
<dt>traceId</dt><dd><code class="datatype">Text</code>Trace ID</dd>
<dt>packagePickupAddress<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Maximum 150char,Address should always end with pincode (6 digits)</dd>


</article>
</div>

	</div>
	<div class="col-md-6">
<h6><span id="createdelivery"
                              style=''><b>Sample Request for Cancel Delivery</b><br></span></h6>
							  <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                     style='border-collapse:collapse;
                     border:none'>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border:solid black 1.0pt;
                           border-left:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Cancel Delivery</span></p>
                        </td>
                     </tr>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>/api/v1/cancelDelivery</span></p>
                        </td>
                     </tr>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;trackingId&quot;:&quot;5bd96a73b009fb2ff881538e&quot;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;CANCEL&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;f63c748ce0a04ed4b117932179e03e25&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>OR</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;RETURN&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;f63c748ce0a04ed4b117932179e03e25&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:89.9pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:89.9pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:89.9pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;PACKAGE_NOT_FOUND&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;285fb08e30ea410da854eedf178d4c54&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;DELIVERED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;732d79ecddee43c4a1d8043130b26108&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:98.65pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:98.65pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:98.65pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&quot;}]</span></p>
                        </td>
                     </tr>
                  </table>
	</div>
</div>
<div class="row">	
	<div class="col-md-6">
	<p><b><h5>Get Delivery Status </h5></b><br>
	<p>GetDeliveryStatus, fetches the status of the package and returns the response as  ASSIGNED OR DELIVERED and error response as PACKAGE_NOT_FOUND if the package is not found.
Following are the parameters which needs to be sent to cancel the package
</p><br>
<h6><span style='line-height:115%;
                     font-family:'><b>Field Specification for Get Delivery Status</b></span></h6>
<div class="tablediv">
<article>

<dt>trackingId</dt><dd><code class="datatype">Text</code>Tracking ID as input</dd>
<dt>Success Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either CANCEL or RETURN</dd>
<dt>trackingId</dt><dd><code class="datatype">Text</code>Text Tracking id of the booked package</dd>
<dt>traceId</dt><dd><code class="datatype">Text</code>Text Trace Id is used to trace the request log file</dd>
<dt>transporterName</dt><dd><code class="datatype">Text</code>Text Name of the deliverer</dd>
<dt>transporterContact</dt><dd><code class="datatype">Number</code>10 digit mobile no</dd>
<dt>pickedUpDate</dt><dd><code class="datatype">DateTime</code>Picked up date</dd>
<dt>deliveredDate</dt><dd><code class="datatype">DateTime</code>Delivered date and time</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Error Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>ASSIGNED : Assigned to a Deliverer<br>
PICKEDUP : Picked Up for delivery<br>
CANCEL : Request cancelled by the sender<br>
RETURN : Return of the Package requested<br>
RETURNED : Package returned to the Sender<br>
DELIVERED : Package delivered<br>
PACKAGE_NOT_FOUND : There is no such request found</dd>

</article>
</div>

				  </div>
	<div class="col-md-6">
<h6><span id="createdelivery"
                              style=''><b>Sample Request for Get Delivery Status</b><br></span></h6>
							  <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 
                     style='border-collapse:collapse;border:
                     none'>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border:solid black 1.0pt;
                           border-left:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Get Delivery
                              Status</span>
                           </p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>/api/v1/getDeliveryStatus</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;trackingId&quot;:&quot;5bd9803db009fb2a74e75763&quot;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;ASSIGNED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;trackingId&quot;: &quot;5bd9803db009fb2a74e75763&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;5b93ab89cf4a438f9d10f9d66c63d0a1&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;transporterName&quot;: &quot;VIJAYSHANKAR&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;transporterContact&quot;:
                              &quot;7358410026&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>OR</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;DELIVERED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;trackingId&quot;: &quot;5bd96443b009fb2ff8815379&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;ef1410cffb3242978f9b01bc9b20d7e7&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;transporterName&quot;: &quot;VIJAYSHANKAR&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;transporterContact&quot;: &quot;7358410026&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;pickedUpDate&quot;:
                              &quot;2018-10-31T08:22:19.051+0000&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;deliveredDate&quot;: &quot;2018-10-31T08:38:27.223+0000&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;PACKAGE_NOT_FOUND&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:4.0cm'>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&quot;}]</span></p>
                        </td>
                     </tr>
                  </table>
				  	</div>
</div>


<div class="row">


	<div class="col-md-6">
	<p><h5> <b>Get Schedule Rates</b></h5></p><br>
<p>GetRates API: Endpoint calculates the Rate for the Given PickUp and Drop address and returns the DeliveryCharge as response. If the given address is not under the Serivce limit, error message will be returned with deliveryCharge as '0'.
Following are the parameters which needs to be sent to calculate the rate.</p>
</p><br>
<h6><span
                              style='font-family:'><b>Field
                           Specification for Get Schedule Rates</b></span></h6></b></p>

<div class="tablediv">
<article>

<dt>sendFrom<span class="mand">*</span></dt><dd><code class="datatype">Text</code>15 character length, Value can be one of the below Chennai,Salem,Bengaluru,Coimbatore</dd>
<dt>weight</dt><dd><code class="datatype">Number</code>Maximum 15 kg</dd>
<dt>pickupLatitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address latitude</dd>
<dt>pickupLongitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address longitude</dd>
<dt>dropLatitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address latitude</dd>
<dt>dropLongitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address longitude</dd>
<dt>distance</dt><dd><code class="datatype">Number</code>If not given then we will calculate with latitude and longitude</dd>
<dt>scheduleDt</dt><dd><code class="datatype">String</code>Date in the format 'yyyy-MM-dd'</dd>
<dt>scheduleTm</dt><dd><code class="datatype">String</code>Time in the format 'hh:mm aa'</dd></article></div> <br>
<div class="tablediv">
<article>
<dt>Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Success</dd>
<dt>deliveryCharge</dt><dd><code class="datatype">Number</code>Provides the calculated delivery charge for the given pickup and drop address</dd>
<dt>Error Message</dt><dd><code class="datatype">Text</code></dd>

</article>
</div>




	</div>
					 
					 
					 
					 
					 	<div class="col-md-6">
						<p class=MsoNormal>
                     <b>
                  <h6><span id="getrates" style='line-height:115%;font-family:
                     '>Sample Request for Get Schedule Rates</span></h6></b></p> 
	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                     style='border-collapse:collapse;border:none'>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td valign=top style='border:solid black 1.0pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Get Schedule Rates</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              /api/v1/getScheduleRates</span>
                           </p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;sendFrom&quot;:&quot;Bengaluru&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;weight&quot;:&quot;3&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLatitude&quot;:&quot;13.0567009&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLongitude&quot;:&quot;80.1426371&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLatitude&quot;:&quot;12.9929222&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLongitude&quot;:&quot;80.2197077&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>"distance":"10 KM,"</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>"scheduleDt":"2022-07-10,"</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>"scheduleTm":"10:30 AM"</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;packageStatus&quot;:
                              &quot;SUCCESS&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;deliveryCharge&quot;:
                              80.0</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border-top:none;border-left:solid black 1.0pt;
                           border-bottom:solid windowtext 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;errorMessage&quot;:
                              &quot;We are sorry.We don't have service in 'dfsa'. Current service areas are
                              Chennai,Salem,Bengaluru,Coimbatore&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;deliveryCharge&quot;:
                              0.0</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr style='height:4.0cm'>
                        <td valign=top style='border-top:none;border-left:solid black 1.0pt;
                           border-bottom:solid windowtext 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&quot;}]</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
					 </table>
	</div>
	</div>
	
	
	
	
	
	
	


	
<div class="row">	
	<div class="col-md-6">
	<p><b><h5>	Schedule Delivery</h5></b></p><br>
<p>ScheduleDelivery books a package with the Order id and other required details given by the customer
and returns  Success response as OPEN or NOT CREATED otherwise error response as CONFLICT with appropriate error message.

Following are the parameters which needs to be sent to book the package</p><br>


</p>
<h6><span style='line-height:115%;
                     font-family:'><b>Field Specification for Schedule Delivery</b></span></h6>
<div class="tablediv">
<article>

<dt>sendFrom<span class="mand">*</span></dt><dd><code class="datatype">Text</code>15 character length, Value can be one of the below Chennai,Salem,Bengaluru,Coimbatore</dd>
<dt>weight</dt><dd><code class="datatype">Number</code>Maximum 15 kg</dd>
<dt>pickupLatitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address latitude</dd>
<dt>pickupLongitude</dt><dd><code class="datatype">Decimal</code>Provide the pickup address longitude</dd>
<dt>dropLatitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address latitude</dd>
<dt>dropLongitude</dt><dd><code class="datatype">Decimal</code>Provide the drop address longitude</dd>
<dt>parcelType<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Parcel type can be any one of the below Document/Books,Electronics,Food/Medicine/Vegetables,Metal,Dress,Others</dd>
<dt>packagePickupAddress<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Maximum 150char,Address should always end with pincode (6 digits)</dd>
<dt>receiverAddress<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Maximum 150char,Address should always end with pincode (6 digits)</dd>
<dt>receiverName<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Text 25 character length Name of the receiver</dd>
<dt>receiverContact<span class="mand">*</span></dt><dd><code class="datatype">Number</code>Number 10 digit Contact Number of the receiver</dd>
<dt>orderId</dt><dd><code class="datatype">Text</code>Merchants Order id</dd>
<dt>senderContact</dt><dd><code class="datatype">Number</code>10 digit sender contact number</dd>
<dt>merchantName</dt><dd><code class="datatype">Text</code>15 character length merchant BusinessNname</dd>
<dt>codFlag</dt><dd><code class="datatype">Text</code>True/False</dd>
<dt>codAmount</dt><dd><code class="datatype">Number</code>Amount to be collected</dd>
<dt>scheduleDt</dt><dd><code class="datatype">String</code>Date in the format 'yyyy-MM-dd'</dd>
<dt>scheduleTm</dt><dd><code class="datatype">String</code>Time in the format 'hh:mm aa'</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Success Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either OPEN or NOTCREATED</dd>
<dt>trackingId</dt><dd><code class="datatype">Text</code>Tracking Id</dd>
<dt>traceId	</dt><dd><code class="datatype">Text</code>Trace Id</dd>
<dt>deliveryCharge</dt><dd><code class="datatype">Number</code>Delivery charge for the delivery</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Error Response</dt><dd></dd>
<dt>Status</dt><dd><code class="datatype">Text</code>if any of the mandatory field is missing corresponding error message will be sent</dd>
<dt>timeStamp</dt><dd><code class="datatype">Text</code>Date and time</dd>
<dt>Message</dt><dd><code class="datatype">Text</code>Error Message</dd>
<dt>debugMessage</dt><dd><code class="datatype">Text</code>Error Message</dd>


</article>
</div>
	</div>
	<div class="col-md-6">
<h6><span id="createdelivery"
                              style=''><b>Sample Request for Schedule Delivery</b><br></span></h6>
							  <table class=MsoTableGrid cellspacing=0 cellpadding=0
                     style='border-collapse:collapse; margin-bottom:40px;
                     '>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>ScheduleDelivery</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>/api/v1/scheduleDelivery</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;sendFrom&quot;:&quot;Bengaluru&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;weight&quot;:&quot;3&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLatitude&quot;:&quot;13.0567009&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;pickupLongitude&quot;:&quot;80.1426371&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLatitude&quot;:&quot;12.9929222&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;dropLongitude&quot;:&quot;80.2197077&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;parcelType&quot;:&quot;Groceries&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;packagePickupAddress&quot;:&quot;No.
                              425/A, 11th Cross, Peenya 4th Phase Peenya Industrial Area, Yeswanthpur,
                              Bengaluru, Karnataka, 560058&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;recieverAddress&quot;:&quot;No.
                              425/A, 11th Cross, Peenya 4th Phase Peenya Industrial Area, Yeswanthpur,
                              Bengaluru, Karnataka, 560057&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;recieverName&quot;:&quot;abcd&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;recieverContact&quot;:&quot;2309824933&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;orderId&quot;:&quot;12134567890&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;senderContact&quot;:&quot;9876543210&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;merchantName&quot;:&quot;Saukhya&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;codFlag&quot;:true,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;codAmount&quot;:&quot;500&quot;,</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>"scheduleDt":"2022-07-10",</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>"scheduleTm":"10:30 AM"</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;OPEN&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;trackingId&quot;: &quot;5bd9631db009fb2ff8815375&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;8d78a78a9c5e4e06b4ff8c0dfcd4a541&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;<span
                              class=p-name><span >deliveryCharge</span></span>
                              &quot;: &quot;<span class=number><span >100.0</span></span>&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>OR</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;NOTCREATED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;a8c799247d9e46f2bbc110927c0345e9&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:409</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;status&quot;: &quot;CONFLICT&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;<b>timestamp</b>&quot;:
                              &quot;31-10-2018 04:12:35&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;message&quot;: &quot;packagePickupAddress must not be null&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;debugMessage&quot;: null</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td valign=top style='border:solid black 1.0pt;border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td valign=top style='border-top:none;border-left:none;border-bottom:solid black 1.0pt;
                           border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer&lt;<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&gt;"}</span></p>
                        </td>
                     </tr>
                  </table>
	</div>
</div>

<div class="row">	
	<div class="col-md-6">
	<p><b><h5>
	Cancel Schedule</h5></b></p><br>
<p>Cancel schedule, cancels the package already scheduled for delivery with trackingId as the input and returns successful response as CANCEL OR RETURN and error is returned as response if PACKAGE_NOT_FOUND or if the package is already been DELIVERED.
Following are the parameters which needs to be sent to cancel the package</p><br>

</p><h6><span style='line-height:115%;
                     font-family:'><b>Field Specification for Cancel Schedule</b></span></h6>
<div class="tablediv">
<article>

<dt>trackingId</dt><dd><code class="datatype">Text</code>Tracking ID as input</dd>
<dt>Success Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either CANCEL or RETURN</dd>
<dt>traceId</dt><dd><code class="datatype">Text</code>Trace Id</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Error Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either PACKAGE_NOT_FOUND or DELIVERED</dd>
<dt>traceId</dt><dd><code class="datatype">Text</code>Trace ID</dd>
<dt>packagePickupAddress<span class="mand">*</span></dt><dd><code class="datatype">Text</code>Maximum 150char,Address should always end with pincode (6 digits)</dd>


</article>
</div>

	</div>
	<div class="col-md-6">
<h6><span id="scheduledelivery"
                              style=''><b>Sample Request for Cancel Schedule</b><br></span></h6>
							  <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
                     style='border-collapse:collapse;
                     border:none'>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border:solid black 1.0pt;
                           border-left:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Cancel Schedule</span></p>
                        </td>
                     </tr>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>/api/v1/cancelSchedule</span></p>
                        </td>
                     </tr>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;trackingId&quot;:&quot;5bd96a73b009fb2ff881538e&quot;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:6.25pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:6.25pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;CANCEL&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;f63c748ce0a04ed4b117932179e03e25&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>OR</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;RETURN&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;f63c748ce0a04ed4b117932179e03e25&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:89.9pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:89.9pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:89.9pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;PACKAGE_NOT_FOUND&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;285fb08e30ea410da854eedf178d4c54&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;DELIVERED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;732d79ecddee43c4a1d8043130b26108&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:98.65pt'>
                        <td width=184 valign=top style='width:137.7pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:98.65pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td width=473 valign=top style='width:354.65pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:98.65pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&quot;}]</span></p>
                        </td>
                     </tr>
                  </table>
	</div>
</div>
<div class="row">	
	<div class="col-md-6">
	<p><b><h5>Get Delivery Status For Schedule </h5></b><br>
	<p>GetDeliveryStatus, fetches the status of the package and returns the response as  ASSIGNED OR DELIVERED and error response as PACKAGE_NOT_FOUND if the package is not found.
Following are the parameters which needs to be sent to cancel the package
</p><br>
<h6><span style='line-height:115%;
                     font-family:'><b>Field Specification for Get Delivery Status for Schedule</b></span></h6>
<div class="tablediv">
<article>

<dt>trackingId</dt><dd><code class="datatype">Text</code>Schedule Tracking ID as input</dd>
<dt>Success Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>Either CANCEL or RETURN</dd>
<dt>trackingId</dt><dd><code class="datatype">Text</code>Text Tracking id of the booked package</dd>
<dt>traceId</dt><dd><code class="datatype">Text</code>Text Trace Id is used to trace the request log file</dd>
<dt>transporterName</dt><dd><code class="datatype">Text</code>Text Name of the deliverer</dd>
<dt>transporterContact</dt><dd><code class="datatype">Number</code>10 digit mobile no</dd>
<dt>pickedUpDate</dt><dd><code class="datatype">DateTime</code>Picked up date</dd>
<dt>deliveredDate</dt><dd><code class="datatype">DateTime</code>Delivered date and time</dd></article></div><br>
<div class="tablediv">
<article>
<dt>Error Response</dt><dd></dd>
<dt>packageStatus</dt><dd><code class="datatype">Text</code>ASSIGNED : Assigned to a Deliverer<br>
PICKEDUP : Picked Up for delivery<br>
CANCEL : Request cancelled by the sender<br>
RETURN : Return of the Package requested<br>
RETURNED : Package returned to the Sender<br>
DELIVERED : Package delivered<br>
PACKAGE_NOT_FOUND : There is no such request found</dd>

</article>
</div>

				  </div>
	<div class="col-md-6">
<h6><span id="createdelivery"
                              style=''><b>Sample Request for Get Delivery Status for Schedule</b><br></span></h6>
							  <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 
                     style='border-collapse:collapse;border:
                     none'>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Name</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border:solid black 1.0pt;
                           border-left:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Get Delivery
                              Status for Schedule</span>
                           </p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>URL</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>/api/v1/getDeliveryStatusForSchedule</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Request</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&quot;trackingId&quot;:&quot;5bd9803db009fb2a74e75763&quot;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>SuccessResponse</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;ASSIGNED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;trackingId&quot;: &quot;5bd9803db009fb2a74e75763&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;5b93ab89cf4a438f9d10f9d66c63d0a1&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;transporterName&quot;: &quot;VIJAYSHANKAR&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;transporterContact&quot;:
                              &quot;7358410026&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>OR</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;DELIVERED&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;trackingId&quot;: &quot;5bd96443b009fb2ff8815379&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;traceId&quot;: &quot;ef1410cffb3242978f9b01bc9b20d7e7&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;transporterName&quot;: &quot;VIJAYSHANKAR&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;transporterContact&quot;: &quot;7358410026&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'> &quot;pickedUpDate&quot;:
                              &quot;2018-10-31T08:22:19.051+0000&quot;,</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;deliveredDate&quot;: &quot;2018-10-31T08:38:27.223+0000&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Error Response</span></b></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Status code:200</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;SCHEDULE_NOT_FOUND&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                              
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;PACKAGE_NOT_FOUND&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                              
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;REQUEST_NOT_CREATED&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                              
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>
                              &quot;packageStatus&quot;: &quot;Schedule TRACKING_ID or ORDER_ID is Required&quot;</span>
                           </p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>}</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>&nbsp;</span></p>
                        </td>
                     </tr>
                     <tr style='height:4.0cm'>
                        <td width=193 valign=top style='width:144.9pt;border:solid black 1.0pt;
                           border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><b><span
                              style='font-family:'>Headers</span></b></p>
                        </td>
                        <td width=498 valign=top style='width:373.3pt;border-top:none;border-left:
                           none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
                           padding:0cm 5.4pt 0cm 5.4pt;height:4.0cm'>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>Content-Type:application/json</span></p>
                           <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'><span
                              style='font-family:'>{&quot;key&quot;:&quot;Authorization&quot;,&quot;value&quot;:&quot;Bearer<b>COPY_PASTE_THE_GIVEN_TOKEN</b>&quot;}]</span></p>
                        </td>
                     </tr>
                  </table>
				  	</div>
</div>
      </div>
   </body>
</html>