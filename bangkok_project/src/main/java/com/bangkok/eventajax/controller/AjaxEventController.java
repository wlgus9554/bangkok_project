package com.bangkok.eventajax.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bangkok.event.service.EventService;
import com.bangkok.hotel_reservations.service.Hotel_reservationsService;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.reviews.service.ReviewsService;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ajax")
@Log4j
public class AjaxEventController {
	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("eventServiceImpl")
	private EventService eventService;
	@Autowired
	@Qualifier("hotel_reservationsServiceImpl")
	private Hotel_reservationsService HotelReservice;
	@Autowired
	@Qualifier("reviewsServiceImpl")
	private ReviewsService Reviewservice;	
	
	@GetMapping("/getHotel.do")
	public String getHotel(Model model, HttpServletRequest request) throws Exception {
		log.info("getHotel.do");
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		String strPerPageNum = request.getParameter("perPageNum");
		if(strPerPageNum == null  || strPerPageNum.equals("") )
			pageObject.setPerPageNum(12);
		
		model.addAttribute("hotel", eventService.hotelList());
		model.addAttribute("pageObject", pageObject);
		return "event/hotelList";
	}
	@GetMapping("/getTrip.do")
	public String getTrip(Model model,HttpServletRequest request) throws Exception {
		log.info("getTrip.do");
		PageObject pageObject = PageObject.getInstance(request);
		String strPerPageNum = request.getParameter("perPageNum");
		if(strPerPageNum == null  || strPerPageNum.equals("") )
			pageObject.setPerPageNum(12);
		
		model.addAttribute("trip", eventService.tripList());
		model.addAttribute("pageObject", pageObject);		
		return "event/tripList";
	}
	//--- 해외 호텔 예약리스트  ------------------------------------
	@GetMapping("/listAjax.do")
	// public ModelAndView list(Model model) {
	public String listAjax(Model model, HttpServletRequest request)
			throws Exception {
		log.info("listAjax.do");
		//나중에 풀자
		HttpSession session = request.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		String email =login.getEmail();		
//		String email = "john@example.com";
		model.addAttribute("check", HotelReservice.check(email));
		model.addAttribute("list", HotelReservice.listAjax(email));
		model.addAttribute("listCompletion", HotelReservice.listCompletionAjax(email));
		
		return "/hotel_reservationsAjax/ajaxList";
	}
	@GetMapping("/menuList.do")
	// public ModelAndView list(Model model) {
	public String menuList(Model model,Integer no)
			throws Exception {
		// 페이지 처리를 위한 객체 생겅
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", Reviewservice.menuList(no));
		return "reviews/menuList";
	}
}
