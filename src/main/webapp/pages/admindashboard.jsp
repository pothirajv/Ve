<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%-- <script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script> --%>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<style>

/*  .vdeliveryStatusCls{ */
/*     background: linear-gradient(to right, rgba(6, 185, 157, 1), rgba(132, 217, 210, 1)); */
/*  text-align :center; */
/*  color:white; */
/*  } */
 
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

.bg-fb{
/* background-color: #3b5998!important; */
    background-color: #00aced!important;
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

.card {
    position: relative;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-direction: column;
    flex-direction: column;
    min-width: 0;
    margin-bottom: 1.5rem;
    word-wrap: break-word;
    background-clip: border-box;
    border: 1px solid;
    border-radius: .25rem;
    background-color: #fff;
    border-color: #d8dbe0;
}

.card-body {
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    min-height: 1px;
    padding: 1.25rem;
}

.col {
    -ms-flex-preferred-size: 0;
    flex-basis: 0;
    -ms-flex-positive: 1;
    flex-grow: 1;
    max-width: 100%;
}

.c-vr {
    width: 1px;
    background-color: rgba(0,0,21,.2);
}

</style>

<script>


$(document).ready(function(){

	//$("#todayDeliveryViews").hide();
	
	$('.loadCmnCls').show();
	$.ajax({
		type:'POST',
		url:$("#contextPath").val()+'/adm/admindashboarddetails',
		data :{
			'city' : 'Chennai'
		},
		success:function(data){
			$('.loadCmnCls').hide();
			//deliveryStatus1(data);
			//PackageStatusCount
			usersDetails(data);
			topPickUpDetails(data);
			topDeliveryDetails(data);
			regCountChartLoad(data);
			deliveriesChartLoad(data);
			delivererDetailsTbl(data);
		}
	});
});
//Chart Load

function deliveriesChartLoad(data){
	
	deliveriesObj = [];
	$.map(data.deliveryCountByMonth,function(value,key,index){
		
		var delivery= {
				 y: value,
				 label: key
				 
		}
		deliveriesObj.push(delivery)
	});
	
	var deliveriesChart = new CanvasJS.Chart("deliveriesChart", {
		animationEnabled: true,
		theme: "light2", // "light1", "light2", "dark1", "dark2"
		title:{
			text: "Deliveries"
		},
		
		data: [{        
			type: "column",  
			showInLegend: true, 
			indexLabel: "{y}",
			legendMarkerColor: "#6d78ad",
			legendText: "delivery",
			dataPoints :deliveriesObj
		}]
		
	});
	deliveriesChart.render();
	
}

function regCountChartLoad(data){
	
	registeredUsersObj = [];
	$.map(data.userRegCountByMonth,function(value,key,index){
		
		var userObj= {
				 y: value,
				 label: key
				 
		}
		registeredUsersObj.push(userObj)
	});
	
	registeredVendorObj = [];
	$.map(data.vRegCountByMonth,function(value,key,index){
		
		var vendorObj= {
				 y: value,
				 label: key
				 
		}
		registeredVendorObj.push(vendorObj)
	});
	
	var registeredCountChart = new CanvasJS.Chart("registeredCountChart", {
		animationEnabled: true,
		theme: "light2", // "light1", "light2", "dark1", "dark2"
		title:{
			text: "Registered Users And Vendors"
		},
		
		
		data: [{        
			type: "column",  
			showInLegend: true, 
			name: "Users",
			indexLabel: "{y}",
			legendMarkerColor: "#6d78ad",
			legendText: "Users",
			dataPoints :registeredUsersObj
		},
		{        
			type: "column",  
			showInLegend: true, 
			name: "Vendors",
			indexLabel: "{y}",
			legendMarkerColor: "#51cda0",
			legendText: "Vendors",
			//axisYType: "secondary",
			dataPoints :registeredVendorObj
		}]
	});
	registeredCountChart.render();
	
	
}
	
//usersDetails
function usersDetails(data){
	
    $('#sender_reg_users').text(data.senderCount);
    $('#sender_active_users').text(data.activeSenderCount);
    $('#sender_cod').text(data.senderCODAmount);
    
    $('#vendor_reg_users').text(data.vendorCount);
    $('#vendor_active_users').text(data.activeVendorCount);
    $('#vendor_cod').text(data.vendorCODAmount);
    
    $('#deliver_reg_users').text(data.delivererCount);
    $('#deliver_active_users').text(data.activeDelivererCount);
    $('#deliver_cod').text(data.delivererCODAmount);
	
}

//TopPickUpDetails
function topPickUpDetails(data){
	
	var percentage=0;
	var topCount=1;
	$.map(data.topPickupByLocationMap,function(value,key,index){
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
	}else{
		bg_color="bg-green";
	}
	
	if(value > 0 && data.totalPickupCount > 0){
		percentage =((parseInt(value) / parseInt(data.totalPickupCount)) *100).toFixed(2);
	}else{
		percentage = 0;
	}
	var topPickUp="";
	topPickUp +='<div class="info-box '+bg_color+'"><span class="info-box-icon"><small>'+topCount+'</small></span>'
		        +'<div class="info-box-content"><span class="info-box-text">'+key+'</span><span class="info-box-number">'+value+'</span>'
		        +'<div class="progress" style="height: 2px; margin-bottom: 0px;"><div class="progress-bar" style="width: '+percentage+'%"></div></div>'
		        +'<span class="progress-description">'+percentage+'% delivered</span></div></div>'
		        
		$(".topPickUpContentDivCls").append(topPickUp);       
		        
		        topCount++;
	});
}

