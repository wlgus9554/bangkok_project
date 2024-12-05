<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>항공 예약 상세</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff8f0; /* 연한 주황색 배경 */
            color: #444;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        h1, h2 {
            color: #d35400; /* 주황색 톤 */
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }

        .info-section, .reservation-group {
            margin-bottom: 40px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #ececec;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-row strong {
            width: 180px;
            color: #d35400; /* 주황색 강조 */
        }

        .info-row span {
            color: #555555;
        }

        .reservation-group {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
        }

        .reservation-card {
            flex: 1 1 calc(48%);
            padding: 25px;
            border: 1px solid #ebebeb;
            border-radius: 15px;
            background-color: #fff4e6; /* 연한 주황색 배경 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s ease, transform 0.2s ease;
        }

        .reservation-card:hover {
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            transform: translateY(-5px);
        }

        .btn, .changePassportBtn {
            padding: 12px 25px;
            background-color: #e67e22; /* 주황색 버튼 */
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            display: inline-block;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 16px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn:hover, .changePassportBtn:hover {
            background-color: #d35400; /* 호버 시 진한 주황색 */
            transform: translateY(-2px);
        }

        /* Change Passport Button Specific Styles */
        .changePassportBtn {
            background-color: #f39c12; /* 비밀번호 변경 버튼 주황색 */
        }

        .changePassportBtn:hover {
            background-color: #e67e22;
        }

        /* 탑승객 목록 표 스타일 */
        .passenger-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .passenger-table th, .passenger-table td {
            border: 1px solid #ececec;
            padding: 12px 15px;
            text-align: center;
        }

        .passenger-table th {
            background-color: #ffe5d0;
            color: #d35400;
            font-weight: 600;
        }

        .passenger-table tr:nth-child(even) {
            background-color: #fff4e6;
        }

        .passenger-table tr:hover {
            background-color: #fdebd0;
        }

        /* Modal Styles */
        .modal-content {
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            border-bottom: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 22px;
            font-weight: 600;
            color: #d35400; /* 주황색 제목 */
        }

        .close {
            font-size: 24px;
            color: #d35400;
            border: none;
            background: none;
            cursor: pointer;
        }

        .modal-body {
            padding-top: 15px;
        }

        .modal-footer {
            border-top: none;
            display: flex;
            justify-content: flex-end;
            padding-top: 15px;
            gap: 10px;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .form-control:focus {
            border-color: #d35400; /* 주황색 포커스 */
            box-shadow: 0 0 8px rgba(211, 84, 0, 0.2);
            outline: none;
        }

        .btn-danger {
            background-color: #e74c3c;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .btn-secondary {
            background-color: #95a5a6;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        /* 경고 메시지 스타일 */
        .alert-warning-custom {
            background-color: #ffe5d0;
            color: #d35400;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: center;
            font-weight: 600;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .reservation-card {
                flex: 1 1 100%;
            }

            .info-row {
                flex-direction: column;
                align-items: flex-start;
            }

            .info-row strong {
                width: 100%;
                margin-bottom: 5px;
            }

            .btn, .changePassportBtn {
                width: 100%;
                text-align: center;
            }

            .passenger-table th, .passenger-table td {
                padding: 10px;
                font-size: 14px;
            }

            .modal-content {
                padding: 15px;
            }

            .modal-title {
                font-size: 20px;
            }

            .form-control {
                padding: 10px;
                font-size: 14px;
            }

            .btn, .changePassportBtn {
                font-size: 14px;
                padding: 10px 15px;
            }
        }
    </style>

    <!-- jQuery CDN (필요 시) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap CSS & JS (모달 기능 사용을 위해 추가) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function() {
            // 현재 날짜
            const now = new Date();

            // 출발 시간 (서버에서 전달된 데이터)
            const departureTime = new Date('${vo.departureTime}');

            // 날짜 차이 계산 (밀리초 -> 일 변환)
            const diffInTime = departureTime.getTime() - now.getTime();
            const diffInDays = diffInTime / (1000 * 60 * 60 * 24);

            // 3일 미만이면 여권 수정 버튼을 숨기고 안내 메시지 출력
            if (diffInDays < 3) {
                $('#passportMsg').text('출국까지의 기간이 3일밖에 안남아서 여권 변경 불가');
                $('.changePassportBtn').hide();
            }
        });

        // 모달 데이터 설정
        $('#updateModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var passengerNo = button.data('passenger-no');
            var reservationNo = button.data('reservation-no');
            var passengerType = button.data('passenger-type');

            var modal = $(this);
            modal.find('input[name="passengerNo"]').val(passengerNo);
            modal.find('input[name="reservationNo"]').val(reservationNo);
            modal.find('input[name="passenger_type"]').val(passengerType);
            modal.find('input[name="existingPassportNumber"]').val(button.closest('.info-row').find('span').eq(5).text());
        });
    </script>
</head>
<body>
    <div class="container">
        <h1>항공 예약 상세</h1>

        <h2>예약 정보</h2>
  
        <div class="reservation-group">
            <c:forEach var="vo" items="${reservation}">
                <div class="reservation-card">
                    <div class="info-row"><strong>이메일:</strong> <span>${vo.email}</span></div>
                    <div class="info-row"><strong>출발:</strong> <span>${vo.departure}</span></div>
                    <div class="info-row"><strong>도착:</strong> <span>${vo.arrival}</span></div>
                    <div class="info-row"><strong>총 가격:</strong> <span>${vo.total_Price} 원</span></div>
                    <div class="info-row"><strong>예약 날짜:</strong> <span>${vo.booking_Date}</span></div>
                    <div class="info-row"><strong>결제 방법:</strong> <span>${vo.paymentMethod}</span></div>
                    <div class="info-row"><strong>비행기 이름:</strong> <span>${vo.flightName}</span></div>
                    <div class="info-row"><strong>좌석 등급:</strong> <span>
                        <c:choose>
                            <c:when test="${vo.classNo == 1}">일반석</c:when>
                            <c:when test="${vo.classNo == 2}">비즈니스석</c:when>
                            <c:when test="${vo.classNo == 3}">일등석</c:when>
                            <c:otherwise>알 수 없음</c:otherwise>
                        </c:choose>
                    </span></div>
                </div>
            </c:forEach>
        </div>

        <h2>탑승객 목록</h2>
        <div class="info-section">
            <table class="passenger-table">
                <thead>
                    <tr>
                        <th>탑승객 번호</th>
                        <th>이름</th>
                        <th>성</th>
                        <th>생일</th>
                        <th>국적</th>
                        <th>여권 번호</th>
                        <th>성별</th>
                        <th>탑승객 유형</th>
                        <th>여권번호 수정</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="passenger" items="${passengers}">
                        <tr>
                            <td>${passenger.passengerNo}</td>
                            <td>${passenger.first_name}</td>
                            <td>${passenger.last_name}</td>
                            <td>${passenger.birth}</td>
                            <td>${passenger.nationality}</td>
                            <td>${passenger.passport_number}</td>
                            <td>${passenger.gender}</td>
                            <td>${passenger.passenger_type}</td>
                            <td>
                                <button class="changePassportBtn" 
                                        data-toggle="modal" 
                                        data-target="#updateModal" 
                                        data-passenger-no="${passenger.passengerNo}" 
                                        data-reservation-no="${passenger.reservationNo}" 
                                        data-passenger-type="${passenger.passenger_type}">
                                    여권 수정
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div id="passportMsg" style="color: #d35400; font-weight: bold; text-align: center; margin-top: 15px;"></div>
        </div>

        <div style="text-align: center;">
            <a href="list.do" class="btn">뒤로</a>
            <c:if test="${reservation != null && !empty reservation}">
                <c:set var="hasEmptySeatID" value="false" />
                <c:set var="hasReservedSeatID" value="false" /> <!-- 예약된 좌석 여부 -->
            
                <c:forEach items="${reservation}" var="vo">
                    <c:if test="${vo.seatID == null || vo.seatID == ''}">
                        <c:set var="hasEmptySeatID" value="true" />
                    </c:if>
                    <c:if test="${vo.seatID != null && !empty vo.seatID}">
                        <c:set var="hasReservedSeatID" value="true" /> <!-- 예약된 좌석이 있는 경우 -->
                    </c:if>
                </c:forEach>
            
                <c:if test="${hasReservedSeatID}">
                    <div class="alert-warning-custom">
                        이미 좌석을 예약했습니다.
                    </div> <!-- 메시지 표시 -->
                </c:if>
            
                <c:if test="${hasEmptySeatID}">
                    <form action="/seat/seatDlist.do" method="post" style="margin-top: 20px;">
                        <c:forEach items="${reservation}" var="vo">
                            <c:if test="${vo.seatID == null || vo.seatID == ''}">
                                <input type="hidden" name="scheduleID" value="${vo.scheduleId_a}">
                                <input type="hidden" name="classNo" value="${vo.classNo}">
                                <input type="hidden" name="reservationNo" value="${vo.reservationNo}">
                            </c:if>
                        </c:forEach>
                        <button class="btn">좌석 예약하러 가기</button>
                    </form>
                </c:if>
            </c:if>
        </div>
    </div>

    <!-- 여권 수정 모달 -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="updateModalLabel">여권번호 수정</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form action="update.do" method="post">
                    <input type="hidden" name="passengerNo" value="">
                    <input type="hidden" name="reservationNo" value="">
                    <input type="hidden" name="passenger_type" value="">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="existingPassportNumber"><strong>기존 여권번호</strong></label>
                            <input class="form-control" name="existingPassportNumber" type="text" id="passportNum" value="" readonly>
                            
                            <label for="passportEnddate"><strong>여권 만료일</strong></label>
                            <input class="form-control" name="passport_enddate" type="date" id="passportEnddate" required>
                            
                            <label for="newPassportNum"><strong>새 여권번호</strong></label>
                            <input class="form-control" name="passport_number" type="text" id="newPassportNum" required>
                        </div>
                        <div id="passportMsg" style="color: #d35400; font-weight: bold; text-align: center;"></div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-danger" type="submit">수정</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
