package com.vedagram.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class CustomClientHttpRequestInterceptor implements HandlerInterceptor {

    private static final Logger LOGGERREQ = LoggerFactory.getLogger("RR.request");
    private static final Logger LOGGERRES = LoggerFactory.getLogger("RR.response");

    @Override
    public boolean preHandle(HttpServletRequest hsr, HttpServletResponse hsr1, Object o) throws Exception {
		String requestUrl = hsr.getRequestURI().substring(hsr.getContextPath().length());
		if (requestUrl.contains("/v/sendPackage") || requestUrl.contains("/v/trackPackage")
				|| requestUrl.contains("/v/schedules") || requestUrl.contains("/v/manageFavourites")) {
			if (hsr.getSession().getAttribute("Role").toString().equals("ROLE_VENDOR")
					&& (hsr.getSession().getAttribute("loginViaAdmin") == null || !hsr.getSession().getAttribute("loginViaAdmin").toString().equals("true"))) {
				String redirect = hsr.getContextPath() + "/v/vendorHome";
				hsr1.sendRedirect(redirect);
				hsr1.flushBuffer();
				return false;
			}
		}
        return true;
    }

    /*@Override
    public void afterCompletion(HttpServletRequest hsr, HttpServletResponse hsr1, Object o, Exception excptn) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private String getContentAsString(byte[] buf, String charsetName) {
        if (buf == null || buf.length == 0) {
            return "";
        }

        try {
            int length = Math.min(buf.length, 1000);

            return new String(buf, 0, length, charsetName);
        } catch (UnsupportedEncodingException ex) {
            return "Unsupported Encoding";
        }
    }

    @Override
    public void postHandle(HttpServletRequest hsr, HttpServletResponse hsr1, Object o, ModelAndView mav) throws Exception {
        ContentCachingRequestWrapper wrappedRequest = new ContentCachingRequestWrapper(hsr);
        ContentCachingResponseWrapper wrappedResponse = new ContentCachingResponseWrapper(hsr1);
        String requestBody = this.getContentAsString(wrappedRequest.getContentAsByteArray(), hsr.getCharacterEncoding());
        if (requestBody.length() > 0) {
            this.LOGGERREQ.debug("   Request body:\n" + requestBody);
        }
        byte[] buf = wrappedResponse.getContentAsByteArray();
        CustomClientHttpRequestInterceptor.LOGGERRES.debug("   Response body:\n" + getContentAsString(buf, hsr1.getCharacterEncoding()));

    }*/

}
