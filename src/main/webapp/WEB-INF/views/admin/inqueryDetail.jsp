<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
    
    .myinfo th {
    	max-width: 100px;
    }
    
    input[type="text"] {
    	border-radius: 5px;
    	padding: 3px 5px;
    	border: 1px solid gray;
    	font-size: 14px;
    }
    
    .textarea {
	    width: 90%;
	    height: 200px;
	    border-radius: 5px;
	    padding: 3px 5px;
	    resize: none;
	    font-size: 14px;
  	}
  	
   .bottom-button {
   		margin: 20px 20px;
   		padding: 7px 20px;
   		border-radius: 5px;
   		border: none;
   		background-color: #537ef4;
   		color: #eaeaea;
   }
   
   #button-wrap {
   		text-align: center;
   		margin-top: 40px;
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
	     	<table class="myinfo">
	            	<tr>
	            		<th>μμ±μ</th>
	            		<td>${map.member_id}</td>
	            	</tr>
	            	<tr>
	            		<th>μ λͺ©</th>
	            		<td>${map.subject}</td>
	            	</tr>
	            	<tr>
	            		<th>μμ±μΌ</th>
	            		<td><fmt:formatDate pattern="yyyy-MM-dd KK:mm" value="${map.inquery_date}"/></td>
	            	</tr>
	            	<tr>
	            		<th>λ΄μ©</th>
	            		<td>${map.inquery_content}</td>
	            	</tr>
	        </table>
	        <br><br><br>
	        <c:choose>
		         <c:when test = "${map.status eq 'λ―Έμ²λ¦¬'}">
		            <form action="adminInqueryUpdate" method="POST">
		        	<table class="myinfo">
		            	<tr>
		            		<th>μ²λ¦¬ν κ΄λ¦¬μ</th>
		            		<td>
		            			<input type="hidden" name="inquery_idx" value="${page}"/>
		            			<input type="text" name="inquery_admin" value="${sessionScope.loginId}" readonly/>
		            		</td>
		            	</tr>
		            	<tr>
		            		<th>λ΅λ³λ΄μ©</th>
		            		<!-- <td><input type="text" name="answer_content" placeholder="150μ μ΄λ΄" required="required"/></td> -->
		            		<td><textarea class="textarea" name="answer_content" placeholder="150μ μ΄λ΄" required="required"></textarea></td>
		            	</tr>
		            	<tr>
		            		<th>μ²λ¦¬μν</th>
		            		<td>
		            			<select name="status" size="1">
									<option value="λ―Έμ²λ¦¬">λ―Έμ²λ¦¬</option>
									<option value="μ²λ¦¬μ€">μ²λ¦¬μ€</option>
									<option value="μ²λ¦¬μλ£">μ²λ¦¬μλ£</option>
								</select>
		            		</td>
		            	</tr>
		            	<tr>
		            		<th colspan="2">
					        	<input class="bottom-button" type="button" value="λμκ°κΈ°" onclick="location.href='/admininqueryList.go'"/>
					        	<input class="bottom-button" type="submit" value="λ΅λ³νκΈ°"/>
		            		</th>
		            	</tr>
		        	</table>
		        	</form>
		         </c:when>
		         <c:when test = "${map.status eq 'μ²λ¦¬μ€'}">
		         	<form action="adminInqueryUpdate" method="POST">
		        	<table class="myinfo">
		            	<tr>
		            		<th>μ²λ¦¬ν κ΄λ¦¬μ</th>
		            		<td>
		            			<input type="hidden" name="inquery_idx" value="${page}"/>
		            			<input type="text" name="inquery_admin" value="${sessionScope.loginId}" readonly/>
		            		</td>
		            	</tr>
		            	<tr>
		            		<th>λ΅λ³λ΄μ©</th>
		            		<%-- <td><input type="text" name="answer_content" value="${map.answer_content}" placeholder="150μ μ΄λ΄" required="required"/></td> --%>
		            		<td><textarea class="textarea" name="answer_content" placeholder="150μ μ΄λ΄" required="required">${map.answer_content}</textarea></td>
		            	</tr>
		            	<tr>
		            		<th>μ²λ¦¬μν</th>
		            		<td>
		            			<select name="status" size="1">
									<option value="λ―Έμ²λ¦¬">λ―Έμ²λ¦¬</option>
									<option value="μ²λ¦¬μ€" selected="selected">μ²λ¦¬μ€</option>
									<option value="μ²λ¦¬μλ£">μ²λ¦¬μλ£</option>
								</select>
		            		</td>
		            	</tr>
		            	<tr>
		            		<th colspan="2">
					        	<input class="bottom-button" type="button" value="λμκ°κΈ°" onclick="location.href='/admininqueryList.go'"/>
					        	<input class="bottom-button" type="submit" value="λ΅λ³νκΈ°"/>
		            		</th>
		            	</tr>
		        	</table>
		        	</form>
		         </c:when>
		         <c:otherwise>
		        	<table class="myinfo">
		            	<tr>
		            		<th>μ²λ¦¬ν κ΄λ¦¬μ</th>
		            		<td>
		            			<input type="hidden" name="inquery_idx" value="${page}"/>
		            			${sessionScope.loginId}
		            		</td>
		            	</tr>
		            	<tr>
		            		<th>λ΅λ³λ΄μ©</th>
		            		<td>${map.answer_content}</td>
		            	</tr>
		            	<tr>
		            		<th>λ΅λ³ μμ±μΌ</th>
		            		<td><fmt:formatDate pattern="yyyy-MM-dd KK:mm" value="${map.inquery_date}"/></td>
		            	</tr>
		            	<tr>
		            		<th>μ²λ¦¬μν</th>
		            		<td>${map.status}</td>
		            	</tr>
		            	<tr>
		            		<th colspan="2">
		        				<input class="bottom-button" type="button" value="λμκ°κΈ°" onclick="location.href='/admininqueryList.go'"/>
		        			</th>
		            	</tr>
		        	</table>
		         </c:otherwise>
		    </c:choose>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>