<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String memId = (String) session.getAttribute("memId");
String proState = (String) request.getAttribute("proState");
%>

<style>
table {
	width: 100%;
}

th, td {
	padding: 5px 0;
	text-align: center;
}

.mid-nav-list {
	margin: 0 auto;
	text-align: center;
	width: 97%;
	height: 50%;
}

.mid-nav-item {
	width: 50%;
	background-color: gray;
	margin-bottom: 0;
}

.mid-nav-item li {
	color: black;
	font-weight: 500;
}

.progress {
	margin: 0 auto;
}

.pro-content {
	width: 100%;
	padding: 7%;
	border: 3px solid lightgray;
	margin: 1px auto;
	text-align: center;
	border-radius: 15px;
}

.pro-content>div>h2 {
	color: white;
	line-height: 2;
}

#COMMENT {
	padding-bottom: 10px;
}

.sub-wrap {
	margin-bottom: 1%;
}

.btn {
	background-color: lightgray;
	border-top-left-radius: 0;
	border-bottom-left-radius: 0;
}
</style>

<script type="text/javascript">
function price() {
	$.ajax({
		url: "/price",
        type: "POST",
        data: {
            opNo: $('#opNo').val()
        },
        datatype : 'json',
        success: function (data) {
	        document.getElementById('totalPrice').value = document.getElementById('count').value * data.price;
        },
        error: function(){
        	alert("에러 발생");
        }
	});
}

