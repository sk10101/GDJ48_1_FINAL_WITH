<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .sidebar {
        top: 100px;
        max-width: 160px;
        width: 100%;
        height: 100%;
        background-color: #2962ff;
        display: inline-block;
        position: fixed;
        border-radius: 0 0 0 20px;
        background-image: linear-gradient(#2962ff, #42a5f5);
    }

    .sidebar ul {
        position: relative;
        top: 10px;
    } 

    .sidebar li {
        position: relative;
        list-style: none;
        text-align: center;
        margin-top: 15px;
        transition: all 0.3s ease;
    }

    .sidebar li:nth-child(3) {
        background-color: #0026ca;
        font-weight: bold;
        color: #fff;
    }

    .sidebar li:nth-child(1):hover,
    li:nth-child(2):hover {
        transform: translateX(17px);
    }

    .sidebar li:nth-child(5):hover,
    li:nth-child(6):hover,
    li:nth-child(7):hover,
    li:nth-child(8):hover {
        background-color: #0026ca;
    }

    .sidebar li a {
        color: #eaeaea;
        text-decoration: none;
        font-size: 16px;
        display: block;
        height: 73px;
    }

    .sidebar li a.my {
        height: 50px;
        line-height: 50px;
    }

    .sidebar li .line {
        position: relative;
        background-color: #eaeaea;
        display: inline-block;
        height: 1px;
        width: 80%;
        top: -10px;
    }

    .sidebar ul li img {
        width: 40px;
        position: relative;
        top: 15px;
        right: 15px;
        z-index: 1;
    }

    .circle {
        background-color: #0026ca;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        position: absolute;
        left: 21px;
        top: 6px;
    }

</style>
   <div class="sidebar">
       <ul>
           <li><a href="#"><img src="./resources/images/delivery.png" alt="delivery"><div class="circle"></div>배달</a></li>
           <li><a href="#"><img src="./resources/images/taxi.png" alt="taxi"><div class="circle"></div>택시</a></li>
           <li><a href="#"><img class="eating" src="./resources/images/eating.png" alt="eating"><div class="circle"></div>식사</a></li>
           <li><div class="line"></div></li>
           <li><a class="my" href="#">내 정보</a></li>
           <li><a class="my" href="#">이용내역</a></li>
           <li><a class="my" href="#">차단 회원 관리</a></li>
           <li><a class="my" href="#">고객 문의</a></li>
       </ul>
   </div>