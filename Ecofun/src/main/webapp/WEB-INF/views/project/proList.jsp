<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	function filtering() {
		var state = $('#state').val();
		var type = $('#type').val();
		var sort = $('#sort').val();

		$.ajax({
			url : "list/filter",
			data : {
				state : state,
				type : type,
				sort : sort
			},
			type : "POST",
			dataType : "HTML",
			success : function(data) {
				$("#projectContent").html(data);
				$("#state").val(state).prop("selected", true);
				$("#type").val(type).prop("selected", true);
				$("#sort").val(sort).prop("selected", true);
				return false;
			},
			error : function(data) {
				alert('죄송합니다. 잠시 후 다시 시도해주세요.');
			}
		})
	}
</script>

<div class="container">
	<!-- Content-Header (프로젝트) -->
	<div class="row">
		<div class="col">
			<h5>| 프로젝트</h5>
		</div>
		<div class="col text-end">
			<span>진행 ${projectCount[4]}건</span>
			<span>| 기부 ${projectCount[5]}건</span>
			<span>| 펀딩 ${projectCount[6]}건</span>
		</div>
	</div>
	<hr>

	<div class="row">
		<!-- Filter -->
		<div class="col">
			<select class="btn btn-light filter" name="proState" id="state" onchange="filtering()">
				<option value="전체">상태(전체)</option>
				<option value="진행">진행</option>
				<option value="종료">종료</option>
				<option value="예정">예정</option>
			</select> <select class="btn btn-light filter" name="proType" id="type" onchange="filtering()">
				<option value="전체">분류(전체)</option>
				<option value="기부">기부</option>
				<option value="펀딩">펀딩</option>
			</select>
		</div>

		<!-- Sort -->
		<div class="col" style="text-align: right;">
			<select class="btn btn-light filter" id="sort" onchange="filtering()">
				<option value="proStart" selected>최근등록순</option>
				<option value="proHit">참여인원순</option>
				<option value="proNow">모집액순</option>
			</select>
		</div>
	</div>
	<br>

	<div id="projectContent">
		<jsp:include page="proContent.jsp" />
	</div>
</div>