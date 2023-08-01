<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<title>Vedagram : Sender Requests</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/packagetrack.js"></script>
<script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script>

<script>
var deliveryStatusChart;
var dps = [];

$(document).ready(function() {
	
	if($('.mainDashboardCls').length > 0) {
		dps.push({label: "Total", y: 0});
		dps.push({label: "Assigned", y: 0});
		dps.push({label: "Acknoledge", y: 0});
		dps.push({label: "Picked Up", y: 0});
		dps.push({label: "Delivered", y: 0});
		dps.push({label: "Canceled", y: 0});
		
		deliveryStatusChart = new CanvasJS.Chart("deliveryStatusChart", {
			theme: "theme2",//theme1
			title:{
				text: "Delivery Status"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: dps
			}
			]
		});
		deliveryStatusChart.render();
	}
});
</script>
</head>

<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
				<div class="container">
					<h5 class="font-weight-bold">
						<span>Delivery Package Management</span>
					</h5>
					<div class="row">
						<div class="col-md-12 mr-auto" style="margin-top: 20px;display:none">
							<div class="row formcls">
								<div class="col-md-6 mr-auto">
									<div class="row">
										<div class="col-md-12">
											<div class="radio">
												<input id="radio-1" type="radio" name="periodSelect" class="rad_periodSelect_cls" value="d" checked="checked">
												<label for="radio-1" class="radio-label">Search By Date</label>
											</div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodDayLblCls">From</label><br> 
											<input type="text" class="dateSearch" id="from_date_id" placeholder="Ex. YYYY-MM-DD"> 
											<div class="validation"></div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodDayLblCls">To Date</label><br> 
											<input type="text" class="dateSearch" id="to_date_id" placeholder="Ex. YYYY-MM-DD">
											<div class="validation"></div>
										</div>
									</div>
								</div>
								
								<div class="col-md-6 mr-auto">
									<div class="row">
										<div class="col-md-12">
											<div class="radio">
												<input id="radio-2" type="radio" name="periodSelect" class="rad_periodSelect_cls" value="m">
												<label for="radio-2" class="radio-label">Search By Month</label>
											</div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodMonthLblCls">Month</label><br> 
											<input name="startDate" id="startDate" class="mnth_datepicker monthSearch" placeholder="Ex. May 2020" disabled>
											<div class="validation"></div>
										</div>
									</div>
								</div>
								
								<div class="col-md-3">
									<label for="pickdrop">Package Status</label><br> <select
										id="package_status">
										<option value="">All</option>
										<option value="PICKEDUP">Picked Up</option>
										<option value="ASSIGNED">Assigned</option>
										<option value="DELIVERED">Delivered</option>
										<option value="CANCEL">Cancel</option>
									</select>
								</div>
								
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="">Batch Id</label><br> 
									<input type="text" id="batch_id" class="" placeholder="Ex. BUDDMMYYYY-01">
									<div class="validation"></div>
								</div>
								
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="">Vendor Name</label><br> 
									
									<% if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_ADMIN")) { %>
										<select id="sel_vendor_id" style="overflow: hidden"></select>
									<%} else { %>
										<select id="sel_vendor_id" style="overflow: hidden" disabled="disabled"></select>
									<%} %>
								</div>
								
								<div class="col-md-3 form-group branchdivCls" style="display: none;">
									<label for="pickdrop" class="">Vendor Branch</label><br> 
									<select id="sel_vendorBranch_id" style="overflow: hidden" class=""></select>
									<div class="validation"></div>
								</div>
								
								<div class="col-md-12"></div>

								<div class="col-md-12">
									<button class="btn btn-primary" id="sender_search">
										<span class="fa fa-search btn-icon"></span> Search</button>
								</div>
							</div>
						</div>

						<%if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_VENDOR")) { %>
						<!-- <div class="col-md-12 mr-auto mainDashboardCls" style="margin-top: 20px;">
							<div class="row1">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="deliveryStatusChart" class="chartDivCls"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div> -->
						<%} %>
						
						<div class="col-md-12" style="margin-top: 50px;">
							<table id="senderdetails" class="table table-striped table-bordered dataTable no-footer">
								<thead>
									<tr>
										<th>Type</th>
										<th>Created Date</th>
										<th>Schedule Date</th>
										<th>Sender Name</th>
										<th>Pick From</th>
										<th>Drop To</th>
										<th>Amount</th>
										<th>Package Status</th>
										<th>Deliverer Name</th>
										<th>Available Deliverers</th>
										<th>Action</th>
										
									</tr>
								</thead>
							</table>
							
							<div class="row">
								<div class="col-md-12">
									<button class="btn btn-primary" id="sender_report" style="float: right; margin-top: 20px;">
										<span class="fa fa-download btn-icon"></span> Generate Report</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	
	<div id="delvModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="loadCls"></div>
				<div class="modal-header">
					<h5 class="modal-title">Delivery Information</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group" style="font-size: 14px; display: none;">
						<input type="radio" name="loginas" value="1" id="loginmob"
							checked="checked"> <label for="loginmob">By
							Mobile No.</label> <input type="radio" name="loginas" value="2"
							id="loginemail" style="margin-left: 20px;"> <label
							for="loginemail">By Email Id</label>
					</div>
					<div class="delvdetlsdivcls" style="font-size: 0.8rem;">
						<div id="errormsg"></div>
						<div class="form-group">
							<h6 class="delvHdrCls">Pickup Address</h6>
							<span class="pickDtlsCls"></span>
						</div>
						<div class="form-group">
							<h6 class="delvHdrCls">Drop Address</h6>
							<span class="dropDtlsCls"></span>
						</div>
						<div class="form-group">
							<h6 class="delvHdrCls">Package Details</h6>
							<span class="pckgDtlsCls"></span>
						</div>
					</div>

				</div>



			</div>

		</div>
	</div>
</body>