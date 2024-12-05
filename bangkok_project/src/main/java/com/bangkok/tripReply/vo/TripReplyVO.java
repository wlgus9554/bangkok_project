package com.bangkok.tripReply.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TripReplyVO {

	private Long rno;
	private Long no;
	private String r_content;
	private String email;
	private String nickName;
	private String photo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date r_writeDate;
	
}
