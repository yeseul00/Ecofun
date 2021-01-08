package com.study.springboot.repository;

import java.time.LocalDateTime;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.OrdersDto;

@Repository
public interface OrdersRepository extends JpaRepository<OrdersDto, Long> {

	public OrdersDto findByOrderNo(Long orderNo);

	public List<OrdersDto> findAllByMemNo(Long memNo);

	public List<OrdersDto> findAllByProNo(Long proNo);

	public Page<OrdersDto> findAllByMemNoAndOrderDateBetween(Long memNo, LocalDateTime start, LocalDateTime end, Pageable pageable);

	@Query(value = "SELECT o.* FROM orders o, project p WHERE o.mem_no = :memNo AND o.pro_no = p.pro_no AND p.pro_type = :proType AND o.order_date BETWEEN :start AND :end", countQuery = "SELECT COUNT(*) FROM orders o, project p WHERE o.mem_no = :memNo AND o.pro_no = p.pro_no AND p.pro_type = :proType AND o.order_date BETWEEN :start AND :end", nativeQuery = true)
	public Page<OrdersDto> findAllByMemNoAndProTypeAndOrderDateBetween(@Param("memNo") Long memNo, @Param("proType") String proType, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end, Pageable pageable);

	/**/

	public Long countByProNo(Long proNo);

	public Long countByMemNo(Long memNo);

	@Query(value = "SELECT COUNT(*) FROM orders o, project p WHERE o.mem_no = :memNo AND o.pro_no = p.pro_no AND o.order_date BETWEEN :start AND :end", nativeQuery = true)
	public Long countByMemNoAndOrderDateBetween(@Param("memNo") Long memNo, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

	@Query(value = "SELECT COUNT(*) FROM orders o, project p WHERE o.mem_no = :memNo AND o.pro_no = p.pro_no AND p.pro_type = :proType AND o.order_date BETWEEN :start AND :end", nativeQuery = true)
	public Long countByMemNoAndProTypeAndOrderDateBetween(@Param("memNo") Long memNo, @Param("proType") String proType, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

	/**/

	@Query(value = "SELECT SUM(total_price) FROM orders WHERE pro_no = ?1 ", nativeQuery = true)
	public Long sumTotalPrice(Long proNo);

	@Query(value = "SELECT SUM(total_price) FROM orders WHERE mem_no = ?1 AND order_date BETWEEN ?2 AND ?3", nativeQuery = true)
	public Long sumTotalPriceByMemNoAndOrderDateBetween(Long memNo, LocalDateTime start, LocalDateTime end);

	@Query(value = "SELECT SUM(o.total_price) FROM orders o, project p WHERE o.mem_no = ?1 AND p.pro_type = ?2 AND o.order_date BETWEEN ?3 AND ?4", nativeQuery = true)
	public Long sumTotalPriceByMemNoAndProTypeAndOrderDateBetween(Long memNo, String proType, LocalDateTime start, LocalDateTime end);
}
