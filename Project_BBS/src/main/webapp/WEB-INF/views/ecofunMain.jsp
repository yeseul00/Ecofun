<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.project-item {
	margin-bottom: 3%;
}

.project-item-title {
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: center;
}
</style>

<script>
	$(function() {
		// 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
		$('#carouselExampleIndicators').carousel({
			interval : 5000,	// 슬리아딩 자동 순환 지연 시간. false면 자동 순환하지 않는다.
			pause : "hover",	// hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
			wrap : true,		// 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
			keyboard : true		// 키보드 이벤트 설정 여부(?)
		});
	});
</script>


<!-- 캐러셀 -->
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width: 100%;">
	<ol class="carousel-indicators">
		<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
		<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	</ol>
	<div class="carousel-inner">
		<div class="carousel-item active">
			<img class="d-block w-100" src="/img/1.jpg" alt="First slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block" style="color: darkslategray;">
				<h5>코팅하지 않은 친환경 냄비 세트</h5>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img class="d-block w-100" src="/img/2.jpg" alt="Second slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block">
				<h5>자연으로 돌아가는 생분해 포장지</h5>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img class="d-block w-100" src="/img/3.jpg" alt="Third slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block">
				<h5>재활용 플라스틱으로 만든 자동 쓰레기통</h5>
				<p></p>
			</div>
		</div>
		<div class="carousel-item">
			<img class="d-block w-100" src="/img/4.jpg" alt="Forth slide" style="width: 100%">
			<div class="carousel-caption d-none d-md-block">
				<h5></h5>
				<p></p>
			</div>
		</div>
	</div>
	<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev"> <!-- <span class="carousel-control-prev-icon" aria-hidden="true"></span> -->
		<span class="sr-only">Previous</span>
	</a> <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next"> <!-- <span class="carousel-control-next-icon" aria-hidden="true"></span> -->
		<span class="sr-only">Next</span>
	</a>
</div>


<div class="container">
	<!-- 메인영역 1(진행중 리스트) 시작-->
	<div class="row">
		<div class="col-lg-12 col-md-12">
			<h3 style="text-align: left; margin-top: 3%; margin-bottom: 2%; font-size: larger;">
				진행중인 프로젝트 <a href="projectList" style="float: right;"><span style="font-size: small;">더보기></span></a>
			</h3>
		</div>
	</div>
	<!-- 컨텐츠 시작 -->
	<div>
		<ul class="form-inline">
			<c:forEach end="5" var="project1" items="${projectList1.content}">
				<li class="col-sm-6 col-lg-4 project-item"><a href="/projectDetail?proNo=${project1.proNo}" class="d-inline">
						<div style="height: 10rem; background-image: url('${project1.proThumb}'); background-size: 100% 100%;"></div>
						<div class="progress-bar" role="progressbar" style="width: ${project1.proceed}%;" aria-valuenow="${project1.proceed}" aria-valuemin="0"
							aria-valuemax="100"
						>${project1.proceed}%</div>
						<div class="project-item-title">${project1.proInfo}</div>
						<div>
							<span class="badge">${project1.proType}</span><span style="float: right;">${project1.proStart}~${project1.proEnd}</span>
						</div>
				</a></li>
			</c:forEach>
		</ul>
	</div>
	<hr style="margin-top: 5%; margin-bottom: 3%;">
	<!-- 테스트 끝 -->


	<!-- 메인영역 2(종료임박 리스트) 시작-->
	<div class="row">
		<div class="col-lg-12 col-md-12">
			<h3 style="text-align: left; margin-top: 3%; margin-bottom: 2%; font-size: larger;">
				종료임박 프로젝트 <a href="projectList" style="float: right;"><span style="font-size: small;">더보기></span></a>
			</h3>
		</div>
	</div>
	<!-- 컨텐츠 시작 -->
	<div>
		<ul class="form-inline">
			<c:forEach end="5" var="project2" items="${projectList2.content}">
				<li class="col-sm-6 col-lg-4 project-item"><a href="/projectDetail?proNo=${project2.proNo}" class="d-inline">
						<div style="height: 10rem; background-image: url('${project2.proThumb}'); background-size: 100% 100%;"></div>
						<div class="progress-bar" role="progressbar" style="width: ${project2.proceed}%;" aria-valuenow="${project2.proceed}" aria-valuemin="0"
							aria-valuemax="100"
						>${project2.proceed}%</div>
						<div class="project-item-title">${project2.proInfo}</div>
						<div>
							<span class="badge">${project2.proType}</span><span style="float: right;">${project2.proStart}~${project2.proEnd}</span>
						</div>
				</a></li>
			</c:forEach>
		</ul>
	</div>
	<hr style="margin-top: 5%;">
	<!-- 테스트 끝 -->


	<!-- 메인영역 3(진행예정 리스트) 시작-->
	<div class="row">
		<div class="col-lg-12 col-md-12">
			<h3 style="text-align: left; margin-top: 3%; margin-bottom: 2%; font-size: larger;">
				진행예정 프로젝트 <a href="projectList" style="float: right;"><span style="font-size: small;">더보기></span></a>
			</h3>
		</div>
	</div>
	<!-- 컨텐츠 시작 -->
	<div>
		<ul class="form-inline">
			<c:forEach var="project3" items="${projectList3.content}">
				<li class="col-sm-6 col-lg-4 project-item"><a href="/projectDetail?proNo=${project3.proNo}" class="d-inline">
						<div style="height: 10rem; background-image: url('${project3.proThumb}'); background-size: 100% 100%;"></div>
						<div class="progress-bar" role="progressbar" style="width: ${project3.proceed}%;" aria-valuenow="${project3.proceed}" aria-valuemin="0"
							aria-valuemax="100"
						>${project3.proceed}%</div>
						<div class="project-item-title">${project3.proInfo}</div>
						<div>
							<span class="badge">${project3.proType}</span><span style="float: right;">${project3.proStart}~${project3.proEnd}</span>
						</div>
				</a></li>
			</c:forEach>
		</ul>
	</div>
	<hr style="margin-top: 5%; margin-bottom: 3%;">
	<!-- 테스트 끝 -->
</div>