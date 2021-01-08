<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="../../../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<style>
th {
	width: 20%;
	background: #f7f7f7;
	padding: 10px 15px;
}
</style>

<div class="container">
	<div>
		<h4>| 프로젝트 신청</h4>
	</div>
	<hr>
	<br>

	<div>
		<form action="/mypage/applyInsert" class="fileUploadForm" enctype="multipart/form-data" method="post">
			<!-- 기본 정보 -->
			<div>
				<div>
					<h5>기본 정보</h5>
				</div>
				<div>
					<table>
						<tr>
							<th>
								<strong>프로젝트 제목</strong>
							</th>
							<td>
								<input type="text" name="aplTitle" id="title" style="width: 100%;">
							</td>
						</tr>
					</table>
				</div>
			</div>
			<br>

			<!-- 에디터 -->
			<div>
				<div>
					<h5>상세 설명</h5>
				</div>
				<div>
					<textarea name="textAreaContent" id="textAreaContent" style="width: 100%; height: 350px;" required></textarea>
				</div>
			</div>
			<br>

			<!-- 이미지 -->
			<div>
				<div>
					<h5>이미지</h5>
				</div>
				<div>
					<table>
						<tr>
							<th>
								<span style="color: red">*</span>
								썸네일
							</th>
							<td>
								<input type="file" name="fileName" id="upload/thumbnails" onchange="Check1(this)" accept="image/*" />
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<input type="file" name="fileName" onchange="Check2(this)" accept=".zip, .7z, .tgz" />
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center;">필요한 파일들은 압축파일로 올려주세요. 첨부파일 20MB까지만 첨부가능합니다.</td>
						</tr>
					</table>
				</div>
			</div>
			<br>

			<!-- 신청/취소 -->
			<div class="text-center">
				<button type="button" style="width: 15%;" onclick="history.back()">취소</button>
				<button type="button" style="width: 15%;" onclick="submitContents(this)">신청</button>
			</div>
		</form>
	</div>
</div>


<!-- 에디터기능 -->
<script>
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "textAreaContent",
		sSkinURI : "../../../se2/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,
			bUseVerticalResizer : true,
			bUseModeChanger : true
		},
		fCreator : "createSEditor2"
	});

	function pasteHTML(filepath) {
		var sHTML = '<img src="../../../se2/upload/' + filepath + '">';
		oEditors.getById["textAreaContent"].exec("PASTE_HTML", [ sHTML ]);
	}

	function submitContents(elClickedObj) {
		oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);

		if ($('#title').val() == "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
		}

		if ($('#textAreaContent').val() == "") {
			alert("상세 설명을 입력해주세요.");
			oEditors.getById["textAreaContent"].exec("FOCUS");
			return;
		}

		if ($('#thumbNail').val() == "") {
			alert("썸네일을 등록해주세요.");
			$("#thumbNail").focus();
			return;
		}

		try {
			elClickedObj.form.submit();
			alert("프로젝트를 신청하였습니다.");
		} catch (e) {
		}
	}

	function Check1(input) { //이미지 파일 확장자 검사
		var file = input.value;
		file = file.slice(file.indexOf(".") + 1).toLowerCase();
		if (!(file == "jpg" || file == "jpeg" || file == "png" || file == "svg" || file == "vnb")) {
			alert("이미지 파일만 선택해주세요.");
			input.value = null;
		}
	}

	function Check2(input) { //첨부파일 확장자 검사, 사이즈검사
		var file = input.value;
		file = file.slice(file.indexOf(".") + 1).toLowerCase();
		if (!(file == "zip" || file == "7z" || file != "tgz")) {
			alert("압축파일만 선택해주세요.");
			input.value = null;
		} else {
			if (input.files && input.files[0].size > (20 * 1024 * 1024)) {
				alert("파일 사이즈가 20MB 를 넘습니다.");
				input.value = null;
			}
		}
	}
</script>