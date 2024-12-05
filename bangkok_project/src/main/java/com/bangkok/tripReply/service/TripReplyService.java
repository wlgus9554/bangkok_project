package com.bangkok.tripReply.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bangkok.tripReply.vo.TripReplyVO;

@Service
public interface TripReplyService {

	public List<TripReplyVO> list(Long no);
	
	public Integer write(TripReplyVO tripReplyVO);
	
	public Integer update(TripReplyVO tripReplyVO);
	
	public Integer delete(TripReplyVO tripReplyVO);
	
}
