<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<style>
#index {
  padding: 10px;
  animation: fadein 3s;
  -moz-animation: fadein 3s; /* Firefox */
  -webkit-animation: fadein 3s; /* Safari and Chrome */
  -o-animation: fadein 3s; /* Opera */
}

@keyframes fadein {
    from {
        opacity:0;
    }
    to {
        opacity:1;
    }
}
@-moz-keyframes fadein { /* Firefox */
    from {
        opacity:0;
    }
    to {
        opacity:1;
    }
}
@-webkit-keyframes fadein { /* Safari and Chrome */
    from {
        opacity:0;
    }
    to {
        opacity:1;
    }
}
@-o-keyframes fadein { /* Opera */
    from {
        opacity:0;
    }
    to {
        opacity: 1;
    }
}

* {
	font-family: 'Gowun Dodum', sans-serif;
}

</style>
<script>
// 새로고침 금지
function noRefresh()
{
    if (event.keyCode == 116) 
    {
        alert("새로고침을 할 수 없습니다.");
        event.keyCode = 2;
        return false;
    } 
    else if(event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) 
    {
        return false;
    }
}
document.onkeydown = noRefresh;
</script>
</head>
<body oncontextmenu="return false">
	<div class="container mt-3" id="index" style="border: 1px solid black; border-radius: 1rem;">
		
		<c:if test="${sessionScope.loginName ne null}">
			<h1 class="text-center mb-3" style="margin-top: 30%;">Welcome to ${sessionScope.loginName}</h1>
		</c:if>
		<c:if test="${sessionScope.kakaoN ne null}">
			<h1 class="text-center mb-3" style="margin-top: 30%;">Welcome to ${sessionScope.kakaoN}</h1>
		</c:if>
		<c:if test="${sessionScope.naverName ne null}">
			<h1 class="text-center mb-3" style="margin-top: 30%;">Welcome to ${sessionScope.naverName}</h1>
		</c:if>
        <div class="text-center" style="margin-bottom: 30%;">
            <a class="btn btn-outline-dark" href="/auction/auction">Auction</a>
            <a class="btn btn-outline-dark" href="/exhibition/paging">Exhibition</a>
            <c:if test="${sessionScope.loginName ne null}">
        		<a class="btn btn-outline-dark" href="/member/myPage?m_number=${sessionScope.loginNumber}">My Page</a>
        		<a class="btn btn-outline-danger" href="/member/logout">Logout</a>
            </c:if>
            <c:if test="${sessionScope.kakaoN ne null}">
            	<a class="btn btn-outline-danger" href="https://kauth.kakao.com/oauth/logout?client_id=070aeade687be812b74c91bedf42e6ec&logout_redirect_uri=http://localhost:8080/">Logout</a>
            </c:if>
            <c:if test="${sessionScope.naverName ne null}">
            	<a class="btn btn-outline-danger" href="/member/naverLogout">Logout</a>
            </c:if>
        </div>
	</div>


</body>
</html>