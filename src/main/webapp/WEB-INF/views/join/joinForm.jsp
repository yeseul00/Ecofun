<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		$(".button_id_check").click(function() {
			idCheck(this.form);
		});
		$(".password_check")
				.keyup(
						function() {
							$(".pw_check_result").remove();
							if ($("#memPw").val().length > 0
									&& $("#memPw_re").val().length > 0) {
								if ($("#memPw").val() == $("#memPw_re").val()) {
									$(".memPwLabel")
											.after(
													'<span class="pw_check_result id_check_sucess">비밀번호 일치</span>');
								} else {
									$(".memPwLabel")
											.after(
													'<span class="pw_check_result id_check_fail">비밀번호 불일치</span>');
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
			$(".id_check_result").remove();
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
		$(".id_check_result").remove();
		$
				.ajax({
					type : "post",
					url : "idCheck",
					data : $(form).serialize(),
					success : function(data) {
						if (data == 0) {
							isIdCheck.flag = 0;
							isIdCheck.id = form.memId.value;
							$(".button_id_check")
									.after(
											'<br><span class="id_check_result id_check_sucess">사용 가능한 아이디</span>');
						} else {
							$(".button_id_check")
									.after(
											'<br><span class="id_check_result id_check_fail">중복된 아이디</span>');
						}
					},
					dataType : "text"
				});
	}
</script>

<div class="section auto">
	<div class="main_wrap">
		<div class="register col-md-10 col-md-offset-1" style="max-width: 100%; margin-top: 60px;">
			<div class="top_nav" style="width: 1000px;">
				<span id="tab">회원가입</span>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>회원 가입</h3>
				</div>
				<div class="panel-heading">
					<form action="/memInsert" method="post" onsubmit="return formCheck()">
						<!-- 아이디 입력 -->
						<div class="" id="memId_div">
							<!-- <label class="register-label" for="memId"><span class="red">*</span>아이디</label> -->
							<div class="register-content-none-border">
								<label style="width: 77%;"> <input type="text" id="memId" name="memId" class="form-control input" placeholder="아이디*" required>
								</label>
								<button type="button" class="button_id_check">중복체크</button>
								<!-- <p class="help-block">영문자, 숫자, _ 만 입력 가능. 최소 3자이상 입력하세요</p> -->
							</div>
						</div>

						<!-- 비밀번호입력 -->
						<div class="" id="memPw_div">
							<!-- <label class="register-label" for="memPw"><span
									class="red">*</span>비밀번호</label> -->
							<div class="register-content-none-border">
								<label class="memPwLabel" style="width: 77%;"> <input type="password" id="memPw" name="memPw"
									class="form-control input password_check" maxlength="20" placeholder="비밀번호*"
								/>
								</label>
								<!-- <p class="help-block">비밀번호는 6자리 이상이어야 합니다</p> -->
							</div>
						</div>

						<!-- 비밀번호 확인 -->
						<div id="memPw_re_div">
							<!-- <label class="register-label" for="memPw_re"><span	class="red">*</span>비밀번호 확인</label> -->
							<div class="register-content-none-border">
								<label style="width: 77%;"> <input type="password" id="memPw_re" name="memPw_re" class="form-control input password_check"
									placeholder="비밀번호 확인*"
								/>
								</label>
							</div>
						</div>

						<!-- 이름입력 -->
						<div id="memName_div">
							<!-- <label class="register-label" for="memName"><span class="red">*</span>성함</label> -->
							<div class="register-content-none-border">
								<input type="text" id="memName" name="memName" class="form-control input" placeholder="성함*" required>
							</div>
						</div>

						<!-- 전화번호 입력 -->
						<div id="memTel_div">
							<!-- <label class="register-label" for="memTel"><span class="red">*</span>연락처</label> -->
							<div class="register-content-none-border">
								<input type="text" id="memTel" name="memTel" class="form-control input" maxlength="11" placeholder="연락처*" required>
							</div>
						</div>
						<div class="" id="mem_address_div">
							<!-- <label class="register-label" for="mem_address"><span
									class="red">*</span>주소</label> -->
							<div class="register-content-none-border">
								<label style="width: 77%;"> <input type="text" name="postalCode" id="postalCode" class="form-control input" placeholder="우편번호*"
									readonly="readonly"
								/>
								</label> <label>
									<button type="button" class="button_postnumber" onclick="sample4_execDaumPostcode();" style="padding-left: 9px; left: 0px;">주소 검색</button>
								</label><br> <input type="text" name="address1" id="address1" class="form-control input" placeholder="도로명주소*" style="margin-top: 20px;"><br>
								<input type="text" name="address2" id="address2" class="form-control input" placeholder="기본주소*"><br> <input type="text"
									name="address3" id="address3" class="form-control input" placeholder="상세주소*" required
								><br> <input type="text" name="address4" id="address4" class="form-control input" readonly="readonly" placeholder="참고항목"> <input
									type="hidden" name="mem_address4"
								>
							</div>
						</div>

						<div id="bankName_div">
							<label class="register-label" for="bankName"> <span class="red">*</span>계좌
							</label>
							<div class="register-content-none-border">
								<select name="bankName" class="form-control input" required>
									<option value="">은행을 선택하세요 *</option>
									<option value="국민은행">국민은행</option>
									<option value="우리은행">우리은행</option>
									<option value="신한은행">신한은행</option>
									<option value="농협은행">농협은행</option>
									<option value="카카오뱅크">카카오뱅크</option>
								</select><br> <input type="text" id="accountName" name="accountName" class="form-control input" maxlength="10" placeholder="계좌주입력*" required><br>
								<input type="text" id="accountNumber" name="accountNumber" class="form-control input" maxlength="14" placeholder="계좌번호 입력*" required>
							</div>
						</div>
						<div class="border_button">
							<button type="submit" class="btn btn-success btn-sm">가입하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
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
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
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
					guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr
							+ ')';
					guideTextBox.style.display = 'block';
				} else if (data.autoJibunAddress) {
					var expJibunAddr = data.autoJibunAddress;
					guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr
							+ ')';
					guideTextBox.style.display = 'block';
				} else {
					guideTextBox.innerHTML = '';
					guideTextBox.style.display = 'none';
				}
			}
		}).open();
	}
</script>
<!-- 다음 주소 스크립트 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/js/address.js"></script>
<script type="text/javascript" src="/js/member_register.js"></script>