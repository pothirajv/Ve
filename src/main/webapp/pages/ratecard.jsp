<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script>

var objArr=[];
var objArr1=[];
var dataTable1;
$(document).ready(function(){
	$("#loc1").parent().hide();

	
	$.ajax({
		url : $("#contextPath").val()+'/adm/getLocation',
		type : 'POST',
		data :{} ,
		success:function(data){
			var htmlVar="";
			for(var i =0;i<data.length;i++){
				htmlVar+="<option value='"+data[i]+"'>"+data[i]+"</option>";
			}
			$("#loc1").append(htmlVar);
			$("#loc1").chosen();
		},
		error:function(data){}
	});
	
	$("#ratecard1").hide();
	$('input[type=radio][name=action]').change(function() {
	    if (this.value == 'update') {
	    	$("#loc1").parent().show();
	    	$("#ratecard1").hide();
	    	$("#ratecard").show();
	    }
	    else if (this.value == 'insert') {
	    	$("#ratecard1").show();
	    	$("#loc1").parent().hide();
	    	$("#ratecard").hide();
	    	var newRow=new Object();
	    	newRow.key = "";
	    	newRow.startKm = "";
	    	newRow.endKm = "";
	    	newRow.percentageIncrease = "";
	    	objArr1.unshift(newRow);
	    	buildDataTable1(objArr1);
	    }
	});
	$("#loc1").change(function() {
		var loc1=$("#loc1").val();
		
		$.ajax({
			url : $("#contextPath").val()+'/adm/getRateCard',
			type : 'POST',
			data :{'loc':loc1} ,
			success:function(data){
			
				var ratecard=data[0];
				$("#brate").val(ratecard.baseRate);
				$("#bratekl").val(ratecard.baseRateKilometer);
				$("#bratewt").val(ratecard.baseRateWeight);
				$("#klbr").val(ratecard.kilometerBreaker);
				$("#maxkl").val(ratecard.maximumKilometer);
				$("#maxwt").val(ratecard.maximumWeight);
				$("#rklbr").val(ratecard.rateForKilometerBreaker);
				$("#rwtbr").val(ratecard.rateForWeightBreaker);
				$("#wtbr").val(ratecard.weightBreaker);
				buildDataTable(ratecard.rateSlab);
				
				
			}
			});
		$("#cityname").html(loc1);
		$("#ratecard").parent().slideDown(500);
		});
	$("#rateupdatebtn").click(function(){
		var rateCardModel= new Object();
		rateCardModel.city=$("#loc1").val();
		rateCardModel.baseRate=$("#brate").val();
		rateCardModel.baseRateKilometer=$("#bratekl").val();
		rateCardModel.baseRateWeight=$("#bratewt").val();
		rateCardModel.kilometerBreaker=$("#klbr").val();
		rateCardModel.maximumKilometer=$("#maxkl").val();
		rateCardModel.maximumWeight=$("#maxwt").val();
		rateCardModel.rateForKilometerBreaker=$("#rklbr").val();
		rateCardModel.rateForWeightBreaker=$("#rwtbr").val();
		rateCardModel.weightBreaker=$("#wtbr").val();
		rateCardModel.rateSlab=objArr;
				$.ajax({
			url : $("#contextPath").val()+"/adm/rateUpdate",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(rateCardModel),
			dataType : "json",
			success : function(data) {
				alert("Successfully Updated!!");
	},
		error : function(data) {
			alert("Successfully Updated!!");
}
		});
});
	$("#rateinsertbtn").click(function(event){
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
		
		var rateCardModel= new Object();
		rateCardModel.city=$("#city1").val();
		rateCardModel.baseRate=$("#brate1").val();
		rateCardModel.baseRateKilometer=$("#bratekl1").val();
		rateCardModel.baseRateWeight=$("#bratewt1").val();
		rateCardModel.kilometerBreaker=$("#klbr1").val();
		rateCardModel.maximumKilometer=$("#maxkl1").val();
		rateCardModel.maximumWeight=$("#maxwt1").val();
		rateCardModel.rateForKilometerBreaker=$("#rklbr1").val();
		rateCardModel.rateForWeightBreaker=$("#rwtbr1").val();
		rateCardModel.weightBreaker=$("#wtbr1").val();
		rateCardModel.rateSlab=objArr1;
		
		$.ajax({
			url : $("#contextPath").val()+"/adm/rateInsert",
			contentType : 'application/json',
			method : 'POST',
			data : JSON.stringify(rateCardModel),
			dataType : "json",
			success : function(data) {
				alert("Successfully Updated!!");
	},
		error : function(data) {
			alert("Successfully Updated!!");
}
		});
		}

		});
	

function buildDataTable(rateSlab) {
	
	if(rateSlab.length>0) {
		var headers = "";
		var body = "";
		
		headers += "<tr role='row'>";
		headers +="<th>Edit</th>";
		headers +="<th>Key</th>";
		headers +="<th>Start Km</th>";
		headers +="<th>End Km</th>";
		headers +="<th>Percentage Increase</th>";

		for (var i = 0; i <rateSlab.length; i++) {
			var reqObj = rateSlab[i];
			body += "<tr role='row'>"; 
			body += "<td><input class='edittblinput' type='checkbox'  value=''></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.key+"' disabled='disabled'></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.startKm+"'  disabled='disabled'></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.endKm+"'  disabled='disabled'></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.percentageIncrease+"'  disabled='disabled'></td>";
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
			"searchable" : false,

				"oPaginate" : {
					"sFirst" : "First",
					"sLast" : "Last",
					"sNext" : "Next",
					"sPrevious" : "Previous"
				
			},
			"bPaginate": false,
		    "bLengthChange": false,
		    "bFilter": false,
		    "bInfo": false,
		    "bAutoWidth": true
		});
		
	} else {
		alert('Please fill atleast one row');
	}
	objArr=rateSlab;
	//alert(JSON.stringify(objArr));
	$(".edittblinput").click(function(){	
		if($(this).is(':checked')){
			$(this).closest('tr').find('.tblinput').each(function(i){
				if(i>0 || (i==0 && $(this).val()=="" ))
				$(this).removeAttr("disabled");
			})
		}
		else{
			$(this).closest('tr').find('.tblinput').each(function(){
				$(this).attr("disabled","disabled");
			})

		}
			
			 
	});
}

