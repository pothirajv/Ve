<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<script type="text/javascript">
	$(document).ready(function() {

	});
</script>

<section id="main-body" class="container"
	style="font-family: 'Poppins', sans-serif;">

	<c:choose>
		<c:when test="${TransMsg == 'SUCCESS' || TransMsg == 'success'}">
			<div
				style="font-weight: bold; padding: 30px 0px; text-align: center; color: red;">Thanks
				for your payment</div>

			<div style="display: none;">
				<div>Transaction Id : ${ResTranId}</div>
				<div>Track Id : ${ResTrackId}</div>
			</div>

			<div style="text-align: center; color: red;">
				<a href="www.pickdrop.in/payres/successpayhome"
					style="text-decoration: initial; display: inline-block; padding: 2px 0px; width: 120px; background: #6ecac8; color: #f7f7f7; border: 1px solid transparent;">Home</a>
				<a href="www.pickdrop.in/payres/successpay"
					style="text-decoration: initial; display: inline-block; padding: 2px 0px; width: 120px; background: #000000; color: #f7f7f7; border: 1px solid transparent;">Track
					Order</a>
			</div>
		</c:when>
		<c:otherwise>
			<div
				style="font-weight: bold; padding: 30px 0px; text-align: center; color: red;">Problem
				in payment</div>
			<div style="text-align: center; color: red;">
				<a href="www.pickdrop.in/payres/failretry"
					style="text-decoration: initial; padding: 3px 20px; background: #6ecac8; color: #f7f7f7; border: 1px solid transparent;">Retry</a>
			</div>
		</c:otherwise>
	</c:choose>

	<div class="clearfix"></div>
</section>