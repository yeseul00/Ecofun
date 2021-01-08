<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	Long memNo = (Long) session.getAttribute("memNo");
String memId = (String) session.getAttribute("memId");
String proState = (String) request.getAttribute("proState");
%>

<script type="text/javascript">
const countDownTimer = function (id, date) {
	var _vDate = new Date(date);
	var _second = 1000; var _minute = _second * 60; var _hour = _minute * 60; var _day = _hour * 24; var timer;
	function showRemaining() {
		var now = new Date(); var distDt = _vDate - now;
		if (distDt < 0) {
			clearInterval(timer); document.getElementById(id).textContent = '해당 프로젝트는 종료 되었습니다!'; return;
		}
		var days = Math.floor(distDt / _day); var hours = Math.floor((distDt % _day) / _hour); var minutes = Math.floor((distDt % _hour) / _minute); var seconds = Math.floor((distDt % _minute) / _second); 
		document.getElementById(id).textContent = days + '일 '; 
		document.getElementById(id).textContent += hours + '시간 '; 
		document.getElementById(id).textContent += minutes + '분 '; 
		document.getElementById(id).textContent += seconds + '초';
	}
	timer = setInterval(showRemaining, 1000);
}
var dateObj = new Date();
dateObj.setDate(dateObj.getDate() + 1);
countDownTimer('remain', '${project.proEnd}');

function price() {
	$.ajax({
		url: "detail/price",
        type: "POST",
        data: {
            opNo: $('#opNo').val()
        },
        datatype : 'json',
        success: function (result) {
        	document.getElementById('totalPrice').value = $('#count').val() * result.price;
        },
        error: function(){
        	alert("에러 발생");
        }
	});
}

function saveLike() {
	$.ajax({
		url: "detail/like",
		type: "POST",
		dataType: "json",
		data: {
			proNo: ${project.proNo}
		},
		success: function(data) {
			if (data.proNo > 0) {
				$("#like").html("즐겨찾기 취소");
				$("#like").attr("onclick", "deleteLike()");
				alert("좋아한 프로젝트 목록에 추가되었습니다.");
			}
		},
		error: function() {
			alert("에러 발생");
		}
	});
}

function deleteLike() {
	$.ajax({
		url: "detail/unlike",
		type: "POST",
		dataType: "text",
		data: {
			proNo: ${project.proNo}
		},
		success: function(data) {
			if (data > 0) {
				$("#like").html("즐겨찾기");
				$("#like").attr("onclick", "saveLike()");
				alert("좋아한 프로젝트 목록에서 삭제되었습니다.");
			}
		},
		error: function() {
			alert("에러 발생");
		}
	});
}

function orderCheck() {    
	if($("#totalPrice").val() == 0){
		alert("하나 이상의 수량을 선택해주세요.");
		return false;
	} else {
		$('#orderDetails').submit();
	}   
}
</script>

