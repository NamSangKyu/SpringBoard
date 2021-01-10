<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 페이지</title>
<style>
.container{
	width:1200px;
	margin:0px auto;
	padding-top:30px;
	box-sizing: border-box;
}
#menu_bar{
	width:1200px;
	box-sizing: border-box;
	text-align: center;
}
#menu_bar > select{
	width:150px;
	padding:5px;
	margin-right:5px;
}
#menu_bar > input{
	width:200px;
	padding:5px;
	margin-right:5px;
}
#menu_bar > button{
	width:100px;
	padding:5px;
}
#title > li {
	width: 230px;
	font-size:16px;
	display: inline-block;
	text-align: center;
	font-weight: bold;
	padding:10px;
	box-sizing: border-box;
}
#title{
	font-size:0px;
	padding:0;
}
table{
	border-collapse: collapse;
}
td{
	width:230px;
	text-align: center;
	padding:10px;
	box-sizing: border-box;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	function update_member(obj) {
		//alert($(this).parent().parent().index());//현재 버튼이 속해있는 tr을 선택, 인덱스 번호 조회
		var data = "";
		$.each($(obj).parent().parent().find("input"), function(i,o) {
			//데이터를 조립 쿼리 스트링 id=A0001&name=홍길동
			console.log(i,$(o).val());
			data += $(o).attr("name") + "=" + $(o).val()  + "&"; 
		});
		console.log(data);
		//ajax를 이용하여 수정 처리 -> AjaxUpdateMember.jsp --> MemberService -> MemberDAO
		$.ajax({
			url : "process/ajax_update_member.jsp",
			data : data,
			method:"get",
			success:function(d){
				d = Boolean(d);
				if(d){
					console.log("수정 성공");
				}else{
					console.log("수정 실패");						
				}
				$("#search")[0].reset();
				$("#btn_submit").click();	
			}
		});
	}
	function delete_member(obj) {
		var data = "";
		data = "id=" + $(obj).parent().parent().find("input").first().val();
		console.log(data);
		$.ajax({
			url : "process/ajax_delete_member.jsp",
			data : data,
			method:"get",
			success:function(d){
				d = Boolean(d);
				if(d){
					console.log("삭제 성공");
				}else{
					console.log("삭제 실패");						
				}
				$("#search")[0].reset();
				$("#btn_submit").click();	
			}
		});
	}
	$(function() {
		$("#btn_submit").click(function(e) {
			var data = $("#search").serialize();//kind=id&name=검색어
			$.ajax({
				url : "<%=request.getContextPath()%>/admin/process/ajax_search_process.jsp",
				data : data,
				method : 'get',
				success : function(d) {
					console.log(d);
					var json = JSON.parse(d);
					var result = "<table>";
					var arr = json.result;
					for(i=0;i<arr.length;i++){
						//한건당 한줄씩 표현 
						result += 
						"<tr><td>"+arr[i].id+"<input type='hidden' name='id' value='"+arr[i].id+"'></td>"
						+"<td><input type='text' name='name' value='"+arr[i].name+"'></td>"
						+"<td><input type='text' name='age' value='"+arr[i].age+"'></td>"
						+"<td><input type='text' name='grade' value='"+arr[i].grade+"'></td>"
						+"<td><a href='#' class='update'>수정</a> / <a href='#' class='delete'>삭제</a></td></tr>";
					}
					result += "</table>";
					$("#content_area").html(result);
					//동적엘리먼트에 대한 이벤트 처리
					$(".update").click(function() {
						update_member($(this));
					});			
					$(".delete").click(function() {
						delete_member($(this));
					});			
				}
			});
			e.preventDefault();	
		});
		$(".update").click(function() {
			update_member($(this));
		});
		$(".delete").click(function() {
			delete_member($(this));
		});
	});	
</script>
</head>
<body>
	<%
		if(session.getAttribute("login") == null || !session.getAttribute("grade").equals("master")){
			%>
				<script>
					location.href="<%=request.getContextPath()%>/index.jsp";
				</script>
			<%
		}
	
		//전체 회원 목록 읽어옴
		ArrayList<MemberVO> list = MemberService.getInstance().selectAllMemberVO();
	%>
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<div class="container">
		<div id="menu_bar">
			<form id="search">
				<select name="kind">
					<option value="id">아이디</option>
					<option value="name">이름</option>
					<option value="grade">등급</option>
				</select>
				<input type="text" name="search">
				<button id="btn_submit">검색</button>
			</form>
		</div>
		<hr>
		<div id="content">
			<ul id="title">
				<li>아이디</li>
				<li>이름</li>
				<li>나이</li>
				<li>등급</li>
				<li>비고</li>
			</ul>
			<hr>
			<div id="content_area">
				<table>
				<%
					for(int i=0;i<list.size();i++){
						%>
						<tr> 
							<td><%=list.get(i).getId() %>
							<input type="hidden" name="id" value="<%=list.get(i).getId() %>"></td>
							<td><input type="text" name="name" value="<%=list.get(i).getName() %>"></td>
							<td><input type="text" name="age" value="<%=list.get(i).getAge() %>"></td>
							<td><input type="text" name="grade" value="<%=list.get(i).getGrade() %>"></td>
							<td>
								<a href="#" class="update">수정</a> / <a href="#" class="delete">삭제</a>  
							</td>
						</tr>
						<%
					}
				
				%>
				</table>
			</div>
		</div>
		
	</div>
			
	<jsp:include page="/template/footer.jsp"></jsp:include>
</body>
</html>








