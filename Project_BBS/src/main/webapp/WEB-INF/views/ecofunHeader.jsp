<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String memId = (String) session.getAttribute("memId");
String memName = (String) session.getAttribute("memName");
%>
<style>
/* 페이지네이션 스타일 */
.pagination {
	display: -ms-flexbox;
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem;
}

.sub-wrap {
	border-top: 1px darkgray solid;
	border-bottom: 1px darkgray solid;
	margin-top: 5%;
	margin-bottom: 5%;
	width: 100%;
}
/* 로그인폼 회원가입 버튼설정 */
.pc_join_button {
	width: 100%;
	box-sizing: border-box;
	padding: 16px;
	border: none;
	font-weight: bold;
	font-size: 1.2rem;
	color: black;
	/* 	margin-top: 0px; */
	background: #e9e7e7;
	/* margin-top: 2px; */
}
/* container 마진설정 */
#container {
	margin-top: 5%;
}

#pc-logo {
	box-sizing: none;
}
</style>
<script>
	$(function() {
		$(".project-search")
				.keyup(
						function() {
							if ($(this).val().length > 1) {
								$("#searchResult").empty();
								$
										.ajax({
											type : "get",
											url : "/keywordSearch/"
													+ $(this).val(),
											success : function(data) {
												var appendTag = "";
												$(data)
														.each(
																function(index,
																		item) {
																	appendTag += '<a href="/projectDetail?proNo='
																			+ item.proNo
																			+ '">'
																			+ item.proInfo
																			+ '</a><br>';
																});
												$("#searchResult").append(
														appendTag);
											},
											dataType : "json"
										});
							}
						});
	});
</script>
<!-- 모바일 -->
<!-- <div class="menu_mobile white txt-center"> -->
<div class="navbar fixed-top navbar-light bg-light"
	style="margin-bottom: 0px;">
	<div class="container" style="padding: 0;">
		<!-- 좌측 사이드메뉴 버튼 -->
		<div style="padding: 0;">
			<button class="btn" type="button" data-toggle="modal"
				data-target="#navLeft">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>

		<!-- 로고 -->
		<!-- 모바일로고 -->
		<div class="navbar-brand menu_mobile white txt-center"
			style="width: 58%; left: 21%; margin: 0px; position: absolute; margin-top: 5px;">
			<h5>
				<a href="/main"><img src="/img/ecofunproject.png" alt=" "
					style="width: 100%"></a>
			</h5>
		</div>
		<!-- PC로고 -->
		<div class="navbar-brand menu_pc" id="pc-logo"
			style="width: 30%; left: 35%; margin: 0; position: absolute;">
			<h6>
				<a href="/main"><img src="/img/ecofunproject.png" alt=" "
					style="width: 100%"></a>
			</h6>
		</div>

		<!-- 우측 사이드메뉴 버튼 -->
		<%-- 로그인 전: 로그인 화면 이동 --%>
		<%
			if (memId == null) {
		%>
		<div class="btn-group">
			<button onclick="changeView(1)" class="navbar-toggler" type="button"
				aria-expanded="false" style="border: 0">
				<span><img src="/img/account_circle-black-36dp.svg" alt=""></span>
			</button>
		</div>

		<%-- 로그인 후: 드롭다운 메뉴 --%>
		<%
			} else if (memId != null) {
		%>
		<div class="btn-group">
			<div class="d-none d-sm-inline"
				style="font-size: large; margin: auto;">
				<%=memName%>님 <span class="d-none d-lg-inline">환영합니다.</span>
			</div>
			<button class="navbar-toggler" type="button" data-toggle="dropdown"
				aria-expanded="false" style="border: 0">
				<span><img src="/img/account_circle-black-36dp.svg" alt=""></span>
			</button>
			<div class="dropdown-menu" style="right: 0; left: auto;">
				<ul style="list-style: none; padding-left: 10px;">
					<label style="font-size: large;">프로젝트</label>
					<a href="/myProList" class="dropdown-item"><li>참여한 프로젝트</li></a>
					<a href="/myProLikeList" class="dropdown-item"><li>좋아한
							프로젝트</li></a>
					<li class="dropdown-divider"></li>

					<label style="font-size: large;">문의 및 신청</label>
					<a href="mySuggestList" class="dropdown-item"><li>문의 및 신청
							내역</li></a>
					<a href="/myAskInsertForm" class="dropdown-item"><li>문의하기</li></a>
					<a href="/myApplyInsertForm" class="dropdown-item"><li>프로젝트
							신청하기</li></a>
					<li class="dropdown-divider"></li>

					<label style="font-size: large;">개인정보 수정</label>
					<a href="/pwCheckForm" class="dropdown-item"><li>개인정보 수정</li></a>
					<a href="/memPwUpdateForm" class="dropdown-item"><li>비밀번호
							변경</li></a>
					<a href="/memDeleteForm" class="dropdown-item"
						onclick="changeView(8)"><li>회원 탈퇴</li></a>

					<%-- 관리자일 경우: 관리자 영역 공개 --%>
					<%
						String id = (String) session.getAttribute("memId");
					if (id != null && id.equals("admin")) {
					%>
					<li class="dropdown-divider"></li>
					<label style="font-size: large;">관리자 영역</label>
					<a href="/adMemList" class="dropdown-item" onclick="changeView(9)"><li>회원
							관리</li></a>
					<a href="#" class="dropdown-item" onclick="changeView(10)"><li>프로젝트
							관리</li></a>
					<a href="#" class="dropdown-item" onclick="changeView(11)"><li>문의및신청
							관리</li></a>
					<%
						}
					%>
					<li class="dropdown-divider"></li>
					<li class="dropdown-item" style="cursor: pointer"
						onclick="changeView(6)">로그아웃</li>
				</ul>
			</div>
		</div>
		<%
			}
		%>

	</div>
