<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div>
		<h4>주문 및 결제</h4>
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
			<input type="text" hidden="hidden" name="proType" value="펀딩">
			<input type="number" hidden="hidden" name="memNo" value="${member.memNo}">
			<input type="number" hidden="hidden" name="proNo" value="${project.proNo}">
			<input type="number" hidden="hidden" name="opNo" value="${option.opNo}">
			<input type="number" hidden="hidden" name="count" value="${orders.count}">

			<h5>| 참여자 정보</h5>
			<div>
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
			</div>
			<br>
			<br>

			<h5>| 배송지 정보</h5>
			<div>
				<table class="table-bordered">
					<tr>
						<th class="col-2">이름</th>
						<td>
							<input type="text" class="col-11 col-lg-6" name="toName" id="toName" value="${member.memName}" maxlength="10">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input type="number" class="col-11 col-lg-6" name="toTel" id="toTel" maxlength="11" placeholder="'-' 없이 숫자만 입력해주세요."
								oninput="maxLengthCheck(this)"
							>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td class="address-area">
							<input type="number" class="col-5" name="postalCode" id="postalCode" placeholder="우편번호" onclick="sample4_execDaumPostcode()" readonly />
							<button type="button" class="col-5 btn-zipCode" id="address" onclick="sample4_execDaumPostcode()">주소 검색</button>
							<input type="text" class="col-11" name="address1" id="address1" placeholder="도로명주소" />
							<input type="text" class="col-11" name="address2" id="address2" placeholder="기본주소" />
							<input type="text" class="col-11" name="address4" id="address4" readonly placeholder="참고항목" />
							<input type="text" class="col-11" name="address3" id="address3" placeholder="상세주소" />
						</td>
					</tr>
					<tr>
						<th>요청사항</th>
						<td>
							<input type="text" class="col-11" name="request" placeholder="20자 이내">
						</td>
					</tr>
				</table>
			</div>
			<br>
			<br>

			<h5>| 결제금액 / 결제방법</h5>
			<div>
				<table class="table-bordered">
					<tr>
						<th class="col-2">결제금액</th>
						<td>
							<input type="text" class="col-10 col-lg-5" name="totalPrice" value="${orders.totalPrice}" readonly>
							원
						</td>
					</tr>
					<tr>
						<th>결제방법</th>
						<td>
							<input type="radio" name="pay" id="card" value="card" required />
							<label for="card">카드결제</label>
							<input type="radio" name="pay" id="kakao" value="kakaopay" />
							<label for="kakao">카카오페이</label>
						</td>
					</tr>
				</table>
			</div>
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

<script type="text/javascript">
	// 주소 검색
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				// 법정동 (법정리X)(법정동은 "동/로/가"로 끝남)
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명 있는 공동주택
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 참고 항목
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				document.getElementById('postalCode').value = data.zonecode;
				document.getElementById("address1").value = roadAddr;
				document.getElementById("address2").value = data.jibunAddress;
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

	// 연락처 숫자 외 입력 제한
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}

	// 검증
	function validation(orders) {
		var none = $('#none').val();
		var toName = $('#toName').val();
		var toTel = $('#toTel').val();
		var postalCode = $('#postalCode').val();
		var address1 = $('#address1').val();
		if (none == "") {
			alert("성함을 입력해주세요.");
			$('#none').focus();
		} else if (toName == "") {
			alert("수령인의 성함을 입력해주세요.");
			$('#toName').focus();
		} else if (toTel == "") {
			alert("수령인의 연락처를 입력해주세요.");
			$('#toTel').focus();
		} else if (postalCode == "" || address1 == "") {
			alert("주소를 입력해주세요.");
			$('#address').focus();
		} else {			
			orders.form.submit();
			alert("주문이 완료되었습니다.");
		}
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/js/address.js"></script>