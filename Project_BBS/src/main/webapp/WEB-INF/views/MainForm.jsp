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
<link rel="shortcut icon" href="/img/ecofun.ico" />
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/custom.min.css">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"> -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/hiun/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/font-nanum/1.0/nanumbarungothic/nanumbarungothic.css">
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/ecofun.css">
<!-- 슬라이드 js -->
<link rel="stylesheet" type="text/css" href="/js/slick/slick.css" />
<!-- 슬라이드테마 -->
<link rel="stylesheet" type="text/css" href="/js/slick/slick-theme.css" />
<!-- 스위치 탭 -->
<link rel="stylesheet" href="/css/swichTab.css">
<!-- 애니메이션 -->
<link rel="stylesheet" type="text/css" href="/css/animate.css">
<!-- 아이콘 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">-->
<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous"> -->

<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/custom.js"></script>

<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
<script>
	function changeView(value) {

		if (value == "0") {
			location.href = "main"; // HOME 버튼 클릭시 첫화면으로 이동
		} else if (value == "1") {
			location.href = "loginForm"; // 로그인 버튼 클릭시 로그인 화면으로 이동
		} else if (value == "2") {
			location.href = "agreeForm"; // 회원가입 버튼 클릭시 약관동의 화면으로 이동
		} else if (value == "3") {
			location.href = "memInsertForm";// 약관동의 폼의 회원가입 버튼 클릭시 회원가입 처리
		} else if (value == "4") {
			location.href = "loginLayer"; // 내정보 버튼 클릭시 회원정보 보여주는 화면으로 이동
		} else if (value == "5") {
			location.href = "MemberList";
		} else if (value == "8") {
			location.href = "memDeleteForm";// 회원탈퇴 클릭시 회원탈퇴 화면으로 이동
		}
		
		/* 관리자 */
		  else if (value == "9") {
			location.href = "adMemList";	// 회원 관리
		} else if (value == "10") {
			location.href = "adProList";	// 프로젝트 관리
		} else if (value == "11") {
			location.href = "adSuggestList";// 문의및신청 관리
		}
		
		else if (value == "6") {
			location.href = "logout"; // 로그아웃 버튼 클릭 시, 로그아웃&메인 이동
		}
	}
</script>
</head>
<body style="padding-top: 5%;">
	<!-- 탑 네비게이션영역 -->
	<jsp:include page="ecofunHeader.jsp" />
	<!-- 메인영역 -->
	<jsp:include page="<%=contentPage%>" />
	<hr>
	<!-- 푸터 -->
	<jsp:include page="ecofunFooter.jsp" />

	<!-- <script src="/js/jquery.min.js"></script>
	<script src="/js/bootstrap.bundle.min.js"></script>
	<script src="/js/custom.js"></script> -->
</body>
</html>