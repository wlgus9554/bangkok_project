package com.bangkok.tripReply.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.tripReply.mapper.TripReplyMapper;
import com.bangkok.tripReply.vo.TripReplyVO;

@Service
@Qualifier("tripReplyServiceImpl")
public class TripReplyServiceImpl implements TripReplyService {

	@Inject
	TripReplyMapper mapper;
	
	@Override
	public List<TripReplyVO> list(Long no) {
		// TODO Auto-generated method stub
		return mapper.list(no);
	}

	@Override
	public Integer write(TripReplyVO tripReplyVO) {
		// TODO Auto-generated method stub
		return mapper.write(tripReplyVO);
	}

	@Override
	public Integer update(TripReplyVO tripReplyVO) {
		// TODO Auto-generated method stub
		return mapper.update(tripReplyVO);
	}

	@Override
	public Integer delete(TripReplyVO tripReplyVO) {
		// TODO Auto-generated method stub
		return mapper.delete(tripReplyVO);
	}

	
	
}
