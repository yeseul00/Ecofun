package com.study.springboot.service;

import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.repository.MemberRepository;
import com.study.springboot.repository.OrdersRepository;
import com.study.springboot.util.Encrypt;

@Service
public class MemberService {

	@Autowired
	private MemberRepository memberRepository;

	@Autowired
	private OrdersRepository orderRepository;

	public MemberDto findByMemNo(Long memNo) {
		return memberRepository.findByMemNo(memNo);
	}

	public MemberDto findByMemId(String memId) {
		return memberRepository.findByMemId(memId);
	}

	public Optional<MemberDto> findById(Long memNo) {
		return memberRepository.findById(memNo);
	}

	public List<MemberDto> findAllByMemIdLike(String keyword) {
		return memberRepository.findAllByMemIdLike("%" + keyword + "%");
	}

	public Page<MemberDto> findAll(Pageable pageable) {
		Page<MemberDto> member = memberRepository.findAll(pageable);
		member.forEach(e -> {
			Long count = orderRepository.countByMemNo(e.getMemNo());
			e.setProjectOrderCount(count);
		});
		return member;
	}

	public MemberDto findByMemIdAndMemPw(MemberDto member, HttpSession session) throws NoSuchAlgorithmException {
		MemberDto memberDto = memberRepository.findByMemIdAndMemPw(member.getMemId(), Encrypt.sha256(member.getMemPw()));
		if (memberDto != null) {
			session.setAttribute("memNo", memberDto.getMemNo());
			session.setAttribute("memId", memberDto.getMemId());
			session.setAttribute("memName", memberDto.getMemName());
		}
		return memberDto;
	}

	public MemberDto save(MemberDto member, HttpSession session) throws NoSuchAlgorithmException {
		member.setMemPw(Encrypt.sha256(member.getMemPw()));
		member.setMemJoinDate(LocalDateTime.now());
		MemberDto memberDto = memberRepository.save(member);

		if (memberDto != null) {
			session.setAttribute("memNo", memberDto.getMemNo());
			session.setAttribute("memId", memberDto.getMemId()); // 가입 성공 후 로그인을 위한 세션 처리
			session.setAttribute("memName", memberDto.getMemName());
		}
		return memberDto;
	}

	public void memUpdate(Long memNo, String phone) {
		Optional<MemberDto> memberOpt = memberRepository.findById(memNo);
		memberOpt.ifPresent(member -> {
			member.setMemTel(phone);
			memberRepository.save(member);
		});
	}

	public void pwUpdate(Long memNo, String newPW) {
		Optional<MemberDto> memberOpt = memberRepository.findById(memNo);
		memberOpt.ifPresent(member -> {
			try {
				member.setMemPw(Encrypt.sha256(newPW));
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			memberRepository.save(member);
		});
	}

	public Long deleteByMemNo(Long memNo) {
		return memberRepository.deleteByMemNo(memNo);
	}

	public Long countByMemId(MemberDto member) {
		return memberRepository.countByMemId(member.getMemId());
	}

	public Long countByMemJoinDateBetween() {
		return memberRepository.countByMemJoinDateBetween(LocalDate.now().atStartOfDay(), LocalDate.now().atTime(23, 59, 59));
	}
}
