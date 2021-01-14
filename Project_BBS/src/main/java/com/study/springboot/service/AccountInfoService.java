package com.study.springboot.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dto.AccountInfoDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.repository.AccountInfoRepository;

@Service
public class AccountInfoService {

	@Autowired
	private AccountInfoRepository accountInfoRepository;

	public void save(MemberDto member, AccountInfoDto accountInfo) {
		accountInfo.setMemNo(member.getMemNo());
		accountInfo.setAccountDate(member.getMemJoinDate());
		accountInfoRepository.save(accountInfo);
	}

	public void deleteByMemNo(Long memNo) {
		accountInfoRepository.deleteByMemNo(memNo);
	}

	public AccountInfoDto findByMemNo(Long memNo) {
		return accountInfoRepository.findByMemNo(memNo);
	}

	public Long findAccountNoByMemNo(Long memNo) { // 어카운트넘버(키값) 있는지 없는지 알아보기 위한 쿼리.
		List<AccountInfoDto> list = accountInfoRepository.findAllByMemNo(memNo);
		AccountInfoDto accountDto = list.get(0);
		return accountDto.getAccountNo();
	}

	public void update(Long memNo, AccountInfoDto accountDto) {
		Long AccountNo = findAccountNoByMemNo(memNo);
		if (AccountNo == null) { // 지금은 필요없음. 키값이 없을 때(=회원가입할 때 저장안했으면 새로 만들어주는 로직)
			accountDto.setAccountDate(LocalDateTime.now());
			accountDto.setMemNo(memNo);
			accountInfoRepository.save(accountDto);
			System.out.println("account 새로 생성!");
		} else if (AccountNo != null) { // 부분수정 로직
			Optional<AccountInfoDto> accountOpt = accountInfoRepository.findById(AccountNo);
			accountOpt.ifPresent(account -> {
				account.setAccountDate(LocalDateTime.now());
				account.setMemNo(memNo);
				account.setBankName(accountDto.getBankName());
				account.setAccountName(accountDto.getAccountName());
				account.setAccountNumber(accountDto.getAccountNumber());
				account.setAccountName(account.getAccountName());
				accountInfoRepository.save(account);
			});
		}
	}
}
