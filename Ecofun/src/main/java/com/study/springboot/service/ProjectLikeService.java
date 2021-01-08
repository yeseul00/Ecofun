package com.study.springboot.service;

import java.time.LocalDateTime;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.dto.ProjectLikeDto;
import com.study.springboot.repository.ProjectLikeRepository;
import com.study.springboot.repository.ProjectRepository;

@Service
public class ProjectLikeService {

	@Autowired
	private ProjectLikeRepository projectLikeRepository;

	@Autowired
	private ProjectRepository projectRepository;

	public ProjectLikeDto save(ProjectLikeDto likeDto, HttpServletRequest request) {
		likeDto.setLikeDate(LocalDateTime.now());
		likeDto.setMemNo((Long) request.getSession().getAttribute("memNo"));
		return projectLikeRepository.save(likeDto);
	}

	public Long delete(ProjectLikeDto likeDto, HttpServletRequest request) {
		return projectLikeRepository.deleteByMemNoAndProNo((Long) request.getSession().getAttribute("memNo"), likeDto.getProNo());
	}

	public Page<ProjectLikeDto> findAll(HttpServletRequest request, Pageable pageable) {
		Page<ProjectLikeDto> likeArr = null;
		String proType = request.getParameter("proType");
		String proState = request.getParameter("proState");
		if (proType != null && !proType.equals("") && proState != null && !proState.equals("")) {
			likeArr = findAllByMemNoAndProTypeAndProState(request, pageable);
		} else if (proType != null && !proType.equals("")) {
			likeArr = findAllByMemNoAndProType(request, pageable);
		} else if (proState != null && !proState.equals("")) {
			likeArr = findAllByMemNoAndProState(request, pageable);
		} else {
			likeArr = findAllByMemNo(request, pageable);
		}
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNo(HttpServletRequest request, Pageable pageable) {
		if (pageable.getSort().toString() == "UNSORTED") {
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("LikeNo").descending());
		}

		Long memNo = (Long) request.getSession().getAttribute("memNo");
		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNo(memNo, pageable);
		likeArr.forEach(e -> {
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo());
			projectOpt.ifPresent(project -> {
				project.setProThumb(project.getProThumb());
				project.setProceed(project.getProceed());
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNoAndProType(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proType = request.getParameter("proType");
		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNoAndProType(memNo, proType, pageable);
		likeArr.forEach(e -> {
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo());
			projectOpt.ifPresent(project -> {
				project.setProThumb(project.getProThumb());
				project.setProceed(project.getProceed());
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNoAndProState(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proState = request.getParameter("proState");
		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNoAndProState(memNo, proState, pageable);
		likeArr.forEach(e -> {
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo());
			projectOpt.ifPresent(project -> {
				project.setProThumb(project.getProThumb());
				project.setProceed(project.getProceed());
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	private Page<ProjectLikeDto> findAllByMemNoAndProTypeAndProState(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proType = request.getParameter("proType");
		String proState = request.getParameter("proState");
		Page<ProjectLikeDto> likeArr = projectLikeRepository.findAllByMemNoAndProTypeAndProState(memNo, proType, proState, pageable);
		likeArr.forEach(e -> {
			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo());
			projectOpt.ifPresent(project -> {
				project.setProThumb(project.getProThumb());
				project.setProceed(project.getProceed());
				e.setProjectDto(project); // ProjectLikeDto 리스트에 담기 위한 프로젝트 객체 set
			});
		});
		return likeArr;
	}

	public int countByMemNo(HttpServletRequest request) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		return projectLikeRepository.findAllByMemNo(memNo).size();
	}

	public Long countByMemNoAndProNo(Long proNo, HttpServletRequest request) {
		return projectLikeRepository.countByMemNoAndProNo((Long) request.getSession().getAttribute("memNo"), proNo);
	}
}
