function loadDelvTableList(data, reportFor, tblId){
	
	if ($.fn.DataTable.isDataTable(tblId) ) {
		$(tblId).DataTable().destroy();
	  	$(tblId).empty();
	}
	
	var userTbl ="";
	userTbl ='<thead><tr>';
	if(reportFor == 1) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Created<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Created<BR>By</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Address</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Travel Distance<BR>(Km)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery Charge<BR>Included in<BR>Package Amount<BR>(Yes/No)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery Amount<BR>to be collected<BR>from the customer<BR>(Including GST)(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Package Amount<BR>to be collected<BR>from the customer<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Total Amount<BR>to be collected<BR>from Customer<BR>[Delivery charges + Package Amount](<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Card Service<BR>Charge<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase/Collection<BR>of Commission<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Vendor Invoice<BR>(Service Charge + GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Credit Amount<BR>To<BR>Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Debit Amount<BR>From<BR>Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
	} else if(reportFor == 2) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>House No.</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>House No.</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
		userTbl += '<th style="min-width: 130px;">Item Pay<BR>Flag</th>';
		userTbl += '<th style="min-width: 130px;">Delivery Charge<BR>Included in<BR>Package Amount<BR>(Yes/No)</th>';
		userTbl += '<th style="min-width: 130px;">Item <BR>Amount<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Excluding GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Discount in %</th>';
		userTbl += '<th style="min-width: 130px;">Card Service<BR>Charge<BR>Exclusive of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">GST Of<BR>Card Service Charge<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Total Card<BR>Charges Inclusive<BR>of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase/Collection<BR>of Commission<BR>Exclusive of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">GST of<BR>Purchase/Collection<BR>of Commission<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase/Collection<BR>of Commission<BR>Inclusive of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Amount<BR>to be collected<BR>from Customer<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">IC/PD<BR>Amount<BR>receivable<BR>(when closing the delivery)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Credit Amount<BR>To<BR>Temp Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Debit Amount<BR>From<BR>Temp Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Credit Amount<BR>To<BR>Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Debit Amount<BR>From<BR>Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Vendor<BR>Invoice (Total)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Service Charged<BR>to be collected<BR>from Vendor<BR>(Invoice - Entry1)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">GST for<BR>Service Charge<BR>to be collected<BR>from Vendor<BR>(Invoice - Entry2)<BR>(<span class="fa fa-inr"></span>)</th>';
	} else if(reportFor == 3) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">First Name</th>';
		userTbl += '<th style="min-width: 130px;">Last Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Address</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Address</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Travel Distance<BR>(Km)</th>';
//		userTbl += '<th style="min-width: 130px;">Delivery Charge<BR>Included in<BR>Package Amount<BR>(Yes/No)</th>';
//		userTbl += '<th style="min-width: 130px;">Delivery Amount<BR>to be collected<BR>from the customer<BR>(Including GST)(<span class="fa fa-inr"></span>)</th>';
//		userTbl += '<th style="min-width: 130px;">Package Amount<BR>to be collected<BR>from the customer<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Total Amount<BR>to be collected<BR>from Customer<BR>[Delivery charges + Package Amount](<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
	} else if(reportFor == 4) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
		userTbl += '<th style="min-width: 130px;">Travel Distance<BR>(Km)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Excluding GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Rider<BR>Commission<BR>of Delivery Charge<BR>(<span class="fa fa-inr"></span>)</th>';
	} else if(reportFor == 5) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
		userTbl += '<th style="min-width: 130px;">Travel Distance<BR>(Km)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Excluding GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Rider<BR>Travel Allowance<BR>(<span class="fa fa-inr"></span>)</th>';
	} else if(reportFor == 6) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>House No.</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>House No.</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
		userTbl += '<th style="min-width: 130px;">Item Pay<BR>Flag</th>';
		userTbl += '<th style="min-width: 130px;">Delivery Charge<BR>Included in<BR>Package Amount<BR>(Yes/No)</th>';
		userTbl += '<th style="min-width: 130px;">Item <BR>Amount<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Excluding GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Discount in %</th>';
		userTbl += '<th style="min-width: 130px;">Card Service<BR>Charge<BR>Exclusive of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">GST Of<BR>Card Service Charge<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Total Card<BR>Charges Inclusive<BR>of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase/Collection<BR>of Commission<BR>Exclusive of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">GST of<BR>Purchase/Collection<BR>of Commission<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase/Collection<BR>of Commission<BR>Inclusive of GST<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Amount<BR>to be collected<BR>from Customer<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">IC/PD<BR>Amount<BR>receivable<BR>(when closing the delivery)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Credit Amount<BR>To<BR>Temp Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Debit Amount<BR>From<BR>Temp Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Credit Amount<BR>To<BR>Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Debit Amount<BR>From<BR>Vendor<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Vendor<BR>Invoice (Total)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Service Charged<BR>to be collected<BR>from Vendor<BR>(Invoice - Entry1)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">GST for<BR>Service Charge<BR>to be collected<BR>from Vendor<BR>(Invoice - Entry2)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Travel Distance<BR>(Km)</th>';
		userTbl += '<th style="min-width: 130px;">Rider<BR>Travel Allowance<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Rider<BR>Commission<BR>of Delivery Charge<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">IC/PD<BR>Margin<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Card Charge<BR>(%)</th>';
		userTbl += '<th style="min-width: 130px;">Card Charge<BR>Gst<BR>(%)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery Charge<BR>Gst<BR>(%)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase<BR>Commission<BR>(%)</th>';
		userTbl += '<th style="min-width: 130px;">Purchase<BR>Commission Gst<BR>(%)</th>';
		userTbl += '<th style="min-width: 130px;">Rider<BR>Commission<BR>(%)</th>';
		userTbl += '<th style="min-width: 130px;">Rider<BR>Allowance<BR>Per Km</th>';
	} else if(reportFor == 7) {
		userTbl += '<th>S.No.</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Deliverer<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Package<BR>Status</th>';
		userTbl += '<th style="min-width: 130px;">Paid By</th>';
		userTbl += '<th style="min-width: 130px;">Delivery Charge<BR>Included in<BR>Package Amount<BR>(Yes/No)</th>';
		userTbl += '<th style="min-width: 130px;">Delivery<BR>Amount<BR>(Including GST)<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Item<BR>Amount<BR>(<span class="fa fa-inr"></span>)</th>';
		userTbl += '<th style="min-width: 130px;">Sender / Vendor<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Branch<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Sender<BR>Address</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Name</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Phone</th>';
		userTbl += '<th style="min-width: 130px;">Receiver<BR>Address</th>';
		userTbl += '<th style="min-width: 130px;">Delivered<BR>Date<BR>(dd-mm-yyyy)</th>';
		userTbl += '<th style="min-width: 130px;">Travel Distance<BR>(Km)</th>';
	}
	userTbl += '</tr></thead>';
	$(tblId).append(userTbl);

	loadDelvTblBody(data, reportFor, tblId);
}

