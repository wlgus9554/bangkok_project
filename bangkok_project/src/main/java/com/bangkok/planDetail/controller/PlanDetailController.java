package com.bangkok.planDetail.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.planDetail.service.PlanDetailService;
import com.bangkok.planDetail.vo.PlanDetailVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/planAjax")
@Log4j
public class PlanDetailController {

	@Autowired
	@Qualifier("planDetailServiceImpl")
	PlanDetailService service;
	
	@GetMapping("/getPlanList.do")
	public String PlanList(Model model, 
			@RequestParam(name = "tno") Long tno, 
			@RequestParam(name = "tripDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date tripDate) {
		model.addAttribute("planDetailList", service.planList(tno, tripDate));
		// model.addAttribute("date", service.getDate(tno));
		log.info(service.planList(tno, tripDate));
		return "/plan/planList";
	}
	
	@GetMapping("/getPlanView.do")
	public String PlanView(Model model, 
			@RequestParam(name = "tno") Long tno, 
			@RequestParam(name = "pno") Long pno) {
		model.addAttribute("planVO", service.planView(tno, pno));
		return "/plan/planWriteModal";
	}
	
	@GetMapping("/getPlanWriteForm.do")
	public String PlanWriteForm() {
		return "/plan/planWriteModal";
	}
	
	@GetMapping("/getPlanUpdateForm.do")
	public String getPlanUpdateForm(Model model, 
			@RequestParam(name = "tno") Long tno, 
			@RequestParam(name = "pno") Long pno) {
		model.addAttribute("vo", service.planView(tno, pno));
		return "/plan/planUpdateModal";
	}
	
	@PostMapping("/planWrite.do")
	public String planWrite(PlanDetailVO planDetailVO, RedirectAttributes rttr) {
		service.planWrite(planDetailVO);
		rttr.addFlashAttribute("msg", "여행 일정이 정상적으로 등록되었습니다.");
		return "redirect:/plan/view.do?tno=" + planDetailVO.getTno();
	}
	
	@PostMapping("/planUpdate.do")
	public String planUpdate(PlanDetailVO planDetailVO, RedirectAttributes rttr) {
		service.planUpdate(planDetailVO);
		rttr.addFlashAttribute("msg", "여행 일정이 정상적으로 수정되었습니다.");
		return "redirect:/plan/view.do?tno=" + planDetailVO.getTno();
	}
	
	@PostMapping("/planDelete.do")
	public String planDelete(PlanDetailVO planDetailVO, RedirectAttributes rttr) {
		service.planDelete(planDetailVO);
		rttr.addFlashAttribute("msg", "여행 일정이 정상적으로 삭제되었습니다.");
		return "redirect:/plan/view.do?tno=" + planDetailVO.getTno();
	}
}
