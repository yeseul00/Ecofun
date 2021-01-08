package com.study.springboot.service;

import java.time.LocalDateTime;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.AskDto;
import com.study.springboot.repository.AskRepository;

@Service
public class AskService {

	@Autowired
	private AskRepository askRepository;

	// 문의 저장
	public AskDto save(AskDto askDto, HttpSession session) {
		Long memNo = (Long) session.getAttribute("memNo");
		askDto.setAskDate(LocalDateTime.now());
		askDto.setAskState("검토중");
		askDto.setMemNo(memNo);
		return askRepository.save(askDto);
	}

	// 문의 목록 (관리자용)
	public Page<AskDto> findAll(Pageable page) {
		return askRepository.findAll(page);
	}

	// 문의 목록 (사용자용)
	public Page<AskDto> findAllByMemNo(Long memNo, Pageable pageable) {
		return askRepository.findByMemNo(memNo, pageable);
	}

	// 문의 상세
	public AskDto findByAskNo(Long askNo) {
		return askRepository.findByAskNo(askNo);
	}

	// 문의 카운트 (관리자용)
	public int count() {
		return Long.valueOf(askRepository.count()).intValue();
	}

	// 문의 카운트 (사용자용)
	public int countByMemNo(Long memNo) {
		return Long.valueOf(askRepository.countByMemNo(memNo)).intValue();
	}
}
