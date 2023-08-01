<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script src="<%=request.getContextPath()%>/js/canvas/canvasjs.min.js"></script>
<script>
	
	$(document).ready(function() {
		
		var mercLoginChart = new CanvasJS.Chart("mercLoginChart", {
			theme: "theme2",//theme1
			title:{
				text: "No. Of Deliveries Of Last 4 Months"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "spline",
				dataPoints: [
					{ label: "Jan 2020", y: 105   },
					{ label: "Feb 2020", y: 80  },
					{ label: "March 2020", y: 100  },
					{ label: "April 2020", y: 2  }
				]
			}
			]
		});
		mercLoginChart.render();
		
		var noOfProdChart = new CanvasJS.Chart("noOfProdChart", {
			theme: "theme2",//theme1
			title:{
				text: "Today Delivery Status"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: [
					{ label: "Total", y: 50  },
					{ label: "Assigned", y: 12  },
					{ label: "Pickedup", y: 22  },
					{ label: "Delivered", y: 10  },
					{ label: "Canceled", y: 6  }
				]
			}
			]
		});
		noOfProdChart.render();
		
		var prodBySchemeStateChart = new CanvasJS.Chart("prodBySchemeStateChart", {
			theme: "theme2",//theme1
			title:{
				text: "Products By Scheme Status"              
			},
	        legend:{
	            verticalAlign: "bottom",
	            horizontalAlign: "center"
			},
			animationEnabled: true,   // change to true
			data: [
				{
					type: "doughnut",
					startAngle: 10,
					toolTipContent: "{name} <strong>{y} %<strong>",
					showInLegend: true,
					indexLabel: "{name} {y}%",
					dataPoints: [
					{  y: 50, name:"Not Assigned" },
					{  y: 40, name:"In Stock"},
					{  y: 10, name:"Out Of Stock"}
					]
				}
			]
		});
		prodBySchemeStateChart.render();
		
		var schemePendingApproveChart = new CanvasJS.Chart("schemePendingApproveChart", {
			theme: "theme2",//theme1
			title:{
				text: "Scheme Pending Approval By Month"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: [
					{ label: "May 2016", y: 15  },
					{ label: "June 2016", y: 25  },
					{ label: "July 2016", y: 30  },
					{ label: "August 2016", y: 28  }
				]
			}
			]
		});
		schemePendingApproveChart.render();
		
		var noOfTxnChart = new CanvasJS.Chart("noOfTxnChart", {
			theme: "theme2",//theme1
			title:{
				text: "No. Of Transactions By Month"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: [
					{ label: "May 2016", y: 100  },
					{ label: "June 2016", y: 250  },
					{ label: "July 2016", y: 315  },
					{ label: "August 2016", y: 700  }
				]
			}
			]
		});
		noOfTxnChart.render();
		
		var txnValChart = new CanvasJS.Chart("txnValChart", {
			theme: "theme2",//theme1
			title:{
				text: "Transaction Value By Month"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "spline",
				dataPoints: [
					{ label: "May 2016", y: 100000  },
					{ label: "June 2016", y: 250000  },
					{ label: "July 2016", y: 1000000  },
					{ label: "August 2016", y: 1500000  }
				]
			}
			]
		});
		txnValChart.render();
		
		var prodOneSalesChart = new CanvasJS.Chart("prodOneSalesChart", {
			theme: "theme2",//theme1
			title:{
				text: "iPhone SE Sales Status"              
			},
	        legend:{
	            verticalAlign: "bottom",
	            horizontalAlign: "center"
			},
			animationEnabled: true,   // change to true
			data: [
				{
					type: "doughnut",
					startAngle: 10,
					toolTipContent: "{name} <strong>{y} %<strong>",
					showInLegend: true,
					indexLabel: "{name} {y}%",
					dataPoints: [
					{  y: 50, name:"Mumbai" },
					{  y: 25, name:"Hyderabad"},
					{  y: 25, name:"Chennai"}
					]
				}
			]
		});
		prodOneSalesChart.render();
		
		var prodTwoSalesChart = new CanvasJS.Chart("prodTwoSalesChart", {
			theme: "theme2",//theme1
			title:{
				text: "Redmi Note 3 Sales Status"              
			},
	        legend:{
	            verticalAlign: "bottom",
	            horizontalAlign: "center"
			},
			animationEnabled: true,   // change to true
			data: [
				{
					type: "doughnut",
					startAngle: 10,
					toolTipContent: "{name} <strong>{y} %<strong>",
					showInLegend: true,
					indexLabel: "{name} {y}%",
					dataPoints: [
					{  y: 50, name:"Chennai" },
					{  y: 30, name:"Mumbai"},
					{  y: 20, name:"Hyderabad"}
					]
				}
			]
		});
		prodTwoSalesChart.render();
		
		var merRatChart = new CanvasJS.Chart("merRatChart", {
			theme: "theme2",//theme1
			title:{
				text: "Merchant Ratings"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "spline",
				dataPoints: [
					{ label: "May 2016", y: 2.5  },
					{ label: "June 2016", y: 2.5  },
					{ label: "July 2016", y: 3.5  },
					{ label: "August 2016", y: 4  }
				]
			}
			]
		});
		merRatChart.render();
		
		var prodRatChart = new CanvasJS.Chart("prodRatChart", {
			theme: "theme2",//theme1
			title:{
				text: "Product Ratings"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: [
					{ label: "iPhone SE", y: 4.5  },
					{ label: "Lenovo K5 Vibe", y: 4  },
					{ label: "AZUS Zenfone 2", y: 3.75  },
					{ label: "Microsoft Lumia 520", y: 3  },
					{ label: "Redmi Note 3", y: 4  }
				]
			}
			]
		});
		prodRatChart.render();
		
		var prodOneDetailsChart = new CanvasJS.Chart("prodOneDetailsChart", {
			theme: "theme2",//theme1
			title:{
				text: "iPhone SE"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: [
					{ label: "Members in groups", y: 72  },
					{ label: "Members viewed listing", y: 256  },
					{ label: "Members liked product", y: 157  },
					{ label: "Members joined groups but left", y: 18  },
					{ label: "Items sold", y: 65  }
				]
			}
			]
		});
		prodOneDetailsChart.render();
		
		var prodTwoDetailsChart = new CanvasJS.Chart("prodTwoDetailsChart", {
			theme: "theme2",//theme1
			title:{
				text: "Redmi Note 3"              
			},
			animationEnabled: true,   // change to true
			data: [              
			{
				// Change type to "bar", "area", "spline", "pie",etc.
				type: "column",
				dataPoints: [
					{ label: "Members in groups", y: 132  },
					{ label: "Members viewed listing", y: 331  },
					{ label: "Members liked product", y: 187  },
					{ label: "Members joined groups but left", y: 33  },
					{ label: "Items sold", y: 83  }
				]
			}
			]
		});
		prodTwoDetailsChart.render();
		
	});
	
		
