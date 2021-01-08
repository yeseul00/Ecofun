package com.study.springboot.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.repository.ProjectRepository;

@Service
public class ProjectService {

	@Autowired
	private ProjectRepository projectRepository;

	public ProjectDto findByProNo(Long proNo) {
		return projectRepository.findByProNo(proNo);
	}

	public List<ProjectDto> findAllByProTitleLike(String keyword) {
		return projectRepository.findAllByProTitleLike("%" + keyword + "%");
	}

	// 목록
	@Transactional
	public Page<ProjectDto> getProjectList(String state, String type, Pageable pageable) {
		Date now = Date.valueOf(LocalDate.now());
		if (state.equals("진행")) {
			if (type.equals("전체")) {
				return projectRepository.findByProStartBeforeAndProEndAfter(now, now, pageable);
			}
			return projectRepository.findByProStartBeforeAndProEndAfterAndProType(now, now, type, pageable);
		} else if (state.equals("종료")) {
			if (type.equals("전체")) {
				return projectRepository.findByProEndBefore(now, pageable);
			}
			return projectRepository.findByProEndBeforeAndProType(now, type, pageable);
		} else if (state.equals("예정")) {
			if (type.equals("전체")) {
				return projectRepository.findByProStartAfter(now, pageable);
			}
			return projectRepository.findByProStartAfterAndProType(now, type, pageable);
		} else {
			if (type.equals("전체")) {
				return projectRepository.findAll(pageable);
			}
			return projectRepository.findByProType(type, pageable);
		}
	}

	public Page<ProjectDto> getMainList(String state, Pageable pageable) {
		Date now = Date.valueOf(LocalDate.now());
		// List<ProjectDto> list = projectRepository.findAll();
		if (state.equals("진행")) {
			return projectRepository.findByProStartBeforeAndProEndAfter(now, now, pageable);
		} else if (state.equals("예정")) {
			return projectRepository.findByProStartAfter(now, pageable);
		} else {
			return projectRepository.findByProStartBeforeAndProEndAfter(now, now, pageable);
		}
	}

	public List<Integer> countProject() {
		List<Integer> counts = new ArrayList<Integer>();
		counts.add(Long.valueOf(projectRepository.count()).intValue()); // [0]: 전체, 전체
		counts.add(projectRepository.countByProState("예정")); // [1]: 예정, 전체
		counts.add(projectRepository.countByProStateAndProType("예정", "기부")); // [2]: 예정, 기부
		counts.add(projectRepository.countByProStateAndProType("예정", "펀딩")); // [3]: 예정, 펀딩
		counts.add(projectRepository.countByProState("진행")); // [4]: 진행, 전체
		counts.add(projectRepository.countByProStateAndProType("진행", "기부")); // [5]: 진행, 기부
		counts.add(projectRepository.countByProStateAndProType("진행", "펀딩")); // [6]: 진행, 펀딩
		counts.add(projectRepository.countByProState("종료")); // [7]: 종료, 전체
		counts.add(projectRepository.countByProStateAndProType("종료", "기부")); // [8]: 종료, 기부
		counts.add(projectRepository.countByProStateAndProType("종료", "펀딩")); // [9]: 종료, 펀딩
		return counts;
	}

	// 입력
	@Transactional
	public ProjectDto save(ProjectDto projectDto) {
		Date proStart = projectDto.getProStart();
		Date proEnd = projectDto.getProEnd();

		LocalDate nowDate = LocalDate.now();
		LocalDate startDate = proStart.toLocalDate();
		LocalDate endDate = proEnd.toLocalDate();

		if (nowDate.isBefore(startDate)) {
			projectDto.setProState("예정");
		} else if (nowDate.isBefore(endDate.plusDays(1))) {
			projectDto.setProState("진행");
		} else if (nowDate.isAfter(endDate)) {
			projectDto.setProState("종료");
		}

		return projectRepository.save(projectDto);
	}

	public void stateUpdateScheduler() {
		LocalDate nowDate = LocalDate.now();

		projectRepository.findAll().forEach(e -> {
			Date proStart = e.getProStart();
			Date proEnd = e.getProEnd();

			LocalDate startDate = proStart.toLocalDate();
			LocalDate endDate = proEnd.toLocalDate();

			if (nowDate.isBefore(startDate)) {
				e.setProState("예정");
			} else if (nowDate.isBefore(endDate.plusDays(1))) {
				e.setProState("진행");
			} else if (nowDate.isAfter(endDate)) {
				e.setProState("종료");
			}

			projectRepository.save(e);
		});
	}
}