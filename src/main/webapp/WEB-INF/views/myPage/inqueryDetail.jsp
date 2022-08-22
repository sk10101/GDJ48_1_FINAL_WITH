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
    
    .myinfo, .managerinfo {
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
    	font-size: 14px;
    }
    
    #textarea1 {
	    width: 90%;
	    height: 200px;
	    border-radius: 5px;
	    padding: 3px 5px;
	    resize: none;
	    font-size: 14px;
  	}
  	
    #textarea2 {
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
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar7.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar7.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <form action="inqueryUpdate" method="POST">
		       <table class="myinfo">
	            	<tr>
	            		<th>작성자</th>
	            		<td>${map.member_id}<input type="hidden" name="idx" value="${map.idx}"/></td>
	            	</tr>
	            	<tr>
	            		<th>제목</th>
	            		<td>
	            		<c:choose>
					         <c:when test="${map.status eq '미처리'}">
					        	<input id="subject" type="text" name="subject" placeholder="50자 이내" maxlength="50" value="${map.subject}" required/>
					         </c:when>
					         <c:otherwise>
					    		<input id="subject" type="text" value="${map.subject}" readonly/>
					         </c:otherwise>
					      </c:choose>
	            		</td>
	            	</tr>
	            	<tr>
	            		<th>내용</th>
	            		<td>
	            			<c:choose>
					         <c:when test="${map.status eq '미처리'}">
					        	<%-- <input name="content" type="text" value="${map.inquery_content}"/> --%>
					        	<textarea id="textarea1" name="content" placeholder="500자 이내" maxlength="333" required>${map.inquery_content}</textarea>
					         </c:when>
					         <c:otherwise>
					    		<%-- <input type="text" value="${map.inquery_content}" readonly/> --%>
					    		<textarea id="textarea1" readonly>${map.inquery_content}</textarea>
					         </c:otherwise>
					      </c:choose>	
	            		</td>
	            	</tr>
	            	<tr>
	            		<th>처리상태</th>
						<c:if test="${map.status eq '미처리'}">						
							<td style="color: #ef5350;">${map.status}</td>
						</c:if>	
						<c:if test="${map.status eq '처리중'}">						
							<td style="color: #ff6f00;">${map.status}</td>
						</c:if>	
						<c:if test="${map.status eq '처리완료'}">						
							<td style="color: #537ef4;">${map.status}</td>
						</c:if>	
	            	</tr>
	            	<tr>
	            		<th>작성일</th>
	            		<td><fmt:formatDate pattern="yyyy-MM-dd KK:mm" value="${map.inquery_date}"/></td>
	            	</tr>
	            </table>
	            
	            <br><br><hr style="width: 70%; margin: 0 auto;"><br><br>
	            
	            <table class="managerinfo">
	            	<tr>
	            		<th>관리자</th>
	            		<td>${map.inquery_admin}</td>
	            	</tr>
	            	<tr>
	            		<th>답변내용</th>
	            		<%-- <td>${map.answer_content}</td> --%>
	            		<c:if test="${map.answer_content ne null}">
	            			<td><textarea id="textarea2" readonly>${map.answer_content}</textarea></td>
	            		</c:if>
	            		<c:if test="${map.answer_content eq null}">
	            			<td><textarea style="color: #ef5350;" id="textarea2" readonly>아직 답변이 달리지 않은 문의글 입니다.</textarea></td>
	            		</c:if>
	            	</tr>
	            	<tr>
	            		<th>작성일</th>
	            		<c:if test="${map.answer_date eq null}">
	            			<td> - </td>
	            		</c:if>
	            		<c:if test="${map.answer_date ne null}">
	            			<td><fmt:formatDate pattern="yyyy-MM-dd KK:mm" value="${map.answer_date}"/></td>
	            		</c:if>
	            	</tr>
	            </table>
	            <div id="button-wrap">
	           		<c:if test="${map.status eq '미처리'}">
	           			<input class="bottom-button" type="submit" value="수정"/>
	           		</c:if>
	       			<input class="bottom-button" type="button" onclick="location.href='/inqueryList.go'" value="돌아가기"/>
          		</div>
            </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>