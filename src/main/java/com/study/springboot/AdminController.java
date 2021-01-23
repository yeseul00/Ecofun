package com.study.springboot;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.study.springboot.dto.MemberDto;
import com.study.springboot.service.AddressService;
import com.study.springboot.service.MemberService;
import com.study.springboot.service.OrderService;
import com.study.springboot.service.ProjectService;

@Controller
public class AdminController {
 
	@Autowired
	MemberService memberService;

	@Autowired
	AddressService addressService;
 
	@Autowired
	ProjectService projectService;

	@Autowired
	OrderService orderService;

	// 회원목록 화면이동
	@GetMapping("/adMemList")
	public String adMemList(Model model, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("memNo").descending());
		}
		model.addAttribute("todayCount", memberService.countByMemJoinDateBetween());
		model.addAttribute("list", memberService.findAll(pageable));
		return "MainForm.jsp?contentPage=admin/adMemList";
	}

	// 회원 상세
	@GetMapping("/adMemDetail/{id}")
	public String adMemDetail(@PathVariable("id") Long memNo, Model model, Pageable pageable) {
		Optional<MemberDto> memberOpt = memberService.findById(memNo);
		memberOpt.ifPresent(data -> {
			model.addAttribute("data", data);
			model.addAttribute("orderList", orderService.findAll(memNo, pageable, null, null));
			model.addAttribute("addressList", addressService.findAllByMemNo(memNo));
		});
		return "admin/adMemDetail";
	}

	@GetMapping("/adProList")
	public String adProList(String state, String type, Model model, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("proNo").descending());
		}
		if (state == null) {
			state = "전체";
		}
		if (type == null) {
			type = "전체";
		}
		model.addAttribute("projectList", projectService.getProjectList(state, type, pageable));
		model.addAttribute("projectCount", projectService.countProject());
		return "index.jsp?contentPage=admin/adProList";
	}

}
