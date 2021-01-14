package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.ProCommentDto;

@Repository
public interface ProCommentRepository extends JpaRepository<ProCommentDto, Long> {
	public Page<ProCommentDto> findByProNo(Long proNo, Pageable pageable);
}
