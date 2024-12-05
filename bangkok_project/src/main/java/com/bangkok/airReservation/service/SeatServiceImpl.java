package com.bangkok.airReservation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.airReservation.mapper.SeatMapper;
import com.bangkok.airReservation.vo.SeatReservationVO;
import com.bangkok.airReservation.vo.SeatVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("SeatServiceImpl")
public class SeatServiceImpl implements SeatService{
	
	@Inject
	private SeatMapper mapper;
	
	// 좌석 리스트
	@Override
	public List<SeatVO> getASeats(Long scheduleId_a) {
		// TODO Auto-generated method stub
		return mapper.getASeats(scheduleId_a);
	}
	
	// 좌석 예약 보기

	@Override
	public List<SeatVO> getDSeats(Long scheduleId_d) {
		// TODO Auto-generated method stub
		return mapper.getDSeats(scheduleId_d);
	}

	@Override
	public List<SeatVO> getDSeatsReserved(Long scheduleId_d, Long reservationNo) {
		// TODO Auto-generated method stub
		return mapper.getDSeatsReserved(scheduleId_d, reservationNo);
	}

	@Override
	public List<SeatVO> getASeatsReserved(Long scheduleId_a, Long reservationNo) {
		// TODO Auto-generated method stub
		return mapper.getASeatsReserved(scheduleId_a, reservationNo);
	}
	
	
	@Override
	public List<Long> seatReservedList(Long reservationNo) {
		// TODO Auto-generated method stub
		return mapper.seatReservedList(reservationNo);
	}

	@Override
	public Integer reservationDSeat(List<SeatVO> seats, List<SeatReservationVO> reservations,
			Long reservationNo, Long scheduleId_d) {
		
		Integer result = 0;
		log.info("탑승자 번호" + seats.get(0).getPassengerNo());
		log.info("좌석 번호" + reservations.get(0).getSeatNo());
		
		result = mapper.insertSeatReservations(reservations, reservationNo, seats);

		result = mapper.updateDPassengerSeats(seats, scheduleId_d);
	
        
		return result;
	}
	
	@Override
	public Integer reservationASeat(List<SeatVO> seats, List<SeatReservationVO> reservations, Long reservationNo,
			Long scheduleId_a) {
		
		Integer result = 0;
		log.info("탑승자 번호" + seats.get(0).getPassengerNo());
		log.info("좌석 번호" + reservations.get(0).getSeatNo());
		
		result = mapper.insertSeatReservations(reservations, reservationNo, seats);
		result = mapper.updateAPassengerSeats(seats, scheduleId_a);
		
		return result;
	}


	@Override
	public Integer deleteReservedSeat(List<Long> reservedSeats, Long reservationNo, List<Long> scheduleID) {
		// TODO Auto-generated method stub
		
		Integer result = 0;
		
		result = mapper.cancelSeatReservations(reservedSeats, reservationNo);
		
		result = mapper.updateSeatsOnCancellation(reservedSeats, scheduleID);
		
		return result;
	}



	

	

	



}
