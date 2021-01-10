<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//검색할 종류
	String kind = request.getParameter("kind");
	//검색어
	String search = request.getParameter("search");
	
	//검색 결과를 받아서 클라이언트에게 출력 
	if(kind.equals("grade"))
		kind = "grade_name";
	search = search.toUpperCase();
	ArrayList<MemberVO> list = MemberService.getInstance().searchMember(kind,search);

	JSONObject jsonObject = new JSONObject();
	JSONArray jsonArray = new JSONArray(); 
	for(int i=0;i<list.size();i++){
		JSONObject temp = new JSONObject();
		temp.put("id", list.get(i).getId());
		temp.put("name",list.get(i).getName());
		temp.put("age",list.get(i).getAge());
		temp.put("grade",list.get(i).getGrade());
		jsonArray.put(temp);		
	}
	jsonObject.put("result", jsonArray);
	out.write(jsonObject.toString());	
	
%>





