package com.study.springboot.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.ProjectCmtDto;
import com.study.springboot.repository.MemberRepository;
import com.study.springboot.repository.ProjectCmtRepository;

@Service
public class ProjectCmtService {

	@Autowired
	private ProjectCmtRepository cmtRepository;

	@Autowired
	private MemberRepository memberRepository;

	// 목록
	@Transactional
	public Page<ProjectCmtDto> findAllByProNo(Long proNo, Pageable pageable) {
		return cmtRepository.findAllByProNo(proNo, pageable);
	}

	public List<ProjectCmtDto> findAllByProNo(Long proNo){
		return cmtRepository.findAllByProNo(proNo);
	}
	
	public List<MemberDto> findAllMemberByProjectCmt(List<ProjectCmtDto> cmtList) {
		List<MemberDto> memList = new ArrayList<MemberDto>();
		for (ProjectCmtDto cmt : cmtList) {
			memList.add(memberRepository.findByMemNo(cmt.getCmtMemNo()));
		}
		return memList;
	}

	// 입력
	@Transactional
	public ProjectCmtDto save(ProjectCmtDto cmtDto) {
		cmtDto.setCmtDate(LocalDateTime.now());
		return cmtRepository.save(cmtDto);
	}

	// 카운트
	@Transactional
	public Long countCmt() {
		return cmtRepository.count();
	}
}