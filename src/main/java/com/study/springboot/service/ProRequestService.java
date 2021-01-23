package com.study.springboot.service;

import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.study.springboot.dto.ProRequestDto;
import com.study.springboot.repository.ProRequestRepository;

@Service
public class ProRequestService {

	@Autowired
	private ProRequestRepository proRequestRepository;

	public ProRequestDto save(ProRequestDto proRequest, HttpServletRequest request, HttpSession session) throws NoSuchAlgorithmException {
		Long memNo = (Long) session.getAttribute("memNo");
		proRequest.setMemNo(memNo);
		proRequest.setReqDate(LocalDateTime.now());
		proRequest.setReqTitle(request.getParameter("req_title"));
		String content = request.getParameter("textAreaContent");
		content.replace("\r\n", "<br/>"); // 줄바꿈 그대로 저장하기. 안하면 나중에 한줄로만 나옴(공백으로 인식해서)
		proRequest.setReqContent(content);

		return proRequestRepository.save(proRequest);
	}

	// 신청서 목록 (관리자용)
	public Page<ProRequestDto> getAllProRequestList(Pageable pageable) {
		return proRequestRepository.findAll(pageable);
	}

	// 신청서 목록 (사용자용)
	public Page<ProRequestDto> getProRequestList(Long memNo, Pageable pageable) {
		return proRequestRepository.findAllByMemNo(memNo, pageable);
	}

	// 신청서 상세
	public ProRequestDto getProRequest(Long reqNo) {
		return proRequestRepository.findByReqNo(reqNo);
	}

	// 신청서 카운트 (관리자용)
	public int countRequest() {
		return Long.valueOf(proRequestRepository.count()).intValue();
	}

	// 신청서 카운트 (사용자용)
	public int countByMemNo(Long memNo) {
		return Long.valueOf(proRequestRepository.countByMemNo(memNo)).intValue();
	}
}