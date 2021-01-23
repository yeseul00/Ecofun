<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.sub-wrap {
	border-top: 1px darkgray solid;
	border-bottom: 1px darkgray solid;
	margin-top: 5%;
	margin-bottom: 5%;
	width: 100%;
}
table {
	width: 100%;
}
th, td {
	vertical-align: middle !Important;
	padding: 0 10px;
}
th {
	text-align: center;
	border-right: darkgray 3px solid;
	background-color: lightgray;
	border-right: darkgray 3px solid;
	width: 25%;
	line-height: 20px;
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
input {
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
						<td><h3 style="margin: inherit;">${project.proInfo}</h3></td>
					</tr>
					<tr>
						<td><h4>
								옵션: <strong>${option.opName}</strong> <span
									style="float: right;">${option.price}원</span> <span
									style="float: right;">${order.count}개</span>
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

		<form action="/order" method="POST">
			<input type="text" hidden="hidden" name="proType" value="펀딩">
			<input type="number" hidden="hidden" name="memNo"
				value="${member.memNo}"> <input type="number"
				hidden="hidden" name="proNo" value="${project.proNo}"> <input
				type="number" hidden="hidden" name="opNo" value="${option.opNo}">
			<input type="number" hidden="hidden" name="count"
				value="${order.count}">

			<!-- 주문자 정보 -->
			<h5>| 주문자 정보</h5>
			<div class="sub-wrap">
				<table border="1">
					<tr>
						<th style="width: 20%;">이름</th>
						<td><input class="form-control name" type="text"
							name="memName" value="${member.memName}" readonly></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input class="form-control" type="text" name="memTel"
							value="${member.memTel}" readonly></td>
					</tr>
				</table>
			</div>

			<!-- 배송지 정보 -->
			<h5>| 배송지 정보</h5>
			<div class="sub-wrap">
				<table>
					<tr>
						<th>이름</th>
						<td><input type="text" class="form-control name"
							name="toName" value="${member.memName}" maxlength="10"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="number" class="form-control" name="toTel"
							maxlength="11" placeholder="'-' 없이 숫자만 입력해주세요."
							oninput="maxLengthCheck(this)"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><label style="width: 70%;"> <input type="number"
								class="form-control input" name="postalCode" id="postalCode"
								placeholder="우편번호" readonly="readonly" />
						</label> <label style="width: 20%">
								<button type="button" class="button_postnumber"
									onclick="sample4_execDaumPostcode();"
									style="width: 75%; padding: 0; margin: 0;">주소 검색</button>
						</label><br> <input type="text" class="form-control input"
							name="address1" id="address1" placeholder="도로명주소"
							style="margin-top: 20px;"><br> <input type="text"
							class="form-control input" name="address2" id="address2"
							placeholder="기본주소"><br> <input type="text"
							class="form-control input" name="address3" id="address3"
							placeholder="상세주소"><br> <input type="text"
							class="form-control input" name="address4" id="address4" readonly
							placeholder="참고항목"></td>
					</tr>
					<tr>
						<th style="width: 120;">요청사항</th>
						<td><input type="text" class="form-control" name="request"
							placeholder="20자 이내"></td>
					</tr>
				</table>
			</div>

			<!-- 결제 수단 -->
			<h5>| 결제금액 / 결제방법</h5>
			<div class="sub-wrap">
				<table>
					<tr>
						<th>결제금액</th>
						<td><input class="form-control" type="text" name="totalPrice"
							value="${order.totalPrice}" style="width: 20%;" readonly>원</td>
					</tr>
					<tr>
						<th>결제방법</th>
						<td><input type="radio" id="card" name="pay" value="card"
							required><label for="card">카드결제</label> <input
							type="radio" id="kakaopay" name="pay" value="kakaopay"><label
							for="kakaopay">카카오페이</label></td>
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
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postalCode').value = data.zonecode;
				document.getElementById("address1").value = roadAddr;
				document.getElementById("address2").value = data.jibunAddress;
				// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
				if (roadAddr !== '') {
					document.getElementById("address4").value = extraRoadAddr;
				} else {
					document.getElementById("address4").value = '';
				}
				var guideTextBox = document.getElementById("address1");
				// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				if (data.autoRoadAddress) {
					var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					guideTextBox.style.display = 'block';
				} else if (data.autoJibunAddress) {
					var expJibunAddr = data.autoJibunAddress;
					guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					guideTextBox.style.display = 'block';
				} else {
					guideTextBox.innerHTML = '';
					guideTextBox.style.display = 'none';
				}
			}
		}).open();
	}
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/js/address.js"></script>