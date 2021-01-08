<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	window.onload = function() {
		$('#main-banner').carousel({
			interval : 5000, // false (순환 X) 
			pause : "hover",
			wrap : true,
			keyboard : true
		});
	});
</script>

<!-- 캐러셀 -->
<div id="main-banner" class="carousel slide" data-ride="carousel" style="width: 100%;">
	<ol class="carousel-indicators">
		<li data-target="#main-banner" data-slide-to="0" class="active"></li>
		<li data-target="#main-banner" data-slide-to="1"></li>
		<li data-target="#main-banner" data-slide-to="2"></li>
	</ol>
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img src="/img/1.jpg" alt="First slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block" style="color: black;">
				<h5>코팅하지 않은 친환경 냄비 세트</h5>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img src="/img/2.jpg" alt="Second slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block">
				<h5>자연으로 돌아가는 생분해 포장지</h5>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img src="/img/3.jpg" alt="Third slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block">
				<h5>재활용 플라스틱으로 만든 자동 쓰레기통</h5>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img src="/img/4.jpg" alt="Forth slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block">
				<h5></h5>
				<p></p>
			</div>
		</div>
	</div>
	<a class="carousel-control-prev" href="#main-banner" role="button" data-bs-slide="prev"> <span class="carousel-control-prev-icon"></span>
	</a> <a class="carousel-control-next" href="#main-banner" role="button" data-bs-slide="next"> <span class="carousel-control-next-icon"></span>
	</a>
</div>


<div class="container">
	<!-- 메인영역 1(진행중 리스트) -->
	<div>
		<div class="row">
			<h3 style="margin-top: 3%; margin-bottom: 2%; font-size: larger;">
				진행중인 프로젝트 <a href="project/list" style="float: right;"> <span style="font-size: small;">더보기></span>
				</a>
			</h3>
		</div>
		<div>
			<ul class="row">
				<c:forEach end="5" var="project1" items="${projectList1.content}">
					<li class="col-sm-6 col-lg-4 project-item">
						<a href="/project/detail?proNo=${project1.proNo}" class="d-inline">
							<div style="height: 10rem; background-image: url('${project1.proThumb}'); background-size: 100% 100%;"></div>
							<div class="progress-bar" role="progressbar" style="width: ${project1.proceed}%;" aria-valuenow="${project1.proceed}" aria-valuemin="0"
								aria-valuemax="100"
							>${project1.proceed}%</div>
							<div class="project-item-title">${project1.proTitle}</div>
							<div>
								<span class="badge">${project1.proType}</span>
								<span style="float: right;">${project1.proStart}~${project1.proEnd}</span>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<hr>
	<br>

	<!-- 메인영역 2(종료임박 리스트) -->
	<div>
		<div class="row">
			<h3 style="text-align: left; margin-top: 3%; margin-bottom: 2%; font-size: larger;">
				종료임박 프로젝트 <a href="project/list" style="float: right;"> <span style="font-size: small;">더보기></span>
				</a>
			</h3>
		</div>
		<div>
			<ul class="row">
				<c:forEach end="5" var="project2" items="${projectList2.content}">
					<li class="col-sm-6 col-lg-4 project-item">
						<a href="/project/detail?proNo=${project2.proNo}" class="d-inline">
							<div style="height: 10rem; background-image: url('${project2.proThumb}'); background-size: 100% 100%;"></div>
							<div class="progress-bar" role="progressbar" style="width: ${project2.proceed}%;" aria-valuenow="${project2.proceed}" aria-valuemin="0"
								aria-valuemax="100"
							>${project2.proceed}%</div>
							<div class="project-item-title">${project2.proTitle}</div>
							<div>
								<span class="badge">${project2.proType}</span>
								<span style="float: right;">${project2.proStart}~${project2.proEnd}</span>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<hr>
	<br>

	<!-- 메인영역 3(진행예정 리스트) -->
	<div>
		<div class="row">
			<h3 style="text-align: left; margin-top: 3%; margin-bottom: 2%; font-size: larger;">
				진행예정 프로젝트 <a href="project/list" style="float: right;"> <span style="font-size: small;">더보기></span>
				</a>
			</h3>
		</div>
		<div>
			<ul class="row">
				<c:forEach var="project3" items="${projectList3.content}">
					<li class="col-sm-6 col-lg-4 project-item">
						<a href="/project/detail?proNo=${project3.proNo}" class="d-inline">
							<div style="height: 10rem; background-image: url('${project3.proThumb}'); background-size: 100% 100%;"></div>
							<div class="progress-bar" role="progressbar" style="width: ${project3.proceed}%;" aria-valuenow="${project3.proceed}" aria-valuemin="0"
								aria-valuemax="100"
							>${project3.proceed}%</div>
							<div class="project-item-title">${project3.proTitle}</div>
							<div>
								<span class="badge">${project3.proType}</span>
								<span style="float: right;">${project3.proStart}~${project3.proEnd}</span>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>