//TopDeliveryDetails
function topDeliveryDetails(data){
	
	var percentage=0;
	var topCount=1;
	$.map(data.topDeliveryByLocationMap,function(value,key,index){
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
	}else{
		bg_color="bg-green";
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
	
function delivererDetailsTbl(data){
	
	
	delivererDetailsTbl = $("#delivererDetailsTbl").DataTable({
		
		"data" : data.delivererDto,
		"autoWidth": false,
		"oLanguage" : {
			"sEmptyTable" : "No Data Available"
		},
		"order" : [ [ 0, "desc" ] ],
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
		
		"columns" : [{
			"data" : "delivererName",
		},{
			"data" : "totalDeliveries",
		},{
			"data" : "totalPackageVal",
		},{
			"data" : "totalDeliveryCharges",
		},{
			"data" : "totalPayout",
		},{
			"data" : "gst",
		},{
			"data" : "revenue"
		}],
		"pageLength" : 5,
		"order" : [ [ 0, "desc" ] ],
		"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]

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
				<h5 class="font-weight-bold">Dashboard</h5>
				
				<div class="row">
					<div class="col-md-12 mr-auto" style="margin-top: 20px;">
						<div class="mainDashboardCls">
							<div class="panel-sec">
<!-- 								<div class="row"> -->
<!-- 		                            <div class="col-md-3 col-sm-6"> -->
<!-- 		                                <div class="panel first-info short-states"> -->
<!-- 		                                    <div class="panel-title"> -->
<!-- 		                                        <h4> <span class="label label-danger pull-right" style="background-color: #d9534f;">Registered Users</span></h4> -->
<!-- 		                                    </div> -->
<!-- 		                                    <div class="panel-body" id="aRegUsersId"> -->
<!-- 		                                        <h1 style="color: #cec7c7;">0</h1> -->
<!-- 		                                    </div> -->
<!-- 		                                </div> -->
<!-- 		                            </div> -->
		                            
<!-- 								</div> -->
								
								<div class="row" id="usersDetailsId">
								
								<div class="col-md-4 mr-auto" style="margin-top: 20px;">
								 <div class="card">
								<div class="card-header bg-fb content-center " style="text-align:center;">Sender 
<!--     							<span class="text-center">Sender Deatils</span> -->
								</div>
								<div class="card-body row text-center">
								<div class="col">
								<div class="text-value-xl" id="sender_reg_users"></div>
								<div class="text-uppercase text-muted small">Total User</div>
								</div>
								<div class="c-vr"></div>
								<div class="col">
								<div class="text-value-xl" id="sender_active_users"></div>
								<div class="text-uppercase text-muted small">Active Users</div>
								</div>
								<div class="c-vr"></div>
								<div class="col">
								<div class="text-value-xl" id="sender_cod"></div>
								<div class="text-uppercase text-muted small">COD</div>
								</div>
								</div>
								</div>
								
								</div>
								
								<div class="col-md-4 mr-auto" style="margin-top: 20px;">
								 <div class="card">
								<div class="card-header bg-fb content-center " style="text-align:center;">Vendor
<!--     							<span class="text-center">Vendor</span> -->
								</div>
								<div class="card-body row text-center">
								<div class="col">
								<div class="text-value-xl" id="vendor_reg_users"></div>
								<div class="text-uppercase text-muted small">Total User</div>
								</div>
								<div class="c-vr"></div>
								<div class="col">
								<div class="text-value-xl" id="vendor_active_users"></div>
								<div class="text-uppercase text-muted small">Active Users</div>
								</div>
								<div class="c-vr"></div>
								<div class="col">
								<div class="text-value-xl" id="vendor_cod"></div>
								<div class="text-uppercase text-muted small">COD</div>
								</div>
								</div>
								</div>
								
								</div>
								
								<div class="col-md-4 mr-auto" style="margin-top: 20px;">
								 <div class="card">
								<div class="card-header bg-fb content-center " style="text-align:center;">Deliverer
<!--     							<span class="text-center">Deliverer</span> -->
								</div>
								<div class="card-body row text-center">
								<div class="col">
								<div class="text-value-xl" id="deliver_reg_users"></div>
								<div class="text-uppercase text-muted small">Total User</div>
								</div>
								<div class="c-vr"></div>
								<div class="col">
								<div class="text-value-xl" id="deliver_active_users"></div>
								<div class="text-uppercase text-muted small">Active Users</div>
								</div>
								<div class="c-vr"></div>
								<div class="col">
								<div class="text-value-xl" id="deliver_cod"></div>
								<div class="text-uppercase text-muted small">COD</div>
								</div>
								</div>
								</div>
								
								</div>
								
		                        </div>
		                        
		                         <div class="row">
		                            
		                            <div class="col-md-6">
		                                <div class="panel">

		                                    <div class="panel-body">
		                                    
		                                    	<div id="registeredCountChart" class="chartDivCls"></div>

		                                    </div>
		                                </div>
		                            </div>
		                            
		                             <div class="col-md-6">
		                                <div class="panel">

		                                    <div class="panel-body">
		                                    
		                                    	<div id="deliveriesChart" class="chartDivCls"></div>

		                                    </div>
		                                </div>
		                            </div>
		                            
		                            </div>
		                        
		                        <div class="row">
		                         <div class="col-md-6 ">
		                                <div class="panel">
		                                    <header class="panel-heading panel-border">
		                                        Top PickUp
		                                        <span class="tools pull-right">
		                                            <a class="refresh-box fa fa-repeat" href="javascript:;"></a>
		                                            <a class="collapse-box fa fa-chevron-down" href="javascript:;"></a>
		                                            <a class="close-box fa fa-times" href="javascript:;"></a>
		                                        </span>
		                                    </header>
		                                    <div class="panel-body whlbl">
												<div class="topPickUpContentDivCls" style="margin-top: 0px;">

												</div>
											</div>
		                                </div>
		                            </div>
		                            
		                             <div class="col-md-6 ">
		                                <div class="panel">
		                                    <header class="panel-heading panel-border">
		                                        Top Deliveries
		                                        <span class="tools pull-right">
		                                            <a class="refresh-box fa fa-repeat" href="javascript:;"></a>
		                                            <a class="collapse-box fa fa-chevron-down" href="javascript:;"></a>
		                                            <a class="close-box fa fa-times" href="javascript:;"></a>
		                                        </span>
		                                    </header>
		                                    <div class="panel-body whlbl">
												<div class="topDeliveryContentDivCls" style="margin-top: 0px;">

												</div>
											</div>
		                                </div>
		                            </div>
		                            
		                            </div>
		                            
		                           
		                           <div class="" style="margin-top: 50px;">

                                      <div class="panel">
		                                    <header class="panel-heading panel-border" style="background-color:#74a27c;">
		                                        Deliverer Details
		                                        <span class="tools pull-right">
<!-- 		                                            <a class="refresh-box fa fa-repeat" href="javascript:;"></a> -->
<!-- 		                                            <a class="collapse-box fa fa-chevron-down" href="javascript:;"></a> -->
<!-- 		                                            <a class="close-box fa fa-times" href="javascript:;"></a> -->
		                                        </span>
		                                    </header>
		                                    <div class="panel-body">
		                                        <div class="order-short-info">
<!-- 		                                           	 <span class="mtop-10"> COD: <strong>123 <i class="fa fa-level-up text-primary"></i></strong>,  Payment Gateway: <strong> 212 <i class="fa fa-level-down text-danger"></i></strong></span> -->
<%-- 		                                            <a href="<%=request.getContextPath()%>/v/requestReport" class="pull-right pull-left-xs btn1 btn-primary1 btn-sm1">View All</a> --%>
		                                        </div>
		                                        <hr>
		                                        <div class="table-responsive">
		                        <table id="delivererDetailsTbl" class="table table-striped table-bordered dataTable no-footer">
								<thead>
									<tr>
										<th>Deliverer Name</th>
										<th>Delivery</th>
										<th>Package Amount</th>
										<th>Delivery Charge</th>
										<th>Total Payout</th>
										<th>Gst</th>
										<th>Revenue</th>
									</tr>
								</thead>
							</table>
		                                        </div>
		                                    </div>
		                                </div>








							
						</div>
		                        
		                        
		                        
		                        
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>