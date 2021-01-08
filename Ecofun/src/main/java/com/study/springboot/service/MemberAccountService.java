package com.study.springboot.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.MemberAccountDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.repository.MemberAccountRepository;

@Service
public class MemberAccountService {

	@Autowired
	private MemberAccountRepository accountRepository;

	public MemberAccountDto findByMemNo(Long memNo) {
		return accountRepository.findByMemNo(memNo);
	}

	public Long findAccountNoByMemNo(Long memNo) {
		List<MemberAccountDto> list = accountRepository.findAllByMemNo(memNo);
		MemberAccountDto accountDto = list.get(0);
		return accountDto.getAccountNo();
	}

	public void save(MemberDto member, MemberAccountDto accountInfo) {
		accountInfo.setMemNo(member.getMemNo());
		accountInfo.setAccountDate(LocalDateTime.now());
		accountRepository.save(accountInfo);
	}

	public void deleteByMemNo(Long memNo) {
		accountRepository.deleteByMemNo(memNo);
	}

	public void update(Long memNo, MemberAccountDto accountDto) {
		Long AccountNo = findAccountNoByMemNo(memNo);
		if (AccountNo == null) { // 지금은 필요없음. 키값이 없을 때(=회원가입할 때 저장안했으면 새로 만들어주는 로직)
			accountDto.setAccountDate(LocalDateTime.now());
			accountDto.setMemNo(memNo);
			accountRepository.save(accountDto);
			System.out.println("account 새로 생성!");
		} else if (AccountNo != null) { // 부분수정 로직
			Optional<MemberAccountDto> accountOpt = accountRepository.findById(AccountNo);
			accountOpt.ifPresent(account -> {
				account.setAccountDate(LocalDateTime.now());
				account.setMemNo(memNo);
				account.setBankName(accountDto.getBankName());
				account.setAccountName(accountDto.getAccountName());
				account.setAccountNumber(accountDto.getAccountNumber());
				account.setAccountName(account.getAccountName());
				accountRepository.save(account);
			});
		}
	}
}
