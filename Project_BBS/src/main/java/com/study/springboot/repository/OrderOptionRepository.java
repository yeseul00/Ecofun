package com.study.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.OrderOptionDto;

@Repository
public interface OrderOptionRepository extends JpaRepository<OrderOptionDto, Long>{
	public OrderOptionDto findByOpNo(Long opNo);
	public OrderOptionDto findByProNo(Long proNo);
	public List<OrderOptionDto> findAllByProNo(Long proNo);
}
