package com.bangkok.planDetail.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.planDetail.vo.PlanDetailVO;

@Repository
public interface PlanDetailMapper {
	
	// 1-1. 날짜 조회
//	public List<PlanDetailVO> getDate(@Param(value = "tno") Long tno);

	// 1-2. list
	public List<PlanDetailVO> planList(@Param(value = "tno") Long tno,
			@Param(value = "tripDate") Date tripDate);

	// 2. view
	public PlanDetailVO planView(@Param(value = "tno") Long tno, @Param(value = "pno") Long pno);
	
	// 3. write
	public Integer planWrite(PlanDetailVO planDetailVO);
	
	// 4. update
	public Integer planUpdate(PlanDetailVO planDetailVO);
	
	// 5. delete
	public Integer planDelete(PlanDetailVO planDetailVO);
	
}
