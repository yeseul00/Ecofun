<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.carousel-item>img {
	margin: 0 auto;
	height: 350px;
}
h5 {
	font-size: 1.32875rem;
	font-weight: 700;
	line-height: 1.2;
}
.carousel-item div p,h5{
	text-align: right;
	color: black;
}
a:link{
	display: flex;
}
</style>
<div class="container">
	<br>
	<br>
	<div>
		<h6>| 제휴단체</h6>
		<hr>
	</div>

	<div class="row" style="justify-content: center;">
		<h5>EcoFun Project와 함께하는 단체들을 소개합니다.</h5>
	</div>
	<br>

	<!-- 캐러셀 적용 -->
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img class="w-75" src="img/그린피스.jpg" alt="First slide">
				<div class="carousel-caption d-none d-md-block">
					<h5>그린피스</h5>
					<p>https://www.greenpeace.org/korea/</p>
				</div>
			</div>
			<div class="carousel-item">
				<img class="w-75" src="img/환경재단.jpg" alt="Second slide">
				<div class="carousel-caption d-none d-md-block">
					<h5>환경재단</h5>
					<p>http://www.greenfund.org/</p>
				</div>
			</div>
			<div class="carousel-item">
				<img class="w-75" src="img/환경보전협회.gif" alt="Third slide">
				<div class="carousel-caption d-none d-md-block">
					<h5>환경보전협회</h5>
					<p>https://www.epa.or.kr/main.jsp#slide2</p>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="false"></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next"> <span class="carousel-control-next-icon"
			aria-hidden="false" style="background-color:green;"
		></span> <span class="sr-only">Next</span>
		</a>
	</div>
</div>