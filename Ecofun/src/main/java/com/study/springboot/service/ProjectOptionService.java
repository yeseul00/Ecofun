package com.study.springboot.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.ProjectOptionDto;
import com.study.springboot.repository.ProjectOptionRepository;

@Service
public class ProjectOptionService {

	@Autowired
	private ProjectOptionRepository optionsRepository;

	public ProjectOptionDto findByOpNo(Long opNo) {
		return optionsRepository.findByOpNo(opNo);
	}

	public ProjectOptionDto findByProNo(Long proNo) {
		return optionsRepository.findByProNo(proNo);
	}

	public List<ProjectOptionDto> findAllByProNo(Long proNo) {
		return optionsRepository.findAllByProNo(proNo);
	}

	public void save(ProjectOptionDto optionDto) {
		optionsRepository.save(optionDto);
	}
}