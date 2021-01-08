<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	$(function() {
		$(".close").click(function(e) {
			e.preventDefault();
			$(".layer-background, .member-detail").hide();
		});
		$("#withdraw").click(function(e) {
			if (confirm("탈퇴시키시겠습니까?")) {
				//탈퇴
			}
		});
	});
</script>

<div class="container">
	<!-- 기본정보 -->
	<div>
		<div class="row">
			<div class="col">
				<h5>| 기본정보</h5>
			</div>
			<div class="col">
				<button type="button" class="close" aria-label="Close">
					<span aria-hidden="true" style="font-size: xxx-large;">&times;</span>
				</button>
			</div>
		</div>

		<div>
			<table class="table-bordered table-striped">
				<tr>
					<th style="width: 15%;">
						<b>아이디</b>
					</th>
					<td style="width: 35%;">${memberDto.memId}</td>
					<th style="width: 15%;">
						<b>비밀번호</b>
					</th>
					<td style="width: 35%;">숨김처리</td>
					<%-- <td style="width: 35%;">${memberDto.memPw}</td> --%>
				</tr>
				<tr>
					<th>
						<b>성함</b>
					</th>
					<td>${memberDto.memName}</td>
					<th>
						<b>연락처</b>
					</th>
					<td>${memberDto.memTel}</td>
				</tr>
				<c:choose>
					<c:when test="${not empty addressList}">
						<c:forEach items="${addressList}" var="addressDto">
							<tr>
								<th rowspan="2">
									<b>주소</b>
								</th>
								<td colspan="3">${addressDto.postalCode}&nbsp;${addressDto.address1}&nbsp;${addressDto.address2}&nbsp;${addressDto.address3}&nbsp;
									${addressDto.address4}</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</table>
		</div>
	</div>
	<br>
	<br>

	<!-- 참여내역 -->
	<div>
		<div class="row">
			<div>
				<h5>| 참여 내역</h5>
			</div>
		</div>

		<div class="table-wrapper-scroll-y my-custom-scrollbar">
			<table class="table-bordered table-striped">
				<tr>
					<th class="col-2">
						<b>날짜</b>
					</th>
					<th class="col-6">
						<b>프로젝트</b>
					</th>
					<th class="col-1 d-sm-none d-md-table-cell">
						<b>수량</b>
					</th>
					<th class="col-2">
						<b>총액</b>
					</th>
					<th class="col-1">
						<b>상태</b>
					</th>
				</tr>
				<tbody>
					<c:choose>
						<c:when test="${empty orderList.content}">
							<tr>
								<td colspan="5">없음</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${orderList.content}" var="ordersDto" varStatus="orders">
								<tr>
									<td>${ordersDto.orderDate}</td>
									<td>${projectList[orders.index].proTitle}</td>
									<td>${ordersDto.count}</td>
									<td>${ordersDto.totalPrice}</td>
									<td>${ordersDto.state}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<br>
	<br>

	<!-- 탈퇴 -->
	<div class="text-center">
		<button type="button" id="withdraw" class="btn btn-secondary">
			<b>강제 탈퇴</b>
		</button>
	</div>
	<br>
</div>
