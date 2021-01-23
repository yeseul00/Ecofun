package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.study.springboot.dto.ProRequestStateDto;
import com.study.springboot.repository.ProRequestStateRepository;

@Service
public class ProRequestStateService {

	@Autowired
	private ProRequestStateRepository proRequestStateRepository;

	// 신청서 상태 목록 (관리자용)
	public Page<ProRequestStateDto> getAllProRequestStateList(Pageable pageable) {
		return proRequestStateRepository.findAll(pageable);
	}

	// 신청서 상태 목록 (사용자용)
	public Page<ProRequestStateDto> getProRequestStateList(Long memNo, Pageable pageable) {
		return proRequestStateRepository.findByReqsMemNo(memNo, pageable);
	}

	// 신청서 상태 상세
	public ProRequestStateDto getProRequestState(Long reqNo) {
		return proRequestStateRepository.findByReqNo(reqNo);
	}

}