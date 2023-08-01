<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<style>
.sidebar-wrapper .sidebar-menu ul li a i {
    font-size: 0.8rem !important;
}
.sidebar-wrapper .sidebar-menu ul li a {
    font-size: 0.9rem;
    padding: 8px 5px 8px 15px !important;
}
.chiller-theme .sidebar-wrapper .sidebar-header .user-info .user-role, .chiller-theme .sidebar-wrapper .sidebar-header .user-info .user-status, .chiller-theme .sidebar-wrapper .sidebar-search input.search-menu, .chiller-theme .sidebar-wrapper .sidebar-search .input-group-text, .chiller-theme .sidebar-wrapper .sidebar-brand>a, .chiller-theme .sidebar-wrapper .sidebar-menu ul li a, .chiller-theme .sidebar-footer>a {
    color: #dfdfdf;
}
.chiller-theme .sidebar-wrapper .sidebar-menu ul li:hover>a, .chiller-theme .sidebar-wrapper .sidebar-menu .sidebar-dropdown.active>a, .chiller-theme .sidebar-wrapper .sidebar-header .user-info, .chiller-theme .sidebar-wrapper .sidebar-brand>a:hover, .chiller-theme .sidebar-footer>a:hover i {
    color: #ffffff;
}
.sidebar-wrapper .sidebar-menu .sidebar-dropdown .sidebar-submenu li {
    padding-left: 15px;
}
.chiller-theme .sidebar-wrapper ul li:hover a i, .chiller-theme .sidebar-wrapper .sidebar-dropdown .sidebar-submenu li a:hover:before, .chiller-theme .sidebar-wrapper .sidebar-search input.search-menu:focus+span, .chiller-theme .sidebar-wrapper .sidebar-menu .sidebar-dropdown.active a i {
    color: #ffffff;
    text-shadow: 0px 0px 10px #ffffff;
}
/* .sidebar-submenu a {
    color: #808080 !important;
}
.chiller-theme .sidebar-wrapper ul li:hover a i, .chiller-theme .sidebar-wrapper .sidebar-dropdown .sidebar-submenu li a:hover:before, .chiller-theme .sidebar-wrapper .sidebar-search input.search-menu:focus+span, .chiller-theme .sidebar-wrapper .sidebar-menu .sidebar-dropdown.active a i {
	color: #e91e63;
    text-shadow: 0px 0px 10px rgb(233 30 99 / 50%);
}
.page-wrapper.toggled .sidebar-wrapper {
    box-shadow: 2px 0px 4px #c7c0c0;
}
.chiller-theme .sidebar-wrapper .sidebar-menu ul li:hover>a, .chiller-theme .sidebar-wrapper .sidebar-menu .sidebar-dropdown.active>a, .chiller-theme .sidebar-wrapper .sidebar-header .user-info1, .chiller-theme .sidebar-wrapper .sidebar-brand>a:hover, .chiller-theme .sidebar-footer>a:hover i {
    color: #e91e63;
}
.chiller-theme .sidebar-wrapper .sidebar-menu ul li a i, .chiller-theme .sidebar-wrapper .sidebar-menu .sidebar-dropdown div, .chiller-theme .sidebar-wrapper .sidebar-search input.search-menu, .chiller-theme .sidebar-wrapper .sidebar-search .input-group-text {
    background: #ffffff !important;
}
.chiller-theme .sidebar-wrapper .sidebar-header, .chiller-theme .sidebar-wrapper .sidebar-search, .chiller-theme .sidebar-wrapper .sidebar-menu {
    border-top: 1px solid #f9f9f9;
}
.sidebar-header {
    background: #fbfbfb;
}
.chiller-theme .sidebar-wrapper {
    background: #ffffff;
}
.chiller-theme .sidebar-wrapper .sidebar-menu ul li a i, .chiller-theme .sidebar-wrapper .sidebar-menu .sidebar-dropdown div, .chiller-theme .sidebar-wrapper .sidebar-search input.search-menu, .chiller-theme .sidebar-wrapper .sidebar-search .input-group-text {
    background: #efefef;
}
.chiller-theme .sidebar-wrapper .sidebar-header .user-info .user-role1, .chiller-theme .sidebar-wrapper .sidebar-header .user-info .user-status, .chiller-theme .sidebar-wrapper .sidebar-search input.search-menu, .chiller-theme .sidebar-wrapper .sidebar-search .input-group-text, .chiller-theme .sidebar-wrapper .sidebar-brand>a, .chiller-theme .sidebar-wrapper .sidebar-menu ul li a, .chiller-theme .sidebar-footer>a {
    color: #e91e63;
} */
.container {
    padding: 0 20px !important;
    max-width: 100%;
}
.page-wrapper .page-content > div {
    padding: 0px 0px
}
.sidebar-wrapper .sidebar-header .user-pic {
	width: auto;
}
.sidebar-wrapper .sidebar-header .user-pic {
    font-size: 2rem;
    color: #b8bfce;
}
#show-sidebar {
    position: fixed;
    left: 0;
    top: 7px;
    border-radius: 0 4px 4px 0px;
    width: 35px;
    transition-delay: 0.3s;
    padding: 7px 0px;
}
#show-sidebar .fas {
	font-size: 1.1rem;
}
.sidebar-brand a, .sidebar-brand a:hover {
	background-color: transparent;
	padding: 0;
}
.sidebar-menu a, .sidebar-menu a:hover {
	background-color: transparent;
}
.finalDivCls {
	display: none;
}
.switchLoginNoHdrCls {
	background: #ff5722 !important;
}
.switchLoginCls {
    font-size: 12px;
    cursor: pointer;
    color: #ffffff;
    width: 30px;
    height: 30px;
    line-height: 30px;
    background: #ff5722;
    border-radius: 20px;
    position: relative;
    text-align: center;
}
#innerBodyDiv {
	min-height: calc(100% - 50px);
	float: left;
    width: 100%;
}
#mainBodyDiv {
	float: left;
    width: 100%;
    padding-top: 0;
}
#mainBodyDiv.hasSideMnuCls {
	min-height: 245px;
/* 	padding-left: 260px; */
	float: left;
    width: 100%;
}
#sideBarMainDiv {
    width: 260px;
    margin-bottom: 100px;
    background: #ffffff;
    position: fixed;
    left: 0;
    overflow-y: auto;
    height: 100%;
    box-shadow: 2px 0px 4px #c7c0c0;
}
#sideMnuBarDiv {
	float: left;
	height: 100%;
	width: 100%;
}

#header {
	box-shadow: 2px 0px 4px #c7c0c0;
    background: #fdfdfd;
    float: left;
    width: 100%;
    padding: 5px 0 5px 0;
}

.ui-widget.ui-widget-content {
	z-index: 2 !important;
}

.addrTblCls {
	height: 40px;
    line-height: 19px;
    position: relative;
    cursor: pointer;
	transition: all 0.3s;
}

.addrTblCls:hover {
	color: #007bff;
}

.expandAddrCls {
	height: auto !important;
}

