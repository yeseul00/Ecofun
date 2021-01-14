<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- <link rel="stylesheet" href="./css/bootstrap.css">
    <link rel="stylesheet" href="./css/custom.min.css"> -->
	
    <div class="container" style="margin-top : 5%">
    <!-- 제목 -->
    <div style="margin-bottom: 5%;"><h3>|  비밀번호 확인</h3></div>
    
    <div class="container" >
        <!-- 설명 -->
         <div class="row" style="margin: 0 auto;">
                <div class="col-lg-9 col-sm-10" style="width: 200px; margin: 30px auto; text-align: center; font-size: larger;">
                    사용자 확인을 위해 비밀번호를 다시 한번 입력해주세요!
                </div>
            </div>
        <!-- 입력값 -->
        <form action="/pwCheck" method="post">
            <div class="row" style="margin:0 auto; padding: 10px 10px;">
                <input type="password" name="password" class="form-control col-lg-7 col-sm-7" style=" width: 100%; height: 50px; margin: 0px auto; display:flex; justify-content: center; border: lightgray solid 1px;" required>
            </div>
            <div class="row" style="margin:0 auto; padding: 10px 10px;">
                <input type="submit" class="col-lg-7 col-sm-7" value="확인" style=" width: 100%; height: 50px; margin: 0px auto; display:flex; justify-content: center; border: lightgray solid 1px;">
            </div>
        </form>
    </div> 
</div>