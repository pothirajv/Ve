<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBR8gfXIcdX2P2xl43xrDV13hqCLbsl5zk&libraries=places"></script>
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
	
	$("#gst").parent().parent().hide();
if($("#gstflag").val()=="true")
{
	$("#gstflg").attr("checked","checked");
	$("#gst").parent().parent().hide();
	}
	$("#acno").parent().parent().hide();
	$("#actype").parent().parent().hide();
	$("#acname").parent().parent().hide();
	$("#ifsc").parent().parent().hide();
	$("#acbank").parent().parent().hide();
	$("#acbranch").parent().parent().hide();
	if($("#acname").val()!=""){
		$("#detailOff").attr("checked","checked");
		$("#acno").parent().parent().show();
		$("#actype").parent().parent().show();
		$("#acname").parent().parent().show();
		$("#ifsc").parent().parent().show();
		$("#acbank").parent().parent().show();
		$("#acbranch").parent().parent().show();
		//$('#detailOff').parent().parent().hide();

	}
	$('#detailOff').click(function() {
		if($(this).is(':checked')) {
			$("#acno").parent().parent().slideDown();
			$("#actype").parent().parent().slideDown();
			$("#acname").parent().parent().slideDown();
			$("#ifsc").parent().parent().slideDown();
			$("#acbank").parent().parent().slideDown();
			$("#acbranch").parent().parent().slideDown();

		} else {
			$("#acno").parent().parent().slideUp();
			$("#actype").parent().parent().slideUp();
			$("#acname").parent().parent().slideUp();
			$("#ifsc").parent().parent().slideUp();
			$("#acbank").parent().parent().slideUp();
			$("#acbranch").parent().parent().slideUp();

		}
	});
	$('#gstflg').click(function(){
		if($(this).is(':checked')) {
		$("#gst").parent().parent().hide();
		}
		else{
			$("#gst").parent().parent().show ();
		}
	});
	
	$('#product').val($('#prodHdn').val());
	
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
	
	$('#editbtn').click(
			function(event) {
				
// 				if($('#address').val() != '') {
// 					$('#lat').val('13.0632365');
// 					$('#long').val('80.22499189999999');
// 					$('#city').val('Chennai');
// 					$('#state').val('TN');
// 					$('#country').val('IN');
// 				}
				
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
				
// 				if (flag == false) {
// 					event.preventDefault();
// 				} else {
					$('.loadCmnCls').show();
					
					var registerModel = new Object();
					registerModel.firstName = $('#fname').val();
					registerModel.lastName = $('#lname').val();
					registerModel.vendorGroupName = $('#nom').val();
					registerModel.vendorName = $('#branhnm').val();
					if($('#gstflg').is(':checked')== false){
					registerModel.gst = $('#gst').val();
					}
					else{
						registerModel.noGstFlag=true;
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
					if($('#detailOff').is(':checked')){
						registerModel.accountNo = $('#acno').val();
						registerModel.accountType= $('#actype').val();
						registerModel.accountName= $('#acname').val();
						registerModel.ifsc= $('#ifsc').val();
						registerModel.bankName= $('#acbank').val();
						registerModel.bankBranch= $('#acbranch').val();
					}
					
					$.ajax({
						url : $("#contextPath").val()+"/b/edit",
						contentType : 'application/json',
						method : 'POST',
						data : JSON.stringify(registerModel),
						dataType : "json",
						success : function(data) {
							$('.loadCmnCls').hide();
							if (data != null) {
								if (data == true) {
									alert("Updated successfully!");
									window.location = $("#contextPath").val() + "/v/vendorHome";
								} else {
									alert('Problem in update');
								}
							} else {
								alert('Problem in update');
							}
						},
						error : function(data,status,er) {
							$('.loadCmnCls').hide();
							alert('Problem in update');
						}
					});
				//}
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
	
	getGoogleAddress();
	$('#address').addClass('required');
});

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

<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center;">My Profile</h5>

				<form>
					<div class="contentform row formcls">
						<div class="col-md-1"></div>
						<div class="col-md-10">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<p>E-mail <span>*</span></p>
										<input type="text" name="email" id="email" class="required" value="${User.email}" disabled="disabled" placeholder="Email Id"/>
										<br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>First Name <span>*</span></p>
										<input type="text" name="fname" id="fname" class="required" value="${User.firstName}" placeholder="FirstName"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Last Name</p>
										<input type="text" name="lname" id="lname" value="${User.lastName}"  placeholder="LastName"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Business / Shop Name <span>*</span></p>
										<input type="text" name="nom" id="nom" class="required" value="${User.vendorGroupName}" disabled="disabled"/ placeholder="Business/Shop Name"> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Branch Name <span>*</span></p>
										<input type="text" name="branhnm" id="branhnm" class="required" value="${User.vendorName}" placeholder="BranchName"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Address <span>*</span></p>
										<input id="address" name="address" onFocus="geolocate()" value="${User.address}" class="controls" type="text" class="required">
    									<div id="map"></div> <br>
										<div class="validation"></div>
										<input type="hidden" id="area" value="${User.area}">
										<input type="hidden" id="city" value="${User.city}">
										<input type="hidden" id="state" value="${User.state}">
										<input type="hidden" id="country" value="${User.country}">
										<input type="hidden" id="lat" value="${User.latitude}">
										<input type="hidden" id="long" value="${User.longitude}">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>House / Street Name <span>*</span></p>
										<input type="text" name="stname" id="stname" class="required" value="${User.houseNo}" placeholder="StreetName"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Mobile No <span>*</span></p>
										<c:choose>
											<c:when test="${User.mobileNumber == ''}">
												<input type="number" name="" style="padding-left: 40px;" id="mobileNoId" class="required" value="${User.mobileNumber}" minlength="10" maxlength="10" placeholder="Mobile No"/>
											</c:when>
											<c:otherwise>
												<input type="number" name="" style="padding-left: 40px;" id="mobileNoId" class="required" value="${User.mobileNumber}" minlength="10" maxlength="10" placeholder="Mobile No" disabled="disabled"/>
											</c:otherwise>
										</c:choose>
										<span class="mobile-pre-ex">+91</span><br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<div class="radio">
											<input class="styled-checkbox" id="gstflg" type="checkbox" value="1">
    										<label for="gstflg">No GST</label>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>GST </p>
										<input type="text" name="gst" id="gst" class="required" value="${User.gst}" placeholder="GST Number"/>
										<br>
									</div>
								</div>
								
										<input type="hidden" name="gstflag" id="gstflag" class="required" value="${User.noGstFlag}"/>
										
								<div class="col-md-6">
									<div class="form-group">
										<p>Company URL</p>
										<input type="text" name="phone" id="comu" data-rule="maxlen:10" value="${User.companyUrl}" placeholder="Ex. www.examle.com"/>
										<br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Types of Products <span>*</span></p>
										<input type="hidden" id="prodHdn" value="${User.parcelType}">
										<select id="product" value="${User.parcelType}">
											<option value="doc_books">Doc / Books</option>
											<option value="electronics">Electronics</option>
											<option value="food/med">Food / Med</option>
											<option value="veg">Veg</option>
										</select>
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
								<div class="col-md-6">
									<div class="form-group">
										<p>Account No</p>
										<input type="text" name="acno" id="acno" class="required" value="${User.accountNo}" /> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Account Type</p>
										<select id="actype" value="${User.accountType}">
											<option value="current">Current</option>
											<option value="savings">Savings</option>
											<option value="others">Others</option>
											</select>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Account Name</p>
										<input type="text" name="acname" id="acname" class="required" value="${User.accountName}"  /> <br>
										
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>IFSC Code</p>
										<input type="text" name="ifsc" id="ifsc" class="required" value="${User.ifsc}" /> <br>
								
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Bank Name</p>
										<input type="text" name="acbank" id="acbank" class="required" value="${User.bankName}" /> <br>
										
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Branch</p>
										<input type="text" name="acbranch" id="acbranch" class="required" value="${User.bankBranch}" /> <br>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-1"></div>
						
						<div class="col-md-1"></div>
						<div class="col-md-5"></div>
						<div class="col-md-5">
							<div class="quote_btn-container">
				              <button type="button" class="btn btn-primary" id="editbtn">Update</button>
				            </div>
						</div>
						<div class="col-md-1"></div>
						
					</div>
					
				</form>
			</div>
		</section>
	</div>
</div>