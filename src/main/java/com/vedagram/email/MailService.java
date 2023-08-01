package com.vedagram.email;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
@PropertySource("classpath:mail.properties")
public class MailService {

	@Value("${test.mobile.number}")
    String testMobileNumber;
	
	@Value("${from.address}")
    String fromAddress;

	@Value("${auth.password}")
    String authPassword;
	
	@Value("${host.name}")
    String hostName;
	
	@Value("${mail.smtp.starttls.enable}")
    String starttls;
	
	@Value("${mail.smtp.auth}")
    String smtpAuth;
	
	@Value("${mail.port}")
    String mailPort;
	
	@Value("${registerMailContent}")
    String registerMailContent;
	
	@Async
	public String sendEmail(final String[] toAdd,final String[] ccAdd,final String subject, final String content) {

		Properties props = new Properties();    
		props.put("mail.smtp.host", hostName);    
        props.put("mail.smtp.starttls.enable", starttls);
        props.put("mail.smtp.auth", smtpAuth);    
        props.put("mail.smtp.port", mailPort);
        props.put("mail.smtp.ssl.trust", hostName);
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.debug", "false");
        
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromAddress, authPassword);
			}
		});
        Message message = new MimeMessage(session);
        try {
			message.setFrom(new InternetAddress(fromAddress));
			for(String to:toAdd) {
			message.setRecipient(Message.RecipientType.TO,new InternetAddress(to));
			}
			for(String cc:ccAdd) {
				message.addRecipient(Message.RecipientType.CC,new InternetAddress(cc));
				}
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
        
        try {
			message.setSubject(subject);

			message.setContent(content, "text/html");
			Transport.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		return "SENT";
	}
	
	@Async
	public String sendEmailWithAttachment (final String[] toAdd,final String[] ccAdd,final String subject, final String content) throws IOException {

		Properties props = new Properties();    
		props.put("mail.smtp.host", hostName);    
        props.put("mail.smtp.starttls.enable", starttls);
        props.put("mail.smtp.auth", smtpAuth);    
        props.put("mail.smtp.port", mailPort);
        props.put("mail.smtp.ssl.trust", hostName);
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.debug", "false");
        
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromAddress, authPassword);
			}
		});
        Message message = new MimeMessage(session);
        try {
			message.setFrom(new InternetAddress(fromAddress));
			for(String to:toAdd) {
			message.setRecipient(Message.RecipientType.TO,new InternetAddress(to));
			}
			for(String cc:ccAdd) {
				message.addRecipient(Message.RecipientType.CC,new InternetAddress(cc));
				}
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
        
        try {
			message.setSubject(subject);
			BodyPart messageBodyPart = new MimeBodyPart(); 
			messageBodyPart.setText("Attached are the scheduled orders for "+LocalDate.now().plusDays(1));
			MimeBodyPart attachmentPart = new MimeBodyPart();
			File todayReport=new File(content);
			attachmentPart.attachFile(todayReport);
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			multipart.addBodyPart(attachmentPart);
			message.setContent(multipart);
			Transport.send(message);
			File yesterdayReport=new File("SenderRequestModel_"+LocalDate.now().minusDays(1)+".xlsx");
			if(yesterdayReport.exists()) {
				yesterdayReport.delete();
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		return "SENT";
	}
}