function buildDataTable1(rateSlab) {
	
	if(rateSlab.length>0) {
		var headers = "";
		var body = "";
		
		headers += "<tr role='row'>";
		headers +="<th>Key</th>";
		headers +="<th>Start Km</th>";
		headers +="<th>End Km</th>";
		headers +="<th>Percentage Increase</th>";

		for (var i = 0; i <rateSlab.length; i++) {
			var reqObj = rateSlab[i];
			body += "<tr role='row'>"; 
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.key+"'></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.startKm+"'></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.endKm+"'></td>";
			body += "<td><input class='tblinput' type='text'  value='"+reqObj.percentageIncrease+"'></td>";
 			body += "</tr>";
		}

		$("#tableDivs").empty();
		$("#tableDivs")
				.append(
						"<table width='100%' class='table table-striped table-bordered dataTable no-footer' id='tableId1'><thead>"
								+ headers
								+ "</thead><tbody>"
								+ body
								+ "</tbody></table>");

		dataTable1 = $('#tableId1').DataTable({
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
			"searchable" : false,

				"oPaginate" : {
					"sFirst" : "First",
					"sLast" : "Last",
					"sNext" : "Next",
					"sPrevious" : "Previous"
				
			},
			"bPaginate": false,
		    "bLengthChange": false,
		    "bFilter": false,
		    "bInfo": false,
		    "bAutoWidth": true
		});
		
	} else {
		alert('Please fill atleast one row');
	}
	objArr=rateSlab;
	//alert(JSON.stringify(objArr));
}
$('#newSlabBtn').click(function(e) {
	//alert(JSON.stringify(objArr));
	insertNewrow();
	e.preventDefault();
});
function insertNewrow()
{	
	var newRow=new Object();
	newRow.key = "";
	newRow.startKm = "";
	newRow.endKm = "";
	newRow.percentageIncrease = "";
	objArr1.unshift(newRow);
	buildDataTable1(objArr1);
}
$('#newSlabBtn1').click(function(e) {
	//alert(JSON.stringify(objArr));
	insertNewrow1();
	e.preventDefault();
});
function insertNewrow1()
{	
	var newRow=new Object();
	newRow.key = "";
	newRow.startKm = "";
	newRow.endKm = "";
	newRow.percentageIncrease = "";
	objArr.push(newRow);
	buildDataTable(objArr);
}
// function deleteRow(row){
// 	$('.statusCls').removeClass('errCls');
// 	$('.statusCls').html('');
// 	objArr.splice(row,1);
// 	buildDataTable(objArr);
// }

