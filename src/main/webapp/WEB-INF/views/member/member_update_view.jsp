<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<style>
.container{
	width:300px;
	margin:0px auto;
	height: 600px;
	padding-top:200px;
	box-sizing: border-box;
}
</style>
</head>
<body>
	
	<%
		System.out.println(session.getAttribute("login")); 
		System.out.println(session.getAttribute("login")==null); 
		//세션 유효 처리
		if(session.getAttribute("login") == null || !((boolean)session.getAttribute("login")) ){
			//sendRedirect 해도 바로 페이지 이동 X
			response.sendRedirect(request.getContextPath() + "/member/login.jsp"); 
			return;			
		}
		
		//회원 정보
		MemberVO vo = MemberService.getInstance().selectMemberVO((String)session.getAttribute("id"));
				
	%>
	<jsp:include page="/template/header.jsp"></jsp:include>
	<div id="container">
		<form action="<%=request.getContextPath() %>/member/update_process.jsp" method="post">
			아이디 : <input type="text" name="id" value="<%=vo.getId()%>" readonly><br>
			암호 : <input type="password" name="pass"><br>
			이름 : <input type="text" name="name" value="<%=vo.getName()%>"><br>
			나이 : <input type="text" name="age" value="<%=vo.getAge()%>"><br>
			<button>정보수정</button>		
		</form>
	</div>
	<jsp:include page="/template/footer.jsp"></jsp:include>
</body>
</html>











