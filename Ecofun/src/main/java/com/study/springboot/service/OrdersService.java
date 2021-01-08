package com.study.springboot.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrdersDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.repository.MemberRepository;
import com.study.springboot.repository.OrdersRepository;
import com.study.springboot.repository.ProjectRepository;

@Service
public class OrdersService {

	@Autowired
	private OrdersRepository ordersRepository;

	@Autowired
	private ProjectRepository projectRepository;

	@Autowired
	private MemberRepository memberRepository;

	public OrdersDto findByOrderNo(Long orderNo) {
		return ordersRepository.findByOrderNo(orderNo);
	}

	public List<OrdersDto> findAllByMemNo(Long memNo) {
		return ordersRepository.findAllByMemNo(memNo);
	}

	public List<ProjectDto> findAllProjectByOrders(List<OrdersDto> ordersList) {
		List<ProjectDto> projectList = new ArrayList<ProjectDto>();
		for (OrdersDto orders : ordersList) {
			projectList.add(projectRepository.findByProNo(orders.getProNo()));
		}
		return projectList;
	}

	public Page<OrdersDto> findAllByMemNoAndOrderDateBetween(Long memNo, String startDate, String endDate, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("orderNo").descending());
		}

		LocalDateTime start;
		if (startDate == null || startDate.equals("")) {
			start = LocalDate.of(2020, 1, 1).atStartOfDay();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE).atStartOfDay();
		}
		LocalDateTime end;
		if (endDate == null || endDate.equals("")) {
			end = LocalDateTime.now();
		} else {
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE).atTime(23, 59, 59);
		}

		Page<OrdersDto> orderArr = ordersRepository.findAllByMemNoAndOrderDateBetween(memNo, start, end, pageable);
		orderArr.forEach(e -> {
			Optional<ProjectDto> projectOpt = projectRepository.findById(memNo);
			projectOpt.ifPresent(project -> {
				project.setProThumb(project.getProThumb());
				project.setProceed(project.getProceed());
				Optional<MemberDto> memberOpt = memberRepository.findById(project.getMemNo());
				memberOpt.ifPresent(member -> {
					e.setProjectMemberName(member.getMemName());
				});
				e.setProjectDto(project);
			});
		});
		return orderArr;
	}

	public Page<OrdersDto> findAllByMemNoAndProTypeAndOrderDateBetween(Long memNo, String proType, String startDate, String endDate, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("order_no").descending()); // order_no -> nativeQuery=true
		}

		LocalDateTime start;
		if (startDate == null || startDate.equals("")) {
			start = LocalDate.of(2020, 1, 1).atStartOfDay();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE).atStartOfDay();
		}
		LocalDateTime end;
		if (endDate == null || endDate.equals("")) {
			end = LocalDateTime.now();
		} else {
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE).atTime(23, 59, 59);
		}

		Page<OrdersDto> orderArr = ordersRepository.findAllByMemNoAndProTypeAndOrderDateBetween(memNo, proType, start, end, pageable);
		orderArr.forEach(e -> {
			Optional<ProjectDto> projectOpt = projectRepository.findById(memNo);
			projectOpt.ifPresent(project -> {
				project.setProThumb(project.getProThumb());
				project.setProceed(project.getProceed());
				Optional<MemberDto> memberOpt = memberRepository.findById(project.getMemNo());
				memberOpt.ifPresent(member -> {
					e.setProjectMemberName(member.getMemName());
				});
				e.setProjectDto(project);
			});
		});
		return orderArr;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public Long sumTotalPriceByProNo(Long proNo) {
		return ordersRepository.sumTotalPrice(proNo);
		// Long sum = 0L;
		// for (OrdersDto orders : ordersRepository.findAllByProNo(proNo)) {
		// sum += orders.getTotalPrice();
		// }
		// return sum;
	}

	public Long sumTotalPriceByMemNoAndProTypeAndOrderDateBetween(Long memNo, String proType, String startDate, String endDate) {
		LocalDateTime start;
		if (startDate == null || startDate.equals("")) {
			start = LocalDate.of(2020, 1, 1).atStartOfDay();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE).atStartOfDay();
		}
		LocalDateTime end;
		if (endDate == null || endDate.equals("")) {
			end = LocalDateTime.now();
		} else {
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE).atTime(23, 59, 59);
		}
		return ordersRepository.sumTotalPriceByMemNoAndProTypeAndOrderDateBetween(memNo, proType, start, end);
	}

	public Long sumTotalPriceByMemNoAndOrderDateBetween(Long memNo, String startDate, String endDate) {
		LocalDateTime start;
		if (startDate == null || startDate.equals("")) {
			start = LocalDate.of(2020, 1, 1).atStartOfDay();
		} else {
			start = LocalDate.parse(startDate, DateTimeFormatter.ISO_DATE).atStartOfDay();
		}
		LocalDateTime end;
		if (endDate == null || endDate.equals("")) {
			end = LocalDateTime.now();
		} else {
			end = LocalDate.parse(endDate, DateTimeFormatter.ISO_DATE).atTime(23, 59, 59);
		}
		return ordersRepository.sumTotalPriceByMemNoAndOrderDateBetween(memNo, start, end);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	public Long countByProNo(Long proNo) {
		return ordersRepository.countByProNo(proNo);
	}

	public OrdersDto save(OrdersDto orderDto) {
		orderDto.setOrderDate(LocalDateTime.now());
		ordersRepository.save(orderDto);
		return orderDto;
	}
}
