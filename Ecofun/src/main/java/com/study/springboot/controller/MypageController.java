package com.study.springboot.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.study.springboot.dto.ApplyDto;
import com.study.springboot.dto.AskDto;
import com.study.springboot.dto.FilesDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.service.ApplyService;
import com.study.springboot.service.AskService;
import com.study.springboot.service.FilesService;
import com.study.springboot.service.ImgService;
import com.study.springboot.service.OrdersService;
import com.study.springboot.service.ProjectLikeService;

@Controller
@RequestMapping("mypage")
public class MypageController {

	@Autowired
	AskService askService;

	@Autowired
	ApplyService aplService;

	@Autowired
	ImgService imgService;

	@Autowired
	FilesService fileUploadService;

	@Autowired
	OrdersService ordersService;

	@Autowired
	ProjectLikeService projectLikeService;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 참여한 프로젝트 목록
	@GetMapping("/projectList")
	public String myProList(HttpServletRequest request, Model model, Pageable pageable) {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String proType = request.getParameter("proType");
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		if (proType == null) {
		model.addAttribute("orderList", ordersService.findAllByMemNoAndOrderDateBetween(memNo, startDate, endDate, pageable));
		model.addAttribute("projectList", ordersService.findAllProjectByOrders(ordersService.findAllByMemNo(memNo)));
		model.addAttribute("sum", ordersService.sumTotalPriceByMemNoAndOrderDateBetween(memNo, startDate, endDate));
		} else {
		model.addAttribute("orderList", ordersService.findAllByMemNoAndProTypeAndOrderDateBetween(memNo, proType, startDate, endDate, pageable));
		model.addAttribute("sum", ordersService.sumTotalPriceByMemNoAndProTypeAndOrderDateBetween(memNo, proType, startDate, endDate));
		}
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		return "index.jsp?contentPage=mypage/myProList";
	}

	// 좋아한 프로젝트 목록
	@GetMapping("/projectLikeList")
	public String myProLikeList(HttpServletRequest request, Model model, Pageable pageable) {
		model.addAttribute("likeList", projectLikeService.findAll(request, pageable));
		model.addAttribute("likeListCount", projectLikeService.countByMemNo(request));
		return "index.jsp?contentPage=mypage/myProLikeList";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 문의및신청 목록
	@GetMapping("/qnaList")
	public String myQnaList(Model model, @Qualifier("pageable1") Pageable pageable1, HttpSession session, @Qualifier("pageable2") Pageable pageable2) {
		Long memNo = (Long) session.getAttribute("memNo");

		if (pageable1.getSort().toString() == "UNSORTED") {
			pageable1 = PageRequest.of(pageable1.getPageNumber(), pageable1.getPageSize(), Sort.by("askNo").descending());
		}
		model.addAttribute("askList", askService.findAllByMemNo(memNo, pageable1));
		model.addAttribute("askCount", askService.countByMemNo(memNo));

		if (pageable2.getSort().toString() == "UNSORTED") {
			pageable2 = PageRequest.of(pageable2.getPageNumber(), pageable2.getPageSize(), Sort.by("aplNo").descending());
		}
		model.addAttribute("aplList", aplService.findAllByMemNo(memNo, pageable2));
		model.addAttribute("aplCount", aplService.countByMemNo(memNo));

		System.out.println("문의및신청 목록");
		return "index.jsp?contentPage=mypage/myQnaList";
	}

	// 문의하기 - 상세
	@GetMapping("/askDetail")
	public String myAskDetail(Long askNo, Model model) {
		model.addAttribute("ask", askService.findByAskNo(askNo));
		System.out.println("문의하기 상세");
		return "index.jsp?contentPage=mypage/myQnaAskDetail";
	}

	// 문의하기 - 폼 이동
	@GetMapping("/askInsert")
	public String myAskInsertForm() {
		System.out.println("문의하기 폼 이동");
		return "index.jsp?contentPage=mypage/myQnaAskInsert";
	}

	// 문의하기 - 실행
	@PostMapping("/askInsert")
	public String myAskInsert(AskDto askDto, HttpSession session) {
		askService.save(askDto, session);
		System.out.println("문의하기 실행");
		return "redirect:qnaList";
	}

	// 프로젝트 신청 - 상세
	@GetMapping("/applyDetail")
	public String myAplDetail(Long aplNo, Model model) {
		model.addAttribute("req", aplService.findByAplNo(aplNo));
		System.out.println("신청 상세");
		return "index.jsp?contentPage=mypage/myQnaAplDetail";
	}

	// 프로젝트 신청 - 폼 이동
	@GetMapping("/applyInsert")
	public String myAplInsert(Model model) {
		System.out.println("프로젝트 신청 폼 이동");
		return "index.jsp?contentPage=mypage/myQnaAplInsert";
	}

	// 프로젝트 신청 - 실행 (이후 신청목록으로 이동)
	@PostMapping("/applyInsert")
	public String myAplInsert(HttpSession session, HttpServletRequest request, ApplyDto proRequest, FilesDto filesDto, @RequestParam("fileName") MultipartFile[] files, ImgDto imgDto) throws NoSuchAlgorithmException, IOException {
		aplService.save(proRequest, request, session);

		if (files[1].getSize() == 0) {
			// 두번째로 들어오는 파일의 용량이 0일경우( =두번째 파일을 선택하지 않은 경우/null체크 안됨. 들어오는 건 requestParam 2개 무조건 들어옴.)
			imgService.restore(proRequest, imgDto, files[0]);
		} else {
			imgService.restore(proRequest, imgDto, files[0]);
			fileUploadService.restore(proRequest, filesDto, files[1]);
		}
		System.out.println("프로젝트 신청 실행");
		return "redirect:/qnaList";
	}
}