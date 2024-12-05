package com.bangkok.reviews.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.member.vo.LoginVO;
import com.bangkok.reviews.service.ReviewsService;
import com.bangkok.reviews.vo.ReviewsVO;
import com.bangkok.util.file.FileUtil;
import com.bangkok.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/reviews")
@Log4j
public class ReviewsController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("reviewsServiceImpl")
	private ReviewsService service;
	
	//--- 리뷰 리스트 ------------------------------------
	@GetMapping("/list.do")
	// public ModelAndView list(Model model) {
	public String list(Model model,Integer no)
			throws Exception {
		log.info("list.do");
		// 페이지 처리를 위한 객체 생겅
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
//		HttpSession session = request.getSession();
//		LoginVO login = (LoginVO) session.getAttribute("login");
//		String id =login.getEmail();		
		model.addAttribute("list", service.list(no));
		return "reviews/list";
	}

	
	// --- 리뷰 보기 ------------------------------------
	@GetMapping("/view.do")
	@ResponseBody
	public ResponseEntity<?> view(@RequestParam("reservation_no") Long reservation_no) {
	    log.info("view.do");

	    // 서비스에서 데이터를 가져옴
	    ReviewsVO reviewVO = service.view(reservation_no);

	    // 데이터를 JSON 형식으로 반환
	    return ResponseEntity.ok(reviewVO);
	}
	
	//--- 리뷰 등록 처리 ------------------------------------
	@PostMapping("/write.do")
	public String write(ReviewsVO vo, RedirectAttributes rttr,Long reservation_no){
		log.info("write.do");
		int result = service.write(vo);
		service.hasReview(vo);
		log.info(vo);
		// 처리 결과에 대한 메시지 처리
		if(result == 1) {
			rttr.addFlashAttribute("msg", "리뷰가 정상 등록되었습니다."); 
			return "redirect:/hotel_reservations/list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"리뷰는 한 번만 등록할 수 있습니다. ");
			return "redirect:/hotel_reservations/list.do";
		}		
	}
	//--- 리뷰 좋아요 카운트 ------------------------------------
	@PostMapping("/count.do")
	@ResponseBody
	public ResponseEntity<?> count(ReviewsVO vo,HttpServletRequest request){
		// 처리 결과에 대한 메시지 처리
		//나중에 풀자
		HttpSession session = request.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		String id =login.getEmail();		
		vo.setId(id);
		log.info("vo의 값을 확인중 "+vo);
		Integer reviewVO = service.likeCount(vo);
		return ResponseEntity.ok(reviewVO);
	}
	
	
	//--- 리뷰 삭제 처리 ------------------------------------
	@GetMapping("/delete.do")
	public String delete(ReviewsVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		// 처리 결과에 대한 메시지 처리
		service.hasReviewMinus(vo);
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", vo.getReservation_no()+"번 리뷰가 삭제가 되었습니다."); 
			return "redirect:/hotel_reservations/list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"리뷰가 삭제 되지 않았습니다. ");
			return "redirect:/hotel_reservations/list.do";
		}
	}
}
