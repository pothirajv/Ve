<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Package delivery and courier and Services">
    <meta name="author" content="Pickdrop">
    <link type="text/css" href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.js" integrity="sha256-2JRzNxMJiS0aHOJjG+liqsEOuBb6++9cY4dSOyiijX4=" crossorigin="anonymous"></script>

    <title>Vedagram - Delivery and courier service</title>

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">

    <!-- >link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/font-awesome.css"-->

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/templatemo-lava.css">

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/owl-carousel.css">
<style>
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active,
	a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover
{
	border: 1px solid #003eff;
	background: #008fe2;
	font-weight: normal;
	color: #fff
}

.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
    border: 1px solid #4c55a2;
    background: #4c55a2;
}
.ui-slider-horizontal .ui-slider-handle {
    top: -.3em;
	margin-left: -.1em;
}

.carousel-control-prev, .carousel-control-next {
	width: 10%;
}

.carousel-control-prev-icon, .carousel-control-next-icon {
	background-image: none;
	background-color: #f5f5f5;
	background-size: 20px;
	border-radius: 30px;
	width: 60px;
	height: 60px;
	font-size: 34px;
	padding: 12px 10px;
	color: #151515;
	/*     box-shadow: #cccccc 0px 1px 5px; */
}

.tasty_section {
	background-image: none;
	background: #464444;
}

.hero_area {
	height: auto;
	background-color: transparent;
}

.slider_section {
	padding-top: 8%;
	padding-bottom: 8%;
}

.tasty_section h2 {
	font-size: 75px;
	text-align: center;
	font-weight: bold;
	color: #ffffff;
	text-transform: capitalize;
}

.tasty_section h3 {
	text-align: center;
	color: #d2d2d2;
}

.pdinfocls {
	border: 1px solid #f9f9f9;
	box-shadow: #d6d6d6 1px 0px 3px;
	padding: 30px;
	border-radius: 10px;
	min-height: 340px;
	position: relative;
}

.custom_link-btn {
	border-bottom: 1px dotted #007bff;
}

.pdinfocls h3 {
	text-align: center;
	color: #ff4700;
}

.pdinfomorecls {
	position: absolute;
	bottom: 12px;
	left: 0;
	text-align: center;
	width: 100%;
}

.pdinfomorecls {
	position: absolute;
	bottom: 12px;
	left: 0;
	text-align: center;
	width: 100%;
}

.ourservicon {
	font-size: 40px;
	color: #717171;
	margin: 55px auto 5px auto;
}

.custom_nav-container.navbar-expand-lg .navbar-nav .nav-link {
	color: #ffffff;
}
</style>
</head>

