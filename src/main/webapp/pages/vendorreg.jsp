<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<style>
</style>
<script type="text/javascript">

var placeSearch, autocomplete;
var componentForm = {
	street_number : 'short_name',
	route : 'short_name',
	locality : 'short_name',
	sublocality_level_1 : 'short_name',
	administrative_area_level_1 : 'short_name',
	country : 'short_name',
	postal_code : 'short_name'
};

$(document).ready(function() {
	$("#acno").parent().parent().hide();
	$("#actype").parent().parent().hide();
	$("#acname").parent().parent().hide();
	$("#ifsc").parent().parent().hide();
	$("#acbank").parent().parent().hide();
	$("#acbranch").parent().parent().hide();
	getVendorElem(true);
	$('#headOff').click(function() {
		if($(this).is(':checked')) {
			getVendorElem(false);
		} else {
			getVendorElem(true);
		}
	});
	$('#detailOff').click(function() {
		if($(this).is(':checked')) {
			$("#acno").parent().parent().slideDown();
			$("#actype").parent().parent().slideDown();
			$("#acname").parent().parent().slideDown();
			$("#ifsc").parent().parent().slideDown();
			$("#acbank").parent().parent().slideDown();
			$("#acbranch").parent().parent().slideDown();

			$("#acno").addClass('required');
			$("#acname").addClass('required');
			$("#ifsc").addClass('required');
			$("#acbank").addClass('required');
			$("#acbranch").addClass('required');
		} else {
			$("#acno").parent().parent().slideUp();
			$("#actype").parent().parent().slideUp();
			$("#acname").parent().parent().slideUp();
			$("#ifsc").parent().parent().slideUp();
			$("#acbank").parent().parent().slideUp();
			$("#acbranch").parent().parent().slideUp();

			$("#acno").removeClass('required');
			$("#acname").removeClass('required');
			$("#ifsc").removeClass('required');
			$("#acbank").removeClass('required');
			$("#acbranch").removeClass('required');
		}
	});
	$('#nogst').click(function(){
		if($(this).is(':checked')){
			$("#gst").removeClass('required');
			$("#gst").parent().parent().hide();
		} else {
			$("#gst").addClass('required');
			$("#gst").parent().parent().show();
		}
	});
	$('#address').keyup(function() {
		$('#lat').val('');
		$('#long').val('');
		$('#area').val('');
		$('#city').val('');
		$('#state').val('');
		$('#country').val('');
	});
	
	$('#address').focusout(function() {
		if($('#lat').val() == '') {
			$('#address').val('');
		}
	});
			
	$('#mobileNoId').keypress(function(event){
	    var regex = new RegExp("^[a-zA-Z0-9]+$");
	    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
	    if (!regex.test(key)) {
	       event.preventDefault();
	       return false;
	    }
	});
	
	$('#regbtn').click(
			function(event) {
				
// 				if($('#address').val() != '') {
// 					$('#lat').val('13.0632365');
// 					$('#long').val('80.22499189999999');
// 					$('#city').val('Chennai');
// 					$('#state').val('TN');
// 					$('#country').val('IN');
// 				}
				
				$(".validation").html("");
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
				
				if($('#password').val() != '') {
// 					var obj = validatePassword($('#password').val());
					if(!validatePassword($('#password').val())) {
						$('#password').parent().find(".validation").addClass("showVal");
						$('#password').parent().find(".validation").html('Min 8 characters, 1 upper case, 1 lower case, 1 special character');
						flag = false;
					} else if($('#password').val() != '' && $('#cpassword').val() != '') {
						if($('#password').val() != $('#cpassword').val()) {
							$('#password').parent().find(".validation").addClass("showVal");
							$('#password').parent().find(".validation").html("Password doest not match");
							flag = false;
						} else {
							$('#password').parent().find(".validation").removeClass("showVal");
							$('#password').parent().find(".validation").html("");
						}
					}
				}
				
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
					registerModel.vendorGroupName = $('#nom').val();
					registerModel.vendorName = $('#branhnm').val();
					if($('#nogst').is(':checked')){
						registerModel.noGstFlag = true;
					}
					else{
					registerModel.gst = $('#gst').val();
					}
					registerModel.companyUrl = $('#comu').val();
					registerModel.houseNo = $('#stname').val();
					registerModel.streetName = $('#stname').val();
					registerModel.email = $('#email').val();
					registerModel.password = $('#password').val();
					registerModel.parcelType = $('#product').val();
					registerModel.address = $('#address').val();
					registerModel.area = $('#area').val();
					registerModel.city = $('#city').val();
					registerModel.state = $('#state').val();
					registerModel.country = $('#country').val();
					registerModel.latitude = $('#lat').val();
					registerModel.longitude = $('#long').val();
					registerModel.mobileNumber = $('#mobileNoId').val();
					registerModel.billCycleId = $('#billCycleNum').val();
					
					
					if($('#headOff').is(':checked')) {
						registerModel.hoFlag = true;
					} else {
						registerModel.hoFlag = false;
					}
					if($('#detailOff').is(':checked')){
						registerModel.accountNo == $('#acno').val();
						registerModel.accountType= $('#actype').val();
						registerModel.accountName= $('#acname').val();
						registerModel.ifsc= $('#ifsc').val();
						registerModel.bankName= $('#acbank').val();
						registerModel.bankBranch= $('#acbranch').val();
					}
					
					$.ajax({
						url : "a/q",
						contentType : 'application/json',
						method : 'POST',
						data : JSON.stringify(registerModel),
						dataType : "json",
						success : function(data) {
							$('.loadCmnCls').hide();
							$('#email').parent().find(".validation").removeClass("showVal");
							$('#email').parent().find(".validation").html("");
							
							$('#mobileNoId').parent().find(".validation").removeClass("showVal");
							$('#mobileNoId').parent().find(".validation").html("");
							
							if (data != null) {
								if (data.responseText.startsWith("SUCCESS")) {
									alert("Registered successfully!");
									window.location = $("#contextPath").val() + "/home";
								} else {
									var errMsg = data.responseText.split(":")[1];
									
									if(errMsg == "Email already exist"){
										$('#email').parent().find(".validation").addClass("showVal");
										$('#email').parent().find(".validation").html(errMsg);
									}else if(errMsg == "Mobile no. already exist"){
										$('#mobileNoId').parent().find(".validation").addClass("showVal");
										$('#mobileNoId').parent().find(".validation").html(errMsg);
									}
									
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
	
	function validateMobileNo(mobile) {
		if (mobile.length!=10) {
			return (false)
		}
		return (true)
	}
	
	function validatePassword(pwd) {
		var regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$/
		var valid = regex.test(pwd);
		
// 	    var letter = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$";
// 	    var number = /[0-9]/;
// 	    var valid = letter.test(pwd); //match a letter _and_ a number
	    return valid;
	}
	
	function validatePassword1(p){
	    var anUpperCase = /[A-Z]/;
	    var aLowerCase = /[a-z]/; 
	    var aNumber = /[0-9]/;
	    var aSpecial = /[!|@|#|$|%|^|&|*|(|)|-|_]/;
	    var obj = {};
	    obj.result = true;

	    if(p.length < 15){
	        obj.result=false;
	        obj.error="Not long enough!"
	        return obj;
	    }

	    var numUpper = 0;
	    var numLower = 0;
	    var numNums = 0;
	    var numSpecials = 0;
	    for(var i=0; i<p.length; i++){
	        if(anUpperCase.test(p[i]))
	            numUpper++;
	        else if(aLowerCase.test(p[i]))
	            numLower++;
	        else if(aNumber.test(p[i]))
	            numNums++;
	        else if(aSpecial.test(p[i]))
	            numSpecials++;
	    }

	    if(numUpper < 2 || numLower < 2 || numNums < 2 || numSpecials <2){
	        obj.result=false;
	        obj.error="Wrong Format!";
	        return obj;
	    }
	    return obj;
	}
	
	getGoogleAddress();
	$('#address').addClass('required');
});

function getVendorElem(inputFlag){
	var htmlVar = '';
	if(inputFlag == true) {
		htmlVar = '<input type="text" name="nom" id="nom" class="required" /><div class="validation"></div>';
	} else {
		htmlVar = '<select id="nom" class="required">';
		htmlVar += '<option value="">Select a head office</option>';
		$('.vendorNameCls').each(function(index, elem) {
			htmlVar += '<option value="'+$(elem).val()+'">'+$(elem).val()+'</option>';
		});
		htmlVar += '</select><div class="validation"></div>';
	}
	
	$('#nomDiv').html(htmlVar);
}

function getGoogleAddress(){
	
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

</script>


<script>

// 	var placeSearch, autocomplete;
// 	var componentForm = {
// 		street_number : 'short_name',
// 		route : 'short_name',
// 		locality : 'short_name',
// 		administrative_area_level_1 : 'short_name',
// 		country : 'short_name',
// 		postal_code : 'short_name'
// 	};

// 	function initAutocomplete() {
// 		// Create the autocomplete object, restricting the search predictions to
// 		// geographical location types.
// 		/* autocomplete = new google.maps.places.Autocomplete(document
// 				.getElementById('address'), {
// 			types : [ 'geocode' ]
// 		}); */
// 		alert("initAutocomplete")
// 		autocomplete = new google.maps.places.Autocomplete(document
// 				.getElementById('address'));

// 		// Avoid paying for data that you don't need by restricting the set of
// 		// place fields that are returned to just the address components.
// 		autocomplete.setFields(['address_component', 'geometry']);

// 		// When the user selects an address from the drop-down, populate the
// 		// address fields in the form.
// 		autocomplete.addListener('place_changed', fillInAddress);
// 	}
	
// 	function fillInAddress() {
// 		var place = autocomplete.getPlace();

// 		$('#lat').val(place.geometry.location.lat());
// 		$('#long').val(place.geometry.location.lng());
		
// 		for (var i = 0; i < place.address_components.length; i++) {
// 			var d = place.formatted_address;
// 			var addressType = place.address_components[i].types[0];
// 			if (componentForm[addressType]) {
// 				var val = place.address_components[i][componentForm[addressType]];
				
// 				if(addressType == 'locality') {
// 					$('#city').val(val);
// 				} else if(addressType == 'administrative_area_level_1') {
// 					$('#state').val(val);
// 				} else if(addressType == 'country') {
// 					$('#country').val(val);
// 				}
				
// 			}
// 		}
// 	}

// 	function geolocate() {
// 		if (navigator.geolocation) {
// 			navigator.geolocation.getCurrentPosition(function(position) {
// 				var geolocation = {
// 					lat : position.coords.latitude,
// 					lng : position.coords.longitude
// 				};
// 				console.log("lat :"+position.coords.latitude );
// 				console.log("lan :"+position.coords.longitude );
// 				var circle = new google.maps.Circle({
// 					center : geolocation,
// 					radius : position.coords.accuracy
// 				});
// 				autocomplete.setBounds(circle.getBounds());
// 			});
// 		}
// 	}
</script>

<!-- <script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCb_bPRL8mW7-iuNfH9ithBpw6MifBG_jQ&libraries=places&callback=initAutocomplete"
	async defer></script> -->

<!-- <script -->
<!-- 	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAFaDlYLzjfBK_C7J_WA8O8FMh-dvPkuqs&libraries=places&callback=initAutocomplete" -->
<!-- 	async defer></script> -->

<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBR8gfXIcdX2P2xl43xrDV13hqCLbsl5zk&libraries=places"></script>
	

<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center;">Vendor Registration</h5>

				<form>
					<div class="contentform row formcls">
						<div class="col-md-1"></div>
						<div class="col-md-10">
							<div class="row">
							
								<div class="col-md-12">
									<div class="form-group">
										<div class="radio">
											<input class="styled-checkbox" id="headOff" type="checkbox" value="1">
    										<label for="headOff">Register Branch</label>
										</div>
									</div>
								</div>
							
								<div class="col-md-6">
									<div class="form-group">
										<p>First Name <span>*</span></p>
										<input type="text" name="fname" id="fname" class="required" placeholder="First Name" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Last Name</p>
										<input type="text" name="lname" id="lname" placeholder="Last Name"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div style="display: none;">
										<c:forEach items="${holist.vendorNameList}" var="vendorName">
											<input class="vendorNameCls" type="hidden" value="${vendorName}">
										</c:forEach>
									</div>
									<div class="form-group">
										<p>Business / Shop Name <span>*</span></p>
										<div id="nomDiv">
											<input type="text" name="nom" id="nom" class="required" placeholder="Business/Shop Name" />
											<div class="validation"></div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Branch Name <span>*</span></p>
										<input type="text" name="branhnm" id="branhnm" class="required" placeholder="Branch Name" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<p>Billing Cycle <span>*</span></p>
										<select id="billCycleNum" class="required">
											<option value="">Select One</option>
											<c:forEach items="${billCycleList.billingCycleMasterDtos}" var="billCycle">
												<option value="${billCycle.id}">${billCycle.billingCycleName}</option>
											</c:forEach>
										</select>
										<div class="validation"></div>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<p>Address <span>*</span></p>
										<input id="address" name="address" onFocus="geolocate()" class="controls" type="text" class="required" placeholder="Address">
    									<div id="map"></div> <br>
										<div class="validation"></div>
										<input type="hidden" id="area">
										<input type="hidden" id="city">
										<input type="hidden" id="state">
										<input type="hidden" id="country">
										<input type="hidden" id="lat">
										<input type="hidden" id="long">
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
										<br><div class="validation"></div>
									</div>
								</div>
								
														
								<!-- <div class="col-md-6">
									<div class="form-group">
										<p>PAN <span>*</span></p>
										<input type="text" name="prenom" id="pan" class="required" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								
								<div class="col-md-6">
									<div class="form-group">
										<p>CST <span>*</span></p>
										<input type="text" name="society" id="cst" class="required" />
										<br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>TAX</p>
										<input type="text" name="postal" id="tax" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>TAN</p>
										<input type="text" name="ville" id="tan" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>VAT</p>
										<input type="text" name="ville" id="vat" /> <br>
										<div class="validation"></div>
									</div>
								</div> -->
								<div class="col-md-6">
									<div class="form-group">
										<p>Types of Products <span>*</span></p>
										<select id="product">
											<option value="doc_books">Doc / Books</option>
											<option value="electronics">Electronics</option>
											<option value="food/med">Food / Med</option>
											<option value="veg">Veg</option>
										</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Company URL</p>
										<input type="text" name="phone" id="comu" data-rule="maxlen:10" placeholder="Ex. www.example.com" />
										<br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<div class="radio">
											<input class="styled-checkbox" id="nogst" type="checkbox" value="1" checked="checked">
    										<label for="nogst">No GST</label>
										</div>
									</div>
								</div>
								<div class="col-md-6" style="display: none;">
									<div class="form-group">
										<p>GST</p>
										<input type="text" name="gst" id="gst"  placeholder="GST" />
										<br>
										<div class="validation"></div>
									</div>
								</div>
								
								<div class="col-md-12">
									<div class="form-group">
										<div class="radio">
											<input class="styled-checkbox" id="detailOff" type="checkbox" value="1">
    										<label for="detailOff">Would you like to give your Account details?</label>
										</div>
									</div>
								</div>
								
								<div class="col-md-6" style="display: none;">
									<div class="form-group">
										<p>Account No. <span>*</span></p>
										<input type="text" name="acno" id="acno" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Account Type <span>*</span></p>
										<select id="actype">
											<option value="current">Current</option>
											<option value="savings">Savings</option>
											</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Account Name <span>*</span></p>
										<input type="text" name="acname" id="acname" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>IFSC Code <span>*</span></p>
										<input type="text" name="ifsc" id="ifsc" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Bank Name <span>*</span></p>
										<input type="text" name="acbank" id="acbank" /> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Branch <span>*</span></p>
										<input type="text" name="acbranch" id="acbranch" /> <br>
										<div class="validation"></div>
									</div>
								</div>
							
								
								<div class="col-md-12">
									<div>
										<h4 style="color: #666;text-align: center;margin: 20px 0px 20px 0px;">Account Details</h4>
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
								<div class="col-md-6">
									<div class="form-group">
										<p>Password <span>*</span></p>
										<input type="password" name="password" id="password" class="required" placeholder="Password" />
										<br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Confirm Password <span>*</span></p>
										<input type="password" name="cpassword" id="cpassword" class="required" placeholder="Confirm Password" />
										<br>
										<div class="validation"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-1"></div>
						
						<div class="col-md-1"></div>
						<div class="col-md-5"></div>
						<div class="col-md-5">
							<div class="quote_btn-container">
<!-- 				              <a href="" onclick="return false;" id="regbtn" style="font-size: 16px;">Register</a> -->
				              <button type="button" class="btn btn-primary" id="regbtn">Register</button>
				            </div>
						</div>
						<div class="col-md-1"></div>
						
					</div>
					
				</form>
			</div>
		</section>
	</div>
</div>
