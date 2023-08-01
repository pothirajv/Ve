<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%-- <script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script> --%>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<style>

 .vdeliveryStatusCls{
    background: linear-gradient(to right, rgba(6, 185, 157, 1), rgba(132, 217, 210, 1));
 text-align :center;
 color:white;
 }
 
 .info-box {
    display: block;
    min-height: 70px;
    background: #fff;
    width: 100%;
    box-shadow: 0 1px 5px rgba(0.5,0.5,0.5,0.5);
    border-radius: 2px;
    margin-bottom: 15px;
}

.whlbl {
	color: #fff;
}

.bg-aqua{
/*     background-color: #2982cc; */
    background-color: #00c0ef !important;
}

.info-box-content {
    padding: 5px 10px;
    margin-left: 90px;
}

.info-box-text {
    display: block;
    font-size: 14px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.info-box-icon {
    border-top-left-radius: 2px;
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 2px;
    display: block;
    float: left;
    height: 70px;
    width: 90px;
    text-align: center;
    font-size: 45px;
    line-height: 90px;
    background: rgba(0,0,0,0.2);
}

.progress-group .progress-text {
    font-weight: 600;
}

.progress-group .progress-number {
    float: right;
}

.progress.sm,.progress-bar, .progress-sm .progress-bar {
    border-radius: 1px;
    height: 10px;
}

.progress {
    height: 20px;
    margin-bottom: 20px;
    overflow: hidden;
    background-color: #f5f5f5;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
    box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
}


.progress-description{
    display: block;
    font-size: 11px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.bg-green{
    background-color: #51cda0 !important
}

.bg-purple{
    background-color: #6d78ad !important
}

.bg-red{
    background-color: #df7970 !important
}

.bg-darkblue{
    background-color: #4c9ca0 !important
}

.bg-violet{
    background-color: #ae7d99 !important
}

.progress-bar-aqua, .progress-bar-info {
    background-color: #00c0ef;
}

.progress-bar-red, .progress-bar-danger {
    background-color: #dd4b39;
}

.progress-bar-green, .progress-bar-success {
    background-color: #00a65a;
}

.progress-bar-yellow, .progress-bar-warning {
    background-color: #f39c12;
}

h1 {
    text-align: center;
    margin: 10px 0px 0px 0px;
}
.uniqcus{
font-size:100px!important;
}
.canvasjs-chart-credit{
display:none;}
</style>

<script>

var topDelivery3;

$(document).ready(function(){

	//$("#todayDeliveryViews").hide();
	
	
	$.ajax({
		type:'POST',
		url:$("#contextPath").val()+'/api/v1/vdeliverydashboard',
		success:function(data){
			console.log(data);
			//deliveryStatus1(data);
			$("#vname").html(data.vName);
//PackageStatusCount
			packageStatusCount(data);
	//transactionCount		
			transactionCount(data);
//TopDeliveryDetails
 			topDeliveryDetails(data);
//deliveredKg
			deliveredKg(data);
//Lastest Delivery
// 			lastestDelivery(data);
			pendingDelivery(data);
		
			showMonthData(JSON.stringify(data.monthData));
	
		}
	});
	
    
//     $(".dViewsBtnCls").click(function(){
    	
//     	if($(this).val() == "today"){
//     		$("#dTodayViews").show();
//     		$("#dFullViews").hide();
//     	}else{
//     		$("#dFullViews").show();
//     		$("#dTodayViews").hide();
//     	}
    	
//     });

});
	
// function viewsChange(ths){
// 	if($(ths).val() == "today"){
// 		$(".dTodayViews").show();
// 		//$("#todayDeliveryViews").show();
// 		$(".dFullViews").hide();
// 		//$("#deliveryStatus").hide();
// 		$(".deliveryStatusDivCls").text("Today Delivery Status");
// 	}else{
// 		$(".dFullViews").show();
// 		//$("#deliveryStatus").show();
// 		$(".dTodayViews").hide();
// 		//$("#todayDeliveryViews").hide();
// 		$(".deliveryStatusDivCls").text("Full Delivery Status")
// 	}
// }

//transactionCount
function transactionCount(data){
// 	$("#cllw").html('<h1>'+data.collectedLastLastWeek+'</h1>');
// 	$("#clw").html('<h1>'+data.collectedLastWeek+'</h1>');

// 	$("#pllw").html('<h1>'+data.paidLastLastWeek+'</h1>');
// 	$("#plw").html('<h1>'+data.paidLastWeek+'</h1>');

	$("#uniqcus").html('<h1 class="uniqcus">'+data.uniqCus+'</h1>');
	var paymentTr = "";
	if( data.collectedLastWeek>=0)
		{
	    paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.collectedLastWeekPendingDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Collected from Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.collectedLastWeek+'</span></td></td>'
	                   +'<td><span class="twoline-ellipsis">'+data.collectedLastWeekPendingDueDate+'</span></td><td> <span class="label label-danger">Pending</span> </td> </tr>';
	   if(data.collectedLastWeekCompletedDate!=="" && data.collectedLastLastWeek>=0)
	paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.collectedLastWeekCompletedDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Collected from Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.collectedLastLastWeek+'</span></td></td>'
                   +'<td><span class="twoline-ellipsis">'+data.collectedLastWeekCompletedDueDate+'</span></td><td> <span class="label label-success" style="background-color:green;">Completed</span> </td> </tr>';

		}
	else
		{
		 if(data.collectedLastWeekCompletedDate!=="" && data.collectedLastLastWeek>=0)
		paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.collectedLastWeekCompletedDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Collected from Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.collectedLastLastWeek+'</span></td></td>'
	                   +'<td><span class="twoline-ellipsis">'+data.collectedLastWeekCompletedDueDate+'</span></td><td> <span class="label label-success" style="background-color:green;">Completed</span> </td> </tr>';
		if(data.collectedTwoWeeksCompletedDate!=="" && (data.collectedLastWeekCompletedDueDate!== data.collectedTwoWeeksDueDate) && (data.collectedLastLastWeek!== data.collectedTwoWeeks))
			paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.collectedTwoWeeksCompletedDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Collected from Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.collectedTwoWeeks+'</span></td></td>'
		                   +'<td><span class="twoline-ellipsis">'+data.collectedTwoWeeksDueDate+'</span></td><td> <span class="label label-success" style="background-color:green;">Completed</span> </td> </tr>';
		}
                   
                   
   if( data.paidLastWeek>0) 
	   {
   paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.paidLastWeekPendingDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Paid to Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.paidLastWeek+'</span></td></td>'
                   +'<td><span class="twoline-ellipsis">'+data.paidLastWeekPendingDueDate+'</span></td><td> <span class="label label-danger">Pending</span> </td> </tr>';
                   if(data.paidLastWeekCompletedDate!=="")
                   paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.paidLastWeekCompletedDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Paid to Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.paidLastLastWeek+'</span></td></td>'
                   +'<td><span class="twoline-ellipsis">'+data.paidLastWeekCompletedDueDate+'</span></td><td> <span class="label label-sucess" style="background-color:green;">Completed</span> </td> </tr>';
	   }
   else
	   {
	   if(data.paidLastWeekCompletedDate!=="")
           paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.paidLastWeekCompletedDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Paid to Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.paidLastLastWeek+'</span></td></td>'
           +'<td><span class="twoline-ellipsis">'+data.paidLastWeekCompletedDueDate+'</span></td><td> <span class="label label-sucess" style="background-color:green;">Completed</span> </td> </tr>';
           if(data.paidLastWeekCompletedDate!=="" && (data.paidLastWeekCompletedDueDate!== data.paidLastWeekCompletedDate) && (data.paidLastLastWeek!== data.paidTwoWeeks) &&data.paidTwoWeeksDueDate!=="")
   			paymentTr +='<tr><td><span class="twoline-ellipsis">'+data.paidTwoWeeksCompletedDate+'</span></td><td><span class="twoline-ellipsis">Amount to be Paid to Vedagram</span></td><td><span class="twoline-ellipsis"><i class="fa fa-inr rupeeCls"></i>'+data.paidTwoWeeks+'</span></td></td>'
           +'<td><span class="twoline-ellipsis">'+data.paidTwoWeeksDueDate+'</span></td><td> <span class="label label-sucess" style="background-color:green;">Completed</span> </td> </tr>';
	   }
                   $(".paymentTbody").append(paymentTr);
	
	}
//packageStatusCount
function packageStatusCount(data){
	
	$("#vTotalId").html('<h1>'+data.totalCount+'</h1>');
	$("#vAssignId").html('<h1>'+data.assignedCount+'</h1>');
	
// 	$("#vAckId").html('<h1>'+data.acknowledged+'</h1>');
	$("#vPickUpId").html('<h1>'+data.pickedUpCount+'</h1>');
	$("#vDeliveredId").html('<h1>'+data.deliveryCount+'</h1>');
	$("#vCancellId").html('<h1>'+data.cancelledCount+'</h1>');
		var deliveryCountTr = "";
		deliveryCountTr +='<tr><td><span class="twoline-ellipsis">'+data.totalCount+'</span></td><td><span class="twoline-ellipsis">'+data.assignedCount+'</span></td><td><span class="twoline-ellipsis">'+data.pickedUpCount+'</span></td></td>'
                       +'<td><span class="twoline-ellipsis">'+data.deliveryCount+'</span></td><td> <span class="twoline-ellipsis">'+data.cancelledCount+'</span> </td> </tr>'
			$(".deliveryOrderTbody").append(deliveryCountTr);
	
	
// 	var deliveryStatus = new CanvasJS.Chart("deliveryStatus", {
// 		exportEnabled: true,
// 		animationEnabled: true,
// 		title:{
// 			//text: "Delivery Status 2"
// 		},
// 		legend:{
// 			cursor: "pointer",
// 			itemclick: explodePie
// 		},
// 		data: [{
// 			type: "pie",
// 			showInLegend: true,
// // 			toolTipContent: "{name}: <strong>{y}%</strong>",
// // 			indexLabel: "{name} - {y}%",
// 			indexLabel: "{name} - {y}",
// 			toolTipContent: "<b>{name}:</b> {y}",
// 			dataPoints: [
// 				{ y: data.assignedCount, name: "Assigned" },
// 				{ y: data.acknowledged, name: "Acknowledged" },
// 				{ y: data.pickedUpCount, name: "Picked" },
// 				{ y: data.deliveryCount, name: "Delivered"},
// 				{ y: data.cancelledCount, name: "Cancelled"},
// 				{ y: data.totalCount, name: "Total"}
// 			]
// 		}]
// 	});
// 	//alert(JSON.stringify(dataPoints));
// 	deliveryStatus.render();
	
	
	
	
}
//Chari: Added for Monthwise data
function showMonthData(data)
{
	var dataPoints=[];
	data=JSON.parse(data);
	for (var key in data) {
		if (data.hasOwnProperty(key)) {
			var months=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"];
		  dataPoints.push({label: months[key], y: parseInt(data[key])});
		  
		}
		}
	var chart = new CanvasJS.Chart("monthData", {

		title: {
			text: "Monthly Deliveries"
		},
		axisY:{
			includeZero: true
		},
		data: [{
			type: "column", //change type to bar, line, area, pie, etc
			//indexLabel: "{y}", //Shows y value on all Data Points
			dataPoints: dataPoints,
		}]
	});
	
	
	
	chart.render();
	}




function explodePie (e) {
	if(typeof (e.dataSeries.dataPoints[e.dataPointIndex].exploded) === "undefined" || !e.dataSeries.dataPoints[e.dataPointIndex].exploded) {
		e.dataSeries.dataPoints[e.dataPointIndex].exploded = true;
	} else {
		e.dataSeries.dataPoints[e.dataPointIndex].exploded = false;
	}
	e.topDelivery1.render();

}


	//TopDeliveryDetails
	function topDeliveryDetails(data){
		
		var percentage=0;
		var topCount=1;
		$.map(data.vTopDeliveryMap,function(value,key,index){
			console.log(key+" - "+value);
			
			
		var bg_color="";
		if(topCount == 1){
			bg_color="bg-purple";
		}else if(topCount == 2){
			bg_color="bg-green";
		}else if(topCount == 3){
			bg_color="bg-red";
		}else if(topCount == 4){
			bg_color="bg-darkblue";
		}else if(topCount == 5){
			bg_color="bg-violet";
		}
		
		if(value > 0 && data.totalDeliveryCount > 0){
			percentage =((parseInt(value) / parseInt(data.totalDeliveryCount)) *100).toFixed(2);
		}else{
			percentage = 0;
		}
		var topDelivery="";
		topDelivery +='<div class="info-box '+bg_color+'"><span class="info-box-icon"><small>'+topCount+'</small></span>'
			        +'<div class="info-box-content"><span class="info-box-text">'+key+'</span><span class="info-box-number">'+value+'</span>'
			        +'<div class="progress" style="height: 2px; margin-bottom: 0px;"><div class="progress-bar" style="width: '+percentage+'%"></div></div>'
			        +'<span class="progress-description">'+percentage+'% delivered</span></div></div>'
			        
			$(".topDeliveryContentDivCls").append(topDelivery);       
			        
			        topCount++;
		});
	}
	
	//deliveredKg
	function deliveredKg(data){
		
		var percentage=0;
		$.map(data.vDeliveredKgMap,function(value,key){
			
			if(value > 0 && data.vTotalDeliveredKg > 0){
				percentage =((parseFloat(value) / parseFloat(data.vTotalDeliveredKg)) *100).toFixed(2);
			}else{
				percentage = 0;
			}
		console.log("percentage - "+percentage)
		var deliveredKg="";
		deliveredKg +='<div class="progress-group"><span class="progress-text">'+key+'</span><span class="progress-number"><b>'+value+'</span>'
			        +'<div class="progress sm"><div class="progress-bar progress-bar-aqua" style="width: '+percentage+'%"></div></div></div>'
		
		$(".deliveredKgContenetCls").append(deliveredKg);
		});
		
		$('.totalDeliveredKg').text(data.vTotalDeliveredKg+" Kg");
	}
	
	//Lastest Delivery
// 	function lastestDelivery(data){
//         $.each(data.senderRequestModelList,function(i,ele){
// 			var latestOrderTr = "";
// 			latestOrderTr +='<tr><td><span class="twoline-ellipsis">'+ele.packagePickupAddress+'</span></td><td>'+ele.recieverName+'</td><td><span class="twoline-ellipsis">'+ele.recieverName+','+ele.recieverAddress+'</span></td>'
//                            +'<td><i class="fa fa-inr rupeeCls"></i>'+ele.amount+'</td><td> <span class="label label-danger">'+ele.packageStatus+'</span> </td> </tr>'
//   			$(".latestOrderTbody").append(latestOrderTr);
//         });
// 	}
	//Pending Delivery
	function pendingDelivery(data){
// 		var maxcount=0;
        $.each(data.senderRequestModelPendingLst,function(i,ele){
			var pendingOrderTr = "";
			pendingOrderTr +='<tr><td><span class="twoline-ellipsis">'+ele.packagePickupAddress+'</span></td><td>'+ele.recieverName+'</td><td><span class="twoline-ellipsis">'+ele.recieverName+','+ele.recieverAddress+'</span></td>'
                           +'<td><i class="fa fa-inr rupeeCls"></i>'+ele.amount+'</td><td> <span>'+ele.createdAt.split('T')[0]+'</span> </td><td> <span class="label label-danger">'+ele.packageStatus+'</span> </td> </tr>'
  			$(".pendingOrderTbody").append(pendingOrderTr);
                          
                     //      maxcount++;
                       //    if(maxcount>=5)
                        //	   return false;
        });
        $('.pendingOrderTbody').parent().DataTable().destroy();
        $('.pendingOrderTbody').parent().DataTable({"bFilter":false, "pageLength" : 5,
    		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]});
	}
	function allPendingDelivery(data){
        $.each(data.senderRequestModelPendingLst,function(i,ele){
			var pendingOrderTr = "";
			pendingOrderTr +='<tr><td><span class="twoline-ellipsis">'+ele.packagePickupAddress+'</span></td><td>'+ele.recieverName+'</td><td><span class="twoline-ellipsis">'+ele.recieverName+','+ele.recieverAddress+'</span></td>'
                           +'<td><i class="fa fa-inr rupeeCls"></i>'+ele.amount+'</td><td> <span>'+ele.createdAt+'</span> </td><td> <span class="label label-danger">'+ele.packageStatus+'</span> </td> </tr>'
  			$(".pendingOrderTbody").append(pendingOrderTr);
                          });
	}
</script>

<style>

.panel {
    -webkit-border-radius: 4px;
    border-radius: 4px;
}
.panel {
    position: relative;
}
.panel {
    -webkit-border-radius: 0;
    border-radius: 0;
}
.panel {
    margin-bottom: 20px;
    background-color: #fff;
    border: 1px solid transparent;
    border-radius: 4px;
    -webkit-box-shadow: 1px 5px 10px rgb(202, 202, 202);
    box-shadow: 1px 5px 10px rgb(202, 202, 202);
}

.panel .panel-border {
    border-bottom: 1px solid rgba(0, 0, 0, 0.07);
}
.panel .panel-heading {
    -webkit-border-top-left-radius: 0;
    border-top-left-radius: 0;
    -webkit-border-top-right-radius: 0;
    border-top-right-radius: 0;
    font-weight: bold;
    text-transform: uppercase;
}
.panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}

