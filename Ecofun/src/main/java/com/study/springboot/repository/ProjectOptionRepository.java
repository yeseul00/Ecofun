package com.study.springboot.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.ProjectOptionDto;

@Repository
public interface ProjectOptionRepository extends JpaRepository<ProjectOptionDto, Long> {
	public ProjectOptionDto findByOpNo(Long opNo);
	public ProjectOptionDto findByProNo(Long proNo);
	public List<ProjectOptionDto> findAllByProNo(Long proNo);
}
