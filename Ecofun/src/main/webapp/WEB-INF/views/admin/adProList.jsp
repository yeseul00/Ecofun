<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	function filtering() {
		var state = $('#state').val();
		var type = $('#type').val();
		var sort = $('#sort').val();

		$.ajax({
			url : "admin/projectList?",
			data : {
				state : state,
				type : type,
				sort : sort
			},
			type : "GET",
			dataType : "HTML",
			success : function(data) {
				$("#projectContent").load(data);
				$("#state").val(state).prop("selected", true);
				$("#type").val(type).prop("selected", true);
				$("#sort").val(sort).prop("selected", true);
				return false;
			},
			error : function(data) {
				alert('죄송합니다. 잠시 후 다시 시도해주세요.');
			}
		})
	}
</script>

<div class="container" id="projectContent">
	<!-- Content-Header (프로젝트) -->
	<div class="row">
		<div class="col">
			<h4>| 프로젝트 관리</h4>
		</div>
		<div class="col text-end" style="align-self: flex-end;">
			<span>총 ${projectCount[0]}건</span>
			<span>| 예정 ${projectCount[1]}건</span>
			<span>| 진행 ${projectCount[4]}건</span>
		</div>
	</div>
	<hr>

	<div class="row">
		<!-- Filter -->
		<div class="col">
			<select class="btn btn-light" name="proState" id="state" onchange="filtering()">
				<option value="전체">상태(전체)</option>
				<option value="진행">진행</option>
				<option value="종료">종료</option>
				<option value="예정">예정</option>
			</select> <select class="btn btn-light" name="proType" id="type" onchange="filtering()">
				<option value="전체">분류(전체)</option>
				<option value="기부">기부</option>
				<option value="펀딩">펀딩</option>
			</select>
		</div>

		<!-- Sort -->
		<div class="col text-end">
			<select class="btn btn-light" id="sort" onchange="filtering()">
				<option value="proStart">최근등록순</option>
				<option value="proHit">조회순</option>
				<option value="proNow">모집액순</option>
			</select>
		</div>
	</div>
	<br>

	<!-- Content -->
	<div>
		<table class="table" style="width: 100%; table-layout: fixed;">
			<c:forEach var="project" items="${projectList.content}">
				<tr>
					<th rowspan="3" style="background-image: url(${project.proThumb}); background-size: 100% 100%;"></th>
					<th colspan="2">${project.proTitle}</th>
					<th style="text-align: right;">${project.proState}</th>
					<th style="text-align: right;">
						<button>수정</button>
					</th>
				</tr>
				<tr>
					<td>조회 : ${project.proHit} 명</td>
					<td>참여인원 :</td>
					<td colspan="2" style="text-align: center;">${project.proNow}원/${project.proTarget}원</td>
				</tr>
				<tr>
					<td colspan="2">${project.proStart}~${project.proEnd}</td>
					<td colspan="2">
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: ${project.proceed}%;" aria-valuenow="${project.proceed}" aria-valuemin="0"
								aria-valuemax="100"
							>${project.proceed}%</div>
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<br>

	<!-- Pagination -->
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${!projectList.first}">
				<li class="page-item">
					<a href="?sort=proNo,desc" class="page-link">&laquo;</a>
				</li>
				<li class="page-item">
					<a href="?sort=proNo,desc&page=${projectList.number - 1}" class="page-link">&lt;</a>
				</li>
			</c:if>
			<c:set var="pageRange" scope="session" value="5" />
			<f:parseNumber var="pageIndex" integerOnly="true" value="${projectList.number div pageRange}" />
			<c:choose>
				<c:when test="${pageIndex * pageRange + pageRange > projectList.totalPages - 1}">
					<c:set var="lastPage" scope="session" value="${projectList.totalPages}" />
				</c:when>
				<c:otherwise>
					<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
				<c:choose>
					<c:when test="${projectList.number + 1 == i}">
						<li class="page-item active">
							<a href="#" class="page-link">
								<c:out value="${i}" />
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="?sort=proNo,desc&page=${i - 1}" class="page-link">
								<c:out value="${i}" />
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${!projectList.last}">
				<li class="page-item">
					<a href="?sort=proNo,desc&page=${projectList.number + 1}" class="page-link">&gt;</a>
				</li>
				<li class="page-item">
					<a href="?sort=proNo,desc&page=${projectList.totalPages - 1}" class="page-link">&raquo;</a>
				</li>
			</c:if>
		</ul>
		<!-- 등록 -->
		<div style="text-align: right;">
			<a href="/admin/projectInsert">
				<button class="btn btn-dark" type="button">등록</button>
			</a>
		</div>
	</div>
</div>