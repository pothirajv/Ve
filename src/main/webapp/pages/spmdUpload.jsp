<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<head>
<title>Vedagram : Sender Requests</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/jszip.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.8.0/xlsx.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBR8gfXIcdX2P2xl43xrDV13hqCLbsl5zk&libraries=places"></script>
<style>
/* table {
	border-collapse: collapse;
	table-layout: fixed;
	width: 50px;
}

table, th, td {
	border: 1px solid black;
	table-layout: fixed;
	width: 50px;
} */

.noteCls {
	font-size: 12px;
    border: 1px solid #d4d3d3;
    border-radius: 4px;
    padding: 10px;
    margin-bottom: 20px;
    min-width: 290px;
    width: 60%;
    background: #f9f9f9;
}

.codLblCls {
	margin-top: 5px;
    margin-bottom: 0px;
    margin-left: 10px;
}

.styled-checkbox + label:before {
    border: 2px solid #007bff;
}

.styled-checkbox:checked + label:before {
    background: #007bff;
}

.tblinput {
	width: 120px !important;
}

.rowHighlight {
	background-color: #fff4f4 !important;
}

.colHighlight input, .colHighlight select {
	border-color: red;
	color: red;
}
</style>

<script>

var dataTable1;
var objArr = [];
var rowErrInfo = [];
var ExcelToJSON = function() {
	this.parseExcel = function(file) {
		var reader = new FileReader();
		reader.onload = function(e) {
			var data = e.target.result;
			var workbook = XLSX.read(data, {
				type : 'binary'
			});
			
			var headers = get_header_row(workbook.Sheets[workbook.SheetNames[0]]);
			if(headers.length != 11) {
				$('#uploadFile').val('');
				alert('Invalid number of columns');
				return;
			}
// 			var XL_row_object = XLSX.utils
// 					.sheet_to_row_object_array(workbook.Sheets[workbook.SheetNames[0]]);
// 			var json_object= JSON.stringify(XL_row_object);

			var worksheet = workbook.Sheets[workbook.SheetNames[0]];
		    var headers = {};
		    var data = [];
		    for(z in worksheet) {
		        if(z[0] === '!') continue;
		        //parse out the column, row, and value
		        var col = z.substring(0,1);
		        var row = parseInt(z.substring(1));
		        var value = worksheet[z].v;
		
		        if(row == 1) continue;
		        if(row == 2) {
		            headers[col] = value;
		            continue;
		        }
		        row -= 3;
		        if(!data[row]) data[row]={};
		        data[row][headers[col]] = value;
		    }

// 			var json_object = XLSX.utils.sheet_to_json(workbook.Sheets[workbook.SheetNames[0]], {header:2});
			objArr = [];
			buildObjArr(data);
			buildDataTable(objArr);
				
		};

		reader.onerror = function(ex) {
			console.log(ex);
		};

		reader.readAsBinaryString(file);
	};
};

function get_header_row(sheet) {
    var headers = [];
    var range = XLSX.utils.decode_range(sheet['!ref']);
    range.s.r = 2;
    var C, R = range.s.r; /* start in the first row */
    for(C = range.s.c; C <= range.e.c; ++C) {
        var cell = sheet[XLSX.utils.encode_cell({c:C, r:R})] /* find the cell in the first row */

        var hdr = "UNKNOWN " + C; // <-- replace with your desired default 
        if(cell && cell.t) hdr = XLSX.utils.format_cell(cell);

        headers.push(hdr);
    }
    return headers;
}

