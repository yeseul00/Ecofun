package com.study.springboot;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.AskDto;
import com.study.springboot.dto.FilesDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.ProRequestDto;
import com.study.springboot.service.AskService;
import com.study.springboot.service.FileUploadService;
import com.study.springboot.service.FundLikeLogService;
import com.study.springboot.service.ImgService;
import com.study.springboot.service.OrderService;
import com.study.springboot.service.ProRequestService;
import com.study.springboot.service.ProRequestStateService;
import com.study.springboot.service.ProjectService;

@Controller
public class MyController {

	// 파일 저장 서비스 로딩
	@Autowired
	FileUploadService fileUploadService;

	// 이미지 저장 서비스 로딩
	@Autowired
	ImgService imgService;

	// 문의 서비스 로딩
	@Autowired
	AskService askService;

	// 신청 서비스 로딩
	@Autowired
	ProRequestService requestService;

	@Autowired
	ProRequestStateService requestStateService;

	@Autowired
	OrderService orderService;

	@Autowired
	FundLikeLogService fundLikeLogService;

	@Autowired
	ProjectService projectservice;

	// 루트 페이지 경로
	@RequestMapping("/")
	public String root() throws Exception {
		return "redirect:main";
	}

	//////////////////////////////////////////////////////////////////////
	// servlet3_LoginJoinDB 페이지 연결
	// 메인페이지 불러오기
	@RequestMapping("/main")
	public String main(Model model) {
		System.out.println("main");
		return "MainForm";
	}

	// 약관동의 화면이동
	@RequestMapping("/agreeForm")
	public String agreeForm(Model model) {
		return "MainForm.jsp?contentPage=join/agreeForm";
	}

	// 회원가입 화면이동
	@RequestMapping("/joinForm")
	public String joinForm(Model model) {
		return "MainForm.jsp?contentPage=join/joinForm";
	}

	// 로그인 레이어
	@RequestMapping("/loginLayer")
	public String loginLayer(Model model) {
		return "MainForm.jsp?contentPage=loginLayer";
	}

	// 회사소개
	@GetMapping("/company")
	public String company(Model model, HttpSession session) {
		System.out.println("company");
		return "MainForm.jsp?contentPage=company";
	}

	// 제휴단체
	@GetMapping("/cooperation")
	public String cooperation(Model model) {
		System.out.println("cooperation");
		return "MainForm.jsp?contentPage=cooperation";
	}

	// 오시는길
	@GetMapping("/map")
	public String map(Model model) {
		System.out.println("map");
		return "MainForm.jsp?contentPage=map";
	}

	// 참여한 프로젝트 목록
	@GetMapping({"/myProList", "/myProList/{proType}"})
	public String myProList(@PathVariable(name = "proType", required = false) String proType, HttpServletRequest request, Model model,
			Pageable pageable) {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");

		Long memNo = (Long) request.getSession().getAttribute("memNo");
		if (proType != null) {
			model.addAttribute("list", orderService.findAllByProType(memNo, proType, pageable, startDate, endDate));
			// 합계금액
			model.addAttribute("total", orderService.findAllByProTypeSum(memNo, proType, startDate, endDate));
		} else {
			model.addAttribute("list", orderService.findAll(memNo, pageable, startDate, endDate));
			model.addAttribute("total", orderService.findAllSum(memNo, startDate, endDate));
		}

		model.addAttribute("proType", proType);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		model.addAttribute("projectDto", orderService.findAllProjectByOrder(orderService.findAllByMemNo(memNo)));

		return "MainForm.jsp?contentPage=mypage/myProjectList";
	}

	// 좋아한 프로젝트 목록
	@GetMapping("/myProLikeList")
	public String myProLikeList(HttpServletRequest request, Model model, Pageable pageable) {
		model.addAttribute("list", fundLikeLogService.findAllByList(request, pageable));
		model.addAttribute("countList", fundLikeLogService.countByMemNo(request));
		// model.addAttribute("countProLikePast", fundLikeLogService.countByMemNoAndProState(request));
		// model.addAttribute("countProLikeNow", fundLikeLogService.countByMemNoAndProState(request));
		// model.addAttribute("countProLikeFuture", fundLikeLogService.countByMemNoAndProState(request));
		return "MainForm.jsp?contentPage=mypage/myProLikeList";
	}

	// 문의하기 - 폼 이동
	@GetMapping("/myAskInsertForm")
	public String myAskInsertForm() {
		System.out.println("문의하기 폼 도착");
		return "MainForm.jsp?contentPage=mypage/myAskInsert";
	}

