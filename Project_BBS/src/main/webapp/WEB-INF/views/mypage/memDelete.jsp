<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String memId = (String) session.getAttribute("memId");
%>
<!-- <link rel="stylesheet" href="css/bootstrap.css">
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
<style>
     /* *{
          border: red 1px solid;
     } */
</style>

<div class="container">
     <div style="margin-bottom: 7%;">
          <h6>| 회원 탈퇴</h6>
          <hr>
     </div>
     

     <div class="row" style="margin:0 auto; margin-bottom: 10%;">
          <div class="col-lg-12 col-sm-12">
               <div style="margin-bottom: 2%;"> <h5>회원 탈퇴 안내</h5> </div>
               <div style="margin-bottom: 3%;">
                   <ul>
                        <li style="list-style:none;">
                              <%= memId %> 후원자님! 지금까지 EcoFun Project를 이용해 주셔서 감사합니다.<br>
                              저희 페이지에 부족한 점이 있었다면 너그러운 양해 바라며, 아래의 사항을 확인하시고 진행해주세요.
                         </li>
                    </ul>
               </div>
         
          <div> <h5>회원 탈퇴시 꼭 확인해주세요!</h5> </div>
               <div>
                    <ul>
                         <li>사용하고 계신 아이디는 탈퇴할 경우 3개월 간 재사용이 불가능합니다.</li>
                         <li>탈퇴 이후 참여한 프로젝트 내역 등 이용기록이 모두 삭제됩니다.</li>
                    </ul>
               </div>
          </div>
     </div>
     

     <div class="upButtonWrap" role="group" aria-label="..." style="text-align: center;">
          <form action="">
               <input type="button" value="취소하기">
               <input type="button" value="삭제하기" id="mem_delete"/>
          </form>   
     </div>
</div>

<script>
$('#mem_delete').click( function(){
	$.ajax({
		type: "delete",
		url: "memDelete",
		success: function(data) {
			if (data > 0) {
				alert("삭제되었습니다. 감사합니다.");
				$(location).attr("href", "/");
			}
		},
		dataType: "text"
	});
});
</script>