// var getAddr;
var uploadTimer;
var latErrMsg = '';
var geocoder = new google.maps.Geocoder();
$(document).ready(function() {
	
	$('#download_template').click(function() {
		window.location = $('#contextPath').val() + '/v/uploadtemplate';
	});
	
	$('#choose_file').click(function() {
		$('#uploadFile').trigger('click');
	});
	
	$(document.body).on('change', '.tblinput', function() {
		var info = dataTable1.page.info();
		var currrow = (info.page * info.length) + $(this).closest('tr').index();
		var j = $(this).closest('td').index();
		var inputVal = $(this).val();
		
		if(j == 1) {
			if($(this).is(':checked')) {
				objArr[currrow].codFlag = true;
				
				$(this).closest('tr').find('.incluChargeSelCls').attr('disabled');
				$(this).closest('tr').find('.incluChargeSelCls').val('false');
				$(this).closest('tr').find('.itemPayAmntCls').removeAttr('disabled');
				$(this).closest('tr').find('.itemPayAmntCls').val('');
			} else {
				objArr[currrow].codFlag = false;
				objArr[currrow].itemPayAmount = "";
				objArr[currrow].deliveryChargeInclu = false;
				
				$(this).closest('tr').find('.incluChargeSelCls').attr('disabled', 'disabled');
				$(this).closest('tr').find('.incluChargeSelCls').val('false');
				$(this).closest('tr').find('.itemPayAmntCls').attr('disabled', 'disabled');
				$(this).closest('tr').find('.itemPayAmntCls').val('');
			}
		} else if(j == 2) {
			var numVal = parseFloat(inputVal);
			if(isNaN(numVal)) {
				objArr[currrow].itemPayAmount = "";
				objArr[currrow].deliveryChargeInclu =false;
				$(this).closest('tr').find('.incluChargeSelCls').attr('disabled', 'disabled');
				$(this).closest('tr').find('.incluChargeSelCls').val('false');
			} else {
				objArr[currrow].itemPayAmount = numVal;
				$(this).closest('tr').find('.incluChargeSelCls').removeAttr('disabled');
			}
			$(this).val(objArr[currrow].itemPayAmount);
		} else if(j == 3) {
			if(inputVal=="true")
				objArr[currrow].deliveryChargeInclu =true;
			else
				objArr[currrow].deliveryChargeInclu =false;
			
		} else if(j == 4) {
			objArr[currrow].recieverName = inputVal;
		} else if(j == 5) {
			objArr[currrow].recieverContact = inputVal;
		} else if(j == 6) {
			objArr[currrow].recieverCity = inputVal;
			objArr[currrow].recieverLocation = '';
			
			var htmlVar = '';
			var cityVar = objArr[currrow].recieverCity.toLowerCase();
			if($(".parentCls > .placeSelCls[city='"+cityVar+"']").length > 0) {
				$(".parentCls > .placeSelCls[city='"+cityVar+"']").find("option").removeAttr('selected');
				if(objArr[currrow].recieverLocation == '') {
					objArr[currrow].recieverLocation = $(".parentCls > .placeSelCls[city='"+cityVar+"'] option:first").val();
				}
				
				if($(".parentCls > .placeSelCls[city='"+cityVar+"']").find("option[value='" + objArr[currrow].recieverLocation +"']").length > 0) {
					$(".parentCls > .placeSelCls[city='"+cityVar+"']").val(objArr[currrow].recieverLocation).find("option[value='" + objArr[currrow].recieverLocation +"']").attr('selected', true);
				} else {
					objArr[currrow].recieverLocation = '';
				}
				htmlVar = $(".parentCls > .placeSelCls[city='"+cityVar+"']").closest('.parentCls').html();
			} else {
				objArr[currrow].recieverLocation = '';
				htmlVar = $(".parentCls > .placeSelCls[city='dummy']").closest('.parentCls').html();
			}
			$(this).closest('tr').find('td:nth('+(j+1)+')').html(htmlVar);
		} else if(j == 7) {
			objArr[currrow].recieverLocation = inputVal;
		} else if(j == 8) {
			objArr[currrow].recieverHouseNo = inputVal;
		} else if(j == 9) {
			objArr[currrow].recieverPincode = inputVal;
		} else if(j == 10) {
			objArr[currrow].parcelType = inputVal;
		} else if(j == 11) {
			var numVal = Math.ceil(inputVal);
			if(isNaN(numVal)) {
				objArr[currrow].weight = "";
			} else {
				objArr[currrow].weight = numVal;
			}
			$(this).val(objArr[currrow].weight);
		}
		
		dataTable1.cell($(this).closest('td')).invalidate();
	});
	
	$('#cancelbtn').click(function() {
		$("#tableDiv").empty();
		$('.statusCls').html('');
		$(".finalBtnDivCls").hide();
		$('.initbtndivcls').slideDown();
		//Chari: Hiding Add new row button
		$('.initbtndivcls2').slideUp();
		
		$('#uploadFile').val('');
	});
	
	//Chari: Added click event new button
	$('#newRowbtn').click(function() {
		$('.statusCls').removeClass('errCls');
		$('.statusCls').html('');
		insertNewrow();
	});
	
	document.getElementById('uploadFile').addEventListener('change', handleFileSelect, false);
    $('#uploadbtn').click(function(event) {
   		rowErrInfo = [];
   		$('.statusCls').html('');
   		$("html, body").animate({ scrollTop: 0 }, "slow");
   		var errMsg = '';
   		if(objArr == null || objArr.length == 0) {
   			errMsg = 'No row available to upload';
   		} else {
   			for (var i = 0; i < objArr.length; i++) {
   				var reqObj = objArr[i];
   				var reqMsg = '';
   				var rowErrInfoDtl = new Object();
   				if(reqObj.recieverLocation == null || reqObj.recieverLocation == undefined || reqObj.recieverLocation == '') {
   					reqMsg += (reqMsg == '') ? 'Reciever Location':', Reciever Location';
   					rowErrInfoDtl.recieverLocation = true;
   				}
   				if(reqObj.recieverName == null || reqObj.recieverName == undefined || reqObj.recieverName == '') {
   					reqMsg += (reqMsg == '') ? 'Reciever Name':', Reciever Name';
   					rowErrInfoDtl.recieverName = true;
   				}
   				if(reqObj.recieverCity == null || reqObj.recieverCity == undefined || reqObj.recieverCity == '') {
   					reqMsg += (reqMsg == '') ? 'Reciever City':', Reciever City';
   					rowErrInfoDtl.recieverCity = true;
   				}
   				if(reqObj.recieverHouseNo == null || reqObj.recieverHouseNo == undefined || reqObj.recieverHouseNo == '') {
   					reqMsg += (reqMsg == '') ? 'Reciever Address':', Reciever Address';
   					rowErrInfoDtl.recieverHouseNo = true;
   				}
   				if(reqObj.recieverPincode == null || reqObj.recieverPincode == undefined || reqObj.recieverPincode == '') {
   					reqMsg += (reqMsg == '') ? 'Pincode':', Pincode';
   					rowErrInfoDtl.recieverPincode = true;
   				}
   				if(reqObj.recieverContact == null || reqObj.recieverContact == undefined || reqObj.recieverContact == '') {
   					reqMsg += (reqMsg == '') ? 'Reciever Contact':', Reciever Contact';
   					rowErrInfoDtl.recieverContact = true;
   				}
   				if(reqObj.parcelType == null || reqObj.parcelType == undefined || reqObj.parcelType == '') {
   					reqMsg += (reqMsg == '') ? 'Parcel Type':', Parcel Type';
   					rowErrInfoDtl.parcelType = true;
   				}
   				if(reqObj.weight == null || reqObj.weight == undefined || reqObj.weight == '') {
   					reqMsg += (reqMsg == '') ? 'Weight':', Weight';
   					rowErrInfoDtl.weight = true;
   				}
   				
   				rowErrInfoDtl.errFlag = false;
   				if(reqMsg != '') {
   					rowErrInfoDtl.errFlag = true;
   					rowErrInfoDtl.errMsg = 'Row ' + (i+1) + ': Required Fields [' + reqMsg + ']';
   					errMsg += '<li class="errLiCls">Row ' + (i+1) + ': Required Fields [' + reqMsg + ']</li>';
   				}
   				rowErrInfo[i] = rowErrInfoDtl;
   			}
   			if(errMsg != '') {
   				validateTable();
       			errMsg = '<ul>' + errMsg + '</ul>';
       			$('.statusCls').addClass('errCls');
       			$('.statusCls').html(errMsg);
       			return false;
       		}
   		}
   		
   		if(errMsg != '') {
   			validateTable();
   			errMsg = '<ul>' + errMsg + '</ul>';
   			$('.statusCls').addClass('errCls');
   			$('.statusCls').html(errMsg);
   			return false;
   		}
   		
   		$('.bulkCls').show();
   		latErrMsg = '';
   		callGeoCode(0);
	});
    
    $(document.body).on('click', '#upldagain-btn', function() {
    	$('.statusCls').html('');
    	$('#cancelbtn').click();
    });
    
	$(document.body).on('click', '#viewdelv-btn', function() {
    	
    });
	
});

var componentForm = {
	street_number : 'long_name',
	route : 'long_name',
	locality : 'long_name',
	sublocality_level_1 : 'long_name',
	administrative_area_level_1 : 'long_name',
	country : 'long_name',
	postal_code : 'long_name'
};

var retryFlag = false;
function callGeoCode(index) {
	var address = objArr[index].recieverLocation +","+objArr[index].recieverCity;
	geocoder.geocode({'address': address}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			var address_components_var = results[0].address_components;
			
			var city = '';
			var area = '';
			var state = '';
			var country = '';
			var postal_code = '';
			
			for (var i = 0; i < address_components_var.length; i++) {
				var addressType = '';
				for (var j = 0; j < address_components_var[i].types.length; j++) {
					addressType = address_components_var[i].types[j];
					if (componentForm[addressType]) break;
				}
				if (componentForm[addressType]) {
					var val = address_components_var[i][componentForm[addressType]];
					if(addressType == 'locality') {
						city = val;
					} else if(addressType == 'sublocality_level_1') {
						area = val;
					} else if(addressType == 'administrative_area_level_1') {
						state = val;
					} else if(addressType == 'country') {
						country = val;
					} else if(addressType == 'postal_code') {
						postal_code = val;
					}
				}
			}
			
			/* if(postal_code != objArr[index].recieverPincode) {
				retryFlag = true;
				address = objArr[index].recieverCity +","+objArr[index].recieverPincode;
				geocoder.geocode({'address': address}, function(results, status) {
					if (status == google.maps.GeocoderStatus.OK) {
						var address_components_var = results[0].address_components;
						
						var city = '';
						var area = '';
						var state = '';
						var country = '';
						var postal_code = '';
						
						for (var i = 0; i < address_components_var.length; i++) {
							var addressType = '';
							for (var j = 0; j < address_components_var[i].types.length; j++) {
								addressType = address_components_var[i].types[j];
								if (componentForm[addressType]) break;
							}
							if (componentForm[addressType]) {
								var val = address_components_var[i][componentForm[addressType]];
								if(addressType == 'locality') {
									city = val;
								} else if(addressType == 'sublocality_level_1') {
									area = val;
								} else if(addressType == 'administrative_area_level_1') {
									state = val;
								} else if(addressType == 'country') {
									country = val;
								} else if(addressType == 'postal_code') {
									postal_code = val;
								}
							}
						}
						
						if(postal_code != objArr[index].recieverPincode) {
							latErrMsg += '<li class="errLiCls">Row ' + (index+1) + ': Invalid Address (Pincode does not match with location)</li>';
						} else {
							var latitude = results[0].geometry.location.lat();
				    		var longitude = results[0].geometry.location.lng();
				    		
				    		objArr[index].toLat = latitude;
				    		objArr[index].toLong = longitude;
						}
					} else {
						latErrMsg += '<li class="errLiCls">Row ' + (index+1) + ': Invalid Address</li>';
					}
					
					retryFlag = false;
					if(objArr.length == (index + 1)) {
						if(latErrMsg == '') {
							uploadRequest(objArr);
						} else {
							$('.bulkCls').hide();
			       			errMsg = '<ul>' + latErrMsg + '</ul>';
			       			$('.statusCls').addClass('errCls');
			       			$('.statusCls').html(errMsg);
			       			return false;
						}
					} else {
						index++;
						callGeoCode(index);
					}
				});
			} else { */
				var latitude = results[0].geometry.location.lat();
	    		var longitude = results[0].geometry.location.lng();
	    		
	    		objArr[index].toLat = latitude;
	    		objArr[index].toLong = longitude;
			/* } */
		} else {
			latErrMsg += '<li class="errLiCls">Row ' + (index+1) + ': Invalid Address</li>';
		}
		
		if(retryFlag == false) {
			if(objArr.length == (index + 1)) {
				if(latErrMsg == '') {
					uploadRequest(objArr);
				} else {
					$('.bulkCls').hide();
	       			errMsg = '<ul>' + latErrMsg + '</ul>';
	       			$('.statusCls').addClass('errCls');
	       			$('.statusCls').html(errMsg);
	       			return false;
				}
			} else {
				index++;
				setTimeout(function(){callGeoCode(index);},1000);
				}
		}
	});
}

