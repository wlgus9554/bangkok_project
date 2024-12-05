<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Seat Selection</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style>
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
}


.nav-pills .nav-link {
    border-radius: 20px; /* 부드러운 모서리 */
    background-color: #ffe0b2; /* 밝은 주황색 */
    color: #ff9800; /* 진한 주황색 */
    margin: 5px; /* 간격 추가 */
    transition: background-color 0.3s, color 0.3s;
}

.nav-pills .nav-link:hover {
    background-color: #ffcc80; /* 연한 주황색 */
    color: white; /* 흰색 글자 */
}

.nav-pills .nav-link.active {
    background-color: #ff9800; /* 진한 주황색 */
    color: white; /* 흰색 글자 */
}

.box {
    padding: 20px;
    border: 1px solid #ffcc80; /* 연한 주황색 */
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(255, 165, 0, 0.2);
    margin-bottom: 20px;
    background-color: white;
}

.seat-box {
    text-align: center;
    width: 60px;
    height: 60px;
    line-height: 60px;
    margin: 5px;
    border-radius: 5px;
    border: 1px solid #ffb74d; /* 중간 주황색 */
    background-color: #ffe0b2; /* 밝은 주황색 */
    transition: background-color 0.3s, transform 0.2s;
    cursor: pointer;
}

.seat-box:hover {
    transform: scale(1.05);
}

.seat-box.open {
    background-color: #ffcc80; /* 연한 주황색 */
}

.seat-box.choose {
    background-color: #ff9800; /* 진한 주황색 */
    color: white;
}

.seat-box.blocked {
    background-color: #d6d8db; /* 회색 */
    border: 1px solid #aaa; /* 어두운 회색 */
    cursor: not-allowed;
}

.seat-box.exit {
    background-color: #ffcc80; /* 연한 주황색 */
}

.toilet-box {
    text-align: center;
    width: 60px;
    height: 60px;
    line-height: 60px;
    margin: 5px;
    border-radius: 5px;
    border: 1px solid #ffb74d; /* 중간 주황색 */
    background-color: #ffe0b2; /* 밝은 주황색 */
}

.toilet > img {
    width: 40px;
    height: 40px;
}

.passenger-info {
    background-color: #ff9800; /* 진한 주황색 */
    color: white;
    padding: 15px;
    border-radius: 5px;
    margin-bottom: 10px;
}

.btn {
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s, transform 0.2s;
}

.btn-warning {
    background-color: #ff9800; /* 진한 주황색 */
    color: white;
}

.btn-warning:hover {
    background-color: #e67e22; /* 더 어두운 주황색 */
}

.btn-secondary {
    background-color: #ffb74d; /* 중간 주황색 */
    color: white;
}

.btn-secondary:hover {
    background-color: #ffa726; /* 더 어두운 주황색 */
}

