<%@page import="dto.CommentDTO"%>
<%@page import="service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	 
	int result = BoardService.getInstance().insertBoardComment(new CommentDTO(bno,content,writer));
	out.write(result + "");
%>