.btn-group-vertical>.btn-group:after, .btn-group-vertical>.btn-group:before, .btn-toolbar:after, .btn-toolbar:before, .clearfix:after, .clearfix:before, .container-fluid:after, .container-fluid:before, .container:after, .container:before, .dl-horizontal dd:after, .dl-horizontal dd:before, .form-horizontal .form-group:after, .form-horizontal .form-group:before, .modal-footer:after, .modal-footer:before, .modal-header:after, .modal-header:before, .nav:after, .nav:before, .navbar-collapse:after, .navbar-collapse:before, .navbar-header:after, .navbar-header:before, .navbar:after, .navbar:before, .pager:after, .pager:before, .panel-body:after, .panel-body:before, .row:after, .row:before {
/*     display: table; */
/*     content: " "; */
}

.mtop-10 {
	margin-top: 10px;
    display: inline-block;
}

.btn-primary1 {
    color: #ffffff;
    background-color: #62549a;
    border-color: #62549a;
    font-size: 11px;
    padding: 4px 8px;
    /* margin-top: 10px; */
    border-radius: 3px;
}

.panel-body {
    padding: 15px;
}
.order-short-info {
    display: inline-block;
    width: 100%;
}
.table thead th {
    border-bottom: none;
}
hr {
	border-top: 0px solid rgba(0, 0, 0, 0.1);
}
.panel-sec {
	float: left;
    width: 100%;
/*     padding: 10px 10px; */
    border-radius: 5px;
/*     font-size: 0.7rem; */
}

