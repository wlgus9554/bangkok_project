package com.bangkok.tripReply.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.tripReply.service.TripReplyService;
import com.bangkok.tripReply.vo.TripReplyVO;
import com.bangkok.util.page.PageObject;
import com.google.common.util.concurrent.Service;

@Controller
@RequestMapping("/tripReplyAjax")
public class TripReplyController {

	@Autowired
	@Qualifier("tripReplyServiceImpl")
	TripReplyService service;
	
	// list
	@GetMapping("/list.do")
	public String list(Model model, @RequestParam(name = "no") Long no) {
		model.addAttribute("replyList", service.list(no));
		return "/tripReply/list";
	}
	
	// write
	@PostMapping("/write.do")
	public String write(TripReplyVO tripReplyVO, HttpServletRequest request, 
			PageObject pageObject, RedirectAttributes rttr) throws Exception {
		service.write(tripReplyVO);
		pageObject = PageObject.getInstance(request);
		rttr.addFlashAttribute("msg", "댓글이 정상적으로 등록되었습니다.");
		return "redirect:/info/view.do?no="+ tripReplyVO.getNo() + "&" + pageObject.getPageQuery();
	}
	
	// update
	@PostMapping("/update.do")
	public String update(TripReplyVO tripReplyVO, HttpServletRequest request, 
			PageObject pageObject, RedirectAttributes rttr) throws Exception {
		service.update(tripReplyVO);
		pageObject = PageObject.getInstance(request);
		rttr.addFlashAttribute("msg", "댓글이 정상적으로 수정되었습니다.");
		return "redirect:/info/view.do?no="+ tripReplyVO.getNo() + "&" + pageObject.getPageQuery();
	}
	
	// delete
	@PostMapping("/delete.do")
	public String delete(TripReplyVO tripReplyVO, HttpServletRequest request, 
			PageObject pageObject, RedirectAttributes rttr) throws Exception {
		service.delete(tripReplyVO);
		pageObject = PageObject.getInstance(request);
		rttr.addFlashAttribute("msg", "댓글이 정상적으로 삭제되었습니다.");
		return "redirect:/info/view.do?no="+ tripReplyVO.getNo() + "&" + pageObject.getPageQuery();
	}
	
}
