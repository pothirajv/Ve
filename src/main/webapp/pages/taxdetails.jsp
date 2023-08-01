<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet">
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript"
	src="<%=request.getContextPath() %>/js/taxdetails.js"></script>

</head>
<body>
	<div class="wrapper">
		<div class="top-strip">
			<!-- contact section -->
			<section class="layout_padding">
			<div class="container">

				<h5 class="font-weight-bold">
					<span>Tax Details</span>
				</h5>

				<div class="row">
					<div class="col-md-4">
						<div class="radio">
							<input id="roleSel_ven" type="radio" name="roleSelect"
								class="rad_roleSelect_cls" value="v" checked="checked">
							<label for="roleSel_ven" class="radio-label">Vendor</label>
						</div>
					</div>

					<div class="col-md-4">
						<div class="radio">
							<input id="roleSel_del" type="radio" name="roleSelect"
								class="rad_roleSelect_cls" value="d"> <label
								for="roleSel_del" class="radio-label">Deliverer</label>
						</div>
					</div>

					<div class="col-md-4">
						<div class="radio">
							<input id="roleSel_sen" type="radio" name="roleSelect"
								class="rad_roleSelect_cls" value="s"> <label
								for="roleSel_sen" class="radio-label">Sender</label>
						</div>
					</div>
				</div>



				<div class="row">
					<div class="col-md-12">
						<button class="btn btn-primary" id="admin_search">
							<span class="fa fa-search btn-icon"></span> Search
						</button>
					</div>
				</div>
				<br>

				<div class="row dateCls" style="display: none;">

					<div class="col-md-4">
						<label>From Date</label><br> <input type="text"
							class="dateSearch" id="from_date_id" placeholder="Ex. YYYY-MM-DD">
						<div class="validation"></div>
					</div>

					<div class="col-md-4">
						<label>To Date</label><br> <input type="text"
							class="dateSearch" id="to_date_id" placeholder="Ex. YYYY-MM-DD">
						<div class="validation"></div>
					</div>

				</div>
				<br>

				<div class="row generateDivCls" style="display: none;">
					<div class="col-md-4">
						<button class="btn btn-primary viewdelivercls">
							<span class="fa fa-user btn-icon"></span> View Details
						</button>
					</div>
					<div class="col-md-4">
						<button class="btn btn-primary generateExcel">
							<span class="fa fa-file-excel-o btn-icon"></span> Generate Excel
						</button>
					</div>
					<div class="col-md-4">
						<button class="btn btn-primary generatePDF">
							<span class="fa fa-file-pdf-o btn-icon"></span> Generate Invoice
						</button>
					</div>
				</div>
				<br>

				<div class="row">
					<div class="col-md-12 table-responsive">
						<table id="userManagementTbl"
							class="table table-striped table-bordered dataTable no-footer">
						</table>
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
</body>
</html>