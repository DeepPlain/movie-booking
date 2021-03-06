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
		<div id="theater">
			<div id="1">
				&nbsp; 1. 이름: <input type="text" name="theater" maxlength="45"><br/> 
				&nbsp;&nbsp; - 좌석 <button type="button" onclick="deleteSeat(this)">-</button><button type="button" onclick="addSeat(this)">+</button><br/>
				&nbsp;&nbsp; <input type="text" name="seat1" maxlength="45"><input type="text" name="seat1" maxlength="45"></div></div>
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
		var theater_num = parent.children.length + 1;
		parent.insertAdjacentHTML('beforeend', 
				'<div id="' + theater_num + '">&nbsp; ' + theater_num + '. 이름: <input type="text" name="theater" maxlength="45"><br/> &nbsp;&nbsp; - 좌석 <button type="button" onclick="deleteSeat(this)">-</button><button type="button" onclick="addSeat(this)">+</button><br/>&nbsp;&nbsp; <input type="text" name="seat' + theater_num + '" maxlength="45"><input type="text" name="seat' + theater_num + '" maxlength="45"></div></div>');
	}
	
	function deleteSeat(obj) {
		var parent = obj.parentNode;
		var lastChild = parent.lastChild;
		parent.removeChild(lastChild);
	}
	
	function addSeat(obj) {
		var theater_num = document.getElementById("theater").children.length + 1;
		var parent = obj.parentNode; 
		var input = document.createElement("input");
		input.setAttribute("type", "text");
		input.setAttribute("name", "seat" + parent.id);
		input.setAttribute("maxlength", 45);
		parent.appendChild(input);
	}
</script>
</html>