.first-info .label {
    -webkit-border-radius: 3px 0 0 3px !important;
    border-radius: 3px 0 0 3px !important;
    position: relative;
    right: -1px;
    padding: 6px 12px;
    font-size: 0.7rem;
}

.first-info {
	margin-bottom: 20px;
}

.label-danger {
    background-color: #ff6c60;
}
.pull-right {
    float: right;
}
.pull-right {
    float: right!important;
}
.label-danger {
    background-color: #d9534f;
}
.label {
    display: inline;
    padding: .2em .6em .3em;
    font-size: 75%;
    font-weight: 700;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: .25em;
}

.tools {
    margin-right: -10px;
    position: relative;
}
.tools a {
    color: #C5C5CA;
    float: left;
    padding: 5px 10px;
    text-decoration: none;
    font-size: 11px;
}
</style>

<div class="wrapper" style="/* background: #eaeef3; */">
	<div class="top-strip">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h4 class="font-weight-bold">Dashboard - <span id="vname"></span></h4>
				<div id="vname"></div>
				<div class="row">
					<div class="col-md-12 mr-auto" style="margin-top: 20px;">
						<div class="mainDashboardCls">
<!-- 							<div class="panel-sec"> -->
<!-- 								<div class="row"> -->
<!-- 								<div class="row col-md-6 col-sm-6"> -->
<!-- 								<center><h6>Amount to be Collected from Vedagram [Weekly]</h6></center> -->
<!-- 		                            <div class="col-md-6 col-sm-6"> -->
<!-- 		                             <div class="panel first-info short-states"> -->
<!-- 		                                    <div class="panel-title"> -->
<!-- 		                                        <h4> <span class="label label-danger pull-right" style="background-color: #d9534f;">Last to Last week</span></h4> -->
<!-- 		                                    </div> -->
<!-- 		                                    <div class="panel-body" id="cllw"> -->
<!-- 		                                        <h1 style="color: #cec7c7;">0</h1> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
<!-- 		                            <div class="col-md-6 col-sm-6"> -->
<!-- 		                                <div class="panel first-info short-states"> -->
<!-- 		                                    <div class="panel-title"> -->
<!-- 		                                        <h4> <span class="label label-info pull-right" style="background-color: #2196F3;">Last week</span></h4> -->
<!-- 		                                    </div> -->
<!-- 		                                    <div class="panel-body" id="clw"> -->
<!-- 		                                        <h1 style="color: #cec7c7;">0</h1> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
<!-- 		                            </div> -->
<!-- 		                            <div class="row col-md-6 col-sm-6"> -->
<!-- 								<center><h6>Amount to be Paid to Vedagram [Weekly]</h6></center> -->
<!-- 		                            <div class="col-md-6 col-sm-6"> -->
<!-- 		                                <div class="panel first-info short-states"> -->
<!-- 		                                    <div class="panel-title"> -->
<!-- 		                                        <h4> <span class="label label-warning pull-right" style="background-color: #00BCD4;">Last to Last week</span></h4> -->
<!-- 		                                    </div> -->
<!-- 		                                    <div class="panel-body" id="pllw"> -->
<!-- 		                                       <h1 style="color: #cec7c7;">0</h1> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
		                            
