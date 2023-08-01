<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
#loginPageerrormsg {
	display: none;
	color: red;
    text-align: center;
    padding: 20px 0px;
}

.loginPageerrormsg {
	color: red;
	font-size: 14px;
	text-align: center;
	padding: 10px;
}</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
$(document).ready(function() {
	
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
			url : 'a/loginValidate',
			contentType : "application/json",
			method : 'POST',
			data : JSON.stringify(registerModel),
			success : function(data) {
				if (data != null) {
					if (data.startsWith("SUCCESS")) {
						var viewName = data.split(":")[1];
						window.location = viewName;
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
	
	$('#loginpageBtn1').click(function() {
		
		var usernameVar1 = $('#u1_pageuname').val();
		if(usernameVar1 == '') {
			$('#loginPageerrormsg').html('Please enter username');
			$('#loginPageerrormsg').slideDown();
			return false;
		}
		
		var passVar = $('#u1_pagepassword').val();
		if(passVar == '') {
			$('#loginPageerrormsg').html('Please enter password');
			$('#loginPageerrormsg').slideDown();
			return false;
		}
		
		$('#loginPageerrormsg').html('');
		$('#loginPageerrormsg').slideUp();
		
		$('.loadCls').show();
		var registerModel = new Object();
		registerModel.email = $('#u1_pageuname').val();
		registerModel.password = $('#u1_pagepassword').val();
	
		$.ajax({
			url : 'a/loginValidate',
			contentType : "application/json",
			method : 'POST',
			data : JSON.stringify(registerModel),
			success : function(data) {
				if (data != null) {
					if (data.startsWith("SUCCESS")) {
						var viewName = data.split(":")[1];
						window.location = viewName;
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
	
	$('#loginmob').click(function() {
		$('.loinbymobdiv').show();
		$('.loinbyemaildiv').hide();
	});
	
	$('#loginemail').click(function() {
		$('.loinbyemaildiv').show();
		$('.loinbymobdiv').hide();
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

</script>
</head>
<body>

<div class="modal-dialog" role="document">
			<div class="modal-content" style="border:none">
				<div class="loadCls"></div>
				<div class="modal-header">
					<h5 class="font-weight-bold col-12 modal-title text-center">Login</h5>
				</div>
				<div class="modal-body formcls">
					<div id="loginPageerrormsg"></div>
					<div class="form-group row1" style="font-size: 14px;">
						<div class="col1-md-6" style="float: left;">
							<input type="radio" name="loginas" value="2" id="loginemail" checked="checked" style="width: auto; margin-right: 10px; height: 20px;">
							<label for="loginemail">By Email Id</label>
						</div>
						<div class="col1-md-6">
							<input type="radio" name="loginas" value="1" id="loginmob" style="width: auto; margin-right: 10px; height: 20px; margin-left: 20px;">
							<label for="loginmob">By Mobile No.</label>
						</div>
					</div>
					<div class="loinbymobdiv" style="display: none;">
						<div class="form-group">
							<label>Mobile No.</label> <input type="text" class="form-control"
								required="required" id="u_pagemobno">
						</div>
						<div class="form-group">
							<div class="clearfix">
								<label>OTP</label>
							</div>
							<input type="password" class="form-control" required="required"
								id="u_pageotp">
						</div>
						<div class="modal-footer" style="padding: 10px 10px;">
							<button type="button" class="btn btn-primary" id="loginpageBtn">Login</button>
							<button type="button" class="btn btn-primary" id="sendOtpBtn">Send
								OTP</button>
							
						</div>
					</div>

					<div class="loinbyemaildiv">
						<div class="form-group">
							<label>Username</label> <input type="text" class="form-control1"
								required="required" id="u1_pageuname">
						</div>
						<div class="form-group">
							<div class="clearfix">
								<label>Password</label>
							</div>
							<input type="password" class="form-control1" required="required"
								id="u1_pagepassword">
						</div>
						<div class="modal-footer" style="padding-right: 0px;">
							<button type="button" class="btn btn-primary" id="loginpageBtn1">Login</button>
						</div>
					</div>

				</div>



			</div>

		</div>
</body>
</html>