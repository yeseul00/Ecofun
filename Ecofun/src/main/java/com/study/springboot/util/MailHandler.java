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

	// MailHandler의 생성자
	public MailHandler(JavaMailSender jSender) throws MessagingException {
		this.sender = jSender;
		message = jSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, false, "UTF-8");
		// MimeMessageHelper의 생성자 두번째 파라미터는 다수의 사람에게 보낼 수 있는 설정, 세번째는 기본 인코딩 방식
	}

	// 보내는 사람의 이메일, 이름
	public void setFrom(String fromMail, String fromName) throws MessagingException, UnsupportedEncodingException {
		messageHelper.setFrom(fromMail, fromName);
	}

	// 받는 사람의 이메일
	public void setTo(String toMail) throws MessagingException {
		messageHelper.setTo(toMail);
	}

	// 제목
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}

	// 내용
	public void setText(String text, boolean useHtml) throws MessagingException {
		messageHelper.setText(text, useHtml);
		// 두번째 파라미터는 html 적용 여부. true시 html형식으로 작성하면 html형식으로 보임.
	}

	// 첨부 파일
	public void setAttach(String displayFileName, String pathToAttachment) throws MessagingException, IOException {
		File file = new ClassPathResource(pathToAttachment).getFile();
		FileSystemResource fsr = new FileSystemResource(file);
		messageHelper.addAttachment(displayFileName, fsr);
	}

	// 이미지 삽입
	public void setInline(String contentId, String pathToInline) throws MessagingException, IOException {
		File file = new ClassPathResource(pathToInline).getFile();
		FileSystemResource fsr = new FileSystemResource(file);
		messageHelper.addInline(contentId, fsr);
	}

	// 발송
	public void send() {
		try {
			sender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 참고(https://docs.spring.io/spring/docs/3.0.0.M3/reference/html/ch26s03.html)
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
