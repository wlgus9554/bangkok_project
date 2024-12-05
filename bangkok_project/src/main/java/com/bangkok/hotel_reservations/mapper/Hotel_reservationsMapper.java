package com.bangkok.hotel_reservations.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.event.vo.EventVO;
import com.bangkok.hotel_reservations.vo.Hotel_reservationsVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface Hotel_reservationsMapper {

	// 호텔 예약 리스트
	public List<Hotel_reservationsVO> list(String email);
	public List<Hotel_reservationsVO> listCompletion(String email);
	// 보기
	public Hotel_reservationsVO view(Long reservation_no);

	// 등록
	public Integer write(Hotel_reservationsVO vo);
	
	// 수정
	public Integer update(Hotel_reservationsVO vo);
	
	// 삭제
	public Integer delete(Hotel_reservationsVO vo);
	
	//호텔 정보
	public Hotel_reservationsVO hotel(Hotel_reservationsVO vo);
	
	public Hotel_reservationsVO check(String email);
	public List<Hotel_reservationsVO> business(@Param("email")String email, @Param("pageObject")PageObject pageObject);
	public Integer changeStatus(Hotel_reservationsVO vo);
	public Long getTotalRow(PageObject pageObject);
	public List<Hotel_reservationsVO> listAjax(String email);
	public List<Hotel_reservationsVO> listCompletionAjax(String email);


	
}
