<%@page import="service.BoardService"%>
<%@page import="dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	//서비스 클래스로 데이터 보냄
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO(title,writer, content);
	
	dto = BoardService.getInstance().insertBoardDTO(dto);
	//작성한 게시글 조회 페이지 board_view.jsp 게시글 번호
	System.out.println(dto.getBno());
	response.sendRedirect("../board_view.jsp?bno="+dto.getBno());
%>