function uploadRequest() {
	$('.bulkCls').show();
	var senderDetailsMain = new Object();
	senderDetailsMain.senderList = objArr;
	$.ajax({
		url : $("#contextPath").val()+"/c/d",
		contentType : 'application/json',
		method : 'POST',
		data : JSON.stringify(senderDetailsMain),
		dataType : "json",
		success : function(data) {
			$('.bulkCls').hide();
			var htmlVar = '';
			htmlVar += '';
			htmlVar += '<div>';
			htmlVar += '<div style="margin-top: 30px;">Uploaded successfully</div>';
			htmlVar += '<div style="margin-bottom: 10px;"><a href="'+$('#contextPath').val()+'/v/requestReport?btchuplid='+data.uploadBatchId+'">Your batch id [<span style="font-weight: bold;margin-bottom: 20px;text-decoration: underline;">'+data.uploadBatchId+'</span>]</a></div>';
			htmlVar += '<div>';
			htmlVar += '<button class="btn btn-primary" id="upldagain-btn"><span class="fa fa-angle-left btn-icon"></span>Upload Again</button>';
			htmlVar += '</div></div>';
			
			$('#cancelbtn').click();
			$('.statusCls').removeClass('errCls');
			$('.statusCls').html(htmlVar);
			$('.initbtndivcls').hide();
		},
		failure : function(response) {
			$('.bulkCls').hide();
			alert(response.responseText);
		}
	});
}

//Chari: Function for adding new row
function insertNewrow()
{	
	var newRow=new Object();
	newRow.recieverLocation = "";
	newRow.recieverName = "";
	newRow.recieverHouseNo = "";
	newRow.recieverContact = "";
	newRow.recieverCity="";
	newRow.parcelType = "";
	newRow.weight = "";
	newRow.recieverPincode = "";
	newRow.codFlag = true;
	//Chari: Added new column item amount
	newRow.itemPayAmount = "";
	objArr.unshift(newRow);
	
	buildDataTable(objArr);
}

//Chari: Function for deleting new row
function deleteRow(row){
	$('.statusCls').removeClass('errCls');
	$('.statusCls').html('');
	objArr.splice(row,1);
	buildDataTable(objArr);
}

//Chari: Function for building obj array from json 
function buildObjArr(json_object){
	
	if(json_object != '' && json_object != undefined && json_object != '[]') 
// 		var json = JSON.parse(json_object);
		var json = json_object;
	
	for (var i = 0; i < json.length; i++) {
		var reqObj = new Object();
		var values = Object.values(json[i]);

		if(json[i]["Cash On Delivery"] != undefined) {
			if(json[i]["Cash On Delivery"].toLowerCase() == 'yes') {
				reqObj.codFlag = true;
			} else {
				reqObj.codFlag = false;
			}
		} else {
			reqObj.codFlag = true;
		}
		
		if(json[i]["Reciever Name"] != undefined) {
			reqObj.recieverName = json[i]["Reciever Name"];
		} else {
			reqObj.recieverName = "";
		}
		
		if(json[i]["Reciever Contact"] != undefined) {
			reqObj.recieverContact = json[i]["Reciever Contact"];
			var numVal = parseInt(reqObj.recieverContact);
			if(isNaN(numVal)) {
				reqObj.recieverContact = "";
			}
		} else {
			reqObj.recieverContact = "";
		}
		
		if(json[i]["City"] != undefined) {
			reqObj.recieverCity = json[i]["City"];
		} else {
			reqObj.recieverCity = "";
		}
		
		if(json[i]["Location"] != undefined) {
			reqObj.recieverLocation = json[i]["Location"];
		} else {
			reqObj.recieverLocation = "";
		}
		
		if(json[i]["Reciever Address"] != undefined) {
			reqObj.recieverHouseNo = json[i]["Reciever Address"];
		} else {
			reqObj.recieverHouseNo = "";
		}
		
		if(json[i]["Pincode"] != undefined) {
			reqObj.recieverPincode = json[i]["Pincode"];
		} else {
			reqObj.recieverPincode = "";
		}
		
		if(json[i]["Parcel Type"] != undefined) {
			reqObj.parcelType = json[i]["Parcel Type"];
		} else {
			reqObj.parcelType = "";
		}
		
		if(json[i]["Weight"] != undefined) {
			reqObj.weight = json[i]["Weight"];
			var numVal = Math.ceil(reqObj.weight);
			if(isNaN(numVal)) {
				reqObj.weight = "";
			} else {
				reqObj.weight = numVal;
			}
		} else {
			reqObj.weight = "";
		}
		
		if(json[i]["Item Price"] != undefined) {
			if(json[i]["Cash On Delivery"].toLowerCase() != 'yes') {
				reqObj.itemPayAmount = "";
			} else {
				reqObj.itemPayAmount = json[i]["Item Price"];
				var numVal = parseFloat(reqObj.itemPayAmount);
				if(isNaN(numVal)) {
					reqObj.itemPayAmount = "";
				} else {
					reqObj.itemPayAmount = numVal;
				}
			}
		} else {
			reqObj.itemPayAmount = "";
		}
		
		if(json[i]["Inclusive Charge"] != undefined) {
			if(json[i]["Cash On Delivery"].toLowerCase() != 'yes') {
				reqObj.deliveryChargeInclu = false;
			} else {
				var inclCrge = json[i]["Inclusive Charge"];
				if(inclCrge.toLowerCase()=="yes") {
					if(reqObj.itemPayAmount == '') {
						reqObj.deliveryChargeInclu = false;
					} else {
						reqObj.deliveryChargeInclu = true;
					}
				} else {
					reqObj.deliveryChargeInclu = false;
				}
			}
		} else {
			reqObj.deliveryChargeInclu = false;
		}
		objArr[i] = reqObj;
		
		/* for (var j = 0; j <values.length; j++) {
			
			if(j == 0) {
				reqObj.recieverName = values[j];
				
			} else if(j == 1) {
				reqObj.recieverContact = values[j];
			} else if(j == 2) {
				reqObj.recieverCity = values[j];
				
			} else if(j == 3) {
				reqObj.recieverLocation = values[j];
				
			} else if(j == 4) {
				reqObj.recieverHouseNo = values[j];
				
				
			} else if(j == 5) {
				reqObj.recieverPincode = values[j];
				
			} else if(j == 6) {
				reqObj.parcelType = values[j];
				
			}
			else if(j==7){
				reqObj.weight = values[j];
			}
			else if(j==8){
				if(values[j]==undefined)
					reqObj.itemPayAmount ="";
				else
				reqObj.itemPayAmount = values[j];
			}
			else if(j==9){
				if(values[j]=="Yes")
					reqObj.deliveryChargeInclu =true;
				else
					reqObj.deliveryChargeInclu =false;			
				}
			objArr[i] = reqObj;
		} */
}

}

