<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	var proState ='<%=request.getParameter("proState") == null ? "" : request.getParameter("proState")%>';
	var proType ='<%=request.getParameter("proType") == null ? "" : request.getParameter("proType")%>
	';
	var strAppend = '';

	if (proState != '') {
		strAppend += '&proState=' + proState;
	}
	if (proType != '') {
		strAppend += '&proType=' + proType;
	}

	$(function() {
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
			var proType = $(".pro-type a.active").html();
			var proState = $(this).html();
			var getParam = "";
			if (proType != "전체") {
				getParam += "&proType=" + proType;
			}
			if (proState != "전체") {
				getParam += "&proState=" + proState;
			}
			$(location).attr("href", "/mypage/projectLikeList?" + getParam);
		});

		$(".pro-type .dropdown-item").click(function() {
			var proState = $(".pro-state a.active").html();
			var proType = $(this).html();
			var getParam = "";
			if (proState != "전체") {
				getParam += "&proState=" + proState;
			}
			if (proType != "전체") {
				getParam += "&proType=" + proType;
			}
			$(location).attr("href", "/mypage/projectLikeList?" + getParam);
		});

		$(".deleteLike").click(function() {
			deleteLike($(this).data("pro-no"));
		});
	});

	function deleteLike(proNo) {
		$.ajax({
			url : "/project/detail/unlike",
			type : "POST",
			dataType : "text",
			data : {
				proNo : proNo
			},
			success : function(data) {
				if (data > 0) {
					alert("좋아한 프로젝트 목록에서 삭제되었습니다.");
					$(location).attr("href", $(location).attr("href"));
				}
			},
			error : function() {
				alert("에러 발생");
			}
		});
	}
</script>
<div class="container">
	<!-- Content-Header (좋아한 프로젝트) -->
	<div class="row">
		<h4>| 좋아한 프로젝트</h4>
	</div>
	<hr>

	<div class="d-flex">
		<!-- Filter -->
		<div class="col">
			<div class="btn-group">
				<button class="btn btn-light dropdown-toggle pro-state" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">상태(전체)</button>
				<div class="dropdown-menu pro-state" style="min-width: auto;">
					<a class="dropdown-item active" href="#">전체</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">진행</a>
					<a class="dropdown-item" href="#">종료</a>
					<a class="dropdown-item" href="#">예정</a>
				</div>
			</div>
			<div class="btn-group">
				<button class="btn btn-light dropdown-toggle pro-type" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">분류(전체)</button>
				<div class="dropdown-menu pro-type" style="min-width: auto;">
					<a class="dropdown-item active" href="#">전체</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">기부</a>
					<a class="dropdown-item" href="#">펀딩</a>
				</div>
			</div>
		</div>
		<div class="col text-end">
			<span>총 ${likeListCount}건</span>
		</div>
	</div>
	<br>

	<!-- Content -->
	<ul class="row">
		<c:forEach items="${likeList.content}" var="likeDto" varStatus="like">
			<li class="col-sm-6 col-lg-4 project-item">
				<a href="/project/detail?proNo=${likeDto.proNo}">
					<img src="${likeDto.projectDto.proThumb}" alt="이미지" style="width: 100%;">
					<div class="progress-bar" role="progressbar" style="width: ${likeDto.projectDto.proceed}%;" aria-valuenow="${likeDto.projectDto.proceed}" aria-valuemin="0"
						aria-valuemax="100"
					>${likeDto.projectDto.proceed}%</div>
					<span class="project-item-title">${likeDto.projectDto.proTitle}</span>
					<br>
					${likeDto.projectDto.proStart} ~ ${likeDto.projectDto.proEnd}
					<br>
				</a>
				<input type="button" class="deleteLike" data-pro-no="${likeDto.proNo}" value="해제하기">
			</li>
		</c:forEach>
	</ul>
	<br>

	<div class="text-center">
		<ul class="pagination">
			<c:if test="${!likeList.first}">
				<li class="page-item">
					<a href="?" class="page-link">&laquo;</a>
				</li>
				<li class="page-item">
					<a href="?page=${likeList.number - 1}" class="page-link">&lt;</a>
				</li>
			</c:if>
			<c:set var="pageRange" scope="session" value="5" />
			<fmt:parseNumber var="pageIndex" integerOnly="true" value="${likeList.number div pageRange}" />
			<c:choose>
				<c:when test="${pageIndex * pageRange + pageRange > likeList.totalPages - 1}">
					<c:set var="lastPage" scope="session" value="${likeList.totalPages}" />
				</c:when>
				<c:otherwise>
					<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
				<c:choose>
					<c:when test="${likeList.number + 1 == i}">
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
			<c:if test="${!likeList.last}">
				<li class="page-item">
					<a href="?page=${likeList.number + 1}" class="page-link">&gt;</a>
				</li>
				<li class="page-item">
					<a href="?page=${likeList.totalPages - 1}" class="page-link">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
