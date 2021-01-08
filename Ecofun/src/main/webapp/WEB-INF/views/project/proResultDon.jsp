<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.study.springboot.dto.OrdersDto"%>
<%@ page import="com.study.springboot.dto.MemberDto"%>

<%-- <%
Long memNo = (Long) session.getAttribute("memNo");
Long orderMemNo = ((OrderDto) request.getAttribute("order")).getMemNo();
if (memNo == null || memNo != orderMemNo) {
%>
alert("잘못된 경로로 접근하셨습니다."); window.location = '/main';
<%
	} else {
%> --%>

<div class="container">
	<div>
		<h4>| 주문 및 결제</h4>
	</div>
	<hr>
	<br>

	<div>
		<h5>기부완료</h5>
		<strong>참여가 완료되었습니다. "${project.proTitle}"에 참여해주셔서 감사합니다.</strong>
		<p>참여 내역은 [마이 페이지 > 프로젝트 내역]에서 다시 확인할 수 있습니다.</p>
	</div>
	<br>

	<div style="background-image: url('${project.proThumb}'); background-size: 100% 100%;">
		<img src="http://placehold.it/300x300" alt="이미지" class="hidden">
	</div>
	<br>

	<!-- 결제 내역 -->
	<div>
		<h5>| 결제 내역</h5>
		<table class="table-bordered">
			<tr>
				<th class="col-4 col-md-3">프로젝트</th>
				<td>
					<h5>${project.proTitle}</h5>
					<span>${option.opName} (${orders.price}원)</span> * <span>${orders.count}개</span>
					<hr style="margin: 0;">
					<strong>총 금액: ${orders.totalPrice}원</strong>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<br>

	<!-- 기부자 정보 -->
	<div>
		<h5>| 참여자 정보</h5>
		<table class="table-bordered">
			<tr>
				<th class="col-4 col-md-3">이름</th>
				<td>${orders.none}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${member.memTel}</td>
			</tr>
		</table>
	</div>
	<br>
	<br>

	<!-- 결제확인 -->
	<div>
		<h5>| 결제금액 /결제수단 확인</h5>
		<table class="table-bordered">
			<tr>
				<th class="col-4 col-md-3">금액</th>
				<td>${orders.totalPrice}원</td>
			</tr>
			<tr>
				<th>계좌</th>
				<td>${orders.bankName}</td>
			</tr>
			<tr>
				<th>일시</th>
				<td>${orders.orderDate}</td>
			</tr>
		</table>
	</div>
	<br>
	<br>

	<!-- 하단 확인 버튼 -->
	<div class="text-center">
		<button type="button" onclick="changeView(0)">확인</button>
	</div>
</div>