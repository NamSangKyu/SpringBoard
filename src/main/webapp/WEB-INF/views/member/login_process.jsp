<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	MemberVO vo = MemberService.getInstance().login(id,pass);
	
	if(vo == null){ 
		%>
			<script>
				alert("아이디와 비밀번호를 확인하세요");
				history.back();
			</script>
		<%
		session.setAttribute("login", false);
	}else{
		session.setAttribute("login", true);
		session.setAttribute("name", vo.getName());
		session.setAttribute("id", vo.getId());
		session.setAttribute("grade", vo.getGrade().toLowerCase());
		
		if(session.getAttribute("result_url")!=null){
			String url = (String)session.getAttribute("result_url");
			session.removeAttribute("result_url");
			response.sendRedirect(url);
		}else
			response.sendRedirect(request.getContextPath()+"/index.jsp");
		
	}

%>




