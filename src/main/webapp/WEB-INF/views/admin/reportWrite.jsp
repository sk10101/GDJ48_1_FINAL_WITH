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
    .content-wrap {
    	max-width: 1200px;
    	width: 100%;
    	margin: 0 auto;
    }

    .content {
        display: inline-block;
        margin-left: 160px;
        margin-top: 100px;
        max-width: 1040px;
        width: 100%;
        min-height: 100vh;
        /* background-color: #f4f4f4; */
        background-color: rgb(249, 249, 249);
    }
</style>
<body>
	<div class="content-wrap">
	   <div class="content">
	      <form action="reportsend" id="send" method="get">
	      	<table>
	      		<tr>
	      			<input type ="hidden" id ="board_idx" name = "board_idx" value = "${param.board_idx}"/>
	      		</tr>
	      		<tr>
	      			<th><input type="radio" id="chkId" name="check" value="음란성 게시글"/></th>
	      			<th>음란성 게시글</th>
	      		</tr>
	      		<tr>
	      			<th><input type="radio" id="chkId" name="check" value="광고성 게시글"/></th>
	      			<th>광고성 게시글</th>
	      		</tr>
	      		<tr>
	      			<th><input type="radio" id="chkId" name="check" value="도배 게시글"/></th>
	      			<th>도배 게시글</th>
	      		</tr>
	      		<tr>
	      			<th><input type="radio" id="chkId" name="check" value="욕설 게시글"/></th>
	      			<th>욕설 게시글</th>
	      		</tr>
	      		<tr>
	      			<th><input type="radio" id="chkId" name="check" id="etc" value="기타" onClick="this.form.textbox.disabled=false">기타</th>
					<th><input type="text" id="textbox" name="textbox" disabled value="직접입력"></th> 
	      		</tr>
	      		<tr>
	      			<th><input type="submit" id="send_button" value="신고"/></th>
	      			<th><input type="button" id="test" value="닫기" onclick="windowclose()"/></th>
	      		</tr>
	       	</table>	
	     </form>
	   </div>
	</div>
</body>
<script>
/* var msg = "${msg}"
if (msg != "") {
alert(msg);
} */
	
function windowclose(){
	window.close();
}

$("#send_button").click(function(){
	$("#send").submit()
	setTimeout(function() {
		window.close();
	 }, 10);
});

</script>
</html>