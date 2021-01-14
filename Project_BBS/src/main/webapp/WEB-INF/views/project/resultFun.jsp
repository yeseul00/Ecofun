<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.OrderDto"%>
<%@ page import="com.study.springboot.dto.MemberDto"%>

<style>
th,td {
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

.responsive {
	float: left;
	padding: 0;
}

@media ( min-width :992px) {
	.col-lg-3 {
		width: 25%;
	}
	.col-lg-9 {
		width: 75%;
	}
}
</style>

<%-- <%
Long memNo = (Long) session.getAttribute("memNo");
Long orderMemNo = ((OrderDto) model.getAttribute("member")).getMemNo();
if (memNo == null || memNo != orderMemNo) {
%>
alert("잘못된 경로로 접근하셨습니다."); window.location = '/main';
<%
	} else {
%> --%>

<div class="container">
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

	<!-- 참여 프로젝트 정보 -->
	<div>
		<h5>| 참여 프로젝트 정보</h5>
		<div class="sub-wrap" style="display: inline-block;">
			<div class="responsive col-lg-3" style="background-image: url('${project.proThumb}'); background-size: 100% 100%;">
				<img src="http://placehold.it/1240x930" alt="1240x930" style="max-width: 100%; visibility: hidden;">
			</div>
			<div class="responsive col-lg-9" style="text-align: left;">
				<table>
					<tr>
						<td><h3 style="margin: inherit;">${project.proInfo}</h3></td>
					</tr>
					<tr>
						<td><h4>
								옵션: <strong>${option.opName}</strong> <span style="float: right;">${option.price}원</span> <span style="float: right;">${order.count}개</span>
							</h4></td>
					</tr>
					<tr>
						<td><h4>
								총액 <span style="float: right; vertical-align: middle;">${order.totalPrice}원</span>
							</h4></td>
					</tr>
				</table>
			</div>
		</div>
	</div>


	<!-- 참여자 정보 -->
	<div>
		<h5>| 참여자 정보</h5>
		<div class="sub-wrap">
			<table>
				<tr>
					<th>이름</th>
					<td>${member.memName}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${member.memTel}</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 배송지 확인 -->
	<div>
		<h5>| 배송지 확인</h5>
		<div class="sub-wrap">
			<table>
				<tr>
					<th>이름</th>
					<td>${order.toName}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${order.toTel}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${order.address1}${order.address2}${order.address3}</td>
				</tr>
				<tr>
					<th>요청사항</th>
					<td>${order.request}</td>
				</tr>
			</table>
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
						<th>결제방법</th>
						<td><label class="payLabel">{ 신용카드/페이 }</label></td>
					</tr>
					<tr>
						<th>결제일시</th>
						<td><label class="payLabel">${order.orderDate}</label></td>
					</tr>
				</table>
			</div>
		</div>

		<!-- 하단 확인 버튼 -->
		<div class="upButtonWrap" role="group" aria-label="..." style="text-align: center;">
			<button type="button" onclick="changeView(0)">확인</button>
		</div>
	</div>
</div>
<%-- <%
	}
%> --%>