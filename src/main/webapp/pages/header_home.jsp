<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<style>

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
	color: #ffffff;
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
    padding: 15px 0px 15px 20px;
/*     color: #007bff; */
}

.mnuStepCls:hover {
    background: #efefef;
}

.mnuStepHdrCls {
	font-size: 17px;
    float: left;
    color: #607D8B;
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
    height: 100%;
    overflow-y: hidden;
    padding-bottom: 100px !important;
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
	font-size: 16px;
    cursor: pointer;
    color: #48d8be;
    width: 40px;
    height: 40px;
    line-height: 40px;
    background: #f6fbfa;
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
	font-size: 16px;
    cursor: pointer;
    color: #007bff;
    width: 40px;
    height: 40px;
    line-height: 40px;
    background: #f5faff;
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
	border-radius: 2px !important;
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
	color: #ffa31a;
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
		var wndHeight1 = actualHeight - 100;
		$('.mainBodyDivMem').css('min-height', wndHeight1);
		$('.mainBodyDivAdm').css('min-height', wndHeight1);
		$('.mainBodyDivVend').css('min-height', wndHeight1);
		
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