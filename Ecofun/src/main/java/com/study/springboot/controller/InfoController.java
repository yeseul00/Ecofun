package com.study.springboot.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
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
import org.springframework.web.bind.annotation.RequestMapping;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.service.ApplyService;
import com.study.springboot.service.AskService;
import com.study.springboot.service.BoardService;
import com.study.springboot.service.FilesService;
import com.study.springboot.service.ImgService;
import com.study.springboot.service.ProjectService;

@Controller
public class InfoController {

	@Autowired
	ProjectService projectService;

	@Autowired
	BoardService boardService;

	@Autowired
	ImgService imgService;

	@Autowired
	AskService askService;

	@Autowired
	ApplyService requestService;

	@Autowired
	FilesService fileUploadService;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 루트 페이지 경로
	@RequestMapping("/")
	public String root() throws Exception {
		return "redirect:main";
	}

	// 메인 (프로젝트 목록)
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
		return "index.jsp?contentPage=ecofunMain";
	}

	// 프로젝트 키워드 검색
	@GetMapping("/keywordSearch/{keyword}")
	public ResponseEntity<List<ProjectDto>> keywordSearch(@PathVariable(name = "keyword") String keyword, Model model) {
		return new ResponseEntity<List<ProjectDto>>(projectService.findAllByProTitleLike(keyword), HttpStatus.OK);
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 회사소개
	@GetMapping("/about/company")
	public String company(Model model, HttpSession session) {
		System.out.println("company");
		return "index.jsp?contentPage=info/company";
	}

	// 제휴단체
	@GetMapping("/about/cooperation")
	public String cooperation(Model model) {
		System.out.println("cooperation");
		return "index.jsp?contentPage=info/cooperation";
	}

	// 오시는길
	@GetMapping("/about/map")
	public String map(Model model) {
		System.out.println("map");
		return "index.jsp?contentPage=info/map";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 게시판 - 목록
	@GetMapping("/board/list")
	public String boardList(Model model, @Qualifier("pageable1") Pageable pageable1, @Qualifier("pageable2") Pageable pageable2) {
		if (pageable1.getSort().toString() == "UNSORTED") {
			pageable1 = PageRequest.of(pageable1.getPageNumber(), pageable1.getPageSize(), Sort.by("bbsNo").descending());
		}
		model.addAttribute("noticeList", boardService.noticeList("공지사항", pageable1));
		model.addAttribute("noticeCount", boardService.noticeCount());

		if (pageable2.getSort().toString() == "UNSORTED") {
			pageable2 = PageRequest.of(pageable2.getPageNumber(), pageable2.getPageSize(), Sort.by("bbsNo").descending());
		}
		model.addAttribute("eventList", boardService.eventList("이벤트", pageable2));
		model.addAttribute("eventCount", boardService.eventCount());

		System.out.println("게시판 목록");
		return "index.jsp?contentPage=info/boardList";
	}

	// 게시판 - 상세
	@GetMapping("/board/detail")
	public String boardDetail(Long bbsNo, Model model) {
		System.out.println("게시판 상세 (bbsNo: " + bbsNo + ")");
		model.addAttribute("bbsNo", boardService.findByBbsNo(bbsNo));
		return "index.jsp?contentPage=info/boardDetail";
	}
}