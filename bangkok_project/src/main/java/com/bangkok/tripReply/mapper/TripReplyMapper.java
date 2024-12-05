package com.bangkok.tripReply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.tripReply.vo.TripReplyVO;

@Repository
public interface TripReplyMapper {

	public List<TripReplyVO> list(@Param(value = "no") Long no);
	
	public Integer write(TripReplyVO tripReplyVO);
	
	public Integer update(TripReplyVO tripReplyVO);
	
	public Integer delete(TripReplyVO tripReplyVO);
	
}
