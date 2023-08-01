package com.vedagram.sms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

/**
 *
 * @author vijay
 */
@Component
public class SmsService {
    
	private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(SmsService.class);

	@Value("${enable.otp.sending}")
	boolean enableOtp;
     
	@Value("${otp.api.key}")
	String otpApiKey;
	
	@Value("${sms.primary}")
	boolean smsPrimary;
    
    @Async
    public void sendOtp(String otp, String phoneNumber){
    	if(smsPrimary) {
    		if(enableOtp){
                try {
                	// Construct data
	    			String apiKey = "apikey=" + URLEncoder.encode(otpApiKey, "UTF-8");
	    			String message = "&message=" + URLEncoder.encode(otp, "UTF-8");
	    			String sender = "&sender=" + URLEncoder.encode("PkDrop", "UTF-8");
	    			String numbers = "&numbers=" + URLEncoder.encode("91"+phoneNumber, "UTF-8");
	    			
	    			// Send data
	    			String data = "https://api.textlocal.in/send/?" + apiKey + numbers + message + sender;
	    			URL url = new URL(data);
	    			URLConnection conn = url.openConnection();
	    			conn.setDoOutput(true);
	    			
	    			// Get the response
	    			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    			String line;
	    			String sResult="";
	    			while ((line = rd.readLine()) != null) {
	    			// Process line...
	    				sResult=sResult+line+" ";
	    			}
	    			rd.close();
	    			
	    			//return sResult;
	    		} catch (Exception e) {
	    			LOGGER.error("Error SMS "+e);
	    			//return "Error "+e;
	    		}
            }
    	} else {
    		if (enableOtp) {
    			String smsUrl = "http://sms.messagewall.in/api/v2/sms/send?";
     			try {
     				otp = URLEncoder.encode(otp, "UTF-8");
     			} catch (UnsupportedEncodingException e1) {
     				otp = otp.replace(" ", "%20");
     			}

     			if (phoneNumber != null && phoneNumber != "") {
     				HttpClient client = HttpClientBuilder.create().build();
     				HttpGet httpGet = null;
     				try {
     					URIBuilder builder = new URIBuilder(smsUrl);
     					String accessToken = "ad8dd76f80dbadb33171c05c9292694f";
     					String sender = "PkDrop";

     					builder.setParameter("access_token", accessToken);
     					builder.setParameter("sender", sender);
     					builder.setParameter("to", phoneNumber);
     					builder.setParameter("message", otp);
     					builder.setParameter("service", "T");
     					
     					httpGet = new HttpGet(builder.build());
     					client.execute(httpGet);
     				} catch (IOException e) {
     					LOGGER.error("Error SMS "+e);
     				} catch (URISyntaxException e) {
     					LOGGER.error("Error SMS "+e);
     				} finally {
     					httpGet.releaseConnection();
     				}
     			}
     			
//     			String smsUrl = "http://map-alerts.smsalerts.biz/api/web2sms.php?";
//     			try {
//     				otp = URLEncoder.encode(otp, "UTF-8");
//     			} catch (UnsupportedEncodingException e1) {
//     				otp = otp.replace(" ", "%20");
//     			}
//
//     			if (phoneNumber != null && phoneNumber != "") {
//     				HttpClient client = HttpClientBuilder.create().build();
//     				HttpGet httpGet = null;
//     				try {
//     					URIBuilder builder = new URIBuilder(smsUrl);
//     					String workingKey = "Adf4c838332da00a9d8b397e092c62cd2";
//     					String sender = "gpNpay";
//
//     					builder.setParameter("workingkey", workingKey);
//     					builder.setParameter("sender", sender);
//     					builder.setParameter("to", phoneNumber);
//     					builder.setParameter("message", otp);
//
//     					httpGet = new HttpGet(builder.build());
//     					client.execute(httpGet);
//     				} catch (IOException e) {
//     					LOGGER.error("Error SMS "+e);
//     				} catch (URISyntaxException e) {
//     					LOGGER.error("Error SMS "+e);
//     				} finally {
//     					httpGet.releaseConnection();
//     				}
//     			}
     		}
    	}
    }
    
