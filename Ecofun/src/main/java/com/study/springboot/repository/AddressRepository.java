package com.study.springboot.repository;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.AddressDto;

@Repository
public interface AddressRepository extends JpaRepository<AddressDto, Long> {

	@Transactional
	public void deleteByMemNo(Long memNo);

	public List<AddressDto> findAllByMemNo(Long memNo);

	public AddressDto findByMemNo(Long memNo);

	public AddressDto findOneByMemNo(Long memNo);
}
