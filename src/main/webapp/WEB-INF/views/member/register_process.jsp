<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="/error/error.jsp" %>
<%
	request.setCharacterEncoding("utf-8");//post 방식 반드시 인코딩
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));

	MemberVO vo = new MemberVO(id,pass,name,age);
	System.out.println(vo.toString());
	//서비스 클래스로 vo를 전달
	MemberService.getInstance().insertMemberVO(vo);

	RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	dispatcher.forward(request, response);
%>