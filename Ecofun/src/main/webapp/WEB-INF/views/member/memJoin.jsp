<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function() {
		$(".btn-id-check").click(function() {
			idCheck(this.form);
		});

		$(".password-check").keyup(function() {
			$(".pw_check_result").remove();
			if ($("#memPw").val().length > 0 && $("#memPw_re").val().length > 0) {
				if ($("#memPw").val() == $("#memPw_re").val()) {
					$(".memPwLabel").after('<span class="pw_check_result id-check-sucess">비밀번호 일치</span>');
				} else {
					$(".memPwLabel").after('<span class="pw_check_result id-check-fail">비밀번호 불일치</span>');
				}
			}
		});

		$('#memTel').keyup(function() {
			this.value = $('#memTel').val().replace(/[^0-9]/g, '');
		});

		$('#accountNumber').keyup(function() {
			this.value = $('#accountNumber').val().replace(/[^0-9]/g, '');
		});
	});

	var isIdCheck = {
		flag : 1, // 1 중복된 아이디 or 중복체크 안했음, 0 사용 가능한 아이디
		id : "" // 중복체크에 사용된 아이디
	}

	function formCheck() {
		if (isIdCheck.flag == 1 || isIdCheck.id != this.memId.value) {
			$(".id-check-result").remove();
			alert("아이디 중복체크를 해주세요.");
			return false;
		}

		if (this.accountNumber.value == "") {
			this.accountNumber.value = 0; // java 타입에러 방지 (DB에 저장하지 않음)
		}

		if (this.postalCode.value == "") {
			alert("우편번호를 입력해주세요.");
			return false;
			//this.postalCode.value = 0; // java 타입에러 방지 (DB에 저장하지 않음)
		}
	}

	function idCheck(form) {
		if (form.memId.value == "") {
			alert("아이디를 입력해주세요.");
			return;
		}

		$(".id-check-result").remove();
		$.ajax({
			type : "post",
			url : "idCheck",
			data : $(form).serialize(),
			success : function(data) {
				if (data == 0) {
					isIdCheck.flag = 0;
					isIdCheck.id = form.memId.value;
					$(".btn-id-check").after('<br><span class="id-check-result id-check-sucess">사용 가능한 아이디</span>');
				} else {
					$(".btn-id-check").after('<br><span class="id-check-result id-check-fail">중복된 아이디</span>');
				}
			},
			dataType : "text"
		});
	}
</script>

<div class="container">
	<div>
		<h4>| 회원 가입</h4>
	</div>
	<hr>
	<br>

	<div class="register">
		<form action="/member/join" method="post" onsubmit="return formCheck()">
			<div id="mem-id" class="d-flex-wrap">
				<!-- <label class="register-label" for="memId"><span class="red">*</span>아이디</label> -->
				<input type="text" class="form-control not col-6" id="memId" name="memId" placeholder="아이디*" required>
				<button type="button" class="btn-id-check col-3">중복체크</button>
				<!-- <p class="help-block">영문자, 숫자, _ 만 입력 가능. 최소 3자이상 입력하세요</p> -->
			</div>
			<div id="mem-pw">
				<input type="password" class="form-control col-9 memPwLabel" id="memPw" name="memPw" class="password-check" maxlength="20" placeholder="비밀번호*" />
				<!-- <p class="help-block">비밀번호는 6자리 이상이어야 합니다</p> -->
				<input type="password" class="form-control col-9" id="memPw_re" name="memPw_re" class="password-check" placeholder="비밀번호 확인*" />
			</div>
			<br>

			<div>
				<input type="text" class="form-control col-9" id="memName" name="memName" placeholder="이름*" required>
			</div>
			<div>
				<input type="text" class="form-control col-9" id="memTel" name="memTel" maxlength="11" placeholder="연락처*" required>
			</div>
			<br>

			<div class="d-flex-wrap">
				<span class="register-label">주소</span>
				<input type="text" class="form-control not col-6" name="postalCode" id="postalCode" placeholder="우편번호*" readonly="readonly" />
				<button type="button" onclick="sample4_execDaumPostcode();" class="btn-zipCode col-3">주소 검색</button>
				<input type="text" class="form-control col-9" name="address1" id="address1" placeholder="도로명주소*" />
				<input type="text" class="form-control col-9" name="address2" id="address2" placeholder="기본주소*" />
				<input type="text" class="form-control col-9" name="address3" id="address3" placeholder="상세주소*" required />
				<input type="text" class="form-control col-9" name="address4" id="address4" placeholder="참고항목" readonly="readonly" />
				<input type="hidden" name="mem_address4" />
			</div>
			<br>

			<div>
				<span class="register-label">
					계좌
					<span class="red">*</span>
				</span>
				<select name="bankName" class="form-control" required>
					<option value="">은행을 선택하세요 *</option>
					<option value="국민은행">국민은행</option>
					<option value="우리은행">우리은행</option>
					<option value="신한은행">신한은행</option>
					<option value="농협은행">농협은행</option>
					<option value="카카오뱅크">카카오뱅크</option>
				</select>
				<input type="text" class="form-control col-9" id="accountName" name="accountName" maxlength="10" placeholder="계좌주*" required>
				<input type="text" class="form-control col-9" id="accountNumber" name="accountNumber" maxlength="14" placeholder="계좌번호*" required>
			</div>
			<br> <br>

			<div class="text-center">
				<button type="submit" class="btn-register">가입하기</button>
			</div>
		</form>
	</div>
</div>

<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postalCode').value = data.zonecode;
				document.getElementById("address1").value = roadAddr;
				document.getElementById("address2").value = data.jibunAddress;

				// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
				if (roadAddr !== '') {
					document.getElementById("address4").value = extraRoadAddr;
				} else {
					document.getElementById("address4").value = '';
				}

				var guideTextBox = document.getElementById("address1");
				// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				if (data.autoRoadAddress) {
					var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					guideTextBox.style.display = 'block';

				} else if (data.autoJibunAddress) {
					var expJibunAddr = data.autoJibunAddress;
					guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					guideTextBox.style.display = 'block';
				} else {
					guideTextBox.innerHTML = '';
					guideTextBox.style.display = 'none';
				}
			}
		}).open();
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/js/address.js"></script>