<!-- 		                            <div class="col-md-6 col-sm-6"> -->
<!-- 		                                <div class="panel first-info short-states"> -->
<!-- 		                                    <div class="panel-title"> -->
<!-- 		                                        <h4> <span class="label label-success pull-right" style="background-color: #48d8be;">Last week</span></h4> -->
<!-- 		                                    </div> -->
<!-- 		                                    <div class="panel-body" id="plw"> -->
<!-- 		                                        <h1 style="color: #cec7c7;">0</h1> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
<!-- 		                            </div> -->
<!-- 		                            </div> -->
<!-- 		                             </div> -->
		                             		                            <!--charts start-->
		                             		                            <div class="row">
		                            <div class="col-md-12 ">
		                                <div class="panel">
		                                    <header class="panel-heading panel-border">
		                                      Billing - settlement
		                                         </header>
		                                    <div class="panel-body">
		                                        <hr>
		                                        <div class="table-responsive">
		                                            <table class="table table-hover latest-order">
		                                                <thead>
		                                                <tr>
		                                                    <th>Billing Cycle</th>
		                                                    <th>Payment Description</th>
		                                                    <th>Amount</th>
		                                                    <th>Due Date</th>
		                                                    <th>Payment Status</th>
		                                                </tr>
		                                                </thead>
		                                                <tbody class="paymentTbody">
		
		                                                </tbody>
		                                            </table>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                            </div>
<!-- 		                            charts end -->
		                            	
		                                 
		                                </div>
		                            </div>
								</div>
								<div class="panel">
		                            	<header class="panel-heading panel-border">
		                                        Total No of Deliveries till Date
		                                      </header>
								<div class="row">
								
								<div class="col-md-4"></div>
							      <div class="col-md-4 col-sm-6">
		                                <div class="panel first-info short-states">
		                                    <div class="panel-title">
		                                        <h4> <span class="label label-danger pull-right" style="background-color: blue;width:100%;right:0px;">Total</span></h4>
		                                    </div>
		                                    <div class="panel-body" id="vTotalId">
		                                        <h1 style="color: #cec7c7;">0</h1>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-md-4"></div>
		                            </div>
		                            <div class="row">
		                            <div class="col-md-3 col-sm-6">
		                                <div class="panel first-info short-states">
		                                    <div class="panel-title">
		                                        <h4> <span class="label label-info pull-right" style="background-color: Grey;width:100%;right:0px;">Assigned</span></h4>
		                                    </div>
		                                    <div class="panel-body" id="vAssignId">
		                                        <h1 style="color: #cec7c7;">0</h1>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-md-3 col-sm-6">
		                                <div class="panel first-info short-states">
		                                    <div class="panel-title">
		                                        <h4> <span class="label label-info pull-right" style="background-color: orange;width:100%;right:0px;">PickedUp</span></h4>
		                                    </div>
		                                    <div class="panel-body" id="vPickUpId">
		                                        <h1 style="color: #cec7c7;">0</h1>
		                                    </div>
		                                </div>
		                            </div>
		                                <div class="col-md-3 col-sm-6">
		                                <div class="panel first-info short-states">
		                                    <div class="panel-title">
		                                        <h4> <span class="label label-warning pull-right" style="background-color: green;width:100%;right:0px;">Delivered</span></h4>
		                                    </div>
		                                    <div class="panel-body" id="vDeliveredId">
		                                       <h1 style="color: #cec7c7;">0</h1>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-md-3 col-sm-6">
		                                <div class="panel first-info short-states">
		                                    <div class="panel-title">
		                                        <h4> <span class="label label-warning pull-right" style="background-color: red;width:100%;right:0px;">Cancelled</span></h4>
		                                    </div>
		                                    <div class="panel-body" id="vCancellId"> 
		                                       <h1 style="color: #cec7c7;">0</h1>
		                                    </div>
		                                </div>
		                            </div>
		                            </div>
		                            </div>
								  <!--charts start-->
<!-- 		                            <div class="col-md-12 "> -->
<!-- 		                                <div class="panel"> -->
<!-- 		                                    <header class="panel-heading panel-border"> -->
<!-- 		                                        No. of Deliveries -->
<!-- 		                                       </header> -->
<!-- 		                                    <div class="panel-body"> -->
<!-- 		                                        <div class="order-short-info"> -->
<!-- 		                                           	 <span class="mtop-10"> COD: <strong>123 <i class="fa fa-level-up text-primary"></i></strong>,  Payment Gateway: <strong> 212 <i class="fa fa-level-down text-danger"></i></strong></span> -->
<%-- 		                                            <a href="<%=request.getContextPath()%>/v/requestReport" class="pull-right pull-left-xs btn1 btn-primary1 btn-sm1">View All</a> --%>
<!-- 		                                        </div> -->
<!-- 		                                        <hr> -->
<!-- 		                                        <div class="table-responsive"> -->
<!-- 		                                            <table class="table table-hover latest-order"> -->
<!-- 		                                                <thead> -->
<!-- 		                                                <tr> -->
<!-- 		                                                    <th>Total</th> -->
<!-- 		                                                    <th>Assigned</th> -->
<!-- 		                                                    <th>PickedUp</th> -->
<!-- 		                                                    <th>Delivered</th> -->
<!-- 		                                                    <th>Cancelled</th> -->
<!-- 		                                                </tr> -->
<!-- 		                                                </thead> -->
<!-- 		                                                <tbody class="deliveryOrderTbody"> -->
		
<!-- 		                                                </tbody> -->
<!-- 		                                            </table> -->
<!-- 		                                        </div> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
		                            <!--charts end-->
		                            <!--charts start-->
		                           
<!-- 		                            <div class="col-md-12 "> -->
		                                <div class="panel">
		                                    <header class="panel-heading panel-border">
		                                        Pending Deliveries
		                                      </header>
		                                    <div class="panel-body">
		                                        <div class="order-short-info">
<!-- 		                                           	 <span class="mtop-10"> COD: <strong>123 <i class="fa fa-level-up text-primary"></i></strong>,  Payment Gateway: <strong> 212 <i class="fa fa-level-down text-danger"></i></strong></span> -->
<!-- 		                                          <button class="pull-right pull-left-xs btn1 btn-primary1 btn-sm1" onclick="return allPendingDelivery(data);">View All</button> -->
		                                        </div>
		                                        <hr>
		                                        <div class="table-responsive">
		                                            <table class="table table-hover latest-order table-striped">
		                                                <thead>
		                                                <tr>
		                                                    <th>Pick From</th>
		                                                    <th>Customer Name</th>
		                                                    <th>Drop To</th>
		                                                    <th>Amount</th>
		                                                    <th>RequestDate</th>
		                                                    <th>Status</th>
		                                                </tr>
		                                                </thead>
		                                                <tbody class="pendingOrderTbody">
		
		                                                </tbody>
		                                            </table>
		                                        </div>
		                                    </div>
		                                </div>
<!-- 		                            </div> -->
<!-- 		                            charts end -->
<!-- 								<div class="row"> -->
								
