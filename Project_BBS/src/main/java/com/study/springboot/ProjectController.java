package com.study.springboot;

import java.util.List;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.FundLikeLogDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrderDto;
import com.study.springboot.dto.OrderOptionDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.service.AccountInfoService;
import com.study.springboot.service.AddressService;
import com.study.springboot.service.FundLikeLogService;
import com.study.springboot.service.ImgService;
import com.study.springboot.service.MemberService;
import com.study.springboot.service.OrderOptionService;
import com.study.springboot.service.OrderService;
import com.study.springboot.service.ProCommentService;
import com.study.springboot.service.ProjectService;

@Controller
public class ProjectController {

	@Autowired
	ProjectService projectService;

	@Autowired
	OrderOptionService optionService;

	@Autowired
	ProCommentService commentService;

	@Autowired
	ImgService imgService;

	@Autowired
	FundLikeLogService likeService;

	@Autowired
	OrderService orderService;

	@Autowired
	MemberService memberService;

	@Autowired
	AccountInfoService accountService;

	@Autowired
	AddressService addressService;

	// 프로젝트 목록
	@GetMapping("/projectList")
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
		return "MainForm.jsp?contentPage=project/proList";
	}

	@PostMapping("/filtering")
	public String filtering(Model model, String state, String type, Pageable pageable) {
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
		return "project/proContent";
	}

	// 프로젝트 상세
	@GetMapping("/projectDetail")
	public String detail(Long proNo, Model model, HttpServletRequest request) {
		model.addAttribute("project", projectService.findByProNo(proNo));
		model.addAttribute("optionList", optionService.findAllByProNo(proNo));
		model.addAttribute("like", likeService.countByMemNoAndProNo(proNo, request));
		request.setAttribute("proState", projectService.findByProNo(proNo).getProState());
		return "MainForm.jsp?contentPage=project/proDetail";
	}

	// 가격 호출
	@ResponseBody
	@PostMapping("/price")
	public OrderOptionDto price(Long opNo) {
		return optionService.findByOpNo(opNo);
	}

	// 좋아한 프로젝트 입력
	@PostMapping("/like")
	public ResponseEntity<FundLikeLogDto> likeInsert(FundLikeLogDto likeDto, HttpServletRequest request) {
		return new ResponseEntity<FundLikeLogDto>(likeService.saveLike(likeDto, request), HttpStatus.OK);
	}

	// 좋아한 프로젝트 삭제
	@PostMapping("/deleteLike")
	public ResponseEntity<Long> likeDelete(FundLikeLogDto likeDto, HttpServletRequest request) {
		return new ResponseEntity<Long>(likeService.deleteLike(likeDto, request), HttpStatus.OK);
	}

//	// 프로젝트 댓글 입력
//	@GetMapping("/commentInsert")
//	public String commentInsert(ProCommentDto proCommentDto) {
//		commentService.setComment(proCommentDto);
//		return "redirect:main";
//	}

	// 프로젝트 결제1 - 상세 페이지에서 결제하기 클릭 시.
	@PostMapping("/orderForm")
	public String orderForm(OrderDto orderDto, HttpSession session, Long proNo, Long opNo, Model model) {
		model.addAttribute("project", projectService.findByProNo(proNo));
		model.addAttribute("option", optionService.findByOpNo(opNo));
		model.addAttribute("order", orderDto);
		model.addAttribute("member", memberService.findByMemNo((Long) session.getAttribute("memNo")));

		if (projectService.findByProNo(proNo).getProType().equals("펀딩")) {
			return "MainForm.jsp?contentPage=project/orderFun";
		} else {
			return "MainForm.jsp?contentPage=project/orderDon";
		}
	}

	// 프로젝트 결제2 - 결제 페이지에서 결제하기 클릭 시.
	@PostMapping("/order")
	public String orderInsert(Long memNo, Long proNo, Long opNo, OrderDto order, /* AddressDto address, */ String proType, Model model) {
		model.addAttribute("member", memberService.findByMemNo(memNo));
		model.addAttribute("option", optionService.findByOpNo(opNo));
		model.addAttribute("order", orderService.setOrder(order));

		ProjectDto project = projectService.findByProNo(proNo);
		project.setProHit(orderService.countByProNo(proNo));
		project.setProNow(orderService.getTotalPriceByProNo(proNo));
		project.setProceed(project.getProNow() * 100 / project.getProTarget());
		projectService.setProject(project);
		model.addAttribute("project", project);

		// 프로젝트 진행률 처리 로직 (project 테이블 pro_now 컬럼 update, 논리 오류 덮어쓰기)
		// orderService.sumProNow(project);

		if (proType.equals("펀딩")) {
			return "MainForm.jsp?contentPage=project/resultFun";
		} else {
			return "MainForm.jsp?contentPage=project/resultDon";
		}
	}

	// 프로젝트 입력
	@GetMapping("/projectInsert")
	public String proInsertForm() {
		return "MainForm.jsp?contentPage=admin/adProInsert";
	}

	// 프로젝트 입력 - 회원(주최자) 검색
	@GetMapping("/memberSearch/{keyword}")
	public ResponseEntity<List<MemberDto>> memberSearch(@PathVariable(name = "keyword") String keyword, Model model) {
		return new ResponseEntity<List<MemberDto>>(memberService.findAllByMemIdLike(keyword), HttpStatus.OK);
	}

	// 프로젝트 입력 - 실행
	@PostMapping("/projectInsert")
	public String proInsert(String memId, ProjectDto projectDto, HttpServletRequest request, ImgDto imgDto,
			@RequestParam("fileName") MultipartFile files) {
		projectService.setProject(projectDto);
		String[] opNameArr = request.getParameterValues("opNameArr");
		String[] priceArr = request.getParameterValues("priceArr");
		for (int i = 0; i < opNameArr.length; i++) {
			OrderOptionDto option = new OrderOptionDto();
			option.setOpName(opNameArr[i]);
			option.setPrice(Integer.parseInt(priceArr[i]));
			option.setProNo(projectDto.getProNo());
			option.setOpUsed("y");
			optionService.save(option);
		}
		projectDto.setMemNo(memberService.findByMemId(memId).getMemNo());
		projectDto.setProThumb(imgService.save(projectDto, imgDto, files));

		projectService.setProject(projectDto);
		System.out.println("프로젝트 관리 - 입력(실행)");
		return "redirect:/main";
	}	
	
	// 메인페이지 프로젝트 목록
	@GetMapping("/main")
	public String mainpro(Model model, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			// 진행중
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("proStart").descending());
			model.addAttribute("projectList1", projectService.getProjectList("진행", "전체", pageable));
			// 종료임박
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("proEnd").ascending());
			model.addAttribute("projectList2", projectService.getProjectList("종료임박", "전체", pageable));
			// 진행예정
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("proStart").ascending());
			model.addAttribute("projectList3", projectService.getProjectList("예정", "전체", pageable));
		}
		return "MainForm.jsp?contentPage=ecofunMain";
	}

	// 프로젝트 키워드 검색
	@GetMapping("/keywordSearch/{keyword}")
	public ResponseEntity<List<ProjectDto>> keywordSearch(@PathVariable(name = "keyword") String keyword, Model model) {
		return new ResponseEntity<List<ProjectDto>>(projectService.findAllByProInfoLike(keyword), HttpStatus.OK);
	}
}