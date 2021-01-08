<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function() {
		$(".password_check").keyup(function() {
			$(".pw_check_result").remove();
			if ($("#memPw").val().length > 0 && $("#memPw_re").val().length > 0) {
				if ($("#memPw").val() == $("#memPw_re").val()) {
					$(".memPwLabel").after('<span class="pw_check_result id-check-sucess">비밀번호 일치</span>');
				} else {
					$(".memPwLabel").after('<span class="pw_check_result id-check-fail">비밀번호 불일치</span>');
				}
			}
		});
	});
</script>

<style>
#label {
	font-size: large;
	color: darkgray;
}
</style>

<div class="container">
	<!-- title -->
	<div>
		<h4>| 비밀번호 변경</h4>
	</div>
	<hr>
	<br>

	<!-- 변경 폼 -->
	<div class="register">
		<form action="/memPwUpdate" method="post" class="register-form">
			<!-- 비밀번호 -->
			<div id="memPw_div">
				<!-- <label class="register-label" for="memPw"><span class="red">*</span>비밀번호</label> -->
				<input type="password" id="memPw" name="memPw" class="password_check" placeholder="비밀번호*" pattern=".{6,20}" title="6 to 20 characters" required>
				<!-- <p class="help-block">비밀번호는 6자리 이상이어야 합니다</p> -->
			</div>
			<!-- 비밀번호 확인 -->
			<div id="memPw_re_div">
				<!-- <label class="register-label" for="memPw_re"><span class="red">*</span>비밀번호 확인</label> -->
				<input type="password" id="memPw_re" name="memPw_re" class="memPwLabel password_check" placeholder="비밀번호*" pattern=".{6,20}" title="6 to 20 characters"
					required
				>
			</div>

			<div>
				<label id="label"> ※ 영문 숫자, 특수문자를 조합하여 6~20자 이내로 입력</label>
			</div>
			<br> <br>

			<!-- 하단 변경 버튼 -->
			<div class="text-center" role="group">
				<button type="button" onclick="history.back();">취소하기</button>
				<button type="submit">저장하기</button>
			</div>
		</form>
	</div>
</div>