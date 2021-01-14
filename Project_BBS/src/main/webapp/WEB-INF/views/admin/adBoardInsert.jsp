<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.table {
	width: 100%;
	border-bottom: 0.5px lightgray solid;
}

th {
	width: 20%;
	background: #f7f7f7;
	text-align: center;
	padding: 10px 15px;
}

td {
	width: 80%;
	padding: 10px 15px;
}

.category {
	margin-left: 2%;
}

.date {
	display: inline;
	width: 46%;
}
</style>

<div class="container">
	<div>
		<h6>| 게시판 작성</h6>
		<hr>
	</div>
	<br>

	<div>
		<form action="/adBoardAction" name="" id="frm" enctype="multipart/form-data" method="post">
			<!-- 기본 정보 -->
			<div style="margin-bottom: 5%;">
				<div>
					<h6>기본 정보</h6>
				</div>
				<div>
					<table class="table" id="first_table">
						<tr>
							<th><strong>카테고리</strong></th>
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
							<th><strong>제목</strong></th>
							<td>
								<input type="text" id="title" name="bbsTitle" class="form-control">
							</td>
						</tr>
						<tr id="hidden" style="display: none;">
							<th><strong>기간</strong></th>
							<td>
								<input type="date" id="Date1" class="date form-control" name="bbsStart" value="" onchange="check_date1();" />
								<label style="margin-left: 2%; margin-right: 2%;">~</label>
								<input type="date" id="Date2" class="date form-control" name="bbsEnd" value="" onchange="check_date2();" />
							</td>
						</tr>
					</table>
				</div>
			</div>


			<!-- 에디터 -->
			<div style="margin-bottom: 5%;">
				<div>
					<h5>상세 설명</h5>
				</div>
				<div>
					<textarea name="textAreaContent" id="textAreaContent" style="width: 100%; height: 350px;"></textarea>
				</div>
			</div>


			<!-- 이미지 -->
			<div style="margin-bottom: 5%;">
				<div>
					<h5>이미지</h5>
				</div>
				<div>
					<table class="table">
						<tr>
							<th>썸네일(선택)</th>
							<td>
								<input type="file" name="fileName" id="thumbNail" onchange="Check1(this)" accept="image/*" />
							</td>

						</tr>
					</table>
				</div>
			</div>


			<!-- 신청/취소 -->
			<div style="text-align: center; font-size: 1em; margin-bottom: 5%;">
				<input type="button" value="취소" style="width: 15%;" />
				<input type="button" value="신청" onclick="save(this)" style="width: 15%;" />
			</div>
		</form>
	</div>
</div>

<script type="text/javascript" src="../../../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
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
	
	//에디터 이미지저장 
	function pasteHTML(filepath) {
		var sHTML = '<img src="../../../se2/upload/' + filepath + '">';
		oEditors.getById["textAreaContent"].exec("PASTE_HTML", [ sHTML ]);
	}

	function Check1(input) { //이미지 파일 확장자 검사
		var file = input.value;
		file = file.slice(file.indexOf(".") + 1).toLowerCase();
		if (!(file == "jpg" || file == "jpeg" || file == "png" || file == "svg" || file == "vnb")) {
			alert("이미지 파일만 선택해주세요.");
			input.value = null;
		}
	}
</script>

<script type="text/javascript">
	//저장버튼 클릭시 form 전송
	function save(elClickedObj) {
		
		oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);
		var content = document.getElementById("textAreaContent").value;
		var radio = $('input:radio[name=bbsType]').is(':checked'); //Boolean
		var radio_val = $('input:radio[name=bbsType]').value;
		var title = document.getElementById('title').value;
		
		if (!radio) {//라디오를 선택하지 않았을 경우
			alert("카테고리를 선택하세요.");
			$("#radio").focus();
			//이벤트일경우 기간설정 검사는 안만들어줌.
		} else if (title == "") {
			alert("프로젝트 제목을 작성하세요.");
			$("#title").focus();
		} else if (content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br />' || content == '<p>&nbsp;</p>') {
			alert("프로젝트 상세내용을 입력하세요.");
			oEditors.getById["textAreaContent"].exec("FOCUS"); //포커싱 return;
		} else {
			$("#frm").submit(); //폼id로 전송
			alert("신청완료 되었습니다.");
		}
	}
</script>

<script type="text/javascript">
	// 카테고리에 따라 기간row 생기기.
	$(document).ready(function() {
		$("input:radio[name=bbsType]").click(function() {
			var check = $(this).val();
			status = $("#hidden").css("display");
			if (check == "공지사항") {
				// alert("notice="+status);
				if (status == "table-row") {
					$("#hidden").css("display", "none");
				}
			} else if (check == "이벤트") {
				// alert("event"+status);
				if (status == "none") {
					$("#hidden").css("display", "table-row");
				}
			}
		})
	});
	
	// <!-- 날짜 설정 -->
	document.getElementById('Date1').value = new Date().toISOString().substring(0, 10);
	document.getElementById('Date2').value = new Date().toISOString().substring(0, 10);
	// ISO Standard() 형식으로 변환(YYYY-MM-dd HH:mm:ss) .substring(0, 10) 0부터 10까지 표시
</script>

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