.addrTblCls:before {
    content: "\f107";
    font-family: FontAwesome;
    font-style: normal;
    font-weight: normal;
    text-decoration: inherit;
    color: #007bff;
    font-size: 18px;
    font-weight: bold;
    padding-right: 0.5em;
    position: absolute;
    top: 25px;
    right: -6px;
    z-index: 1;
}

.expandAddrCls:before {
	content: "";
}

.expandAddrCls:after {
    content: "\f106";
    font-family: FontAwesome;
    font-style: normal;
    font-weight: normal;
    text-decoration: inherit;
    color: #007bff;
    font-size: 18px;
    font-weight: bold;
    padding-right: 0.5em;
    position: absolute;
    bottom: 0px;
    right: -6px;
    z-index: 1;
}

/* Chosen Select Box CSS Start */
.chosen-container {
	font-size: 0.85rem !important;
	width: 100% !important;
}

.chosen-container .chosen-results li.active-result {
/* 	font-size: 0.75rem; */
}

.chosen-container .chosen-results {
	width: 100% !important;
	margin: 0px !important;
    padding: 0px !important;
}

.chosen-container-single .chosen-single {
	box-shadow: none !important;
}

.chosen-container-single .chosen-single span {
	line-height: 21px;
}

.chosen-container .chosen-results li.highlighted {
	color: #444;
	background: #f3f3f3 !important;
}

a.chosen-single {
    border-radius: 3px !important;
    border: 1px solid #dedede !important;
    margin-bottom: 3px;
    width: 100%;
    float: left;
    padding: 6px 15px !important;
    background: none !important;
    height: auto !important;
}

.chosen-container-single .chosen-search input[type=text] {
	margin-bottom: 8px !important;
	border-radius: 3px;
    border: 1px solid #dedede;
}

.chosen-container .chosen-drop {
    border-top: 1px solid #aaa;
    border-radius: 3px;
    border: 1px solid #dedede;
}

.chosen-container-single .chosen-single div {
	width: 22px;
}

.chosen-container-single .chosen-single div b {
	background-size: 48px 29px;
    transform: scale(1.3);
    margin-top: 11px;
    margin-left: 7px;
}

.chosen-container .chosen-results li em {
	color: #ff1800;
}
/* Chosen Select Box CSS Stop */

.highlight {
    background-color: #ffd950;
}

.statusCls {
    color: #4CAF50;
    text-align: center;
    font-size: 1rem;
    line-height: 40px;	
}

.hdrLblCls {
 	font-weight: bold;
}

.statusCls a {
    color: #4CAF50;
}

.errCls {
    color: #E91E63;
    text-align: left !important;
    font-size: 0.8rem;
    line-height: 20px;	
}

.errCls ul {
    margin-left: -23px;
}

.card-text {
	overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 8;
    -webkit-box-orient: vertical;
}

.mobile-pre-ex {
	position: absolute;
    left: 0;
    line-height: 33px;
    padding: 0px 7px;
    background: #dedede;
    border-radius: 2px 0px 0px 2px;
}

