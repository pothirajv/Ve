package com.vedagram.config;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.vedagram.support.util.ApiError;

public class UnauthenticatedRequestHandler implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException {
		if (request.getServletPath().startsWith("/api/")) {
			response.setStatus(403);
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, authException.getLocalizedMessage());
			setUnauthorizedResponse(response, authException);
		} else {
			response.sendRedirect(request.getContextPath() + "/");
		}
	}

	public void setUnauthorizedResponse(HttpServletResponse response, Exception e) {
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		response.setContentType("application/json");
		ApiError apiError = new ApiError(HttpStatus.UNAUTHORIZED, e.getLocalizedMessage());
		try {
			PrintWriter out = response.getWriter();
			out.println(apiError.convertToJson());
		} catch (IOException ex) {
			// logger.error("Error", ex);
		}
	}
}