<body>

    <!-- ***** Preloader Start ***** -->
    <div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <!-- ***** Preloader End ***** -->


    <!-- ***** Header Area Start ***** -->
    <header class="header-area header-sticky">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav class="main-nav">
                        <!-- ***** Logo Start ***** -->
                        <a href="#" class="logo">
                           <img src="<%=request.getContextPath()%>/assets/images/pdlogo.png" alt="delivery and courier service" style="width: 50px; height: 50px; border-radius: 20px;"> <span style="color: #464e97;font-size: 1.7rem">Pick</span><span style="color: #499018;font-size: 1.7rem">Drop</span>
                        </a>
                        	
                        <!-- ***** Logo End ***** -->
                        <!-- ***** Menu Start ***** -->
						
							<!--Old code from website-->
							
						<div  >	
		
                        <ul class="nav">
                            <li class="scroll-to-section"><a href="#welcome" class="menu-item">Home</a></li>
                            <li class="scroll-to-section"><a href="#about" class="menu-item">About</a></li>
                            <li class="scroll-to-section"><a href="#contact-us" class="menu-item">Contact Us</a></li>
                            <li class="nav-item"><a class="#apisup"
								href="<%=request.getContextPath()%>/apisup">API Integration</a></li>
								 <li class="nav-item"><a class="#awbtrack"
								href="<%=request.getContextPath()%>/awbtrack">AWB Tracking</a></li>
                            <% if(request.getSession().getAttribute("LoggedIn") != null && request.getSession().getAttribute("LoggedIn").equals("TRUE")) { %>
                            <li><a href="<%=request.getContextPath()%>/adm/home">My Account</a></li>
                            <%} %>
                        </ul>
                        <a class='menu-trigger'>
                            <span>Menu</span>
                        </a>
                        </div>
                        </nav>
                        <!-- ***** Menu End ***** -->
                        
                      
                </div>
            </div>
        </div>
    </header>
    <!-- ***** Header Area End ***** -->


    <!-- ***** Welcome Area Start ***** -->
    <div class="welcome-area" id="welcome">

        <!-- ***** Header Text Start ***** -->
        <div class="header-text">
            <div class="container">
                <div class="row">
                    <div class="left-text col-lg-6 col-md-12 col-sm-12 col-xs-12"
                        data-scroll-reveal="enter left move 30px over 0.6s after 0.4s">
                        <h1>We Deliver packages <em> WITHIN CITY </em></h1>
                        <p>You can send Home Cooked food, Envelopes, Packages across in no time. We deliver anything you have forgotten from your home to office or office to home, from a shop to your home and it could be groceries, medicines, mobile spares, anything that can be carried on our Bikes to deliver.</p> 
                       <a href="https://play.google.com/store/apps/details?id=com.pick.drop&hl=en"><img src="/assets/images/download_playstore.png" alt="" title="" width="40%"></a>
					   <a href="https://apps.apple.com/in/app/pickdrop-delivery-service/id1515695227"><img src="/assets/images/download_appstore.png" alt="" title="" width="32%"></a>
					   </div>
                </div>
            </div>
        </div>
        <!-- ***** Header Text End ***** -->
    </div>
    <!-- ***** Welcome Area End ***** -->

    <!-- ***** Features Big Item Start ***** -->
    <section class="section" id="about">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12"
                    data-scroll-reveal="enter left move 30px over 0.3s after 0.2s">
                    <div class="features-item">
                        <div class="features-icon">
                            <h2>CONVENIENT</h2>
                            <img src="/assets/images/features-icon-1.svg" alt="">
                            <h4>Convenient</h4>
                            <p>We PICK and DROP packages from your door step</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12"
                    data-scroll-reveal="enter bottom move 30px over 0.4s after 0.2s">
                    <div class="features-item">
                        <div class="features-icon">
                            <h2>FAST</h2>
                            <img src="/assets/images/features-icon-2.svg" alt="">
                            <h4>Fast</h4>
                            <p>We deliver the packages within two hours of pickup.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12"
                    data-scroll-reveal="enter right move 30px over 0.4s after 0.2s">
                    <div class="features-item">
                        <div class="features-icon">
                            <h2>SECURE</h2>
                            <img src="/assets/images/features-icon-3.svg" alt="">
                            <h4>Secure</h4>
                            <p>Every package is important and we transfer it safe and secure</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Features Big Item End ***** -->

    <div class="left-image-decor"></div>

    <!-- ***** Features Big Item Start ***** -->
    <section class="section" id="promotion">
        <div class="container">
            <div class="row">
                <div class="left-image col-lg-5 col-md-12 col-sm-12 mobile-bottom-fix-big"
                    data-scroll-reveal="enter left move 30px over 0.4s after 0.2s">
                    <img src="/assets/images/left-image.svg" class="rounded img-fluid d-block mx-auto" alt="App">
                </div>
                <div class="right-text offset-lg-1 col-lg-6 col-md-12 col-sm-12 mobile-bottom-fix">
                    <ul>
                        <li data-scroll-reveal="enter right move 30px over 0.4s after 0.2s">
                            <img src="/assets/images/icon1.png" alt="">
                            <div class="text">
                                <h4>Sit back and Relax</h4>
                                <p>Spend your time with your loved ones, we pick and deliver your packages from your doorsteps</p>
                            </div>
                        </li>
                        <li data-scroll-reveal="enter right move 30px over 0.4s after 0.2s">
                            <img src="/assets/images/icon2.png" alt="">
                            <div class="text">
                                <h4>Forgot something in home</h4>
                                <p>We deliver anything like home cooked foods,files,keys,ID cards,Phones,Laptops, Medicines from your home to office</p>
                            </div>
                        </li>
                        <li data-scroll-reveal="enter right move 30px over 0.4s after 0.2s">
                            <img src="/assets/images/icon3.png" alt="">
                            <div class="text">
                                <h4>Shops and Home Business</h4>
                                <p>We take care of your logistics and you concentrate on your business</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Features Big Item End ***** -->

    <div class="right-image-decor"></div>

    <!-- ***** Footer Start ***** -->
    <footer id="contact-us">
        <div class="container">
            <div class="footer-content">
                <div class="row">
                    <!-- ***** Contact Form Start ***** -->
                    <!-- div class="col-lg-6 col-md-12 col-sm-12">
                        <div class="contact-form">
                            <form id="contact" action="" method="post">
                                <div class="row">
                                    <div class="col-md-6 col-sm-12">
                                        <fieldset>
                                            <input name="name" type="text" id="name" placeholder="Full Name" required=""
                                                style="background-color: rgba(250,250,250,0.3);">
                                        </fieldset>
                                    </div>
                                    <div class="col-md-6 col-sm-12">
                                        <fieldset>
                                            <input name="email" type="text" id="email" placeholder="E-Mail Address"
                                                required="" style="background-color: rgba(250,250,250,0.3);">
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <textarea name="message" rows="6" id="message" placeholder="Your Message"
                                                required="" style="background-color: rgba(250,250,250,0.3);"></textarea>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <button type="submit" id="form-submit" class="main-button">Send Message
                                                Now</button>
                                        </fieldset>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div-->
                    <!-- ***** Contact Form End ***** -->
                    <div class="right-content col-md-12 col-sm-12">
                        <h2>More About <em>Vedagram</em></h2>
                        <p>Vedagram is an On-Demand delivery service like no other, which aims at revolutionizing the face of logistics in your city. We are aiming to power our partners to help them grow their businesses without the worry of 'Delivery' and outsource the delivery to us. We will handle it seamlessly end to end from your store / office to your partners / vendors or directly to your Customers.Our Partners need not employ anyone to deliver their goods. We will deliver your goods safe and fast across your city within 2 hours of pickup. We have delivery boys across your city who can deliver your goods as well as pickup goods for you.We take the worry of delivering away from you and let you focus on your Business Goals. We also help you expand your reach beyond your location to cut across the city, now with us delivering your goods across the city, onboard more customers to your business and grow faster.You can collect payments through our app along with your transactions which will be trackable, accountable and reportable at any point in time.</p>
                        <ul class="social">
                            <li><a target="top" href="https://www.facebook.com/pickdrop24x7"><i class="socialmargin fab fa-facebook"></i></a></li>
                            <li><a href="https://twitter.com/pickdrop24x7"><i class="socialmargin fab fa-twitter"></i></a></li>
                            <!-- li><a href="https://www.linkedin.com/company/9466001"><i class="socialmargin fab fa-linkedin"></i></a></li-->
                            <li><a href="https://www.instagram.com/pickdrop24x7/"><i class="socialmargin fab fa-instagram"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="sub-footer">
					<section class="info_section">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<h5>Company</h5>
					<ul>
						<li><a href="/about">About</a></li>
						<li><a href="/services">Services</a></li>
						<li><a href="/privacypolicy">Privacy Policy</a></li>
						<li><a href="/tnc">Terms And Conditions</a></li>
					</ul>
				</div>
				
				<div class="col-md-3">
					<h5>Need Help?</h5>
					<ul>
						<li><a href="/faq">FAQ</a></li>
						<li><a href="/contact">Contact us</a></li>
					</ul>
				</div>
				
				<div class="col-md-3">
					<h5>My Account</h5>
					<ul>
						<li><a href="/login">Login</a></li>

					</ul>
				</div>
			</div>
		</div>
	</section>
	
                    </div>
					<p style="margin-left:10%;color:white">Copyright (c) Vedagram. All rights reserved. <a style="color:orange" href="http://www.pickdrop.in">www.pickdrop.in</a> Site Map |  Terms of Use |  Security and Privacy: <a href="privacypolicy" style="color:orange">Privacy Policy</a></p>
                </div>
            </div>
        </div>
    </footer>

	<script src="<%=request.getContextPath()%>/assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="<%=request.getContextPath()%>/assets/js/popper.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>

    <!-- Plugins -->
    <script src="<%=request.getContextPath()%>/assets/js/owl-carousel.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/scrollreveal.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/waypoints.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/jquery.counterup.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/imgfix.min.js"></script>

    <!-- Global Init -->
    <script src="<%=request.getContextPath()%>/assets/js/custom.js"></script>
   
</body>