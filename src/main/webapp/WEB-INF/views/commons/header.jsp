<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
        font-family: 'Noto Sans KR', sans-serif;
    }

   	.main {
        max-width: 1200px;
        width: 100%;
        margin: 0 auto;
    }

    .navbar-top-bg {
        position: fixed;
        max-width: 1200px;
        width: 100%;
        max-height: 100px;
        height: 100%;
        background-color: #fff;
    }

    .navbar-top {
        max-width: 1200px;
        width: 100%;
        max-height: 100px;
        height: 100%;
        background-color: #f3f3f3;
        border-radius: 20px 20px 0 0;
        position: fixed;
        z-index: 100;
    }

    .navbar-top .logo {
        margin-top: 20px;
        margin-left: 20px;
        width: 110px;
    }

/*     .navbar-top .dot {
        width: 40px;
        position: absolute;
        right: 30px;
        top: 45px;
    }

    .navbar-top .bell {
        position: absolute;
        z-index: 1;
        width: 27px;
        right: 25px;
        top: 60px;
    } */

    .navbar-top p {
        float: right;
        margin-right: 20px;
        margin-top: 10px;
        font-size: 14px;
    }

    .navbar-top p a {
        text-decoration: none;
        color: rgb(104, 104, 104);
    }
    
    .gender {
    	position:relative;
    	width: 35px;
    	top: 13px;
    	right: 10px;
    }

</style>
	<div class="main">
	    <div class="navbar-top-bg"></div>
	    <div class="navbar-top">
	    	<c:choose>
				<c:when test="${sessionScope.member_class eq '일반회원'}">
				   	<a href="/main"><img class="logo" src="./resources/images/logo.png" alt="logo"></a>
				</c:when>
				<c:when test="${sessionScope.member_class eq '관리자'}">
					<a href="/userList.go"><img class="logo" src="./resources/images/logo.png" alt="logo"></a>
				</c:when>
			</c:choose>
            <p>
            	<c:if test="${sessionScope.member_class eq '일반회원'}">
            		<a href="/myInfo">
            	</c:if>	
            	<c:if test="${sessionScope.member_class eq '관리자'}">
            		<a href="#">
            	</c:if>
		            <c:if test="${sessionScope.gender eq '남자'}">
		            	<img class="gender" src="./resources/images/man.png" alt="man">
		            </c:if>	
		            <c:if test="${sessionScope.gender eq '여자'}">
		            	<img class="gender" src="./resources/images/girl.png" alt="girl">
		            </c:if>	
            		${sessionScope.loginId}(${sessionScope.member_class}) 님 환영합니다.
            	</a>
            	 &nbsp; | &nbsp; <a href="logout">로그아웃</a>
            </p>
	        <!-- <a href="#"><img class="bell" src="./resources/images/bell.png" alt="bell"></a>
	        <img class="dot" src="./resources/images/dot.png" alt="dot"> -->
	    </div>
    </div>