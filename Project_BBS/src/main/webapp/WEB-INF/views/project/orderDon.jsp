<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Long memNo = (Long) session.getAttribute("memNo");
%>

<style>
table {
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
	width: 25%;
}

.name {
	width: 25%;
	height: 20%;
}

button {
	width: 25%;
	font-size: 25px;
	line-height: 50px;
}

.bank, input {
	display: inline !Important;
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

<div class="container" id="container">
	<!-- title -->
	<br>
	<div>
		<h6>주문 및 결제</h6>
		<hr>
	</div>
	<br>

	<div>
		<!-- 프로젝트 정보 -->
		<h5>| 참여정보</h5>
		<div class="sub-wrap" style="display: inline-block;">
			<div class="responsive col-lg-3"
				style="background-image: url('${project.proThumb}'); background-size:100% 100%;">
				<img src="http://placehold.it/1240x930" alt="1240x930"
					style="max-width: 100%; visibility: hidden;">
			</div>
			<div class="responsive col-lg-9" style="float: right;">
				<table>
					<tr>
						<td style="padding: 1px 2px;" colspan="2">${project.proInfo}</td>
					</tr>
					<tr>
						<td>${option.opName}</td>
						<td style="text-align: right">${option.price}원${order.count}개</td>
					</tr>
					<tr>
						<td><hr></td>
					</tr>
					<tr>
						<td><strong style="font-size: large;">총액</strong></td>
						<td><strong style="text-align: right;">${order.totalPrice}원</strong></td>
					</tr>
				</table>
			</div>
		</div>

		<form action="/order" method="POST">
			<input type="text" hidden="hidden" name="proType" value="기부">
			<input type="number" hidden="hidden" name="memNo"
				value="${member.memNo}"> <input type="number"
				hidden="hidden" name="proNo" value="${project.proNo}"> <input
				type="number" hidden="hidden" name="opNo" value="${option.opNo}">
			<input type="number" hidden="hidden" name="count"
				value="${order.count}">

			<!-- 후원자 정보 -->
			<h5>| 후원자 정보</h5>
			<div class="sub-wrap">
				<table border="1">
					<tr>
						<th>이름</th>
						<td><input class="form-control name" type="text" name="none"
							maxlength="8" value="${member.memName}"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input class="form-control" type="text" name="memTel"
							maxlength="11" value="${member.memTel}"
							placeholder="'-' 없이 숫자만 입력해주세요." oninput="maxLengthCheck(this)"></td>
					</tr>
				</table>
			</div>


			<!-- 결제금액 / 결제방법 -->
			<h5>| 결제금액 / 결제방법</h5>
			<div class="sub-wrap">
				<table>
					<tr>
						<th>결제금액</th>
						<td><input class="form-control" type="text" name="totalPrice"
							value="${order.totalPrice}" style="width: 30%;" readonly>원</td>
					</tr>
					<tr>
						<th>입금은행</th>
						<td><input type="radio" name="pay" id="" value="banking"
							checked> 무통장입금
							<ul style="padding-left: 3%;">
								<li style="margin-bottom: 10px; margin-top: 10px;">입금은행 <select
									name="bankName" class="form-control bank" id=""
									style="width: 50%" required>
										<option selected="selected">-선택하세요-</option>
										<option value="신한은행">신한은행</option>
										<option value="기업은행">기업은행</option>
										<option value="국민은행">국민은행</option>
										<option value="우리은행">우리은행</option>
										<option value="제일은행">제일은행</option>
										<option value="농협은행">농협은행</option>
								</select>
								</li>
								<li>입금자명 <input type="text" class="form-control name"
									name="accountName" required>
								</li>
							</ul>
							<div id="label">※ 정확한 입금자명을 적어주세요</div></td>
					</tr>
				</table>
			</div>

			<!-- 하단 확인 버튼 -->
			<div style="text-align: center;">
				<button type="button" onclick="history.back();">뒤로가기</button>
				<button type="submit">결제하기</button>
			</div>
		</form>
	</div>
</div>

<script>
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/js/address.js"></script>