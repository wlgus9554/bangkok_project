package com.bangkok.air.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.air.service.AirService;
import com.bangkok.air.vo.AirVO;
import com.bangkok.air.vo.AirlineVO;
import com.bangkok.air.vo.AirplaneVO;
import com.bangkok.air.vo.PriceVO;
import com.bangkok.air.vo.RouteVO;
import com.bangkok.air.vo.ScheduleVO;
import com.bangkok.info.service.InfoService;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/air")
@Log4j
public class AirController {
	
	// 자동 DI
	// @Setter(onMethod_= @Autowired)
	@Autowired
	@Qualifier("AirServiceImpl")
	private AirService service;
	
	// 자동 DI
	// @Setter(onMethod_= @Autowired)
	@Autowired
	@Qualifier("infoServiceImpl")
	private InfoService infoService;
	
	// 1. 항공 메인
	@GetMapping("/main.do")
	public String list(Model model, HttpServletRequest request, HttpSession session, PageObject pageObject, String cityname, String countrycode
			, String filename) throws Exception {
		log.info("AirController.main() --------------------------");
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			model.addAttribute("login");
		}
		
		// 대륙별 리스트 가져오기
		List<AirVO> asia = service.nocList("ASIA");
		List<AirVO> africa = service.nocList("AFRICA");
		List<AirVO> australia = service.nocList("AUSTRALIA");
		List<AirVO> europe = service.nocList("EUROPE");
		List<AirVO> northAmerica = service.nocList("NORTH AMERICA");
		List<AirVO> southAmerica = service.nocList("SOUTH AMERICA");
		
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("asia", asia);
		model.addAttribute("africa", africa);
		model.addAttribute("australia", australia);
		model.addAttribute("europe", europe);
		model.addAttribute("northAmerica", northAmerica);
		model.addAttribute("southAmerica", southAmerica);
		
		model.addAttribute("infoList", infoService.list(pageObject,cityname,countrycode,filename)); // 여행정보 리스트
		
