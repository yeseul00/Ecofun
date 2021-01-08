package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.ApplyDto;

@Repository
public interface ApplyRepository extends JpaRepository<ApplyDto, Long> {
	public Page<ApplyDto> findAll(Pageable pageable);
	public Page<ApplyDto> findAllByMemNo(Long MemNo, Pageable pageable);
	public ApplyDto findByAplNo(Long aplNo);
	public int countByMemNo(Long MemNo);
}
