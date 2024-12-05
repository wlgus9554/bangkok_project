package com.bangkok.airReservation.vo;

import java.util.List;

import lombok.Data;

@Data
public class SeatVO {
	private Long seatNo;        // 좌석 번호
    private Long seatRow;       // 좌석 행
    private String seatID;        // 좌석 ID
    private String seatCol;       // 좌석 열
    private Integer classNo;       // 클래스 번호
    private String scheduleID;    // 스케줄 ID
    private String status;        // 좌석 상태
    private Long passengerNo;
    
    public List<SeatVO> seats; 
    public List<SeatVO> seatD; 
    public List<SeatVO> seatA; 
    
}
