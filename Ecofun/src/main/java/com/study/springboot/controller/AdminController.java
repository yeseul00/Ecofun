package com.study.springboot.controller;

import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.dto.ProjectOptionDto;
import com.study.springboot.service.AddressService;
import com.study.springboot.service.ApplyService;
import com.study.springboot.service.AskService;
import com.study.springboot.service.BoardService;
import com.study.springboot.service.ImgService;
import com.study.springboot.service.MemberService;
import com.study.springboot.service.OrdersService;
import com.study.springboot.service.ProjectOptionService;
import com.study.springboot.service.ProjectService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	MemberService memberService;

	@Autowired
	AddressService addressService;

	@Autowired
	ProjectService projectService;

	@Autowired
	OrdersService ordersService;

	@Autowired
	ProjectOptionService optionService;

	@Autowired
	AskService askService;

	@Autowired
	ApplyService applyService;

	@Autowired
	BoardService boardService;

	@Autowired
	ImgService imgService;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 프로젝트 관리 - 목록
	@GetMapping("/projectList")
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
		System.out.println("프로젝트 관리 - 목록");
		return "index.jsp?contentPage=admin/adProList";
	}

	// 프로젝트 관리 - 입력 - 폼 이동
	@GetMapping("/projectInsert")
	public String proInsertForm() {
		System.out.println("프로젝트 관리 - 입력(폼 이동)");
		return "index.jsp?contentPage=admin/adProInsert";
	}

	// 프로젝트 관리 - 입력 - 회원(주최자) 검색
	@GetMapping("/memberSearch/{keyword}")
	public ResponseEntity<List<MemberDto>> memberSearch(@PathVariable(name = "keyword") String keyword, Model model) {
		return new ResponseEntity<List<MemberDto>>(memberService.findAllByMemIdLike(keyword), HttpStatus.OK);
	}

	// 프로젝트 관리 - 입력 - 실행
	@PostMapping("/projectInsert")
	public String proInsert(String memId, ProjectDto projectDto, HttpServletRequest request, ImgDto imgDto, @RequestParam("fileName") MultipartFile files) {
		projectService.save(projectDto);
		String[] opNames = request.getParameterValues("opName");
		String[] prices = request.getParameterValues("price");
		for (int i = 0; i < opNames.length; i++) {
			ProjectOptionDto option = new ProjectOptionDto();
			option.setOpName(opNames[i]);
			option.setPrice(Integer.parseInt(prices[i]));
			option.setProNo(projectDto.getProNo());
			option.setOpUsed("y");
			optionService.save(option);
		}
		projectDto.setMemNo(memberService.findByMemId(memId).getMemNo());
		projectDto.setProThumb(imgService.save(projectDto, imgDto, files));

		projectService.save(projectDto);
		System.out.println("프로젝트 관리 - 입력(실행)");
		return "redirect:/main";
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 문의및신청 관리 - 목록
	@GetMapping("/qnaList")
	public String qnaList(Model model, @Qualifier("pageable1") Pageable pageable1, @Qualifier("pageable2") Pageable pageable2) {
		if (pageable1.getSort().toString() == "UNSORTED") {
			pageable1 = PageRequest.of(pageable1.getPageNumber(), pageable1.getPageSize(), Sort.by("askNo").descending());
		}
		model.addAttribute("askList", askService.findAll(pageable1));
		model.addAttribute("askCount", askService.count());

		if (pageable2.getSort().toString() == "UNSORTED") {
			pageable2 = PageRequest.of(pageable2.getPageNumber(), pageable2.getPageSize(), Sort.by("aplNo").descending());
		}
		model.addAttribute("aplList", applyService.findAll(pageable2));
		model.addAttribute("aplCount", applyService.countApl());

		System.out.println("문의및신청 관리 - 목록");
		return "index.jsp?contentPage=admin/adQnaList";
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 회원 관리 - 목록
	@GetMapping("/memberList")
	public String adMemList(Model model, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("memNo").descending());
		}
		model.addAttribute("todayCount", memberService.countByMemJoinDateBetween());
		model.addAttribute("list", memberService.findAll(pageable));
		System.out.println("회원 관리 - 목록");
		return "index.jsp?contentPage=admin/adMemList";
	}

	// 회원 관리 - 상세
	@GetMapping("/memberDetail/{id}")
	public String adMemDetail(@PathVariable("id") Long memNo, Model model, Pageable pageable) {
		Optional<MemberDto> memberOpt = memberService.findById(memNo);
		memberOpt.ifPresent(memberDto -> {
			model.addAttribute("memberDto", memberDto);
			model.addAttribute("orderList", ordersService.findAllByMemNoAndOrderDateBetween(memNo, null, null, pageable));
			model.addAttribute("addressList", addressService.findAllByMemNo(memNo));
			model.addAttribute("projectList", ordersService.findAllProjectByOrders(ordersService.findAllByMemNo(memNo)));
		});
		System.out.println("회원 관리 - 상세");
		return "admin/adMemDetail";
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 게시판 관리 - 입력 - 폼 이동
	@GetMapping("/boardInsert")
	public String adBoardInsertForm() {
		System.out.println("게시판 관리 - 입력(폼 이동)");
		return "index.jsp?contentPage=admin/adBoardInsert";
	}

	// 게시판 관리 - 입력 - 실행
	@PostMapping("/boardInsert")
	public String adBoardInsert(BoardDto boardDto, HttpServletRequest request, Model model, @RequestParam("fileName") MultipartFile file, ImgDto imgDto) {
		if (file == null) {
			boardService.save(boardDto, request);
		} else {
			if (file.getSize() > 0) {
				boardService.save(boardDto, request);
				imgService.restore(boardDto, imgDto, file);
				boardService.save(boardDto, request);
			} else {
				boardService.save(boardDto, request);
			}
		}
		model.addAttribute("boardList", boardDto);

		System.out.println("게시판 작성 - 입력(실행)");
		return "redirect:/board/list";
	}
}
