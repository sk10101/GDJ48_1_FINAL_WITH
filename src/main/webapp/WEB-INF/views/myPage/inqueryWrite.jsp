<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"> -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./resources/js/jquery.twbsPagination.js"></script>
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
        padding: 60px 100px;
    }
    
    .myinfo {
   		width: 70%;
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
    	border-collapse: collapse;
    }
    
    .myinfo th,td {
    	padding: 20px 15px;
    }
    
    #subject {
    	width: 80%;
    }
    
    input[type="text"] {
    	border-radius: 5px;
    	padding: 3px 5px;
    	border: 1px solid gray;
    }
    
    textarea {
	    width: 90%;
	    height: 400px;
	    border-radius: 5px;
	    padding: 3px 5px;
	    resize: none;
  	}
    
    .bottom-button {
   		margin: 10px 20px;
   		padding: 5px 20px;
   		border-radius: 5px;
   		border: none;
   		background-color: #537ef4;
   		color: #eaeaea;
   }
    
    
    
    
    
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <c:choose>
			<c:when test="${sessionScope.member_class eq 'μΌλ°νμ'}">
			   <jsp:include page="../commons/memberSideBar7.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq 'κ΄λ¦¬μ'}">
				<jsp:include page="../commons/adminSideBar7.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- μ¬κΈ°μμ μμ μμνμΈμ -->
	       <form action="inqueryWrite" method="POST">
	       	   <!-- <h2 style="text-align: center; font-weight: normal; color: rgb(88, 88, 88); margin-bottom: 30px;">λ¬Έμ μμ±</h2> -->
		       <table class="myinfo">
	            	<tr>
	            		<th>μ λͺ©</th>
	            		<td><input id="subject" type="text" name="subject" placeholder="50μ μ΄λ΄" maxlength="50" required/></td>
	            	</tr>
	            	<tr>
	            		<th>λ΄μ©</th>
	            		<td><textarea name="inquery_content" placeholder="500μ μ΄λ΄" maxlength="333" required></textarea></td>
	            	</tr>
	            	<tr>
	            		<th colspan="2">
				            <input class="bottom-button" type="submit" value="μ μ₯"/>
				            <input class="bottom-button" type="button" onclick="location.href='/inqueryList?page=1'" value="λμκ°κΈ°"/>
	            		</th>
	            	</tr>
	            </table>
	           	<input type="hidden" name="member_id" value="${sessionScope.loginId}"/>
            </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>