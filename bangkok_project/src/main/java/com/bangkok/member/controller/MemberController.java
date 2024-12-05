package com.bangkok.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.member.service.EmailService;
import com.bangkok.member.service.MemberService;
import com.bangkok.member.vo.BusinessVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;
import com.bangkok.util.file.FileUtil;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	// 파일 위치 지정
	String path = "/upload/member";
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;
	@Autowired
	private EmailService emailService;

	// 회원 리스트 - 관리자만
	@GetMapping("/memberList.do")
	public String list(Model model, HttpServletRequest request, HttpSession session) throws Exception {
	    // 세션에서 gradeNo 가져오기
	    Integer gradeNoObj = (Integer) session.getAttribute("gradeNo"); // Integer로 가져오기
	    
	    // gradeNo가 null일 경우 로그인 페이지로 리다이렉트
	    if (gradeNoObj == null) {
	    	model.addAttribute("msg", "권한이 없습니다."); // 모달에서 보여줄 메시지
	    	return "member/memberList"; // 동일한 페이지에서 모달을 띄움
	    }

	    int gradeNo = gradeNoObj; // null이 아닐 경우 gradeNoObj를 사용
	    log.info("세션에서 가져온 gradeNo: " + gradeNo); // 세션 확인

	    // gradeNo가 9가 아닐 경우
	    if (gradeNo != 9) {
	        model.addAttribute("msg", "권한이 없습니다."); // 모달에서 보여줄 메시지
	        return "member/memberList"; // 동일한 페이지에서 모달을 띄움
	    }

	    // 페이지 정보 가져오기
	    PageObject pageObject = PageObject.getInstance(request);
	    model.addAttribute("list", service.list(pageObject));
	    model.addAttribute("pageObject", pageObject);

	    return "member/memberList"; // 정상적으로 리스트 반환
	}





	@RequestMapping("/view.do")
	public String view(Model model, String mode,HttpSession session, @RequestParam(value = "email", required = false) String email) {
	    log.info("memberController.view()-------------");
	    
	    // 세션에서 로그인 정보를 가져옴
	    LoginVO loginVO = (LoginVO) session.getAttribute("login");
	    
	    String loggedInUserEmail = null;

	    // 로그인 확인
	    if (loginVO == null) {
	        log.warn("사용자가 로그인하지 않았습니다.");
	        return "redirect:/main/main.do"; // 로그인 페이지로 리다이렉트
	    } else {
	        loggedInUserEmail = loginVO.getEmail();
	        log.info("로그인한 사용자 이메일: " + loggedInUserEmail);
	    }

	    // 이메일이 없으면 세션에서 가져오기
	    if (email == null || email.isEmpty()) {
	        email = loggedInUserEmail; // 세션에서 가져온 이메일로 업데이트
	    }

	    // 이메일이 유효한지 확인
	    if (email != null && !email.isEmpty()) {
	        MemberVO memberInfo = service.view(email); // 이메일로 회원 정보 조회
	        if (memberInfo != null) {
	            model.addAttribute("vo", memberInfo); // 모델에 회원 정보 추가
	            boolean isEditable = loggedInUserEmail.equals(memberInfo.getEmail());
	            model.addAttribute("isEditable", isEditable);
	            log.info("현재 조회한 사용자 이메일: " + memberInfo.getEmail());

	            return "member/view"; // 회원 정보 뷰 반환
	        } else {
	            log.warn("해당 이메일에 대한 사용자 정보를 찾을 수 없습니다: " + email);
	            return "redirect:/main/main.do"; // 사용자 정보를 찾을 수 없는 경우 메인으로 리다이렉트
	        }
	    } else {
	        log.warn("이메일이 유효하지 않습니다.");
	        return "redirect:/main/main.do"; // 유효하지 않은 이메일 처리
	    }
	}






	// 회원가입 폼
	@GetMapping("/joinForm.do")
	public String writeForm() {
		log.info("memberController.JoinForm()-------------");
		return "member/joinForm";
	}

	// 회원가입 처리
	@PostMapping("/join.do")
	public String join(MemberVO memberVO, BusinessVO businessVO, int gradeNo, RedirectAttributes rttr,
			MultipartFile photoFile, HttpServletRequest request) throws Exception {
		// 파일 업로드 처리
		if (photoFile != null && !photoFile.isEmpty()) {
			String photoPath = FileUtil.upload(path, photoFile, request);
			memberVO.setPhoto(photoPath);
			log.info("업로드된 사진: " + photoFile.getOriginalFilename());

		}
		// 회원 등급에 따라 분기
		memberVO.setGradeNo(gradeNo);
		service.join(memberVO, businessVO);
		rttr.addFlashAttribute("msg", "회원가입 되셨습니다 로그인 후 이용해주세요.");
		return "redirect:/main/main.do";
	}

	// 회원 정보 수정 폼
	@PostMapping("/updateForm.do")
	public String updateForm(Model model, @RequestParam("email") String email) {
		log.info("memberController.updateForm()-------------");
		log.info(email);
		// 데이터 조회 후 모델에 추가
		model.addAttribute("vo", service.view(email));
		// 업데이트 폼 뷰 반환
		return "member/updateForm";
	}
	