<div class="container">
	<br>
	<div>
		<h4>| <a href="/project/list">프로젝트</a> > 상세
		</h4>
	</div>
	<hr>
	<br>

	<div>
		<div class="d-flex-wrap">
			<!-- 대표 이미지 -->
			<div class="col-12 col-lg-6 border" style="background-image: url('${project.proThumb}'); background-size: 100% 100%;">
				<img src="https://place-hold.it/588x341/FFFFFF/C0C0C0.png&text=Ecofun&fontsize=10" alt="이미지" class="hidden" />
			</div>

			<!-- 표 -->
			<div class="col-12 col-lg-6">
				<form action="/project/orderForm" method="post" id="orderDetails">
					<input hidden="hidden" name="proType" value="${project.proType}" />
					<input hidden="hidden" name="proNo" value="${project.proNo}" />
					<table class="table-bordered">
						<tr>
							<td colspan="3" class="fs-5">
								<b>${project.proTitle}</b>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<a href="/project/list?type=${project.proType}"> <label class="badge">${project.proType}</label>
								</a> <a> <label class="badge">${project.proState}</label>
								</a>
							</td>
						</tr>
						<tr>
							<th class="col-3">
								<span>진행률</span>
							</th>
							<td colspan="2">
								<p class="progress" style="width: 90%;">
									<span class="progress-bar" role="progressbar" aria-valuenow="${project.proceed}" aria-valuemin="0" aria-valuemax="100"
										style="width: ${project.proceed}%"
									> </span>
									${project.proceed}%
								</p>
							</td>
						</tr>
						<tr>
							<th>모인금액</th>
							<td>
								<span>${project.proNow}원</span>
							</td>
						</tr>
						<tr>
							<th>
								<span>남은기간</span>
							</th>
							<td>
								<span id="remain"></span>
							</td>
						</tr>
						<tr>
							<th>
								<span>옵션</span>
							</th>
							<td>
								<select class="select" ID="opNo" name="opNo" style="width: 90%;">
									<c:forEach var="option" items="${optionList}">
										<option value="${option.opNo}">${option.opName}(${option.price}원)</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>
								<span>수량</span>
							</th>
							<td>
								<input type="number" id="count" name="count" onchange="price()" value="0" min="0" />
								개
							</td>
						</tr>
						<tr>
							<th>
								<span>총액</span>
							</th>
							<td>
								<input type="number" id="totalPrice" name="totalPrice" value="0" readonly="readonly" />
								원
							</td>
						</tr>

						<tr>
							<td colspan="2">
								<%
									if (proState.equals("종료")) {
								%>
								<button type="button" style="width: 90%;">종료</button>
								<%
									} else if (proState.equals("예정")) {
								%>
								<c:choose>
									<c:when test="${like == 0}">
										<button id="like" type="button" style="width: 90%;" onclick="saveLike()">즐겨찾기</button>
									</c:when>
									<c:otherwise>
										<button id="like" type="button" style="width: 90%;" onclick="deleteLike()">즐겨찾기 취소</button>
									</c:otherwise>
								</c:choose>
								<%
									} else {
								if (memId == null) {
								%>
								<button type="button" style="width: 90%;" onclick="changeView(1)">로그인</button>
								<%
									} else {
								%>
								<c:choose>
									<c:when test="${like == 0}">
										<button id="like" type="button" style="width: 40%;" onclick="saveLike()">즐겨찾기</button>
									</c:when>
									<c:otherwise>
										<button id="like" type="button" style="width: 40%;" onclick="deleteLike()">즐겨찾기 취소</button>
									</c:otherwise>
								</c:choose>
								<button type="button" style="width: 40%;" onclick="orderCheck()">결제하기</button>
								<%
									}
								}
								%>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<br>

	<!-- 중간 탭(STORY|COMMENT) -->
	<nav class="navbar navbar-dark bg-dark">
		<div class="navbar-nav" style="width: 50%; border-right: 1px solid white;">
			<a class="nav-link" href="#STORY">STORY</a>
		</div>
		<div class="navbar-nav" style="width: 50%; border-left: 1px solid white;">
			<a class="nav-link" href="#COMMENT">COMMENT</a>
		</div>
	</nav>
	<br>

	<div id="content">
		<!-- 내용 -->
		<article id="STORY" class="project-content">
			<div></div>
			<div style="width: 100%;">${project.proContent}</div>
		</article>

		<!-- 댓글 -->
		<div id="COMMENT" class="project-content">
			<ul>
				<%
					if (memId == null) {
				%>
				<li>
					<div class="d-flex">
						<textarea class="col-10" rows="2" style="resize: none;" placeholder="로그인이 필요합니다."></textarea>
						<button type="button" class="col-2 btn-outline" onclick="changeView(1)">등록</button>
					</div>
				</li>
				<%
					} else {
				%>
				<li>
					<form action="/project/commentInsert" class="d-flex" method="get">
						<textarea name="comment" rows="2" class="col-10" style="resize: none;"></textarea>
						<button type="submit" class="col-2 btn btn-primary">등록</button>
						<input class="hidden" name="proNo" value="${project.proNo}" />
						<input class="hidden" name="cmtMemNo" value="<%=memNo%>" />
					</form>
				</li>
				<%
					}
				%>
				<c:if test="${cmtList!=null}">
					<c:forEach items="${cmtList.content}" var="cmtDto" varStatus="cmt">
						<li class="project-comment-list">
							<div class="col-3">
								<b>${memList[cmt.index].memName}</b> <br>
							</div>
							<div class="col-6">${cmtDto.comment}</div>
							<div class="col-3">${cmtDto.cmtDate}</div>
						</li>
					</c:forEach>
				</c:if>
				<li>
					<!-- Pagination -->
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${!cmtList.first}">
								<li class="page-item">
									<a href="?sort=cmtNo,desc" class="page-link">&laquo;</a>
								</li>
								<li class="page-item">
									<a href="?sort=cmtNo,desc&page=${cmtList.number - 1}" class="page-link">&lt;</a>
								</li>
							</c:if>
							<c:set var="pageRange" scope="session" value="5" />
							<f:parseNumber var="pageIndex" integerOnly="true" value="${cmtList.number div pageRange}" />
							<c:choose>
								<c:when test="${pageIndex * pageRange + pageRange > cmtList.totalPages - 1}">
									<c:set var="lastPage" scope="session" value="${cmtList.totalPages}" />
								</c:when>
								<c:otherwise>
									<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
								</c:otherwise>
							</c:choose>
							<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
								<c:choose>
									<c:when test="${cmtList.number + 1 == i}">
										<li class="page-item active">
											<a href="#" class="page-link"> <c:out value="${i}" /></a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a href="?sort=proNo,desc&page=${i - 1}" class="page-link"> <c:out value="${i}" /></a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${!cmtList.last}">
								<li class="page-item">
									<a href="?sort=proNo,desc&page=${cmtList.number + 1}" class="page-link">&gt;</a>
								</li>
								<li class="page-item">
									<a href="?sort=proNo,desc&page=${cmtList.totalPages - 1}" class="page-link">&raquo;</a>
								</li>
							</c:if>
						</ul>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>