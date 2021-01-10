<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String grade = request.getParameter("grade").toUpperCase();
	
	MemberVO vo = new MemberVO(id,null,name,age,grade);
	
	if(MemberService.getInstance().updateManageMemberVO(vo)){
		out.write("true");
	}else{
		out.write("false");
		
	}

%>