var delvReportTbl;
function loadDelvTblBody(data, reportFor, tblId) {
	if(reportFor == 1) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "senderRequestModel.createdAt",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "senderRequestModel.createdBy"
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},
			{
				"data" : "senderUserModel.vendorName"
			},{
				"data" : "senderRequestModel.recieverName"
			},{
				"data" : "senderRequestModel.recieverHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.recieverAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.recieverContact"
			},{
				"data" : "senderRequestModel.assignedUserModel.firstName"
			},{
				"data" : "senderRequestModel.assignedUserModel.mobileNumber"
			},
			{
				"data" : "riderTravelDistance"
			},{
				"data" : "senderRequestModel.deliveryChargeInclu",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == true) {
						return "<span class='tblcolumnlbl' style='width: 200px;'>Yes</span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>No</span>";
					}
				}
			},{
				"data" : "deliveryChargeIncluGst"
			},{
				"data" : "senderRequestModel.itemPayAmount",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == undefined || data == 'undefined' || data == '') {
						return "<span class='tblcolumnlbl' style='width: 200px;'></span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>"+data+"</span>";
					}
				}
			},{
				"data" : "collectCustomerAmount"
			},{
				"data" : "cardServiceCharges"
			},{
				"data" : "purchaseCommission"
			},{
				"data" : "vendorInvoiceAmount"
			},{
				"data" : "vendorCreditAmount"
			},{
				"data" : "vendorDebitAmount"
			},{
				"data" : "senderRequestModel.codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.senderRequestModel.noPayFlag == true) {
				    		if(row.vendorBillingCycleModel != null && row.vendorBillingCycleModel.payCompleteFlag == true) {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Received from Vendor</span>";
							} else {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
							}
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	} else if(reportFor == 2) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "senderRequestModel.assignedUserModel.firstName"
			},{
				"data" : "senderRequestModel.assignedUserModel.mobileNumber"
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},{
				"data" : "senderUserModel.vendorName"
			},{
				"data" : "senderRequestModel.pickUpHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.packagePickupAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.senderPhoneNumber"
			},{
				"data" : "senderRequestModel.recieverName"
			},{
				"data" : "senderRequestModel.recieverHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.recieverAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.recieverContact"
			},{
				"data" : "senderRequestModel.codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.senderRequestModel.noPayFlag == true) {
				    		if(row.vendorBillingCycleModel != null && row.vendorBillingCycleModel.payCompleteFlag == true) {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Received from Vendor</span>";
							} else {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
							}
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			},{
				"data" : "senderRequestModel.itemPayFlag"
			},{
				"data" : "senderRequestModel.deliveryChargeInclu"
			},{
				"data" : "senderRequestModel.itemPayAmount",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == undefined || data == 'undefined' || data == '') {
						return "<span class='tblcolumnlbl' style='width: 200px;'></span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>"+data+"</span>";
					}
				}
			},{
				"data" : "deliveryChargeIncluGst"
			},{
				"data" : "deliveryChargeExcluGst"
			},{
				"data" : "deliveryGst"
			},{
				"data" : "deliveryDiscount"
			},{
				"data" : "cardServChrgExclGst"
			},{
				"data" : "cardServChrgGst"
			},{
				"data" : "cardServiceCharges"
			},{
				"data" : "purchaseCommisExclGst"
			},{
				"data" : "purchaseCommisGst"
			},{
				"data" : "purchaseCommission"
			},{
				"data" : "collectCustomerAmount"
			},{
				"data" : "pdReceivableAmount"
			},{
				"data" : "",
				"render" : function(data, type, row) {
					if(type === "sort" || type === "type") return 0;
				    return 0;
				}
			},{
				"data" : "",
				"render" : function(data, type, row) {
					if(type === "sort" || type === "type") return 0;
				    return 0;
				}
			},{
				"data" : "vendorCreditAmount"
			},{
				"data" : "vendorDebitAmount"
			},{
				"data" : "vendorInvoiceAmount"
			},{
				"data" : "vendorServChrge"
			},{
				"data" : "vendorServChrgeGst"
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	} else if(reportFor == 3) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "senderUserModel.firstName"
			},{
				"data" : "senderUserModel.lastName"
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					} else {
						senderName = '';
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},{
				"data" : "senderUserModel.vendorName"
			},{
				"data" : "senderRequestModel.pickUpHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.packagePickupAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.senderPhoneNumber"
			},{
				"data" : "senderRequestModel.recieverName"
			},{
				"data" : "senderRequestModel.recieverHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.recieverAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.recieverContact"
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "senderRequestModel.distance"
			}/*,{
				"data" : "senderRequestModel.deliveryChargeInclu",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == true) {
						return "<span class='tblcolumnlbl' style='width: 200px;'>Yes</span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>No</span>";
					}
				}
			},{
				"data" : "deliveryChargeIncluGst"
			},{
				"data" : "senderRequestModel.itemPayAmount",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == undefined || data == 'undefined' || data == '') {
						return "<span class='tblcolumnlbl' style='width: 200px;'></span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>"+data+"</span>";
					}
				}
			}*/,{
				"data" : "collectCustomerAmount"
			},{
				"data" : "senderRequestModel.codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.senderRequestModel.noPayFlag == true) {
				    		if(row.vendorBillingCycleModel != null && row.vendorBillingCycleModel.payCompleteFlag == true) {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Received from Vendor</span>";
							} else {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
							}
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	} else if(reportFor == 4) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},{
				"data" : "senderRequestModel.vendorName"
			},{
				"data" : "senderRequestModel.senderPhoneNumber"
			},{
				"data" : "senderRequestModel.recieverName"
			},{
				"data" : "senderRequestModel.recieverContact"
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "senderRequestModel.codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.senderRequestModel.noPayFlag == true) {
				    		if(row.vendorBillingCycleModel != null && row.vendorBillingCycleModel.payCompleteFlag == true) {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Received from Vendor</span>";
							} else {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
							}
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			},{
				"data" : "riderTravelDistance"
			},{
				"data" : "deliveryChargeIncluGst"
			},{
				"data" : "deliveryChargeExcluGst"
			},{
				"data" : "riderCommission"
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	} else if(reportFor == 5) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},{
				"data" : "senderRequestModel.vendorName"
			},{
				"data" : "senderRequestModel.senderPhoneNumber"
			},{
				"data" : "senderRequestModel.recieverName"
			},{
				"data" : "senderRequestModel.recieverContact"
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "senderRequestModel.codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.senderRequestModel.noPayFlag == true) {
				    		if(row.vendorBillingCycleModel != null && row.vendorBillingCycleModel.payCompleteFlag == true) {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Received from Vendor</span>";
							} else {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
							}
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			},{
				"data" : "riderTravelDistance"
			},{
				"data" : "deliveryChargeIncluGst"
			},{
				"data" : "deliveryChargeExcluGst"
			},{
				"data" : "riderTravelAllowance"
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	} else if(reportFor == 6) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "senderRequestModel.assignedUserModel.firstName"
			},{
				"data" : "senderRequestModel.assignedUserModel.mobileNumber"
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},{
				"data" : "senderUserModel.vendorName"
			},{
				"data" : "senderRequestModel.pickUpHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.packagePickupAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.senderPhoneNumber"
			},{
				"data" : "senderRequestModel.recieverName"
			},{
				"data" : "senderRequestModel.recieverHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.senderRequestModel.recieverAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "senderRequestModel.recieverContact"
			},{
				"data" : "senderRequestModel.codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.senderRequestModel.noPayFlag == true) {
				    		if(row.vendorBillingCycleModel != null && row.vendorBillingCycleModel.payCompleteFlag == true) {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Received from Vendor</span>";
							} else {
								return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
							}
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			},{
				"data" : "senderRequestModel.itemPayFlag"
			},{
				"data" : "senderRequestModel.deliveryChargeInclu"
			},{
				"data" : "senderRequestModel.itemPayAmount",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == undefined || data == 'undefined' || data == '') {
						return "<span class='tblcolumnlbl' style='width: 200px;'></span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>"+data+"</span>";
					}
				}
			},{
				"data" : "deliveryChargeIncluGst"
			},{
				"data" : "deliveryChargeExcluGst"
			},{
				"data" : "deliveryGst"
			},{
				"data" : "deliveryDiscount"
			},{
				"data" : "cardServChrgExclGst"
			},{
				"data" : "cardServChrgGst"
			},{
				"data" : "cardServiceCharges"
			},{
				"data" : "purchaseCommisExclGst"
			},{
				"data" : "purchaseCommisGst"
			},{
				"data" : "purchaseCommission"
			},{
				"data" : "collectCustomerAmount"
			},{
				"data" : "pdReceivableAmount"
			},{
				"data" : "",
				"render" : function(data, type, row) {
					if(type === "sort" || type === "type") return 0;
				    return 0;
				}
			},{
				"data" : "",
				"render" : function(data, type, row) {
					if(type === "sort" || type === "type") return 0;
				    return 0;
				}
			},{
				"data" : "vendorCreditAmount"
			},{
				"data" : "vendorDebitAmount"
			},{
				"data" : "vendorInvoiceAmount"
			},{
				"data" : "vendorServChrge"
			},{
				"data" : "vendorServChrgeGst"
			},{
				"data" : "riderTravelDistance"
			},{
				"data" : "riderTravelAllowance"
			},{
				"data" : "riderCommission"
			},{
				"data" : "pdMargin"
			},{
				"data" : "cardChargePerc"
			},{
				"data" : "cardChargeGstPerc"
			},{
				"data" : "delvChargeGstPerc"
			},{
				"data" : "purcCmsnPerc"
			},{
				"data" : "purcCmsnGstPerc"
			},{
				"data" : "riderCmsnPerc"
			},{
				"data" : "riderAllowancePerKm"
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	} else if(reportFor == 7) {
		delvReportTbl = $(tblId).DataTable({
			"data" : data,
			"autoWidth": false,
			"oLanguage" : {
				"sEmptyTable" : "No Data Available"
			},
			"order" : [ [ 0, "asc" ] ],
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
				"data" : "",
				"render" : function(data, type, row, meta) {
					var rowIdx = meta.row + meta.settings._iDisplayStart + 1;
					if(rowIdx == null)rowIdx = ""; if(type === "sort" || type === "type") return rowIdx;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + rowIdx + "</span>";
				}
			},{
				"data" : "delivererName",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "assignedToPhoneNumber",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "packageStatus",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "codFlag",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    if(data == true) {
				    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>COD</span>";
				    } else {
				    	if(row.noPayFlag == true) {
							return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Yet to collect from Vendor</span>";
					    } else {
					    	return "<span class='tblcolumnlbl' style='white-space: nowrap;'>Online</span>";
					    }
				    }
				}
			},{
				"data" : "deliveryChargeInclu",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == true) {
						return "<span class='tblcolumnlbl' style='width: 200px;'>Yes</span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>No</span>";
					}
				}
			},{
				"data" : "amount",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "itemPayAmount",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					if(data == undefined || data == 'undefined' || data == '') {
						return "<span class='tblcolumnlbl' style='width: 200px;'></span>";
					} else {
						return "<span class='tblcolumnlbl' style='width: 200px;'>"+data+"</span>";
					}
				}
			},{
				"data" : "senderUserModel",
				"render" : function(data, type, row) {
				    var senderName = "";
					if(data != null && data.firstName != null) {
						senderName = data.firstName;
					}
					if(data != null && data.lastName != null) {
						if(senderName != '')
							senderName += ' ';
						senderName += data.lastName;
					}
					
					if(data.vendorFlag == true) {
						senderName = data.vendorGroupName;
					}
					
					if(type === "sort" || type === "type") return senderName;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + senderName + "</span>";
				}
			},{
				"data" : "senderUserModel.vendorName",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "senderPhone",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "pickUpHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.packagePickupAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "recieverName",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "recieverContact",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			},{
				"data" : "recieverHouseNo",
				"render" : function(data, type, row) {
					if(data == null)data = ""; if(type === "sort" || type === "type") return data;
					return "<span class='tblcolumnlbl addrTblCls' style='width: 200px;'>" + row.recieverAddress + "<BR><BR><strong>Landmark: </strong>" + data + "</span>";
				}
			},{
				"data" : "deliveredDate",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    var datestring = '';
				    if(data != '') {
				    	var d = new Date(data);
					    datestring = prefixPattern(d.getDate()+"", 2, "0") + "-" + prefixPattern((d.getMonth()+1)+"", 2, "0") + "-" + d.getFullYear();
				    }
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>" + datestring + "</span>";
				}
			},{
				"data" : "distance",
				"render" : function(data, type, row) {
				    if(data == null)data = ""; if(type === "sort" || type === "type") return data;
				    return "<span class='tblcolumnlbl' style='white-space: nowrap;'>"+data+"</span>";
				}
			}],
			"pageLength" : 5,
			"lengthMenu" : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ]
		});
	}
	
	delvReportTbl.on('draw', function () {
		var body = $(delvReportTbl.table().body());
		body.unhighlight();
		body.highlight(delvReportTbl.search());  
	});
}

function prefixPattern(val, maxNum, prefixVal) {
	if(maxNum > val.length) {
		for(var i = 0; i < (maxNum - val.length); i++) {
			val = prefixVal + val;
		}
	}
	return val;
}