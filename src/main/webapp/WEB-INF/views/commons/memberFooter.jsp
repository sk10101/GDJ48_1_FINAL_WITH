<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
    .footer {
        margin: 0 auto;
        max-width: 1200px;
        width: 100%;
        height: 100px;
        background-color: #dedede;
        border-radius: 0 0 20px 20px;
    }

    .footer p {
        position: relative;
        text-align: center;
        transform: translate(-50%, -50%); /* 중심축 잡기 */
        left: 50%;
        top: 50%;
        font-size: 12px;
        letter-spacing: 1px;
        padding: 0px 30px;
        line-height: 25px;
        color: rgb(104, 104, 104);
    }

</style>
<body>
    <div class="footer">
        <p>Copyright 2022. With<br/>Designed by With<br/>All right reserved.</p>
    </div>
</body>
</html>