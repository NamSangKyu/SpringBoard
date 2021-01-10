<%@page import="dao.MemberDAO"%>
<%@page import="service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	 
	if(MemberDAO.getInstance().deleteMember(id)){
		out.write("true");
	}else{
		out.write("false");
		
	}

%>