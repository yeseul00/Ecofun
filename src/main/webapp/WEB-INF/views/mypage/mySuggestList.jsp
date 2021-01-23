<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
	<!-- Content-Header -->
	<div class="row">
		<div>
			<h6>| 문의 및 신청</h6>
		</div>
		<div class="ml-auto" style="align-self: flex-end;">
			<span>문의: ${askCount}건</span> <span>| 신청: ${reqCount}건</span>
		</div>
	</div>
	<hr>

	<div class="col">
		<!-- 탭 (문의|신청) -->
		<div>
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					data-toggle="tab" href="#ask">문의</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#request">신청</a></li>
			</ul>
		</div>
		<br>

		<div class="tab-content">
			<!-- 문의 -->
			<div class="tab-pane fade show active" id="ask">
				<div>
					<table class="table table-striped"
						style="width: 100%; text-align: center; padding: 0;">
						<tr class="thead-dark">
							<th style="width: 10%;">번호</th>
							<th style="width: 50%;">제목</th>
							<th style="width: 15%;">작성일</th>
							<th style="width: 10%;">답변</th>
						</tr>
						<c:forEach var="ask" items="${askList.content}">
							<fmt:parseDate value="${ask.askDate}" var="dateValue"
								pattern="yyyy-MM-dd'T'HH:mm" />
							<tr>
								<td>${ask.askNo}</td>
								<td><a href="myAskDetail?askNo=${ask.askNo}">${ask.askTitle}</a></td>
								<td><fmt:formatDate value="${dateValue}"
										pattern="yyyy-MM-dd" /></td>
								<td>${ask.askState}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<br>

				<!-- Pagination -->
				<div style="position: relative;">
					<ul class="pagination justify-center"
						style="justify-content: center;">
						<c:if test="${!askList.first}">
							<li class="page-item"><a href="?sort=askNo,desc$page="
								class="page-link">&laquo;</a></li>
							<li class="page-item"><a
								href="?sort=askNo,desc&page=${askList.number - 1}"
								class="page-link">&lt;</a></li>
						</c:if>
						<c:set var="pageRange" scope="session" value="5" />
						<fmt:parseNumber var="pageIndex" integerOnly="true"
							value="${askList.number div pageRange}" />
						<c:choose>
							<c:when
								test="${pageIndex * pageRange + pageRange > askList.totalPages - 1}">
								<c:set var="lastPage" scope="session"
									value="${askList.totalPages}" />
							</c:when>
							<c:otherwise>
								<c:set var="lastPage" scope="session"
									value="${pageIndex * pageRange + pageRange}" />
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="${pageIndex * pageRange + 1}"
							end="${lastPage}">
							<c:choose>
								<c:when test="${askList.number + 1 == i}">
									<li class="page-item active"><a href="#" class="page-link"><c:out
												value="${i}" /></a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a href="?sort=askNo,desc&page=${i}"
										class="page-link"><c:out value="${i}" /></a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${!askList.last}">
							<li class="page-item"><a
								href="?sort=askNo,desc&page=${askList.number + 1}"
								class="page-link">&gt;</a></li>
							<li class="page-item"><a
								href="?sort=askNo,desc&page=${askList.totalPages - 1}"
								class="page-link">&raquo;</a></li>
						</c:if>
					</ul>

				</div>
			</div>


			<!-- 신청 -->
			<div class="tab-pane fade show" id="request">
				<div>
					<table class="table"
						style="width: 100%; text-align: center; padding: 0;">
						<tr class="thead-dark">
							<th style="width: 10%;">번호</th>
							<th style="width: 50%;">제목</th>
							<th style="width: 15%;">작성일</th>
							<th style="width: 10%;">답변</th>
						</tr>
						<c:forEach var="req" items="${reqList.content}">
							<fmt:parseDate value="${req.reqDate}" var="dateValue2"
								pattern="yyyy-MM-dd'T'HH:mm" />
							<tr>
								<td>${req.reqNo}</td>
								<td><a href="myReqDetail?reqNo=${req.reqNo}">${req.reqTitle}</a></td>
								<td><fmt:formatDate value="${dateValue2}"
										pattern="yyyy-MM-dd" /></td>
								<%-- <c:forEach var="reqState" items="${reqStateList}"> --%>
								<td>검토중</td>
								<!-- <td>${reqState.reqsState}</td> -->
								<%-- </c:forEach> --%>
							</tr>
						</c:forEach>
					</table>
				</div>
				<br>


				<!-- Pagination -->
				<div>
					<ul class="pagination justify-center"
						style="position: relative; justify-content: center;">
						<c:if test="${!reqList.first}">
							<li class="page-item"><a href="?sort=reqNo,desc"
								class="page-link">&laquo;</a></li>
							<li class="page-item"><a
								href="?sort=reqNo,desc&page=${reqList.number - 1}"
								class="page-link">&lt;</a></li>
						</c:if>
						<c:set var="pageRange2" scope="session" value="5" />
						<fmt:parseNumber var="pageIndex2" integerOnly="true"
							value="${reqList.number div pageRange2}" />
						<c:choose>
							<c:when
								test="${pageIndex2 * pageRange2 + pageRange2 > reqList.totalPages - 1}">
								<c:set var="lastPage2" scope="session"
									value="${reqList.totalPages}" />
							</c:when>
							<c:otherwise>
								<c:set var="lastPage2" scope="session"
									value="${pageIndex2 * pageRange2 + pageRange2}" />
							</c:otherwise>
						</c:choose>
						<c:forEach var="k" begin="${pageIndex2 * pageRange2 + 1}"
							end="${lastPage2}">
							<c:choose>
								<c:when test="${reqList.number + 1 == k}">
									<li class="page-item active"><a href="#" class="page-link"><c:out
												value="${k}" /></a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a
										href="?sort=reqNo,desc&page=${k - 1}" class="page-link"><c:out
												value="${k}" /></a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${!reqList.last}">
							<li class="page-item"><a
								href="?sort=reqNo,desc&page=${reqList.number + 1}"
								class="page-link">&gt;</a></li>
							<li class="page-item"><a
								href="?sort=reqNo,desc&page=${reqList.totalPages - 1}"
								class="page-link">&raquo;</a></li>
						</c:if>
					</ul>


				</div>
			</div>
		</div>
	</div>
</div>