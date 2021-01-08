<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="../../../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<style>
input {
	display: inline !important;
}

#option_table {
	border: none;
}

.category {
	margin-left: 10%;
	margin-right: 10%;
}

.opt_price {
	width: 75%;
	margin-right: 5px;
}
</style>

<div class="container">
	<div>
		<h4>| <a href="/admin/projectList">프로젝트 관리</a> > 게시
		</h4>
		<hr>
	</div>
	<br>

	<div>
		<form action="/admin/projectInsert" method="post" enctype="multipart/form-data">
			<input hidden="hidden" name="proceed" value="0" />
			<input hidden="hidden" name="proHit" value="0" />

			<!-- 기본 정보 -->
			<div>
				<div>
					<h5>기본 정보</h5>
				</div>
				<div>
					<table class="table">
						<tr>
							<th style="width: 20%;">카테고리</th>
							<td>
								<label class="category">
									<input type="radio" name="proType" value="기부" required>
									기부
								</label>
								<label class="category">
									<input type="radio" name="proType" value="펀딩">
									펀딩
								</label>
							</td>
						</tr>
						<tr>
							<th>주최자</th>
							<td>
								<input class="member-search" type="search" name="memId" placeholder="주최자 아이디" style="width: 100%;" required>
								<div id="member-search-result"></div>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" name="proTitle" id="proTitle" class="form-control" style="width: 100%;" required>
							</td>
						</tr>
						<tr>
							<th>기간</th>
							<td>
								<input type="date" id="Date1" class="col-5" name="proStart" onchange="check_date1();" />
								<label class="col-2 text-center">~</label>
								<input type="date" id="Date2" class="col-5" name="proEnd" onchange="check_date2();" required />
							</td>
						</tr>
						<tr>
							<th>목표금액</th>
							<td>
								<input type="number" name="proTarget" class="col-6 text-end" required />
								<label style="width: 10%;">원</label>
							</td>
						</tr>
						<tr>
							<th>옵션</th>
							<td>
								<table>
									<thead id="option_table">
										<tr>
											<th style="width: 10%;">번호</th>
											<th style="width: 50%;">옵션명</th>
											<th style="width: 30%;">가격</th>
											<th style="width: 10%;">수</th>
										</tr>
									</thead>
									<tbody id="item_option_wrap">
										<tr>
											<td id="count">1</td>
											<td>
												<input type="text" class="form-control" name="opName" required />
											</td>
											<td>
												<input type="number" class="form-control opt_price" name="price" required />
												원
											</td>
											<td>
												<a href="javascript:;" onclick="add_option();">+</a>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th>썸네일</th>
							<td>
								<input type="file" name="fileName" id="proThumb" accept="image/*" required>
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
					<textarea name="proContent" id="textAreaContent" style="width: 100%; height: 350px;"></textarea>
				</div>
			</div>
			<br>

			<!-- 신청/취소 -->
			<div style="text-align: center;">
				<button type="button" style="width: 15%;" onclick="history.back()">취소</button>
				<button type="button" style="width: 15%;" onclick="submitContents(this)">게시</button>
			</div>
		</form>
	</div>
</div>


<!-- 주최자 -->
<script>
	$(function() {
		$('.member-search').keyup(function() {
			if ($(this).val().length > 0) {
				$('#member-search-result').empty();
				$.ajax({
					type : "GET",
					url : "/admin/memberSearch/" + $(this).val(),
					dataType : "json",
					success : function(data) {
						for (var i = 0; i < data.length; i++) {
							$('#member-search-result').append("<a href=\"javascript:select('" + data[i].memId + "')\">" + data[i].memId + "</a><br>")
						}
					}
				});
			}
		});
	});
	function select(selectedKeyword) {
		$('.member-search').val(selectedKeyword);
		$('#member-search-result').empty();
	}
</script>

<!-- 기간 -->
<script type="text/javascript">
	document.getElementById('Date1').value = new Date().toISOString().substring(0, 10);
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

<!-- 옵션 -->
<script type="text/javascript">
	function add_option() {
		var re = document.getElementById('item_option_wrap');
		if (re.rows.length < 5) {
			var count = (re.rows.length) + 1;
			$('#item_option_wrap')
				.append('<tr><td>' + count + '</td><td><input type="text" class="form-control" name="opName"></td><td><input type="number" class="form-control opt_price" name="price">원</td><td><span><a href="javascript:;" onclick="add_option();">+</a></span><span style="float: right;"><a href="javascript:;" onclick="remove_option();">-</a></span></td></tr> ');
		} else {
			alert("옵션은 최대 5개까지 추가 가능합니다.")
		}
	}
	function remove_option() {
		var re = document.getElementById('item_option_wrap');
		if (re.rows.length < 1) return;
		re.deleteRow(re.rows.length - 1);
	}
</script>

<!-- 에디터 -->
<script>
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "textAreaContent",
		sSkinURI : "../../../se2/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,
			bUseVerticalResizer : true,
			bUseModeChanger : true,
			fOnBeforeUnload : function() {}
		},
		fCreator : "createSEditor2"
	});

	function pasteHTML(filepath) {
		var sHTML = '<img src= "../../../se2/upload/' + filepath + '">';
		oEditors.getById["textAreaContent"].exec("PASTE_HTML", [
			sHTML
		]);
	}

	function submitContents(elClickedObj) {
		oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);

		if ($('#proTitle').val() == "") {
			alert("제목을 입력하세요.");
			$("#proTitle").focus();
			return;
		}

		if ($('#textAreaContent').val() == "") {
			alert("상세 설명을 입력하세요.");
			oEditors.getById["textAreaContent"].exec("FOCUS");
			return false;
		}

		if ($('#proThumb').val() == "") {
			alert("썸네일을 등록하세요.");
			$("#proThumb").focus();
			return false;
		}

		try {
			elClickedObj.form.submit();
			alert("프로젝트를 등록하였습니다.");
		} catch (e) {}
	}
</script>