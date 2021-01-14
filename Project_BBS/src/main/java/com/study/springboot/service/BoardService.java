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

	public BoardDto save(BoardDto boardDto, HttpServletRequest request) {
		String content = request.getParameter("textAreaContent");
		content.replace("\r\n", "<br/>"); // 줄바꿈 그대로 저장하기. 안하면 나중에 한줄로만 나옴(공백으로 인식해서)
		boardDto.setBbsContent(content);
		boardDto.setBbsDate(LocalDateTime.now());

		return boardRepository.save(boardDto);
	}

	// 공지사항 리스트
	public Page<BoardDto> noticeList(String btype, Pageable pageable) {
		return boardRepository.findAllByBbsType(btype, pageable);
	}

	// 이벤트 리스트
	public Page<BoardDto> eventList(String btype, Pageable pageable) {
		return boardRepository.findAllByBbsType(btype, pageable);
	}

	// 게시판 카운트
	public int countBoard(String type) {
		return boardRepository.countByBbsType(type);
	}

	// 게시판 상세보기
	public BoardDto getDetail(Long bbsNo) {
		return boardRepository.findByBbsNo(bbsNo);
	}
}
