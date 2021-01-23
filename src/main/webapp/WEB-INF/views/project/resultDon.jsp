<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.OrderDto"%>
<%@ page import="com.study.springboot.dto.MemberDto"%>

<!-- <link rel="stylesheet" href="css/bootstrap.css"> -->

<style>
.sub-wrap {
	border-top: 1px darkgray solid;
	border-bottom: 1px darkgray solid;
	margin-bottom: 5%;
	width: 100%;
}

th, td {
	vertical-align: middle !Important;
	padding: 5px;
}

th {
	text-align: center;
	border-right: darkgray 3px solid;
	background-color: lightgray;
	border-right: darkgray 3px solid;
	width: 20%;
}
</style>

<%-- <%
Long memNo = (Long) session.getAttribute("memNo");
Long orderMemNo = ((OrderDto) request.getAttribute("order")).getMemNo();
if (memNo == null || memNo != orderMemNo) {
%>
alert("?섎せ??寃쎈줈濡??묎렐?섏뀲?듬땲??"); window.location = '/main';
<%
	} else {
%> --%>

<div class="container" id="container">
	<!-- title -->
	<br>
	<div>
		<h6>二쇰Ц 諛?寃곗젣</h6>
		<hr>
	</div>
	<br>


	<div>
		<h5>湲곕??꾨즺</h5>
		<div class="sub-wrap">
			<div>
				<strong>李몄뿬媛 ?꾨즺?섏뿀?듬땲?? "${project.proInfo}"??李몄뿬?댁＜?붿꽌 媛먯궗?⑸땲??</strong>
			</div>
			<div>李몄뿬 ?댁뿭? [留덉씠 ?섏씠吏 > ?꾨줈?앺듃 ?댁뿭]?먯꽌 ?ㅼ떆 ?뺤씤?????덉뒿?덈떎.</div>
		</div>
	</div>


	<!-- ?꾨줈?앺듃 ?뺣낫 -->
	<div>
		<h5>| 李몄뿬?뺣낫</h5>
		<div class="sub-wrap" style="display: flex;">
			<div class="col-lg-2"
				style="background-image: url('${project.proThumb}'); background-size: 100% 100%;"></div>
			<div class="col-lg-11" style="text-align: left;">
				<div class="pro" style="font-size: large; margin-bottom: 3%;">${project.proInfo}</div>
				<div class="col-lg-5" style="float: left; padding-left: 0;">${option.opName}</div>
				<div class="col-lg-3" style="float: right; text-align: right;">${order.price}??/div>
				<div class="col-lg-3" style="float: right; text-align: right;">${order.count}媛?/div>
				<div style="clear: both;"></div>
				<hr>
				<div class="col-lg-5" style="float: left; font-size: large;">
					<strong> 珥?湲덉븸 </strong>
				</div>
				<div class="col-lg-3" style="float: right; text-align: right;">
					<strong> ${order.totalPrice}??/strong>
				</div>
			</div>
		</div>
	</div>


	<!-- 湲곕????뺣낫 -->
	<div>
		<h5>| 李몄뿬???뺣낫</h5>
		<div class="sub-wrap">
			<table>
				<tr>
					<th>?대쫫</th>
					<td>${order.none}</td>
				</tr>
				<tr>
					<th>?곕씫泥?/th>
					<td>${member.memTel}</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 寃곗젣?뺤씤 -->
	<div>
		<h5>| 寃곗젣湲덉븸 /寃곗젣?섎떒 ?뺤씤</h5>
		<div class="sub-wrap">
			<table>
				<tr>
					<th>寃곗젣湲덉븸</th>
					<td>${order.totalPrice}??/td>
				</tr>
				<tr>
					<th>寃곗젣怨꾩쥖</th>
					<td><label class="payLabel">${order.bankName} /
							${order.accountNumber}</label></td>
				</tr>
				<tr>
					<th>寃곗젣?쇱떆</th>
					<td><label class="payLabel">${order.orderDate}</label></td>
				</tr>
			</table>
		</div>
	</div>

	<!-- ?섎떒 ?뺤씤 踰꾪듉 -->
	<div class="upButtonWrap" role="group" aria-label="..."
		style="text-align: center;">
		<button type="button" onclick="changeView(0)">?뺤씤</button>
	</div>
</div>