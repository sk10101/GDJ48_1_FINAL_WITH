<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
</head>
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
        min-height: 100vh;
        margin: 0 auto;
        background-color: rgb(249, 249, 249);
        border-radius: 20px 20px 0 0;
    }

    div.logo {
        display: inline-block;
        position: absolute;
        transform: translate(-50%, -50%);
        left: 50%;
        top: 100px;
    }

    div.logo img {
        width: 140px;
    }

    .content {
        display: inline-block;
        max-width: 400px;
        width: 100%;
        min-height: 500px;
        margin-left: 400px;
        margin-top: 170px;
        border-radius: 20px;
        /* background-color: #f4f4f4; */
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        padding: 30px 30px;
    }
    
    #title {
    	text-align: center;
    	color: rgb(88, 88, 88);
    	font-size: 20px;
    }
    
    table {
    	margin: 0 auto;
    	color: rgb(88, 88, 88);
    	margin-top: 50px;
    }
    
    td, th {
    	padding: 10px 10px;
    }
    
    table tr:last-child td {
		padding-top: 30px;
		text-align: center;
	}
	
	.FindBtn {
		padding: 5px 10px;
		border: none;
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		transition: all 0.3s ease;
		margin: 0 10px;
	}
	
	.FindBtn:hover {
		background-color: #004ecb;
		transform: scale(1.05);
	}
	
	input[type='password'] {
		padding: 3px 10px;
		border-radius: 5px;
		border: 0.3px solid gray;
	}

</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="./resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
            <!-- ???????????? ?????? ??????????????? -->
            <h2>???????????? ?????????</h2><br>
     <form action="newPw" id="test" method="POST">
		<table>
			<tr>
				<th>????????????</th>
				<td>
					<input type="hidden" name="id" id="id" value="${id}"/>
					<input type="password" name="pw" id="pw" required="required"/>
				</td>
			</tr>	
			<tr>
				<th>??????????????????</th>
				<td>
					<p><input type="password" name="pw1" id="pw1" required="required"/><font id="chkNotice" size="2"></font></p>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><br>
					<button class="FindBtn" type="button" onclick="save(); return false;">??????</button>
					<button class="FindBtn" type="button" onclick="location.href='/'" >????????????</button>
				</td>
			</tr>
		</table>
	</form>
     	</div>
    	</div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
//???????????? ?????? ????????? ?????? ????????? ???????????????
$(function(){
    $('#pw1').keyup(function(){
		
        if($('#pw').val() == $('#pw1').val()){
        	$("#chkNotice").html(' ?????????');
            $("#chkNotice").css('color','blue');
        } else{
          $("#chkNotice").html(' ????????????');
          $("#chkNotice").css('color','red');
        }
    });
});


function save() {
	   if ($("#pw").val() != $("#pw1").val()) {
		      alert("??????????????? ???????????? ????????????.");
		      $("#pw2").focus();
		    
		      return false;
		      }
	    if (confirm("?????????????????????????")) {
		    
	 	   $("#test").submit();
	 	    
	 	      return false;
	 	      }
}
</script>
</html>