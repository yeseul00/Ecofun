package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.ProRequestDto;

@Repository
public interface ProRequestRepository extends JpaRepository<ProRequestDto, Long> {
	public Page<ProRequestDto> findAll(Pageable pageable);
	public Page<ProRequestDto> findAllByMemNo(Long MemNo, Pageable pageable);
	public ProRequestDto findByReqNo(Long reqNo);
	public int countByMemNo(Long MemNo);
}
