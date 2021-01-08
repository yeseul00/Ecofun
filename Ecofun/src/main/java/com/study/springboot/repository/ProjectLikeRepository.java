package com.study.springboot.repository;

import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.ProjectLikeDto;

@Repository
public interface ProjectLikeRepository extends JpaRepository<ProjectLikeDto, Long> {

	public Optional<ProjectLikeDto> findByMemNoAndProNo(Long memNo, Long proNo);

	public Long countByMemNoAndProNo(Long memNo, Long proNo);

	@Transactional
	public Long deleteByMemNoAndProNo(Long memNo, Long proNo);

	public List<ProjectLikeDto> findAllByMemNo(Long memNo);

	public Page<ProjectLikeDto> findAllByMemNo(Long memNo, Pageable pageable);

	@Query(value = "SELECT f.* FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType", countQuery = "SELECT COUNT(*) FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType", // 네이티브
																																																																					// 쿼리에서
																																																																					// Pageable을
																																																																					// 사용하기
																																																																					// 위한
																																																																					// countQuery
		nativeQuery = true)
	public Page<ProjectLikeDto> findAllByMemNoAndProType(@Param("memNo") Long memNo, @Param("proType") String proType, Pageable pageable);

	@Query(value = "SELECT 	f.* FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_state = :proState ", countQuery = "SELECT COUNT(*) FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_state = :proState", // 네이티브
																																																																							// 쿼리에서
																																																																							// Pageable을
																																																																							// 사용하기
																																																																							// 위한
																																																																							// countQuery
		nativeQuery = true)
	public Page<ProjectLikeDto> findAllByMemNoAndProState(@Param("memNo") Long memNo, @Param("proState") String proState, Pageable pageable);

	@Query(value = "SELECT 	f.* FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType AND p.pro_state = :proState", countQuery = "SELECT COUNT(*) FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType AND p.pro_state = :proState", // 네이티브
																																																																																			// 쿼리에서
																																																																																			// Pageable을
																																																																																			// 사용하기
																																																																																			// 위한
																																																																																			// countQuery
		nativeQuery = true)
	public Page<ProjectLikeDto> findAllByMemNoAndProTypeAndProState(@Param("memNo") Long memNo, @Param("proType") String proType, @Param("proState") String proState, Pageable pageable);

	@Query(value = "SELECT COUNT(*) FROM project_like f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_state = :proState", nativeQuery = true)
	public int countByMemNoAndProState(@Param("memNo") Long memNo, @Param("proState") String proState);
}
