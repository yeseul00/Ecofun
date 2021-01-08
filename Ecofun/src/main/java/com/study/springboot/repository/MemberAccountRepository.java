package com.study.springboot.repository;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.MemberAccountDto;

@Repository
public interface MemberAccountRepository extends JpaRepository<MemberAccountDto, Long> {

	@Transactional
	public void deleteByMemNo(Long memNo);

	public List<MemberAccountDto> findAllByMemNo(Long memNo);

	public MemberAccountDto findByMemNo(Long memNo);
}
