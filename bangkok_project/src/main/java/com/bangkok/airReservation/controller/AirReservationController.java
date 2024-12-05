package com.bangkok.airReservation.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.format.annotation.DateTimeFormat;


import com.bangkok.airReservation.service.AirReservationService;
import com.bangkok.airReservation.service.SeatService;
import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.PassengersVO;
import com.bangkok.airReservation.vo.SeatReservationVO;
import com.bangkok.airReservation.vo.SeatVO;
import com.bangkok.airReservation.vo.StatusVO;
import com.bangkok.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/airReservation")
@Log4j
public class AirReservationController {

	@Autowired
	@Qualifier("AirReservationServiceImpl")
	private AirReservationService service;
	
	@Autowired
	@Qualifier("SeatServiceImpl")
	private SeatService seatService;
	
	
	@GetMapping("/list.do")
	public String list(Model model, HttpSession session, RedirectAttributes rttr) {	
		// @RequestParam("email") String email
		
		LoginVO login = (LoginVO) session.getAttribute("login");
		
		if (login == null) {
			rttr.addFlashAttribute("msg", "로그인을 하신 후 이용해주세요.");
			
			return "redirect:/main/main.do";
		}
		
		String email =login.getEmail();		
		
		model.addAttribute("list", service.list(email));
		

		return "airReservation/list";

	}
	
	@GetMapping("view.do")
	public String view(Model model, @RequestParam("reservationNo") Long reservationNo ) {	
		// @RequestParam("email") String email
		
		// 예약 정보 가져오기 (리스트 형태)
        List<AirReservationVO> reservationList = service.view(reservationNo);
        
        // 예약 정보가 없을 경우 처리
        if (reservationList.isEmpty()) {
            model.addAttribute("error", "예약 정보를 찾을 수 없습니다.");
            
            return "redirect:/main/main.do";
        }

        
        // 승객 정보 가져오기
        List<PassengersVO> passengers = service.viewPassengers(reservationNo);
        
        // 스케줄 ID 가져오기
        List<Long> scheduleIds = service.viewscheduleID(reservationNo);
        
        // 모델에 데이터 추가
        model.addAttribute("reservation", reservationList);
        model.addAttribute("passengers", passengers);
        model.addAttribute("scheduleIds", scheduleIds);

		return "airReservation/view";

	}


