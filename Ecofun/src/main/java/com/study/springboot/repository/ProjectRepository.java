package com.study.springboot.repository;

import java.sql.Date;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.ProjectDto;

@Repository
public interface ProjectRepository extends JpaRepository<ProjectDto, Long> {
	public Page<ProjectDto> findAll(Pageable pageable);
	public Page<ProjectDto> findByProStartBeforeAndProEndAfter(Date now1, Date now2, Pageable pageable);
	public Page<ProjectDto> findByProEndBefore(Date now, Pageable pageable);
	public Page<ProjectDto> findByProStartAfter(Date now, Pageable pageable);

	public Page<ProjectDto> findByProType(String proType, Pageable pageable);
	public Page<ProjectDto> findByProStartBeforeAndProEndAfterAndProType(Date now1, Date now2, String proType, Pageable pageable);
	public Page<ProjectDto> findByProEndBeforeAndProType(Date now, String proType, Pageable pageable);
	public Page<ProjectDto> findByProStartAfterAndProType(Date now, String proType, Pageable pageable);

	public ProjectDto findByProNo(Long proNo);
	
	public List<ProjectDto> findAllByMemNo(Long memNo);
	public List<ProjectDto> findAllByProTitleLike(String keyword);
	
	public int countByProState(String proState);
	public int countByProStateAndProType(String proState, String proType);
}