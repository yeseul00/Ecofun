<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
	<div class="row">
		<h4>
			|
			<a href="">게시판</a>
			> ${bbsNo.bbsType}
		</h4>
	</div>
	<hr>

	<!-- Detail -->
	<div class="row">
		<table class="table text-center">
			<tr class="thead-light">
				<th style="width: 10%;">${bbsNo.bbsNo}</th>
				<th style="width: 75%;">${bbsNo.bbsTitle}</th>
				<th class="d-none d-md-table-cell" style="width: 15%;">${bbsNo.bbsDate}</th>
			</tr>
			<tr>
				<td rowspan="15" colspan="15" style="width: 100%;">${bbsNo.bbsContent}</td>
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

	<div class="row text-center">
		<!-- <div class="col">
            <button>이전</button>
        </div> -->
		<div class="col">
			<a href="/boardList">
				<input type="Button" value="목록">
			</a>
		</div>
		<!-- <div class="col">
            <button>다음</button>
        </div>     -->
	</div>
</div>