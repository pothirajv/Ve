<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/paymentdetails.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/delvtbl.js"></script>

<style>

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

</style>

</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
			<div class="container">
				<div class="srchMainCls">
					<div class="row formcls srchCls" style="margin-top: 0px;">
						<div class="col-md-12 mr-auto">
							<h5 class="font-weight-bold">
								<span>Settlement To Vendor</span>
							</h5>
						</div>
						<div class="col-md-12 mr-auto" style="margin-top: 20px;">
							<div class="row">
								<div class="col-md-6" style="display: none;">
									<div class="row">
										<div class="col-md-12">
											<div class="radio">
												<input id="radio-1" type="radio" name="periodSelect" class="rad_periodSelect_cls" value="d" checked="checked">
												<label for="radio-1" class="radio-label hdrLblCls">Search By Date</label>
											</div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodDayLblCls hdrLblCls">From</label><br> 
											<input type="text" class="dateSearch" id="from_date_id" placeholder="Ex. YYYY-MM-DD"> 
											<div class="validation"></div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodDayLblCls hdrLblCls">To Date</label><br> 
											<input type="text" class="dateSearch" id="to_date_id" placeholder="Ex. YYYY-MM-DD">
											<div class="validation"></div>
										</div>
									</div>
								</div>
								
								<div class="col-md-6" style="display: none;">
									<div class="row">
										<div class="col-md-12">
											<div class="radio">
												<input id="radio-2" type="radio" name="periodSelect" class="rad_periodSelect_cls" value="m">
												<label for="radio-2" class="radio-label hdrLblCls">Search By Month</label>
											</div>
										</div>
										<div class="col-md-6 form-group">
											<label for="pickdrop" class="periodMonthLblCls hdrLblCls">Month</label><br> 
											<input name="startDate" id="startDate" class="mnth_datepicker monthSearch" placeholder="Ex. May 2020" disabled>
											<div class="validation"></div>
										</div>
									</div>
								</div>
								
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Billing Status</label><br> 
									<select id="billCyclePend">
										<option value="2">Show All</option>
										<option value="1" selected="selected">Show Pending</option>
									</select>
								</div>
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls">Location</label><br> 
									<select id="locSelCls">
										<option value="">All Location</option>
										<c:forEach items="${allowedLocation}" var="allowedLoc">
											<option value="${allowedLoc}">${allowedLoc}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-3 form-group" style="display: none;">
									<label for="pickdrop" class="hdrLblCls">Role Name</label><br> 
									<select id="rad_roleSelect_cls">
										<option value="ROLE_VENDOR">Vendor</option>
										<!-- <option value="ROLE_DELIVER">Deliverer</option> -->
									</select>
								</div>
								<div class="col-md-3 form-group">
									<label for="pickdrop" class="hdrLblCls nameLblCls required-label">Vendor Name</label><br> 
									<select id="userNameSrchSel"></select>
								</div>
								<div class="col-md-2 form-group">
									<label for="pickdrop" class="hdrLblCls nameLblCls required-label">Branch Name</label><br> 
									<select id="branchSrchSel"></select>
								</div>
								<div class="col-md-3 form-group1">
									<label for="pickdrop" class="hdrLblCls required-label">Billing Cycle</label><br> 
									<select id="billingCycle" disabled="disabled">
										<option value="">No Billing Cycle</option>
									</select>
								</div>
								<!-- <div class="col-md-12"></div>
			
								<div class="col-md-12">
									<button class="btn btn-primary" id="admin_search">
										<span class="fa fa-search btn-icon"></span> Search</button>
								</div> -->
							</div>
						</div>
					</div>
					
					<div class="row mainContentCls" style="margin-top: 30px; display: none;">
						<div class="col-md-12">
							<div id="tableDiv21" class="">
								<table id="mainListTbl"
									class="table table-striped table-bordered dataTable no-footer">
								</table>
							</div>
						</div>
					</div>
				</div>
				
				<div class="mainContentCls1" style="margin-top: 10px; display: none;">
					<div class="col-md-12 row mr-auto">
						<h5 class="font-weight-bold" style="color: #e91e63;">
							<input type="hidden" id="roleNmFrm">
							<input type="hidden" id="employeeFlag">
							<span id="userNameFrm"></span><label id="roleNameFrm" style="display: none;"></label>
						</h5>
					</div>
					
					<div style="margin-top: 10px; display: none;">
						<label for="pickdrop" class="hdrLblCls" style="color: #007bff;">Billing Cycle</label><br> 
						<select id="billCycleFrm" class="customSelect"></select>
					</div>
					
					<div class="row formcls">
						<div class="col-md-12 form-group">
							<table class="defTbl" style="">
								<tr>
									<td style="width: 180px;">
										<label for="pickdrop" class="hdrLblCls">Total Deliveries</label><br> 
										<label id="totDelvHdr">0</label>
									</td>
									<td style="display: none;">
										<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls">Total Package Amount</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
										<label id="totItemAmntHdr">0</label>
									</td>
									<td style="display: none;">
										<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totGstLbl">Total Delivery Amount</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
										<label id="totDelvChargeHdr">0</label>
									</td>
									<td style="display: none;">
										<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totServChrgLbl">Total Service Charge</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
										<label id="totChargeHdr">0</label>
									</td>
									<td style="width: 220px;">
										<span style="font-weight: bold;"><label for="pickdrop" class="hdrLblCls totAmntLbl">Total Amount To Pay</label> (<span class="fa fa-inr inrCls"></span>)</span><br> 
										<label id="totAmntHdr"></label>
									</td>
								</tr>
							</table>
						</div>
						<div class="col-md-12"></div>
					</div>
					
					<div class="mainContentCls1" style="margin-top: 20px;">
						<div class="row payFormCls">
							<div class="col-md-12 form-group" style="margin-top: 10px; margin-bottom: 0px;">
								<h6 style="font-weight: bold; float: left;">Payment Info</h6>
							</div>
						</div>
						
						<div class="row formcls payFormCls">
							<div class="col-md-12 form-group" style="margin-top: 10px; margin-bottom: 0px;">
								<div class="row formcls">
									<div class="col-md-3 form-group" style="display: none;">
										<label for="pickdrop" class="hdrLblCls">Balance Amount To Pay (<span class="fa fa-inr inrCls"></span>)</label><br> 
										<input type="text" id="amntToPay" disabled="disabled">
										<input type="hidden" id="totAmntFrmHdn">
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls amntPaidReceiveCls required-label">Amount Paid</label><br> 
										<input type="text" id="paidAmnt" disabled="disabled">
									</div>
									<div class="col-md-3 form-group" style="display: none;">
										<label for="pickdrop" class="hdrLblCls required-label">Payment Type</label><br> 
										<select id="paymentType">
											<option value="1">Payment Sent</option>
											<option value="2">Payment Received</option>
										</select>
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls required-label">Paid On</label><br> 
										<input type="text" id="paidOn">
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls required-label">Invoice Date</label><br> 
										<input type="text" id="invoiceDt1">
										<input type="hidden" id="invoiceDtHdn">
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls required-label">Invoice No.</label><br> 
										<input type="text" id="invoiceNm1">
										<input type="hidden" id="invoiceNmHdn">
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls required-label">Payment Reference No.</label><br> 
										<input type="text" id="refNo">
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls">Payment Remarks</label><br> 
										<input type="text" id="payRemarks">