<!-- 		                            charts start -->
<!-- 		                            <div class="col-md-12 "> -->
<!-- 		                                <div class="panel"> -->
<!-- 		                                    <header class="panel-heading panel-border"> -->
<!-- 		                                        Recent Deliveries -->
<!-- 		                                        <span class="tools pull-right"> -->
<!-- 		                                            <a class="refresh-box fa fa-repeat" href="javascript:;"></a> -->
<!-- 		                                            <a class="collapse-box fa fa-chevron-down" href="javascript:;"></a> -->
<!-- 		                                            <a class="close-box fa fa-times" href="javascript:;"></a> -->
<!-- 		                                        </span> -->
<!-- 		                                    </header> -->
<!-- 		                                    <div class="panel-body"> -->
<!-- 		                                        <div class="order-short-info"> -->
<!--	                                           	 <span class="mtop-10"> COD: <strong>123 <i class="fa fa-level-up text-primary"></i></strong>,  Payment Gateway: <strong> 212 <i class="fa fa-level-down text-danger"></i></strong></span>  -->
<%-- 		                                            <a href="<%=request.getContextPath()%>/v/requestReport" class="pull-right pull-left-xs btn1 btn-primary1 btn-sm1">View All</a> --%>
<!-- 		                                        </div> -->
<!-- 		                                        <hr> -->
<!-- 		                                        <div class="table-responsive"> -->
<!-- 		                                            <table class="table table-hover latest-order"> -->
<!-- 		                                                <thead> -->
<!-- 		                                                <tr> -->
<!-- 		                                                    <th>Pick From</th> -->
<!-- 		                                                    <th>Customer Name</th> -->
<!-- 		                                                    <th>Drop To</th> -->
<!-- 		                                                    <th>Amount</th> -->
<!-- 		                                                    <th>Status</th> -->
<!-- 		                                                </tr> -->
<!-- 		                                                </thead> -->
<!-- 		                                                <tbody class="latestOrderTbody"> -->
		
<!-- 		                                                </tbody> -->
<!-- 		                                            </table> -->
<!-- 		                                        </div> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
<!-- 		                            </div> -->
		                            
<!-- 		                            charts end -->
 									<div class="panel">
 									<header class="panel-heading">Customer Statistics</header>
									<div class="row">
		                            <div class="col-md-7">
