<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .footer-wrap {
        margin: 0 auto;
        max-width: 1200px;
        width: 100%;
    }

    .footer {
        position: relative;
        max-width: 1040px;
        width: 100%;
        height: 100px;
        margin-left: 160px;
        background-color: #dedede;
        border-radius: 0 0 20px 0;
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
    <div class="footer-wrap">
        <div class="footer">
            <p>Copyright 2022. With<br/>Designed by With<br/>All right reserved.</p>
        </div>
    </div>
<script>
    // 아래 코드는 지우지 마세요
/* 	$(".sidebar").css("height", (
		$(".content").height() + 
		parseInt($(".content").css("padding-top")) +
		parseInt($(".content").css("padding-bottom")) + 
		$(".footer").height())
	); */
</script>