    //Chari: Added for sending sms to the users
    @Async
    public void sendSms(String msg,String phoneNumber){
    	if(smsPrimary) {
    		if(enableOtp){
                try {
	    			// Construct data
	    			String apiKey = "apikey=" + URLEncoder.encode(otpApiKey, "UTF-8");
	    			String message = "&message=" + URLEncoder.encode(msg, "UTF-8");
	    			String sender = "&sender=" + URLEncoder.encode("PkDrop", "UTF-8");
	    			String numbers = "&numbers=" + URLEncoder.encode("91"+phoneNumber, "UTF-8");
	    			
	    			// Send data
	    			String data = "https://api.textlocal.in/send?" + apiKey + numbers + message + sender;
	    			URL url = new URL(data);
	    			URLConnection conn = url.openConnection();
	    			conn.setDoOutput(true);
	    			
	    			// Get the response
	    			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    			String line;
	    			String sResult="";
	    			while ((line = rd.readLine()) != null) {
	    			// Process line...
	    				sResult=sResult+line+" ";
	    			}
	    			rd.close();
	    			
	    			//return sResult;
	    		} catch (Exception e) {
	    			LOGGER.error("Error SMS "+e);
	    			//return "Error "+e;
	    		}
            }
    	} else {
    		if (enableOtp) {
    			String smsUrl = "http://map-alerts.smsalerts.biz/api/web2sms.php?";
    			try {
    				msg = URLEncoder.encode(msg, "UTF-8");
    			} catch (UnsupportedEncodingException e1) {
    				msg = msg.replace(" ", "%20");
    			}

    			if (phoneNumber != null && phoneNumber != "") {
    				HttpClient client = HttpClientBuilder.create().build();
    				HttpGet httpGet = null;
    				try {
    					URIBuilder builder = new URIBuilder(smsUrl);
    					String accessToken = "ad8dd76f80dbadb33171c05c9292694f";
     					String sender = "PkDrop";

     					builder.setParameter("access_token", accessToken);
     					builder.setParameter("sender", sender);
     					builder.setParameter("to", phoneNumber);
     					builder.setParameter("message", msg);
     					builder.setParameter("service", "T");

    					httpGet = new HttpGet(builder.build());
    					client.execute(httpGet);
    				} catch (IOException e) {
    					LOGGER.error("Error SMS "+e);
    				} catch (URISyntaxException e) {
    					LOGGER.error("Error SMS "+e);
    				} finally {
    					httpGet.releaseConnection();
    				}
    			}
    			
//    			String smsUrl = "http://map-alerts.smsalerts.biz/api/web2sms.php?";
//    			try {
//    				msg = URLEncoder.encode(msg, "UTF-8");
//    			} catch (UnsupportedEncodingException e1) {
//    				msg = msg.replace(" ", "%20");
//    			}
//
//    			if (phoneNumber != null && phoneNumber != "") {
//    				HttpClient client = HttpClientBuilder.create().build();
//    				HttpGet httpGet = null;
//    				try {
//    					URIBuilder builder = new URIBuilder(smsUrl);
//    					String workingKey = "Adf4c838332da00a9d8b397e092c62cd2";
//    					String sender = "gpNpay";
//
//    					builder.setParameter("workingkey", workingKey);
//    					builder.setParameter("sender", sender);
//    					builder.setParameter("to", phoneNumber);
//    					builder.setParameter("message", msg);
//
//    					httpGet = new HttpGet(builder.build());
//    					client.execute(httpGet);
//    				} catch (IOException e) {
//    					LOGGER.error("Error SMS "+e);
//    				} catch (URISyntaxException e) {
//    					LOGGER.error("Error SMS "+e);
//    				} finally {
//    					httpGet.releaseConnection();
//    				}
//    			}
    		}
    	}
    }
}