<!-- 		                                <div class="panel"> -->
<!-- 		                                    <header class="panel-heading"> -->
<!-- 		                                        Polar Chart -->
<!-- 		                                        <span class="tools pull-right"> -->
<!-- 		                                            <a class="refresh-box fa fa-repeat" href="javascript:;"></a> -->
<!-- 		                                            <a class="collapse-box fa fa-chevron-down" href="javascript:;"></a> -->
<!-- 		                                            <a class="close-box fa fa-times" href="javascript:;"></a> -->
<!-- 		                                        </span> -->
<!-- 		                                    </header> -->
<!-- 		                                    <div class="panel-body"> -->
<!-- 		                                    	<div id="deliveryStatus" class="chartDivCls"></div> -->
<!-- 		                                        <div id="polar-chart" data-highcharts-chart="0"><div id="highcharts-r1czo5c-0" class="highcharts-container " style="position: relative; overflow: hidden; width: 426px; height: 400px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" class="highcharts-root" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="426" height="400"><desc>Created with Highcharts 5.0.6</desc><defs><clipPath id="highcharts-r1czo5c-1"><rect x="0" y="0" width="406" height="291" fill="none"></rect></clipPath></defs><rect fill="#ffffff" class="highcharts-background" x="0" y="0" width="426" height="400" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="10" y="53" width="406" height="291"></rect><g class="highcharts-grid highcharts-xaxis-grid "><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 213 74.825" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 300.4514311632463 111.04856883675374" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 336.675 198.5" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 300.4514311632463 285.95143116324624" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 213 322.175" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 125.54856883675374 285.9514311632463" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 89.325 198.50000000000003" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 125.54856883675372 111.04856883675374" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 212.99999999999997 74.825" opacity="1"></path></g><g class="highcharts-grid highcharts-yaxis-grid "><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 136.6625 A 61.8375 61.8375 0 1 1 212.93816251030623 136.66253091874742 M 213 198.5 A 0 0 0 1 0 213 198.5 " opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 74.825 A 123.675 123.675 0 1 1 212.87632502061243 74.82506183749484 M 213 198.5 A 0 0 0 1 0 213 198.5 " opacity="1"></path></g><rect fill="none" class="highcharts-plot-border" x="10" y="53" width="406" height="291"></rect><g class="highcharts-axis highcharts-xaxis "><path fill="none" class="highcharts-axis-line" stroke="#ccd6eb" stroke-width="1" d="M 213 74.825 A 123.675 123.675 0 1 1 212.87632502061243 74.82506183749484 M 213 198.5 A 0 0 0 1 0 213 198.5 "></path></g><g class="highcharts-axis highcharts-yaxis "><path fill="none" class="highcharts-axis-line" d="M 213 198.5 L 213 74.825"></path></g><g class="highcharts-series-group"><g class="highcharts-series highcharts-series-0 highcharts-column-series highcharts-color-0 highcharts-dense-data highcharts-tracker" transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="url(#highcharts-r1czo5c-1)"><path fill="#7cb5ec" d="M 202.9999999999996 46.56 A 98.94 98.94 0 0 1 272.89114881675675 75.46892891670184 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 264.2160018142741 84.2839981857293 A 86.57249999999999 86.57249999999999 0 0 1 289.5724567137536 145.41342751443113 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 277.205 145.49999999999847 A 74.205 74.205 0 0 1 255.52330331247447 197.9183616125667 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 246.72571558162178 189.22571558162448 A 61.8375 61.8375 0 0 1 203.0618374896918 207.33746908125258 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 203.00000000000085 194.97 A 49.47 49.47 0 0 1 168.05442559162208 180.51553554164954 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 176.76457065102522 171.73542934897299 A 37.102500000000006 37.102500000000006 0 0 1 165.89751855124845 145.53710249381498 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 178.265 145.50000000000034 A 24.735 24.735 0 0 1 185.49223222917527 128.02721279581098 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 194.2548568836757 136.75485688367505 A 12.367499999999993 12.367499999999993 0 0 1 202.98763250206173 133.13250618374948 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path></g><g class="highcharts-markers highcharts-series-0 highcharts-column-series highcharts-color-0 " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="none"></g><g class="highcharts-series highcharts-series-1 highcharts-line-series highcharts-color-1 " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="url(#highcharts-r1czo5c-1)"><path fill="none" d="M 203 133.1325 L 220.49028623264928 128.00971376735077 L 240.10250000000002 145.50000000000014 L 237.98057246530007 180.48057246529694 L 202.99999999999957 207.33749999999998 L 150.52914130205443 197.97085869794992 L 116.42750000000001 145.4999999999991 L 133.0388550694003 75.53885506940566 L 203 133.1325" class="highcharts-graph" stroke="#434348" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path><path fill="none" d="M 193 133.1325 L 203 133.1325 L 220.49028623264928 128.00971376735077 L 240.10250000000002 145.50000000000014 L 237.98057246530007 180.48057246529694 L 202.99999999999957 207.33749999999998 L 150.52914130205443 197.97085869794992 L 116.42750000000001 145.4999999999991 L 133.0388550694003 75.53885506940566 L 203 133.1325 L 213 133.1325" stroke-linejoin="round" visibility="visible" stroke="rgba(192,192,192,0.0001)" stroke-width="22" class="highcharts-tracker"></path></g><g class="highcharts-markers highcharts-series-1 highcharts-line-series highcharts-color-1 highcharts-tracker " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="none"><path fill="#434348" d="M 203 129.1325 C 208.328 129.1325 208.328 137.1325 203 137.1325 C 197.672 137.1325 197.672 129.1325 203 129.1325 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 133 71.53885506940566 C 138.328 71.53885506940566 138.328 79.53885506940566 133 79.53885506940566 C 127.672 79.53885506940566 127.672 71.53885506940566 133 71.53885506940566 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 116 141.4999999999991 C 121.328 141.4999999999991 121.328 149.4999999999991 116 149.4999999999991 C 110.672 149.4999999999991 110.672 141.4999999999991 116 141.4999999999991 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 150 193.97085869794992 C 155.328 193.97085869794992 155.328 201.97085869794992 150 201.97085869794992 C 144.672 201.97085869794992 144.672 193.97085869794992 150 193.97085869794992 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 202 203.33749999999998 C 207.328 203.33749999999998 207.328 211.33749999999998 202 211.33749999999998 C 196.672 211.33749999999998 196.672 203.33749999999998 202 203.33749999999998 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 237 176.48057246529694 C 242.328 176.48057246529694 242.328 184.48057246529694 237 184.48057246529694 C 231.672 184.48057246529694 231.672 176.48057246529694 237 176.48057246529694 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 240 141.50000000000014 C 245.328 141.50000000000014 245.328 149.50000000000014 240 149.50000000000014 C 234.672 149.50000000000014 234.672 141.50000000000014 240 141.50000000000014 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 220 124.00971376735077 C 225.328 124.00971376735077 225.328 132.00971376735077 220 132.00971376735077 C 214.672 132.00971376735077 214.672 124.00971376735077 220 124.00971376735077 Z" class="highcharts-point highcharts-color-1"></path></g><g class="highcharts-series highcharts-series-2 highcharts-area-series highcharts-color-2 " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="url(#highcharts-r1czo5c-1)"><path fill="rgba(144,237,125,0.75)" d="M 203 133.1325 L 272.96114493059713 75.5388550694031 L 227.735 145.50000000000009 L 264.21600181427516 206.71600181426965 L 202.99999999999974 182.60250000000002 L 150.52914130205443 197.97085869794992 L 153.53 145.4999999999995 L 159.2742844183752 101.77428441837856 L 203 133.1325 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5" class="highcharts-area"></path><path fill="none" d="M 203 133.1325 L 272.96114493059713 75.5388550694031 L 227.735 145.50000000000009 L 264.21600181427516 206.71600181426965 L 202.99999999999974 182.60250000000002 L 150.52914130205443 197.97085869794992 L 153.53 145.4999999999995 L 159.2742844183752 101.77428441837856 L 203 133.1325 L 203 133.1325" class="highcharts-graph" stroke="#90ed7d" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path><path fill="none" d="M 193 133.1325 L 203 133.1325 L 272.96114493059713 75.5388550694031 L 227.735 145.50000000000009 L 264.21600181427516 206.71600181426965 L 202.99999999999974 182.60250000000002 L 150.52914130205443 197.97085869794992 L 153.53 145.4999999999995 L 159.2742844183752 101.77428441837856 L 203 133.1325 L 203 133.1325 L 213 133.1325" stroke-linejoin="round" visibility="visible" stroke="rgba(192,192,192,0.0001)" stroke-width="22" class="highcharts-tracker"></path></g><g class="highcharts-markers highcharts-series-2 highcharts-area-series highcharts-color-2 highcharts-tracker " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="none"><path fill="#90ed7d" d="M 159 97.77428441837856 L 163 101.77428441837856 159 105.77428441837856 155 101.77428441837856 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 153 141.4999999999995 L 157 145.4999999999995 153 149.4999999999995 149 145.4999999999995 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 150 193.97085869794992 L 154 197.97085869794992 150 201.97085869794992 146 197.97085869794992 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 202 178.60250000000002 L 206 182.60250000000002 202 186.60250000000002 198 182.60250000000002 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 264 202.71600181426965 L 268 206.71600181426965 264 210.71600181426965 260 206.71600181426965 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 227 141.50000000000009 L 231 145.50000000000009 227 149.50000000000009 223 145.50000000000009 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 272 71.5388550694031 L 276 75.5388550694031 272 79.5388550694031 268 75.5388550694031 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 203 129.1325 L 207 133.1325 203 137.1325 199 133.1325 Z" class="highcharts-point highcharts-color-2"></path></g></g><g class="highcharts-button highcharts-contextbutton" style="cursor:pointer;" stroke-linecap="round" transform="translate(392,10)"><title>Chart context menu</title><rect fill="#ffffff" class=" highcharts-button-box" x="0.5" y="0.5" width="24" height="22" rx="2" ry="2" stroke="none" stroke-width="1"></rect><path fill="#666666" d="M 6 6.5 L 20 6.5 M 6 11.5 L 20 11.5 M 6 16.5 L 20 16.5" class="highcharts-button-symbol" stroke="#666666" stroke-width="3"></path><text x="0" style="font-weight:normal;color:#333333;fill:#333333;" y="12"></text></g><text x="213" text-anchor="middle" class="highcharts-title" style="color:#333333;font-size:18px;fill:#333333;width:362px;" y="24"><tspan>Highcharts Polar Chart</tspan></text><g class="highcharts-legend" transform="translate(102,356)"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="221" height="29" visibility="visible"></rect><g><g><g class="highcharts-legend-item highcharts-column-series highcharts-color-0 highcharts-series-0" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" y="15">Column</text><rect x="2" y="4" width="12" height="12" fill="#7cb5ec" rx="6" ry="6" class="highcharts-point"></rect></g><g class="highcharts-legend-item highcharts-line-series highcharts-color-1 highcharts-series-1" transform="translate(96,3)"><path fill="none" d="M 0 11 L 16 11" class="highcharts-graph" stroke="#434348" stroke-width="2"></path><path fill="#434348" d="M 8 7 C 13.328 7 13.328 15 8 15 C 2.6719999999999997 15 2.6719999999999997 7 8 7 Z" class="highcharts-point"></path><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start">Line</text></g><g class="highcharts-legend-item highcharts-area-series highcharts-color-2 highcharts-series-2" transform="translate(163.046875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start">Area</text><rect x="2" y="4" width="12" height="12" fill="#90ed7d" rx="6" ry="6" class="highcharts-point"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels "><text x="213" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="middle" y="62.32499999999999" opacity="1"><tspan>0°</tspan></text><text x="311.0580328810445" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="start" y="102.94196711895552" opacity="1"><tspan>45°</tspan></text><text x="351.675" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="start" y="201" opacity="1"><tspan>90°</tspan></text><text x="311.0580328810445" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="start" y="299.0580328810445" opacity="1"><tspan>135°</tspan></text><text x="213" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="middle" y="339.675" opacity="1"><tspan>180°</tspan></text><text x="114.94196711895552" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="end" y="299.0580328810445" opacity="1"><tspan>225°</tspan></text><text x="74.32499999999999" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="end" y="201.00000000000003" opacity="1"><tspan>270°</tspan></text><text x="114.94196711895549" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="end" y="102.94196711895552" opacity="1"><tspan>315°</tspan></text><text x="0" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="middle" y="-9999"><tspan>360°</tspan></text></g><g class="highcharts-axis-labels highcharts-yaxis-labels "><text x="210" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:131px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="196.5" opacity="1"><tspan>0</tspan></text><text x="210" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:131px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="134.6625" opacity="1"><tspan>5</tspan></text><text x="0" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:131px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="-9999"><tspan>10</tspan></text></g><text x="416" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="395">Highcharts.com</text></svg></div></div>  -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
		                                 <div class="panel">
		                                    	<div id="monthData" class="chartDivCls"></div>
