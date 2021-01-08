<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div>
		<h4>| 문의하기</h4>
	</div>
	<hr>
	<br>

	<div class="text-center">
		<h6>작성완료를 누르면 관리자에게 전송됩니다. 답변은 나의 문의내역에서 확인 가능합니다.</h6>
	</div>

	<div>
		<form action="/askRequest" method="POST" class="col-12">
			<!-- 제목 -->
			<div>
				<input class="col-12" type="text" id="title" name="askTitle" placeholder="제목을 입력해주세요!" style="padding: 5px;">
			</div>
			<br>

			<!-- 에디터 -->
			<div>
				<textarea class="col-12" id="content" name="askContent" placeholder="내용을 입력해주세요!" style="resize: none;" rows="20;"></textarea>
			</div>
			<br>

			<!-- 등록/취소 -->
			<div class="text-center">
				<button type="button" style="width: 15%;" onclick="history.back()">취소</button>
				<button type="button" style="width: 15%;" onclick="submitContents(this)">문의</button>
			</div>
			<br>
		</form>
	</div>
</div>

<script type="text/javascript">
	function submitContents(elClickedObj) {
		var title = document.getElementById('title').value;
		var content = document.getElementById('content').value;
		if (title == "" || title == null || title == '&nbsp;' || title == '<br>' || title == '<br />' || title == '<p>&nbsp;</p>') {
			alert("제목을 입력해주세요.");
			$("#title").focus();
		} else if (content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br />' || content == '<p>&nbsp;</p>') {
			alert("내용을 입력해주세요.");
			$("#content").focus();
		} else {
			elClickedObj.form.submit();
			alert("문의하기가 완료되었습니다.");
		}
	}
</script>