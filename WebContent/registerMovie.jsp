<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="adminSessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Movie</title>
</head>
<body>
	<h2>영화 등록</h2>

	<form method="post" action="registerMovieHandler.jsp">
		제목 : <input type="text" name="title" maxlength="45"><br/>
		감독 : <input type="text" name="director" maxlength="20"><br/>
		<div id="actor">
			출연 : <input type="text" name="actor" maxlength="20">
			<button onclick="addActor()">+</button><br/>
		</div>
		등급 : <input type="text" name="rating" maxlength="20"><br/>
		주요정보 : <input type="text" name="key_information"><br/>
		<input type="submit" value="회원가입">
	</form>
</body>
<script>
	function addActor() {
		document.getElementById("actor").innerHTML += "<input type='text' name='actor' maxlength='20'><br/>"
	}
</script>
</html>