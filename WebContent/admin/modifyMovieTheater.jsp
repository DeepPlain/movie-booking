<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movietheater.*" %>
<%@ page import="java.util.ArrayList" %>

<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Movie Theater</title>
</head>
<body>
	<h2>영화관 정보 수정</h2>

	<form method="post" action="modifyMovieTheaterHandler.jsp">
		<b>이름</b>: <input type="text" name="movie_theater_name" maxlength="45" value="<%=request.getParameter("movie_theater_name") %>"><br/>
		<b>주소</b>: <input type="text" name="address" maxlength="100" value="<%=request.getParameter("address") %>"><br/>
		<b>전화번호</b>: <input type="text" name="telephone_number" maxlength="10" value="<%=request.getParameter("telephone_number") %>"><br/>
		<b>상영관 </b><button type="button" onclick="deleteTheater()">-</button><button type="button" onclick="addTheater()">+</button><br/>
		<div id="theater">
<%
		MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
		ArrayList<TheaterBean> theaterBeans = movieTheaterDB.selectTheaterList(request.getParameter("movie_theater_name"));
		for(int i=0; i<theaterBeans.size(); i++) {
			TheaterBean theaterBean = theaterBeans.get(i);
			%><div id=<%=(i+1) %>>
				&nbsp; <%=(i+1) %>. 이름: <input type="text" name="theater" maxlength="45" id="<%=theaterBean.getTheater_id() %>" value="<%=theaterBean.getTheater_name() %>"><br/> 
				&nbsp;&nbsp; - 좌석 <button type="button" onclick="deleteSeat(this)">-</button><button type="button" onclick="addSeat(this)">+</button><br/>
				&nbsp;&nbsp; 
<%
				ArrayList<SeatBean> seatBeans = theaterBean.getSeatBean();
				for(int j=0; j<seatBeans.size(); j++) {
					SeatBean seatBean = seatBeans.get(j);
					%><input type="text" name="seat<%=(i+1) %>" maxlength="45" id="<%=seatBean.getSeat_id() %>" value="<%=seatBean.getSeat_name() %>"><%
				}%></div><%
		}
		%></div>
		<input type="submit" value="수정">
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