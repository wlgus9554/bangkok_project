package com.bangkok.member.restcontroller;

import com.bangkok.member.service.MemberService;
import com.bangkok.member.vo.GoogleMemberVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;

import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/kakao")
@Log4j
public class KakaoLoginController {

    private static final String KAKAO_CLIENT_ID = "db6ad3fe13bf1957ce42a1452d36ee81"; // 카카오 REST API 키
    private static final String KAKAO_TOKEN_URL = "https://kauth.kakao.com/oauth/token";
    private static final String KAKAO_USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";

    @Autowired
    @Qualifier("memberServiceImpl")
    private MemberService service;

    @PostMapping("/kakaoLogin.do")
    public Map<String, Object> handleKakaoLogin(@RequestBody Map<String, String> requestBody, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        String email = requestBody.get("email");
        String nickname = requestBody.get("nickname");
        String profileImage = requestBody.get("profileImage");

        try {
            // 이메일로 사용자 찾기
            MemberVO vo = service.findByEmail(email);

            if (vo == null) {
                // 신규 사용자 생성 로직
            	MemberVO kakaoMember = new MemberVO();
                kakaoMember.setEmail(email);
                kakaoMember.setName(nickname);
                kakaoMember.setPhoto(profileImage);
                kakaoMember.setPw("test"); 
                kakaoMember.setStatus("정상");
                kakaoMember.setGradeNo(1);
                kakaoMember.setNickName(nickname);
                kakaoMember.setGender("여자");
                
                if (profileImage == null || profileImage.isEmpty()) {
                    kakaoMember.setPhoto("default-profile.png"); 
                } else {
                    kakaoMember.setPhoto(profileImage);
                }
                service.saveKakaoMember(kakaoMember); 
                
                LoginVO kakaoLogin = new LoginVO();
                kakaoLogin.setEmail(email);
                kakaoLogin.setName(nickname);
                kakaoLogin.setPhoto(profileImage);
                kakaoLogin.setPw("test"); 
                kakaoLogin.setStatus("정상");
                kakaoLogin.setGradeNo(1);
                kakaoLogin.setNickName(nickname);
                kakaoLogin.setGender("여자");
                
                
                // 세션에 kakaoUser 저장
                session.setAttribute("login", kakaoLogin);
                log.info(session.getAttribute("login"));
            } else {
                // 기존 사용자일 경우
                String status = vo.getStatus();
                if ("탈퇴".equals(status) || "강퇴".equals(status)) { // 탈퇴 또는 강퇴 상태 확인
                    response.put("status", "error");
                    response.put("msg", status.equals("탈퇴") ? 
                        "탈퇴된 계정입니다. 다시 로그인해 주세요." : 
                        "강퇴된 계정입니다. 관리자에게 문의하세요."); // 상태에 따라 다른 메시지
                    return response; // 로그인을 진행하지 않고 종료
                }
                LoginVO kakaoLogin = new LoginVO();
                kakaoLogin.setEmail(vo.getEmail());
                kakaoLogin.setName(vo.getName());
                kakaoLogin.setPhoto(vo.getPhoto());
                kakaoLogin.setPw(vo.getPw()); 
                kakaoLogin.setStatus(vo.getStatus());
                kakaoLogin.setGradeNo(vo.getGradeNo());
                kakaoLogin.setNickName(vo.getNickName());
                kakaoLogin.setGender(vo.getGender());
                
                
                // 세션에 kakaoUser 저장
                session.setAttribute("login", kakaoLogin);
                
                session.setAttribute("kakaoUser", vo);
            }

            // 메시지 설정
            response.put("status", "success");
            response.put("msg", nickname + "님이 카카오 계정으로 로그인 되었습니다.");
         // 기존 회원이면 conDate 업데이트
            service.changeConDate(vo.getEmail());
        } catch (Exception e) {
            response.put("status", "error");
            response.put("msg", "카카오 로그인에 실패했습니다.");
        }

        return response;
    }



    // 로그아웃 처리
    @PostMapping("/logout.do")
    public Map<String, Object> logout(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // 세션 무효화
        session.invalidate();
        response.put("status", "success");
        response.put("msg", "로그아웃이 성공적으로 처리되었습니다.");

        return response;
    }
}
