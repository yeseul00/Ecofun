package com.study.springboot.util;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	private JavaMailSender sender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;

	// MailHandler???앹꽦??
	public MailHandler(JavaMailSender jSender) throws MessagingException {
		this.sender = jSender;
		message = jSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, false, "UTF-8");
		// MimeMessageHelper???앹꽦???먮쾲吏??뚮씪誘명꽣???ㅼ닔???щ엺?먭쾶 蹂대궪 ???덈뒗 ?ㅼ젙, ?몃쾲吏몃뒗 湲곕낯 ?몄퐫??諛⑹떇
	}

	// 蹂대궡???щ엺???대찓?? ?대쫫
	public void setFrom(String fromMail, String fromName) throws MessagingException, UnsupportedEncodingException {
		messageHelper.setFrom(fromMail, fromName);
	}

	// 諛쏅뒗 ?щ엺???대찓??
	public void setTo(String toMail) throws MessagingException {
		messageHelper.setTo(toMail);
	}

	// ?쒕ぉ
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}

	// ?댁슜
	public void setText(String text, boolean useHtml) throws MessagingException {
		messageHelper.setText(text, useHtml);
		// ?먮쾲吏??뚮씪誘명꽣??html ?곸슜 ?щ?. true??html?뺤떇?쇰줈 ?묒꽦?섎㈃ html?뺤떇?쇰줈 蹂댁엫.
	}

	// 泥⑤? ?뚯씪
	public void setAttach(String displayFileName, String pathToAttachment) throws MessagingException, IOException {
		File file = new ClassPathResource(pathToAttachment).getFile();
		FileSystemResource fsr = new FileSystemResource(file);
		messageHelper.addAttachment(displayFileName, fsr);
	}

	// ?대?吏 ?쎌엯
	public void setInline(String contentId, String pathToInline) throws MessagingException, IOException {
		File file = new ClassPathResource(pathToInline).getFile();
		FileSystemResource fsr = new FileSystemResource(file);
		messageHelper.addInline(contentId, fsr);
	}

	// 諛쒖넚
	public void send() {
		try {
			sender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 李멸퀬(https://docs.spring.io/spring/docs/3.0.0.M3/reference/html/ch26s03.html)
	// public void addInline(String contentId, Resource resource) throws MessagingException {
	// messageHelper.addInline(contentId, resource);
	// }
	// public void addInline(String contentId, File file) throws MessagingException {
	// messageHelper.addInline(contentId, file);
	// }
	// public void addInline(String contentId, DataSource source) throws MessagingException {
	// messageHelper.addInline(contentId, source);
	// }
}
