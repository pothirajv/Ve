<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/vendorreport.js"></script>

<div class="wrapper">
	<div class="top-strip">
		<!-- contact section -->
		<section class="layout_padding">
			<div class="container">
				<h5 class="font-weight-bold">Vendor Report Generate</h5>
				<div class="row">
					<div class="col-md-12 mr-auto" style="margin-top: 20px;">
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
										<label for="pickdrop" class="periodDayLblCls required-label">From</label><br> 
										<input type="text" class="dateSearch required" id="from_date_id"> 
										<div class="validation"></div>
									</div>
									<div class="col-md-6 form-group">
										<label for="pickdrop" class="periodDayLblCls required-label">To Date</label><br> 
										<input type="text" class="dateSearch required" id="to_date_id">
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
										<input name="startDate" id="startDate" class="mnth_datepicker monthSearch" disabled>
										<div class="validation"></div>
									</div>
								</div>
							</div>
							
							<div class="col-md-3 mr-auto form-group">
								<label for="pickdrop" class="">Vendor Name</label><br> 
								
								<% if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_ADMIN")) { %>
									<select id="sel_vendor_id" style="overflow: hidden"></select>
								<%} else { %>
									<select id="sel_vendor_id" style="overflow: hidden" disabled="disabled"></select>
								<%} %>
							</div>
							
							<div class="col-md-3 mr-auto form-group branchdivCls" style="display: none;">
								<label for="pickdrop" class="">Vendor Branch</label><br> 
								<select id="sel_vendorBranch_id" style="overflow: hidden" class=""></select>
								<div class="validation"></div>
							</div>
							
							<div class="col-md-6 mr-auto"></div>
							
							<div class="col-md-12 mr-auto" style="margin-top: 0px;">
								<button class="btn btn-primary" id="btn_reportGenBtn_id">Report Generate</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>
