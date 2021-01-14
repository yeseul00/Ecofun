<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.findPw-input {
	height: 50px;
	margin: 10px auto;
	border: lightgray solid 1px;
}
</style>

<script>
	function mail() {
		$.ajax({
			url : "findPw.mail?",
			data : {
				memName : document.getElementById('memName').value,
				memId : document.getElementById('memId').value
			},
			type : "POST",
			dataType : "text",
			success : function(result) {
				if (result == 2) {
					alert('일치하는 회원 정보를 찾을 수 없었습니다.');
				} else if (result == 1) {
					alert('일치하는 회원 정보를 찾을 수 없었습니다.');
				} else {
					$('.pw-check').show();
				}
			},
			error : function(result) {
				alert('죄송합니다. 잠시 후 다시 시도해주세요.');
			}
		});
	}

	function check() {
		$.ajax({
			url : "findPw.check?",
			data : {
				check : document.getElementById('check').value,
				memId : document.getElementById('memId').value
			},
			type : "POST",
			dataType : "text",
			success : function(result) {
				if (result == 1) {
					alert('인증 코드가 일치하지 않습니다.');
				} else {
					window.location.href = "memPwUpdateForm";
				}
			},
			error : function(result) {
				alert('죄송합니다. 잠시 후 다시 시도해주세요.');
			}
		});
	}
</script>

<div class="container" style="margin-top: 30px;">
	<div>
		<h6>비밀번호 찾기</h6>
		<hr>
	</div>
	<br>
	<div>
		<div class="pw-mail">
			<div class="col-md-10 col-sm-10" style="margin: 30px auto; text-align: center;">
				<h5>회원가입 시 입력한 이름과 이메일 주소를 적어주세요</h5>
			</div>
			<div class="row">
				<input type="text" class="col-md-6 col-sm-9 findPw-input" id="memName" name="memName" placeholder="이름">
			</div>
			<div class="row">
				<input type="text" class="col-md-6 col-sm-9 findPw-input" id="memId" name="memId" placeholder=" 이메일주소">
			</div>
			<div class="row">
				<input type="button" class="col-md-6 col-sm-9 findPw-input" style="background-color: lightgray;" value="확인" onclick="mail()">
			</div>
		</div>
		<%-- <%
			if (request.getAttribute("auth") != null) {
		%> --%>
		<div class="pw-check" style="display: none;">
			<div class="col-md-10 col-sm-10" style="margin: 30px auto; text-align: center;">
				<h5>발송된 인증 코드를 입력해주세요.</h5>
			</div>
			<div class="row">
				<input type="text" class="col-md-6 col-sm-9 findPw-input" id="check" name="check" placeholder="인증 코드">
			</div>
			<div class="row">
				<input type="button" class="col-md-6 col-sm-9 findPw-input" style="background-color: lightgray;" value="확인" onclick="check()">
			</div>
		</div>
		<%-- <%
			}
		%> --%>
	</div>
</div>