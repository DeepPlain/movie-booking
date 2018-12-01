<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Movie</title>
</head>
<body>
	<h2>영화 정보 수정</h2>

	<form method="post" action="modifyMovieHandler.jsp">
		<input type=text style="display: none;" name="movie_id" value="<%=request.getParameter("movie_id") %>">
		<b>제목</b>: <input type="text" name="title" maxlength="45" value="<%=request.getParameter("title") %>"><br/>
		<b>감독</b>: <input type="text" name="director" maxlength="20" value="<%=request.getParameter("director") %>"><br/>
		<b>출연 </b><button type="button" onclick="deleteActor()">-</button><button type="button" onclick="addActor()">+</button><br/>
		<div id="actor">
<%
		String actor[] = request.getParameterValues("actor");
		for(int i=0; i<actor.length; i++) {
%><input type="text" name="actor" maxlength="20" value="<%=actor[i] %>"><%}
%></div>
		<b>등급</b>: <input type="text" name="rating" maxlength="20" value="<%=request.getParameter("rating") %>"><br/>
		<b>주요 정보</b>: <input type="text" name="key_information" value="<%=request.getParameter("key_information") %>"><br/>
		<input type="submit" value="수정">
	</form>
</body>
<script>
	function deleteActor() {
		var parent = document.getElementById("actor");
		var lastChild = parent.lastChild;
		parent.removeChild(lastChild);
	}

	function addActor() {
		var parent = document.getElementById("actor");
		var input = document.createElement("input");
		input.setAttribute("type", "text");
		input.setAttribute("name", "actor")
		input.setAttribute("maxlength", 20);
		parent.appendChild(input);
	}
</script>
</html>