h5 {
    border-bottom: 2px solid #ffcc80; /* 연한 주황색 */
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.row {
    margin-bottom: 20px; /* 간격 조정 */
}

.passengers.selected {
    background-color: #ff9800; /* 진한 주황색 배경 */
    color: white; /* 흰색 글자 */
}

.alert {
    margin-bottom: 15px;
}

.passenger-list {
    margin-top: 10px;
}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function() {
    let seatCnt = 0; // 선택된 좌석 수
    let passengerCnt = ${reservation[0].adult_count + reservation[0].child_count + reservation[0].infant_count}; // 승객 수
    let selectedPassengerNo = null; // 선택된 승객 번호 초기화
    let selectedPassengerType = null; // 선택된 승객 타입 초기화
    let selectedSeats = {}; // 각 승객의 타입과 번호에 따라 선택한 좌석을 저장

    // 승객 선택
    $(".passengers").click(function() {
        let passengerType = $(this).data("passenger-type"); // 승객 타입 가져오기
        let passengerNo = $(this).data("passenger-no"); // 승객 번호 가져오기

        selectedPassengerNo = passengerNo; // 선택된 승객 번호
        selectedPassengerType = passengerType; // 선택된 승객 타입
        $(".passengers").removeClass("selected");
        $(this).addClass("selected");
    });

    // 좌석 선택
    $(".seat-box").click(function() {
        let originalSeatID = $(this).text();
        let seatNum = $(this).attr("data-seatNum");

        if (!selectedPassengerNo || !selectedPassengerType) {
            alert("먼저 승객을 선택하세요.");
            return;
        }

        // 타입과 번호를 결합한 고유 키 생성 (예: "adult_1", "child_1")
        let passengerKey = `\${selectedPassengerType}_\${selectedPassengerNo}`;

        // 이미 좌석을 선택한 승객인지 확인
        if (selectedSeats[passengerKey]) {
            alert("이미 이 승객을 위한 좌석이 선택되었습니다. 좌석을 취소한 후 다른 좌석을 선택하세요.");
            return;
        }

        if ($(this).hasClass("open")) {
            seatCnt++;
            $(this).removeClass("open").addClass("choose");

            let seatInput = `<input type="hidden" name="seats[\${seatCnt - 1}].seatID" value="\${originalSeatID}">
                <input name="seats[\${seatCnt - 1}].seatNo" value="\${seatNum}">
                <input name="seats[\${seatCnt - 1}].passengerNo" value="\${selectedPassengerNo}">
                <input name="seats[\${seatCnt - 1}].passengerType" value="\${selectedPassengerType}">
                <input name="reservations[\${seatCnt - 1}].seatNo" value="\${seatNum}">`;
          
            $(".seatInputs").append(seatInput);
            
            console.log($("#seatInputs").html()); // 현재 입력 필드 상태 확인

            // 선택한 좌석을 탑승객 정보 옆에 표시
            $(`.passengers[data-passenger-no='\${selectedPassengerNo}'][data-passenger-type='\${selectedPassengerType}']`).append(`<span id="seat-\${passengerKey}" class="ml-2">(좌석: \${originalSeatID})</span>`);

            // 각 승객에 대해 선택한 좌석 저장
            selectedSeats[passengerKey] = {
                seatID: originalSeatID,
                seatNum: seatNum
            };
        } else if ($(this).hasClass("choose")) {
            $(this).removeClass("choose").addClass("open");

            // 좌석 선택 취소 처리
            delete selectedSeats[passengerKey]; // 해당 승객의 선택 좌석 정보 삭제
            $(`.seatInputs input[value='\${originalSeatID}']`).remove(); // 좌석 정보 삭제
            $(`span#seat-\${passengerKey}`).remove(); // 선택한 좌석 정보 표시 삭제
            seatCnt--;
        }
    });

    function resetSelection() {
        // 선택된 좌석과 승객 정보를 초기화하는 코드
        seatCnt = 0; // 좌석 카운트 초기화
        selectedPassengerNo = null; // 선택한 승객 번호 초기화
        selectedPassengerType = null; // 선택한 승객 타입 초기화
        selectedSeats = {}; // 선택된 좌석 초기화

        // UI 초기화
        $(".passengers").removeClass("selected"); // 승객 선택 초기화
        $(".seat-box").removeClass("choose").addClass("open"); // 모든 좌석을 선택 가능으로 변경
        $(".seatInputs").empty(); // 숨겨진 입력 필드 삭제

        // 선택한 좌석 정보를 탑승객 정보에서 삭제
        $(".passengers span[id^='seat-']").remove(); // 모든 선택된 좌석 정보 삭제
    }

    // 리셋 버튼 클릭 시 초기화 함수 호출
    $("button[type='reset']").click(function() {
        resetSelection();
    });
});


</script>

