<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Vedagram</title>
  
  <link rel="apple-touch-icon" sizes="57x57" href="<%=request.getContextPath()%>/images/apple-icon-57x57.png"></link>
  <link rel="apple-touch-icon" sizes="60x60" href="<%=request.getContextPath()%>/images/apple-icon-60x60.png"></link>
  <link rel="apple-touch-icon" sizes="72x72" href="<%=request.getContextPath()%>/images/apple-icon-72x72.png"></link>
  <link rel="apple-touch-icon" sizes="76x76" href="<%=request.getContextPath()%>/images/apple-icon-76x76.png"></link>
  <link rel="apple-touch-icon" sizes="114x114" href="<%=request.getContextPath()%>/images/apple-icon-114x114.png"></link>
  <link rel="apple-touch-icon" sizes="120x120" href="<%=request.getContextPath()%>/images/apple-icon-120x120.png"></link>
  <link rel="apple-touch-icon" sizes="144x144" href="<%=request.getContextPath()%>/images/apple-icon-144x144.png"></link>
  <link rel="apple-touch-icon" sizes="152x152" href="<%=request.getContextPath()%>/images/apple-icon-152x152.png"></link>
  <link rel="apple-touch-icon" sizes="180x180" href="<%=request.getContextPath()%>/images/apple-icon-180x180.png"></link>
  <link rel="icon" type="image/png" sizes="192x192"  href="<%=request.getContextPath()%>/images/android-icon-192x192.png"></link>
  <link rel="icon" type="image/png" sizes="32x32" href="<%=request.getContextPath()%>/images/favicon-32x32.png"></link>
  <link rel="icon" type="image/png" sizes="96x96" href="<%=request.getContextPath()%>/images/favicon-96x96.png"></link>
  <link rel="icon" type="image/png" sizes="16x16" href="<%=request.getContextPath()%>/images/favicon-16x16.png"></link>

  <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<%--   <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dataTables.js"></script> --%>

  <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dataTables.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/dataTables.bootstrap4.min.js"></script>
<%--   <script type="text/javascript" src="<%=request.getContextPath() %>/js/a36f299288.js"></script> --%>
  
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/bootstrap.css"></link>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/dataTables.bootstrap4.min.css"></link>

  <!-- font awesome -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/font-awesome.min.css"></link>

  <!-- slider stylesheet -->
<!--   <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.1.3/assets/owl.carousel.min.css"></link> -->

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/bootstrap.css"></link>
  
  <!-- Jquery Ui css -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/jquery-ui.min.css"></link> 

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet"></link>
  
  <!-- Custom styles for this template -->
  <link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet"></link>
  
  <!-- responsive style -->
  <link href="<%=request.getContextPath() %>/css/responsive.css" rel="stylesheet"></link>
  
  <!-- chosen select box style -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.min.css"></link>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.5.1/chosen.jquery.min.js"></script>
  
  
  
<!-- Bootstrap 4 CSS and JavaScript -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->
<!-- jQuery JS -->
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!-- Font Awesome 5 CSS -->
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<!-- Style CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/sidemenu.css">
<style>

</style>
<script type="text/javascript">
jQuery(function ($) {

	$(".sidebar-dropdown > a").click(function () {
		$(".sidebar-submenu").slideUp(200);
		if (
			$(this)
			.parent()
			.hasClass("active")
		) {
			$(".sidebar-dropdown").removeClass("active");
			$(this)
				.parent()
				.removeClass("active");
		} else {
			$(".sidebar-dropdown").removeClass("active");
			$(this)
				.next(".sidebar-submenu")
				.slideDown(200);
			$(this)
				.parent()
				.addClass("active");
		}
	});

	$("#close-sidebar").click(function () {
		$(".page-wrapper").removeClass("toggled");
	});
	$("#show-sidebar").click(function () {
		$(".page-wrapper").addClass("toggled");
	});


});
</script>
  
