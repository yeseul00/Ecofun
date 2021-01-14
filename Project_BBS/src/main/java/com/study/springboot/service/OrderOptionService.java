package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dto.OrderOptionDto;
import com.study.springboot.repository.OrderOptionRepository;

@Service
public class OrderOptionService {

	@Autowired
	private OrderOptionRepository optionRepository;

	public OrderOptionDto findByOpNo(Long opNo) {
		return optionRepository.findByOpNo(opNo);
	}

	public OrderOptionDto findByProNo(Long proNo) {
		return optionRepository.findByProNo(proNo);
	}

	public List<OrderOptionDto> findAllByProNo(Long proNo) {
		return optionRepository.findAllByProNo(proNo);
	}

	public void save(OrderOptionDto optionDto) {
		optionRepository.save(optionDto);
//		OrderOptionDto orderOption = null;
//		
//		Iterator<Integer> price = optionDto.getPriceArr().iterator();
//		Iterator<String> opName = optionDto.getOpNameArr().iterator();
//		
//		while (price.hasNext()) { // hasNext() : 데이터가 있으면 true 없으면 false
//			orderOption = new OrderOptionDto();
//			orderOption.setProNo(optionDto.getProNo());
//			orderOption.setPrice(price.next());
//			orderOption.setOpName(opName.next());
//			orderOption.setOpUsed(optionDto.getOpUsed());
//			optionRepository.save(orderOption);
//		}
	}
}