	@PostMapping("update.do")
	public String update(@RequestParam("reservationNo") Long reservationNo,
	                     @RequestParam("passengerNo") Long passengerNo,
	                     @RequestParam("passport_enddate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate passportEndDate,
	                     @RequestParam("existingPassportNumber") String existingPassportNumber,
	                     @RequestParam("passport_number") String passportNumber,
	                     @RequestParam("passenger_type") String passengerType) {

	    log.info("탑승자 번호: " + passengerNo);
	    log.info("예약 번호: " + reservationNo);
	    log.info("기존 여권 번호: " + existingPassportNumber);
	    log.info("새 여권 번호: " + passportNumber);
	    log.info("여권 만료일: " + passportEndDate);
	    log.info("탑승객 타입: " + passengerType);

	    APassengerVO avo = new APassengerVO();
	    CPassengerVO cvo = new CPassengerVO();
	    IPassengerVO ivo = new IPassengerVO();

	    if(passengerType.equals("성인")) {
	        log.info("성인 탑승객 업데이트");
	        avo.setAdultPassengerNo(passengerNo);
	        avo.setReservationNo(reservationNo);
	        avo.setPassport_number(passportNumber);
	        avo.setExistingPassportNumber(existingPassportNumber);
	        avo.setPassportEndDate(passportEndDate);  // Set passport end date

	        service.updateAPassportNumber(avo);
	    }

	    if(passengerType.equals("소아")) {
	        log.info("소아 탑승객 업데이트");
	        cvo.setChildPassengerNo(passengerNo);
	        cvo.setReservationNo(reservationNo);
	        cvo.setPassport_number(passportNumber);
	        cvo.setExistingPassportNumber(existingPassportNumber);
	        cvo.setPassportEndDate(passportEndDate);  // Set passport end date

	        service.updateCPassportNumber(cvo);
	    }

	    if(passengerType.equals("유아")) {
	        log.info("유아 탑승객 업데이트");
	        ivo.setInfantPassengerNo(passengerNo);
	        ivo.setReservationNo(reservationNo);
	        ivo.setPassport_number(passportNumber);
	        ivo.setExistingPassportNumber(existingPassportNumber);
	        ivo.setPassportEndDate(passportEndDate);  // Set passport end date

	        service.updateIPassportNumber(ivo);
	    }

	    return "redirect:view.do?reservationNo=" + reservationNo;
	}
	

	// --- 상품 글등록 폼 ------------------------------------
	@PostMapping("/writeForm.do")
	public String writeForm(@ModelAttribute("list") AirReservationVO vo,
			HttpSession session, RedirectAttributes rttr, Model model) {
		log.info("writeForm.do");
		log.info("airReservationWriteForm-- " + vo);
		
		LoginVO login = (LoginVO) session.getAttribute("login");
		model.addAttribute("login");
		
		if (login == null) {
			rttr.addFlashAttribute("msg", "접근권한이 없습니다 로그인 후 예약을 하여 이용해주세요.");
			
			return "redirect:/main/main.do";
		}
		
			// 항공 검색 결과
		 	log.info("aPassenger: " + vo.getAPassenger());  // aPassenger 값 로그
		    log.info("cPassenger: " + vo.getCPassenger());
		    log.info("iPassenger: " + vo.getIPassenger());
		
		return "airReservation/writeForm";
	}
	
	@PostMapping("/write.do")
	public String write(AirReservationVO vo, 
			@ModelAttribute("apassengers") APassengerVO apassengerList,
			@ModelAttribute("cpassengers") CPassengerVO cpassengerList,
			@ModelAttribute("ipassengers") IPassengerVO ipassengerList,
			@ModelAttribute("baggages") BaggageVO baggageList,
			@ModelAttribute("scheduleID") AirReservationVO scheduleID,
			@RequestParam("classNo") Long classNo,
			HttpSession session,
			RedirectAttributes rttr) {
		
		log.info("aPassenger = " + vo.getAPassenger());
		log.info("cPassenger = " + vo.getCPassenger());
		log.info("iPassenger = " + vo.getIPassenger());
		
		log.info("좌석 등급" + vo.getSeatGrade());
		
		log.info("클래스 번호 = " + vo.getClassNo());
		
	    log.info("write.do");
	   
	    log.info("List<BaggageVO> " + baggageList);
	    log.info("ReservationScheduleVO " + scheduleID);
	    log.info("APassengerVO " + apassengerList);
	    log.info("CPassengerVO " + cpassengerList);
	    log.info("IPassengerVO " + ipassengerList);
	    log.info("ReservationScheduleVO-scheduleID " + scheduleID.getScheduleID());
	    
	    List<APassengerVO> apassengerLists = apassengerList.getApassengers();
	    for (APassengerVO apassenger : apassengerLists) {
	        log.info("성별: " + apassenger.getGender());
	    }
	    
	    
		vo.setEmail(getEmail(session));
	
	    
	    service.reservation(vo, 
	    		apassengerList.getApassengers(), 
	    		cpassengerList.getCpassengers(),
	    		ipassengerList.getIpassengers(), 
	    		baggageList.getBaggages(), scheduleID,
	    		classNo
	    		);
	   
	    
	    rttr.addFlashAttribute("msg", "예약이 완료 되었습니다.");


	    return "redirect:list.do";
	}
	

	@PostMapping("delete.do")
	public String delete(AirReservationVO vo, RedirectAttributes rttr, 
	                     @RequestParam("reservationNo") Long reservationNo
	                     ) {

	    // 예약된 좌석 번호 가져오기
	    List<Long> reservedSeats = seatService.seatReservedList(reservationNo);
	    log.info("reservedSeats: " + reservedSeats);
	    
	    List<Long> scheduleID = service.viewscheduleID(reservationNo);

	    // 삭제할 좌석 번호가 제공되지 않았을 경우 경고 로그
	    if (reservedSeats == null || reservedSeats.isEmpty()) {
	        log.warn("No seat numbers provided");
	        rttr.addFlashAttribute("msg", "삭제할 좌석 번호가 없습니다.");
	        return "redirect:list.do"; // 좌석 번호가 없을 경우 리디렉션
	    } 

	    log.info("삭제할 좌석 번호들: " + reservedSeats);

	    // 예약 삭제 성공 여부 확인
	    if (service.reservationDelete(vo) == 1) {
	        // 예약된 좌석 삭제
	 
	        seatService.deleteReservedSeat(reservedSeats, reservationNo, scheduleID);

	        rttr.addFlashAttribute("msg", "예약 취소 요청이 완료되었습니다.");
	    } else {
	        rttr.addFlashAttribute("msg", "예약 취소 요청 중 오류가 발생했습니다. 다시 확인하고 시도해 주세요.");
	    }

	    return "redirect:list.do"; // 예약 목록으로 리디렉션
	}




	@GetMapping("/adminList.do")
	public String adminList(Model model) {
	    // 예약 리스트를 가져오는 서비스 메서드에서 각 예약의 승객 리스트도 함께 포함
	    List<AirReservationVO> reservations = service.listAllReservations();
	    
	    List<StatusVO> selectStatus = service.selectStatus();
	    
	    // 각 예약의 승객 리스트를 담을 맵 생성 (reservationNo -> 승객 리스트)
	    Map<Long, List<PassengersVO>> passengersMap = new HashMap<>();

	    // 각 예약에 대해 승객 리스트를 조회하여 맵에 추가
	    for (AirReservationVO reservation : reservations) {
	        Long reservationNo = reservation.getReservationNo();
	        List<PassengersVO> passengers = service.viewPassengers(reservationNo);
	        passengersMap.put(reservationNo, passengers);
	    }

	    // 모델에 예약 정보와 승객 정보를 추가
	    model.addAttribute("reservations", reservations);
	    model.addAttribute("passengersMap", passengersMap);
	    model.addAttribute("selectStatus", selectStatus);

	    return "airReservation/adminList";
	}

	

	@PostMapping("/adminUpdate.do")
	public String adminUpdateStatus(AirReservationVO vo ) {
		
		service.updateReservationStatus(vo);

	    return "redirect:adminList.do";
	}



	
	private String getEmail(HttpSession session) {
		LoginVO vo = (LoginVO)session.getAttribute("login");
		String email = vo.getEmail();
		return email; // 강제 로그인 처리해서 test로 하드코딩했다.
	}


}