</head>
<body>
	<div class="wrapper">
		<!-- Body Page -->
		<% if(request.getSession().getAttribute("LoggedIn") != null && request.getSession().getAttribute("LoggedIn").equals("TRUE")) { %>
			<div id="sideBarMainDiv1" class="">
				<div class="page-wrapper chiller-theme toggled">
					<a id="show-sidebar" class="btn btn-sm btn-dark" href="#">
						<i class="fas fa-bars"></i>
					</a>
					<nav id="sidebar" class="sidebar-wrapper">
						<div class="sidebar-content">
							<div class="sidebar-brand">
								<a href="<%=request.getContextPath()%>/" style="font-size: 1.3rem;">
									<img src="<%=request.getContextPath()%>/images/pdlogo.png" alt="" style="width: 25px;height: 25px;border-radius: 20px;" />
								   	<span style="color: #48a8ff;text-transform: initial;">Pick </span>
								   	<span style="color: #76d397;text-transform: initial;">Drop</span>
								</a>
								<div id="close-sidebar">
									<i class="fas fa-times"></i>
								</div>
							</div>
							<div class="sidebar-header">
								<div class="user-pic">
									<i class="fa fa-user-circle"></i>
								</div>
								<div class="user-info">
									<span class="user-name">
										<strong><%= request.getSession().getAttribute("UserName")%></strong>
									</span>
								      
									<% if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_ADMIN")) { %>
										<span class="user-role">Administrator</span>
									<%} else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_VENDOR")) { %>
										<span class="user-role">Vendor</span>
									<%} else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_DELIVER")) { %>
										<span class="user-role">Deliverer</span>
									<%} %>
									<!-- <span class="user-status">
										<i class="fa fa-circle"></i>
										<span>Online</span>
									</span> -->
								   </div>
								</div>
								<!-- sidebar-header  -->
								<!-- <div class="sidebar-search">
								   <div>
								      <div class="input-group">
								         <input type="text" class="form-control search-menu" placeholder="Search...">
								         <div class="input-group-append">
								            <span class="input-group-text">
								            <i class="fa fa-search" aria-hidden="true"></i>
								            </span>
								         </div>
								      </div>
								   </div>
								</div> -->
								<!-- sidebar-search  -->
								<div class="sidebar-menu">
									<ul>
										<% if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_ADMIN")) { %>
											<li class="header-menu"><span>General</span></li>
											<li class="sidebar-dropdown1"><a
												href="<%=request.getContextPath()%>/adm/dashboard"> <i
													class="fa fa-tachometer-alt"></i> <span>Dashboard</span>
													<!-- <span class="badge badge-pill badge-warning">New</span> -->
											</a></li>
											<li class="sidebar-dropdown1"><a
												href="<%=request.getContextPath()%>/adm/senderRequests"> <i
													class="fa fa-truck"></i> <span>All Deliveries</span>
											</a></li>
											<li class="sidebar-dropdown">
												<a href="#"> <i class="fa fa-money-bill-alt"></i> <span>Settlement</span></a>
												<div class="sidebar-submenu">
													<ul>
														<li>
															<a href="<%=request.getContextPath()%>/adm/sdetails">To Vedagram 
																<!-- <span class="badge badge-pill badge-success">Pro</span> -->
															</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/paymentdetails">To Vendor</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/delvpaymentdetails">To Deliverer</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/paysettlesummary">Settlement Summary</a>
														</li>
													</ul>
												</div>
											</li>
				
											<li class="sidebar-dropdown">
												<a href="#">
													<i class="fa fa-users"></i>
									         		<span>User Management</span>
									         	</a>
												<div class="sidebar-submenu">
													<ul>
														<li>
															<a href="<%=request.getContextPath()%>/adm/useradm">App User</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/delvemp">Deliverer[Employee]</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/delvnonemp">Deliverer[Non-Employee]</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/ven">Vendor</a>
														</li>
													</ul>
												</div>
											</li>
											<li class="sidebar-dropdown">
												<a href="#">
													<i class="fa fa-wrench"></i>
													<span>Operations</span>
												</a>
												<div class="sidebar-submenu">
													<ul>
														<li>
															<a href="<%=request.getContextPath()%>/adm/packagemgmt">Delivery Package Management</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/supmnu">Support Menu</a>
														</li>
														<li>
															<a href="<%=request.getContextPath()%>/adm/ratecard">Rate Card</a>
														</li>
													</ul>
												</div>
											</li>
											<li class="sidebar-dropdown1">
												<a href="<%=request.getContextPath()%>/adm/ofrmgmt">
													<i class="fa fa-cog"></i>
													<span>Offer Management</span>
												</a>
											</li>
									      
									      
									      <!-- <li class="header-menu">
									         <span>Extra</span>
									      </li>
									      <li>
									         <a href="#">
									         <i class="fa fa-book"></i>
									         <span>Documentation</span>
									         <span class="badge badge-pill badge-primary">Beta</span>
									         </a>
									      </li>
									      <li>
									         <a href="#">
									         <i class="fa fa-calendar"></i>
									         <span>Calendar</span>
									         </a>
									      </li>
									      <li>
									         <a href="#">
									         <i class="fa fa-folder"></i>
									         <span>Examples</span>
									         </a>
									      </li> -->
										<% } else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_VENDOR")) { %>
											<li class="header-menu"><span>General</span></li>
												<li class="sidebar-dropdown1">
													<a href="<%=request.getContextPath()%>/v/vreportdashboard">
														<i class="fa fa-tachometer-alt"></i>
														<span>Dashboard</span>
													</a>
												</li>
												<% if(request.getSession().getAttribute("loginViaAdmin") != null && request.getSession().getAttribute("loginViaAdmin").toString().equals("true")) {%>
													<li class="sidebar-dropdown1">
														<a href="<%=request.getContextPath()%>/v/sendPackage">
															<i class="fa fa-paper-plane"></i>
															<span>Send Package</span>
														</a>
													</li>
													<li class="sidebar-dropdown1">
														<a href="<%=request.getContextPath()%>/v/trackPackage">
															<i class="fa fa-map-marker"></i>
															<span>Track Package</span>
														</a>
													</li>
													<li class="sidebar-dropdown1">
														<a href="<%=request.getContextPath()%>/v/schedules">
															<i class="fa fa-calendar"></i>
															<span>Schedules</span>
														</a>
													</li>
													<li class="sidebar-dropdown1">
														<a href="<%=request.getContextPath()%>/v/manageFavourites">
															<i class="fa fa-bookmark"></i>
															<span>Favourites</span>
														</a>
													</li>
												<% } %>
												<li class="sidebar-dropdown1">
													<a href="<%=request.getContextPath()%>/v/requestReport">
														<i class="fa fa-truck"></i>
														<span>Delivery Report</span>
													</a>
												</li>
												<li class="sidebar-dropdown1">
													<a href="<%=request.getContextPath()%>/v/vendorreport">
														<i class="fa fa-file"></i>
														<span>Vendor Report</span>
													</a>
												</li>
												<li class="sidebar-dropdown1">
													<a href="<%=request.getContextPath()%>/b/myprofile">
														<i class="fa fa-cog"></i>
														<span>My Profile</span>
													</a>
												</li>
										<% } else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_DELIVER")) { %>
											<li class="sidebar-dropdown1">
												<a href="<%=request.getContextPath()%>/">
													<i class="fa fa-user"></i>
													<span>Home</span>
												</a>
											</li>
											<li class="sidebar-dropdown1">
												<a href="<%=request.getContextPath()%>/senderRequests">
													<i class="fa fa-truck"></i>
													<span>View Deliveries</span>
												</a>
											</li>
										<% } %>
								   </ul>
								</div>
							</div>
							<!-- <div class="sidebar-footer">
								<a href="#">
									<i class="fa fa-bell"></i>
									<span class="badge badge-pill badge-warning notification">3</span>
								</a>
								<a href="#">
									<i class="fa fa-envelope"></i>
									<span class="badge badge-pill badge-success notification">7</span>
								</a>
								<a href="#">
									<i class="fa fa-cog"></i>
									<span class="badge-sonar"></span>
								</a>
								<a href="#">
									<i class="fa fa-power-off"></i>
								</a>
							</div> -->
						</nav>
						
						<% if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_ADMIN")) { %>
							<div id="mainBodyDiv" class="hasSideMnuCls1 page-content">
								<!-- Header -->
								<tiles:insertAttribute name="header" />
								
								<div id="innerBodyDiv" class="mainBodyDivAdm">
									<tiles:insertAttribute name="body" />
								</div>
								
								<!-- Footer Page -->
								<tiles:insertAttribute name="footer" />
							</div>
						<% } else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_VENDOR")) { %>
							<div id="mainBodyDiv" class="hasSideMnuCls1 page-content">
								<!-- Header -->
								<tiles:insertAttribute name="header" />
								
								<div id="innerBodyDiv" class="mainBodyDivVend">
									<tiles:insertAttribute name="body" />
								</div>
								
								<!-- Footer Page -->
								<tiles:insertAttribute name="footer" />
							</div>
						<% } else if(request.getSession().getAttribute("Role") != null && request.getSession().getAttribute("Role").equals("ROLE_DELIVER")) { %>
							<div id="mainBodyDiv" class="hasSideMnuCls1 page-content">
								<!-- Header -->
								<tiles:insertAttribute name="header" />
								
								<div id="innerBodyDiv" class="mainBodyDivDeliv">
									<tiles:insertAttribute name="body" />
								</div>
								
								<!-- Footer Page -->
								<tiles:insertAttribute name="footer" />
							</div>
						<% } else { %>
							<div id="mainBodyDiv" class="hasSideMnuCls1 page-content">
								<!-- Header -->
								<tiles:insertAttribute name="header" />
								
								<div id="innerBodyDiv" class="mainBodyDivMem">
									<tiles:insertAttribute name="body" />
								</div>
								
								<!-- Footer Page -->
								<tiles:insertAttribute name="footer" />
							</div>
						<% } %>
					<% } else { %>
						<!-- Header -->
						<tiles:insertAttribute name="header" />
						
						<div id="mainBodyDiv" class="mainBodyDivMem">
							<div id="innerBodyDiv">
								<tiles:insertAttribute name="body" />
							</div>
						</div>
						
						<!-- Footer Page -->
						<tiles:insertAttribute name="footer" />
					<% } %>
					</div>
					
			</div>
		
			
	</div>
</body>
</html>
