<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<style type="text/css">
	#container{
		height: 600px;
		/* background-color: lime; */
		width:1200px;
		margin:0 auto;
	}
	#container table{
		width:600px;
		border-collapse: collapse;
		margin:0 auto;
	}
	#container th{
		width:150px !important;
		text-align: right;
		padding:5px;
	}
	#container td{
		width: 500px;
		padding:5px;
		height: 40px;
	}
	#container input{
		width: 100%;
		height:40px;
		box-sizing:border-box;
		border-width : 1px;
		border-radius: 5px;
	}
	h2{
		text-align: center;
	}
	.btn{
		text-decoration: none;
		background-color: #e8e8e8;
		width: 80px;
		display: inline-block;
		padding:5px 0px;
		font-weight:normal;
		border : 1px solid #585858;
		text-align:center;
		color : black;
		font-size:14px;
		box-sizing: border-box;
	}
	.btn:hover{
		background-color: #282828;
		color:#FFFFFF
	}
	textarea {
		width:100%;
		height: 300px;
		resize: none;
		box-sizing: border-box;
	}
</style>
</head>
<body>
<%
		if(session.getAttribute("login") == null || (boolean) session.getAttribute("login")==false){
			String queryString = "";
			queryString = request.getQueryString() != null ? "?"+ request.getQueryString() : "";
			session.setAttribute("result_url", "write" );
			%>
				<script>
					console.log("<%=session.getAttribute("result_url")%>");
					alert("로그인을 하셔야 이용할수 있습니다.");
					location.href="login.do";
				</script>
			<%
		}
%>
	<jsp:include page="../template/header.jsp" flush="false"></jsp:include>
	<div id="container">
		<h2>글쓰기 페이지</h2>
		<form action="boardWrite.do" method="post">
			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<input type="hidden" name="writer" value="<%=session.getAttribute("id")%>">
						<%=session.getAttribute("id")%>					
					</td>
				</tr>
				<tr>
					<th style="vertical-align: top;">내용</th><td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<th><a href="<%=request.getContextPath()%>/index.jsp" class="btn">목록보기</a></th>
					<td style="text-align: right;">
						<a href="javascript:history.back();" class="btn">뒤로가기</a>
						<button class="btn">글쓰기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../template/footer.jsp" flush="false"></jsp:include>
</body>
</html>