<!-- 		                                        <div id="polar-chart" data-highcharts-chart="0"><div id="highcharts-r1czo5c-0" class="highcharts-container " style="position: relative; overflow: hidden; width: 426px; height: 400px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"><svg version="1.1" class="highcharts-root" style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="426" height="400"><desc>Created with Highcharts 5.0.6</desc><defs><clipPath id="highcharts-r1czo5c-1"><rect x="0" y="0" width="406" height="291" fill="none"></rect></clipPath></defs><rect fill="#ffffff" class="highcharts-background" x="0" y="0" width="426" height="400" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="10" y="53" width="406" height="291"></rect><g class="highcharts-grid highcharts-xaxis-grid "><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 213 74.825" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 300.4514311632463 111.04856883675374" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 336.675 198.5" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 300.4514311632463 285.95143116324624" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 213 322.175" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 125.54856883675374 285.9514311632463" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 89.325 198.50000000000003" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 125.54856883675372 111.04856883675374" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 198.5 L 212.99999999999997 74.825" opacity="1"></path></g><g class="highcharts-grid highcharts-yaxis-grid "><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 136.6625 A 61.8375 61.8375 0 1 1 212.93816251030623 136.66253091874742 M 213 198.5 A 0 0 0 1 0 213 198.5 " opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 213 74.825 A 123.675 123.675 0 1 1 212.87632502061243 74.82506183749484 M 213 198.5 A 0 0 0 1 0 213 198.5 " opacity="1"></path></g><rect fill="none" class="highcharts-plot-border" x="10" y="53" width="406" height="291"></rect><g class="highcharts-axis highcharts-xaxis "><path fill="none" class="highcharts-axis-line" stroke="#ccd6eb" stroke-width="1" d="M 213 74.825 A 123.675 123.675 0 1 1 212.87632502061243 74.82506183749484 M 213 198.5 A 0 0 0 1 0 213 198.5 "></path></g><g class="highcharts-axis highcharts-yaxis "><path fill="none" class="highcharts-axis-line" d="M 213 198.5 L 213 74.825"></path></g><g class="highcharts-series-group"><g class="highcharts-series highcharts-series-0 highcharts-column-series highcharts-color-0 highcharts-dense-data highcharts-tracker" transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="url(#highcharts-r1czo5c-1)"><path fill="#7cb5ec" d="M 202.9999999999996 46.56 A 98.94 98.94 0 0 1 272.89114881675675 75.46892891670184 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 264.2160018142741 84.2839981857293 A 86.57249999999999 86.57249999999999 0 0 1 289.5724567137536 145.41342751443113 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 277.205 145.49999999999847 A 74.205 74.205 0 0 1 255.52330331247447 197.9183616125667 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 246.72571558162178 189.22571558162448 A 61.8375 61.8375 0 0 1 203.0618374896918 207.33746908125258 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 203.00000000000085 194.97 A 49.47 49.47 0 0 1 168.05442559162208 180.51553554164954 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 176.76457065102522 171.73542934897299 A 37.102500000000006 37.102500000000006 0 0 1 165.89751855124845 145.53710249381498 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 178.265 145.50000000000034 A 24.735 24.735 0 0 1 185.49223222917527 128.02721279581098 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7cb5ec" d="M 194.2548568836757 136.75485688367505 A 12.367499999999993 12.367499999999993 0 0 1 202.98763250206173 133.13250618374948 L 203 145.5 A 0 0 0 0 0 203 145.5 Z" class="highcharts-point highcharts-color-0"></path></g><g class="highcharts-markers highcharts-series-0 highcharts-column-series highcharts-color-0 " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="none"></g><g class="highcharts-series highcharts-series-1 highcharts-line-series highcharts-color-1 " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="url(#highcharts-r1czo5c-1)"><path fill="none" d="M 203 133.1325 L 220.49028623264928 128.00971376735077 L 240.10250000000002 145.50000000000014 L 237.98057246530007 180.48057246529694 L 202.99999999999957 207.33749999999998 L 150.52914130205443 197.97085869794992 L 116.42750000000001 145.4999999999991 L 133.0388550694003 75.53885506940566 L 203 133.1325" class="highcharts-graph" stroke="#434348" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path><path fill="none" d="M 193 133.1325 L 203 133.1325 L 220.49028623264928 128.00971376735077 L 240.10250000000002 145.50000000000014 L 237.98057246530007 180.48057246529694 L 202.99999999999957 207.33749999999998 L 150.52914130205443 197.97085869794992 L 116.42750000000001 145.4999999999991 L 133.0388550694003 75.53885506940566 L 203 133.1325 L 213 133.1325" stroke-linejoin="round" visibility="visible" stroke="rgba(192,192,192,0.0001)" stroke-width="22" class="highcharts-tracker"></path></g><g class="highcharts-markers highcharts-series-1 highcharts-line-series highcharts-color-1 highcharts-tracker " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="none"><path fill="#434348" d="M 203 129.1325 C 208.328 129.1325 208.328 137.1325 203 137.1325 C 197.672 137.1325 197.672 129.1325 203 129.1325 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 133 71.53885506940566 C 138.328 71.53885506940566 138.328 79.53885506940566 133 79.53885506940566 C 127.672 79.53885506940566 127.672 71.53885506940566 133 71.53885506940566 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 116 141.4999999999991 C 121.328 141.4999999999991 121.328 149.4999999999991 116 149.4999999999991 C 110.672 149.4999999999991 110.672 141.4999999999991 116 141.4999999999991 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 150 193.97085869794992 C 155.328 193.97085869794992 155.328 201.97085869794992 150 201.97085869794992 C 144.672 201.97085869794992 144.672 193.97085869794992 150 193.97085869794992 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 202 203.33749999999998 C 207.328 203.33749999999998 207.328 211.33749999999998 202 211.33749999999998 C 196.672 211.33749999999998 196.672 203.33749999999998 202 203.33749999999998 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 237 176.48057246529694 C 242.328 176.48057246529694 242.328 184.48057246529694 237 184.48057246529694 C 231.672 184.48057246529694 231.672 176.48057246529694 237 176.48057246529694 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 240 141.50000000000014 C 245.328 141.50000000000014 245.328 149.50000000000014 240 149.50000000000014 C 234.672 149.50000000000014 234.672 141.50000000000014 240 141.50000000000014 Z" class="highcharts-point highcharts-color-1"></path><path fill="#434348" d="M 220 124.00971376735077 C 225.328 124.00971376735077 225.328 132.00971376735077 220 132.00971376735077 C 214.672 132.00971376735077 214.672 124.00971376735077 220 124.00971376735077 Z" class="highcharts-point highcharts-color-1"></path></g><g class="highcharts-series highcharts-series-2 highcharts-area-series highcharts-color-2 " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="url(#highcharts-r1czo5c-1)"><path fill="rgba(144,237,125,0.75)" d="M 203 133.1325 L 272.96114493059713 75.5388550694031 L 227.735 145.50000000000009 L 264.21600181427516 206.71600181426965 L 202.99999999999974 182.60250000000002 L 150.52914130205443 197.97085869794992 L 153.53 145.4999999999995 L 159.2742844183752 101.77428441837856 L 203 133.1325 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5 L 203 145.5" class="highcharts-area"></path><path fill="none" d="M 203 133.1325 L 272.96114493059713 75.5388550694031 L 227.735 145.50000000000009 L 264.21600181427516 206.71600181426965 L 202.99999999999974 182.60250000000002 L 150.52914130205443 197.97085869794992 L 153.53 145.4999999999995 L 159.2742844183752 101.77428441837856 L 203 133.1325 L 203 133.1325" class="highcharts-graph" stroke="#90ed7d" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path><path fill="none" d="M 193 133.1325 L 203 133.1325 L 272.96114493059713 75.5388550694031 L 227.735 145.50000000000009 L 264.21600181427516 206.71600181426965 L 202.99999999999974 182.60250000000002 L 150.52914130205443 197.97085869794992 L 153.53 145.4999999999995 L 159.2742844183752 101.77428441837856 L 203 133.1325 L 203 133.1325 L 213 133.1325" stroke-linejoin="round" visibility="visible" stroke="rgba(192,192,192,0.0001)" stroke-width="22" class="highcharts-tracker"></path></g><g class="highcharts-markers highcharts-series-2 highcharts-area-series highcharts-color-2 highcharts-tracker " transform="translate(10,53) scale(1 1)" width="123.675" height="777.0729428654353" clip-path="none"><path fill="#90ed7d" d="M 159 97.77428441837856 L 163 101.77428441837856 159 105.77428441837856 155 101.77428441837856 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 153 141.4999999999995 L 157 145.4999999999995 153 149.4999999999995 149 145.4999999999995 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 150 193.97085869794992 L 154 197.97085869794992 150 201.97085869794992 146 197.97085869794992 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 202 178.60250000000002 L 206 182.60250000000002 202 186.60250000000002 198 182.60250000000002 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 264 202.71600181426965 L 268 206.71600181426965 264 210.71600181426965 260 206.71600181426965 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 227 141.50000000000009 L 231 145.50000000000009 227 149.50000000000009 223 145.50000000000009 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 272 71.5388550694031 L 276 75.5388550694031 272 79.5388550694031 268 75.5388550694031 Z" class="highcharts-point highcharts-color-2"></path><path fill="#90ed7d" d="M 203 129.1325 L 207 133.1325 203 137.1325 199 133.1325 Z" class="highcharts-point highcharts-color-2"></path></g></g><g class="highcharts-button highcharts-contextbutton" style="cursor:pointer;" stroke-linecap="round" transform="translate(392,10)"><title>Chart context menu</title><rect fill="#ffffff" class=" highcharts-button-box" x="0.5" y="0.5" width="24" height="22" rx="2" ry="2" stroke="none" stroke-width="1"></rect><path fill="#666666" d="M 6 6.5 L 20 6.5 M 6 11.5 L 20 11.5 M 6 16.5 L 20 16.5" class="highcharts-button-symbol" stroke="#666666" stroke-width="3"></path><text x="0" style="font-weight:normal;color:#333333;fill:#333333;" y="12"></text></g><text x="213" text-anchor="middle" class="highcharts-title" style="color:#333333;font-size:18px;fill:#333333;width:362px;" y="24"><tspan>Highcharts Polar Chart</tspan></text><g class="highcharts-legend" transform="translate(102,356)"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="221" height="29" visibility="visible"></rect><g><g><g class="highcharts-legend-item highcharts-column-series highcharts-color-0 highcharts-series-0" transform="translate(8,3)"><text x="21" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" y="15">Column</text><rect x="2" y="4" width="12" height="12" fill="#7cb5ec" rx="6" ry="6" class="highcharts-point"></rect></g><g class="highcharts-legend-item highcharts-line-series highcharts-color-1 highcharts-series-1" transform="translate(96,3)"><path fill="none" d="M 0 11 L 16 11" class="highcharts-graph" stroke="#434348" stroke-width="2"></path><path fill="#434348" d="M 8 7 C 13.328 7 13.328 15 8 15 C 2.6719999999999997 15 2.6719999999999997 7 8 7 Z" class="highcharts-point"></path><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start">Line</text></g><g class="highcharts-legend-item highcharts-area-series highcharts-color-2 highcharts-series-2" transform="translate(163.046875,3)"><text x="21" y="15" style="color:#333333;font-size:12px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start">Area</text><rect x="2" y="4" width="12" height="12" fill="#90ed7d" rx="6" ry="6" class="highcharts-point"></rect></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels "><text x="213" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="middle" y="62.32499999999999" opacity="1"><tspan>0°</tspan></text><text x="311.0580328810445" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="start" y="102.94196711895552" opacity="1"><tspan>45°</tspan></text><text x="351.675" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="start" y="201" opacity="1"><tspan>90°</tspan></text><text x="311.0580328810445" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="start" y="299.0580328810445" opacity="1"><tspan>135°</tspan></text><text x="213" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="middle" y="339.675" opacity="1"><tspan>180°</tspan></text><text x="114.94196711895552" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="end" y="299.0580328810445" opacity="1"><tspan>225°</tspan></text><text x="74.32499999999999" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="end" y="201.00000000000003" opacity="1"><tspan>270°</tspan></text><text x="114.94196711895549" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="end" y="102.94196711895552" opacity="1"><tspan>315°</tspan></text><text x="0" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:41px;text-overflow:clip;" transform="translate(0,0)" text-anchor="middle" y="-9999"><tspan>360°</tspan></text></g><g class="highcharts-axis-labels highcharts-yaxis-labels "><text x="210" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:131px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="196.5" opacity="1"><tspan>0</tspan></text><text x="210" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:131px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="134.6625" opacity="1"><tspan>5</tspan></text><text x="0" style="color:#666666;cursor:default;font-size:11px;fill:#666666;width:131px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="-9999"><tspan>10</tspan></text></g><text x="416" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="395">Highcharts.com</text></svg></div></div> -->
		                                    </div>
		                            </div>
		                            <div class="col-md-1"></div>
		                                <div class="row col-md-4
		                                 col-sm-6">
						
		                            
		                                <div class="panel first-info short-states" style="height:150px;width:250px;margin-top:20%;" >
		                                    <div class="panel-title">
		                                        <h4> <span class="label label-success pull-left" style="background-color: #48d8be;width:100%;right:0px;">Total Unique Customers</span></h4>
		                                    </div>
		                                    <div class="panel-body" id="uniqcus">
		                                        <h1 class="uniqcus" style="color: #cec7c7;">0</h1>
		                                    </div>
		                                </div>
		                           
		                            </div>
		                        </div>
		                        
		                        <div class="row">
		                            <!--charts start-->
		                            <div class="col-md-7 ">
		                                <div class="panel">
		                                    <header class="panel-heading panel-border">
		                                        Top Five Delivery
		                                        </header>
		                                    <div class="panel-body whlbl">
												<div class="topDeliveryContentDivCls" style="margin-top: 0px;">

												</div>
											</div>
		                                </div>
		                            </div>
		                            <!--charts end-->
		
		                            <div class="col-md-5">
		                                <div class="panel">
		                                    <header class="panel-heading panel-border">
		                                        Area Wise Delivered Kg
			                                    </header>
		                                    <div class="panel-body">
												<div class="deliveredKgContenetCls" style="margin-top: 0px;">

												</div>

												<div class="info-box">
													<span class="info-box-icon bg-aqua"
														style="width: 70%; padding: 6px 20px; background-color: #E91E63 !important; color: white;"><small
														style="margin-top: 0px; display: inline-block; font-size: 21px; line-height: 27px;">Total<br>
															Delivered
													</small></span>
													<div class="info-box-content"
														style="float: left; margin-left: 0px; padding: 5px 20px;">
														 <span
															class="info-box-number totalDeliveredKg" style="font-size: 26px;"> </span>
													</div>
												</div>
											</div>
		                                </div>
		                            </div>
		                        </div>
							</div>
							  
						<!-- <div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
								
								
								<div class="btn-group btn-group-toggle mx-3" data-toggle="buttons" style="float:right;">
								
								<label class="btn btn-outline-secondary">
								<input id="dTodayViewsBtnId" class="dViewsBtnCls" value="today" type="radio" name="options" onchange="viewsChange(this)"> Today Views</label>
								<span id="dTodayViewsBtnId" class="dViewsBtnCls" > Today Views</span></label>

								<label class="btn btn-outline-secondary active">
								<input id="dFullViewsBtnId" class="dViewsBtnCls" value="full" type="radio" name="options" onchange="viewsChange(this)"> Views</label>
								<span id="dFullViewsBtnId" class="dViewsBtnCls"  > Views</span></label>

								</div>
							</div>
							</div> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>