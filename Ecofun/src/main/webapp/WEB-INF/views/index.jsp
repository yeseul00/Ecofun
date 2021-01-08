<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contentPage = request.getParameter("contentPage");
if (contentPage == null)
	contentPage = "ecofunMain.jsp";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>친환경 프로젝트 에코펀!</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/ecofun.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"></script>

<script>
	function changeView(value) {
		if (value == "0") {
			location.href = "/main"; // HOME 버튼 클릭시 첫화면으로 이동
		} else if (value == "1") {
			location.href = "/member/login"; // 로그인 버튼 클릭시 로그인 화면으로 이동
		} else if (value == "2") {
			location.href = "/member/agreeForm"; // 회원가입 버튼 클릭시 약관동의 화면으로 이동
		} else if (value == "3") {
			location.href = "/member/join";// 약관동의 폼의 회원가입 버튼 클릭시 회원가입 처리
		} else if (value == "5") {
			location.href = "/admin/memberList";
		} else if (value == "6") {
			location.href = "/member/logout"; // 로그아웃 버튼 클릭 시, 로그아웃&메인 이동
		}
	}
</script>
</head>

<body>
	<header>
		<jsp:include page="ecofunHeader.jsp" />
	</header>
	<br>

	<section>
		<jsp:include page="<%=contentPage%>" />
	</section>
	<br>
	<hr>
	<br>

	<footer>
		<jsp:include page="ecofunFooter.jsp" />
	</footer>
</body>
</html>