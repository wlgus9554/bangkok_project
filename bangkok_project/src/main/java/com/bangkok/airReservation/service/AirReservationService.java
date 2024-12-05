package com.bangkok.airReservation.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.CountryVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.PassengersVO;
import com.bangkok.airReservation.vo.StatusVO;

public interface AirReservationService {
	
	// 사용자 
	
	public List<AirReservationVO> list(String email);
	
	public List<AirReservationVO> view(Long reservationNo);
	
	public List<PassengersVO> viewPassengers(Long reservationNo);
	
	public List<Long> viewscheduleID(Long reservationNo);
	
	public Integer updateAPassportNumber(APassengerVO vo);
	public Integer updateCPassportNumber(CPassengerVO vo);
	public Integer updateIPassportNumber(IPassengerVO vo);
	
	public List<CountryVO> selectCountry();
	
	public List<BaggageTypeVO> selectBaggage();
	
	public List<StatusVO> selectStatus();

	public Integer reservation(AirReservationVO vo,
			List<APassengerVO> apassengerList,
			List<CPassengerVO> cpassengerList,
			List<IPassengerVO> ipassengerList,
			List<BaggageVO> baggageList,
			AirReservationVO scheduleID, 
			Long classNo);
	
	public Integer reservationDelete(AirReservationVO vo);
	
	// 관리자 
	
	public List<AirReservationVO> listAllReservations();
	
	
	public Integer updateReservationStatus(AirReservationVO vo);
	
	public Integer deletePassenger(Long passengerNo);

}
