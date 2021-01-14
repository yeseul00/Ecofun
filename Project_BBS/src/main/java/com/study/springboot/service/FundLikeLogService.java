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

import com.study.springboot.dto.FundLikeLogDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.repository.FundLikeLogRepository;
import com.study.springboot.repository.ImgRepository;
import com.study.springboot.repository.ProjectRepository;

@Service
public class FundLikeLogService {

	@Autowired
	private FundLikeLogRepository fundLikeLogRepository;

	@Autowired
	private ProjectRepository projectRepository;

	@Autowired
	private ImgRepository imgRepository;

	public FundLikeLogDto saveLike(FundLikeLogDto likeDto, HttpServletRequest request) {
		likeDto.setLikeDate(LocalDateTime.now());
		likeDto.setMemNo((Long) request.getSession().getAttribute("memNo"));
		return fundLikeLogRepository.save(likeDto);
	}

	public Long countByMemNoAndProNo(Long proNo, HttpServletRequest request) {
		return fundLikeLogRepository.countByMemNoAndProNo((Long) request.getSession().getAttribute("memNo"), proNo);
	}

	public Long deleteLike(FundLikeLogDto likeDto, HttpServletRequest request) {
		return fundLikeLogRepository.deleteByMemNoAndProNo((Long) request.getSession().getAttribute("memNo"), likeDto.getProNo());
	}

	public Page<FundLikeLogDto> findAllByList(HttpServletRequest request, Pageable pageable) {
		String proType = request.getParameter("proType");
		String proState = request.getParameter("proState");

		Page<FundLikeLogDto> likeArr = null;

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

	private Page<FundLikeLogDto> findAllByMemNo(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");

		if (pageable.getSort().toString() == "UNSORTED") { // 정렬 값이 없다면 기본키 내림차순 정렬
			pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("fundLikeNo").descending());
		}

		Page<FundLikeLogDto> likeArr = fundLikeLogRepository.findAllByMemNo(memNo, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴

			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {

				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});

				e.setProjectDto(project); // FundLikeLogDto 리스트에 담기 위한 프로젝트 객체 set

			});

		});

		return likeArr;
	}

	private Page<FundLikeLogDto> findAllByMemNoAndProType(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proType = request.getParameter("proType");

		Page<FundLikeLogDto> likeArr = fundLikeLogRepository.findAllByMemNoAndProType(memNo, proType, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴

			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {

				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});

				e.setProjectDto(project); // FundLikeLogDto 리스트에 담기 위한 프로젝트 객체 set

			});

		});

		return likeArr;
	}

	private Page<FundLikeLogDto> findAllByMemNoAndProState(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proState = request.getParameter("proState");

		Page<FundLikeLogDto> likeArr = fundLikeLogRepository.findAllByMemNoAndProState(memNo, proState, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴

			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {

				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});

				e.setProjectDto(project); // FundLikeLogDto 리스트에 담기 위한 프로젝트 객체 set

			});

		});

		return likeArr;
	}

	private Page<FundLikeLogDto> findAllByMemNoAndProTypeAndProState(HttpServletRequest request, Pageable pageable) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		String proType = request.getParameter("proType");
		String proState = request.getParameter("proState");

		Page<FundLikeLogDto> likeArr = fundLikeLogRepository.findAllByMemNoAndProTypeAndProState(memNo, proType, proState, pageable);
		likeArr.forEach(e -> { // 해당 회원의 좋아한 프로젝트 내역을 불러옴

			Optional<ProjectDto> projectOpt = projectRepository.findById(e.getProNo()); // 좋아한 내역과 일치하는 프로젝트 정보를 불러옴
			projectOpt.ifPresent(project -> {

				Optional<ImgDto> imgOpt = imgRepository.findByProNo(project.getProNo()); // 프로젝트의 이미지 파일 경로를 불러옴
				imgOpt.ifPresent(img -> {
					project.setImgDto(img);
				});

				e.setProjectDto(project); // FundLikeLogDto 리스트에 담기 위한 프로젝트 객체 set

			});

		});

		return likeArr;
	}

	public int countByMemNo(HttpServletRequest request) {
		Long memNo = (Long) request.getSession().getAttribute("memNo");
		return fundLikeLogRepository.findAllByMemNo(memNo).size();
	}
}
