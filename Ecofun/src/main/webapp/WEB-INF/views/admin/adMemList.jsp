<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	// 상세 관련
	function openMemberDetail(memNo) {
		$(".member-detail").empty();
		$.ajax({
			type : "get",
			url : "/admin/memberDetail/" + memNo,
			success : function(data) {
				$(".member-detail").append(data);
			},
			dataType : "html"
		});

		$(".layer-background").css({
			"width" : $(document).width(),
			"height" : $(document).height()
		});
		$(".layer-background").fadeTo("slow", 0.8);

		$(".member-detail").fadeTo("slow", 1);
	}

	// 상세 관련
	$(function() {
		// 열기 (more 클릭)
		$(".open-member-detail").click(function(e) {
			e.preventDefault();
			openMemberDetail($(this).data("mem-no"));
		});

		// 닫기 (배경 클릭)
		$(".layer-background").click(function() {
			$(this).hide();
			$(".member-detail").hide();
		});
	});

	// 정렬 관련
	$(function() {
		$(".member-order").click(function() {
			$(location).attr("href", $(this).attr("href"));
		});

		var orderValue1 = "";
		$.each($("#headerSortParam").val().split(","), function(index, item) {
			var param1 = $.trim(item.split(":")[0]);
			var direction1 = $.trim(item.split(":")[1].toLowerCase());
			if (param1 == "memNo") {
				return true; // true = $.each continue;
			}
			orderValue1 += "&sort=" + param1 + "," + direction1;
			$(".member-order." + param1).data("direction", direction1);
		});

		$(".member-order").each(function(index, item) {
			var orderValue2 = "";
			var param2 = $(this).data("param");
			var direction2 = $(this).data("direction").toLowerCase();
			// 경로에서 기존 정렬 문구 삭제
			$(this).empty();
			orderValue2 = orderValue1.replace("&sort=" + param2 + ",asc", "");
			orderValue2 = orderValue2.replace("&sort=" + param2 + ",desc", "");
			// 정렬 방향에 따른 △▽ 변화. + 다음 번 클릭 시의 경로 설정. 
			if (direction2 == "") {
				$(this).append($(this).data("title") + " △▽");
				orderValue2 += "&sort=" + param2 + ",asc";
			} else if (direction2 == "asc") {
				$(this).append($(this).data("title") + " ▲▽");
				orderValue2 += "&sort=" + param2 + ",desc";
			} else if (direction2 == "desc") {
				$(this).append($(this).data("title") + " △▼");
			}

			$(this).attr("href", "/admin/memberList?page=" + $("#headerPageParam").val() + orderValue2);
		});

		// 페이지네이션 링크에 정렬 파라미터(orderValue1) 추가
		$(".page-item:not(.active) a").each(function(index, item) {
			$(this).attr("href", $(this).attr("href") + orderValue1);
		});
	});
</script>

<div class="container">
	<!-- Content-Header (회원 관리) -->
	<div class="row">
		<div class="col">
			<h4>| 회원 관리</h4>
		</div>
		<div class="col text-end align-self-end">
			<span>가입 ${todayCount}명</span>
			<span>| 총 ${list.totalElements}명</span>
		</div>
	</div>
	<hr>

	<!-- 문의 -->
	<div>
		<input type="hidden" id="headerSortParam" value="${list.sort}">
		<input type="hidden" id="headerPageParam" value="${list.number}">
		<table class="table table-striped table-hover">
			<tr>
				<th style="width: 10%;">no</th>
				<th style="width: 20%;">
					<a href="#" class="member-order memId" data-param="memId" data-title="아이디" data-direction=""></a>
				</th>
				<th style="width: 10%;">
					<a href="#" class="member-order memName" data-param="memName" data-title="이름" data-direction=""></a>
				</th>
				<th style="width: 15%;">
					<a href="#" class="member-order memJoinDate" data-param="memJoinDate" data-title="가입일" data-direction=""></a>
				</th>
				<th style="width: 10%;">횟수</th>
				<th style="width: 10%;">더보기</th>
			</tr>
			<c:forEach items="${list.content}" var="memberDto" varStatus="status">
				<tr>
					<td>${list.totalElements - status.index - (list.size * list.number)}</td>
					<td>${memberDto.memId}</td>
					<td>${memberDto.memName}</td>
					<td>${memberDto.memJoinDate}</td>
					<td>${memberDto.projectOrderCount}</td>
					<td>
						<a href="#" class="open-member-detail" data-mem-no="${memberDto.memNo}">
							<strong><i>MORE</i></strong>
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<br>

	<!-- Pagination -->
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${!list.first}">
				<li class="page-item">
					<a href="?" class="page-link">&laquo;</a>
				</li>
				<li class="page-item">
					<a href="?page=${list.number - 1}" class="page-link">&lt;</a>
				</li>
			</c:if>
			<c:set var="pageRange" scope="session" value="5" />
			<fmt:parseNumber var="pageIndex" integerOnly="true" value="${list.number div pageRange}" />
			<c:choose>
				<c:when test="${pageIndex * pageRange + pageRange > list.totalPages - 1}">
					<c:set var="lastPage" scope="session" value="${list.totalPages}" />
				</c:when>
				<c:otherwise>
					<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
				<c:choose>
					<c:when test="${list.number + 1 == i}">
						<li class="page-item active">
							<a href="#" class="page-link">
								<c:out value="${i}" />
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="?page=${i - 1}" class="page-link">
								<c:out value="${i}" />
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${!list.last}">
				<li class="page-item">
					<a href="?page=${list.number + 1}" class="page-link">&gt;</a>
				</li>
				<li class="page-item">
					<a href="?page=${list.totalPages - 1}" class="page-link">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
<div class="layer-background"></div>
<div class="member-detail"></div>