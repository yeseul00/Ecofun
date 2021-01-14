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
<title>EcoFun Project</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.min.css">
<!-- Global Site Tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23019901-1"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	gtag('js', new Date());

	gtag('config', 'UA-23019901-1');
</script>
</head>

<body style="padding-top: 59px;" id="body">
	<!-- 탑 네비게이션영역 시작 -->
	<jsp:include page="ecofunHeader.jsp" />
	<!-- 탑 네비게이션영역 끝 -->
	<div class="container">
		<!-- 메인영역 시작 -->
		<%-- <jsp:include page="ecofunMain.jsp"/> --%>
		<jsp:include page="<%=contentPage%>" />
		<!-- 메인영역 끝 -->
		<hr>
		<!-- 푸터 시작 -->
		<jsp:include page="ecofunFooter.jsp" />
		<!-- 푸터 끝 -->
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/custom.js"></script>
</body>
</html>
