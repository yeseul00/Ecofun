<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- <link rel="stylesheet" href="css/bootstrap.css"> -->

<body>
	<div class="container" style="margin-top:5%;">
		<!-- Content-Header (건의 내역 > 신청 > 상세) -->
		<div class="row">
		<%	
        	String id = (String) session.getAttribute("memId");
			if (id != null && id.equals("admin")) {
		%>
		  	<div class="col">
                <h6>| <a href="/adSuggestList">문의 및 신청</a> > 프로그램 신청 상세</h6>
            </div>
			
		<%
			}else{  
		%>
       		  <div class="col">
				<h6>
					| <a href="/mySuggestList">문의 및 신청</a> > 프로그램 신청 상세
				</h6>
			</div>
        <%  } %>
			
		</div>
		<hr>
		

		<!-- Detail -->
		<div class="row">
		 <fmt:parseDate value="${req.reqDate}" var="dateValue" pattern="yyyy-MM-dd'T'HH:mm" />
			<table class="table" style="width: 100%; text-align: center; padding: 0;">
				<tr class="thead-light">
					<th style="width: 10%;">${req.reqNo}</th>
					<th style="width: 65%;">${req.reqTitle}</th>
					<th class="d-none d-md-table-cell" style="width: 10%;">검토중</th>
					<th class="d-none d-md-table-cell" style="width: 15%;">
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd'<br>'HH:mm" />
					</th>
				</tr>
				<tr >
					<td colspan="15"style="width:100%; margin-bottom:30%;">  
					${req.reqContent}
					</td>
				</tr>
				
				<!-- <tr>
					<td>관리자</td>
					<td colspan="13">{req.reqsReply}</td>
					<td></td> 
					<td>{req.reqsDate}</td>
				</tr> -->
				<!-- <tr class="bg-light">
					<td>Next</td>
					<td><a href="">{mpaTitle}</a></td>
					<td class="d-none d-md-table-cell">{mpaState}</td>
					<td class="d-none d-md-table-cell">{mpaDate}</td>
				</tr>
				<tr class="bg-light">
					<td>Prev</td>
					<td><a href="">{mpaTitle}</a></td>
					<td class="d-none d-md-table-cell">{mpaState}</td>
					<td class="d-none d-md-table-cell">{mpaDate}</td>
				</tr> -->
			</table>
		</div>
		<br>

		<div class="row" style="text-align: center;">
			<%	
        	if (id != null && id.equals("admin")) {
			%>
		  	<div class="col">
               <a href="/adSuggestList"><input type="button" value="목록으로"></a>
            </div>
			
		<%
			}else{  
		%>
       		 <div class="col">
			<a href="/mySuggestList"><input type="button" value="목록으로"></a>
			</div>
        <%  } %>
			
		</div>
	</div>
</body>