</head>
<body>
	<div class="container-fluid">
		<div style="border-bottom: 1px solid #e0e0e0;" class="mb-3">
			<h4>항공 좌석 선택</h4>
			<p>아래 여정마다 좌석을 선택할 수 있습니다.</p>
			<ul class="nav nav-pills nav-justified">
				<li class="nav-item"><a class="nav-link active"
					href="/seat/seatDlist.do">가는편</a></li>
				<li class="nav-item"></li>
			</ul>
		</div>

		<div class="row">
			<!-- 왼쪽 좌석 구분 -->
			<div class="col-sm-2">
				<div class="p-4"
					style="border: 1px solid #e0e0e0; border-radius: 10px;">
					<h5>
						<strong>좌석 구분</strong>
					</h5>
					<hr>
					<div class="form-inline mb-3">
						<div class="seat-box open"></div>
						<span>: 선택 가능 좌석</span>
					</div>
					<div class="form-inline mb-3">
						<div class="seat-box choose"></div>
						<span>: 선택한 좌석</span>
					</div>
					<div class="form-inline mb-3">
						<div class="seat-box blocked"></div>
						<span>: 선택 불가</span>
					</div>
					<div class="form-inline mb-3">
						<div class="seat-box exit"></div>
						<span>: 비상구</span>
					</div>
				</div>
			</div>

			<!-- 가운데 좌석 선택 -->
			<div class="col-sm-7">
				<div class="alert alert-warning text-center">
					<strong>모든 좌석에 다음 기능이 있습니다:</strong> <span class="ml-4"><i
						class="material-icons">power</i> 110V AC</span> <span class="ml-4"><i
						class="material-icons">tv</i> 10.6인치 LCD</span>
				</div>



				<div class="box">

					<div class="row binder">

						<div class="col seat-box">
							<i class="material-icons"
								style="font-size: 24px; color: red; text-align: center;">directions_run</i>
						</div>
						<div class="col-2 seat-box kitchen">주방</div>

						<div class="col-2 seat-box kitchen">주방</div>

						<div class="col-2 seat-box kitchen">주방</div>
						<div class="col seat-box">
							<i class="material-icons"
								style="font-size: 24px; color: red; text-align: center;">directions_run</i>
						</div>

					</div>

					<h5>퍼스트 클래스</h5>
					<div class="row justify-content-center">
						<c:forEach var="seat" items="${seats}" varStatus="status">
							<c:if test="${seat.classNo == 3}">
								<div
									class="seat-box ${(seat.classNo == reservation[0].classNo && seat.status == 'available') ? 'open' : 'blocked'}"
									data-seatNum="${seat.seatNo}">${seat.seatID}</div>
								<c:if test="${(status.index + 1) % 4 == 0}">
									<div style="flex-basis: 20px;"></div>
								</c:if>
								<c:if test="${(status.index + 1) % 8 == 0}">
									<div style="flex-basis: 100%; height: 0;"></div>
								</c:if>
							</c:if>
						</c:forEach>
					</div>

					<div class="row binder">
						<div class="col seat-box"></div>
						<div class="col seat-box"></div>
						<div class="col-2 seat-box toilet">
							<img src="/upload/air/toilet.png">
						</div>
						<div class="col seat-box"></div>
						<div class="col-2 seat-box toilet">
							<img src="/upload/air/toilet.png">
						</div>
						<div class="col seat-box"></div>
						<div class="col-2 seat-box toilet">
							<img src="/upload/air/toilet.png">
						</div>
						<div class="col seat-box"></div>
						<div class="col seat-box"></div>
					</div>


					<h5>비즈니스 클래스</h5>
					<div class="row justify-content-center">
						<c:forEach var="seat" items="${seats}" varStatus="status">
							<c:if test="${seat.classNo == 2}">
								<div
									class="seat-box ${seat.classNo == reservation[0].classNo && seat.status == 'available' ? 'open' : 'blocked'}"
									data-seatNum="${seat.seatNo}">${seat.seatID}</div>
								<c:if test="${(status.index + 1) % 4 == 0}">
									<div style="flex-basis: 20px;"></div>
								</c:if>
								<c:if test="${(status.index + 1) % 8 == 0}">
									<div style="flex-basis: 100%; height: 0;"></div>
								</c:if>
							</c:if>
						</c:forEach>
					</div>

					<div class="row binder">
						<div class="col seat-box"></div>
						<div class="col seat-box"></div>
						<div class="col-2 seat-box toilet">
							<img src="/upload/air/toilet.png">
						</div>
						<div class="col seat-box"></div>
						<div class="col-2 seat-box toilet">
							<img src="/upload/air/toilet.png">
						</div>
						<div class="col seat-box"></div>
						<div class="col-2 seat-box toilet">
							<img src="/upload/air/toilet.png">
						</div>
						<div class="col seat-box"></div>
						<div class="col seat-box"></div>
					</div>

					<h5>이코노미 클래스</h5>
					<div class="row justify-content-center">
						<c:forEach var="seat" items="${seats}" varStatus="status">
							<c:if test="${seat.classNo == 1}">
								<div
									class="seat-box ${seat.classNo == reservation[0].classNo && seat.status == 'available' ? 'open' : 'blocked'}"
									data-seatNum="${seat.seatNo}">${seat.seatID}</div>
								<c:if test="${(status.index + 1) % 4 == 0}">
									<div style="flex-basis: 20px;"></div>
								</c:if>
								<c:if test="${(status.index + 1) % 8 == 0}">
									<div style="flex-basis: 100%; height: 0;"></div>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>

			<!-- 오른쪽 탑승객 정보 -->
			<div class="col-sm-3">
				<div class="passenger-info">
					<h5>
						<strong>여정 정보</strong>
					</h5>
					<p>예약번호: ${reservation[0].reservationNo}</p>
					<p>예약자 이메일: ${reservation[0].email}</p>
					<p>총 금액: ${reservation[0].total_Price}</p>
					<p>항공사: ${reservation[0].airlinekor} (${reservation[0].airlineEng})</p>
					<p>출발 시간: ${reservation[0].departureTime}</p>
					<p>도착 시간: ${reservation[0].arrivalTime}</p>
				</div>

				<div class="box">
					<h5>승객 정보</h5>
					<div class="form-group">
						<div class="passenger-info">성인: ${reservation[0].adult_count},
							소아: ${reservation[0].child_count}, 유아: ${reservation[0].infant_count}</div>
						<div class="passenger-list">
							<c:forEach items="${passengers}" var="passenger">
								<div class="alert passengers"
									data-passenger-no="${passenger.passengerNo}"
									data-passenger-type="${passenger.passenger_type}">
									<strong>${passenger.first_name} ${passenger.last_name}
										(${passenger.gender})</strong> - <small>${passenger.passenger_type}</small>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>



				<form action="seatReservationA.do" method="post">
					<h3>좌석 선택</h3>
					<input type="hidden" name="reservationNo"
						value="${reservation[0].reservationNo }">
					<div id="seatInputs" style="display: none;"></div>

					<c:forEach items="${passengers }" var="passenger"
						varStatus="status">
						<c:if test="${passenger.passenger_type == '성인' }">
							<input type="hidden"
								name="reservations[${status.index}].adultPassengerNo"
								value="${passenger.passengerNo}">
							<input type="hidden"
								name="reservations[${status.index}].childPassengerNo" value="">
							<input type="hidden"
								name="reservations[${status.index}].infantPassengerNo" value="">
						</c:if>
						<c:if test="${passenger.passenger_type == '소아' }">
							<input type="hidden"
								name="reservations[${status.index}].adultPassengerNo" value="">
							<input type="hidden"
								name="reservations[${status.index}].childPassengerNo"
								value="${passenger.passengerNo}">
							<input type="hidden"
								name="reservations[${status.index}].infantPassengerNo" value="">
						</c:if>
						<c:if test="${passenger.passenger_type == '유아' }">
							<input type="hidden"
								name="reservations[${status.index}].adultPassengerNo" value="">
							<input type="hidden"
								name="reservations[${status.index}].childPassengerNo" value="">
							<input type="hidden"
								name="reservations[${status.index}].infantPassengerNo"
								value="${passenger.passengerNo}">
						</c:if>
						<c:forEach items="${reservation }" var="vo">
							<input type="hidden" name = "scheduleID" value="${vo.scheduleId_a }">
						</c:forEach>

					</c:forEach>
					<button class="btn btn-secondary" type="reset">다시 선택</button>
					<button class="btn btn-warning" type="submit">예약하기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
