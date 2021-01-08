<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
	<!-- Content-Header (건의 내역) -->
	<div class="row">
		<%
			String id = (String) session.getAttribute("memId");
		if (id != null && id.equals("admin")) {
		%>
		<div class="col">
			<h6>| <a href="/adSuggestList">문의 및 신청</a> > 문의
			</h6>
		</div>
		<%
			} else {
		%>
		<div class="col">
			<h6>| <a href="/mySuggestList">문의 및 신청</a> > 문의
			</h6>
		</div>
		<%
			}
		%>
	</div>
	<hr>

	<!-- Detail -->
	<div class="row">
		<fmt:parseDate value="${ask.askDate}" var="dateValue" pattern="yyyy-MM-dd'T'HH:mm" />
		<table class="table">
			<tr class="thead-light">
				<th style="width: 10%;">${ask.askNo}</th>
				<th style="width: 65%;">${ask.askTitle}</th>
				<th class="d-none d-md-table-cell" style="width: 10%;">${ask.askState}</th>
				<th class="d-none d-md-table-cell" style="width: 15%;">
					<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd'<br>'HH:mm" />
				</th>
			</tr>
			<tr>
				<td colspan="4" style="width: 100%;">${ask.askContent}</td>
			</tr>
			<%--   <tr>
                    <td>관리자</td>
                    <td>
                        ${ask.askReply}
                    </td>
                    <td></td>
                    <td>${ask.askDate}</td>
                </tr> --%>
		</table>
	</div>
	<br>

	<!-- 목록으로 -->
	<div class="row text-center">
		<%
			if (id != null && id.equals("admin")) {
		%>
		<div class="col">
			<a href="/adSuggestList"> <input type="button" value="목록으로">
			</a>
		</div>
		<%
			} else {
		%>
		<div class="col">
			<a href="/mySuggestList"> <input type="button" value="목록으로">
			</a>
		</div>
		<%
			}
		%>
	</div>
</div>