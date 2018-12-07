<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="screeningmovie.*" %>      
<%@ page import="customer.*" %>
<%@ page import="java.util.ArrayList" %>
    
<% request.setCharacterEncoding("utf-8"); %>
    
<jsp:include page="sessionCheck.jsp" flush="false"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Movie - Payment</title>
</head>
<body>
	<b style="font-size: x-large;">영화 예약 (결제) </b> 
	</br></br>
<%
	int screening_timetable_id = Integer.parseInt(request.getParameter("screening_timetable_id"));
	String seat[] = request.getParameterValues("seat_id");
	ScreeningMovieDB screeningMovieDB = ScreeningMovieDB.getInstance();
	ScreeningMovieBean screeningMovieBean = screeningMovieDB.selectScreeningMovieById(screening_timetable_id);
	CustomerDB customerDB = CustomerDB.getInstance();
	CustomerBean customerBean = customerDB.selectCustomer((String)session.getAttribute("id"));
%>
	<b>제목</b>: <%=screeningMovieBean.getTitle() %> /
	<b>상영관</b>: <%=screeningMovieBean.getMovie_theater_name() %> - <%=screeningMovieBean.getTheater_name() %> /
	<b>날짜</b>: <%=screeningMovieBean.getScreening_date() %> /
	<b>가격</b>: <%=screeningMovieBean.getPrice() %> / 
	<b>좌석</b>: 
<%
	for(int i=0; i<seat.length; i++) {
		String seat_split[] = seat[i].split("==>>");
		seat[i] = seat_split[0];
%>
		<%=seat_split[1] %>
<%
	}
%>	
	<form method="post" action="bookMovieHandler.jsp" style="display: inline;">
		<input type=text style="display: none;" name="screening_timetable_id" value="<%=screening_timetable_id %>">
<%
		for(int i=0; i<seat.length; i++) {
%>
			<input type=text style="display: none;" name="seat_id" value="<%=seat[i] %>">
<%
		}
%>

		</br></br>
		<b>결제 유형:</b> 
		<select id="payment_type" name="payment_type" onchange="changeType()">
			<option value="현장 결제">현장 결제</option>
			<option value="인터넷 결제">인터넷 결제</option>
		</select>
		</br></br>
		<span id="point">
			<input type="text" style="display: none;" name="point" value="0">
		</span>
		<br/><br/>
		<input type="text" style="display: none;" name="payment_amount" value="<%=screeningMovieBean.getPrice() * seat.length %>">
		<b>결제 금액:</b> <span id="payment_amount" value="<%=screeningMovieBean.getPrice() * seat.length %>"><%=screeningMovieBean.getPrice() * seat.length %></span>
		</br></br>
		<input type="submit" value="예약 완료">
	</form>
	</br></br>
		
</body>
<script>
	function changeType() {
		var typeSelect = document.getElementById("payment_type");
		var type = typeSelect.options[typeSelect.selectedIndex].value; 
		if(type == "인터넷 결제") {
			document.getElementById("point").innerHTML = '<b>포인트:</b> <input type="text" name="point" value="0" onkeyup="keyupPoint(this)" onchange="changePoint(this)"> <%=customerBean.getPoint() %>원 보유 (1000원 이상 사용 가능)';
		}
		else {
			payment_amount.innerHTML = payment_amount.getAttribute('value');
			document.getElementById("point").innerHTML = '<input type="text" style="display: none;" name="point" value="0">';
		}
	}
	
	function keyupPoint(obj) {
		var customer_point = <%=customerBean.getPoint() %>;
		var point = obj.value;
		var payment_amount = document.getElementById("payment_amount");
		if(customer_point < point) {
			obj.value = 0;
			payment_amount.innerHTML = payment_amount.getAttribute('value');
			alert('보유 포인트보다 더 많이 사용할 수 없습니다.');
		}
		else {
			payment_amount.innerHTML = payment_amount.getAttribute('value') - point;
		}
	}
	
	function changePoint(obj) {
		var customer_point = <%=customerBean.getPoint() %>;
		var point = obj.value;
		var payment_amount = document.getElementById("payment_amount");
		if(point < 1000) {
			obj.value = 0;
			payment_amount.innerHTML = payment_amount.getAttribute('value');
			alert('1000포인트 이상 사용 가능합니다.');
		}
	}
</script>
</html>