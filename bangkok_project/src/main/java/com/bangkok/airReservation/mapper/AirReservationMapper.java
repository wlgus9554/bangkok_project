package com.bangkok.airReservation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.CountryVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.PassengersVO;
import com.bangkok.airReservation.vo.SeatVO;
import com.bangkok.airReservation.vo.StatusVO;

@Repository
public interface AirReservationMapper {

	// 예약 리스트
	public List<AirReservationVO> list(@Param("email") String email);
	// 예약 상세보기 
	public List<AirReservationVO> view(@Param("reservationNo") Long reservationNo);
	
	public List<PassengersVO> viewPassengers(@Param("reservationNo") Long reservationNo);
	
	public List<Long> viewscheduleID(@Param("reservationNo") Long reservationNo);
	
	// 예약 등록 관련 mapper

	public Integer reservation(AirReservationVO vo);

	public Integer reservationAPassenger(List<APassengerVO> apassengerList);
	public Integer reservationCPassenger(List<CPassengerVO> cpassengerList);
	public Integer reservationIPassenger(List<IPassengerVO> ipassengerList);

	public Integer reservationBaggage(List<BaggageVO> baggageList);

	public Integer reservationSchedule(AirReservationVO scheduleID);

	public Integer reservationState(AirReservationVO vo);
	
	// 예약 수정 관련 mapper 
	
	public Integer updateAPassportNumber(APassengerVO vo);
	public Integer updateCPassportNumber(CPassengerVO vo);
	public Integer updateIPassportNumber(IPassengerVO vo);

	// 예약 삭제 (환불)
	public Integer reservationDelete(AirReservationVO vo);
	

	public List<CountryVO> selectCountry();

	public List<BaggageTypeVO> selectBaggage();
	
	public List<StatusVO> selectStatus();

	// 좌석 mapper
	public List<SeatVO> seatList();

	public Integer seatWrite();
	
	
	// 관리자 
	public List<AirReservationVO> listAllReservations();
	

	public Integer updateReservationStatus(AirReservationVO vo);

	public Integer deletePassenger(Long passengerNo);

	

}