//Chari: moved JSON to Datatable conversion into a method
function buildDataTable(objArr) {
	
	if(objArr.length>0) {
		var headers = "";
		var body = "";
		
		headers += "<tr role='row'>";
		headers +="<th>S.No.</th>";
		headers +="<th>Cash on<br>Delivery</th>";
		headers +="<th>Item<br>Price</th>";
		headers +="<th>Include<br>Delivery Charge</th>";
		headers +="<th>Reciever<br>Name</th>";
		headers +="<th>Reciever<br>Contact</th>";
		headers +="<th>Reciever<br>City</th>";
		headers +="<th>Reciever<br>Location</th>";
		headers +="<th>Reciever<br>Street/House Details</th>";
		headers +="<th>Pincode</th>";
		headers +="<th>Parcel<br>Type</th>";
		headers +="<th>Weight</th>";
		headers += "<th>Action</th></tr>";

		for (var i = 0; i < objArr.length; i++) {
			var reqObj = objArr[i];
			body += "<tr role='row'>";
			body += "<td><span class='rowNumCls'>"+(i+1)+"</span></td>";
			
			if(reqObj.codFlag == true) {
				body += "<td style='text-align: center;'><input class='tblinput styled-checkbox codcls' type='checkbox' id='cod_"+(i+1)+"' value='"+reqObj.codFlag+"' checked>";
				body += "<label class='codLblCls' for='cod_"+(i+1)+"'>&nbsp</label></td>";
			} else {
				body += "<td style='text-align: center;'><input class='tblinput styled-checkbox codcls' type='checkbox' id='cod_"+(i+1)+"' value='"+reqObj.codFlag+"'>";
				body += "<label class='codLblCls' for='cod_"+(i+1)+"'>&nbsp</label></td>";
			}
			
			var disabledVar = '';
			if(reqObj.codFlag != true) {
				disabledVar = ' disabled';
			}
			if(reqObj.itemPayAmount==undefined)
				body += "<td><input class='tblinput itemPayAmntCls' type='text' value='' "+disabledVar+"></td>";
			else
				body += "<td><input class='tblinput itemPayAmntCls' type='text' value='"+reqObj.itemPayAmount+"' "+disabledVar+"></td>"; 
			
			body +="<td>";
			
			if(reqObj.itemPayAmount == '') {
				reqObj.deliveryChargeInclu = 'false';
			}
			
			$(".parentCls > .incluChargeSelCls").find("option").removeAttr('selected');
			$(".parentCls > .incluChargeSelCls").val(reqObj.deliveryChargeInclu).find("option[value='" + reqObj.deliveryChargeInclu +"']").attr('selected', true);
			var incluChargeVar = $('.parentCls > .incluChargeSelCls').closest('.parentCls').html();
			if(reqObj.itemPayAmount!=undefined && reqObj.itemPayAmount != '') {
				incluChargeVar = incluChargeVar.replace('disabled="disabled"', '');
			}
			body += incluChargeVar;
			
			body +="</td>";
			
			body += "<td><input class='tblinput' type='text' value='"+reqObj.recieverName+"'></td>";
			body += "<td><input class='tblinput' type='text' value='"+reqObj.recieverContact+"'></td>";
			
			body += "<td>";
			$(".parentCls > .citySelCls").find("option").removeAttr('selected');
			if(reqObj.recieverCity == '') {
				reqObj.recieverCity = $(".parentCls > .citySelCls option:first").val();
			}
			
			if($(".parentCls > .citySelCls").find("option[value='" + reqObj.recieverCity +"']").length > 0) {
				$(".parentCls > .citySelCls").val(reqObj.recieverCity).find("option[value='" + reqObj.recieverCity +"']").attr('selected', true);
			} else {
				reqObj.recieverCity = '';
			}
			body += $('.parentCls > .citySelCls').closest('.parentCls').html();
			body += "</td>";
			
			var cityVar = reqObj.recieverCity.toLowerCase();
			body += "<td>";
			if($(".parentCls > .placeSelCls[city='"+cityVar+"']").length > 0) {
				$(".parentCls > .placeSelCls[city='"+cityVar+"']").find("option").removeAttr('selected');
				if(reqObj.recieverLocation == '') {
					reqObj.recieverLocation = $(".parentCls > .placeSelCls[city='"+cityVar+"'] option:first").val();
				}
				
				if($(".parentCls > .placeSelCls[city='"+cityVar+"']").find("option[value='" + reqObj.recieverLocation +"']").length > 0) {
					$(".parentCls > .placeSelCls[city='"+cityVar+"']").val(reqObj.recieverLocation).find("option[value='" + reqObj.recieverLocation +"']").attr('selected', true);
				} else {
					reqObj.recieverLocation = '';
				}
				body += $(".parentCls > .placeSelCls[city='"+cityVar+"']").closest('.parentCls').html();
			} else {
				reqObj.recieverLocation = '';
				body += $(".parentCls > .placeSelCls[city='dummy']").closest('.parentCls').html();
			}
			
			body += "</td>";
// 			body += "<td><input class='tblinput placeSelCls' type='text' value='"+reqObj.recieverLocation+"'></td>";
			
			body += "<td><input class='tblinput' type='text' value='"+reqObj.recieverHouseNo+"' style='width: 200px !important;'></td>";
			body += "<td><input class='tblinput' type='text' value='"+reqObj.recieverPincode+"' style='width: 100px !important;'></td>";	
			body += "<td>";
			
			$(".parentCls > .parcelTypeSelCls").find("option").removeAttr('selected');
			if(reqObj.parcelType == '') {
				reqObj.parcelType = $(".parentCls > .parcelTypeSelCls option:first").val();
			}
			reqObj.parcelType = reqObj.parcelType.toLowerCase();
			
			$(".parentCls > .parcelTypeSelCls").val(reqObj.parcelType).find("option[value='" + reqObj.parcelType +"']").attr('selected', true);
			body += $('.parentCls > .parcelTypeSelCls').closest('.parentCls').html();
			
			body += "</td>";
			
				 
			body += "<td><input class='tblinput' type='text' value='"+reqObj.weight+"' style='width: 60px !important;'></td>";
			
			body+="<td><span style='float:left;width:80px;text-align: center;'><span class='tblcolumnlbl tblActionCls viewdelivercls delbtn' style='height: 20px;font-size: 0.7rem;' reqid="+i+" onclick='deleteRow($(this).attr(\"reqid\"));'>Delete</span></span></td>"

			body += "</tr>";
		}

		$("#tableDiv").empty();
		$("#tableDiv")
				.append(
						"<table width='100%' class='table table-striped table-bordered dataTable no-footer' id='tableId'><thead>"
								+ headers
								+ "</thead><tbody>"
								+ body
								+ "</tbody></table>");

		dataTable1 = $('#tableId').DataTable({
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 2, "desc" ] ],
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
			"pageLength" : 25,
			"order" : [ [ 0, "asc" ] ],
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ],
			"columnDefs": [
				{
					targets: [0, 8, 9],
					type: 'num',
					render: function(data, type, full, meta){
						if (type === 'filter' || type === 'sort') {
							var api = new $.fn.dataTable.Api(meta.settings);
							var td = api.cell({row: meta.row, column: meta.col}).node();
							if(meta.col == 0) {
								data = $('.rowNumCls', td).html();
							} else {
								data = $('select, input[type="text"], input[type="checkbox"]', td).val();
							}
						}
						return data;
					}
				},
				{
					targets: [1, 2, 3, 4, 5, 6, 7, 10],
					type: 'string',
					render: function(data, type, full, meta){
						if (type === 'filter' || type === 'sort') {
							var api = new $.fn.dataTable.Api(meta.settings);
							var td = api.cell({row: meta.row, column: meta.col}).node();
							if(meta.col == 0) {
								data = $('.rowNumCls', td).html();
							} else {
								data = $('select, input[type="text"], input[type="checkbox"]', td).val();
							}
						}
						return data;
					}
				},
				{ 
					bSortable: false, 
					aTargets: [ -1 ]
				}
			],
			"initComplete": function(settings, json) {
				validateTable();
			}
			/* "drawCallback": function(){
				console.log('IN');
				validateTable();
			} */
			/* "rowCallback": function(row, data, dataIndex) {
				if(rowErrInfo != undefined) {
					var rowErrInfoDtl = rowErrInfo[dataIndex];
					if(rowErrInfoDtl != null && rowErrInfoDtl != undefined && rowErrInfoDtl.errFlag ==  true) {
						$(row).addClass('rowHighlight');
					}
				}
			} */
		});
		
		$(".finalBtnDivCls").show();
		$('.initbtndivcls').slideUp();
		$('.initbtndivcls2').slideDown();
	} else {
		alert('Please fill atleast one row');
	}
}

