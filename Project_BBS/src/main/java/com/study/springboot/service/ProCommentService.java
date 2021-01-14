package com.study.springboot.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.dto.ProCommentDto;
import com.study.springboot.repository.ProCommentRepository;

@Service
public class ProCommentService {

	@Autowired
	private ProCommentRepository proCmtRepository;

	// 목록
	@Transactional
	public Page<ProCommentDto> getCommentList(Long proNo, Pageable pageable) {
		return proCmtRepository.findByProNo(proNo, pageable);
	}
	
	// 입력
	@Transactional
	public ProCommentDto setComment(ProCommentDto proCmtDto) {
		proCmtDto.setProCmtDate(LocalDateTime.now());
		return proCmtRepository.save(proCmtDto);
	}

	// 카운트
	@Transactional
	public long countComment() {
		return proCmtRepository.count();
	}

}