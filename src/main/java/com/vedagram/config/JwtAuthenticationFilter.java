package com.vedagram.config;

import static com.vedagram.support.constant.SecurityConstants.HEADER_STRING;
import static com.vedagram.support.constant.SecurityConstants.OTHER_HEADERS;
import static com.vedagram.support.constant.SecurityConstants.SECRET;
import static com.vedagram.support.constant.SecurityConstants.TOKEN_PREFIX;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import com.vedagram.repository.UserRepository;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.support.constant.ErrorConstants;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.ApiError;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;

public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

	private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(JwtAuthenticationFilter.class);
	UserRepository userRepository;
	
	 @Value("${auth.header.strings}")
	 String authHeaderString;

	public JwtAuthenticationFilter(AuthenticationManager authenticationManager, UserRepository userRepository) {
		super(authenticationManager);
		this.userRepository = userRepository;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
			throws IOException, ServletException, UsernameNotFoundException {
		String header = req.getHeader(HEADER_STRING);
		String tokenPrefix="";
		if(header==null) {
			
			String [] authHeaderStrings=OTHER_HEADERS.split(",");
			for(String authHeader:authHeaderStrings) {
			LOGGER.debug("External system API -->"+authHeader);
			header = req.getHeader(authHeader);
			}
		}else {
			tokenPrefix=TOKEN_PREFIX;
		}
		if (header == null && req.getSession() != null && req.getSession().getAttribute(HEADER_STRING) != null) {
			header = req.getSession().getAttribute(HEADER_STRING).toString();
			tokenPrefix=TOKEN_PREFIX;
		}

		if (header == null) {
			chain.doFilter(req, res);
		} else {
			UsernamePasswordAuthenticationToken authentication = getAuthentication(header,tokenPrefix);
			SecurityContextHolder.getContext().setAuthentication(authentication);

			if (authentication != null) {
				MDC.put("traceUser", authentication.getPrincipal().toString());
				MDC.put("traceID", UUID.randomUUID().toString().replace("-", ""));
				chain.doFilter(req, res);
			}else {
				throw new UsernameNotFoundException(ErrorConstants.TOKEN_VALIDATION_FAILED);
			}
		}
	}

	private UsernamePasswordAuthenticationToken getAuthentication(String token,String tokenPrefix) {
		PrincipalDetails principalDetails = new PrincipalDetails();
		if (token != null) {
			Jws<Claims> jws = Jwts.parser().setSigningKey(SECRET).parseClaimsJws(token.replace(tokenPrefix, ""));
			String email = jws.getBody().get("email") == null ? "" : jws.getBody().get("email").toString();
			String mobileNo = jws.getBody().get("mobileNumber") == null ? ""
					: jws.getBody().get("mobileNumber").toString();

			UserModel userModel = checkUserAndTokenStatus(mobileNo, email, token.replace(tokenPrefix, ""));

			if ((userModel != null 
					&& userModel.getUserToken().equals(token.replace(tokenPrefix, "")))) {
				principalDetails.setMobileNumber(mobileNo);
				principalDetails.setEmail(email);
				principalDetails.setUserId((String) jws.getBody().get("userID"));
				principalDetails.setRole((String) jws.getBody().get("role"));
				principalDetails.setVendorName(userModel.getVendorName());
				String roles;
				roles = (String) jws.getBody().get("role");
				List<GrantedAuthority> grantedAuths = AuthorityUtils.commaSeparatedStringToAuthorityList(roles);
				LOGGER.debug("User ID -->"+(String) jws.getBody().get("userID")+","+mobileNo);
				return new UsernamePasswordAuthenticationToken(principalDetails, null, grantedAuths);
			} else {
				return null;
				// logger.error(ErrorConstants.INVALID_USER_STATUS);
				// throw new UsernameNotFoundException(ErrorConstants.INVALID_USER_STATUS);
			}
		} else {
			// logger.error(ErrorConstants.INVALID_USER_STATUS);
			// throw new UsernameNotFoundException(ErrorConstants.INVALID_USER_STATUS);
			return null;
		}
	}

	public UserModel checkUserAndTokenStatus(String mobileNumber, String email, String token) {
		UserModel um = null;
		try {
			if (email != null && !email.isEmpty()) {
				um = userRepository.findByEmailIgnoreCase(email);
			}
		} catch (Exception e) {
			logger.error(e);
		}
		return um;
	}

	public void setUnauthorizedResponse(HttpServletResponse response, Exception e) {
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		response.setContentType("application/json");
		ApiError apiError = new ApiError(HttpStatus.UNAUTHORIZED, e.getLocalizedMessage());
		try {
			PrintWriter out = response.getWriter();
			out.println(apiError.convertToJson());
		} catch (IOException ex) {
			logger.error("Error", ex);
		}
	}
}
