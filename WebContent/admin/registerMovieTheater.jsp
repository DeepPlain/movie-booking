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
	<h2>영화관 등록</h2>

	<form method="post" action="registerMovieTheaterHandler.jsp">
		<b>이름</b>: <input type="text" name="movie_theater_name" maxlength="45"><br/>
		<b>주소</b>: <input type="text" name="address" maxlength="100"><br/>
		<b>전화번호</b>: <input type="text" name="telephone_number" maxlength="10"><br/>
		<b>상영관 </b><button type="button" onclick="deleteTheater()">-</button><button type="button" onclick="addTheater()">+</button><br/>
		<div id="theater"><input type="text" name="theater" maxlength="45"><input type="text" name="theater" maxlength="45"></div>
		<input type="submit" value="등록">
	</form>
</body>
<script>
	function deleteTheater() {
		var parent = document.getElementById("theater");
		var lastChild = parent.lastChild;
		parent.removeChild(lastChild);
	}

	function addTheater() {
		var parent = document.getElementById("theater");
		var input = document.createElement("input");
		input.setAttribute("type", "text");
		input.setAttribute("name", "theater")
		input.setAttribute("maxlength", 45);
		parent.appendChild(input);
	}
</script>
</html>