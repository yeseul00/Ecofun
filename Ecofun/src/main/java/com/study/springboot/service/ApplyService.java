package com.study.springboot.service;

import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ApplyDto;
import com.study.springboot.repository.ApplyRepository;

@Service
public class ApplyService {

	@Autowired
	private ApplyRepository applyRepository;

	// 신청서 목록 (관리자용)
	public Page<ApplyDto> findAll(Pageable pageable) {
		return applyRepository.findAll(pageable);
	}

	// 신청서 목록 (사용자용)
	public Page<ApplyDto> findAllByMemNo(Long memNo, Pageable pageable) {
		return applyRepository.findAllByMemNo(memNo, pageable);
	}

	// 신청서 상세
	public ApplyDto findByAplNo(Long aplNo) {
		return applyRepository.findByAplNo(aplNo);
	}

	// 신청서 카운트 (관리자용)
	public int countApl() {
		return Long.valueOf(applyRepository.count()).intValue();
	}

	// 신청서 카운트 (사용자용)
	public int countByMemNo(Long memNo) {
		return Long.valueOf(applyRepository.countByMemNo(memNo)).intValue();
	}

	// 신청서 입력
	public ApplyDto save(ApplyDto apl, HttpServletRequest request, HttpSession session) throws NoSuchAlgorithmException {
		Long memNo = (Long) session.getAttribute("memNo");
		apl.setMemNo(memNo);
		apl.setAplDate(LocalDateTime.now());
		apl.setAplTitle(request.getParameter("req_title"));
		String content = request.getParameter("textAreaContent");
		content.replace("\r\n", "<br/>"); // 줄바꿈 그대로 저장하기. 안하면 나중에 한줄로만 나옴(공백으로 인식해서)
		apl.setAplContent(content);

		return applyRepository.save(apl);
	}
}
