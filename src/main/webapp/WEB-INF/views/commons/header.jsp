<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
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

    .navbar-top .dot {
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
    }

    .navbar-top p {
        float: right;
        margin-top: 20px;
        margin-right: 20px;
        font-size: 14px;
    }

    .navbar-top p a {
        text-decoration: none;
        color: rgb(104, 104, 104);
    }

</style>
	<div class="main">
	    <div class="navbar-top-bg"></div>
	    <div class="navbar-top">
	        <a href="#"><img class="logo" src="./resources/images/logo.png" alt="logo"></a>
	        <p><a href="#">${sessionScope.loginId}(${sessionScope.member_class}) 님 환영합니다.</a> &nbsp; | &nbsp; <a href="logout">로그아웃</a></p>
	        <a href="#"><img class="bell" src="./resources/images/bell.png" alt="bell"></a>
	        <img class="dot" src="./resources/images/dot.png" alt="dot">
	    </div>
    </div>