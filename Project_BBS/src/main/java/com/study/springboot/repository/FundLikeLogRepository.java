package com.study.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.dto.FundLikeLogDto;

@Repository
public interface FundLikeLogRepository extends JpaRepository<FundLikeLogDto, Long> {

	public Optional<FundLikeLogDto> findByMemNoAndProNo(Long memNo, Long proNo);

	public Long countByMemNoAndProNo(Long memNo, Long proNo);

	@Transactional
	public Long deleteByMemNoAndProNo(Long memNo, Long proNo);
	
	public List<FundLikeLogDto> findAllByMemNo(Long memNo);

	public Page<FundLikeLogDto> findAllByMemNo(Long memNo, Pageable pageable);

	@Query(value = "SELECT f.* FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType",
			countQuery = "SELECT COUNT(*) FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType", // 네이티브 쿼리에서 Pageable을 사용하기 위한 countQuery
			nativeQuery = true)
	public Page<FundLikeLogDto> findAllByMemNoAndProType(@Param("memNo") Long memNo, @Param("proType") String proType, Pageable pageable);

	@Query(value = "SELECT 	f.* FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_state = :proState ",
			countQuery = "SELECT COUNT(*) FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_state = :proState", // 네이티브 쿼리에서 Pageable을 사용하기 위한 countQuery
			nativeQuery = true)
	public Page<FundLikeLogDto> findAllByMemNoAndProState(@Param("memNo") Long memNo, @Param("proState") String proState, Pageable pageable);

	@Query(value = "SELECT 	f.* FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType AND p.pro_state = :proState",
			countQuery = "SELECT COUNT(*) FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_type = :proType AND p.pro_state = :proState",	// 네이티브 쿼리에서 Pageable을 사용하기 위한 countQuery
			nativeQuery = true)
	public Page<FundLikeLogDto> findAllByMemNoAndProTypeAndProState(@Param("memNo") Long memNo, @Param("proType") String proType,
			@Param("proState") String proState, Pageable pageable);

	@Query(value = "SELECT COUNT(*) FROM fund_like_log f, project p WHERE f.mem_no = :memNo AND f.pro_no = p.pro_no AND p.pro_state = :proState", nativeQuery = true)
	public int countByMemNoAndProState(@Param("memNo") Long memNo, @Param("proState") String proState);
}
