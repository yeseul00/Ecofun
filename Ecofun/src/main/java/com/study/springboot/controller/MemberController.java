package com.study.springboot.controller;

import java.security.NoSuchAlgorithmException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.study.springboot.dto.AddressDto;
import com.study.springboot.dto.MemberAccountDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.service.AddressService;
import com.study.springboot.service.MailService;
import com.study.springboot.service.MemberAccountService;
import com.study.springboot.service.MemberService;
import com.study.springboot.util.Encrypt;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;

	@Autowired
	AddressService addressService;

	@Autowired
	MemberAccountService accountService;

	@Autowired
	MailService mailService;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 로그인 - 폼 이동
	@GetMapping("/login")
	public String loginForm() {
		return "index.jsp?contentPage=member/memLogin";
	}

	// 로그인 - 실행
	@PostMapping("/login")
	public ResponseEntity<MemberDto> login(MemberDto member, HttpSession session) throws NoSuchAlgorithmException {
		return new ResponseEntity<MemberDto>(memberService.findByMemIdAndMemPw(member, session), HttpStatus.OK);
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 약관동의 - 폼 이동
	@GetMapping("/agreeForm")
	public String agreeForm(Model model) {
		return "index.jsp?contentPage=member/memAgree";
	}

	// 회원가입 - 폼 이동
	@GetMapping("/join")
	public String insertForm(Model model) {
		return "index.jsp?contentPage=member/memJoin";
	}

	// 회원가입 - 아이디 중복 체크
	@PostMapping("/join.idCheck")
	public ResponseEntity<Long> idCheck(MemberDto member) {
		return new ResponseEntity<Long>(memberService.countByMemId(member), HttpStatus.OK);
	}

	// 회원가입 - 실행
	@PostMapping("/join")
	public String insert(MemberDto member, AddressDto address, MemberAccountDto accountInfo, HttpSession session) throws NoSuchAlgorithmException {
		if (member != null) {
			MemberDto memberDto = memberService.save(member, session);
			mailService.sendMail(member.getMemId(), member.getMemName(), 1);
			if (memberDto != null) {
				if (!address.getAddress1().equals("")) {
					addressService.save(memberDto, address);
				}
				if (!accountInfo.getBankName().equals("") && !accountInfo.getAccountName().equals("") && accountInfo.getAccountNumber() > 0) {
					accountService.save(memberDto, accountInfo);
				}
			}
		}
		return "redirect:/main";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 개인정보수정 - 폼 이동
	@GetMapping("/update")
	public String updateForm(MemberDto member, AddressDto address, MemberAccountDto account, Model model, HttpSession session) {
		Long memNo = (Long) session.getAttribute("memNo");
		member = memberService.findByMemNo(memNo);
		address = addressService.findByMemNo(memNo);
		account = accountService.findByMemNo(memNo);
		model.addAttribute("member", member);
		model.addAttribute("address", address);
		model.addAttribute("account", account);
		return "index.jsp?contentPage=mypage/myMemUpdate";
	}

	// 개인정보수정 - 실행
	@PutMapping("/update")
	public String update(MemberDto member, AddressDto address, MemberAccountDto account, HttpSession session) {
		Long memNo = (Long) session.getAttribute("memNo");
		addressService.update(memNo, member.getMemName(), address);
		accountService.update(memNo, account);
		memberService.memUpdate(memNo, member.getMemTel());
		return "redirect:/main";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 회원탈퇴 - 폼 이동
	@GetMapping("/withdraw")
	public String deleteForm() {
		return "index.jsp?contentPage=mypage/myMemDelete";
	}

	// 회원탈퇴 - 실행
	@DeleteMapping("/withdraw")
	public ResponseEntity<Long> delete(HttpSession session) {
		Long memNo = (Long) session.getAttribute("memNo");
		addressService.deleteByMemNo(memNo);
		accountService.deleteByMemNo(memNo); // 탈퇴 회원의 모든 계좌 삭제
		Long deleteCount = memberService.deleteByMemNo(memNo); // 회원탈퇴
		session.invalidate(); // 세션 해제하여 로그아웃 처리
		return new ResponseEntity<Long>(deleteCount, HttpStatus.OK); // 탈퇴 성공시 deleteCount > 0 true
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 비밀번호 확인 - 폼 이동 (for 개인정보 진입)
	@GetMapping("/pwCheck")
	public String pwCheckForm() {
		System.out.println("비밀번호 확인 폼 이동");
		return "index.jsp?contentPage=member/memPwCheck";
	}

	// 비밀번호 확인 - 실행
	@PostMapping("/pwCheck")
	public String pwCheck(MemberDto member, HttpServletRequest request, HttpSession session) throws NoSuchAlgorithmException {
		String id = (String) session.getAttribute("memId");
		String pw = request.getParameter("password");
		member = memberService.findByMemId(id);
		if (Encrypt.sha256(pw).equals(member.getMemPw())) {
			return "redirect:/member/update";
		} else {
			return null;
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 비밀번호 찾기 - 폼 이동
	@GetMapping("/pwFind")
	public String findPwForm() {
		return "index.jsp?contentPage=member/memPwFind";
	}

	// 비밀번호 찾기 - 인증 메일 발송
	@PostMapping("/pwFind.mail")
	public @ResponseBody String findPwMail(String memName, String memId, HttpSession session) {
		if (memberService.findByMemId(memId) != null) {
			if (memName.equals(memberService.findByMemId(memId).getMemName())) {
				session.setAttribute("auth", mailService.sendMail(memId, memName, 2));
				return "0";
			}
			return "1"; // 해당 아이디의 회원은 있으나, 이름과 일치하지 않음.
		}
		return "2"; // 해당 아이디의 회원이 없음.
	}

	// 비밀번호 찾기 - 인증 코드 확인 (& 비밀번호 변경 폼 이동)
	@PostMapping("/pwFind.check")
	public @ResponseBody String findPw(String check, String memId, HttpSession session) {
		if (check.equals((String) session.getAttribute("auth"))) {
			session.setAttribute("memNo", memberService.findByMemId(memId).getMemNo());
			System.out.println("aa");
			System.out.println(session.getAttribute("memNo"));
			return "0";
		} else {
			return "1";
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 비밀번호 변경 - 폼 이동
	@GetMapping("/pwUpdate")
	public String pwUpdateForm(Model model) {
		model.addAttribute("memNo", model.getAttribute("memNo"));
		return "index.jsp?contentPage=member/memPwUpdate";
	}

	// 비밀번호 변경 - 실행
	@PostMapping("/pwUpdate")
	public String pwUpdate(HttpSession session, Model model, String memPw) throws NoSuchAlgorithmException {
		Long memNo;
		if (model.getAttribute("memNo") == null) {
			memNo = (Long) session.getAttribute("memNo");
		} else {
			memNo = (Long) model.getAttribute("memNo");
		}
		memberService.pwUpdate(memNo, memPw);

		MemberDto member = memberService.findByMemNo(memNo);
		mailService.sendMail(member.getMemId(), member.getMemName(), 3);
		return "redirect:/main";
	}
}