function validateTable() {
	$('.rowHighlight').removeClass('rowHighlight');
	$('.colHighlight').removeClass('colHighlight');
	if(dataTable1 != undefined && dataTable1.rows().indexes().length) {
		dataTable1.rows(function (idx, data, row) {
			if(rowErrInfo != undefined) {
				var rowErrInfoDtl = rowErrInfo[idx];
				if(rowErrInfoDtl != null && rowErrInfoDtl != undefined && rowErrInfoDtl.errFlag ==  true) {
					$(row).addClass('rowHighlight');
					$(row).find('td').each(function(index, elem){
						if(index==4 && rowErrInfoDtl.recieverLocation == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==1 && rowErrInfoDtl.recieverName == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==3 && rowErrInfoDtl.recieverCity == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==5 && rowErrInfoDtl.recieverHouseNo == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==6 && rowErrInfoDtl.recieverPincode == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==2 && rowErrInfoDtl.recieverContact == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==7 && rowErrInfoDtl.parcelType == true) {
							$(elem).addClass('colHighlight');
		   				}
						if(index==8 && rowErrInfoDtl.weight == true) {
							$(elem).addClass('colHighlight');
		   				}
					});
				}
			}
        });      
    }
}

function handleFileSelect(evt) {
	var files = evt.target.files; // FileList object
	var xl2json = new ExcelToJSON();
	xl2json.parseExcel(files[0]);
}
</script>
</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
				<div class="container">
					<h5 class="font-weight-bold">
						<span>Upload Deliveries</span>
						<span class="fa fa-info-circle helpCls">
							<span class="hlpTitleCls">Help</span>
							<span class="hlpBodyCls">
								<span class="helpStepCls">
								    <span class="helpStepHdrCls">Step 1</span>
								    <span class="helpStepRowCls">Download template excel file</span>
								</span>
								<span class="helpStepCls">
								    <span class="helpStepHdrCls">Step 2</span>
								    <span class="helpStepRowCls">Upload excel file</span>
								</span>
								<span class="helpStepCls">
								    <span class="helpStepHdrCls">Step 3</span>
								    <span class="helpStepRowCls">Edit table if changes need</span>
								</span>
								<span class="helpStepCls">
								    <span class="helpStepHdrCls">Step 4</span>
								    <span class="helpStepRowCls">Click 'Upload File' button</span>
								</span>
							</span>
						</span>
					</h5>
									
					<div class="row">
						<div class="col-md-12 mr-auto statusCls"></div>
						<div class="col-md-12 mr-auto initbtndivcls" style="margin-top: 20px; margin-bottom: 50px;">
							<div class="row formcls">
								<div class="col-md-6 mr-auto"></div>
								<div class="col-md-12 mr-auto">
									<button class="btn btn-primary" id="choose_file" style="margin-right: 20px;">
										<span class="fa fa-file btn-icon"></span> Choose a File</button>
									<input id="uploadFile" type=file  name="files[]" style="display: none;" accept=".xlsx, .xls">
									
									<button class="btn btn-primary btn-primary-gray" id="download_template">
										<span class="fa fa-download btn-icon"></span> Download Template</button>
										
								</div>
							</div>
						</div>
						<!-- Chari: Added new button for Adding new row -->
						<div class="col-md-12 mr-auto initbtndivcls2" style="display:none;margin-top: 20px; margin-bottom: 10px;">
							<div class="row formcls">
								<div class="col-md-12 mr-auto">
									<div class="noteCls">
										<div style="color: red; font-weight: bold;">Note:</div>
										<div style="color: red;">Cash On Delivery</div>
										<div style="margin-bottom: 6px;">
											<div>If Yes, Delivery charge will be collected from customer</div>
											<div>If No, Delivery charge will be collected from you <span>(Item Price will not be considered)</span></div>
										</div>
										<div style="color: red;">Item Price</div>
										<div style="margin-bottom: 6px;">
											Need to collect cash from customer on the item amount (If yes, provide the item amount)
										</div>
										<div style="color: red;">Inclusive Charge</div>
										<div>
											Need to include delivery charge in the item amount (Yes / No)
										</div>
									</div>
								</div>
								<div class="col-md-12 mr-auto">
									<button class="btn btn-primary" id="newRowbtn" style="float: left;">
								<span class="fa fa-plus btn-icon"></span>Add New Row</button>
								</div>
							</div>
						</div>
						
						

						<div id="tableDiv" class="col-md-12 mr-auto" style="margin-top: 20px;"></div>
						<div class="col-md-12 mr-auto finalBtnDivCls" align="left" style="margin-top: 30px; display: none;">
							<button class="btn btn-primary" id="uploadbtn" style="float: left;">
								<span class="fa fa-upload btn-icon"></span> Upload File</button>
							<button class="btn btn-primary btn-primary-gray" id="cancelbtn" style="float: left; margin-left: 20px;">
								<span class="fa fa-angle-left btn-icon"></span> Cancel</button>
								
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<div style="display: none;">
		<div class="parentCls">
			<select class="tblinput citySelCls">
				<option value=""> -- </option>
				<option value="${serviceCity}">${serviceCity}</option>
			</select>
		</div>
		
		<div class="parentCls">
			<select class="tblinput placeSelCls" city="chennai">
				<option value=""> -- </option>
				<option value="Abhiramapuram">Abhiramapuram</option>
				<option value="Adambakkam">Adambakkam</option>
				<option value="Adyar">Adyar</option>
				<option value="Agaram">Agaram</option>
				<option value="Akkarai">Akkarai</option>
				<option value="Alandur">Alandur</option>
				<option value="Alapakkam, Porur">Alapakkam, Porur</option>
				<option value="Alwarpet">Alwarpet</option>
				<option value="Alwarthirunagar, Valasaravakkam">Alwarthirunagar, Valasaravakkam</option>
				<option value="Alwarthirunagar">Alwarthirunagar</option>
				<option value="Ambattur">Ambattur</option>
				<option value="Aminjikarai">Aminjikarai</option>
				<option value="Anakaputhur">Anakaputhur</option>
				<option value="Andarkuppam, Manali">Andarkuppam, Manali</option>
				<option value="Anna Nagar">Anna Nagar</option>
				<option value="Anna Nagar West">Anna Nagar West</option>
				<option value="Anna Salai">Anna Salai</option>
				<option value="Mount Road">Mount Road</option>
				<option value="Annanur">Annanur</option>
				<option value="Ariyalur">Ariyalur</option>
				<option value="Arumbakkam">Arumbakkam</option>
				<option value="Ashok Nagar">Ashok Nagar</option>
				<option value="Assisi Nagar, Manali">Assisi Nagar, Manali</option>
				<option value="Athipattu, Ambattur">Athipattu, Ambattur</option>
				<option value="Athipattu">Athipattu</option>
				<option value="Athipet">Athipet</option>
				<option value="Avadi">Avadi</option>
				<option value="Avurikollaimedu, Manali">Avurikollaimedu, Manali</option>
				<option value="Ayanambakkam">Ayanambakkam</option>
				<option value="Ayanavaram">Ayanavaram</option>
				<option value="Ayapakkam">Ayapakkam</option>
				<option value="Basin Bridge">Basin Bridge</option>
				<option value="Besant Nagar">Besant Nagar</option>
				<option value="Boat Club">Boat Club</option>
				<option value="Broadway">Broadway</option>
				<option value="Burma Bazaar">Burma Bazaar</option>
				<option value="Central">Central</option>
				<option value="Chepauk">Chepauk</option>
				<option value="Cheran nagar, Perumbakkam">Cheran nagar, Perumbakkam</option>
				<option value="Chetpet ">Chetpet </option>
				<option value="Chetput">Chetput</option>
				<option value="Chinnasekkadu, Manali">Chinnasekkadu, Manali</option>
				<option value="Chintadripet">Chintadripet</option>
				<option value="Chintamani">Chintamani</option>
				<option value="Chitlapakkam">Chitlapakkam</option>
				<option value="Choolaimedu">Choolaimedu</option>
				<option value="Choolai">Choolai</option>
				<option value="Chromepet">Chromepet</option>
				<option value="Chrompet">Chrompet</option>
				<option value="CIT Nagar">CIT Nagar</option>
				<option value="Defence Colony">Defence Colony</option>
				<option value="Dhargaas">Dhargaas</option>
				<option value="Echankuzhi">Echankuzhi</option>
				<option value="Edapalayam">Edapalayam</option>
				<option value="Egmore">Egmore</option>
				<option value="Ekkaduthangal">Ekkaduthangal</option>
				<option value="Ennore">Ennore</option>
				<option value="Eranavur">Eranavur</option>
				<option value="Erukkanchery">Erukkanchery</option>
				<option value="Erukanchery">Erukanchery</option>
				<option value="Erukkancherry">Erukkancherry</option>
				<option value="Foreshore Estate">Foreshore Estate</option>
				<option value="Fort St. George">Fort St. George</option>
				<option value="George Town">George Town</option>
				<option value="Gerugambakkam">Gerugambakkam</option>
				<option value="Gopalapuram">Gopalapuram</option>
				<option value="Government Estate">Government Estate</option>
				<option value="Gowrivakkam">Gowrivakkam</option>
				<option value="Grant Lyon, Red Hills">Grant Lyon, Red Hills</option>
				<option value="Greenways Road">Greenways Road</option>
				<option value="Guindy">Guindy</option>
				<option value="Guindy TVK Estate">Guindy TVK Estate</option>
				<option value="Hasthinapuram, Chromepet">Hasthinapuram, Chromepet</option>
				<option value="ICF">ICF</option>
				<option value="ICF Colony">ICF Colony</option>
				<option value="IIT Madras">IIT Madras</option>
				<option value="Indhra Nagar">Indhra Nagar</option>
				<option value="Injambakkam">Injambakkam</option>
				<option value="Irumbuliyur, Tambaram West">Irumbuliyur, Tambaram West</option>
				<option value="Iyyapanthangal">Iyyapanthangal</option>
				<option value="J J Nagar">J J Nagar</option>
				<option value="Jafferkhanpet">Jafferkhanpet</option>
				<option value="Jaladampet, Pallikaranai">Jaladampet, Pallikaranai</option>
				<option value="Jamalia">Jamalia</option>
				<option value="Jawahar Nagar">Jawahar Nagar</option>
				<option value="K.K. Nagar">K.K. Nagar</option>
				<option value="Kaaladipettai">Kaaladipettai</option>
				<option value="Kaladipet, Thiruvottiyur">Kaladipet, Thiruvottiyur</option>
				<option value="Kadapakkam">Kadapakkam</option>
				<option value="Kalakkral, Manali">Kalakkral, Manali</option>
				<option value="Kallikuppam, Ambattur">Kallikuppam, Ambattur</option>
				<option value="Kandanchavadi">Kandanchavadi</option>
				<option value="Kanniammanpettai, Manali">Kanniammanpettai, Manali</option>
				<option value="Karambakkam">Karambakkam</option>
				<option value="Karapakkam">Karapakkam</option>
				<option value="Karayanchavadi">Karayanchavadi</option>
				<option value="Karukku">Karukku</option>
				<option value="Kasimedu">Kasimedu</option>
				<option value="Kasturba Nagar">Kasturba Nagar</option>
				<option value="Kathirvedu, Puzhal">Kathirvedu, Puzhal</option>
				<option value="Kathivakkam">Kathivakkam</option>
				<option value="Kattivakkam, Ennore">Kattivakkam, Ennore</option>
				<option value="Kattupakkam">Kattupakkam</option>
				<option value="Kattur road">Kattur road</option>
				<option value="Kattur">Kattur</option>
				<option value="Kavangarai, Puzhal">Kavangarai, Puzhal</option>
				<option value="Kazhipattur, Siruseri">Kazhipattur, Siruseri</option>
				<option value="Keelkattalai">Keelkattalai</option>
				<option value="Kilpauk">Kilpauk</option>
				<option value="KK Thazhai">KK Thazhai</option>
				<option value="KKD Nagar">KKD Nagar</option>
				<option value="Kaviarasu Kannadhasan Nagar">Kaviarasu Kannadhasan Nagar</option>
				<option value="Kodambakkam">Kodambakkam</option>
				<option value="Kodungaiyur">Kodungaiyur</option>
				<option value="Koladi">Koladi</option>
				<option value="Kolapakkam">Kolapakkam</option>
				<option value="Kolathur">Kolathur</option>
				<option value="Kondithoppu">Kondithoppu</option>
				<option value="Kondithope">Kondithope</option>
				<option value="Konnur">Konnur</option>
				<option value="Konnur, ICF">Konnur, ICF</option>
				<option value="Korattur">Korattur</option>
				<option value="Korukkupet">Korukkupet</option>
				<option value="Kosapet, Purasaiwakkam">Kosapet, Purasaiwakkam</option>
				<option value="Kosappur">Kosappur</option>
				<option value="Kothawal Chavadi">Kothawal Chavadi</option>
				<option value="Kottivakkam">Kottivakkam</option>
				<option value="Kottur">Kottur</option>
				<option value="Kottur garden">Kottur garden</option>
				<option value="Kotturpuram">Kotturpuram</option>
				<option value="Kovilambakkam">Kovilambakkam</option>
				<option value="Kovur, Kanchipuram">Kovur, Kanchipuram</option>
				<option value="Kovur">Kovur</option>
				<option value="Koyambedu">Koyambedu</option>
				<option value="Kumananchavadi">Kumananchavadi</option>
				<option value="Kumaran Nagar">Kumaran Nagar</option>
				<option value="Kundrathur">Kundrathur</option>
				<option value="Lakshmipuram">Lakshmipuram</option>
				<option value="Lakshmipuram, Kolathur">Lakshmipuram, Kolathur</option>
				<option value="Madambakkam">Madambakkam</option>
				<option value="Madhananthapuram">Madhananthapuram</option>
				<option value="Madhavaram">Madhavaram</option>
				<option value="Madhavaram Milk Colony">Madhavaram Milk Colony</option>
				<option value="Madhuvankarai ">Madhuvankarai </option>
				<option value="Maduvankarai">Maduvankarai</option>
				<option value="Madipakkam">Madipakkam</option>
				<option value="Maduravoyal">Maduravoyal</option>
				<option value="Mahakavi Bharathi Nagar">Mahakavi Bharathi Nagar</option>
				<option value="M.K.B Nagar">M.K.B Nagar</option>
				<option value="Mambakkam">Mambakkam</option>
				<option value="Mambalam">Mambalam</option>
				<option value="Manali">Manali</option>
				<option value="Manali New Town">Manali New Town</option>
				<option value="Manali Pudhunagar">Manali Pudhunagar</option>
				<option value="Manapakkam">Manapakkam</option>
				<option value="Mandaveli">Mandaveli</option>
				<option value="Mangadu">Mangadu</option>
				<option value="Manjambakkam, Madhavaram">Manjambakkam, Madhavaram</option>
				<option value="Mannadi">Mannadi</option>
				<option value="Mannady">Mannady</option>
				<option value="Mathur, MMDA">Mathur, MMDA</option>
				<option value="Mathur MMDA">Mathur MMDA</option>
				<option value="Medavakkam">Medavakkam</option>
				<option value="Meenambakkam">Meenambakkam</option>
				<option value="Menambedu">Menambedu</option>
				<option value="MEPZ">MEPZ</option>
				<option value="MGR Gardens">MGR Gardens</option>
				<option value="M.G.R Garden">M.G.R Garden</option>
				<option value="MGR Nagar">MGR Nagar</option>
				<option value="Minjur">Minjur</option>
				<option value="MKB Nagar">MKB Nagar</option>
				<option value="MMDA Colony">MMDA Colony</option>
				<option value="Mogappair">Mogappair</option>
				<option value="Moolakadai">Moolakadai</option>
				<option value="Moulivakkam">Moulivakkam</option>
				<option value="Mowlivakkam">Mowlivakkam</option>
				<option value="Mount Road">Mount Road</option>
				<option value="MRC Nagar">MRC Nagar</option>
				<option value="Mudichur">Mudichur</option>
				<option value="Mugalivakkam">Mugalivakkam</option>
				<option value="Muthialpet">Muthialpet</option>
				<option value="Mylapore">Mylapore</option>
				<option value="Nandambakkam">Nandambakkam</option>
				<option value="Nandanam">Nandanam</option>
				<option value="Nanganallur">Nanganallur</option>
				<option value="Nanmangalam">Nanmangalam</option>
				<option value="Naravarikuppam">Naravarikuppam</option>
				<option value="Neelankarai">Neelankarai</option>
				<option value="Nemilichery">Nemilichery</option>
				<option value="Nerkundram, Sholavaram">Nerkundram, Sholavaram</option>
				<option value="Nesapakkam">Nesapakkam</option>
				<option value="Nochikuppam">Nochikuppam</option>
				<option value="Nolambur">Nolambur</option>
				<option value="Noombal">Noombal</option>
				<option value="Noothancheri">Noothancheri</option>
				<option value="Nungambakkam">Nungambakkam</option>
				<option value="Okkiyam">Okkiyam</option>
				<option value="Otteri">Otteri</option>
				<option value="Ottiambakkam">Ottiambakkam</option>
				<option value="Padi">Padi</option>
				<option value="Pakkam">Pakkam</option>
				<option value="Palavakkam">Palavakkam</option>
				<option value="Palavanthangal">Palavanthangal</option>
				<option value="Pallavaram">Pallavaram</option>
				<option value="Pallikaranai">Pallikaranai</option>
				<option value="Pammal">Pammal</option>
				<option value="Panagal Park">Panagal Park</option>
				<option value="Panaiyur">Panaiyur</option>
				<option value="Paraniputhur">Paraniputhur</option>
				<option value="Parivakkam">Parivakkam</option>
				<option value="Park Town">Park Town</option>
				<option value="Parry's Corner">Parry's Corner</option>
				<option value="Pattabiram">Pattabiram</option>
				<option value="Pattaravakkam">Pattaravakkam</option>
				<option value="Pazhavanthangal">Pazhavanthangal</option>
				<option value="pazhayavannarapettai ">pazhayavannarapettai </option>
				<option value="Old Washermenpet">Old Washermenpet</option>
				<option value="Peerkankaranai">Peerkankaranai</option>
				<option value="Perambur">Perambur</option>
				<option value="Peravallur">Peravallur</option>
				<option value="Periamet">Periamet</option>
				<option value="Periametu">Periametu</option>
				<option value="Periyar Nagar">Periyar Nagar</option>
				<option value="Perumbakkam">Perumbakkam</option>
				<option value="Perungalathur">Perungalathur</option>
				<option value="Perungudi">Perungudi</option>
				<option value="Poes Garden">Poes Garden</option>
				<option value="Polichalur">Polichalur</option>
				<option value="Pondy Bazaar">Pondy Bazaar</option>
				<option value="Ponni Nagar">Ponni Nagar</option>
				<option value="Ponniammanmedu">Ponniammanmedu</option>
				<option value="Poonamallee">Poonamallee</option>
				<option value="Porur">Porur</option>
				<option value="Pozhichalur">Pozhichalur</option>
				<option value="Pudhuvannarapettai">Pudhuvannarapettai</option>
				<option value="New Washermenpet ">New Washermenpet </option>
				<option value="Pudupet">Pudupet</option>
				<option value="Pudur, Ambattur">Pudur, Ambattur</option>
				<option value="Pudur">Pudur</option>
				<option value="Pudhur">Pudhur</option>
				<option value="Pulianthope">Pulianthope</option>
				<option value="Pulinanthope">Pulinanthope</option>
				<option value="Purasaiwalkam">Purasaiwalkam</option>
				<option value="Puthagaram">Puthagaram</option>
				<option value="Puzhal">Puzhal</option>
				<option value="Puzhuthivakkam">Puzhuthivakkam</option>
				<option value="Quibble Island">Quibble Island</option>
				<option value="R.A.Puram">R.A.Puram</option>
				<option value="Raja Annamalai Puram">Raja Annamalai Puram</option>
				<option value="Raj Bhavan">Raj Bhavan</option>
				<option value="Rajakadai">Rajakadai</option>
				<option value="Raja Kadai, Thiruvottiyur">Raja Kadai, Thiruvottiyur</option>
				<option value="Ramapuram">Ramapuram</option>
				<option value="Ramavaram">Ramavaram</option>
				<option value="Red Hills">Red Hills</option>
				<option value="Retteri">Retteri</option>
				<option value="Royapettah">Royapettah</option>
				<option value="Royapuram">Royapuram</option>
				<option value="Sadayankuppam">Sadayankuppam</option>
				<option value="Saidapet">Saidapet</option>
				<option value="Saligramam">Saligramam</option>
				<option value="Santhome">Santhome</option>
				<option value="Sathangadu">Sathangadu</option>
				<option value="Sathyamoorthy Nagar (Choolaimedu)">Sathyamoorthy Nagar (Choolaimedu)</option>
				<option value="Sathyamoorthy Nagar (Tiruvottiyur)">Sathyamoorthy Nagar (Tiruvottiyur)</option>
				<option value="Sathyamoorthy Nagar (Vyasarpadi)">Sathyamoorthy Nagar (Vyasarpadi)</option>
				<option value="Selaiyur">Selaiyur</option>
				<option value="Selavoyal">Selavoyal</option>
				<option value="selavayal">selavayal</option>
				<option value="Sembakkam">Sembakkam</option>
				<option value="Sembium">Sembium</option>
				<option value="Sembiam">Sembiam</option>
				<option value="Sembiyamanali">Sembiyamanali</option>
				<option value="Semmencherry">Semmencherry</option>
				<option value="Seneerkuppam">Seneerkuppam</option>
				<option value="Seven Wells">Seven Wells</option>
				<option value="Ezhu Ginaru">Ezhu Ginaru</option>
				<option value="Shenoy Nagar">Shenoy Nagar</option>
				<option value="Sholavaram">Sholavaram</option>
				<option value="Sholinganallur">Sholinganallur</option>
				<option value="Sirugavoor">Sirugavoor</option>
				<option value="Sirugavur">Sirugavur</option>
				<option value="Sithalapakkam">Sithalapakkam</option>
				<option value="Sowcarpet">Sowcarpet</option>
				<option value="Srinagar Colony">Srinagar Colony</option>
				<option value="St. Thomas Mount">St. Thomas Mount</option>
				<option value="Surapet">Surapet</option>
				<option value="T Nagar">T Nagar</option>
				<option value="Tambaram">Tambaram</option>
				<option value="Tambaram Sanatorium">Tambaram Sanatorium</option>
				<option value="Taramani">Taramani</option>
				<option value="Teynampet">Teynampet</option>
				<option value="Thalambur">Thalambur</option>
				<option value="Tharamani">Tharamani</option>
				<option value="Tharapakkam">Tharapakkam</option>
				<option value="The Island">The Island</option>
				<option value="Theeyampakkam">Theeyampakkam</option>
				<option value="Theeyambakkam">Theeyambakkam</option>
				<option value="Thirumangalam">Thirumangalam</option>
				<option value="Thirumazhisai">Thirumazhisai</option>
				<option value="Thirumullaivoyal">Thirumullaivoyal</option>
				<option value="Thirumullaivayal">Thirumullaivayal</option>
				<option value="Thiruneermalai">Thiruneermalai</option>
				<option value="Thirunindravur">Thirunindravur</option>
				<option value="Thiruvanmiyur">Thiruvanmiyur</option>
				<option value="Thiruvotriyur">Thiruvotriyur</option>
				<option value="Thousand Lights">Thousand Lights</option>
				<option value="Thuraipakkam">Thuraipakkam</option>
				<option value="Thoraipakkam">Thoraipakkam</option>
				<option value="Tirusulam">Tirusulam</option>
				<option value="Tiruvallikeni">Tiruvallikeni</option>
				<option value="Tiruverkadu">Tiruverkadu</option>
				<option value="Thiruverkadu">Thiruverkadu</option>
				<option value="Tiruvottiyur">Tiruvottiyur</option>
				<option value="Tolgate">Tolgate</option>
				<option value="Tollgate">Tollgate</option>
				<option value="Tondiarpet">Tondiarpet</option>
				<option value="Triplicane">Triplicane</option>
				<option value="Trustpuram">Trustpuram</option>
				<option value="TVK Nagar">TVK Nagar</option>
				<option value="Thiru Vi Ka Nagar">Thiru Vi Ka Nagar</option>
				<option value="Ullagaram">Ullagaram</option>
				<option value="United India Colony">United India Colony</option>
				<option value="Urapakkam">Urapakkam</option>
				<option value="Vadapalani">Vadapalani</option>
				<option value="Vadaperumbakkam">Vadaperumbakkam</option>
				<option value="Vaikkadu, Manali">Vaikkadu, Manali</option>
				<option value="Valasaravakkam">Valasaravakkam</option>
				<option value="Vallalar Nagar">Vallalar Nagar</option>
				<option value="Vanagaram">Vanagaram</option>
				<option value="Vandalur">Vandalur</option>
				<option value="Vanuvampet">Vanuvampet</option>
				<option value="Varadharajapuram">Varadharajapuram</option>
				<option value="Velachery">Velachery</option>
				<option value="Velappanchavadi">Velappanchavadi</option>
				<option value="Vengaivasal">Vengaivasal</option>
				<option value="Vepery">Vepery</option>
				<option value="Veppery">Veppery</option>
				<option value="Villivakkam">Villivakkam</option>
				<option value="Vinayagapuram">Vinayagapuram</option>
				<option value="Vinduthalai Nagar">Vinduthalai Nagar</option>
				<option value="Virugambakkam">Virugambakkam</option>
				<option value="VOC Nagar">VOC Nagar</option>
				<option value="Vyasar Nagar">Vyasar Nagar</option>
				<option value="Vyasarpadi">Vyasarpadi</option>
				<option value="Washermanpet">Washermanpet</option>
				<option value="West Mambalam">West Mambalam</option>
				<option value="Zamin Pallavaram">Zamin Pallavaram</option>
			</select>
		</div>
		
		<div class="parentCls">
			<select class="tblinput placeSelCls" city="salem">
				<option value=""> -- </option>
				<option value="Adambakkam">Adambakkam</option>
				<option value="A.N.Mangalam B.O">A.N.Mangalam B.O</option>
				<option value="Achankuttapatti B.O">Achankuttapatti B.O</option>
				<option value="Adikarai B.O">Adikarai B.O</option>
				<option value="Ammapalayam">Ammapalayam</option>
				<option value="Ammapet">Ammapet</option>
				<option value="Andipatti B.O">Andipatti B.O</option>
				<option value="Anuppur B.O">Anuppur B.O</option>
				<option value="Asambur B.O">Asambur B.O</option>
				<option value="Asthampatty">Asthampatty</option>
				<option value="Ayodhiyapattinam">Ayodhiyapattinam</option>
				<option value="Chendrayampalayam B.O">Chendrayampalayam B.O</option>
				<option value="Devendrapuram">Devendrapuram</option>
				<option value="Fairlands">Fairlands</option>
				<option value="Five Roads">Five Roads</option>
				<option value="Four Roads">Four Roads</option>
				<option value="Govt Engg College">Govt Engg College</option>
				<option value="Gugai">Gugai</option>
				<option value="Junction">Junction</option>
				<option value="Kandashramam B.O">Kandashramam B.O</option>
				<option value="Kannakurichi">Kannakurichi</option>
				<option value="Keeraikadu B.O">Keeraikadu B.O</option>
				<option value="Kondalampatti">Kondalampatti</option>
				<option value="Maramangalathupatti">Maramangalathupatti</option>
				<option value="Nethimedu">Nethimedu</option>
				<option value="Salem">Salem</option>
				<option value="Salem Steel Plant">Salem Steel Plant</option>
				<option value="Seelanaickenpatti">Seelanaickenpatti</option>
				<option value="Town">Town</option>
				<option value="Udayampatty">Udayampatty</option>
			</select>
		</div>
		
		<div class="parentCls">
			<select class="tblinput placeSelCls" city="dummy">
				<option value=""> -- </option>
			</select>
		</div>
		
		<div class="parentCls">
			<select class="tblinput parcelTypeSelCls">
				<option value="document">Document/Books</option>
				<option value="electronics">Electronics</option>
				<option value="food">Food/Medicine/Vegetables</option>
				<option value="metal">Metal</option>
				<option value="dress">Dress</option>
				<option value="others">Others</option>
			</select>
		</div>
		
		<div class="parentCls">
			<select class="tblinput incluChargeSelCls" disabled="disabled">
				<option value="true">Yes</option>
				<option value="false" >No</option>
			</select>
		</div>
	</div>
</body>
</html>