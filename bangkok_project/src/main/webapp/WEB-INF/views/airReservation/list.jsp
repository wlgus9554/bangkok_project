<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 목록 페이지</title>
    
    <style>
        
        .container {
            max-width: 1200px;
            width: 100%;
            background-color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            padding: 30px;
            animation: fadeIn 1s ease-in-out;
            max-height: 90vh;
            overflow-y: auto;
            margin: 0 auto;
        }
        
        h2 {
            font-size: 32px;
            color: #d35400; /* 주황색 톤 */
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
        }
        
        .reservation-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .reservation-card, .reservation-card-cancel {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 25px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            border: 1px solid #e0e0e0;
        }
        
        .reservation-card-cancel {
            background-color: #fdf2e9; /* 연한 주황색 배경 */
            cursor: not-allowed;
        }
        
        .reservation-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.2);
        }
        
        .reservation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 20px;
            color: #d35400; /* 주황색 톤 */
            margin-bottom: 20px;
            position: relative;
        }
        
        .highlight {
            background-color: #ffe5d0; /* 주황색 계열의 배경 */
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            color: #d35400; /* 주황색 텍스트 */
            font-weight: bold;
            cursor: pointer;
            margin-right: 5px;
            transition: background-color 0.3s ease;
        }
        
        .highlight:hover {
            background-color: #ffd1a3; /* 호버 시 약간 진한 주황색 */
        }
        
        .arrow {
            font-size: 18px;
            cursor: pointer;
            transition: transform 0.3s ease;
            color: #d35400; /* 주황색 톤 */
        }
        
        .rotate {
            transform: rotate(180deg);
        }
        
        .info-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .info-row div {
            width: 48%;
            font-size: 16px;
            color: #555555;
            margin-bottom: 8px;
        }
        
        .summary {
            margin-top: 15px;
            font-weight: bold;
            color: #e67e22; /* 주황색 계열 */
            font-size: 18px;
            cursor: pointer;
        }
        
        .buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 10px;
        }
        
        .button {
            background-color: #e67e22; /* 주황색 버튼 */
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 25px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        
        .button.refund {
            background-color: #d35400; /* 진한 주황색 */
        }
        
        .button:hover {
            background-color: #cf711f; /* 호버 시 약간 어두운 주황색 */
            transform: translateY(-2px);
        }
        
        .button.refund:hover {
            background-color: #ba4a00; /* 환불 버튼 호버 시 */
            transform: translateY(-2px);
        }
        
        .additional-details {
            display: none;
            margin-top: 20px;
            background-color: #fff4e6; /* 연한 주황색 배경 */
            border-radius: 8px;
            padding: 20px;
            animation: slideDown 0.5s ease-in-out forwards;
            font-size: 16px;
            color: #2c3e50;
        }
        
        .additional-details p {
            margin: 8px 0;
        }
        
        /* Modal Styles */
        .modal-header {
            background-color: #e67e22; /* 주황색 모달 헤더 */
            color: #ffffff;
            border-bottom: none;
            padding: 20px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        
        .modal-title {
            margin: 0;
            font-size: 20px;
        }
        
        .close {
            color: #ffffff;
            font-size: 24px;
            font-weight: bold;
            border: none;
            background: none;
            cursor: pointer;
        }
        
        .modal-content {
            border-radius: 10px;
            overflow: hidden;
        }
        
        .modal-body {
            padding: 20px;
            background-color: #ffffff;
        }
        
        .modal-footer {
            padding: 15px 20px;
            background-color: #fff4e6; /* 연한 주황색 */
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 15px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            margin-top: 10px;
        }
        
        /* Animations */
        @keyframes fadeIn { 
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes slideDown { 
            0% {
                max-height: 0;
                opacity: 0;
            }
            100% {
                max-height: 500px;
                opacity: 1;
            }
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .info-row div {
                width: 100%;
            }
            
            .buttons {
                flex-direction: column;
                align-items: stretch;
            }
            
            .button {
                width: 100%;
            }
        }
    </style>
    
    <!-- jQuery CDN (필요 시) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        // 상세보기 토글
        function toggleDetails(element) {
            const card = $(element).closest('.reservation-card');
            const details = card.find('.additional-details');
            const arrow = card.find('.arrow');
    
            details.slideToggle(300);
            arrow.toggleClass('rotate');
        }
    
        // 예약 상세보기 페이지로 이동 (토글 버튼이 아닌 카드 클릭 시 이동)
        $(document).on('click', '.reservation-card', function(event) {
            // arrow 또는 refund 버튼 또는 reservationLabel이 클릭된 경우에는 이동하지 않도록 막음
            if (!$(event.target).closest('.arrow').length && 
                !$(event.target).closest('.button.refund').length && 
                !$(event.target).closest('.highlight').length) {
                const reservationNo = $(this).find('.reservationNo').val();
                location.href = "view.do?reservationNo=" + reservationNo;
            }
        });
    
        // 예약 번호 복사 기능
        function copyReservationLabel(reservationLabel) {
            navigator.clipboard.writeText(reservationLabel).then(() => {
                alert('예약 번호가 복사되었습니다: ' + reservationLabel);
            }, (err) => {
                alert('복사 실패: ' + err);
            });
        }
        
        // 모달 열기 시 예약번호 설정
        $(document).on('click', '.button.refund', function(event) {
            event.stopPropagation(); // 카드 클릭 이벤트 방지
            const reservationNo = $(this).closest('.reservation-card, .reservation-card-cancel').find('.reservationNo').val();
            $('#modalReservationNo').val(reservationNo);
            $('#deleteModal').modal('show');
        });
    </script>
    
    <!-- Bootstrap CSS & JS (모달 기능 사용을 위해 추가) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
</head>
<body>

    <div class="container">
        <h2>예약 목록</h2>
        <div class="reservation-list">

            <!-- 예약 카드 목록 -->
            <c:forEach items="${list}" var="vo" varStatus="status">
                <c:if test="${vo.status == '완료됨'}">
                    <div class="reservation-card">
                        <input type="hidden" class="reservationNo" value="${vo.reservationNo}">
    
                        <div class="reservation-header">
                            <h2>
                                <span class="highlight" onclick="copyReservationLabel('${vo.reservationLabel}')">${vo.email}</span>님의 예약번호는 
                                <input type="text" class="highlight" value="${vo.reservationLabel}" readonly />입니다
                            </h2>
                            <div class="arrow" onclick="toggleDetails(this)">▼</div>
                        </div>
                        <div class="info-row">
                            <div><strong>출발:</strong> ${vo.departure}</div>
                            <div><strong>도착:</strong> ${vo.arrival}</div>
                        </div>
                        <div class="info-row">
                            <div><strong>항공사:</strong> ${vo.flightName}</div>
                        </div>
                        <div class="info-row">
                            <div><strong>출발날짜:</strong> ${vo.departureTime}</div>
                            <div><strong>도착날짜:</strong> ${vo.arrivalTime}</div>
                        </div>
                        <div class="summary">총 결제 금액: ${vo.total_Price}원</div>
                        <div class="buttons">
                            <button class="button refund">환불</button>
                        </div>
                        <div class="additional-details">
                            <p><strong>출발:</strong> ${vo.departure}</p>
                            <p><strong>도착:</strong> ${vo.arrival}</p>
                            <p><strong>항공사:</strong> ${vo.flightName}</p>
                            <p><strong>왕복 / 편도:</strong> ${vo.type}</p>
                            <p><strong>상태:</strong> ${vo.status}</p>
                            <c:choose>
                                <c:when test="${vo.classNo == 1}">
                                    <p><strong>좌석 등급:</strong> 일반석</p>
                                </c:when>
                                <c:when test="${vo.classNo == 2}">
                                    <p><strong>좌석 등급:</strong> 비즈니스석</p>
                                </c:when>
                                <c:when test="${vo.classNo == 3}">
                                    <p><strong>좌석 등급:</strong> 일등석</p>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${empty vo.seatID}">
                                    <p><strong>좌석 ID:</strong></p><p style="color:#e67e22;">좌석을 예약해주세요!</p>
                                </c:when>
                                <c:otherwise>
                                    <p><strong>좌석 ID:</strong> ${vo.seatID}</p>
                                </c:otherwise>
                            </c:choose>
                            <p><strong>성인 탑승객 수:</strong> ${vo.adult_count}</p>
                            <p><strong>소아 탑승객 수:</strong> ${vo.child_count}</p>
                            <p><strong>유아 탑승객 수:</strong> ${vo.infant_count}</p>
                        </div>
                    </div>
                </c:if>
                <c:if test="${vo.status != '완료됨'}">
                    <div class="reservation-card-cancel">
                        <input type="hidden" class="reservationNo" value="${vo.reservationNo}">
                        <div class="reservation-header">
                            <h2>${vo.email}</h2>
                            <p><strong>상태:</strong> ${vo.status}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <!-- 예약 취소 모달 -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title" id="deleteModalLabel">예약을 취소하려면 예약번호를 입력 해주세요.</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
                </div>
                
                <form action="delete.do" method="post">
                    <div class="modal-body">
                        <c:forEach items="${reservedSeat}" var="vo" varStatus="status">
                            <input type="hidden" name="reservedSeats[${status.index}]" value="${vo}"> <!-- 좌석 번호 전송 -->
                        </c:forEach>
                        <c:forEach items="${reservationSchedule}" var="rs">
                            <input type="hidden" name="scheduleID" value="${rs}">
                        </c:forEach>
                        <input type="hidden" name="reservationNo" id="modalReservationNo">
                        <input type="hidden" name="status" value="취소됨">
                        <div class="form-group">
                            <input class="form-control" name="reservationLabel" type="text" id="reservationLabel" placeholder="예약 번호를 입력하세요." required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="button refund">예약 취소</button>
                        <button type="button" class="button" data-dismiss="modal">취소</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

</body>
</html>
