<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	$(function() {
		$(".login-button").click(function() {
			loginSubmit($(this.form).serialize());
		});
	});

	var loginFail = '<div class="alert alert-warning" role="alert">회원 아이디와 패스워드가 서로 맞지 않습니다.</div>';

	function loginSubmit(formData) {
		$.ajax({
			type : "post",
			url : "login",
			data : formData,
			success : function(data) {
				if (data.memId != "") {
					$(location).attr("href", "/");
				}
			},
			dataType : "json"
		}).fail(function() {
			$(".alert.alert-warning").remove();
			$(".login ul").prepend(loginFail);
		});
	}
</script>

<div class="contianer text-center">
	<form class="login">
		<ul>
			<li>
				<h2>로그인 하세요</h2>
			</li>
			<li>
				<input type="text" class="login_form email" name="memId" placeholder="아이디" maxlength="25" required>
			</li>
			<li>
				<input type="password" class="login_form password" name="memPw" placeholder="비밀번호 (6자 이상)" maxlength="20" required>
			</li>
			<li>
				<label class="auto-login">
					<input type="checkbox" name="notyet">
					자동로그인
				</label>
				<a class="find_account" href="/member/pwFind">아이디/비밀번호 찾기 &#187;</a>
			</li>
			<li>
				<button class="login-button">로그인</button>
			</li>
			<li class="login-line"></li>
			<li>
				<a onclick="changeView(2)">
					<button class="join-button">회원가입</button>
				</a>
			</li>
		</ul>
	</form>
</div>
