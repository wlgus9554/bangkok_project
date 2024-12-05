package com.bangkok.hotel_reservations.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.hotel.service.HotelService;
import com.bangkok.hotel_reservations.service.Hotel_reservationsService;
import com.bangkok.hotel_reservations.vo.Hotel_reservationsVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel_reservations")
@Log4j
public class Hotel_reservationsController {
	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("hotel_reservationsServiceImpl")
	private Hotel_reservationsService service;
	@Autowired
	@Qualifier("hotelServiceImpl")
	private HotelService Hotelservice;	
	//--- 호텔 예약리스트 ------------------------------------
	@GetMapping("/list.do")
	// public ModelAndView list(Model model) {
	public String list(Model model, HttpServletRequest request)
			throws Exception {
		log.info("list.do");
		//나중에 풀자
		HttpSession session = request.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		String email =login.getEmail();		
//		String email = "john@example.com";
		model.addAttribute("check", service.check(email));
		model.addAttribute("list", service.list(email));
		model.addAttribute("listCompletion", service.listCompletion(email));

		return "hotel_reservations/list";
	}
	//--- 호텔 관리자 리스트 ------------------------------------
	@GetMapping("/adminList.do")
	// public ModelAndView list(Model model) {
	public String adminList(Model model, HttpServletRequest request)
			throws Exception {
		//나중에 풀자
		HttpSession session = request.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		String email =login.getEmail();		
//		String email = "john@example.com";
		PageObject pageObject = PageObject.getInstance(request);
		//데이터 정렬 시킬 기준 데이터를 pageObject period에 저장
		pageObject.setPeriod(request.getParameter("optList"));
		log.info("pageObject"+pageObject);
		
		List<Hotel_reservationsVO> busy = service.Business(email,pageObject);
		
		model.addAttribute("pageObject", pageObject);	
		model.addAttribute("busy", busy);
		
		return "hotel_reservations/adminList";
	}
	
	//--- 호텔 예약보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model,Long reservation_no) {
		log.info("view.do");
		log.info("reservation_no "+reservation_no);
		
		model.addAttribute("vo", service.view(reservation_no));
		
		return "hotel_reservations/view";
	}
	
	//--- 호텔 예약등록 폼 ------------------------------------
	@GetMapping("/writeForm.do")
	public String writeForm(HttpServletRequest request,Model model,Long rno) {
		log.info("writeForm.do");

		//나중에 풀자
		HttpSession session = request.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		String id =login.getEmail();		
		
		Hotel_reservationsVO vo = new Hotel_reservationsVO();
		vo.setEmail(id);
		vo.setRno(rno);
		
		model.addAttribute("hotel",service.hotel(vo));
		
		
		return "hotel_reservations/writeForm";
	}
	//--- 호텔 관리자 상태 수정 폼 ------------------------------------
	@PostMapping("/changeStatus.do")
	public String changeStatus(Hotel_reservationsVO vo, Model model, RedirectAttributes rttr) throws Exception {
		log.info("vo 값"+vo);
		model.addAttribute("vo", service.changeStatus(vo));
		if(service.changeStatus(vo) == 1) {
			rttr.addFlashAttribute("msg", vo.getPaymentStatus()+" 상태가 정상적으로 변경 되었습니다."); 
			return "redirect:adminList.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"상태가 정상적으로 변경 되지 않았습니다.");
			return "redirect:adminList.do";
		}
	}
	
	//--- 호텔 예약삭제 처리 ------------------------------------
	@PostMapping("/delete.do")
	public String delete(Hotel_reservationsVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		// 처리 결과에 대한 메시지 처리
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", vo.getReservation_no()+"예약 번호 예약이 취소 처리 되었습니다."); 
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"호텔 예약이 취소 되지 않았습니다. ");
			return "redirect:view.do?reservation_no="+ vo.getReservation_no();
		}
	}

}
