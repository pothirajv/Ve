
$(document).ready(function(){
	var contextPath=$("#contextPath").val();
	
	
	//$("#senderdetailsTbl").DataTable();
	//getVendorNameList();
	getVendorList();
//	   getVendorBranchList();
	//searchBtnFunc();
	datePickFn();
	reportGenerateFn();
	$('.branchdivCls').hide();
	
	$(".rad_periodSelect_cls").click(function(){
		if($(this).val()=="d") {
			$(".dateSearch").attr("disabled",false);
			$(".monthSearch").attr("disabled",true);
			$(".monthSearch").val("");
			
			$(".dateSearch").addClass('required');
			$(".monthSearch").removeClass('required');
			
			$('.periodMonthLblCls').removeClass('required-label');
			$('.periodDayLblCls').addClass('required-label');
		} else if($(this).val()=="m") {
			$(".dateSearch").attr("disabled",true);
			$(".monthSearch").attr("disabled",false);
			$(".dateSearch").val("");
			
			$(".monthSearch").addClass('required');
			$(".dateSearch").removeClass('required');
			
			$('.periodDayLblCls').removeClass('required-label');
			$('.periodMonthLblCls').addClass('required-label');
		}
	});
	
	$(document.body).on('change', '#sel_vendor_id', function() {
		getVendorBranchList($(this).val());
	});
	
});

function datePickFn(){
	
	$(".dateSearch").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	$(".mnth_datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'MM yy',
        onClose: function(dateText, inst) { 
            $(this).datepicker('setDate', new Date(inst.selectedYear, inst.selectedMonth, 1));
        }		
	});
	
	$(".mnth_datepicker").focus(function () {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });
    });
}

function reportGenerateFn(){
	
	$("#btn_reportGenBtn_id").click(function(){
		$('.validation').html('');
		var flag = true;
		$(".required").each(
			function(index) {
				if ($(this).val() === null || $(this).val() === "") {
					$(this).parent().find("div").addClass("showVal");
					$(this).parent().find("div").html("This field is mandatory");
					flag = false;
				} else {
					$(this).parent().find("div").removeClass("showVal");
					$(this).parent().find("div").html("");
				}
			}
		);
		
		if (flag == false) {
			return false;
		} else {
			var vendorGroupName=$("#sel_vendor_id").val();
			var userId=$("#sel_vendorBranch_id").val();
			var searchFromdate,searchTodate;
			if($("input[name='periodSelect']:checked").val()=="d"){
				 searchFromdate =$("#from_date_id").val();
				 searchTodate =$("#to_date_id").val();
			}else{
				var date,month,year;
				 var selectDate = new Date($(".mnth_datepicker").val());
				
				 month =selectDate.getMonth();
				 year = selectDate.getFullYear();
				
				 firstDay = new Date(year, month, 1);
		         lastDay = new Date(year, month + 1, 0);
		        
		         date = firstDay.getDate();
		         month = firstDay.getMonth()+1;
		         year =  firstDay.getFullYear();
		         
		          searchFromdate =year + '-' + month + '-' + date;
		        
		         date = lastDay.getDate();
		         month = lastDay.getMonth()+1;
		         year =  lastDay.getFullYear();
		         
		          searchTodate =year + '-' + month + '-' + date;
		         
			}
			
			if(userId == undefined || userId == '' || userId == null) {
				userId = '';
			}
			if(vendorGroupName == undefined || vendorGroupName == '' || vendorGroupName == null) {
				vendorGroupName = '';
			}
			
			window.location =$("#contextPath").val()+'/api/v1/venreportgen?vendorGroupName='+vendorGroupName.toString()+'&vendorId='+userId.toString()+'&searchFromdate='+searchFromdate.toString()+'&searchTodate='+searchTodate.toString();
		}
	});
}

function getVendorList(){
	$.ajax({
		url : $("#contextPath").val()+'/api/v1/venl',
		type : 'POST',
		success:function(data){
			var opt="";
			if(data.vendorNameList.length > 1) {
				opt="<option value=''>All</option>";
			}
			
			$.each(data.vendorNameList,function(i,val){
				opt+="<option value='"+val+"'>"+val+"</option>";
			});
			$("#sel_vendor_id").append(opt);
			
			getVendorBranchList($("#sel_vendor_id").val());
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

function getVendorBranchList(vendorName){
	$("#sel_vendorBranch_id").html('');
	
	if(vendorName == null || vendorName == undefined || vendorName == '') {
		$('.branchdivCls').hide();
		return;
	}
	var vendorDto = new Object();
	vendorDto.vendorName = vendorName;
	$.ajax({
		url : $("#contextPath").val()+'/api/v1/venbl',
		contentType : "application/json",
		type : 'POST',
		data : JSON.stringify(vendorDto),
		success:function(data){
			var opt="";
			if(data.vendorBranchDetailsList.length > 1) {
				opt="<option value=''>All</option>";
			}
			
			$.each(data.vendorBranchDetailsList,function(i,val){
				opt+="<option value='"+val.userId+"'>"+val.branchName+"</option>";
			});
			$("#sel_vendorBranch_id").append(opt);
			
			$('.branchdivCls').show();
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        alert("Status: " + textStatus);
	    }
	});
}

