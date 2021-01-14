<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="container" id="container">
	<!-- Content-Header (공지사항) -->
	<div class="row">
		<div class="col">
			<h5>
				| <a href="boardList">게시판</a> > ${bbsNo.bbsType}
			</h5>
		</div>
	</div>
	<hr>
  
	<!-- Detail -->
	<div class="row">
		<table class="table"
			style="width: 100%; text-align: center; padding: 0;">
			<tr class="thead-light">
				<th style="width: 10%;">${bbsNo.bbsNo}</th>
				<th style="width: 75%;">${bbsNo.bbsTitle}</th>
				<th class="d-none d-md-table-cell" style="width: 15%;">${bbsNo.bbsStart}</th>
			</tr>
			<tr>
				<td rowspan="15" colspan="15" style="width: 100%;">
					${bbsNo.bbsContent}</td>
			</tr>
			<%-- <tr class="bg-light">
                <td>Next</td>
                <td><a href="">${bbsNo.bbsNo+1}</a></td>
                <td class="d-none d-md-table-cell">{bbsNo+1.BDate}</td>
            </tr>
            <tr class="bg-light">
                <td>Prev</td>
                <td><a href="">{BTitle}</a></td>
                <td class="d-none d-md-table-cell">{BDate}</td>
            </tr> --%>
		</table>
	</div>
	<br>

	<div class="row" style="text-align: center;">
		<!-- <div class="col">
            <button>이전</button>
        </div> -->
		<div class="col">
			<a href="/boardList"><input type="Button" value="목록"></a>
		</div>
		<!-- <div class="col">
            <button>다음</button>
        </div>     -->
	</div>

</div>
<!-- <script src="js/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script> -->