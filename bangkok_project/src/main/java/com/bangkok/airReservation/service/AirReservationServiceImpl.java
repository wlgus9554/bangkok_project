package com.bangkok.airReservation.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.airReservation.mapper.AirReservationMapper;
import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.CountryVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.PassengersVO;
import com.bangkok.airReservation.vo.StatusVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("AirReservationServiceImpl")
public class AirReservationServiceImpl implements AirReservationService {

	@Inject
	private AirReservationMapper mapper;

	@Override
	public List<AirReservationVO> list(String email) {
		// TODO Auto-generated method stub
		return mapper.list(email);
	}

	@Override
	public List<AirReservationVO> view(Long reservationNo) {
		// TODO Auto-generated method stub
		return mapper.view(reservationNo);
	}
	
	@Override
	public List<PassengersVO> viewPassengers(Long reservationNo) {
		// TODO Auto-generated method stub
		return mapper.viewPassengers(reservationNo);
	}
	
	// 
	@Override
	public List<Long> viewscheduleID(Long reservationNo) {
		// TODO Auto-generated method stub
		return mapper.viewscheduleID(reservationNo);
	}

	// 예약 등록
	@Override
	public Integer reservation(AirReservationVO vo, List<APassengerVO> apassengerList,
			List<CPassengerVO> cpassengerList, List<IPassengerVO> ipassengerList, List<BaggageVO> baggageList,
			AirReservationVO scheduleID, Long classNo) {
		
		log.info("class No ====== " + classNo);
		
		Integer result = null;

		log.info("aPassenger = " + vo.getAPassenger());
		log.info("cPassenger = " + vo.getCPassenger());
		log.info("iPassenger = " + vo.getIPassenger());

		Integer childCount = vo.getCPassenger();
		Integer infantCount = vo.getIPassenger();

		mapper.reservation(vo);

		log.info("Reservation Number: " + vo.getReservationNo());

		
		
		scheduleID.setReservationNo(vo.getReservationNo());
		scheduleID.setClassNo(classNo);
		mapper.reservationSchedule(scheduleID); // 개별 스케줄 저장

		if (apassengerList != null && !apassengerList.isEmpty()) {
			for (APassengerVO apassengerVO : apassengerList) {
				apassengerVO.setReservationNo(vo.getReservationNo());
			}
			mapper.reservationAPassenger(apassengerList);
		}

		if (cpassengerList != null && !cpassengerList.isEmpty()) {
			// 첫 번째 항목의 childCount를 검사
			if (childCount != null && childCount > 0) {
				for (CPassengerVO cpassengerVO : cpassengerList) {
					cpassengerVO.setReservationNo(vo.getReservationNo());
				}
				mapper.reservationCPassenger(cpassengerList); // 리스트를 처리한 후, 한 번만 호출
			}
		}

		if (ipassengerList != null && !ipassengerList.isEmpty()) {
			if (infantCount != null && infantCount > 0)
				for (IPassengerVO ipassengerVO : ipassengerList) {
					ipassengerVO.setReservationNo(vo.getReservationNo());
					mapper.reservationIPassenger(ipassengerList);
				}
		}

		if (baggageList != null && !baggageList.isEmpty()) {
			for (BaggageVO baggageVO : baggageList) {
				baggageVO.setReservationNo(vo.getReservationNo());
			}
			mapper.reservationBaggage(baggageList);
		}

		result = mapper.reservationState(vo);

		return result;
	}
	
	@Override
	public Integer updateAPassportNumber(APassengerVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateAPassportNumber(vo);
	}

	@Override
	public Integer updateCPassportNumber(CPassengerVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateCPassportNumber(vo);
	}

	@Override
	public Integer updateIPassportNumber(IPassengerVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateIPassportNumber(vo);
	}

	@Override
	public Integer reservationDelete(AirReservationVO vo) {

		log.info("예약 번호" + vo.getReservationNo());
		// TODO Auto-generated method stub
		return mapper.reservationDelete(vo);
	}

	// ----------------------- 관리자 -----------------------

	@Override
	public List<AirReservationVO> listAllReservations() {
		// TODO Auto-generated method stub
		return mapper.listAllReservations();

	}

	@Override
	public Integer updateReservationStatus(AirReservationVO vo) {
		
		vo.getStatus();
		vo.getReservationNo();
		
		// TODO Auto-generated method stub
		return mapper.updateReservationStatus(vo);
	}

	@Override
	public Integer deletePassenger(Long passengerNo) {
		// TODO Auto-generated method stub
		return mapper.deletePassenger(passengerNo);
	}

	// --------------------------- Ajax -------------------------------

	@Override
	public List<CountryVO> selectCountry() {
		// TODO Auto-generated method stub
		return mapper.selectCountry();
	}

	@Override
	public List<BaggageTypeVO> selectBaggage() {
		// TODO Auto-generated method stub
		return mapper.selectBaggage();
	}

	@Override
	public List<StatusVO> selectStatus() {
		// TODO Auto-generated method stub
		return mapper.selectStatus();
	}

	




}
