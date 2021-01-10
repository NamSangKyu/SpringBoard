<%@page import="dao.BoardDAO"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="/error/error_ajax.jsp" %>
<%
	if(session.getAttribute("login") == null)
		throw new Exception("로그인을 해야 이용할 수 있습니다.");
	int mode = Integer.parseInt(request.getParameter("mode"));
	int bno = Integer.parseInt(request.getParameter("bno"));
	BoardDAO.getInstance().addLikeHate(bno,mode);
	int count = BoardDAO.getInstance().selectLikeHate(bno,mode);
	out.write(String.valueOf(count));    
%>