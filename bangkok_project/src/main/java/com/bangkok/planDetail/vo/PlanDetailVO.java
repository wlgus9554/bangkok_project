package com.bangkok.planDetail.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PlanDetailVO {

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date tripDate; 
	private Long pno;
	private Long tno;
	private Long no; // from. tripInfo T
	private String tripTime;
	private String planComment;
	private Long cityNum; // from. city T
	private String place; // from. tripInfo T
	private String imageFile; // from. tripInfo T
	private String cate_name; // from. tripInfoCategory T
	
}