$(document.body).on('keyup', '.tblinput', function() {
	var info = dataTable1.page.info();
	var currrow = (info.page * info.length) + $(this).closest('tr').index();
	var j = $(this).closest('td').index()-1;
	var inputVal = $(this).val();
	
	  if(j == 0) {
		objArr[currrow].key = inputVal;
	} else if(j == 1) {
		objArr[currrow].startKm = inputVal;
	} else if(j == 2) {
		objArr[currrow].endKm = inputVal;
	} else if(j == 3) {
		objArr[currrow].percentageIncrease = inputVal;
	} 
	dataTable1.cell($(this).closest('td')).invalidate();
});

$('#editratecard').click(function() {
	if($('#editratecard').is(':checked')){
	$("#brate").removeAttr("disabled");
	$("#bratekl").removeAttr("disabled");
	$("#bratewt").removeAttr("disabled");
	$("#klbr").removeAttr("disabled");
	$("#maxkl").removeAttr("disabled");
	$("#maxwt").removeAttr("disabled");
	$("#rklbr").removeAttr("disabled");
	$("#rwtbr").removeAttr("disabled");
	$("#wtbr").removeAttr("disabled");
	}
	else{
	$("#brate").attr("disabled","disabled");
	$("#bratekl").attr("disabled","disabled");
	$("#bratewt").attr("disabled","disabled");
	$("#klbr").attr("disabled","disabled");
	$("#maxkl").attr("disabled","disabled");
	$("#maxwt").attr("disabled","disabled");
	$("#rklbr").attr("disabled","disabled");
	$("#rwtbr").attr("disabled","disabled");
	$("#wtbr").attr("disabled","disabled");
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

#loc1_chosen
{
width:200px!important;
}

</style>

</head>
<body >
<div class="wrapper" style="min-height:500px;">
		<div class="top-strip">
			<!-- contact section -->
			<div class="container">
				<div class="srchMainCls">
				<div class="row formcls srchCls" style="margin-top: 0px;">
				<div class="col-md-12 mr-auto">
							<h5 class="font-weight-bold">
								<span>Rate Card</span>
							</h5>
						</div>
						<br><br><br><br>
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="row">

								<div class="col-md-12 form-group">
								<div class="row">
								<div class="col-md-1 form-group">
									<input type="radio" id="update" name="action" value="update">
									</div>
								<div class="col-md-3 form-group">
									<label for="update" class="font-weight-bold">View/Update existing Rate card</label></div>
								<div class="col-md-1 form-group">
									<input type="radio" id="insert" name="action" value="insert">
									</div>
									<div class="col-md-3 form-group">
									<label for="insert" class="font-weight-bold">Insert new Rate card</label>
									</div>
								</div>
								
								</div>
								
							</div>

				</div>
			</div>	
					<div class="row formcls srchCls" style="margin-top: 0px;">
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="row">

								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Location</label><br> 
									<select id="loc1">
										<option value="Äll Location">Select One</option>
									</select>
								</div>
								
								
								
							</div>

				</div>
			</div>
		</div>

	</div>


<div class="row" style="margin-bottom:10px;margin-top:10px;display:none;">
<div class="col-md-1"></div>
<div class="col-md-10" id="ratecard" style="margin-bottom: 50px;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center;">Rate Card for <span id="cityname"></span></h5>
	
				<form>
					<div class="contentform row formcls">
						<div class="col-md-1"></div>
						<input class="styled-checkbox" id="editratecard" type="checkbox" value="1">
    										<label for="editratecard"><b>Edit Rate Card</b></label>
						<div class="col-md-10">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<p>Base Rate</p>
										<input type="text" name="brate" id="brate" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6"></div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Base Rate Kilometer</p>
										<input type="text" name="bratekl" id="bratekl" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Base Rate Weight</p>
										<input type="text" name="bratewt" id="bratewt" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Kilometer Breaker</p>
										<input type="text" name="klbr" id="klbr" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Weight Breaker</p>
										<input type="text" name="wtbr" id="wtbr" disabled="disabled"/>
										<br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Maximum Kilometer</p>
										<input type="text"id="maxkl" name="maxkl" disabled="disabled"/>
    									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Maximum Weight</p>
										<input type="text" name="maxwt" id="maxwt" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Rate for Kilometer Breaker</p>
										<input type="text" name="rklbr" id="rklbr" disabled="disabled"/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Rate for Weight Breaker</p>
										<input type="text" name="rwtbr" id="rwtbr" disabled="disabled"/>
										<br>
									</div>
								</div>
								<div class="col-md-6">
									</div>
									<div class="col-md-4">
									</div>
									<div class="col-md-1">
									</div>
									
								
								</div>
								</div>
					
						<div class="col-md-1"></div>
						</div>
						<div class="row">
						
						<div class="col-md-12">	
						<div class="row">
						<div class="col-md-4">
									</div>
									<div class="col-md-1">
									</div>
						<div class="col-md-3">
									<div class="form-group">
										<p><h5 class="font-weight-bold">Rate Slab</h5></p>
										<br>
									</div>
								</div></div>
								<div class=row>
						<button class="btn btn-primary" id="newSlabBtn1" style="float: left;">
								<span class="fa fa-plus btn-icon"></span>Add New Rate Slab</button>
								<br>
								
						<div id="tableDiv" class="col-md-12 mr-auto"></div>
						
							<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="rateupdatebtn">Update</button>
				            </div>
				            </div>
						</div>
						
						
					</div>
					
				</form>
			</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>
<div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="ratecard1" style="margin-bottom: 50px;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center;"> Configure New Rate Card</h5>

				<form>
					<div class="contentform row formcls">
						<div class="col-md-1"></div>
						<div class="col-md-10">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<p>City<span>*</span></p>
										<input type="text" name="brate" id="city1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Base Rate<span>*</span></p>
										<input type="text" name="brate" id="brate1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Base Rate Kilometer<span>*</span></p>
										<input type="text" name="bratekl" id="bratekl1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Base Rate Weight<span>*</span></p>
										<input type="text" name="bratewt" id="bratewt1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Kilometer Breaker<span>*</span></p>
										<input type="text" name="klbr" id="klbr1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
									<div class="col-md-6">
									<div class="form-group">
										<p>Weight Breaker<span>*</span></p>
										<input type="text" name="wtbr" id="wtbr1" class="required"/>
										<div class="validation"></div>
										<br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Maximum Kilometer<span>*</span></p>
										<input type="text"id="maxkl1" name="maxkl1" class="required"/>
										<div class="validation"></div>
    									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Maximum Weight<span>*</span></p>
										<input type="text" name="maxwt" id="maxwt1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Rate for Kilometer Breaker<span>*</span></p>
										<input type="text" name="rklbr" id="rklbr1" class="required"/> <br>
										<div class="validation"></div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Rate for Weight Breaker<span>*</span></p>
										<input type="text" name="rwtbr" id="rwtbr1" class="required"/>
										<div class="validation"></div>
										<br>
									</div>
								</div>
								
								
<!-- 						<div class="col-md-6"> -->
<!-- 									</div> -->
									<div class="col-md-4">
									</div>
									<div class="col-md-1">
									</div>
									<div class="col-md-3">
									<div class="form-group">
										<p><h5 class="font-weight-bold">Rate Slab</h5></p>
										<br>
									</div>
								</div>
								
								</div>
							</div>
						<div class="col-md-1"></div>

						
						<div class="col-md-5">
						<button class="btn btn-primary" id="newSlabBtn" style="float: left;">
								<span class="fa fa-plus btn-icon"></span>Add New Rate Slab</button>
								</div>
						<div id="tableDivs" class="col-md-12 mr-auto" style="margin-top: 20px;"></div>
						<br><br>
							<div class="quote_btn-container col-md-12 " style="text-align:center;margin-top: 20px;">
				              <button type="button" class="btn btn-primary" id="rateinsertbtn">Save</button>
				            </div>
						</div>
						<div class="col-md-1"></div>
						
					</div>
					
				</form>
			</div>
		</section>
	</div>
</div>
</div>
<div class="col-md-1"></div>
</div>

</body>
</html>