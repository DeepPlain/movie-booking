<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Movie</title>
</head>
<body>
	<h2>영화 등록</h2>

	<form method="post" action="registerMovieHandler.jsp">
		<b>제목</b>: <input type="text" name="title" maxlength="45"><br/>
		<b>감독</b>: <input type="text" name="director" maxlength="20"><br/>
		<b>출연 </b><button type="button" onclick="deleteActor()">-</button><button type="button" onclick="addActor()">+</button><br/>
		<div id="actor"><input type="text" name="actor" maxlength="20"><input type="text" name="actor" maxlength="20"></div>
		<b>등급</b>: <input type="text" name="rating" maxlength="20"><br/>
		<b>주요 정보</b>: <input type="text" name="key_information"><br/>
		<input type="submit" value="등록">
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