package com.study.springboot.service;

import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.repository.BoardRepository;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	// 게시판 상세보기
	public BoardDto findByBbsNo(Long bbsNo) {
		return boardRepository.findByBbsNo(bbsNo);
	}

	// 공지사항 리스트
	public Page<BoardDto> noticeList(String bbsType, Pageable pageable) {
		return boardRepository.findAllByBbsType(bbsType, pageable);
	}

	// 공지사항 카운트
	public int noticeCount() {
		return boardRepository.countByBbsType("공지사항");
	}

	// 이벤트 리스트
	public Page<BoardDto> eventList(String bbsType, Pageable pageable) {
		return boardRepository.findAllByBbsType(bbsType, pageable);
	}

	// 이벤트 카운트
	public int eventCount() {
		return boardRepository.countByBbsType("이벤트");
	}

	// 게시판 저장
	public BoardDto save(BoardDto boardDto, HttpServletRequest request) {
		String content = request.getParameter("textAreaContent");
		content.replace("\r\n", "<br/>"); // 줄바꿈 그대로 저장하기. 안하면 나중에 한줄로만 나옴(공백으로 인식해서)
		boardDto.setBbsContent(content);
		boardDto.setBbsDate(LocalDateTime.now());
		return boardRepository.save(boardDto);
	}
}
