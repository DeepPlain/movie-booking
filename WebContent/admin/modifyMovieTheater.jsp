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
		<input type="text" style="display: none;" name="movie_theater_name" value="movie_theater_name==>><%=request.getParameter("movie_theater_name") %>">
		<b>이름</b>: <input type="text" name="movie_theater_name==>><%=request.getParameter("movie_theater_name") %>" maxlength="45" value="<%=request.getParameter("movie_theater_name") %>"><br/>
		<b>주소</b>: <input type="text" name="address" maxlength="100" value="<%=request.getParameter("address") %>"><br/>
		<b>전화번호</b>: <input type="text" name="telephone_number" maxlength="10" value="<%=request.getParameter("telephone_number") %>"><br/>
		<b>기존 상영관 수정</b><br/>
		<div>
<%
		MovieTheaterDB movieTheaterDB = MovieTheaterDB.getInstance();
		ArrayList<TheaterBean> theaterBeans = movieTheaterDB.selectTheaterList(request.getParameter("movie_theater_name"));
		for(int i=0; i<theaterBeans.size(); i++) {
			TheaterBean theaterBean = theaterBeans.get(i);
			%><div id="<%=theaterBean.getTheater_id() %>" name="<%=theaterBean.getTheater_name() %>">
				&nbsp; <%=(i+1) %>. 이름: <span id="<%=theaterBean.getTheater_id() %>" name="<%=theaterBean.getTheater_name() %>"><span><%=theaterBean.getTheater_name() %></span>
				<button type="button" onclick="modifyOriginalTheater(this)">수정</button><button type="button" onclick="deleteOriginalTheater(this)">삭제</button>
				</span></br> 
				&nbsp;&nbsp; - 좌석 <button type="button" onclick="cancelModifyOriginalSeat(this)">-</button><button type="button" onclick="modifyOriginalSeat(this)">+</button><br/>
				&nbsp;&nbsp; 
<%
				ArrayList<SeatBean> seatBeans = theaterBean.getSeatBean();
				for(int j=0; j<seatBeans.size(); j++) {
					SeatBean seatBean = seatBeans.get(j);
%>
					<button type="button" onclick="deleteOriginalSeat(this)" id="<%=seatBean.getSeat_id() %>"><%=seatBean.getSeat_name() %> X</button>
<%
				}
%>			
			</div>
<%
		}
%>
		</div>
		<br/>
		<b>상영관 추가</b><button type="button" onclick="deleteTheater()">-</button><button type="button" onclick="addTheater()">+</button><br/>		
		<div id="theater">
		</div>
		</br>
		<input type="submit" value="수정">
	</form>
</body>
<script>
	function cancelModifyOriginalTheater(obj) {
		obj.innerHTML = '수정';
		obj.setAttribute('onclick', 'modifyOriginalTheater(this)');
		var parent = obj.parentNode;
		var name = parent.getAttribute('name');
		console.log(parent);
		console.log(name);
		parent.childNodes[0].innerHTML = name;
	}

	function modifyOriginalTheater(obj) {
		obj.innerHTML = '취소';
		obj.setAttribute('onclick', 'cancelModifyOriginalTheater(this)');
		var parent = obj.parentNode;
		var id = parent.id;
		var name = parent.childNodes[0].innerHTML;
		parent.childNodes[0].innerHTML = '<input type="text" style="display: none;" name="modifiedTheater" value="modifiedTheater==>>' + id + '">';
		parent.childNodes[0].innerHTML += '<input type="text" name="modifiedTheater==>>' + id + '" maxlength="45" value="' + name + '">';
	}
	
	function deleteOriginalTheater(obj) {
		var parent = obj.parentNode.parentNode.parentNode;
		var id = obj.parentNode.id;
		parent.removeChild(obj.parentNode.parentNode);
		parent.insertAdjacentHTML('afterbegin', 
				'<input style="display: none;" name="deletedTheater" value="' + id + '">');
	}
	
	function cancelModifyOriginalSeat(obj) {
		var parent = obj.parentNode;
		var lastChild = parent.lastChild;
		if(parent.lastChild.tagName == "INPUT") {
			parent.removeChild(lastChild);
		}
		var lastChild = parent.lastChild;
		if(parent.lastChild.tagName == "INPUT") {
			parent.removeChild(lastChild);
		}
	}
	
	function modifyOriginalSeat(obj) {
		var parent = obj.parentNode;
		var id = parent.id;
		parent.insertAdjacentHTML('beforeend', 
				'<input style="display: none;" name="modifiedSeat" value="modifiedSeat==>>' + id + '">');
		parent.insertAdjacentHTML('beforeend', 
				'<input type="text" maxlength="45" name="modifiedSeat==>>' + id + '">');
	}
	
	function deleteOriginalSeat(obj) {
		var parent = obj.parentNode;
		var id = obj.id;
		parent.removeChild(obj);
		parent.insertAdjacentHTML('beforeend', 
				'<input style="display: none;" name="deletedSeat" value="' + id + '">');
	}
	
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
		console.log(parent.lastChild.tagName);
		if(parent.lastChild.tagName == "INPUT") {
			parent.removeChild(lastChild);
		}
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