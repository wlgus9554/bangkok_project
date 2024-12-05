<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>항공 예약 관리</title>
<style>
body {
	background-color: #e9ecef;
	font-family: Arial, sans-serif;
}

h1, h2 {
	color: #343a40;
}

.reservation-container {
	display: flex;
	flex-direction: column;
	background-color: #fff;
	padding: 20px;
	border: 1px solid #dee2e6;
	margin-bottom: 20px;
}

.reservation-header {
	display: flex;
	font-weight: bold;
	background-color: #343a40;
	color: #fff;
	padding: 10px;
}

.reservation-row {
	display: flex;
	padding: 10px;
	background-color: #f8f9fa;
	border-top: 1px solid #dee2e6;
}

.reservation-cell {
	flex: 1;
	text-align: center;
}

select, input[type="submit"], button {
	padding: 8px 16px;
	margin: 5px;
	border: none;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
}

select {
	background-color: #fff;
	border: 1px solid #ced4da;
}

input[type="submit"] {
	background-color: #ff6f61;
	color: #fff;
}

input[type="submit"]:hover {
	background-color: #ff4f41;
}

button {
	background-color: #6c757d;
	color: #fff;
}

button:hover {
	background-color: #5a6268;
}

.passenger-list {
	display: none;
	padding: 10px;
	border: 1px solid #dee2e6;
	margin-top: 10px;
}

.passenger-header, .passenger-row {
	display: flex;
}

.passenger-header {
	font-weight: bold;
	background-color: #343a40;
	color: #fff;
	padding: 10px;
}

.passenger-row {
	background-color: #f8f9fa;
	padding: 10px;
	border-top: 1px solid #dee2e6;
}

.passenger-cell {
	flex: 1;
	text-align: center;
}
</style>
<script>
        function togglePassengers(reservationNo) {
            var passengersDiv = document.getElementById("passengers-" + reservationNo);
            if (passengersDiv.style.display === "none") {
                passengersDiv.style.display = "block";
            } else {
                passengersDiv.style.display = "none";
            }
        }
    </script>
</head>
<body>
	<h1>항공 예약 관리</h1>

	<h2>예약 목록</h2>
	<div class="reservation-container">
		<div class="reservation-header">
			<div class="reservation-cell">예약 번호</div>
			<div class="reservation-cell">이메일</div>
			<div class="reservation-cell">예약 날짜</div>
			<div class="reservation-cell">총 가격</div>
			<div class="reservation-cell">상태</div>
			<div class="reservation-cell">작업</div>
		</div>
		<c:forEach var="reservation" items="${reservations}">
			<div class="reservation-row">
				<div class="reservation-cell">${reservation.reservationNo}</div>
				<div class="reservation-cell">${reservation.email}</div>
				<div class="reservation-cell">${reservation.booking_Date}</div>
				<div class="reservation-cell">${reservation.total_Price}</div>
				<div class="reservation-cell">

					<form action="adminUpdate.do" method="post">
					    <input type="hidden" name="reservationNo" value="${reservation.reservationNo}" />
					    <select name="status">
					        <c:forEach items="${selectStatus}" var="status">
					            <c:if test="${reservation.status == status.status_no}">
					                <option value="${status.status_no}" selected>${status.status_name}</option>
					            </c:if>
					            <c:if test="${reservation.status != status.status_no}">
					                <option value="${status.status_no}">${status.status_name}</option>
					            </c:if>
					        </c:forEach>
					    </select>
					    <input type="submit" value="상태 업데이트" />
					</form>


				</div>
				<div class="reservation-cell">
					<form action="${pageContext.request.contextPath}/deleteReservation"
						method="post">
						<input type="hidden" name="reservationNo"
							value="${reservation.reservationNo}" /> <input type="submit"
							value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
					</form>
				</div>
			</div>
			<div class="reservation-row">
				<div class="reservation-cell" colspan="7">
					<button onclick="togglePassengers(${reservation.reservationNo})">승객
						목록 보기/숨기기</button>
					<div id="passengers-${reservation.reservationNo}"
						class="passenger-list">
						<h3>승객 목록</h3>
						<div class="passenger-header">
							<div class="passenger-cell">승객 번호</div>
							<div class="passenger-cell">이름</div>
							<div class="passenger-cell">성</div>
							<div class="passenger-cell">생년월일</div>
							<div class="passenger-cell">국적</div>
							<div class="passenger-cell">여권 번호</div>
							<div class="passenger-cell">작업</div>
						</div>
						<c:forEach var="passenger"
							items="${passengersMap[reservation.reservationNo]}">
							<div class="passenger-row">
								<div class="passenger-cell">${passenger.passengerNo}</div>
								<div class="passenger-cell">${passenger.first_name}</div>
								<div class="passenger-cell">${passenger.last_name}</div>
								<div class="passenger-cell">${passenger.birth}</div>
								<div class="passenger-cell">${passenger.nationality}</div>
								<div class="passenger-cell">${passenger.passport_number}</div>
								<div class="passenger-cell">
									<form
										action="${pageContext.request.contextPath}/deletePassenger"
										method="post">
										<input type="hidden" name="passengerNo"
											value="${passenger.passengerNo}" /> <input type="submit"
											value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
									</form>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

</body>
</html>
