<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
table {
	border-bottom: solid darkgray 1px;
	border-top: solid darkgray 1px;
	padding-right: 15px;
	margin-bottom: 10%;
}
.td1 {
	border-right: darkgray solid 1px;
	text-align: right;
	padding-right: 15px;
}
.td2 {
	padding-left: 15px;
}
td {
	border-bottom: solid darkgray 1px;
	padding-bottom: 1.5%;
	padding-top: 1.5%;
}
tr {
	vertical-align: middle;
}
.btn {
	float: right;
	background-color: white;
}
.phone {
	width: 20%;
	height: 95%;
	display: inline;
}
.address1 {
	width: 30%;
	display: inline;
	height: 30%;
}
.address2 {
	width: 75%;
	height: 30%;
	margin-top: 5px;
}
.bank {
	width: 75%;
	height: 20%;
}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="container" style="margin-top: 5%">
	<!-- title -->
	<div style="margin-bottom: 5%;">
		<h2>| 개인정보 수정</h2>
		<hr>
	</div>
	<!-- table -->
	<div style="margin: 0 auto;">
		<form action="/main" onsubmit="update(); return false" id="form">
			<table style="width: 100%;">
				<tr>
					<!-- 아이디 -->
					<td class="td1">
						<span style="color: orange">*</span>아이디
					</td>
					<td class="td2">${member.memId}</td>
				</tr>
				<tr>
					<!-- 이름 -->
					<td class="td1">
						<span style="color: orange">*</span>이름
					</td>
					<td class="td2">
						<input type="hidden" id="name" name="memName" value="${member.memName}">${member.memName}</td>
				</tr>
				<tr>
					<!-- 연락처 수정 -->
					<td class="td1">
						<span style="color: orange">*</span> 연락처
					</td>
					<td class="td2">
						<input type="text" id="memTel" name="memTel" class="form-control input" value="${member.memTel}" required>
					</td>
				</tr>
				<tr>
					<!-- 주소수정 -->
					<td class="td1">주소</td>
					<td class="td2">
						<label style="width: 91%;"> <input type="text" name="postalCode" id="postalCode" class="form-control input" value="${address.postalCode}" readonly />
						</label> <label>
							<button type="button" class="button_postnumber" onclick="sample4_execDaumPostcode();" style="padding-left: 9px; left: 0px;">주소 검색</button>
						</label> <br>
						<input type="text" name="address1" id="address1" class="form-control input" value="${address.address1}" style="margin-top: 20px;" readonly />
						<br>
						<input type="text" name="address2" id="address2" class="form-control input" value="${address.address2}" readonly />
						<br>
						<input type="text" name="address3" id="address3" class="form-control input" value="${address.address3}">
						<br>
						<input type="text" name="address4" id="address4" class="form-control input" readonly="readonly" value="${address.address4}">
						<input type="hidden" name="mem_address4">
					</td>
				</tr>
				<tr>
					<!-- 계좌수정 -->
					<td class="td1">계좌</td>
					<td class="td2">
						은행선택 : <select name="bankName" id="bankName" class="form-control input">
							<option value="" selected>은행을 선택하세요</option>
							<option value="국민은행">국민은행</option>
							<option value="우리은행">우리은행</option>
							<option value="신한은행">신한은행</option>
							<option value="농협은행">농협은행</option>
							<option value="카카오뱅크">카카오뱅크</option>
						</select> <br>
						<input type="text" id="accountName" name="accountName" class="form-control input" value="${account.accountName}">
						<br>
						<input type="text" id="accountNumber" name="accountNumber" class="form-control input" value="${account.accountNumber}">
					</td>
				</tr>
			</table>
			<!-- table end -->
			<!-- 동의서 -->
			<div class="col-lg-12 col-sm-12" style="margin-bottom: 5%;">
				<h5>| 마케팅정보 제공동의</h5>
				<hr>
				<textarea class="col-lg-12 col-sm-12" name="" id="" style="resize: none;"></textarea>
				<hr>
			</div>
			<div class="upButtonWrap" role="group" aria-label="..." style="margin: 0 auto;">
				<a href="/main"><input type="button" class="uploadButton" value="취소하기"></a>
				<button type="submit" class="uploadButton">저장하기</button>
			</div>
		</form>
	</div>
</div>

<!-- 은행명 -->
<script>
	$(document).ready(function() {
		$("#bankName").val(${account.bankName}).prop("selected", true);
	})
</script>

<!-- 주소 -->
<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수
				
				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 도로명 주소 선택 시
					addr = data.roadAddress;
				} /* else { addr = data.jibunAddress; } // 지번 주소 선택 시 */
				
				// 법정동명 있는 경우 (법정리 X)(법정동은 "동/로/가"로 끝남)
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명 있고 공동주택인 경우
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 참고항목 있는 경우
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				
				// 우편번호와 주소 정보를 해당 필드에 입력
				document.getElementById('postalCode').value = data.zonecode;
				document.getElementById("address1").value = roadAddr;
				document.getElementById("address2").value = data.jibunAddress;
				
				// 참고항목 있는 경우의 입력란
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
</script>

<!-- 검증 -->
<script>
	function update() {
		if ($('#memTel').val() == "") {
			alert("연락처를 입력해주세요");
			$('#memTel').focus();
			return false;
		} else if ($('address3').val() == "") {
			alert("상세주소를 입력해주세요.");
			$("#address3").focus();
			return false;
		} else if ($('#bankName').val() == "") {
			alert("은행을 선택해주세요.");
			$("#bankName").focus();
			return false;
		} else if ($('#accountName').val() == "") {
			alert("예금주를 입력해주세요.");
			$("#accountName").focus();
			return false;
		} else if ($('#accountNumber').val() == "") {
			alert("계좌번호를 입력해주세요.");
			$("#accountNumber").focus();
			return false;
		} else {
			$.ajax({
				type : "put",
				url : "memUpdateRequest",
				data : $('#form').serialize(),
				success : function() {
					alert("회원정보가 수정되었습니다.");
					window.location = '/main';
				}
			});
		}
	}
</script>