<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	Long memNo = (Long) session.getAttribute("memNo");
%>

<div class="container">
	<div>
		<h4>| 주문 및 결제</h4>
	</div>
	<hr>
	<br>

	<div class="order-area">
		<h5>| 참여 정보</h5>
		<div class="d-flex flex-wrap-reverse">
			<div class="col-12 col-md-8">
				<table class="table-bordered">
					<tr>
						<th class="col-2 col-md-3">프로젝트</th>
						<td colspan="2">
							<b class="fs-4">${project.proTitle}</b>
						</td>
					</tr>
					<tr>
						<th>옵션</th>
						<td>${option.opName}</td>
						<td class="text-end">${option.price}원*${orders.count}개</td>
					</tr>
					<tr>
						<th>총액</th>
						<td colspan="2" class="text-end">
							<strong>${orders.totalPrice}원</strong>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-12 col-md-4" style="background-image: url('${project.proThumb}'); background-size:100% 100%;">
				<img src="https://place-hold.it/294x122/FFFFFF/C0C0C0.png&text=Ecofun&fontsize=10" alt="이미지" class="hidden">
			</div>
		</div>
		<br>
		<br>

		<form action="/project/order" method="POST">
			<input type="text" hidden="hidden" name="proType" value="기부">
			<input type="number" hidden="hidden" name="memNo" value="${member.memNo}">
			<input type="number" hidden="hidden" name="proNo" value="${project.proNo}">
			<input type="number" hidden="hidden" name="opNo" value="${option.opNo}">
			<input type="number" hidden="hidden" name="count" value="${orders.count}">

			<h5>| 참여자 정보</h5>
			<table class="table-bordered">
				<tr>
					<th class="col-2">이름</th>
					<td>
						<input type="text" class="col-11 col-lg-6" name="none" id="none" maxlength="8" value="${member.memName}">
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input type="text" class="col-11 col-lg-6" name="memTel" maxlength="11" value="${member.memTel}" placeholder="'-' 없이 숫자만 입력해주세요."
							oninput="maxLengthCheck(this)"
						>
					</td>
				</tr>
			</table>
			<br>
			<br>

			<h5>| 결제금액 / 결제방법</h5>
			<table class="table-bordered">
				<tr>
					<th class="col-2">결제금액</th>
					<td colspan="3">
						<input type="text" class="col-10 col-lg-5" name="totalPrice" value="${orders.totalPrice}" readonly>
						원
					</td>
				</tr>
				<tr>
					<th>입금은행</th>
					<td>
						<input type="radio" name="pay" id="pay" value="banking" checked>
						<label for="pay">무통장입금</label>
					</td>
					<td>
						<label for="bankName">입금은행</label>
						<select name="bankName" id="bankName" required>
							<option value="" selected="selected">-선택하세요-</option>
							<option value="신한은행">신한은행</option>
							<option value="기업은행">기업은행</option>
							<option value="국민은행">국민은행</option>
							<option value="우리은행">우리은행</option>
							<option value="제일은행">제일은행</option>
							<option value="농협은행">농협은행</option>
							<option value="카카오뱅크">카카오뱅크</option>
						</select>
					</td>
					<td>
						<label for="accountName">입금자명</label>
						<input type="text" name="accountName" id="accountName" required>
					</td>
				</tr>
			</table>
			<br>
			<br>

			<!-- 하단 확인 버튼 -->
			<div class="text-center">
				<button type="button" onclick="history.back();">뒤로가기</button>
				<button type="button" onclick="validation(this)">결제하기</button>
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

	// 검증
	function validation(orders) {
		var none = $('#none').val();
		var accountName = $('#accountName').val();
		if (none == "") {
			alert("성함을 입력해주세요. 익명도 가능합니다.");
			$('#none').focus();
		} else if (accountName == "") {
			alert("임급자명을 입력해주세요.");
			$('#accountName').focus();
		} else {
			orders.form.submit();
			alert("주문이 완료되었습니다.");
		}
	}
</script>