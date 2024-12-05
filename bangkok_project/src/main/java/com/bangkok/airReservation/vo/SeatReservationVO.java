package com.bangkok.airReservation.vo;

import java.util.List;

import lombok.Data;

@Data
public class SeatReservationVO {
    private Long seatReservationNo; // 예약 좌석 번호
    private Long reservationNo;    // 예약 번호
    private Long seatNo;           // 좌석 번호
    private Long adultPassengerNo; // 예약 좌석 번호
    private Long childPassengerNo; // 예약 좌석 번호
    private Long infantPassengerNo; // 예약 좌석 번호
    
    public List<SeatReservationVO> reservations;
    public List<SeatReservationVO> reservationsD;
    public List<SeatReservationVO> reservationsA;
}
