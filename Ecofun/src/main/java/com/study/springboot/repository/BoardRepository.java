package com.study.springboot.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.BoardDto;

@Repository
public interface BoardRepository extends JpaRepository<BoardDto, Long> {

	public Page<BoardDto> findAllByBbsType(String bbsType, Pageable pageable);

	public BoardDto findByBbsNo(Long bbsNo);

	public int countByBbsType(String bbsType);
}
