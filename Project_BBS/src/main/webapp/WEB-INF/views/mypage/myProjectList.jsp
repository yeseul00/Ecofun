<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	.form-control{
		width:200px;
		display:inline;
	}
</style>
<script>
	var nowDate = new Date();
	var nowFullDate = nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate(); // getMonth() = 0 -> 1월
	var proType = '<c:out value="${proType}" />';
	var startDate = '<c:out value="${startDate}" />';
	var endDate = '<c:out value="${endDate}" />';
	var appendBefore = "";
	var appendAfter = "";
	
	function formCheck(thisForm) {
		
		var type = $("input[name='projectType']:checked").val();
		if (type == "기부" || type == "펀딩") {
			$(thisForm).attr("action", $(thisForm).attr("action") + "/" + type);
		}
		
		return true;
	}
	
	$(function() {
		if (proType != "") {
			$("input[name='projectType']:radio[value='" + proType + "']").prop("checked", true);
			appendBefore += "/myProList/" + proType;
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
		
		// 페이징 처리 부분
		$(".page-item:not(.active) a").each(function(index, item) {
			$(this).attr("href", appendBefore + $(this).attr("href") + appendAfter);
		});

		$(".date-button").click(function() {
			if ($(this).data("range") == 0) {
				$("#startDate").val(nowFullDate);
				$("#endDate").val(nowFullDate);
			} else {
				var month = nowDate.getMonth() + 1 - $(this).data("range");
				month = month < 10 ? "0" + month : month;
				$("#startDate").val(nowDate.getFullYear() + "-" + month + "-" + nowDate.getDate());
				$("#endDate").val(nowFullDate);
			}
			$(this.form).submit();
		});
	})
</script>

<div class="container" style="margin-top:5%;">
	<div class="row">
		<h6>| 참여한 프로젝트</h6>
		<hr>
	</div>
	<br>
	
 
<!-- 총 참여 횟수 -->
<div class="row" style="margin: 5% 0;  border: black solid 1px;">

	<div class="col-lg-10 col-sm-10" style="margin: 0 auto; display: flex; text-align: center; padding: 3%; border-bottom: lightgray solid 1px;">
		<div class="col-lg-6 col-sm-6" style="padding:0; border-right: black solid 1px;" >
			<label style="display: block;">총 참여금액</label>
			<label><fmt:formatNumber value="${total}" pattern="#,###" /> 원</label>
		</div>
		<div class="col-lg-6 col-sm-6" style="padding:0" >
			<label style="display: block;">참여한 횟수</label>
			<label><c:out value="${list.totalElements}" />회</label>
		</div>
		
	</div>
	<!-- 옵션선택 -->
	<div class="col-lg-10 col-sm-10" style="margin: 0 auto; text-align: center; padding-top: 3%; padding-bottom: 3%;">
		<label><input type="radio" name="projectType" value=""> 전체</label>
		<label><input type="radio" name="projectType" value="기부"> 기부</label>
		<label><input type="radio" name="projectType" value="펀딩"> 펀딩</label>
	</div>

	<!-- 날짜조회 -->
	<div class="col-lg-10 col-sm-10" style="margin: 0 auto; margin-bottom: 5%; text-align: center;">
		<form action="/myProList" method="get" onsubmit="return formCheck(this)">
			<input type="date" name="startDate" id="startDate" class="form-control"> ~ <input type="date" name="endDate" id="endDate" class="form-control"> 
			<input type="submit" value="조회" style="margin-bottom: 17px; margin-top: 17px;">
			<br>
			<input type="button" class="date-button" data-range="0" value="당일">
			<input type="button" class="date-button" data-range="3" value="3개월">
			<input type="button" class="date-button" data-range="6" value="6개월">
		</form>
	</div>
	
</div>

<!-- 테이블 영역 -->
	<!-- for문 돌려서 -->
<c:forEach items="${list.content}" var="orderDto" varStatus="status">
	<fmt:parseDate value="${orderDto.orderDate}" var="dateValue" pattern="yyyy-MM-dd'T'HH:mm" />
	<div class="row" style="padding: 10px; ">
	
		<!-- 월 표시 -->
		<label class="col-lg-12 col-sm-12 line" style="font-size: 14px">
		<fmt:formatDate value="${dateValue}" pattern="yyyy-MM" /></label>
		<div class="col-lg-12 col-sm-12"style="display: flex;">
	  		<img src="${projectDto[status.index].proThumb}" alt="썸네일" style=" width:80px; height: 80px; margin: auto 0 auto auto;">
			<div class="col-lg-9 col-sm-10" style="margin: 10px auto; display: flex;">
				<div class="col-lg-9" style="text-align: left;">
					<div class="list"><fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm" /></div>
					<div class="list">${projectDto[status.index].proInfo}</div>
					<div class="list">${orderDto.projectMemberName}</div>
				</div>
				<div class="col-lg-3" style="text-align: center; margin: auto;">
					<div class="list"> 결제금액 </div>
					<div class="list"><fmt:formatNumber value="${orderDto.totalPrice}" pattern="#,###" /> 원</div>
				</div>
			</div>
		</div>
		
		 <!-- 상세(드롭다운) -->
		<div class="col-lg-12 col-sm-12" style="border-bottom: lightgray solid 1px;">
			<details style="text-align: center;">
				<summary style="margin-bottom: 15px;">상세</summary>
				<div class="col-lg-7 col-sm-6" style="margin: 0 auto; text-align: left;">
					<div class="col-lg-10 col-sm-10" style="margin: 0 auto; display: flex; text-align: left; padding: 3%;">
						<div class="col-lg-6 col-sm-6" style="padding:0" >
							<div class="list detail">참여일시</div>
							<div class="list detail">프로젝트 마감일</div>
							<div class="list detail">결제상태</div>
							<div class="list detail">결제일</div>
						</div>
						<div class="col-lg-6 col-sm-6" style="padding:0" >
							<div class="list"><fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm" /></div>
							<div class="list">${projectDto[status.index].proEnd}</div>
							<div class="list">${projectDto[status.index].proState}</div>
							<div class="list"><fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm" /></div> 
						</div>
					</div> 
				</div>
			</details>
		</div>
		
	</div>
</c:forEach>
 <!-- <div class="btn-group"> 
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"> v 
				<span class="caret"></span> </button> 
				<ul class="dropdown-menu" role="menu"> 
					<li><a href="#">Action</a></li> 
					<li><a href="#">Another action</a></li> 
					<li><a href="#">Something else here</a></li> 
					<li class="divider"></li> 
					<li><a href="#">Separated link</a></li> 
				</ul> </div> -->  
		<!-- <div class="btn-group">
			<button class="dropdown" type="button" data-toggle="dropdown" 
			aria-expanded="false" style="margin: auto; width:20px; height:20px">v</button>
		
			<div class="dropdown-menu" role="menu" style="right:0; left:auto; width: 30%; height: 20%; padding: 5%;">
				<ul style="list-style:none; padding: 5px 0;">
					<label style="font-size: large;">프로젝트</label>
					<li> <div src="#"> 참여한 프로젝트 </div></li>
					<li> <div src="#"> 좋아한 프로젝트 </div></li>
					<li> <div src="#" style="color: red;"> 프로젝트 신청목록 </div></li>
				</ul>
			</div>
		</div> -->
	

 
 <!-- 하단 페이지번호 -->
	<!-- Pagination -->
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
