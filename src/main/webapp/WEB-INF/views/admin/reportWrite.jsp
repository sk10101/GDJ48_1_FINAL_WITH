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
    	max-width: 300px;
    	width: 100%;
    	margin: 0 auto;
    }

    .content {
        display: inline-block;
        max-width: 300px;
        width: 100%;
        min-height: 100vh;
        /* padding: 50px 50px; */
        /* background-color: #f4f4f4; */
    }
    
    table {
    	margin: 0 auto;
    	margin-top: 50px;
    }
    
    table th input {
    	margin: 10px 0;
    }
    
    .bottom-button {
    	margin: 10px 10px;
    	border: none;
    	border-radius: 5px;
    	color: #eaeaea;
    	padding: 5px 10px;
    }
    
    .report-button {
 		background-color: #ef5350;
    }
    
    .back-button {
 		background-color: #537ef4;
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
	      			<th><input type="radio" id="chkId" name="check" value="음란성 게시글" checked/></th>
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
	      			<th><input type="radio" id="chkId" name="check" id="etc" value="기타" onClick="this.form.textbox.disabled=false"></th>
					<th>기타 &nbsp;<input type="text" id="textbox" name="textbox" disabled value="직접입력"></th> 
	      		</tr>
	      		<tr>
	      			<th colspan="2">
		      			<input class="bottom-button report-button" type="submit" id="send_button" value="신고"/>
		      			<input class="bottom-button back-button" type="button" id="test" value="닫기" onclick="windowclose()"/>
	      			</th>
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