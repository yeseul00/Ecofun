package com.study.springboot;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.service.BoardService;
import com.study.springboot.service.FileUploadService;
import com.study.springboot.service.ImgService;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	ImgService imgService;

	@Autowired
	FileUploadService fileService;

	@GetMapping("/adBoardInsert")
	public String adboardForm() {
		System.out.println("게시판 작성 폼 도착");
		return "MainForm.jsp?contentPage=admin/adBoardInsert";
	}

	@PostMapping("/adBoardAction")
	public String adBord(BoardDto boardDto, HttpServletRequest request, Model model,
						 @RequestParam("fileName")MultipartFile file,ImgDto imgDto) {
		
		if( file == null) { //null로 들어오는 경우를 배제할 수 없기 때문에 한번 감싸줌
			boardService.save(boardDto, request);
		}else {
			if( file.getSize() > 0 ) { //값이 있음. (null이 아니라 객체로 들어와서 사이즈로 두번 체크)
				boardService.save(boardDto, request);
				imgService.restore(boardDto, imgDto, file);
				boardService.save(boardDto, request);//두번 해주는 이유는 restore에서 bbsNo를 사용하고, Dto.setImgUrl을 저장해서 최종Dto를 repository에 다시 한번 저장해주기 위함. 
			}else { //null이면 사이즈 0으로 찍힘. 
				boardService.save(boardDto, request);
			}
		}
		/* input 히든으로 하고 button으로 씌울경우 이렇게 하면 null구분가능
		 * if(file.getName()==""||file.getName()==null||file.getName().equals("")) {
		 * System.out.println("0000000000"); }else {
		 * System.out.println("11111111111111");
		 * System.out.println(file.getOriginalFilename()); }
		 */
		model.addAttribute("boardList", boardDto);
		
		return "redirect:boardList";
	}
	
	//게시판 목록
	@GetMapping("/boardList")
	public String boardList(Model model,@Qualifier("pageable1") Pageable pageable1,
										@Qualifier("pageable2") Pageable pageable2) {
		if (pageable1.getSort().toString() == "UNSORTED") {
			pageable1 = PageRequest.of(pageable1.getPageNumber(), pageable1.getPageSize(), Sort.by("bbsNo").descending());
		}
		model.addAttribute("noticeList", boardService.noticeList("공지사항",pageable1));
		model.addAttribute("noticeCount", boardService.countBoard("공지사항"));
		
		if (pageable2.getSort().toString() == "UNSORTED") {
			pageable2 = PageRequest.of(pageable2.getPageNumber(), pageable2.getPageSize(), Sort.by("bbsNo","bbsType").descending());
		}
		model.addAttribute("eventList", boardService.eventList("이벤트",pageable2));
		model.addAttribute("eventCount", boardService.countBoard("이벤트"));
		
		return "MainForm.jsp?contentPage=boardList";
	}
	
	
	//게시판 상세보기
	@GetMapping("/bbsDetail")
	public String noDetail(long bbsNo,Model model) {
		System.out.println("00000000000000bbsNo"+bbsNo);
		model.addAttribute("bbsNo",boardService.getDetail(bbsNo));
		return "MainForm.jsp?contentPage=boardDetail";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
