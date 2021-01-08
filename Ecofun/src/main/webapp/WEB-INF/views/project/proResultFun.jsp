<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.study.springboot.dto.OrdersDto"%>
<%@ page import="com.study.springboot.dto.MemberDto"%>

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
	<div>
		<h4>| 주문 및 결제</h4>
	</div>
	<hr>
	<br>

	<div>
		<h5>참여 완료</h5>
		<div>
			<strong>참여가 완료되었습니다. "${project.proTitle}"에 참여해주셔서 감사합니다.</strong>
			<p>참여 내역은 [마이 페이지 > 프로젝트 내역]에서 다시 확인할 수 있습니다.</p>
		</div>
	</div>

	<div>
		<h5>| 참여 프로젝트 정보</h5>
		<div class="d-flex-wrap">
			<div class="col-12 col-md-3" style="background-image: url('${project.proThumb}'); background-size: 100% 100%;">
				<img src="http://placehold.it/300x300" alt="이미지" class="hidden">
			</div>
			<div class="col-12 col-md-9">
				<table>
					<tr>
						<td>
							<h4 class="mg-auto">${project.proTitle}</h4>
						</td>
					</tr>
					<tr>
						<td>
							<h5>
								옵션: <strong>${option.opName}</strong> <span>${orders.count}개</span> <span>${option.price}원</span>
							</h5>
						</td>
					</tr>
					<tr>
						<td>
							<h4>
								총액 <span>${orders.totalPrice}원</span>
							</h4>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br>
	<br>

	<!-- 참여자 정보 -->
	<div>
		<h5>| 참여자 정보</h5>
		<div>
			<table>
				<tr>
					<th class="col-3 col-md-2">이름</th>
					<td>${member.memName}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${member.memTel}</td>
				</tr>
			</table>
		</div>
	</div>
	<br>
	<br>

	<!-- 배송지 확인 -->
	<div>
		<h5>| 배송지 확인</h5>
		<div>
			<table>
				<tr>
					<th>이름</th>
					<td>${orders.toName}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${orders.toTel}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${orders.address1}${orders.address2}${orders.address3}</td>
				</tr>
				<tr>
					<th>요청사항</th>
					<td>${orders.request}</td>
				</tr>
			</table>
		</div>
	</div>
	<br>
	<br>

	<!-- 결제확인 -->
	<div>
		<h5>| 결제금액 /결제수단 확인</h5>
		<div>
			<table>
				<tr>
					<th colspan="3" class="col-3 col-md-2">결제금액</th>
					<td>${orders.totalPrice}원</td>
				</tr>
				<tr>
					<th>결제방법</th>
					<td>{ 신용카드/페이 }</td>
				</tr>
				<tr>
					<th>결제일시</th>
					<td>${orders.orderDate}</td>
				</tr>
			</table>
		</div>
	</div>
	<br>

	<!-- 하단 확인 버튼 -->
	<div class="text-center">
		<button type="button" onclick="changeView(0)">확인</button>
	</div>
</div>
<%-- <%
	}
%> --%>