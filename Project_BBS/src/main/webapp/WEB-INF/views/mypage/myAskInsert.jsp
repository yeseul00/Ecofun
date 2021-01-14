<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container">
	<div>
		<h6>| 문의하기</h6>
		<hr style="margin-bottom: 5%;">
	</div>

	<div style="text-align: center; margin-bottom: 5%;">
		<h7>작성완료를 누르면 관리자에게 전송됩니다. 답변은 나의 문의내역에서 확인 가능합니다.</h7>
	</div>

	<div>
		<form action="/myAskRequest" id="frm" method="POST"
			style="width: 100%;">
			<!-- 제목 -->
			<div style="margin-bottom: 5%;">
				<input type="text" id="title" name="askTitle" class="form-control"
					placeholder="제목을 입력해주세요!" style="width: 100%; padding: 5px;">
			</div>

			<!-- 에디터 -->
			<div style="width: 100%; margin-bottom: 5%;">
				<textarea class="form-control" id="content" name="askContent"
					placeholder="내용을 입력해주세요!"
					style="width: 100%; min-width: 260px; resize: none;" rows="50;"></textarea>
			</div>

			<!-- 등록/취소 -->
			<div style="text-align: center; font-size: 1em; margin-bottom: 5%;">
				<input type="button" value="취소" style="width: 15%;" /> <input
					type="button" onclick="save(this)" value="확인" style="width: 15%;" "/>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	function save(elClickedObj) {
		var title = document.getElementById('title').value
		var content = document.getElementById('content').value
		if (title == "" || title == null || title == '&nbsp;' || title == '<br>' || title == '<br />' || title == '<p>&nbsp;</p>') {
			alert("문의 제목을 작성하세요.");
			$("#title").focus();
		} else if (content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br />' || content == '<p>&nbsp;</p>') {
			alert("문의 상세내용을 입력하세요.");
			$("#content").focus();
		} else {
			$("#frm").submit(); //폼id로 전송
			alert("신청완료 되었습니다.");
		}
	}
</script>