.twoline-ellipsis {
	overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

.loadingContentCls {
	text-align: center;
    width: 100%;
    float: left;
    margin-top: 20px;
}

::-webkit-scrollbar {
    width: 10px;
    background: #e7e7e7;
}

::-webkit-scrollbar-thumb {
    background: #e6e6e6;
    border: 1px solid rgba(0,0,0,.2);
    border-radius: 0px;
    box-shadow: 1px 1px 1px 0 rgba(0,0,0,.2);
}

.delvHdrCls {
	color: #007bff;
}

.custom_nav-container.navbar-expand-lg .navbar-nav .nav-link {
	color: #7a7a7a;
}

.navbar-brand span {
	color: #e0f0ef;
	font-size: 1rem;
}

.delvRowCls {
    padding: 5px 0px;
    border-bottom: 1px dotted gray;
    float: left;
    width: 100%;
}

.delvSubHdrCls {
	float: left;
    width: 140px;
}

.delvSubHdrValCls {
	float: left;
}

.tblActionCls {
	padding: 2px 7px;
    color: #ffffff;
    cursor: pointer;
    font-size: 0.7rem;
    background: #007bff;
    border-radius: 2px;
}

.tblcolumnlbl {
    max-width: 200px;
    display: inline-block;
/*     max-height: 38px; */
    white-space: break-spaces;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 0.8rem;
}

.tblTelLblCls {
    color: #E91E63;
    font-size: 0.7rem;
    float: left;
    width: 100%;
}

select:disabled {
	background: #ebebe4;
}

.sideMnuTopDivCls {
    float: left;
    width: 100%;
    padding-bottom: 10px;
    box-shadow: 2px 0px 4px #c7c0c0;
    margin-bottom: 8px;
}

/* Menu Bar Starts */
.mnuMainCls {
}

.mnuMaskCls {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: #ababab;
    z-index: 2;
    opacity: 0.5;
    display: none;
}

.mnuStepCls {
	float: left;
    cursor: pointer;
    width: 100%;
    padding: 8px 0px 8px 15px;
	color: #000000;
	font-size: 0.8rem;
}

.mnuStepHdrCls.fa {
    font-size: 0.8rem;
}

.mnuStepHdrCls.fa.fa-mobile {
	font-size: 1.2rem;
}

.mnuStepCls:hover {
    color: #f44336;
}

.mnuStepHdrCls {
    font-size: 0.75rem;
    float: left;
	color: #e91e63;
    line-height: 1.15rem;
    width: 1rem;
    text-align: center;
}

.mnuStepRowCls {
    float: left;
    margin-left: 10px;
}

.mnuStepRowCls a {
    color: #007bff !important;
	letter-spacing: 1px;
}

.mnuBodyCls {
    position: fixed;
    top: 0;
    transition: all 0.3s;
    right: -310px;
    width: 310px;
    height: 100%;
    background: white;
    z-index: 2;
}

.mnuIconCls {
	cursor: pointer;
}

.mnuBodyCls.showCls {
    right: 0%;
}

.mnuContentCls {
    padding: 0px;
    float: left;
    width: 100%;
    height: calc(100% - 63px);
    overflow-y: hidden;
    padding-bottom: 98px !important;
/*     font-size: 0.75rem; */
}

.mnuContentCls:hover {
	overflow-y: auto;
}

.mnuHdrCls {
    text-align: center;
    background: #ffffff;
    padding: 11px 0px 11px 10px;
    border-bottom: 1px solid #e2e2e2;
    color: white;
    float: left;
    width: 100%;
    background: -webkit-gradient(linear,left top,right bottom,color-stop(0%,#008fe2),color-stop(100%,#00b29c));
    background: -webkit-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: -o-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: -ms-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: linear-gradient(154deg,#008fe2 0,#00b29c 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#008fe2', endColorstr='#00b29c', GradientType=1);
}

.mnuUserIconCls {
    color: #767676;
    float: left;
    width: 40px;
    height: 40px;
    font-size: 18px;
    line-height: 40px;
    background: #ffffff;
    border-radius: 20px;
}

.mnuUserNameCls {
	color: #ffffff;
    font-size: 0.8rem;
    line-height: 40px;
    letter-spacing: 1px;
    padding-left: 10px;
    float: left;
    text-align: center;
}

.closeMnuCls {
    position: absolute;
    right: 15px;
    top: 21px;
    font-size: 17px;
    cursor: pointer;
}

.ml-lg-4, .mx-lg-4 {
/*     margin-left: 1.2rem !important; */
}

.bellCls {
	font-size: 12px;
    cursor: pointer;
    color: #ffffff;
    width: 30px;
    height: 30px;
    line-height: 30px;
    background: #48d8be;
    border-radius: 20px;
    position: relative;
    text-align: center;
}

.bellDotCls {
	width: 10px;
    height: 10px;
    background: #53e7cc;
    position: absolute;
    top: 0;
    right: 0;
    border-radius: 5px;
}

.accountCls {
	font-size: 12px;
    cursor: pointer;
    color: #ffffff;
    width: 30px;
    height: 30px;
    line-height: 30px;
    background: #f44336;
    border-radius: 20px;
    text-align: center;
}

/* Menu Bar Ends */

/* Charts Starts */
.chartDivCls {
	height: 300px;
	width: 100%;
}

.chartDivMainCls {
    padding: 10px;
    border: 1px solid #bfbfbf;
    border-radius: 2px;
    box-shadow: 0px 5px 8px #c5c5c5;
}

.prodAddedCls {
	float: left;
    width: 100%;
}

.subHdrCls {
    font-size: 15px;
    font-weight: bold;
    margin-top: 40px;
    margin-bottom: 20px;
	float: left;
	width: 100%;
}

.subHdrCls:first-child {
    margin-top: 20px;
}

.chartMainSubDiv {
	padding: 0 0px;
}
/* Charts Ends */

.loader, .loadCls {
	position: absolute;
    width: 100%;
    height: 100%;
    z-index: 9999;
    background: url(images/page_loader.gif) 50% 50% no-repeat #000000;
    background-color: #fff;
    opacity: 0.7;
    background-size: 30px;
    display: none;
}

.loadCmnCls {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 9999;
    background: url(<%=request.getContextPath() %>/images/page_loader.gif) 50% 50% no-repeat #000000;
    opacity: 0.7;
    background-size: 30px;
    display: none;
}
/* Chari*/
.bulkCls {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 9999;
    background: url(<%=request.getContextPath() %>/images/page_loader.gif) 50% 50% no-repeat white;
    opacity: 0.8;
    color:black;
    text-align:center;
    background-size: 30px;
    display: none;
}

.bulkCls div{
top: 30%;
    font-weight: 700;
    position: absolute;
    left: 0%;
    width: 100%;
    text-align: center;
    font-size: 20px;
}
.btn-primary {
	border-radius: 5px !important;
	color: #fff;
    background-color: rgba(0,148,205,1);
    border-color: rgba(0,148,205,1);
}
.btn-primary:hover {
	color: #fff;
    background-color: rgba(0,148,205,1);
    border-color: rgba(0,148,205,1);
}

.btn-primary-gray {
    background-color: #b3b1b1;
    border-color: #b3b1b1;
}

.btn-primary-gray:hover {
    background-color: #848181;
    border-color: #848181;
}

.helpMainCls {
}

.maskCls {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: gray;
    z-index: 2;
    opacity: 0.5;
}
/* Chari: Added notificationStepCls*/
.helpStepCls,.notStepCls {
    float: left;
    width: 100%;
    margin-bottom: 25px;
}

/*Chari: Added notificationHdrCls*/
.helpStepHdrCls,.notStepHdrCls {
    font-weight: bold;
    float: left;
    width: 100%;
	margin-bottom: 15px;
}

/*Chari: Added notificationRowCls*/
.helpStepRowCls,.notStepRowCls {
    font-size: 13px;
}

/*Chari: Added notificationbodycls*/

.notBodyCls {
    position: fixed;
    top: 0;
    transition: all 0.3s;
    right: -310px;
    width: 310px;
    height: 100%;
    background: white;
    z-index: 2;
}

.helpBodyCls {
    position: fixed;
    top: 0;
    transition: all 0.3s;
    right: -310px;
    width: 310px;
    height: 100%;
    background: white;
    z-index: 2;
}

/*Chari: Added notificationBodyCls.showcls*/
.helpBodyCls.showCls, .notBodyCls.showCls{
    right: 0%;
}

/*Chari: Added notificationContentCls*/
.helpContentCls {
    padding: 30px;
    float: left;
    width: 100%;
}

.notContentCls {
    float: left;
    width: 100%;
    height: 100%;
	overflow-y: auto;
}

.delbtn {
    background: #E91E63;
}

.custom_nav-container {
    z-index: 2;
    padding: 5px 0;
}
.pt-3, .py-3 {
    padding-top: 5px !important;
}

/*Chari: Added notificationCls*/
.helpCls,.notCls {
	color: #d0d1d2;
    cursor: pointer;
    font-size: 1.3rem;
	font-weight: normal;
}

.hlpTitleCls, .hlpBodyCls
{
	display: none;
}

.helpHdrCls{
	text-align: center;
    background: #48d8be;
    padding: 19px 0px;
    color: white;
    float: left;
    width: 100%;
    font-size: 1rem;
    
    background: -webkit-gradient(linear,left top,right bottom,color-stop(0%,#008fe2),color-stop(100%,#00b29c));
    background: -webkit-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: -o-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: -ms-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: linear-gradient(154deg,#008fe2 0,#00b29c 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#008fe2', endColorstr='#00b29c', GradientType=1);
}

/*Chari: Added notificationHdrCls*/
.notHdrCls {
	text-align: center;
    background: #48d8be;
    padding: 19px 0px;
    color: white;
    float: left;
    width: 100%;
    font-size: 1rem;
    
    background: -webkit-gradient(linear,left top,right bottom,color-stop(0%,#008fe2),color-stop(100%,#00b29c));
    background: -webkit-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: -o-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: -ms-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
    background: linear-gradient(154deg,#008fe2 0,#00b29c 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#008fe2', endColorstr='#00b29c', GradientType=1);
}

/*Chari: Added ClosenotificationCls*/
.closeHlpCls,.closeNotCls {
    position: absolute;
    right: 20px;
    top: 21px;
    font-size: 17px;
    cursor: pointer;
}

.pdmnucls {
    height: 1em;
    font-size: 22px;
    background-image: none !important;
    color: #6ecac8;
}

.table-striped tbody tr:nth-of-type(odd), .table-striped tbody tr:nth-of-type(even) {
    background-color: #ffffff;
}

/* table {
	border-collapse: collapse;
	table-layout: fixed;
	width: 50px;
}

table, th, td {
	border: 1px solid black;
	table-layout: fixed;
	width: 50px;
} */

.dataTable {
	background: #f5f5f5;
}

table.table-bordered.dataTable tbody th, table.table-bordered.dataTable tbody td {
/* 	vertical-align: middle; */
}

.dataTable input, .dataTable select {
    overflow: visible;
    width: 100%;
    border-radius: 3px;
	border: 1px solid #dedede;
	margin-bottom: 0px;
	width: 100%;
	float: left;
	padding: 3px 15px;
}

.errlbl {
	display: none;
    float: left;
    margin-top: 2px;
    margin-left: 6px;
    font-size: 12px;
    color: #ff1919;
}

.required-label::after {
	content: '*';
	color: red;
}

.btn {
	border-radius: 0px;
	padding: 5px 15px;
    font-size: 0.85rem;
}

.dataTables_wrapper .dataTables_filter input {
    margin-left: 0em;
}

body {
	font-size: 0.85rem;
}

.btn1-container a {
	border-radius: 2px;
    display: inline-block;
    padding: 5px 15px;
	text-transform: capitalize;
    font-size: 0.8rem;
    background-color: #ffffff;
    color: #00b0a2;
}

.quote_btn-container a {
	text-transform: capitalize;
	font-size: 0.85rem;
z}

.layout_padding {
    padding: 35px 0 100px 0 !important;
}

.info p {
	text-align: center;
	color: #eaeaea;
	text-transform: none;
	font-weight: 600;
	font-size: 15px;
	margin-top: 2px
}

.info i {
	color: #eaeaea;
}

p span {
	color: #F00;
}

p {
	margin: 0px;
	font-weight: 500;
	line-height: 2;
	color: #333;
}

h1 {
	text-align: center;
	color: #666;
	text-shadow: 1px 1px 0px #FFF;
	margin: 50px 0px 0px 0px
}

.styled-checkbox {
    position: absolute;
    opacity: 0;
}

.radio input[type="radio"] {
	position: absolute;
    opacity: 0;
}

.styled-checkbox + label {
    position: relative;
    cursor: pointer;
    padding: 0;
}

.styled-checkbox + label:before {
	content: '';
    margin-right: 10px;
    display: inline-block;
    vertical-align: text-top;
    width: 20px;
    height: 20px;
    border: 2px solid #6ecac8;
    border-radius: 5px;
}

.styled-checkbox:checked + label:before {
    background: #6ecac8;
}

.styled-checkbox:hover + label:after {
    content: '';
    position: absolute;
    left: 5px;
    top: 9px;
    background: #757575;
    width: 2px;
    height: 2px;
    box-shadow: 2px 0 0 #757575, 4px 0 0 #757575, 4px -2px 0 #757575, 4px -4px 0 #757575, 4px -6px 0 #757575, 4px -8px 0 #757575;
    -webkit-transform: rotate(45deg);
    transform: rotate(45deg);
}

.styled-checkbox:checked + label:after {
    content: '';
    position: absolute;
    left: 5px;
    top: 9px;
    background: white;
    width: 2px;
    height: 2px;
    box-shadow: 2px 0 0 white, 4px 0 0 white, 4px -2px 0 white, 4px -4px 0 white, 4px -6px 0 white, 4px -8px 0 white;
    -webkit-transform: rotate(45deg);
    transform: rotate(45deg);
}

[type=checkbox], [type=radio] {
    box-sizing: border-box;
    padding: 0;
}

.radio-label {
	float: left;
}

.radio input[type="radio"]:checked + .radio-label:before {
    background-color: #6ecac8;
    box-shadow: inset 0 0 0 4px #f4f4f4;
}
.radio input[type="radio"] + .radio-label:before {
    content: '';
    background: #f4f4f4;
    border-radius: 100%;
    border: 1px solid #b4b4b4;
    display: inline-block;
    width: 1.4em;
    height: 1.4em;
    position: relative;
    top: -0.2em;
    margin-right: 1em;
    vertical-align: top;
    cursor: pointer;
    text-align: center;
    -webkit-transition: all 250ms ease;
    transition: all 250ms ease;
}

.formcls input {
	border-radius: 3px;
	border: 1px solid #dedede;
	margin-bottom: 15px;
	width: 100%;
/* 	height: 37px; */
	float: left;
	padding: 6px 15px;
}

input:focus, select:focus, textarea:focus {
    outline: none;
    border: 1px solid #6cd0c9;
}

.formcls select {
	border-radius: 3px;
	border: 1px solid #dedede;
	margin-bottom: 15px;
	width: 100%;
/* 	height: 37px; */
	float: left;
	padding: 6px 15px;
}

a {
	text-decoration: inherit
}

.formcls textarea {
	border-radius: 3pxpx;
	border: 1px solid #dedede;
	margin: 0;
	width: 75%;
	height: 130px;
	float: left;
	padding: 6px 15px;
}

.form-group {
/* 	overflow: hidden; */
	clear: both;
	position: relative;
	margin-bottom: 0rem;
}

.icon-case {
	width: 25px;
	float: left;
	border-radius: 10px 10px 10px 10px;
	background: #eeeeee;
	height: 42px;
	position: center;
	text-align: center;
	line-height: 40px;
}

i {
/* 	color: #ffa31a; */
	color: inherit;
}

.btn-icon {
	margin-right: 10px;
    padding-right: 10px;
    font-size: 10px;
    height: 18px;
    line-height: 18px;
    border-right: 1px solid #d4d4d4;
}

.contentform {
	padding: 40px 30px;
}

.bouton-contact {
	background-color: #F6AA93;
	color: #FFF;
	text-align: center;
	width: 100%;
	border: 0;
	border-radius: 0px 0px 5px 5px;
	cursor: pointer;
	margin-top: 40px;
	font-size: 18px;
}

.leftcontact {
	width: 49.5%;
	float: left;
	box-sizing: border-box;
	padding: 0px 15px 0px 0px;
}

.rightcontact {
	width: 49.5%;
	float: right;
	box-sizing: border-box;
	padding: 0px 0px 0px 15px;
}

.validation {
    display: none;
    margin-top: -15px;
    font-weight: 400;
    font-size: 12px;
    color: #ff1919;
    line-height: 15px;
}

.showVal {
	display: inline-block !important;
}

#sendmessage.show, .show {
	display: block;
}

.info_section .form_container input {
	width: 100%;
}

#errormsg {
	display: none;
}

#errormsg {
	color: red;
	font-size: 14px;
	text-align: center;
	padding: 10px;
}

#header {
	/*background: -webkit-gradient(linear,left top,right bottom,color-stop(0%,#008fe2),color-stop(100%,#00b29c));
	background: -webkit-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
	background: -o-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
	background: -ms-linear-gradient(-65deg,#008fe2 0,#00b29c 100%);
	background: linear-gradient(154deg,#008fe2 0,#00b29c 100%);*/
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#008fe2', endColorstr='#00b29c', GradientType=1);
	
	/* -webkit-box-shadow: 0px 4px 2px 0px rgba(222, 222, 222, 0.75);
	-moz-box-shadow: 0px 4px 2px 0px rgba(222, 222, 222, 0.75);
	box-shadow: 0px 4px 2px 0px rgba(222, 222, 222, 0.75); */
}

	.dropdown-content {
    display: none!important;
    position: relative;
    background-color: transparent;
    padding-left: 10px !important;
    margin-left: 0px;
    width: 100%!important;
		  }
		  .drpdown{
    margin-bottom: 0px;
  }
  .drpdwn{
    margin-bottom: 0px;
  }
 
  .dpdwn{
    margin-bottom: 0px;
  }
		  .drpdwn:hover .dropdown-content {display: block!important;}
		  .drpdown:hover .dropdown-content {display: block!important;}
		   .dpdwn:hover .dropdown-content {display: block!important;}
		  .dropdown-content a:hover {background-color: #ddd!important;}
</style>

<script type="text/javascript">
jQuery.extend({
    highlight: function (node, re, nodeName, className) {
        if (node.nodeType === 3) {
            var match = node.data.match(re);
            if (match) {
                var highlight = document.createElement(nodeName || 'span');
                highlight.className = className || 'highlight';
                var wordNode = node.splitText(match.index);
                wordNode.splitText(match[0].length);
                var wordClone = wordNode.cloneNode(true);
                highlight.appendChild(wordClone);
                wordNode.parentNode.replaceChild(highlight, wordNode);
                return 1; //skip added node in parent
            }
        } else if ((node.nodeType === 1 && node.childNodes) && // only element nodes that have children
                !/(script|style)/i.test(node.tagName) && // ignore script and style nodes
                !(node.tagName === nodeName.toUpperCase() && node.className === className)) { // skip if already highlighted
            for (var i = 0; i < node.childNodes.length; i++) {
                i += jQuery.highlight(node.childNodes[i], re, nodeName, className);
            }
        }
        return 0;
    }
});

jQuery.fn.unhighlight = function (options) {
    var settings = { className: 'highlight', element: 'span' };
    jQuery.extend(settings, options);

    return this.find(settings.element + "." + settings.className).each(function () {
        var parent = this.parentNode;
        parent.replaceChild(this.firstChild, this);
        parent.normalize();
    }).end();
};

jQuery.fn.highlight = function (words, options) {
    var settings = { className: 'highlight', element: 'span', caseSensitive: false, wordsOnly: false };
    jQuery.extend(settings, options);
    
    if (words.constructor === String) {
        words = [words];
    }
    words = jQuery.grep(words, function(word, i){
      return word != '';
    });
    words = jQuery.map(words, function(word, i) {
      return word.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
    });
    if (words.length == 0) { return this; };

    var flag = settings.caseSensitive ? "" : "i";
    var pattern = "(" + words.join("|") + ")";
    if (settings.wordsOnly) {
        pattern = "\\b" + pattern + "\\b";
    }
    var re = new RegExp(pattern, flag);
    
    return this.each(function () {
        jQuery.highlight(this, re, settings.element, settings.className);
    });
};

	$(document).ready(function() {
		
		$('.accMnuIconCls').click(function() {
			$('.mnuMaskCls').hide();
			$('.mnuBodyCls').removeClass('showCls');
			
			$(this).find('.mnuMaskCls').fadeIn(200);
			$(this).find('.mnuBodyCls').addClass('showCls');
			$('body').css('overflow', 'hidden');
		});
		
		$('.signoutCls').click(function() {
			window.location.href = $('#contextPath').val() + '/a/logout';
		});
		
		$('.actionUrlCls').click(function() {
			window.location = $(this).attr('targetUrl');
		});
		
		$(document.body).on('click', '.addrTblCls', function() {
			if($(this).hasClass('expandAddrCls')) {
				$(this).removeClass('expandAddrCls')
			} else {
				$(this).addClass('expandAddrCls')
			}
		});
		
		$(document.body).on('click', '.mnuMaskCls, .closeMnuCls', function() {
			$('.mnuBodyCls').removeClass('showCls');
			$('.mnuMaskCls').hide();
			$('body').css('overflow', 'auto');
		});
		
		$('.helpCls').click(function() {
			$('body').css('overflow', 'hidden');
			$('.helpBodyCls').removeClass('showCls', {duration:500}, function() {
				$('.helpMainCls').remove();
			});
			
			var title = $(this).find('.hlpTitleCls').html();
			if(title == '' || title == undefined)
				title = "Help";
			
			var body = $(this).find('.hlpBodyCls').html();
			
			var htmlVar = '<span class="helpMainCls">';
			htmlVar += '<span class="maskCls"></span>';
			htmlVar += '<span class="helpBodyCls">';
			htmlVar += '<span class="helpHdrCls"><span>'+title+'</span><span class="fa fa-close closeHlpCls"></span></span>';
			htmlVar += '<span class="helpContentCls">'+body+'</span>';
			htmlVar += '</span>';
			htmlVar += '</span>';
			
			$(document.body).append(htmlVar);
			setTimeout(function() {
				$('.helpBodyCls').addClass('showCls');
			}, 200);
		});
		
		$(document.body).on('click', '.maskCls, .closeHlpCls', function() {
			$('.helpBodyCls').removeClass('showCls');
			setTimeout(function() {
				$('.helpMainCls').remove();
			}, 500);
			$('body').css('overflow', 'auto');
		});
		
		$(document.body).on('click', '#switchLoginBtn', function() {
// 			windows.create({"url": $('#contextPath').val() + '/swtacnt.html?usrid='+$('#userNameSrchSelLogin').find('option:selected').attr('usr-id'), "incognito": true});
			
			$.ajax({
				url : $('#contextPath').val() + '/adm/switchToUser?usrid='+$('#userNameSrchSelLogin').find('option:selected').attr('usr-id'),
				contentType : "application/json",
				method : 'POST',
				data: {},
				success : function(data) {
					if (data != null) {
						if (data.startsWith("SUCCESS")) {
							var viewName = data.split(":")[1];
							window.location = $('#contextPath').val() + '/' + viewName;
						} else {
							var errMsg = data.split(":")[1];
							alert(errMsg);
						}
					}
					$('.loadCls').hide();
				}
			});
		});
		
		$(document.body).on('change', '#userRoleSel', function() {
			var roleVar = $('#userRoleSel').val();
			if(roleVar == '0') {
				return false;
			}
			
			$.ajax({
	 			url : $('#contextPath').val() + '/adm/userDetailsByRoleToPayAmount?roleName='+roleVar,
	 			contentType : "application/json",
	 			method : 'POST',
	 			success : function(data) {
	 				var htmlVar = "<select id='userNameSrchSelLogin'>";
	 				if(data.length > 0) {
	 					var opt="<option value=''>Select One</option>";
	 					$.each(data,function(i,val){
	 						if(val.vendorGroupName != null && val.vendorGroupName != '') {
	 							htmlVar += "<option value='"+val.vendorGroupName+" - "+val.mobileNumber+"' usr-id='"+val.id+"' contact-no='"+val.mobileNumber+"'>"+val.vendorGroupName+" - "+val.mobileNumber+"</option>";
	 						}
	 					});
	 				} else {
	 					htmlVar += "<option value=''>No User</option>";
	 				}
	 				htmlVar += '</select>';
	 				$('.selDivCls').html(htmlVar);
	 				
	 				$("#userNameSrchSelLogin").chosen();
	 				$('.finalDivCls').show();
	 			}
	 		});
		});
		
		$('.switchLoginCls').click(function() {
			$('body').css('overflow', 'hidden');
			$('.notMainCls').remove();
			var title = "Switch Login";
			var htmlVar = '<span class="notMainCls">';
			htmlVar += '<span class="maskCls"></span>';
			htmlVar += '<span class="notBodyCls">';
			htmlVar += '<span class="notHdrCls switchLoginNoHdrCls"><span>'+title+'</span><span class="fa fa-close closeNotCls"></span></span>';
			htmlVar += '<span class="notContentCls" style="padding: 20px;">';
			
			htmlVar += '<span class="roleSelDivCls">';
			htmlVar += "<select id='userRoleSel'>";
			htmlVar += "<option value='0'>Select One</option>";
			htmlVar += "<option value='ROLE_USER'>User</option>";
			htmlVar += "<option value='ROLE_VENDOR'>Vendor</option>";
			htmlVar += "<option value='ROLE_DELIVER'>Deliver</option>";
			htmlVar += "</select>";
			htmlVar += '</span>';
			
			htmlVar += '<span class="finalDivCls">';
			htmlVar += '<span class="selDivCls"><span class="loadingContentCls">loading...</span></span>';
			htmlVar += '<div><button class="btn btn-primary" id="switchLoginBtn" style="margin-top: 15px;float: right;">Login</button></div>';
			htmlVar += '</span>';
			htmlVar += '</span>';
			htmlVar += '</span>';
			htmlVar += '</span>';
			$(document.body).append(htmlVar);
			
			$("#userRoleSel").chosen();
			
			setTimeout(function() {
				$('.notBodyCls').addClass('showCls');
			}, 200);
		});
		
		//Chari: Notifications popup
		$('.bellCls').click(function() {
			$('body').css('overflow', 'hidden');
			$('.notMainCls').remove();
			var title = "Notifications";
			var htmlVar = '<span class="notMainCls">';
			htmlVar += '<span class="maskCls"></span>';
			htmlVar += '<span class="notBodyCls">';
			htmlVar += '<span class="notHdrCls"><span>'+title+'</span><span class="fa fa-close closeNotCls"></span></span>';
			htmlVar += '<span class="notContentCls"><span class="loadingContentCls">loading...</span></span>';
			htmlVar += '</span>';
			htmlVar += '</span>';
			$(document.body).append(htmlVar);
			
			setTimeout(function() {
				$('.notBodyCls').addClass('showCls');
			}, 200);
			
			$.ajax({
	 			url : $('#contextPath').val() +'/b/notify',
	 			contentType : "application/json",
	 			method : 'POST',
	 			success : function(data) {
	 				var notificationsBody="";
	 				if (data != null) {
	 					for(var i=0;i<data.length;i++) {
	 						var sentDate = new Date(data[i].createdDate);
	 						
	 						notificationsBody+="<span class='notStepCls' style='border-bottom: 1px dotted gray;padding: 10px;margin-bottom: 0px;'>";
	 						notificationsBody+="<span class='notStepHdrCls' style='font-weight: normal;'>"+data[i].notificationMsg+"</span>";
	 						notificationsBody+="<span class='notStepRowCls' style='float: right; font-size: 0.65rem;'>"+sentDate.toShortFormat()+"</span>";
	 						notificationsBody+="</span>";
	 					}
	 				}

	 				if(notificationsBody == '') {
	 					notificationsBody="<span class='loadingContentCls'>No notifications</span>";
	 				}
	 				$('.notContentCls').html(notificationsBody);
	 			}
	 		});
		});
		
		$(document.body).on('click', '.maskCls, .closeNotCls', function() {
			$('.notBodyCls').removeClass('showCls');
			$('body').css('overflow', 'auto');
			setTimeout(function() {
				$('.notMainCls').remove();
			}, 500);
		});
		

		
		//Chari: End of notifications
		
		
		
		var actualHeight = window.innerHeight;
		var wndHeight1 = actualHeight - 50;
		$('#innerBodyDiv').css('min-height', wndHeight1);
// 		$('.mainBodyDivMem').css('min-height', wndHeight1);
// 		$('.mainBodyDivAdm').css('min-height', wndHeight1);
// 		$('.mainBodyDivVend').css('min-height', wndHeight1);
		
		$('#myModal').on('shown.bs.modal', function() {
			$('#myInput').trigger('focus')
		});

		$('#loginMnu').click(function() {
			$('#myModal').modal('show');
		});

		/* $('#sendOtpBtn').click(function() {
			var registerModel = new Object();
			registerModel.mobileNumber = $('#u_mobno').val();

			$.ajax({
				url : 'a/r',
				contentType : "application/json",
				method : 'POST',
				data : JSON.stringify(registerModel),
				success : function(data) {
					if (data != null) {
						$('#u_otp').val(data.otp);
						alert('OTP sent');
					}
				}
			});
		});

		$('#loginBtn').click(function() {
			var registerModel = new Object();
			registerModel.mobileNumber = $('#u_mobno').val();
			registerModel.otp = $('#u_otp').val();

			$.ajax({
				url : 'a/login',
				contentType : "application/json",
				method : 'POST',
				data : JSON.stringify(registerModel),
				success : function(data) {
					if (data != null) {
						if (data.startsWith("SUCCESS")) {
							var viewName = data.split(":")[1];
							window.location = viewName;
						} else {
							var errMsg = data.split(":")[1];
							alert(errMsg);
						}

					}
				}
			});
		});

		$('#loginBtn1').click(function() {
			$('.loadCls').show();
			var registerModel = new Object();
			registerModel.email = $('#u1_uname').val();
			registerModel.password = $('#u1_password').val();
			$('#errormsg').html('');
			$('#errormsg').hide();

			$.ajax({
				url : 'a/loginValidate',
				contentType : "application/json",
				method : 'POST',
				data : JSON.stringify(registerModel),
				success : function(data) {
					if (data != null) {
						if (data.startsWith("SUCCESS")) {
							var viewName = data.split(":")[1];
							window.location = viewName;
						} else {
							var errMsg = data.split(":")[1];
							$('#errormsg').html(errMsg);
							$('#errormsg').show();
						}
					}
					$('.loadCls').hide();
				}
			});
		});

		$('#loginmob').click(function() {
			$('.loinbymobdiv').show();
			$('.loinbyemaildiv').hide();
		});

		$('#loginemail').click(function() {
			$('.loinbyemaildiv').show();
			$('.loinbymobdiv').hide();
		}); */
		
	});
	

	Date.prototype.toShortFormat = function() {
	    var month_names =["Jan","Feb","Mar",
	                      "Apr","May","Jun",
	                      "Jul","Aug","Sep",
	                      "Oct","Nov","Dec"];
	    
	    var day = this.getDate();
	    var month_index = this.getMonth();
	    var year = this.getFullYear();
	    var hours = this.getHours();
	    var minutes = this.getMinutes();
	    var ampm = (hours < 12 || hours === 24) ? "AM" : "PM";
	    var hours = hours % 12 || 12;
	    
	    return "" + day + "-" + month_names[month_index] + "-" + year + " " + hours + ":" + minutes + " " + ampm;
	}
	
		  
</script>

<div id="header" class="cmnHdrCls">
	<input type="hidden" id="contextPath" value="<%=request.getContextPath() %>">

	<%-- <% if(request.getSession().getAttribute("LoggedIn") != null && request.getSession().getAttribute("LoggedIn").equals("TRUE")) { %>
	<div style="margin-bottom: -20px;">
		<div class="container">
			<div style="text-align: right; color: #161717; font-size: 10px; line-height: 18px; letter-spacing: 1px;">
				Welcome <span style="font-weight: bold;"><%= request.getSession().getAttribute("UserName")%></span>
			</div>
		</div>
	</div>
	<%} %> --%>
	
	<!-- header section strats -->
	<div class="container">
		<nav class="navbar navbar-expand-lg custom_nav-container pt-3">
						
			<% if(request.getSession().getAttribute("LoggedIn") == null || !request.getSession().getAttribute("LoggedIn").equals("TRUE")) { %>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon fa fa-bars pdmnucls"></span>
			</button>
			<%} %>
			
			<% if(request.getSession().getAttribute("LoggedIn") != null && request.getSession().getAttribute("LoggedIn").equals("TRUE")) { %>
				<% if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_ADMIN")) { %>
					<div class="" id="navbarSupportedContent" style="width: 100%;">
					<div class="ml-0 ml-lg-4 d-flex justify-content-center" style="float: right;">
						
						<div class="otherSettCls">
							<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls">
								<div class=""><i class="fa fa-toggle-on switchLoginCls"></i></div>
							</div>
						</div>
						
						<div class="otherSettCls">
							<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls" style="margin-left: 1.2rem !important;">
								<div class=""><i class="fa fa-bell bellCls"><span class="bellDotCls"></span></i></div>
							</div>
						</div>
						
						<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls signoutCls" style="margin-left: 1.2rem !important;">
							<div class=""><i class="fa fa-power-off accountCls"></i></div>
                            
							<span class="mnuMainCls">
								<span class="mnuMaskCls"></span>
								<span class="mnuBodyCls">
									<span class="mnuHdrCls">
										<span class="fa fa-user mnuUserIconCls"></span>
										<span class="mnuUserNameCls">
											Welcome <span style="font-weight: bold;"><%= request.getSession().getAttribute("UserName")%></span>
										</span>
										<span class="fa fa-close closeMnuCls"></span>
									</span>
									<span class="mnuContentCls">
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/">
										    <span class="mnuStepHdrCls fa fa-user"></span>
										    <span class="mnuStepRowCls">Home</span>
										</span>
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/trackDelv">
										    <span class="mnuStepHdrCls fa fa-truck"></span>
										    <span class="mnuStepRowCls">Track Deliveries</span>
										</span>
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/senderRequests">
										    <span class="mnuStepHdrCls fa fa-truck"></span>
										    <span class="mnuStepRowCls">All Deliveries</span>
										</span>
										<%-- <span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/vendorreport">
										    <span class="mnuStepHdrCls fa fa-file"></span>
										    <span class="mnuStepRowCls">Vendor Report</span>
										</span> --%>
										<%-- <span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/taxdetails">
											<span class="mnuStepHdrCls fa fa-users"></span>
											<span class="mnuStepRowCls">Tax Details</span>
										</span> --%>
										<div class="mnuStepCls drpdown"><span class="mnuStepHdrCls fa fa-money"></span>
										<span class="mnuStepRowCls">Settlement</span>
										<!-- Chari: Added for user management in admin side -->
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/sdetails">
											<span class="mnuStepHdrCls fa fa-rocket"></span>
											<span class="mnuStepRowCls">To Vedagram</span>
										</span>
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/paymentdetails">
											<span class="mnuStepHdrCls fa fa-building"></span>
											<span class="mnuStepRowCls">To Vendor</span>
										</span>
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/delvpaymentdetails">
											<span class="mnuStepHdrCls fa fa-motorcycle"></span>
											<span class="mnuStepRowCls">To Deliverer</span>
										</span>
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/paysettlesummary">
											<span class="mnuStepHdrCls fa fa-motorcycle"></span>
											<span class="mnuStepRowCls">Settlement Summary</span>
										</span>
										</div>
<%-- 										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/delvtaxreport"> --%>
<!-- 											<span class="mnuStepHdrCls fa fa-users"></span> -->
<!-- 											<span class="mnuStepRowCls">Summary Tax Report</span> -->
<!-- 										</span> -->
										
										<div class=" mnuStepCls drpdwn"><span class="mnuStepHdrCls  fa fa-users"></span><span class="mnuStepRowCls">User Management</span>
										<!-- Chari: Added for user management in admin side -->
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/useradm">
											<span class="mnuStepHdrCls fa fa-mobile"></span>
											<span class="mnuStepRowCls">App User</span>
										</span>
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/delvemp">
											<span class="mnuStepHdrCls fa fa-motorcycle"></span>
											<span class="mnuStepRowCls">Deliverer[Employee]</span>
										</span>
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/delvnonemp">
											<span class="mnuStepHdrCls fa fa-motorcycle"></span>
											<span class="mnuStepRowCls">Deliverer[Non-Employee]</span>
										</span>
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/ven">
											<span class="mnuStepHdrCls  fa fa-building"></span>
											<span class="mnuStepRowCls">Vendor</span>
										</span></div>
										<div class=" mnuStepCls dpdwn"><span class="mnuStepHdrCls  fa fa-wrench"></span><span class="mnuStepRowCls">Operations</span>
										<!-- Chari: Added for user management in admin side -->
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/packagemgmt">
											<span class="mnuStepHdrCls fa fa-truck"></span>
											<span class="mnuStepRowCls">Delivery Package Management</span>
										</span>
<!-- 										Chari: Added for vendor details in admin side -->
<%-- 										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/userdet"> --%>
<!-- 											<span class="mnuStepHdrCls fa fa-users"></span> -->
<!-- 											<span class="mnuStepRowCls">Vendor Details</span> -->
<!-- 										</span> -->
										<!-- Chari: Added for Support Menu in admin side -->
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/supmnu">
											<span class="mnuStepHdrCls fa fa-cog"></span>
											<span class="mnuStepRowCls">Support Menu</span>
										</span>
										<!-- Chari: Added for Rate Card Menu in admin side -->
										<span class="mnuStepCls actionUrlCls dropdown-content" targetUrl="<%=request.getContextPath()%>/adm/ratecard">
											<span class="mnuStepHdrCls fa fa-calculator"></span>
											<span class="mnuStepRowCls">Rate Card</span>
										</span></div>
											<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/adm/ofrmgmt">
										    <span class="mnuStepHdrCls fa fa-cog"></span>
										    <span class="mnuStepRowCls">Offer Management</span>
										</span>
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/a/logout">
										    <span class="mnuStepHdrCls fa fa-power-off"></span>
										    <span class="mnuStepRowCls">Logout</span>
										</span>
									</span>
								</span>
							</span>
							</div>
					</div>
					</div>
				<% } else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_VENDOR")) { %>
					<div class="" id="navbarSupportedContent" style="width: 100%;">
					<div class="ml-0 ml-lg-4 d-flex justify-content-center" style="float: right;">
						<div class="otherSettCls">
							<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls">
								<div class=""><i class="fa fa-bell bellCls"><span class="bellDotCls"></span></i></div>
							</div>
						</div>
						
						<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls signoutCls" style="margin-left: 1.2rem !important;">
							<div class=""><i class="fa fa-power-off accountCls"></i></div>
                            
							<span class="mnuMainCls">
								<span class="mnuMaskCls"></span>
								<span class="mnuBodyCls">
									<span class="mnuHdrCls">
										<span class="fa fa-user mnuUserIconCls"></span>
										<span class="mnuUserNameCls">
											Welcome <span style="font-weight: bold;"><%= request.getSession().getAttribute("UserName")%></span>
										</span>
										<span class="fa fa-close closeMnuCls"></span>
									</span>
									<span class="mnuContentCls">
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/v/vreportdashboard">
										    <span class="mnuStepHdrCls fa fa-bar-chart-o"></span>
										    <span class="mnuStepRowCls">Dashboard</span>
										</span>
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/v/requestReport">
										    <span class="mnuStepHdrCls fa fa-truck"></span>
										    <span class="mnuStepRowCls">Delivery Report</span>
										</span>
<%-- 										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/v/uploadRequest"> --%>
<!-- 										    <span class="mnuStepHdrCls fa fa-upload"></span> -->
<!-- 										    <span class="mnuStepRowCls">Upload Deliveries</span> -->
<!-- 										</span> -->
										<%-- <span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/v/vendorreport">
										    <span class="mnuStepHdrCls fa fa-file"></span>
										    <span class="mnuStepRowCls">Vendor Report</span>
										</span> --%>
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/b/myprofile">
										    <span class="mnuStepHdrCls fa fa-cog"></span>
										    <span class="mnuStepRowCls">My Profile</span>
										</span>
										
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/a/logout">
										    <span class="mnuStepHdrCls fa fa-power-off"></span>
										    <span class="mnuStepRowCls">Logout</span>
										</span>
									</span>
								</span>
							</span>
						</div>
					</div>
					</div>
				<% } else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_DELIVER")) { %>
					<div class="" id="navbarSupportedContent" style="width: 100%;">
					<div class="ml-0 ml-lg-4 d-flex justify-content-center" style="float: right;">
						
						<div class="otherSettCls">
							<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls">
								<div class=""><i class="fa fa-bell bellCls"><span class="bellDotCls"></span></i></div>
							</div>
						</div>
						
						<div class="ml-0 ml-lg-4 d-flex justify-content-center dropdown mnuIconCls signoutCls" style="margin-left: 1.2rem !important;">
							<div class=""><i class="fa fa-power-off accountCls"></i></div>
							
							<span class="mnuMainCls">
								<span class="mnuMaskCls"></span>
								<span class="mnuBodyCls">
									<span class="mnuHdrCls">
										<span class="fa fa-user mnuUserIconCls"></span>
										<span class="mnuUserNameCls">
											Welcome <span style="font-weight: bold;"><%= request.getSession().getAttribute("UserName")%></span>
										</span>
										<span class="fa fa-close closeMnuCls"></span>
									</span>
									<span class="mnuContentCls">
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/">
										    <span class="mnuStepHdrCls fa fa-user"></span>
										    <span class="mnuStepRowCls">Home</span>
										</span>
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/senderRequests">
										    <span class="mnuStepHdrCls fa fa-truck"></span>
										    <span class="mnuStepRowCls">View Deliveries</span>
										</span>
										
										<span class="mnuStepCls actionUrlCls" targetUrl="<%=request.getContextPath()%>/a/logout">
										    <span class="mnuStepHdrCls fa fa-power-off"></span>
										    <span class="mnuStepRowCls">Logout</span>
										</span>
									</span>
								</span>
							</span>
						</div>
					</div>
					</div>
				<% } else { %>
					<div class="" id="navbarSupportedContent" style="width: 100%;">
					<div class="d-flex ml-auto flex-column flex-lg-row align-items-center">
						<ul class="navbar-nav">
							<li class="nav-item active"><a class="nav-link"
								href="<%=request.getContextPath()%>/">Home <span
									class="sr-only">(current)</span></a></li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/about"> About</a></li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/services"> Services </a></li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/contact">Contact us</a></li>
								<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/apisup">API Integration</a></li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/awbtrack">AWB Tracking</a></li>	
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/register"> Register </a></li>
						</ul>
					</div>
					<div class="btn1-container ml-0 ml-lg-4 d-flex justify-content-center">
						<a href="<%=request.getContextPath()%>/login" id="loginMnu1">Login</a>
					</div>
					</div>
				<% } %>
			<% } else { %>
				<div class="collapse navbar-collapse" id="navbarSupportedContent" style="width: 100%;">
				<div class="d-flex ml-auto flex-column flex-lg-row align-items-center">
					<ul class="navbar-nav">
						<li class="nav-item active"><a class="nav-link"
							href="<%=request.getContextPath()%>/">Home <span
								class="sr-only">(current)</span></a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/about"> About</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/services"> Services </a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/apisup">API Integration</a></li>
						<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/awbtrack">AWB Tracking</a></li>	
						<!-- li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/register"> Register </a></li-->
					</ul>
				</div>
				<!-- div class="btn1-container ml-0 ml-lg-4 d-flex justify-content-center">
					<a href="<%=request.getContextPath()%>/login" id="loginMnu1">Login</a>
				</div-->
				</div>
			<% } %>
		</nav>
	</div>

	<!-- <div id="myModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="loadCls"></div>
				<div class="modal-header">
					<h5 class="modal-title">Login</h5>
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

					<div class="loinbymobdiv" style="display: none;">
						<div class="form-group">
							<label>Mobile No.</label> <input type="text" class="form-control"
								required="required" id="u_mobno">
						</div>
						<div class="form-group">
							<div class="clearfix">
								<label>OTP</label>
							</div>
							<input type="password" class="form-control" required="required"
								id="u_otp">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" id="sendOtpBtn">Sent
								OTP</button>
							<button type="button" class="btn btn-primary" id="loginBtn">Login</button>
						</div>
					</div>

					<div class="loinbyemaildiv">
						<div id="errormsg"></div>
						<div class="form-group">
							<label>Username</label> <input type="text" class="form-control"
								required="required" id="u1_uname">
						</div>
						<div class="form-group">
							<div class="clearfix">
								<label>Password</label>
							</div>
							<input type="password" class="form-control" required="required"
								id="u1_password">
						</div>
						<div class="modal-footer" style="padding-right: 0px;">
							<button type="button" class="btn btn-primary" id="loginBtn1">Login</button>
						</div>
					</div>

				</div>



			</div>

		</div>
	</div> -->
</div>
<div class="loadCmnCls"></div>
<div class="bulkCls"><div>Validating and loading records, please do not refresh the page till it is completed</div></div>