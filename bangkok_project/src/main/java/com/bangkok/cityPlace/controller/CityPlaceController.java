package com.bangkok.cityPlace.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bangkok.cityPlace.service.CityPlaceService;
import com.bangkok.util.page.PageObject;

@Controller
@RequestMapping("/cityPlaceAjax")
public class CityPlaceController {

	@Autowired
	@Qualifier("cityServiceImpl")
	CityPlaceService cityService;
	
	// 1-1. city list
	@GetMapping("/getCityList.do")
	public String cityList(Model model) {
		
		model.addAttribute("cityList", cityService.cityList());
		
		return "plan/citySearchModal";
		// return "plan/cityList";
	}
	
	// 1-2. city list
	@GetMapping("/getPlaceList.do")
	public String palceList(Model model, @RequestParam(name = "cityNum") Long cityNum, 
			HttpServletRequest request) throws Exception {
		
		// 페이지오브젝트 생성
		PageObject pageObject = PageObject.getInstance(request);
		// 리스트 객체 생성
		model.addAttribute("placeList", cityService.placeList(pageObject, cityNum));
		model.addAttribute("pageObject", pageObject);
		
		return "plan/placeSearchModal";
		// return "plan/placeList";
	}
	
}
