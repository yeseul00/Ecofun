<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String memId = (String) session.getAttribute("memId");
%>

<div class="container">
	<!-- Content-Header (게시판) -->
	<div class="row">
		<h4>| 게시판</h4>
	</div>
	<hr>

	<div class="row">
		<!-- 탭 (공지사항|이벤트) -->
		<div class="col">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#notice">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#event">이벤트</a>
				</li>
			</ul>
		</div>
		<%
			if (memId != null && memId.equals("admin")) {
		%>
		<div class="col text-end">
			<a href="/admin/boardInsert">
				<button type="button">글작성</button>
			</a>
		</div>
		<%
			}
		%>
		<br>
	</div>

	<div class="tab-content">
		<!-- 공지사항 -->
		<div class="tab-pane fade show active" id="notice">
			<div>
				<table class="table-striped">
					<tr class="thead-dark">
						<th style="width: 10%;">No</th>
						<th style="width: 70%;">제목</th>
						<th style="width: 20%;">작성일</th>
					</tr>
					<c:forEach items="${noticeList.content}" var="nList">
						<tr>
							<td>${nList.bbsNo}</td>
							<td>
								<a type="hidden" href="detail?bbsNo=${nList.bbsNo}">${nList.bbsTitle}</a>
							</td>
							<td>${nList.bbsStart}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br>

			<!-- Pagination -->
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${!noticeList.first}">
						<li class="page-item">
							<a href="?sort=bbsNo,desc$page=" class="page-link">&laquo;</a>
						</li>
						<li class="page-item">
							<a href="?sort=bbsNo,desc&page=${noticeList.number - 1}" class="page-link">&lt;</a>
						</li>
					</c:if>
					<c:set var="pageRange" scope="session" value="10" />
					<fmt:parseNumber var="pageIndex" integerOnly="true" value="${noticeList.number div pageRange}" />
					<c:choose>
						<c:when test="${pageIndex * pageRange + pageRange > noticeList.totalPages - 1}">
							<c:set var="lastPage" scope="session" value="${noticeList.totalPages}" />
						</c:when>
						<c:otherwise>
							<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
						<c:choose>
							<c:when test="${noticeList.number + 1 == i}">
								<li class="page-item active">
									<a href="#" class="page-link"> <c:out value="${i}" />
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a href="?sort=bbsNo,desc&page=${i}" class="page-link"> <c:out value="${i}" />
									</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${!noticeList.last}">
						<li class="page-item">
							<a href="?sort=bbsNo,desc&page=${noticeList.number + 1}" class="page-link">&gt;</a>
						</li>
						<li class="page-item">
							<a href="?sort=bbsNo,desc&page=${noticeList.totalPages - 1}" class="page-link">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>

		<!-- 이벤트 -->
		<div class="tab-pane fade" id="event">
			<div>
				<table>
					<tr class="thead-dark">
						<th style="width: 10%;">No</th>
						<th style="width: 70%;">제목</th>
						<th style="width: 20%;">기간</th>
					</tr>
					<c:forEach items="${eventList.content}" var="eList">
						<tr>
							<td>${eList.bbsNo}</td>
							<td>
								<a type="hidden" href="detail?bbsNo=${eList.bbsNo}">${eList.bbsTitle}</a>
							</td>
							<td>${eList.bbsEnd}~ ${eList.bbsEnd}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br>

			<!-- Pagination -->
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${!eventList.first}">
						<li class="page-item">
							<a href="?sort=bbsNo,desc" class="page-link">&laquo;</a>
						</li>
						<li class="page-item">
							<a href="?sort=bbsNo,desc&page=${eventList.number - 1}" class="page-link">&lt;</a>
						</li>
					</c:if>
					<c:set var="pageRange2" scope="session" value="10" />
					<fmt:parseNumber var="pageIndex2" integerOnly="true" value="${eventList.number div pageRange2}" />
					<c:choose>
						<c:when test="${pageIndex2 * pageRange2 + pageRange2 > eventList.totalPages - 1}">
							<c:set var="lastPage2" scope="session" value="${eventList.totalPages}" />
						</c:when>
						<c:otherwise>
							<c:set var="lastPage2" scope="session" value="${pageIndex2 * pageRange2 + pageRange2}" />
						</c:otherwise>
					</c:choose>
					<c:forEach var="j" begin="${pageIndex2 * pageRange2 + 1}" end="${lastPage2}">
						<c:choose>
							<c:when test="${eventList.number + 1 == j}">
								<li class="page-item active">
									<a href="#" class="page-link"> <c:out value="${j}" />
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a href="?sort=bbsNo,desc&page=${j - 1}" class="page-link"> <c:out value="${j}" />
									</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${!eventList.last}">
						<li class="page-item">
							<a href="?sort=bbsNo,desc&page=${eventList.number + 1}" class="page-link">&gt;</a>
						</li>
						<li class="page-item">
							<a href="?sort=bbsNo,desc&page=${eventList.totalPages - 1}" class="page-link">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>