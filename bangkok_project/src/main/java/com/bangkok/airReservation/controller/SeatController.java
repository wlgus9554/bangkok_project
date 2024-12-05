package com.bangkok.airReservation.controller;

import java.util.List;

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

import com.bangkok.airReservation.service.AirReservationService;
import com.bangkok.airReservation.service.SeatService;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.PassengersVO;
import com.bangkok.airReservation.vo.SeatReservationVO;
import com.bangkok.airReservation.vo.SeatVO;
import com.bangkok.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/seat")
public class SeatController {

	@Autowired
	@Qualifier("SeatServiceImpl")
	private SeatService service;

	@Autowired
	@Qualifier("AirReservationServiceImpl")
	private AirReservationService reservationservice;

	String email = "test1@naver.com";

	@PostMapping("/seatDlist.do")
	public String seatDlist(Model model, 
							 @RequestParam("classNo") Integer classNo,
	                         @RequestParam("reservationNo") Long reservationNo,
	                         @RequestParam("scheduleID") Long[] scheduleIDs,
	                         HttpSession session, RedirectAttributes rttr) {
	    log.info("seat/seatDlist.do");

	    Long scheduleID_d = scheduleIDs[0];
	    
	    log.info("classNo" + classNo);
	    
		LoginVO login = (LoginVO) session.getAttribute("login");
				
				if (login == null) {
					rttr.addFlashAttribute("msg", "로그인 & 예약을 하신 후 이용해주세요.");
					
					return "redirect:/main/main.do";
				}
	    
	    // 예약 정보 조회
	    List<AirReservationVO> reservationList = reservationservice.view(reservationNo);
	    
	    log.info("scheduleIDs = " + scheduleIDs);

	    // 첫 번째 예약 정보 가져오기 (예약 정보가 있을 때만)
	    if (!reservationList.isEmpty()) {
	        AirReservationVO reservation = reservationList.get(0);
	        log.info("어린이 수 = " + reservation.getChild_count());
	        log.info("성인 수 = " + reservation.getAdult_count());
	        log.info("유아 수 = " + reservation.getInfant_count());
	        
	        model.addAttribute("reservation", reservationList);
	    } else {
	        log.warn("예약 정보를 찾을 수 없습니다. reservationNo: " + reservationNo);
	    }
	    

	    // 승객 정보 조회
	    List<PassengersVO> passengers = reservationservice.viewPassengers(reservationNo);
	    model.addAttribute("passengers", passengers);

	    // 좌석 정보 조회
	    List<SeatVO> seats = service.getDSeats(scheduleID_d);
	    log.info("seats ClassNo ---------------- " + seats.get(0).getClassNo());
	    log.info("classNo = " + classNo);
	    
	  	log.info("seats" + seats);

	    // 좌석의 passengerNo 세팅
	    for (SeatVO seat : seats) {
	        for (PassengersVO passenger : passengers) {
	            seat.setPassengerNo(passenger.getPassengerNo());
	            seat.getClassNo();
	            
	        }
	    }

	    // 좌석 정보를 모델에 추가
	    model.addAttribute("seats", seats);

	    return "airReservation/seatDList";
	}

	@GetMapping("/seatAlist.do")
	public String seatAlist(@RequestParam("reservationNo") Long reservationNo, 
							@RequestParam("scheduleID") Long scheduleId_a,
							Model model,
							HttpSession session, RedirectAttributes rttr) {
						    
	    List<AirReservationVO> reservationList = reservationservice.view(reservationNo);
	    
	    log.info("seat/seatAlist.do");
	    log.info("scheduleID = " + scheduleId_a);
	    
	    LoginVO login = (LoginVO) session.getAttribute("login");
		
		if (login == null) {
			rttr.addFlashAttribute("msg", "로그인 & 예약을 하신 후 이용해주세요.");
			
			return "redirect:/main/main.do";
		}

	    
	    
	    // 첫 번째 예약 정보 가져오기 (예약 정보가 있을 때만)
	    if (!reservationList.isEmpty()) {
	        AirReservationVO reservation = reservationList.get(0);
	        log.info("어린이 수 = " + reservation.getChild_count());
	        log.info("성인 수 = " + reservation.getAdult_count());
	        log.info("유아 수 = " + reservation.getInfant_count());
	        
	        model.addAttribute("reservation", reservationList);
	    } else {
	        log.warn("예약 정보를 찾을 수 없습니다. reservationNo: " + reservationNo);
	    }
	    
	    List<SeatVO> seatsList = service.getDSeats(scheduleId_a);
	    model.addAttribute("seats", seatsList);
	    
	    List<PassengersVO> passengers = reservationservice.viewPassengers(reservationNo);
	    model.addAttribute("passengers", passengers);

	    return "airReservation/seatAList";
	}



	@PostMapping("seatReservationD.do")
	public String seatReservationD(@ModelAttribute("seats") SeatVO seats, 
								@ModelAttribute("reservations") SeatReservationVO reservations,
								@RequestParam("reservationNo") Long reservationNo, 
								@RequestParam("scheduleID") Long[] scheduleIDs, 
								RedirectAttributes rttr) {
		
		Long scheduleID_d = scheduleIDs[0];
		Long scheduleID_a = scheduleIDs[1];
		
		log.info("seatReservationD 메소드 시작");
		log.info("scheduleIDs 배열 길이: " + scheduleIDs.length);
		log.info("scheduleID_d: " + scheduleID_d);
		log.info("scheduleID_a: " + scheduleID_a);
		
		
		if(scheduleID_a != 0) {
			service.reservationDSeat(seats.getSeats(), reservations.getReservations(), reservationNo, scheduleID_d);
			log.info("좌석 예약 성공");
			rttr.addFlashAttribute("msg", "오는 편 좌석을 예약하러 갑니다.");
			return "redirect:/seat/seatAlist.do?reservationNo=" + reservationNo + "&scheduleID=" + scheduleID_a;
		}
		return "redirect:/airReservation/view.do?reservationNo=" + reservationNo;
		
	}
	
	
	@PostMapping("seatReservationA.do")
	public String seatReservationA(@ModelAttribute("seats") SeatVO seats, 
								@ModelAttribute("reservations") SeatReservationVO reservations,
								@RequestParam("reservationNo") Long reservationNo, 
								@RequestParam("scheduleID") Long[] scheduleIDs, 
								RedirectAttributes rttr) {

		log.info("전달된 좌석: " + seats);
		
		Long scheduleID_a = scheduleIDs[1];
		
		service.reservationASeat(seats.getSeats(), reservations.getReservations(), reservationNo, scheduleID_a);
		rttr.addAttribute("msg", "좌석 예약을 완료하셨습니다. 즐거운 여행 되세요.");
		
		return "redirect:/airReservation/list.do?";
	}

}
