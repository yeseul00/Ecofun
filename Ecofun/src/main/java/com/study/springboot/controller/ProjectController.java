package com.study.springboot.controller;

import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.study.springboot.dto.OrdersDto;
import com.study.springboot.dto.ProjectCmtDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.dto.ProjectLikeDto;
import com.study.springboot.dto.ProjectOptionDto;
import com.study.springboot.service.ImgService;
import com.study.springboot.service.MemberService;
import com.study.springboot.service.OrdersService;
import com.study.springboot.service.ProjectCmtService;
import com.study.springboot.service.ProjectLikeService;
import com.study.springboot.service.ProjectOptionService;
import com.study.springboot.service.ProjectService;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	ProjectService projectService;

	@Autowired
	ProjectOptionService optionService;

	@Autowired
	OrdersService ordersService;

	@Autowired
	MemberService memberService;

	@Autowired
	ImgService imgService;

	@Autowired
	ProjectLikeService likeService;

	@Autowired
	ProjectCmtService cmtService;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 프로젝트 목록
	@GetMapping("/list")
	public String list(Model model, String state, String type, Pageable pageable) {
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
		return "index.jsp?contentPage=project/proList";
	}

	// 프로젝트 목록 - 필터
	@PostMapping("/list/filter")
	public String filtering(Model model, String state, String type, String sort, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by(sort).descending());
		}
		if (state == null) {
			state = "전체";
		}
		if (type == null) {
			type = "전체";
		}
		model.addAttribute("projectList", projectService.getProjectList(state, type, pageable));
		return "project/proContent";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 프로젝트 상세
	@GetMapping("/detail")
	public String detail(Long proNo, Model model, HttpServletRequest request, Pageable pageable) {
		model.addAttribute("project", projectService.findByProNo(proNo));
		model.addAttribute("optionList", optionService.findAllByProNo(proNo));
		model.addAttribute("like", likeService.countByMemNoAndProNo(proNo, request));
		model.addAttribute("cmtList", cmtService.findAllByProNo(proNo, pageable));
		model.addAttribute("memList", cmtService.findAllMemberByProjectCmt(cmtService.findAllByProNo(proNo)));
		request.setAttribute("proState", (String) (projectService.findByProNo(proNo).getProState()));
		return "index.jsp?contentPage=project/proDetail";
	}

	// 프로젝트 상세 - 가격 호출
	@ResponseBody
	@PostMapping("/detail/price")
	public ProjectOptionDto price(Long opNo) {
		return optionService.findByOpNo(opNo);
	}

	// 프로젝트 상세 - 좋아한 프로젝트 입력
	@PostMapping("/detail/like")
	public ResponseEntity<ProjectLikeDto> likeInsert(ProjectLikeDto likeDto, HttpServletRequest request) {
		return new ResponseEntity<ProjectLikeDto>(likeService.save(likeDto, request), HttpStatus.OK);
	}

	// 프로젝트 상세 - 좋아한 프로젝트 삭제
	@PostMapping("/detail/unlike")
	public ResponseEntity<Long> likeDelete(ProjectLikeDto likeDto, HttpServletRequest request) {
		return new ResponseEntity<Long>(likeService.delete(likeDto, request), HttpStatus.OK);
	}

	// 프로젝트 상세 - 댓글 입력
	@GetMapping("/commentInsert")
	public String save(ProjectCmtDto cmtDto) {
		cmtDto.setCmtDate(LocalDateTime.now());
		cmtService.save(cmtDto);
		return "redirect:/main";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 프로젝트 결제 - 폼 이동
	@PostMapping("/orderForm")
	public String orderForm(OrdersDto ordersDto, HttpSession session, Long proNo, Long opNo, Model model) {
		model.addAttribute("project", projectService.findByProNo(proNo));
		model.addAttribute("option", optionService.findByOpNo(opNo));
		model.addAttribute("orders", ordersDto);
		model.addAttribute("member", memberService.findByMemNo((Long) session.getAttribute("memNo")));

		if (projectService.findByProNo(proNo).getProType().equals("펀딩")) {
			return "index.jsp?contentPage=project/proOrderFun";
		} else {
			return "index.jsp?contentPage=project/proOrderDon";
		}
	}

	// 프로젝트 결제 - 실행
	@PostMapping("/order")
	public String orderInsert(Long memNo, Long proNo, Long opNo, OrdersDto orders, String proType, Model model) {
		model.addAttribute("member", memberService.findByMemNo(memNo));
		model.addAttribute("option", optionService.findByOpNo(opNo));
		model.addAttribute("order", ordersService.save(orders));

		ProjectDto project = projectService.findByProNo(proNo);
		project.setProHit(ordersService.countByProNo(proNo));
		project.setProNow(ordersService.sumTotalPriceByProNo(proNo));
		project.setProceed((int) (project.getProNow() * 100 / project.getProTarget()));
		projectService.save(project);
		model.addAttribute("project", project);
		model.addAttribute("orders", orders);

		if (proType.equals("펀딩")) {
			return "index.jsp?contentPage=project/proResultFun";
		} else {
			return "index.jsp?contentPage=project/proResultDon";
		}
	}
}