<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="../../../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<style>
th {
	width: 20%;
	padding: 10px 15px;
}

td {
	width: 80%;
	padding: 10px 15px;
}

.category {
	margin-left: 2%;
}
</style>
<div class="container" id="container">
	<div>
		<h4>| <a href="/board/list">게시판</a> > 작성
		</h4>
	</div>
	<hr>
	<br>

	<div>
		<form action="/admin/boardInsert" id="frm" enctype="multipart/form-data" method="post">
			<!-- 기본 정보 -->
			<div>
				<h5>기본 정보</h5>
			</div>
			<div>
				<table>
					<tr>
						<th>
							<strong>카테고리</strong>
						</th>
						<td>
							<label class="category">
								<input type="radio" name="bbsType" value="공지사항" id="radio">
								공지사항
							</label>
							<label class="category">
								<input type="radio" name="bbsType" value="이벤트">
								이벤트
							</label>
						</td>
					</tr>
					<tr>
						<th>
							<strong>제목</strong>
						</th>
						<td>
							<input type="text" id="title" name="bbsTitle" class="form-control">
						</td>
					</tr>
					<tr id="hidden" style="display: none;">
						<th>
							<strong>기간</strong>
						</th>
						<td>
							<input type="date" id="Date1" class="date form-control" name="bbsStart" value="" onchange="check_date1();" />
							<label style="margin-left: 2%; margin-right: 2%;">~</label>
							<input type="date" id="Date2" class="date form-control" name="bbsEnd" value="" onchange="check_date2();" />
						</td>
					</tr>
				</table>
			</div>
			<br> <br>

			<!-- 에디터 -->
			<div>
				<div>
					<h5>상세 설명</h5>
				</div>
				<div>
					<textarea name="textAreaContent" id="textAreaContent" style="width: 100%; height: 350px;"></textarea>
				</div>
			</div>
			<br> <br>

			<!-- 이미지 -->
			<div>
				<div>
					<h5>이미지</h5>
				</div>
				<div>
					<table>
						<tr>
							<th>썸네일(선택)</th>
							<td>
								<input type="file" name="fileName" onchange="checkEx(this)" accept="image/*" />
							</td>
						</tr>
					</table>
				</div>
			</div>
			<br> <br>

			<!-- 신청/취소 -->
			<div class="text-center">
				<button type="button" style="width: 15%;" onclick="history.back()">취소</button>
				<button type="button" style="width: 15%;" onclick="submitContents(this)">게시</button>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	// 카테고리에 따라 기간 row 생성
	window.onload = function() {
		$("input:radio[name=bbsType]").click(function() {
			var check = $(this).val();
			status = $("#hidden").css("display");
			if (check == "공지사항") {
				if (status == "table-row") {
					$("#hidden").css("display", "none");
				}
			} else if (check == "이벤트") {
				if (status == "none") {
					$("#hidden").css("display", "table-row");
				}
			}
		})
	}
</script>


<!-- 기간 -->
<script type="text/javascript">
	function check_date1() {
		var today = new Date().toISOString().substring(0, 10);
		var startDate = document.getElementById('Date1').value;

		if (startDate < today) {
			alert("시작기간은 과거로 설정할 수 없습니다.");
			document.getElementById('Date1').value = new Date().toISOString().substring(0, 10);
		}
	}

	function check_date2() {
		var startDate = document.getElementById('Date1').value;
		var endDate = document.getElementById('Date2').value;

		if (startDate > endDate) {
			alert("종료기간은 시작기간보다 커야합니다.");
			document.getElementById('Date2').value = new Date().toISOString().substring(0, 10);
		}
	}
</script>

<!-- 에디터 -->
<script type="text/javascript">
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
		oEditors.getById["textAreaContent"].exec("PASTE_HTML", [
			sHTML
		]);
	}

	function checkEx(input) { //이미지 파일 확장자 검사
		var file = input.value;
		file = file.slice(file.indexOf(".") + 1).toLowerCase();
		if (!(file == "jpg" || file == "jpeg" || file == "png" || file == "svg" || file == "vnb")) {
			alert("이미지 파일만 선택해주세요.");
			input.value = null;
		}
	}

	function submitContents(elClickedObj) {
		oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);
		var radio = $('input:radio[name=bbsType]').is(':checked');
		var radio_val = $('input:radio[name=bbsType]').val();
		var title = $('#title').val();
		var content = $('#textAreaContent').val();

		if (!radio) {
			alert("카테고리를 선택하세요.");
			$("#radio").focus();
		} else if (title == "") {
			alert("기본 정보를 입력하세요.");
			$("#title").focus();
		} else if (content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br />' || content == '<p>&nbsp;</p>') {
			alert("상세 설명을 입력하세요.");
			oEditors.getById["textAreaContent"].exec("FOCUS");
		} else {
			$("#frm").submit();
			alert("게시글을 등록하였습니다.");
		}
	}
</script>