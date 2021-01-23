package com.study.springboot.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.OrderDto;

@Repository
public interface OrderRepository extends JpaRepository<OrderDto, Long>{
	public OrderDto findByOrderNo(Long orderNo);

	public Page<OrderDto> findAllByMemNoAndOrderDateBetween(Long memNo, LocalDateTime startDatetime, LocalDateTime endDatetime, Pageable pageable);
	
	public int countByProNo(Long proNo);
	
	public List<OrderDto> findAllByProNo(Long proNo);

	public List<OrderDto> findAllByMemNo(Long memNo);

	@Query(
		value="SELECT "
			+ "	r.* "
			+ "FROM "
			+ "	req_order r, project p "
			+ "WHERE "
			+ "	r.mem_no = :memNo "
			+ "AND "
			+ "	r.pro_no = p.pro_no "
			+ "AND "
			+ "	p.pro_type = :proType "
			+ "AND "
			+ "	r.order_date BETWEEN :startDatetime AND :endDatetime",
		countQuery="SELECT " // ?ㅼ씠?곕툕 荑쇰━?먯꽌 Pageable???ъ슜?섍린 ?꾪븳 countQuery
			+ "	COUNT(*) "
			+ "FROM "
			+ "	req_order r, project p "
			+ "WHERE "
			+ "	r.mem_no = :memNo "
			+ "AND "
			+ "	r.pro_no = p.pro_no "
			+ "AND "
			+ "	p.pro_type = :proType "
			+ "AND "
			+ "	r.order_date BETWEEN :startDatetime AND :endDatetime",
		nativeQuery=true
	)
	public Page<OrderDto> findAllByMemNoAndProType(
		@Param("memNo") Long memNo,
		@Param("proType") String proType,
		@Param("startDatetime") LocalDateTime startDatetime,
		@Param("endDatetime") LocalDateTime endDatetime,
		Pageable pageable
	);
	
	@Query(
		value="SELECT "
			+ "	COUNT(*) "
			+ "FROM "
			+ "	req_order r, project p "
			+ "WHERE "
			+ "	r.mem_no = :memNo "
			+ "AND "
			+ "	r.pro_no = p.pro_no "
			+ "AND "
			+ "	p.pro_type = :proType "
			+ "AND "
			+ "	r.order_date BETWEEN :startDatetime AND :endDatetime",
		nativeQuery=true
	)
	public Long countByProType(
		@Param("memNo") Long memNo,
		@Param("proType") String proType,
		@Param("startDatetime") LocalDateTime startDatetime,
		@Param("endDatetime") LocalDateTime endDatetime
	);

	@Query(
		value="SELECT "
			+ "	SUM(r.price) "
			+ "FROM "
			+ "	req_order r, project p "
			+ "WHERE "
			+ "	r.mem_no = :memNo "
			+ "AND "
			+ "	r.pro_no = p.pro_no "
			+ "AND "
			+ "	p.pro_type = :proType "
			+ "AND "
			+ "	r.order_date BETWEEN :startDatetime AND :endDatetime",
		nativeQuery=true
	)
	public int findAllByProTypeSum(
		@Param("memNo") Long memNo,
		@Param("proType") String proType,
		@Param("startDatetime") LocalDateTime startDatetime,
		@Param("endDatetime") LocalDateTime endDatetime
	);

	@Query(
		value="SELECT "
			+ "	COUNT(*) "
			+ "FROM "
			+ "	req_order r, project p "
			+ "WHERE "
			+ "	r.mem_no = :memNo "
			+ "AND "
			+ "	r.pro_no = p.pro_no "
			+ "AND "
			+ "	r.order_date BETWEEN :startDatetime AND :endDatetime",
		nativeQuery=true
	)
	public Long countByMemNoAndProTypeAndOrderDateBetween(
		@Param("memNo") Long memNo,
		@Param("startDatetime") LocalDateTime startDatetime,
		@Param("endDatetime") LocalDateTime endDatetime
	);

	@Query(
		value="SELECT "
			+ "	SUM(total_price) "
			+ "FROM "
			+ "req_order "
			+ "WHERE "
			+ "mem_no = :memNo",
		nativeQuery=true
	)
	public int findAllSum(
		@Param("memNo") Long memNo
		
	);

	@Query(
		value="SELECT "
			+ "	SUM(r.total_price) "
			+ "FROM "
			+ "	req_order r "
			+ "WHERE "
			+ "	r.pro_no = :proNo ",
		nativeQuery=true
	)
	public Long sumTotalPrice(@Param("proNo") Long proNo);

	public Long countByMemNo(Long memNo);
		
}
