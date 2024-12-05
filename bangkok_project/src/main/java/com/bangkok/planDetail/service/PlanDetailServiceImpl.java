package com.bangkok.planDetail.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.planDetail.mapper.PlanDetailMapper;
import com.bangkok.planDetail.vo.PlanDetailVO;

@Service
@Qualifier("planDetailServiceImpl")
public class PlanDetailServiceImpl implements PlanDetailService {

	@Inject
	PlanDetailMapper mapper;
	
	@Override
	public List<PlanDetailVO> planList(Long tno, Date tripDate) {
		return mapper.planList(tno, tripDate);
	}

//	@Override
//	public List<PlanDetailVO> getDate(Long tno) {
//		// TODO Auto-generated method stub
//		return mapper.getDate(tno);
//	}

	@Override
	public PlanDetailVO planView(Long tno, Long pno) {
		// TODO Auto-generated method stub
		return mapper.planView(tno, pno);
	}

	@Override
	public Integer planWrite(PlanDetailVO planDetailVO) {
		// TODO Auto-generated method stub
		return mapper.planWrite(planDetailVO);
	}

	@Override
	public Integer planUpdate(PlanDetailVO planDetailVO) {
		// TODO Auto-generated method stub
		return mapper.planUpdate(planDetailVO);
	}

	@Override
	public Integer planDelete(PlanDetailVO planDetailVO) {
		// TODO Auto-generated method stub
		return mapper.planDelete(planDetailVO);
	}


	
}