</div>

<!-- 좌측 사이드 메뉴 (Modal) -->
<div class="modal fade" id="navLeft" tabindex="-1" role="dialog"
	aria-labelledby="navLeft" aria-hidden="true">
	<div class="modal-dialog " role="document"
		style="max-width: 100%; margin: 0;">
		<div class="modal-content" style="min-height: 100vh;">
			<div class="modal-header container">
				<!-- left_타이틀 -->
				<h5 class="modal-title" id="modalTitle">EcoFun Project</h5>

				<!-- left_닫기 버튼 -->
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true" style="font-size: 36px;">&times;</span>
				</button>
			</div>
			<br>

			<div class="modal-body container">
				<!-- left_검색 -->
				<div>
					<nav class="navbar navbar-light bg-light">
						<input class="form-control project-search" type="search"
							placeholder="프로젝트" style="width: 100%;">
						<div id="searchResult"></div>
					</nav>
				</div>
				<br>
				<hr>
				<br>

				<!-- left_프로젝트 -->
				<div>
					<a data-toggle="collapse" href="#project" role="button"
						aria-expanded="false" aria-controls="project"> <label
						style="font-size: large;">프로젝트</label></a>
					<ul class="collapse" id="project">
						<a class="dropdown-item" href="/projectList?type=기부"><li>기부</li></a>
						<a class="dropdown-item" href="/projectList?type=펀딩"><li>펀딩</li></a>
					</ul>
				</div>
				<br> <br>

				<!-- left_게시판 -->
				<div>
					<a data-toggle="collapse" href="#boardList" role="button"
						aria-expanded="false" aria-controls="boardList"> <label
						style="font-size: large;">게시판</label>
					</a>
					<div class="collapse" id="boardList">
						<a class="dropdown-item" href="/boardList"><li>공지사항</li></a> <a
							class="dropdown-item" href="/boardList"><li>이벤트</li></a>
					</div>
				</div>
				<br> <br>

				<!-- left_소개 -->
				<div>
					<a data-toggle="collapse" href="#about" role="button"
						aria-expanded="false" aria-controls="about"> <label
						style="font-size: large;">소개</label>
					</a>
					<div class="collapse" id="about">
						<a class="dropdown-item" href="/company"><li>회사소개</li></a> <a
							class="dropdown-item" href="/cooperation"><li>제휴단체</li></a> <a
							class="dropdown-item" href="/map"><li>오시는길</li></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <script src="js/jquery.min.js"></script> -->