const countDownTimer = function (id, date) {
	var _vDate = new Date(date); // 전달 받은 일자
	var _second = 1000; var _minute = _second * 60; var _hour = _minute * 60; var _day = _hour * 24; var timer;
	function showRemaining() {
		var now = new Date(); var distDt = _vDate - now;
		if (distDt < 0) {
			clearInterval(timer); document.getElementById(id).textContent = '해당 이벤트가 종료 되었습니다!'; return;
		}
		var days = Math.floor(distDt / _day); var hours = Math.floor((distDt % _day) / _hour); var minutes = Math.floor((distDt % _hour) / _minute); var seconds = Math.floor((distDt % _minute) / _second);
		//document.getElementById(id).textContent = date.toLocaleString() + "까지 : "; 
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

function saveLike() {
	$.ajax({
		url: "/like",
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
		url: "/deleteLike",
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

<div class="container" id="container">
	<!-- title -->
	<br>
	<div>
		<h5>| 프로젝트 상세</h5>
		<hr>
	</div>
	<br>

	<div>
		<div class="sub-wrap" style="display: flex;">
			<!-- 대표 이미지 -->
			<div class="col-xs-12 col-lg-6" style="background-image: url(${project.proThumb}); background-size: 100% 100%;"></div>

			<!-- 표 -->
			<div class="col-xs-12 col-lg-6">
				<form action="/orderForm" method="post" id="orderDetails">
					<input hidden="hidden" name="proType" value="${project.proType}" />
					<input hidden="hidden" name="proNo" value="${project.proNo}" />
					<table class="table-bordered">
						<tr>
							<td colspan="3">
								<h4 style="margin-top: 0">${project.proInfo}</h4>
							</td>
						</tr>
						<tr>
							<td colspan="2"><a href="/projectList?type=${project.proType}"><label class="badge">${project.proType}</label></a> <a><label class="badge">${project.proState}</label></a></td>
						</tr>
						<tr>
							<th><span>진행률</span></th>
							<td colspan="2">
								<p class="progress" style="width: 90%;">
									<span class="progress-bar" role="progressbar" aria-valuenow="${project.proceed}" aria-valuemin="0" aria-valuemax="100"
										style="width: ${project.proceed}%"> <span class="sm-only">${project.proceed}%</span>
									</span>
								</p>
							</td>
						</tr>
						<tr>
							<th>모인금액</th>
							<td><span>${project.proNow}원</span></td>
						</tr>
						<tr>
							<th><span>남은기간</span></th>
							<td><span id="remain"></span></td>
						</tr>
						<tr>
							<td><span>옵션</span></td>
							<td><select class="select" ID="opNo" name="opNo">
									<c:forEach var="option" items="${optionList}">
										<option value="${option.opNo}">${option.opName}(${option.price}원)</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td><span>수량</span></td>
							<td><input type="number" id="count" name="count" onchange="price()" value="0" min="0"></td>
						</tr>
						<tr>
							<td><span>총액</span></td>
							<td><input type="number" id="totalPrice" name="totalPrice" value="0" readonly="readonly" />원</td>
						</tr>

						<tr>
							<td colspan="2">
								<%
									if (proState.equals("종료")) {
								%>
								<button type="button" style="width: 90%;">종료</button> <%
 	} else {
 if (memId == null) {
 %>
								<button type="button" style="width: 90%;" onclick="changeView(1)">로그인</button> <%
 	} else {
 if (proState.equals("예정")) {
 %> <c:choose>
									<c:when test="${like == 0}">
										<button id="like" type="button" style="width: 90%;" onclick="saveLike()">즐겨찾기</button>
									</c:when>
									<c:otherwise>
										<button id="like" type="button" style="width: 90%;" onclick="deleteLike()">즐겨찾기 취소</button>
									</c:otherwise>
								</c:choose> <%
 	} else {
 %> <c:choose>
									<c:when test="${like == 0}">
										<button id="like" type="button" style="width: 40%;" onclick="saveLike()">즐겨찾기</button>
									</c:when>
									<c:otherwise>
										<button id="like" type="button" style="width: 40%;" onclick="deleteLike()">즐겨찾기 취소</button>
									</c:otherwise>
								</c:choose>
								<button type="button" style="width: 40%;" onclick="orderCheck()">결제하기</button> <%
 	}
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
	<nav class="row">
		<ul class="list-group list-group-horizontal mid-nav-list">
			<a class="list-group-item mid-nav-item" href="#STORY"><li>DETAIL</li></a>
			<a class="list-group-item mid-nav-item" href="#COMMENT"><li>COMMENT</li></a>
		</ul>
	</nav>
	<br>

	<div id="content">
		<!-- 내용 -->
		<div id="STORY" class="pro-content">
			<div style="width: 100%;">${project.proContent}</div>
		</div>

		<!-- 댓글 -->
		<div id="COMMENT" class="pro-content">
			<%--<div>
				<table border="1" style="width: 100%;">
					 <c:forEach var="comment" items="{commentList.content}">
	                              <tr>
	                                   <td style="width: 15%;"><span>${comment.proCmtMemNo}</span></td>
	                                   <td rowspan="2">${comment.proComment}</td>
	                              </tr>
	                              <tr>
	                                   <td>${comment.proCmtDate}</td>
	                              </tr>
	                         </c:forEach> 
				</table>
			</div>--%>

			<%
				if (memId == null) {
			%>
			<div style="width: 100%;">
				<div style="border: 1px solid black; border-radius: 5px; display: flex; vertical-align: middle;">
					<textarea name="proComment" rows="2" style="width: 80%; border: none; resize: none;" placeholder="로그인이 필요합니다."></textarea>
					<button type="button" style="width: 20%;" onclick="changeView(1)">등록</button>
				</div>
			</div>

			<%
				} else {
			%>
			<div style="width: 100%;">
				<form action="/commentInsert">
					<input hidden="hidden" name="proNo" value=${project.proNo } />
					<div style="border: 1px solid lightgray; border-radius: 5px; display: flex; vertical-align: middle;">
						<textarea name="proComment" rows="2" style="width: 80%; border: none; resize: none;"></textarea>
						<button type="submit" class="btn" style="width: 20%;">등록</button>
					</div>
				</form>
			</div>
			<!-- Pagination -->
			<%-- <div>
				<ul class="pagination justify-center" style="justify-content: center;">
					<c:if test="${!commentList.first}">
						<li class="page-item"><a href="?sort=proCmtNo,desc" class="page-link">&laquo;</a></li>
						<li class="page-item"><a href="?sort=proCmtNo,desc&page=${commentList.number - 1}" class="page-link">&lt;</a></li>
					</c:if>
					<c:set var="pageRange" scope="session" value="5" />
					<f:parseNumber var="pageIndex" integerOnly="true" value="${commentList.number div pageRange}" />
					<c:choose>
						<c:when test="${pageIndex * pageRange + pageRange > commentList.totalPages - 1}">
							<c:set var="lastPage" scope="session" value="${commentList.totalPages}" />
						</c:when>
						<c:otherwise>
							<c:set var="lastPage" scope="session" value="${pageIndex * pageRange + pageRange}" />
						</c:otherwise>
					</c:choose>
					<c:forEach var="i" begin="${pageIndex * pageRange + 1}" end="${lastPage}">
						<c:choose>
							<c:when test="${commentList.number + 1 == i}">
								<li class="page-item active"><a href="#" class="page-link"> <c:out value="${i}" /></a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a href="?sort=proNo,desc&page=${i - 1}" class="page-link"> <c:out value="${i}" /></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${!commentList.last}">
						<li class="page-item"><a href="?sort=proNo,desc&page=${commentList.number + 1}" class="page-link">&gt;</a></li>
						<li class="page-item"><a href="?sort=proNo,desc&page=${commentList.totalPages - 1}" class="page-link">&raquo;</a></li>
					</c:if>
				</ul>
			</div> --%>
			<%
				}
			%>
		</div>
	</div>
</div>