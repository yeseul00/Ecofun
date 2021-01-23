<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.OrderDto"%>
<%@ page import="com.study.springboot.dto.MemberDto"%>

<!-- <link rel="stylesheet" href="css/bootstrap.css"> -->

<style>
.sub-wrap {
	border-top: 1px darkgray solid;
	border-bottom: 1px darkgray solid;
	margin-bottom: 5%;
	width: 100%;
}
th, td {
	vertical-align: middle !Important;
	padding: 5px;
}
th {
	text-align: center;
	border-right: darkgray 3px solid;
	background-color: lightgray;
	border-right: darkgray 3px solid;
	width: 20%;
}
</style>

<%-- <%
Long memNo = (Long) session.getAttribute("memNo");
Long orderMemNo = ((OrderDto) request.getAttribute("order")).getMemNo();
if (memNo == null || memNo != orderMemNo) {
%>
alert("잘못된 경로로 접근하셨습니다."); window.location = '/main';
<%
	} else {
%> --%>

<div class="container" id="container">
	<!-- title -->
	<br>
	<div>
		<h6>주문 및 결제</h6>
		<hr>
	</div>
	<br>


	<div>
		<h5>기부완료</h5>
		<div class="sub-wrap">
			<div>
				<strong>참여가 완료되었습니다. "${project.proInfo}"에 참여해주셔서 감사합니다.</strong>
			</div>
			<div>참여 내역은 [마이 페이지 > 프로젝트 내역]에서 다시 확인할 수 있습니다.</div>
		</div>
	</div>


	<!-- 프로젝트 정보 -->
	<div>
		<h5>| 참여정보</h5>
		<div class="sub-wrap" style="display: flex;">
			<div class="col-lg-2"
				style="background-image: url('${project.proThumb}'); background-size: 100% 100%;"></div>
			<div class="col-lg-11" style="text-align: left;">
				<div class="pro" style="font-size: large; margin-bottom: 3%;">${project.proInfo}</div>
				<div class="col-lg-5" style="float: left; padding-left: 0;">${option.opName}</div>
				<div class="col-lg-3" style="float: right; text-align: right;">${order.price}원</div>
				<div class="col-lg-3" style="float: right; text-align: right;">${order.count}개</div>
				<div style="clear: both;"></div>
				<hr>
				<div class="col-lg-5" style="float: left; font-size: large;">
					<strong> 총 금액 </strong>
				</div>
				<div class="col-lg-3" style="float: right; text-align: right;">
					<strong> ${order.totalPrice}원</strong>
				</div>
			</div>
		</div>
	</div>


	<!-- 기부자 정보 -->
	<div>
		<h5>| 참여자 정보</h5>
		<div class="sub-wrap">
			<table>
				<tr>
					<th>이름</th>
					<td>${order.none}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${member.memTel}</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 결제확인 -->
	<div>
		<h5>| 결제금액 /결제수단 확인</h5>
		<div class="sub-wrap">
			<table>
				<tr>
					<th>결제금액</th>
					<td>${order.totalPrice}원</td>
				</tr>
				<tr>
					<th>결제계좌</th>
					<td><label class="payLabel">${order.bankName} /
							${order.accountNumber}</label></td>
				</tr>
				<tr>
					<th>결제일시</th>
					<td><label class="payLabel">${order.orderDate}</label></td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 하단 확인 버튼 -->
	<div class="upButtonWrap" role="group" aria-label="..."
		style="text-align: center;">
		<button type="button" onclick="changeView(0)">확인</button>
	</div>
</div>