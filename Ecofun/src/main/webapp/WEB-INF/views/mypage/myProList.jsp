<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
	var nowDate = new Date();
	var proType = '<c:out value="${proType}" />';
	var startDate = '<c:out value="${startDate}" />';
	var endDate = '<c:out value="${endDate}" />';
	var appendBefore = "";
	var appendAfter = "";

	/* function formCheck(thisForm) {
		var type = $("input[name='projectType']:checked").val();
		alert(type);
		if (type == "기부" || type == "펀딩") {
			$(thisForm).attr("action", $(thisForm).attr("action") + "/" + type);
		}
		return true;
	} */

	$(function() {
		if (proType != "") {
			$("input[name='projectType']:radio[value='" + proType + "']").prop("checked", true);
			appendBefore += "/mypage/projectList/" + proType;
		} else {
			$("input[name='projectType']:radio[value='']").prop("checked", true);
		}
		if (startDate != "") {
			$("#startDate").val(startDate);
			appendAfter += "&startDate=" + startDate;
		}
		if (endDate != "") {
			$("#endDate").val(endDate);
			appendAfter += "&endDate=" + endDate;
		}

		$(".page-item:not(.active) a").each(function(index, item) {
			$(this).attr("href", appendBefore + $(this).attr("href") + appendAfter);
		});

		$(".date-button").click(function() {
			var month = nowDate.getMonth() + 1 - $(this).data("range");
			month = month < 10 ? "0" + month : month; // 1~9 → 01~09 
			$("#startDate").val(nowDate.getFullYear() + "-" + month + "-" + nowDate.getDate());
			$("#endDate").val(nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate());
			$(this.form).submit();
		});
	})
</script>

<div class="container">
	<div class="row">
		<h4>| 참여한 프로젝트</h4>
	</div>
	<hr>
	<br>

	<div class="col-10 text-center content-center">
		<table class="table-bordered">
			<tr>
				<th class="col-6">
					<h5>총 참여 금액</h5>
					<fmt:formatNumber value="${sum}" pattern="#,##0" />
					원
				</th>
				<th class="col-6">
					<h5>총 참여 횟수</h5>
					<c:out value="${orderList.totalElements}" />
					회
				</th>
			</tr>

			<!-- 옵션선택 -->
			<tr>
				<td colspan="2">
					<form action="/mypage/projectList" method="get" onsubmit="return formCheck(this)">
						<input type="radio" name="projectType" id="" value="">
						<label for="all">전체</label>
						<input type="radio" name="projectType" id="don" value="기부">
						<label for="don">기부</label>
						<input type="radio" name="projectType" id="fun" value="펀딩">
						<label for="fun">펀딩 </label>
						<br>
						<input type="date" name="startDate" id="startDate">
						~
						<input type="date" name="endDate" id="endDate">
						<input type="submit" value="조회">
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" class="date-button" data-range="1" value="1개월">
					<input type="button" class="date-button" data-range="3" value="3개월">
					<input type="button" class="date-button" data-range="6" value="6개월">
				</td>
			</tr>
		</table>
	</div>
	<br>

	<!-- 테이블 영역 -->
	<div>
		<c:forEach items="${orderList.content}" var="ordersDto" varStatus="order">
			<div class="row col-12 content-center">
				<!-- 월 표시 -->
				<div class="col-2 col-lg-1">${ordersDto.orderDate}</div>
				<div class="col-10 col-lg-11 d-flex">
					<img src="${projectList[order.index].proThumb}" alt="이미지" class="content-center" style="width: 100px; height: 60px;">
					<div class="col-lg-9 d-flex content-center">
						<div class="col-9">
							<div>${projectList[order.index].proTitle}</div>
							<div>${ordersDto.projectMemberName}</div>
						</div>
						<div class="col-3">
							<div>결제금액</div>
							<div>
								<fmt:formatNumber value="${ordersDto.totalPrice}" pattern="#,##0" />
								원
							</div>
						</div>
					</div>
				</div>

				<!-- 상세(드롭다운) -->
				<div class="col-12" style="border-bottom: lightgray solid 1px;">
					<details class="text-center">
						<summary>상세</summary>
						<div class="col-10 content-center d-flex">
							<div class="col-6">
								<div>참여일시</div>
								<div>프로젝트 마감일</div>
								<div>결제상태</div>
								<div>결제일</div>
							</div>
							<div class="col-6">
								<div>${ordersDto.orderDate}</div>
								<div>${projectDto[order.index].proEnd}</div>
								<div>${orderDto.orderState}</div>
								<div>${orderDto.orderDate}</div>
							</div>
						</div>
					</details>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- Pagination -->
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${!orderList.first}">
				<li class="page-item">
					<a href="?" class="page-link">&laquo;</a>
				</li>
				<li class="page-item">
					<a href="?page=${orderList.number - 1}" class="page-link">&lt;</a>
				</li>
			</c:if>
			<c:set var="pageRange" scope="session" value="5" />
			<fmt:parseNumber var="pageIndex" integerOnly="true" value="${orderList.number div pageRange}" />
			<c:choose>
				<c:when test="${pageIndex * pageRange + pageRange > orderList.totalPages - 1}">
					<c:set var="lastPage" scope="session" value="${orderList.totalPages}" />
				</c:when>
				<c:otherwise>
					<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
				<c:choose>
					<c:when test="${orderList.number + 1 == i}">
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
			<c:if test="${!orderList.last}">
				<li class="page-item">
					<a href="?page=${orderList.number + 1}" class="page-link">&gt;</a>
				</li>
				<li class="page-item">
					<a href="?page=${orderList.totalPages - 1}" class="page-link">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