</script>

<div class="wrapper">
	<div class="top-strip">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold">Dashboard</h5>
				<div class="">
					<div class="col-md-12 mr-auto" style="margin-top: 20px;">
						<div class="mainDashboardCls">
							<div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="mercLoginChart" class="chartDivCls"></div>
											</div>
										</div>
										
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="noOfProdChart" class="chartDivCls"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="subHdrCls">Scheme Status</div>
							</div>
							<div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="prodBySchemeStateChart" class="chartDivCls"></div>
											</div>
										</div>
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="schemePendingApproveChart" class="chartDivCls"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="subHdrCls">Transaction Details</div>
							</div>
							<div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="noOfTxnChart" class="chartDivCls"></div>
											</div>
										</div>
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="txnValChart" class="chartDivCls"></div>	
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="subHdrCls">Product Status</div>
							</div>
							<div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="prodOneDetailsChart" class="chartDivCls"></div>
											</div>
										</div>
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="prodTwoDetailsChart" class="chartDivCls"></div>	
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="subHdrCls">Regional Product Sales Status</div>
							</div>
							<div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="prodOneSalesChart" class="chartDivCls"></div>
											</div>
										</div>
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="prodTwoSalesChart" class="chartDivCls"></div>	
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="subHdrCls">Ratings</div>
							</div>
							<div class="row">
								<div class="col-md-12 mr-auto chartMainSubDiv">
									<div class="row">
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="merRatChart" class="chartDivCls"></div>
											</div>
										</div>
										<div class="col-md-6 mr-auto" style="margin-top: 0px;">
											<div class="chartDivMainCls">
												<div id="prodRatChart" class="chartDivCls"></div>	
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
