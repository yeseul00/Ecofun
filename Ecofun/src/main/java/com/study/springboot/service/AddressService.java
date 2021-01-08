package com.study.springboot.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.AddressDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.repository.AddressRepository;

@Service
public class AddressService {

	@Autowired
	private AddressRepository addressRepository;

	public AddressDto findByMemNo(Long memNo) {
		return addressRepository.findByMemNo(memNo);
	}

	public List<AddressDto> findAllByMemNo(Long memNo) {
		return addressRepository.findAllByMemNo(memNo);
	}

	public Long findDeliveryNoByMemNo(Long memNo) {
		List<AddressDto> list = addressRepository.findAllByMemNo(memNo);
		AddressDto deliveryDto = list.get(0);
		return deliveryDto.getDeliveryNo();
	}

	public void save(MemberDto member, AddressDto address) {
		address.setMemNo(member.getMemNo());
		address.setAddressMemName(member.getMemName());
		address.setAddressDate(LocalDateTime.now());
		addressRepository.save(address);
	}

	public void deleteByMemNo(Long memNo) {
		addressRepository.deleteByMemNo(memNo);
	}

	public void update(Long memNo, String memName, AddressDto addressDto) {
		Long deliveryNo = findDeliveryNoByMemNo(memNo);
		if (deliveryNo == null) { // 지금은 필요없는 로직. 키값이 없을 때(회원가입 시 저장안했을때) 새로 만들어주는 로직
			addressDto.setAddressDate(LocalDateTime.now());
			addressDto.setMemNo(memNo);
			addressDto.setAddressMemName(memName);
			addressRepository.save(addressDto);
			System.out.println("address 새로 생성!");
		} else if (deliveryNo != null) { // 부분수정 로직
			Optional<AddressDto> addressOpt = addressRepository.findById(deliveryNo);
			addressOpt.ifPresent(address -> {
				address.setAddressDate(LocalDateTime.now());
				address.setAddress1(addressDto.getAddress1());
				address.setAddress2(addressDto.getAddress2());
				address.setAddress3(addressDto.getAddress3());
				address.setAddress4(addressDto.getAddress4());
				address.setPostalCode(address.getPostalCode());
				addressRepository.save(address);
			});
		}
	}
}
