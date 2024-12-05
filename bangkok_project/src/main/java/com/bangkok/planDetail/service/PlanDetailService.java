package com.bangkok.planDetail.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bangkok.planDetail.vo.PlanDetailVO;

@Service
public interface PlanDetailService {

	public List<PlanDetailVO> planList(Long tno, Date tripDate);
	
	// 여행 날짜 조회
//	public List<PlanDetailVO> getDate(Long tno);
	
	public PlanDetailVO planView(Long tno, Long pno);
	
	public Integer planWrite(PlanDetailVO planDetailVO);

	public Integer planUpdate(PlanDetailVO planDetailVO);
	
	public Integer planDelete(PlanDetailVO planDetailVO);
}
