<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String memId = (String) session.getAttribute("memId");
String memName = (String) session.getAttribute("memName");
%>

<script src="https://kit.fontawesome.com/739d6ca544.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
	$(function() {
		$(".project-search").keyup(function() {
			if ($(this).val().length > 1) {
				$("#search-result").empty();
				$.ajax({
					type : "get",
					url : "/keywordSearch/" + $(this).val(),
					success : function(data) {
						var appendTag = "";
						$(data).each(function(index, item) {
							appendTag += '<a href="/project/detail?proNo=' + item.proNo + '">' + item.proTitle + '</a><br>';
						});
						$("#search-result").append(appendTag);
					},
					dataType : "json"
				});
			}
		});
	});
</script>


<div class="navbar fixed-top navbar-light bg-light" style="padding: 10px 5%;">
	<div class="container">
		<!-- 좌측 메뉴 버튼 -->
		<div style="padding: 0;">
			<button class="btn" id="navLeft-show" type="button" data-toggle="modal" data-target="#navLeft">
				<i class="fas fa-bars" style="font-size: x-large"></i>
			</button>
		</div>

		<!-- 로고 (모바일) -->
		<div class="navbar-brand mobile-menu">
			<a href="/main"> <b class="RymanEco">Ecofun Project</b>
			</a>
		</div>

		<!-- 로고 (PC) -->
		<div class="navbar-brand pc-menu">
			<a href="/main"> <b class="RymanEco">Ecofun Project</b>
			</a>
		</div>

		<!-- 우측 메뉴 버튼 -->
		<%-- 로그인 전: 로그인 화면 이동 --%>
		<%
			if (memId == null) {
		%>
		<div class="btn-group">
			<button onclick="changeView(1)" class="navbar-toggler" type="button" aria-expanded="false" style="border: 0">
				<i class="far fa-user-circle" style="font-size: xx-large"></i>
			</button>
		</div>

		<%-- 로그인 후: 드롭다운 메뉴 --%>
		<%
			} else if (memId != null) {
		%>
		<div class="btn-group">
			<div class="d-none d-sm-inline" style="font-size: large; margin: auto;">
				<%=memName%>님
				<span class="d-none d-lg-inline">환영합니다.</span>
			</div>
			<button class="navbar-toggler" type="button" data-toggle="dropdown" aria-expanded="false" style="border: 0">
				<i class="far fa-user-circle" style="font-size: xx-large"></i>
			</button>
			<div class="dropdown-menu" style="right: 0; left: auto;">
				<ul style="list-style: none; padding-left: 10px;">
					<li>
						<label style="font-size: large;">프로젝트</label>
					</li>
					<li>
						<a href="/mypage/projectList" class="dropdown-item">참여한 프로젝트</a>
					</li>
					<li>
						<a href="/mypage/projectLikeList" class="dropdown-item">좋아한 프로젝트</a>
					</li>
					<li class="dropdown-divider"></li>

					<li>
						<label style="font-size: large;">문의 및 신청</label>
					</li>
					<li>
						<a href="/mypage/qnaList" class="dropdown-item">문의및신청 내역</a>
					</li>
					<li>
						<a href="/mypage/askInsert" class="dropdown-item">문의하기</a>
					</li>
					<li>
						<a href="/mypage/applyInsert" class="dropdown-item">신청하기</a>
					</li>
					<li class="dropdown-divider"></li>

					<li>
						<label style="font-size: large;">회원</label>
					</li>
					<li>
						<a href="/member/pwCheck" class="dropdown-item">개인정보 수정</a>
					</li>
					<li>
						<a href="/member/pwUpdate" class="dropdown-item">비밀번호 변경</a>
					</li>
					<li>
						<a href="/member/withdraw" class="dropdown-item">회원 탈퇴</a>
					</li>

					<%-- 관리자일 경우: 관리자 영역 공개 --%>
					<%
						if (memId != null && memId.equals("admin")) {
					%>
					<li class="dropdown-divider"></li>
					<li>
						<label style="font-size: large;">관리자 영역</label>
					</li>
					<li>
						<a href="/admin/projectList" class="dropdown-item">프로젝트 관리</a>
					</li>
					<li>
						<a href="/admin/qnaList" class="dropdown-item">문의및신청 관리</a>
					</li>
					<li>
						<a href="/admin/memberList" class="dropdown-item">회원 관리</a>
					</li>
					<%
						}
					%>
					<li class="dropdown-divider"></li>
					<li class="dropdown-item" style="cursor: pointer" onclick="changeView(6)">로그아웃</li>
				</ul>
			</div>
		</div>
		<%
			}
		%>
	</div>
</div>

<!-- 좌측 메뉴 (Modal) -->
<div class="modal fade" id="navLeft" tabindex="-1" role="dialog" aria-labelledby="navLeft" aria-hidden="true">
	<div class="modal-dialog " role="document" style="max-width: 100%; margin: 0;">
		<div class="modal-content" style="min-height: 100vh;">
			<div class="modal-header container">
				<!-- left_타이틀 -->
				<h5 class="modal-title" id="modalTitle">EcoFun Project</h5>

				<!-- left_닫기 버튼 -->
				<button type="button" class="close" id="navLeft-hide" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<br>

			<div class="modal-body container">
				<!-- left_검색 -->
				<div>
					<nav class="navbar navbar-light bg-light">
						<input class="project-search" type="search" placeholder="프로젝트" style="width: 100%;">
						<div id="search-result"></div>
					</nav>
				</div>
				<br>
				<hr>
				<br>

				<!-- left_프로젝트 -->
				<div>
					<a data-toggle="collapse" href="#project" role="button" aria-expanded="false" aria-controls="project"> <label style="font-size: large;">프로젝트</label>
					</a>
					<ul class="collapse" id="project">
						<li>
							<a class="dropdown-item" href="/project/list?type=기부">기부</a>
						</li>
						<li>
							<a class="dropdown-item" href="/project/list?type=펀딩">펀딩</a>
						</li>
					</ul>
				</div>
				<br>
				<br>

				<!-- left_게시판 -->
				<div>
					<a data-toggle="collapse" href="#boardList" role="button" aria-expanded="false" aria-controls="boardList"> <label style="font-size: large;">게시판</label>
					</a>
					<ul class="collapse" id="boardList">
						<li>
							<a class="dropdown-item" href="/board/list">공지사항</a>
						</li>
						<li>
							<a class="dropdown-item" href="/board/list">이벤트</a>
						</li>
					</ul>
				</div>
				<br>
				<br>

				<!-- left_소개 -->
				<div>
					<a data-toggle="collapse" href="#about" role="button" aria-expanded="false" aria-controls="about"> <label style="font-size: large;">소개</label>
					</a>
					<ul class="collapse" id="about">
						<li>
							<a class="dropdown-item" href="/about/company">회사소개</a>
						</li>
						<li>
							<a class="dropdown-item" href="/about/cooperation">제휴단체</a>
						</li>
						<li>
							<a class="dropdown-item" href="/about/map">오시는길</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