<!-- 										<textarea id="payRemarks" rows="50" style="width: 100%"></textarea> -->
									</div>
								</div>
							</div>
						</div>
						
						<div class="row formcls invFormCls">
							<div class="col-md-12 form-group" style="margin-top: 20px; margin-bottom: 0px;">
								<div class="row formcls">
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls">Invoice Date</label><br> 
										<input type="text" id="invoiceDt">
									</div>
									<div class="col-md-3 form-group">
										<label for="pickdrop" class="hdrLblCls">Invoice No.</label><br> 
										<input type="text" id="invoiceNm">
									</div>
								</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-12 table-responsive" style="margin-top: 10px;">
								<div class="prevBillErrCls">Complete previous billing payment(s)</div>
								<button class="btn btn-primary saveBtn saveTempBtn1">Pay</button>
								<button class="btn btn-primary cancelbtn" style="margin-right: 20px;">Cancel</button>
								<button class="btn btn-primary generatePDF"  style="display: none; margin-left: 20px;background: #E91E63;border-color: #E91E63;">
									<span class="fa fa-file-pdf-o btn-icon"></span> Download Invoice
								</button>
								<input type="hidden" id="payFlag">
								
								<button class="btn btn-primary showDelvTblCls" style="background: #ffffff;border-color: #007bff;color: #007bff;">View All Deliveries</button>
								<button class="btn btn-primary generateExcel" style="background: #ffffff;border-color: #007bff;color: #007bff;">
									<span class="fa fa-file-excel-o btn-icon"></span> Download Deliveries
								</button>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-12" style="margin-top: 20px; margin-bottom: 0px;">
								<!-- <div class="" style="margin-top: 10px;margin-bottom: 10px;">
									<span class="showDelvTblCls" style="text-decoration: underline;color: blue;cursor: pointer;">View All Deliveries
										<span class="fa fa-angle-down"></span>
									</span>
								</div> -->
								
								<div id="tableDiv1" class="" style="display: none;">
									<table id="deliveryDtlsTbl" class="table table-striped table-bordered dataTable no-footer"></table>
								</div>
							</div>
								
							<div class="col-md-12" style="display: none;">
								<div class="" style="margin-top: 10px;margin-bottom: 10px;">
									<span class="showHistoryCls" style="text-decoration: underline;color: blue;cursor: pointer;">Settlement History 
										<span class="fa fa-angle-down"></span>
									</span>
								</div>
								<div id="tableDiv2" class="" style="display: none;">
									<table id="payHistryTbl" class="table table-striped table-bordered dataTable no-footer"></table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</section>
		</div>

	</div>


	<!-- 	MODEL -->

	<div id="userModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="loadCls"></div>
				<div class="modal-header">
					<h5 class="modal-title">User Information</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="delvdetlsdivcls" style="font-size: 0.8rem;">
						<div id="errormsg"></div>
						<div class="form-group">
							<h6 class="delvHdrCls">User Address</h6>
							<span class="addrsDtlsCls"></span>
						</div>
						<!-- 						<div class="form-group"> -->
						<!-- 							<h6 class="delvHdrCls">Drop Address</h6> -->
						<!-- 							<span class="dropDtlsCls"></span> -->
						<!-- 						</div> -->
						<div class="form-group">
							<h6 class="delvHdrCls">Bank Details</h6>
							<span class="bankDtlsCls"></span>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<div id="branchMainCls"></div>
	<input type="hidden" id="currFromDate">
	<input type="hidden" id="currToDate">
	<input type="hidden" id="receivedUserId">
</body>
</html>