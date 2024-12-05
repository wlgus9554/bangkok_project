package com.bangkok.airReservation.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bangkok.airReservation.vo.SeatReservationVO;
import com.bangkok.airReservation.vo.SeatVO;

public interface SeatService {
	
	 public List<SeatVO> getASeats(Long scheduleId_a);
	 
	 public List<SeatVO> getDSeats(Long scheduleId_d);
	 
	 public List<SeatVO> getDSeatsReserved(@Param("scheduleId_d") Long scheduleId_d, Long reservationNo);
		
	 public List<SeatVO> getASeatsReserved(@Param("scheduleId_a") Long scheduleId_a, Long reservationNo);
	 
	 public List<Long> seatReservedList(Long reservationNo);
	 
	 public Integer reservationDSeat(List<SeatVO> seats, List<SeatReservationVO> reservations,  
			 Long reservationNo, Long scheduleId_d);
	 
	 public Integer reservationASeat(List<SeatVO> seats, List<SeatReservationVO> reservations,  
			 Long reservationNo, Long scheduleId_a);

	 public Integer deleteReservedSeat(List<Long> reservedSeats, Long reservationNo, List<Long> scheduleID);
	 

}