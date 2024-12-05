package com.bangkok.airReservation.mapper;

import com.bangkok.airReservation.vo.SeatReservationVO;
import com.bangkok.airReservation.vo.SeatVO;

import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface SeatMapper {

	// 전체 좌석 조회
	
	public List<SeatVO> getDSeats(@Param("scheduleId_d") Long scheduleId_d);
	
	public List<SeatVO> getASeats(@Param("scheduleId_a") Long scheduleId_a);

	// 예약 스케줄 좌석조회
	public List<SeatVO> getDSeatsReserved(@Param("scheduleId_d") Long scheduleId_d, @Param("reservationNo") Long reservationNo);
	
	public List<SeatVO> getASeatsReserved(@Param("scheduleId_a") Long scheduleId_a, @Param("reservationNo") Long reservationNo);
	
	// 좌석 예약
	public Integer updateDPassengerSeats(@Param("seats") List<SeatVO> seats, @Param("scheduleId_d")Long scheduleId_d);
	public Integer updateAPassengerSeats(@Param("seats") List<SeatVO> seats, @Param("scheduleId_a")Long scheduleId_a);

    // 예약된 좌석 정보 삽입
	public Integer insertSeatReservations(@Param("reservations") List<SeatReservationVO> reservations,
			@Param("reservationNo") Long reservationNo, @Param("seats") List<SeatVO> seats);
	
	/*
	 * public Integer insertSeatAReservations(@Param("reservations")
	 * List<SeatReservationVO> reservations,
	 * 
	 * @Param("reservationNo") Long reservationNo, @Param("seats") List<SeatVO>
	 * seats);
	 */

	// 예약 취소
	
	public List<Long> seatReservedList(@Param("reservationNo") Long reservationNo);
	public Integer cancelSeatReservations(@Param("reservedSeats") List<Long> reservedSeats,
			@Param("reservationNo") Long reservationNo);

	// 좌석 상태 업데이트 (예약 취소 시)
	public Integer updateSeatsOnCancellation(@Param("reservedSeats") List<Long> reservedSeats, @Param("scheduleID")List<Long> scheduleID);


}