		return "air/main";
	} // end of list()
	
	// 1-1. 예약 조회
	@GetMapping("/searchReservation.do")
	public String searchReservation() throws Exception {
		log.info("AirController.searchReservation() --------------------------");
		
		return "air/searchReservation";
	} // end of searchReservation()
	
	// 1-2. 출도착 조회
	@GetMapping("/searchSchedule.do")
	public String searchSchedule() throws Exception {
		log.info("AirController.searchSchedule() --------------------------");
		
		return "air/searchSchedule";
	} // end of searchReservation()
	
	
	// 2. 공항 검색 리스트 - GET
	// 넘겨주는 데이터는 기본이 XML로 보내고 JS 에서 JSON 으로 변환한다.
	@GetMapping(value = "/searchAirport",
			produces = {
				MediaType.APPLICATION_XML_VALUE,
				MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	@ResponseBody
	public ResponseEntity<Map<String, Object>> searchAirport(@RequestParam(value = "searchAirport") String searchAirport) {
        
		// DB 에서 데이터를 가져와서 넘겨 준다.
		List<AirVO> list = service.searchList(searchAirport);
		log.info("controller - service()");
	
		// list와 PageObject를 넘겨야 한다.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		// list와 pageObject의 데이터 확인
		log.info("After - map : " + map); 
		
		// ResponseEntity : 통신 상태를 확인하기 위해 ResponseEntity를 사용한다. 데이터 보내는 것 뿐만 아닌 상태까지 보낼 수 있다.
	    // DB에서 초성 및 전체 공항명을 함께 검색
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
    }
	
	// 3. 항공권 검색 결과
	@PostMapping("/selectFlight-D.do")
	public String searchResult(AirVO vo, Model model, @RequestParam Map<String, Object> param) {
		
		model.addAttribute("list", service.searchResult(vo));
		model.addAttribute("param", param);
		
		return "air/selectFlight-D";
	}
	
	// 3-1. 항공권 검색 결과 : 왕복인 경우 검색, 편도인 경우 주문 예약으로 데이터 전송
	@PostMapping("/selectFlight-A.do")
	public String searchReturnResult(AirVO vo, Model model, @RequestParam Map<String, Object> param) {
		
		model.addAttribute("list", service.searchResult(vo));
		model.addAttribute("param", param);
		
		// 왕복 체크
		if (param.get("type").equals("왕복")) {
			
			return "air/selectFlight-A";
			
		} else return "air/main";
		
	}
	
	// 4. 관리자 메인 - 항공사 리스트
	@GetMapping("/airAdmin.do")
	public String airAdminMain(Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		log.info(loginVO);
		
		if (loginVO != null) {
			
			if (loginVO.getGradeNo() == 9){
				PageObject pageObject = PageObject.getInstance(request);
				
				log.info("pageObject.getInstance" + pageObject);
				
				model.addAttribute("login");
				model.addAttribute("list", service.airlineList(pageObject));
				model.addAttribute("pageObject", pageObject);
				
				return "air/airAdmin";
				
			}  else {
				
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "최종 관리자가 아닙니다.");
				return "redirect:" + page;	
			} 
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:" + page;
		}
	}
	
	// 10-1. 항공사 등록 처리
	@PostMapping("/airlineWrite.do")
	public String airlineWrite(AirlineVO vo, RedirectAttributes rttr) {
		
		log.info(vo);
		if (service.airlineWrite(vo) == 1) {
			rttr.addFlashAttribute("msg", "항공사가 정상적으로 등록되었습니다..");
		} else
			rttr.addFlashAttribute("msg", "항공사 등록에 실패하였습니다.");
		
		return "redirect:/air/airAdmin.do";
	}
	
	// 10-2. 항공사 수정 처리
	@PostMapping("/airlineUpdate.do")
	public String airlineUpdate(AirlineVO vo, RedirectAttributes rttr) {
		
		log.info(vo);
		if (service.airlineUpdate(vo) == 1) {
			rttr.addFlashAttribute("msg", "항공사가 정상적으로 수정되었습니다.");
		} else
			rttr.addFlashAttribute("msg", "항공사 수정에 실패하였습니다.");
		
		return "redirect:/air/airAdmin.do";
	}
	
	// 4-1. 관리자 국가 리스트
	@GetMapping("/airAdminNOC.do")
	public String nocList(String pan, Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr){
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		log.info(loginVO);
		
		if (loginVO != null) {
			
			if (loginVO.getGradeNo() == 9){
				
				// 대륙별 리스트 가져오기
				List<AirVO> asia = service.nocList("ASIA");
				List<AirVO> africa = service.nocList("AFRICA");
				List<AirVO> australia = service.nocList("AUSTRALIA");
				List<AirVO> europe = service.nocList("EUROPE");
				List<AirVO> northAmerica = service.nocList("NORTH AMERICA");
				List<AirVO> southAmerica = service.nocList("SOUTH AMERICA");
				
				model.addAttribute("login");
				// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
				model.addAttribute("asia", asia);
				model.addAttribute("africa", africa);
				model.addAttribute("australia", australia);
				model.addAttribute("europe", europe);
				model.addAttribute("northAmerica", northAmerica);
				model.addAttribute("southAmerica", southAmerica);
				
				return "air/airAdminNOC";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "최종 관리자가 아닙니다.");
				return "redirect:" + page;
			} 
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:" + page;
		}
		
	}
	
	// 4-2. 관리자 국가 등록
	@PostMapping("/nocWrite.do")
	public String nocWrite(AirVO vo, RedirectAttributes rttr) {
		
		service.nocWrite(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("msg", "국가 등록이 정상 처리 되었습니다.");
		
		return "redirect:airAdminNOC.do";
	}
	
	// 4-3. 관리자 국가 수정
	@PostMapping("/nocUpdate.do")
	public String nocUpdate(AirVO vo, RedirectAttributes rttr) {
		if(service.nocUpdate(vo) >= 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "국가 수정이 정상 처리 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"국가 수정이 처리 되지 않았습니다."
					+ "국가 정보를 다시 확인하고 시도해 주세요.");
		
		return "redirect:airAdminNOC.do";
	}
	
	// 4-4. 관리자 국가 삭제
	@PostMapping("/nocDelete.do")
	public String nocDelete(AirVO vo, RedirectAttributes rttr) {
		// 처리 결과에 대한 메시지 처리
		if(service.nocDelete(vo) == 1) {
			rttr.addFlashAttribute("msg", "국가 삭제가 정상 처리 되었습니다.");
		}
		else {
			rttr.addFlashAttribute("msg",
					"국가 삭제가 되지 않았습니다. 다시 확인하고 시도해 주세요.");
		}
		return "redirect:airAdminNOC.do";
	}
	
	// 5-1. 관리자 공항 리스트
	@GetMapping("/airAdminAirport.do")
	public String airportList(String pan, Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr){
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		log.info(loginVO);
		
		if (loginVO != null) {
			
			if (loginVO.getGradeNo() == 9){
				
				// 대륙별 리스트 가져오기
				List<AirVO> asia = service.nocList("ASIA");
				List<AirVO> africa = service.nocList("AFRICA");
				List<AirVO> australia = service.nocList("AUSTRALIA");
				List<AirVO> europe = service.nocList("EUROPE");
				List<AirVO> northAmerica = service.nocList("NORTH AMERICA");
				List<AirVO> southAmerica = service.nocList("SOUTH AMERICA");
				
				model.addAttribute("login");
				// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
				model.addAttribute("asia", asia);
				model.addAttribute("africa", africa);
				model.addAttribute("australia", australia);
				model.addAttribute("europe", europe);
				model.addAttribute("northAmerica", northAmerica);
				model.addAttribute("southAmerica", southAmerica);
				
				return "air/airAdminAirport";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "최종 관리자가 아닙니다.");
				return "redirect:" + page;
			} 
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "접근 권한이 없습니다.");
			return "redirect:" + page;
		}
		
	}
	
	// 5-2. 관리자 공항 추가
	@PostMapping("/airportWrite.do")
	public String airportWrite(AirVO vo, RedirectAttributes rttr) {
		
		if (service.airportWrite(vo) == 1) {
			rttr.addFlashAttribute("msg", "공항이 등록되었습니다.");
		} else 
			rttr.addFlashAttribute("msg", "공항 등록에 실패했습니다.");
		
		return "redirect:/air/airAdminNOC.do";
	}
	
	// 5-3. 관리자 공항 수정
	@PostMapping("/airportUpdate.do")
	public String airportUpdate(AirVO vo, RedirectAttributes rttr) {
		if (service.airportUpdate(vo) == 1) {
			rttr.addFlashAttribute("msg", "공항이 수정 되었습니다.");
		} else 
			rttr.addFlashAttribute("msg", "공항 수정에 실패했습니다.");
		
		return "redirect:/air/airAdminNOC.do";
	}
	
	// 5-3. 관리자 공항 수정
	@PostMapping("/airportDelete.do")
	public String airportDelete(AirVO vo, RedirectAttributes rttr) {
		if (service.airportDelete(vo) == 1) {
			rttr.addFlashAttribute("msg", "공항이 삭제 되었습니다.");
		} else 
			rttr.addFlashAttribute("msg", "공항 삭제에 실패했습니다.");
		
		return "redirect:/air/airAdminNOC.do";
	}
	
	// 6. 관리자 기종 관리 리스트
	@GetMapping("/airAdminAirplane.do")
	public String airAdminAirplane(Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		// 이전 페이지
		log.info(request.getHeader("referer"));
		
		if (loginVO != null) {
			
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			log.info(airlineNo);
			
			if (airlineNo != null) {
				PageObject pageObject = PageObject.getInstance(request);
				
				log.info("pageObject.getInstance" + pageObject);
				
				model.addAttribute("login");
				model.addAttribute("flightList", service.flightList(pageObject, airlineNo));
				model.addAttribute("pageObject", pageObject);
				
				return "air/airAdminAirplane";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
	}
	
	// 6-1. 관리자 기종 상세보기 - ajax 처리
		
	// 6-2. 관리자 기종 등록 - 포스트
	@PostMapping("/airplaneWrite.do")
	public String airplaneWrite(@ModelAttribute("list") AirplaneVO vo, RedirectAttributes rttr, HttpSession session, HttpServletRequest request) {
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				log.info(vo.getList());
				ArrayList<AirplaneVO> list = (ArrayList<AirplaneVO>) vo.getList();
				
				if (service.write(list, airlineNo) == 1) {
					rttr.addFlashAttribute("msg", "항공기가 등록되었습니다.");
				} else 
					rttr.addFlashAttribute("msg", "항공기 등록에 실패했습니다.");
				
				return "redirect:/air/airAdminAirplane.do";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
		
	}
	
	// 6-3. 관리자 기종 수정 - 
	
	// 6-4. 관리자 기종 삭제 - 
	
	// 7-1. 관리자 노선 및 운임 리스트
	@GetMapping("/airAdminRoutePrice.do")
	public String airAdminRoutePrice(Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				
				PageObject pageObject = PageObject.getInstance(request);
				model.addAttribute("login");
				model.addAttribute("routeList", service.routeList(pageObject, airlineNo, 0L));
				model.addAttribute("pageObject", pageObject);
				
				return "air/airAdminRoutePrice";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
	}
	
	// 7-2. 노선 등록 버튼
	@PostMapping("/airRouteWrite.do")
	public String airRouteWrite(RouteVO vo, Model model, RedirectAttributes rttr, HttpSession session, HttpServletRequest request) {
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				
				log.info(vo);
				
				if (service.routeWrite(vo, airlineNo) == 1) {
					rttr.addFlashAttribute("msg", "항공 노선이 등록되었습니다.");
				} else
					rttr.addFlashAttribute("msg", "항공 노선 등록을 실패 했습니다.");
				
				return "redirect:/air/airAdminRoutePrice.do";
				
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
	}
	
	// 7-3. 노선 수정 버튼
	@PostMapping("/airRouteUpdate.do")
	public String airRouteUpdate(RouteVO vo, Model model, RedirectAttributes rttr) {
		
		log.info(vo);
		
		if (service.routeUpdate(vo) == 1) {
			rttr.addFlashAttribute("msg", "항공 노선을 수정했습니다.");
		} else
			rttr.addFlashAttribute("msg", "항공 노선 수정을 실패 했습니다.");
		
		return "redirect:/air/airAdminRoutePrice.do";
	}
	
	// 7-4. 노선 삭제 버튼
	@PostMapping("/airRouteDelete.do")
	public String airRouteDelete(Long routeId, Model model, RedirectAttributes rttr) {
		
		log.info(routeId);
		
		if (service.routeDelete(routeId) == 1) {
			rttr.addFlashAttribute("msg", "항공 노선을 삭제했습니다.");
		} else
			rttr.addFlashAttribute("msg", "항공 노선 삭제를 실패 했습니다.");
		
		return "redirect:/air/airAdminRoutePrice.do";
	}
	
	// 8-1. 노선별 금액 상세보기 -- ajax 처리
	
	// 8-2. 노선별 금액 등록
	@PostMapping("/airPriceWrite.do")
	public String airAdminPriceWrite(PriceVO vo, RedirectAttributes rttr, HttpSession session, HttpServletRequest request) {
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				log.info(vo);
				if (service.priceWrite(vo, airlineNo) == 1) {
					rttr.addFlashAttribute("msg", "가격 등록을 성공했습니다.");
				} else
					rttr.addFlashAttribute("msg", "가격 등록을 실패 했습니다. 다시 시도해 주세요.");
				
				return "redirect:/air/airAdminRoutePrice.do";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
		
	}
	
	// 8-3. 노선별 금액 수정
	@PostMapping("/airPriceUpdate.do")
	public String airAdminPriceUpdate(PriceVO vo, RedirectAttributes rttr, HttpSession session, HttpServletRequest request) {
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				log.info(vo);
				if (service.priceUpdate(vo, airlineNo) == 1) {
					rttr.addFlashAttribute("msg", "가격 수정을 성공했습니다.");
				} else
					rttr.addFlashAttribute("msg", "가격 수정을 실패 했습니다. 다시 시도해 주세요.");
				
				return "redirect:/air/airAdminRoutePrice.do";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}		
		
	}
	
	
	// 9-1. 관리자 운항 스케줄 리스트
	@GetMapping("/airAdminSchedule.do")
	public String airAdminSchedule(Long routeId, Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");

		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				PageObject pageObject = PageObject.getInstance(request);
				
				model.addAttribute("routeList", service.routeList(pageObject, airlineNo, 0L));
				model.addAttribute("pageObject", pageObject);
				
				return "air/airAdminSchedule";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}

		
	}
	
	// 9-2. 관리자 운항 스케줄 상세보기
	@GetMapping("/airAdminScheduleDetail.do")
	public String airAdminScheduleDetail(Long routeId, Model model, HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				PageObject pageObject = PageObject.getInstance(request);
				
				model.addAttribute("vo", service.routeView(airlineNo, routeId));
				model.addAttribute("scheduleList", service.airScheduleDetail(airlineNo, routeId, pageObject));
				model.addAttribute("pageObject", pageObject);
				
				return "air/airAdminScheduleDetail";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
		
	}
	
	// 9-3. 관리자 운항 스케줄 등록 폼
	@GetMapping("/airAdminScheduleWriteForm.do")
	public String airAdminScheduleWriteForm(Long routeId, Model model, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				model.addAttribute("vo", service.routeView(airlineNo, routeId));
				
				return "air/airAdminScheduleWriteForm";
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
		
	}
	
	// 9-3. 관리자 운항 스케줄 등록
	@PostMapping("/airAdminScheduleWrite.do")
	public String airAdminScheduleWrite(ScheduleVO vo, Model model, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				log.info(vo);
				model.addAttribute("vo", service.airScheduleWrite(airlineNo, vo));
				
//				return "air/airAdminScheduleWrite";
				return "redirect:/air/airAdminScheduleDetail.do?routeId=" + vo.getRouteId();
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
		
		
	}
	
	// 9-5. 관리자 운항 스케줄 삭제
	@GetMapping("/airAdminScheduleDelete.do")
	public String airAdminScheduleDelete(Long scheduleId, Long routeId, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) {
		
		// 이전 페이지 정보
		String page = request.getHeader("referer");
		
		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		
		if (loginVO != null) {
			// airlineNo 가져오기
			Long airlineNo = service.getAirlineNo(loginVO.getEmail());
			
			log.info(airlineNo);
			
			if (airlineNo != null) {
				service.airScheduleDelete(airlineNo, scheduleId);
				
				return "redirect:/air/airAdminScheduleDetail.do?routeId=" + routeId;
			} else {
				if (page == null) page = "/main/main.do";
				rttr.addFlashAttribute("msg", "항공사 관리자 아이디가 아닙니다. 항공사 관리자 아이디로 로그인 해 주세요.");
				return "redirect:" + page;
			}
		} else {
			if (page == null) page = "/main/main.do";
			rttr.addFlashAttribute("msg", "권한이 존재 하지 않습니다. 관리자 아이디로 로그인해 주세요.");
			return "redirect:" + page;
		}
		
	}
	
	
	
	// --------------------------------------------- 항공 예약 서프트 --------------------------------------
	@GetMapping("/selectSeatEco.do")
	public String selectSeatEco() {
		
		return "air/selectSeatEco";
	}
	
	@GetMapping("/selectSeatBis.do")
	public String selectSeatBis() {
		
		return "air/selectSeatBis";
	}
	
	@GetMapping("/selectSeatFst.do")
	public String selectSeatFst() {
		
		return "air/selectSeatFst";
	}
	
	
}
