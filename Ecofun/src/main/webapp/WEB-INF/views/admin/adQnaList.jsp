<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
	<!-- Content-Header -->
	<div class="row">
		<h4>| 문의 및 신청 관리</h4>
	</div>
	<hr>

	<div class="row">
		<!-- 탭 (문의|신청) -->
		<div class="col">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#ask">문의</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#apply">신청</a>
				</li>
			</ul>
		</div>
		<div class="col text-end">
			<span>문의: ${askCount}건</span>
			<span>| 신청: ${aplCount}건</span>
		</div>
	</div>
	<br>

	<div class="tab-content">
		<!-- 문의 -->
		<div class="tab-pane fade show active" id="ask">
			<div>
				<table class="table table-striped text-center">
					<tr class="thead-dark">
						<th style="width: 10%;">번호</th>
						<th style="width: 50%;">제목</th>
						<th style="width: 15%;">작성일</th>
						<th style="width: 10%;">답변</th>
					</tr>
					<c:forEach var="ask" items="${askList.content}">
						<fmt:parseDate value="${ask.askDate}" var="dateValue" pattern="yyyy-MM-dd'T'HH:mm" />
						<tr>
							<td>${ask.askNo}</td>
							<td>
								<a href="myAskDetail?askNo=${ask.askNo}">${ask.askTitle}</a>
							</td>
							<td>
								<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd" />
							</td>
							<td>${ask.askState}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br>

			<!-- Pagination -->
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${!askList.first}">
						<li class="page-item">
							<a href="?sort=askNo,desc$page=" class="page-link">&laquo;</a>
						</li>
						<li class="page-item">
							<a href="?sort=askNo,desc&page=${askList.number - 1}" class="page-link">&lt;</a>
						</li>
					</c:if>
					<c:set var="pageRange" scope="session" value="10" />
					<fmt:parseNumber var="pageIndex" integerOnly="true" value="${askList.number div pageRange}" />
					<c:choose>
						<c:when test="${pageIndex * pageRange + pageRange > askList.totalPages - 1}">
							<c:set var="lastPage" scope="session" value="${askList.totalPages}" />
						</c:when>
						<c:otherwise>
							<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
						<c:choose>
							<c:when test="${askList.number + 1 == i}">
								<li class="page-item active">
									<a href="#" class="page-link"> <c:out value="${i}" />
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a href="?sort=askNo,desc&page=${i}" class="page-link"> <c:out value="${i}" />
									</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${!askList.last}">
						<li class="page-item">
							<a href="?sort=askNo,desc&page=${askList.number + 1}" class="page-link">&gt;</a>
						</li>
						<li class="page-item">
							<a href="?sort=askNo,desc&page=${askList.totalPages - 1}" class="page-link">&raquo;</a>
						</li>
					</c:if>
				</ul>

			</div>
		</div>

		<!-- 신청 -->
		<div class="tab-pane fade show" id="apply">
			<div>
				<table class="table">
					<tr class="thead-dark">
						<th style="width: 10%;">번호</th>
						<th style="width: 50%;">제목</th>
						<th style="width: 15%;">작성일</th>
						<th style="width: 10%;">답변</th>
					</tr>
					<c:forEach var="apl" items="${aplList.content}">
						<fmt:parseDate value="${apl.aplDate}" var="dateValue2" pattern="yyyy-MM-dd'T'HH:mm" />
						<tr>
							<td>${apl.aplNo}</td>
							<td>
								<a href="/mypage/applyDetail?aplNo=${apl.aplNo}">${apl.aplTitle}</a>
							</td>
							<td>
								<fmt:formatDate value="${dateValue2}" pattern="yyyy-MM-dd" />
							</td>
							<td>검토중</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br>

			<!-- Pagination -->
			<div>
				<ul class="pagination justify-center">
					<c:if test="${!aplList.first}">
						<li class="page-item">
							<a href="?sort=aplNo,desc" class="page-link">&laquo;</a>
						</li>
						<li class="page-item">
							<a href="?sort=aplNo,desc&page=${aplList.number - 1}" class="page-link">&lt;</a>
						</li>
					</c:if>
					<c:set var="pageRange2" scope="session" value="10" />
					<fmt:parseNumber var="pageIndex2" integerOnly="true" value="${aplList.number div pageRange2}" />
					<c:choose>
						<c:when test="${pageIndex2 * pageRange2 + pageRange2 > aplList.totalPages - 1}">
							<c:set var="lastPage2" scope="session" value="${aplList.totalPages}" />
						</c:when>
						<c:otherwise>
							<c:set var="lastPage2" scope="session" value="${pageIndex2 * pageRange2 + pageRange2}" />
						</c:otherwise>
					</c:choose>
					<c:forEach var="k" begin="${pageIndex2 * pageRange2 + 1}" end="${lastPage2}">
						<c:choose>
							<c:when test="${aplList.number + 1 == k}">
								<li class="page-item active">
									<a href="#" class="page-link"> <c:out value="${k}" />
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a href="?sort=aplNo,desc&page=${k - 1}" class="page-link"> <c:out value="${k}" />
									</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${!aplList.last}">
						<li class="page-item">
							<a href="?sort=aplNo,desc&page=${aplList.number + 1}" class="page-link">&gt;</a>
						</li>
						<li class="page-item">
							<a href="?sort=aplNo,desc&page=${aplList.totalPages - 1}" class="page-link">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>