	// 문의하기 - 실행
	@PostMapping("/myAskRequest")
	public String myAskInsert(AskDto askDto, HttpSession session) {
		askService.save(askDto, session);
		return "redirect:mySuggestList";
	}

	// 프로젝트 신청 - 폼 이동
	@GetMapping("/myApplyInsertForm")
	public String myApplyInsert(Model model) {
		System.out.println("프로젝트 신청서 폼 도착");
		return "MainForm.jsp?contentPage=mypage/myApplyInsert";
	}

	// 프로젝트 신청 - 실행 (이후 신청목록으로 이동)
	@PostMapping("/myProRequest")
	public String myApplyInsert(HttpSession session, HttpServletRequest request, ProRequestDto proRequest, FilesDto filesDto,
			@RequestParam("fileName") MultipartFile[] files, ImgDto imgDto) throws NoSuchAlgorithmException, IOException {
		requestService.save(proRequest, request, session);

		if (files[1].getSize() == 0) {
			// 두번째로 들어오는 파일의 용량이 0일경우( =두번째 파일을 선택하지 않은 경우/null체크 안됨. 들어오는 건 requestParam 2개 무조건 들어옴.)
			imgService.restore(proRequest, imgDto, files[0]);
		} else {
			imgService.restore(proRequest, imgDto, files[0]);
			fileUploadService.restore(proRequest, filesDto, files[1]);
		}
		System.out.println("신청 확인 눌림.");
		return "redirect:mySuggestList";
	}

	// 문의및신청 목록 (관리자용)
	@GetMapping("/adSuggestList")
	public String AllmySuggestList(Model model, @Qualifier("pageable1") Pageable pageable1, @Qualifier("pageable2") Pageable pageable2) {
		if (pageable1.getSort().toString() == "UNSORTED") {
			pageable1 = PageRequest.of(pageable1.getPageNumber(), pageable1.getPageSize(), Sort.by("askNo").descending());
		}
		model.addAttribute("askList", askService.getAllAskList(pageable1));

		if (pageable2.getSort().toString() == "UNSORTED") {
			pageable2 = PageRequest.of(pageable2.getPageNumber(), pageable2.getPageSize(), Sort.by("reqNo").descending());
		}
		model.addAttribute("reqList", requestService.getAllProRequestList(pageable2));

		// model.addAttribute("reqStateList", requestStateService.getAllProRequestStateList(pageable));
		System.out.println("건의 목록");
		return "MainForm.jsp?contentPage=admin/adSuggestList";
	}

	// 문의및신청 목록 (사용자용)
	@GetMapping("/mySuggestList")
	public String mySuggestList(Model model, @Qualifier("pageable1") Pageable pageable1, HttpSession session,
			@Qualifier("pageable2") Pageable pageable2) {
		Long memNo = (Long) session.getAttribute("memNo");

		if (pageable1.getSort().toString() == "UNSORTED") {
			pageable1 = PageRequest.of(pageable1.getPageNumber(), pageable1.getPageSize(), Sort.by("askNo").descending());
		}
		model.addAttribute("askList", askService.getAskListByMemId(memNo, pageable1));

		if (pageable2.getSort().toString() == "UNSORTED") {
			pageable2 = PageRequest.of(pageable2.getPageNumber(), pageable2.getPageSize(), Sort.by("reqNo").descending());
		}
		model.addAttribute("reqList", requestService.getProRequestList(memNo, pageable2));
		model.addAttribute("reqStateList", requestStateService.getProRequestStateList(memNo, pageable2));

		return "MainForm.jsp?contentPage=mypage/mySuggestList";
	}

	// 문의 상세
	@GetMapping("/myAskDetail")
	public String myAskDetail(Long askNo, Model model) {
		model.addAttribute("ask", askService.getAsk(askNo));
		System.out.println("건의_문의 상세");
		return "MainForm.jsp?contentPage=mypage/myAskDetail";
	}

	// 신청 상세
	@GetMapping("/myApplyDetail")
	public String myApplyDetail(Long reqNo, Model model) {
		model.addAttribute("req", requestService.getProRequest(reqNo));
		model.addAttribute("reqState", requestStateService.getProRequestState(reqNo));
		System.out.println("건의_신청 상세");
		return "MainForm.jsp?contentPage=mypage/myApplyDetail";
	}
}
