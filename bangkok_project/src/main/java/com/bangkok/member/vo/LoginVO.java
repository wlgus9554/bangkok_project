package com.bangkok.member.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class LoginVO {

	private String email;
	private String pw;
	private String name;
	private String nickName;
	private String photo;
	private Integer gradeNo;
	private String gradeName; // grade 테이블에 있다.
	private String status;
	private String loginSource; // 로그인 소스 필드 추가
	private String tel; // 여기 추가
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth; // 생년월일
	private String gender;
}
