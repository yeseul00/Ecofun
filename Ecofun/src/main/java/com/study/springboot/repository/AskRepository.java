package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.AskDto;

@Repository
public interface AskRepository extends JpaRepository<AskDto, Long> {
	public Page<AskDto> findAll(Pageable pageable);
	public Page<AskDto> findByMemNo(Long MemNo, Pageable pageable);
	public AskDto findByAskNo(Long askNo);
	public int countByMemNo(Long MemNo);
}
