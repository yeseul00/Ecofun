<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div>
		<h4>| 비밀번호 확인</h4>
	</div>
	<hr>
	<br> <br>

	<!-- 설명 -->
	<div class="row text-center">
		<h5 class="col-lg-8 col-sm-9">사용자 확인을 위해 비밀번호를 다시 한번 입력해주세요!</h5>
	</div>
	<br> <br>

	<!-- 입력값 -->
	<div class="text-center">
		<div>
			<form action="/member/pwCheck" method="post">
				<input type="password" name="password" class="text-center col-lg-6 col-sm-8" style="height: 50px;" required>
				<input type="submit" class="col-lg-3 col-sm-8" value="확인" style="height: 50px;">
			</form>
		</div>
	</div>
</div>