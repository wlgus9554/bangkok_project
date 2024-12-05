package com.bangkok.airReservation.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class AirReservationVO {
	
	// 예약 정보
	private Long reservationNo;  // 예약 번호
	private String reservationLabel;
	private String r_lastName;
	private String r_firstName;
	private String email;        // 이메일
	private Long total_Price;    // 총 가격
	private Date booking_Date;    // 예약일
	private String paymentMethod; // 결제 방식
	private String status;       // 예약 상태
	private String flightName;   // 항공편 이름

	// 항공 예약에서 받아오는 정보
	private Integer aPassenger; // 성인 승객 수
	private Integer cPassenger; // 아동 승객 수
	private Integer iPassenger; // 유아 승객 수
	private Long scheduleId_a;
	private Long scheduleId_d;
	private Long[] scheduleID;  

	// 첫번째 구간
	private String firstDeparture;  // 첫 출발지
	private String firstArrival;    // 첫 도착지
	private String secondDeparture; // 두 번째 출발지 (환승)
	private String secondArrival;   // 두 번째 도착지 (환승)
	private Date departureTime;     // 출발 시간
	private Date arrivalTime;       // 도착 시간
	private Long departPrice;       // 출발지 가격
	private Long arrivePrice;       // 도착지 가격
	private String duration;        // 비행 소요 시간
	private String seatGrade;       // 좌석 등급
	private String seatID;         // 좌석 ID들
	private String seatNo;         // 좌석 ID들
	private Long classNo;       // 도착지 가격
	private String type;            // 왕복 / 편도 여부
	
	private String arrival;
	private String departure;
	private String airlinekor;
	private String airlineEng;
	private Integer adult_count;
	private Integer child_count;
	private Integer infant_count;
	


	
	// 예약 목록
	public List<AirReservationVO> list; // AirReservation 목록
}
