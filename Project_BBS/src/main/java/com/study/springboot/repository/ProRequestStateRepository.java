package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.ProRequestStateDto;

@Repository
public interface ProRequestStateRepository extends JpaRepository<ProRequestStateDto, Long>{
	public Page<ProRequestStateDto> findAll(Pageable pageable);
	public Page<ProRequestStateDto> findByReqsMemNo(Long reqsMemNo, Pageable pageable);
	public ProRequestStateDto findByReqNo(Long reqNo);
}
