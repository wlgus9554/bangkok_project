package com.bangkok.hotel.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bangkok.amenities.vo.AmenitiesVO;
import com.bangkok.hotel.vo.HotelAmenitiesVO;
import com.bangkok.hotel.vo.HotelImageVO;
import com.bangkok.hotel.vo.HotelRoomVO;
import com.bangkok.hotel.vo.HotelVO;
import com.bangkok.hotel.vo.RoomImageVO;
import com.bangkok.util.page.PageObject;

public interface HotelService {

    // 상품 리스트
	public List<HotelVO> list(PageObject pageObject);
	public List<HotelRoomVO> roomList(Long[] rno);
	
	// 상품 보기
	public HotelVO view(Integer no, int inc);
	public List<HotelImageVO> hotelImageList(Integer no); // 호텔 사진
	public List<HotelRoomVO> hotelRoomList(Integer no); // 객실 리스트
	public List<RoomImageVO> roomImageList(Long rno); // 객실 사진
	public List<HotelVO> amenitiesList(Integer no); // 편의시설
	
	// 수정때메 만든 서비스
	public HotelRoomVO roomView(Long rno, Integer no);
	
	// 상품 등록
	public Integer write(HotelVO vo,  
			List<HotelImageVO> hotelimageList, // 호텔 사진
			List<HotelRoomVO> hotelRoomList, // 객실
			Integer[] hotelAmenitiesList); // 편의시설
	
	// 상품 수정 - 텍스트 정보 + 대표 이미지 + 상세 설명 이미지
	public Integer update(HotelVO vo);
	
	// 상품 수정 - 텍스트 정보 + 대표 이미지 + 상세 설명 이미지
	public Long updateRoom(HotelRoomVO rvo);
	
	// 상품 삭제
	public Integer delete(HotelVO vo);
	
	// 상품 이미지 추가
	// 상품 이미지 변경
	// 상품 이미지 제거
	
	// 상품 사이즈컬러 추가
	// 상품 사이즈컬러 변경
	// 상품 사이즈컬러 제거
	
	// 상품 현재 가격 변경 + 기간 변경
	// 상품 예정 가격 추가
	
	// 편의시설 가져오기
	public List<AmenitiesVO> getAmenities(@Param("amenitiesNo") Integer amenitiesNo);
	// 특정 호텔의 편의시설 가져오기
	public List<HotelAmenitiesVO> getHotelAmenitiesNo(Integer hotelNo);
	
	// 호텔 사진 변경
	public Integer changeImage(HotelVO vo);
	
	// 호텔 상세보기 변경
	public Integer changeDetailImage(HotelVO vo);
	
	// 호텔 추가 이미지 수정
	public Integer changeHotelImage(HotelImageVO hotelImageVO);
	
	// 객실 이미지 수정
	public Integer changeRoomImage(HotelRoomVO roomVO);
	
	// 객실 이미지 수정
	public Integer changeRoomImages(RoomImageVO roomImageVO);
	
	// 편의시설 수정
	public Integer updateAmenities(Integer no, List<HotelAmenitiesVO> list);

}
