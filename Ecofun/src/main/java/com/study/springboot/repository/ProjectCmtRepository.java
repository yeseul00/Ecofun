package com.study.springboot.repository;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.ProjectCmtDto;

@Repository
public interface ProjectCmtRepository extends JpaRepository<ProjectCmtDto, Long> {
	public List<ProjectCmtDto> findAllByProNo(Long proNo);

	public Page<ProjectCmtDto> findAllByProNo(Long proNo, Pageable pageable);
}
