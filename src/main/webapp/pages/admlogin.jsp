<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
	$(document).ready(function() {

	});
</script>

<div id="main-body">
	<div class="wrapper">
		<div class="top-strip ">
			<!-- contact section -->
			<section class="contact_section layout_padding">
				<div class="container">
					<h5 class="font-weight-bold">Admin Login</h5>
					<div class="row">
						<div class="col-md-8 mr-auto">
							<form action="<%=request.getContextPath() %>/login" method="post">
								<div class="contact_form-container">
									<div>
										<div>
											<input type="text" name="username" placeholder="User Name">
										</div>
										<div>
											<input type="password" name="password" placeholder="Password">
										</div>

										<div class="mt-5">
											<button type="submit" id="loginBtn">Login</button>
										</div>
									</div>

								</div>

							</form>
						</div>
					</div>
				</div>
			</section>
			<!-- end contact section -->
		</div>
		<div class="clearing"></div>
		<!--- top strip div end -->

		<!--- panel wrapper div end -->
	</div>
</div>