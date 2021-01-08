<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Content -->
<div>
	<ul class="row" style="padding: 0;">
		<c:forEach var="project" items="${projectList.content}">
			<li class="col-sm-6 col-lg-4 project-item">
				<a href="/project/detail?proNo=${project.proNo}" class="d-inline">
					<div style="height: 10rem; background-image: url('${project.proThumb}'); background-size: 100% 100%; border-radius: 5% 5% 0 0;"></div>
					<div style="width: 100%; background-color: lightgray; border-radius: 5%">
						<div class="progress-bar" role="progressbar" style="width: ${project.proceed}%;" aria-valuenow="${project.proceed}" aria-valuemin="0"
							aria-valuemax="100" style="border-radius: 5%"
						>${project.proceed}%</div>
					</div>
					<div class="project-item-title">${project.proTitle}</div>
					<div>
						<span class="badge">${project.proType}</span>
						<span style="float: right;">${project.proStart}~${project.proEnd}</span>
					</div>
				</a>
			</li>
		</c:forEach>
	</ul>
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
</div>