//	@GetMapping("/updateForm.do")
//	public String updateForm(Model model, HttpServletRequest request,@RequestParam("email")String email) {
//	    email = (String) request.getSession().getAttribute("loginEmail"); // 세션에서 이메일 가져오기
//	    log.info("memberController.updateForm()-------------");
//	    log.info(email);
//	    model.addAttribute("vo", service.view(email));
//	    return "member/updateForm";
//	}

	// 회원 정보 수정 처리
	@PostMapping(value = "/update.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, String>> update(
	        @RequestParam("email") String email, 
	        MemberVO memberVO,
	        @RequestParam(value = "photoFile", required = false) MultipartFile photoFile,
	        @RequestParam(value = "existingPhoto", required = false) String existingPhoto,
	        HttpServletRequest request) throws Exception {
	    
	    log.info("memberController.update()-------------");
	    log.info("전달된 이메일: " + email); // 전달된 이메일 로그 추가

	    // 이메일 설정
	    memberVO.setEmail(email); // 전달받은 이메일로 memberVO 설정
	    // 기본 프로필 이미지 경로 (예: "/images/default_profile.png")
	    String defaultProfileImagePath = "/upload/member/Default_Profile.png";
	    // 기존 사진이 있을 경우, 기본값으로 설정
	    if (existingPhoto != null && !existingPhoto.isEmpty()) {
	        memberVO.setPhoto(existingPhoto);
	    } else if (photoFile == null || photoFile.isEmpty()) {
	        // 프로필 삭제 버튼을 눌렀거나 사진 파일이 없을 경우, 디폴트 프로필 이미지로 설정
	        memberVO.setPhoto(defaultProfileImagePath);
	        log.info("프로필 삭제: 기본 이미지로 변경됨");
	    }
	    // 파일 업로드 처리
	    if (photoFile != null && !photoFile.isEmpty()) {
	        String photoPath = FileUtil.upload(path, photoFile, request);
	        memberVO.setPhoto(photoPath);
	        log.info("업로드된 사진: " + photoFile.getOriginalFilename());
	    }

	    Integer result = service.update(memberVO);

	    Map<String, String> response = new HashMap<>();
	    if (result > 0) {
	        // 세션 업데이트
	        // 여기에 getMemberInfo 메소드가 MemberVO가 아닌 LoginVO를 반환하는지 확인
	    	// 이메일로 LoginVO 정보를 가져옴
	        LoginVO loginInfo = service.getLoginInfo(email); // LoginVO를 반환하는 메소드 호출
	        request.getSession().setAttribute("login", loginInfo); // 로그인 정보를 세션에 저장
	        response.put("status", "success");
	        response.put("msg", "정보가 성공적으로 업데이트되었습니다.");
	    } else {
	        response.put("status", "error");
	        response.put("msg", "정보 업데이트에 실패했습니다.");
	    }
	    return ResponseEntity.ok(response);
	}




	// 사업자 정보 수정 폼
	@GetMapping("/bisUpdateForm.do")
	public String bisUpdateForm(Model model, @RequestParam("email") String email) {
	    log.info("memberController.bisUpdateForm()-------------");
	    log.info("전달된 이메일: " + email); // 전달된 이메일 로그 추가

	    // 이메일이 비어있지 않은지 확인
	    if (email == null || email.isEmpty()) {
	        log.warn("이메일이 유효하지 않습니다.");
	        return "redirect:/main/main.do"; // 유효하지 않은 이메일 처리
	    }

	    // 데이터 조회 후 모델에 추가
	    model.addAttribute("vo", service.bisView(email));
	    return "member/bisUpdateForm"; // 업데이트 폼 뷰 반환
	}


	// 사업자 정보 수정 처리
	@PostMapping("/bisUpdate.do")
	public String bisUpdate(BusinessVO vo, RedirectAttributes rttr) throws Exception {
	    log.info("memberController.bisUpdate()-------------");
	    
	    // vo에서 이메일 확인
	    log.info("전달된 BusinessVO: " + vo); // BusinessVO 로그 추가
	    if (vo.getEmail() == null || vo.getEmail().isEmpty()) {
	        log.warn("비즈니스 사용자 이메일이 비어 있습니다.");
	        rttr.addFlashAttribute("msg", "이메일 정보가 없습니다.");
	        return "redirect:/main/main.do"; // 이메일이 없을 경우 메인으로 리다이렉트
	    }

	    Integer result = service.bisUpdate(vo);

	    if (result > 0) {
	        // 세션 업데이트
	        rttr.addFlashAttribute("msg", "정보가 성공적으로 업데이트되었습니다.");
	        return "redirect:/member/bisView.do?email=" + vo.getEmail(); // 업데이트 후 상세보기 페이지로 리다이렉트
	    } else {
	        rttr.addFlashAttribute("msg", "정보 업데이트에 실패했습니다.");
	        return "redirect:/member/bisUpdateForm.do?email=" + vo.getEmail(); // 업데이트 실패 시 다시 회원 정보 페이지로 리다이렉트
	    }
	}


	@RequestMapping("/bisView.do")
	public String bisView(Model model, HttpSession session, @RequestParam(value = "email", required = false) String email) {
	    log.info("memberController.bisView()-------------");

	    // 세션에서 이메일 가져오기
	    if (email == null || email.isEmpty()) {
	        if (session.getAttribute("email") != null) {
	            email = (String) session.getAttribute("email");
	            session.removeAttribute("email");
	            log.info("세션에서 가져온 이메일: " + email);
	        } else {
	            log.warn("이메일이 제공되지 않았고 세션에서도 찾을 수 없습니다.");
	            return "redirect:/main/main.do"; // 이메일이 없으면 메인으로 리다이렉트
	        }
	    }

	    // 사업자 정보 조회
	    BusinessVO businessInfo = service.bisView(email);
	    if (businessInfo != null) {
	        model.addAttribute("vo", businessInfo); // 모델에 사업자 정보 추가
	        return "member/bisView"; // 사업자 정보 뷰 반환
	    } else {
	        log.warn("해당 이메일에 대한 사업자 정보를 찾을 수 없습니다: " + email);
	        return "redirect:/main/main.do"; // 사업자 정보를 찾을 수 없는 경우 메인으로 리다이렉트
	    }
	}


	// 이메일 찾기 폼
	@GetMapping("/findEmailForm.do")
	public String showFindEmailForm() {
		// 이메일 찾기 폼으로 이동
		return "member/findEmailForm"; // JSP 파일 경로
	}

	// 이메일 찾기 처리
	@PostMapping("/findEmailResult.do")
	public String findEmailResult(@RequestParam("name") String name, @RequestParam("tel") String tel, Model model) {
		String email = service.findEmail(name, tel);

		if (email != null) {
			model.addAttribute("email", email);
			return "member/emailResult"; // 결과 페이지
		} else {
			model.addAttribute("msg", "일치하는 이메일이 없습니다.");
			return "member/findEmailForm"; // 폼으로 다시 이동
		}
	}

	// 비밀번호 찾기 폼 및 결과 처리 (단일 JSP 사용)
	@GetMapping("/findPwForm.do")
	public String showFindPwForm(Model model) {
		// JSP에서 비밀번호 찾기 폼 및 결과를 함께 보여주도록 처리
		model.addAttribute("msg", ""); // 빈 메시지로 시작
		return "member/findPwForm"; // JSP 파일 경로
	}

	// 비밀번호 찾기 처리
	@PostMapping("/findPw.do")
	public String findPassword(@RequestParam("name") String name, 
	                           @RequestParam("email") String email,
	                           @RequestParam("tel") String tel,
	                           Model model) {
	    MemberVO member = service.findPassword(name, email, tel);

	    if (member != null) {
	        String token = UUID.randomUUID().toString();
	        service.createPasswordResetTokenForUser(member, token);

	        String resetUrl = "http://localhost:80/member/findPwResult.do?token=" + token;
	        emailService.sendSimpleMessage(email, "[BANGKOK] 비밀번호 재설정", "비밀번호를 재설정하려면 아래 링크를 클릭하세요:\n" + resetUrl);
	        model.addAttribute("msg", "비밀번호 재설정 링크가 이메일로 전송되었습니다."); // 포워드로 메시지 전달

	    } else {
	        model.addAttribute("msg", "입력하신 정보와 일치하는 사용자가 없습니다."); // 포워드로 메시지 전달
	    }

	    return "member/findPwForm"; // 비밀번호 찾기 폼으로 포워드
	}



	@GetMapping("/findPwResult.do")
	public String showResetPasswordForm(@RequestParam("token") String token, Model model) {
	    if (service.validatePasswordResetToken(token)) {
	        model.addAttribute("token", token); // 토큰을 JSP로 전달
	        return "member/resetPwForm"; // 비밀번호 재설정 폼으로 이동
	    } else {
	        model.addAttribute("msg", "유효하지 않은 링크입니다."); // 모달에 표시할 메시지 추가
	        return "member/resetPwForm"; // 비밀번호 재설정 폼으로 이동
	    }
	}


	
	@PostMapping("/resetPw.do")
	public String resetPassword(@RequestParam("token") String token, @RequestParam("pw") String pw, RedirectAttributes rttr) {
	    if (service.resetPassword(token, pw)) {
	        rttr.addFlashAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
	        return "redirect:/main/main.do";
	    } else {
	        rttr.addFlashAttribute("msg", "비밀번호 변경에 실패했습니다.");
	        return "member/resetPwForm";
	    }
	}
	


	// 회원 탈퇴 처리
	@PostMapping("/delete.do")
	public String delete(MemberVO vo, RedirectAttributes rttr, HttpServletRequest request) {
		log.info("memberController.delete()-------------");

		vo.setStatus("탈퇴"); // 상태를 '탈퇴'로 설정

		if (service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", "회원 탈퇴 완료 되었습니다.");

			// 로그아웃 처리 (세션 무효화)
			request.getSession().invalidate();

			return "redirect:/main/main.do";
		} else {
			rttr.addFlashAttribute("msg", "회원관리 삭제를 실패했습니다.");
			return "redirect:view.do?no=" + vo.getEmail() + "&inc=0";
		}
	}

	// 회원 상태/등급 수정 처리 - 관리자
	@PostMapping("/updateMember.do")
	public String updateMember(@RequestParam("email") String email,
	                           @RequestParam(value = "status", required = false) String status,
	                           @RequestParam(value = "gradeNo", required = false) Integer gradeNo,
	                           HttpServletRequest request,
	                           RedirectAttributes rttr) {
	    // 회원 정보를 업데이트하는 서비스 메서드 호출
	    if (status != null) {
	        service.updateStatus(email, status);
	    }
	    if (gradeNo != null) {
	        service.updateGrade(email, gradeNo);
	    }

	    // 성공 메시지 설정
	    rttr.addFlashAttribute("msg", "회원 정보가 성공적으로 변경되었습니다.");

	    // 현재 로그인한 사용자의 gradeNo 확인
	    Integer userGradeNo = (Integer) request.getSession().getAttribute("gradeNo");

	    // 관리자일 경우 회원 리스트 페이지로, 일반 사용자일 경우 메인 페이지로 리다이렉트
	    if (userGradeNo != null && userGradeNo == 9) {
	        return "redirect:/member/memberList.do"; // 관리자: 회원 리스트 페이지로 이동
	    } else {
	        return "redirect:/main/main.do"; // 일반 사용자: 메인 페이지로 이동
	    }
	}


	@PostMapping("/login.do")
	public String login(LoginVO vo, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) {
	    // 이전 페이지 정보
	    String page = request.getHeader("referer");
	    // 로그인 로직
	    LoginVO loginVO = service.login(vo);

	    if (loginVO == null) {
	        rttr.addFlashAttribute("msg", "로그인 정보가 맞지 않습니다. 다시 로그인 해주세요.");
	        return "redirect:/main/main.do";
	    }

	    if ("탈퇴".equals(loginVO.getStatus()) || "강퇴".equals(loginVO.getStatus())) {
	        rttr.addFlashAttribute("msg", "회원 탈퇴 또는 강퇴된 계정입니다. 관리자에게 문의하세요.");
	        return "redirect:/main/main.do";
	    }

	    // 로그인 정보 세션에 저장 (필요하다면)
	    session.setAttribute("login", loginVO);
	    session.setAttribute("email", loginVO.getEmail());
	    session.setAttribute("gradeNo", loginVO.getGradeNo());

	    // 최근접속일 업데이트
	    service.changeConDate(loginVO.getEmail());

	   
	    // 로그인 소스에 따라 메시지 설정
	    String loginSourceMessage = "";
	    if ("GOOGLE".equals(vo.getLoginSource())) {
	        loginSourceMessage = "구글 계정으로 로그인 되었습니다.";
	    } else if ("KAKAO".equals(vo.getLoginSource())) {
	        loginSourceMessage = "카카오 계정으로 로그인 되었습니다.";
	    }

	    rttr.addFlashAttribute("msg", loginVO.getName() + "님은 " + loginVO.getGradeName() + " (으)로 로그인 되었습니다. " + loginSourceMessage);
	    
	    // 뷰에 데이터 전달 후 페이지 이동
	    return "redirect:" + page;
	}


	// 로그아웃 처리
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
	    log.info("memberController.logout()-------------");
	    // 세션에서 모든 정보 제거
//	    session.removeAttribute("login"); // 특정 속성 제거
	    session.invalidate(); // 세션 무효화
	    rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
	    return "redirect:/main/main.do";
	}

 
}
