<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>

<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script>
$(document).ready(function() {	
	$("#track").click(function(){
		var awbno=$("#awb").val();
					$.ajax({
				url :'a/t',
				contentType : 'application/json',
				method : 'POST',
				data : awbno,
				success : function(data) {
					var awbModels=data[0];
					$("#awbnumber").val(awbModels.awbNumber);
					$("#rname").val(awbModels.recieverName);
					$("#partype").val(awbModels.parcelType);
					$("#wt").val(awbModels.weight);
					$("#createdat").val((awbModels.createdAt).split(".")[0].replace("T",","));
					
					if(awbModels.pickedUpDate==null ||awbModels.pickedUpDate==""){
				
					$("#pckeddt").parent().attr("style","background-color:grey");
					$("#delvdt").parent().attr("style","background-color:grey");
					}
					else{
						$("#pckeddt").val((awbModels.pickedUpDate).split(".")[0].replace("T",","));
					}
					if(awbModels.deliveredDate==null || awbModels.deliveredDate=="")
						{
						$("#delvdt").parent().attr("style","background-color:grey");
						}
					else{
						$("#delvdt").val((awbModels.deliveredDate).split(".")[0].replace("T",","));
						
					}
					if(awbModels.packageStatus=="CANCEL")
						{
						$("#delvdiv").hide();
						$("#pickdiv").hide();
						$("#canceldiv").show();
						$("#arw2").hide();
						}
					$("#awbdetails").show();
					$("#pckttrck").slideUp();

		},
			error : function(data) {
				alert("Error!!");	
		}
			});
					
					
		});

	});
</script>
<style>
#vdet1{
padding:10px;
}
#vdet1 input{
border:none!important;
background-color:transparent;
}
#vdet1 .form-group p{
font-weight:bold!important;
}
#vdet1 .col-md-6{
    padding: 20px;
    padding-left: 50px;
    border-bottom:2px solid #f1f1f1;

}
#vdet1 .col-md-6 p {
color:#007bff;
font-weight:bold!important;
}
#pckst1,#pckst2{
color:#007bff;
font-weight:bold!important;
}
#delvdt,#pckeddt,#createdat{
font-weight:bold!important;
}
#delvdt{
color:green;
}
#pckeddt
{
color:#464e97;
}
/* #pckst,#pckst1,#pckst2{ */
/* border-right:1px green dotted; */
/* } */
.triangle{
width:0;
height:0px;
border-top:10px solid transparent;
border-left:20px solid #6610f2;
border-bottom:10px solid transparent;
}
</style>


</head>

   <body>
   <div class="row" style="margin-bottom:10px;margin-top:10px;">
<div class="col-md-1"></div>
<div class="col-md-10" id="awbtrack" style="margin-bottom: 50px; display:block;" >
<div class="wrapper">
	<div class="top-strip " id="pckttrck">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
<!-- 				<h5 class="font-weight-bold" style="text-align: center; display:block;">AWB Tracking</h5> -->
				<form id="delallo">
				
				
							<div class="row">
							<div class="col-md-5"></div>
							<div class="col-md-3">
									<div class="form-group">
										<p><b>Provide AWB Number</b></p>
										<input type="text" class="nonedit" name="awb" id="awb"/> <br>
									</div>
								</div>
								<div class="col-md-2">
								
								</div>
								<div class="col-md-2"></div>
								</div></form>
				<br>
						<div class="col-md-12 quote_btn-container" style="text-align:center;">
				              <button type="button" class="btn btn-primary" id="track">Track</button>
				               
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
<div class="col-md-10" id="awbdetails" style="margin-bottom: 50px; display:none;">
<div class="wrapper">
	<div class="top-strip ">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold" style="text-align: center; display:block;">Package Tracking Details</span></h5>
				<form id="vdet1">
				
				
							<div class="row">
							<div class="col-md-6">
									<div class="form-group">
										<p>AWB Number</p>
										<input type="text" class="nonedit" name="awbnumber" id="awbnumber" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Receiver Name</p>
										<input type="text" class="nonedit" name="rname" id="rname" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Parcel Type</p>
										<input type="text" class="nonedit" name="partype" id="partype" disabled=true/> <br>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<p>Package Weight</p>
										<input type="text" class="nonedit" name="wt" id="wt" disabled=true /> <br>
									</div>
								</div>
								<div class="col-md-3" id="reqdiv" style="padding:10px;">
								<div class="form-group" style="background-color:green;text-align:center;">
									<p style="color:white;text-align:center;">Requested Date</p> 
								<input type="text" class="nonedit" name="createdat" id="createdat" disabled=true style="color:white;text-align:center;" /> <br>
								
								</div>
										</div>
										<div class="col-md-1" style="padding-top:25px;padding-left:25px;">
										<div class="triangle" id="arw1"></div></div>
								
								<div class="col-md-3" id="pickdiv" style="padding-top:10px;">
										<div class="form-group" style="background-color:green;text-align:center;">
										<p style="color:white;text-align:center;">PICKEDUP</p> 
										<input type="text" class="nonedit" name="pckeddt" id="pckeddt" disabled=true style="color:white;text-align:center;" /> <br>
										
								</div>
								</div>
									<div class="col-md-1"style="padding-top:25px;padding-left:25px;">
								<div class="triangle" id="arw2"></div></div>
									<div class="col-md-4" id="delvdiv" style="display:block;padding:10px;">
										<div class="form-group" style="background-color:green;text-align:center;">
										<p style="color:white;text-align:center;text-align:center;">DELIVERED</p> 
										<input type="text" class="nonedit" name="delvdt" id="delvdt" disabled=true style="color:white;text-align:center;" /> <br>
								</div>
								</div>
								<br>
								<div class="col-md-3" id="canceldiv" style="display:none;background-color:red;padding:10px">
										<div class="form-group" style="background-color:red;text-align:center;">
										<p style="color:black;text-align:center;">CANCEL</p>
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
   </body>
</html>