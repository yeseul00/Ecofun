package com.study.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.dto.AccountInfoDto;

@Repository
public interface AccountInfoRepository extends JpaRepository<AccountInfoDto, Long>{
	
	@Transactional
	public void deleteByMemNo(Long memNo);

	public List<AccountInfoDto> findAllByMemNo(Long memNo);

	public AccountInfoDto findByMemNo(Long memNo);	
}
