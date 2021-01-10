<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#container{
		height: 600px;
		/* background-color: lime; */
	}
</style>
</head>
<body>
<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
	<div id="container">
	작업 에러 : <%=exception.getMessage() %><br>
	<a href="javascript:history.back();">뒤로가기</a>
	</div>
	<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
	
</body>
</html>