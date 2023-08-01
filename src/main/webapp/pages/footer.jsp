<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<style>

footer {
  padding-top: 50px;
  background-image: url(../assets/images/footer-bg1.jpg);
  background-repeat: no-repeat;
  background-position: center center;
  background-size: cover;
  width: 100%;
  float: left;
}
footer .copyright {
  margin-top: 10px;
  font-weight: 400;
  font-size: 15px;
  color: #4a4a4a;
  letter-spacing: 0.88px;
  text-transform: capitalize;
}

footer .sub-footer {
/*   border-top: 1px solid rgba(250,250,250,0.3); */
  text-align: center;
}

footer .sub-footer a {
	color: #FFF;
}
footer .sub-footer h5 {
	color: #e7e7e7;
}
footer .sub-footer a:hover {
	color: #FC3;
}

footer .sub-footer p {
  color: #fff;
  font-size: 15px;
  font-weight: 300;
  letter-spacing: 0.5px;
}

@media (max-width: 991px) {
  footer .copyright {
    text-align: center;
  }
  footer .social {
    text-align: center;
  }
}
</style>

<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
<footer id="footer">
             <div class="row1">
                <div class="col-md-12">
                    <div class="sub-footer">
	<section class="info_section">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<h5>Company</h5>
					<ul>
						<li><a href="<%=request.getContextPath()%>/about">About</a></li>
						<li><a href="<%=request.getContextPath()%>/services">Services</a></li>
						<li><a href="<%=request.getContextPath()%>/privacypolicy">Privacy Policy</a></li>
						<li><a href="<%=request.getContextPath()%>/tnc">Terms And Conditions</a></li>
					</ul>
				</div>
				
				<div class="col-md-3">
					<h5>Need Help?</h5>
					<ul>
						<li><a href="<%=request.getContextPath()%>/faq">FAQ</a></li>
						<li><a href="<%=request.getContextPath()%>/contact">Contact us</a></li>
					</ul>
				</div>
				
				<div class="col-md-3">
					<h5>My Account</h5>
					<ul>
						<li><a href="<%=request.getContextPath()%>/login">Login</a></li>

					</ul>
				</div>
			</div>
		</div>
	</section>
	
                    </div>
					<p style="margin-left:20%;color:white">Copyright (c) Vedagram. All rights reserved. <a style="color:orange" href="http://www.pickdrop.in">www.pickdrop.in</a> Site Map |  Terms of Use |  Security and Privacy: <a href="privacypolicy" style="color:orange">Privacy Policy</a></p>
                </div>
            </div>
    </footer>