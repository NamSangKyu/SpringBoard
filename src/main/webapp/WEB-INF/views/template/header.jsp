<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
    boolean flag = false;
	if(session.getAttribute("login") != null)
		flag = (boolean)session.getAttribute("login");
	
	if(flag){
		%>
		<style>
	nav {
		width:1200px;
		margin:0 auto;/* 가운데 정렬  */
		border:1px solid black;
		text-align: center;
		position: relative;
	}
	ul{
		list-style-type: none;
		height: auto;
		display: inline-block;
	}
	li{
		display: inline-block;
	}
	#menu_bar a:link,#menu_bar a:visited {
		color:black;
		text-decoration: none;
		font-size: 17px;
		text-align: center;
		padding: 20px 30px;
	}
	#login{
		position: absolute;
		right: 0px;
		top:0px;
		width:150px;
		padding:5px;
	}
</style>
<nav id="menu_bar">
	<ul>
		<li><a href="<%=request.getContextPath() %>/index.jsp">HOME</a></li>
		<li><a href="logout.do">로그아웃</a></li>
		<%
			if(session.getAttribute("grade").equals("master"))
			{
				%>
				<li><a href="<%=request.getContextPath() %>/admin/member_manage_main.jsp">전체 회원 관리</a></li>
				
				<%	
			}
		%>
		<li><a href="<%=request.getContextPath() %>/member/member_update_view.jsp">회원정보수정</a></li>
		<li><a href="#">문의하기</a></li>
	</ul>
	<div id="login">
		<table>
			<tr>
				<td><img src="<%=request.getContextPath() %>/img/<%=session.getAttribute("grade")+".png"%>" style="width:32px;"></td>
				<td><%=session.getAttribute("name") %>님 로그인</td>
			</tr>
			
		</table>
		
	</div>
</nav>		

		<%
		
	}else{
    %>
<!-- 메뉴부분 -->
<style>
	nav {
		width:1200px;
		margin:0 auto;/* 가운데 정렬  */
		border:1px solid black;
		text-align: center;
	}
	ul{
		list-style-type: none;
		height: auto;
		display: inline-block;
	}
	li{
		display: inline-block;
	}
	#menu_bar a:link,#menu_bar a:visited {
		color:black;
		text-decoration: none;
		font-size: 17px;
		text-align: center;
		padding: 20px 30px;
	}
</style>
<nav id="menu_bar">
	<ul>
		<li><a href="/">HOME</a></li>
		<li><a href="<%=request.getContextPath() %>/member/register.jsp">회원가입</a></li>
		<li><a href="login.do">로그인</a></li>
		<li><a href="#">문의하기</a></li>
	</ul>
</nav>
<%
	}
%>




