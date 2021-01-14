<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
	var proState = '<%= request.getParameter("proState") == null ? "" : request.getParameter("proState")  %>';
	var proType = '<%= request.getParameter("proType") == null ? "" : request.getParameter("proType") %>';
	var strAppend = '';
	
	if (proState != '') {
		strAppend += '&proState=' + proState;
	}
	
	if (proType != '') {
		strAppend += '&proType=' + proType;
	}

	$(function() {
		// 페이징 처리 부분에 파라미터 추가
		$(".page-item:not(.active) a").each(function(index, item) {
			$(this).attr("href", $(this).attr("href") + strAppend);
		});
		
		$(".dropdown-item").removeClass("active");
		
		$(".pro-state .dropdown-item").each(function() {
			if (proState != '') {
				if ($(this).html() == proState) {
					$(".dropdown-toggle.pro-state").html("상태(" + proState + ")");
					$(this).addClass("active");
				}
			} else {
				if ($(this).html() == "전체") {
					$(this).addClass("active");
				}
			}
		});
		
		$(".pro-type .dropdown-item").each(function() {
			if (proType != '') {
				if ($(this).html() == proType) {
					$(".dropdown-toggle.pro-type").html("분류(" + proType + ")");
					$(this).addClass("active");
				}
			} else {
				if ($(this).html() == "전체") {
					$(this).addClass("active");
				}
			}
		});
		
		$(".pro-state .dropdown-item").click(function() {
			var activeStr = $(".pro-type a.active").html();
			var thisActiveStr = $(this).html();
			var getParam = "";
			if (activeStr != "전체") {
				getParam += "&proType=" + activeStr;
			}
			if (thisActiveStr != "전체") {
				getParam += "&proState=" + thisActiveStr;
			}
			$(location).attr("href", "/myProLikeList?" + getParam);
		});
		
		$(".pro-type .dropdown-item").click(function() {
			var activeStr = $(".pro-state a.active").html();
			var thisActiveStr = $(this).html();
			var getParam = "";
			if (activeStr != "전체") {
				getParam += "&proState=" + activeStr;
			}
			if (thisActiveStr != "전체") {
				getParam += "&proType=" + thisActiveStr;
			}
			$(location).attr("href", "/myProLikeList?" + getParam);
		});
		
		$(".deleteLike").click(function() {
			deleteLike($(this).data("pro-no"));
		});
	});
	
	function deleteLike(proNo) {
		$.ajax({
			url: "/deleteLike",
			type: "POST",
			dataType: "text",
			data: {
				proNo: proNo
			},
			success: function(data) {
				if (data > 0) {
					alert("좋아한 프로젝트 목록에서 삭제되었습니다.");
					$(location).attr("href", $(location).attr("href"));
				}
			},
			error: function() {
				alert("에러 발생");
			}
		});
	}
</script>
<div class="container" style="margin-top:5%;">
	<!-- Content-Header (좋아한 프로젝트) -->
	<div class="row">
		<div>
			<h6>| 좋아한 프로젝트</h6>
		</div>
		<div class="ml-auto" style="align-self: flex-end;">
			<span>총 ${countList}건</span>
		</div>
	</div>
	<hr>

	<div class="d-flex">
		<!-- Filter -->
		<div>
			<div class="btn-group">
				<button class="btn dropdown-toggle pro-state" type="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">상태(전체)</button>
				<div class="dropdown-menu pro-state" style="min-width: auto;">
					<a class="dropdown-item active" href="#">전체</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">진행</a>
					<a class="dropdown-item" href="#">종료</a>
					<a class="dropdown-item" href="#">예정</a>
				</div>
			</div>
			<div class="btn-group">
				<button class="btn dropdown-toggle pro-type" type="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">분류(전체)</button>
				<div class="dropdown-menu pro-type" style="min-width: auto;">
					<a class="dropdown-item active" href="#">전체</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">기부</a>
					<a class="dropdown-item" href="#">펀딩</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Content -->
	<ul class="form-inline">
		<c:forEach items="${list.content}" var="pList">
			<li class="col-sm-6 col-lg-4 project-item">
				<a href="/projectDetail?proNo=${pList.projectDto.proNo}">
					<c:set var="urlSize" value="${fn:length(pList.projectDto.imgDto.imgUrl)}"/>
					<c:set var="urlSub" value="${fn:substring(pList.projectDto.imgDto.imgUrl, 1, urlSize)}" />
					<c:set var="roundBefore" value="${pList.projectDto.proNow / pList.projectDto.proTarget * 100}" />
					<c:set var="roundAfter" value="${roundBefore+((roundBefore%1>0.5)?(1-(roundBefore%1))%1:-(roundBefore%1))}" />
					<img src="${urlSub}" alt="썸네일" style="width: 100%;">
					<c:choose>
						<c:when test="${roundAfter >= 100}">
							<c:set var="roundAfter2" scope="session" value="100" />
						</c:when>
						<c:otherwise>
							<c:set var="roundAfter2" scope="session" value="${roundAfter}" />
						</c:otherwise>
					</c:choose>
					<div class="progress-bar" role="progressbar" style="width: ${roundAfter2}%;" aria-valuenow="${roundAfter2}" aria-valuemin="0" aria-valuemax="100">${roundAfter2}%</div>
					${pList.projectDto.proInfo}<br>
					${pList.projectDto.proStart} ~ ${pList.projectDto.proEnd}<br>
				</a>
				<input type="button" class="deleteLike" data-pro-no="${pList.projectDto.proNo}" value="해제하기">
			</li>
		</c:forEach>
	</ul>
	<br>

	<!-- Pagination -->
	<!--<div class="pagination" style="justify-content: center;">
		<span class="page-item"><a href="#" class="page-link">&laquo;</a></span>
		<span class="page-item"><a href="#" class="page-link">&lt;</a></span>
		<span class="page-item"><a href="#" class="page-link">1</a></span>
		<span class="page-item"><a href="#" class="page-link">2</a></span>
		<span class="page-item"><a href="#" class="page-link">3</a></span>
		<span class="page-item"><a href="#" class="page-link">4</a></span>
		<span class="page-item"><a href="#" class="page-link">5</a></span>
		<span class="page-item"><a href="#" class="page-link">&gt;</a></span>
		<span class="page-item"><a href="#" class="page-link">&raquo;</a></span>
	</div>-->
	<div style="text-align: center;">
		<ul class="pagination justify-center" style="justify-content: center;">
			<c:if test="${!list.first}">
				<li class="page-item"><a href="?" class="page-link">&laquo;</a></li>
				<li class="page-item"><a href="?page=${list.number - 1}" class="page-link">&lt;</a></li>
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
						<li class="page-item active"><a href="#" class="page-link"><c:out value="${i}"/></a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a href="?page=${i - 1}" class="page-link"><c:out value="${i}"/></a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${!list.last}">
				<li class="page-item"><a href="?page=${list.number + 1}" class="page-link">&gt;</a></li>
				<li class="page-item"><a href="?page=${list.totalPages - 1}" class="page-link">&raquo;</a></li>
			</c:if>
		</ul>
	</div>
</div>
