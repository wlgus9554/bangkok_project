package com.bangkok.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bangkok.amenities.vo.AmenitiesVO;
import com.bangkok.hotel.vo.HotelAmenitiesVO;
import com.bangkok.hotel.vo.HotelImageVO;
import com.bangkok.hotel.vo.HotelRoomVO;
import com.bangkok.hotel.vo.HotelVO;
import com.bangkok.hotel.vo.RoomImageVO;
import com.bangkok.util.page.PageObject;

public interface HotelMapper {

	//상품 리스트
	public List<HotelVO> list(@Param("pageObject") PageObject pageObject);
	
	public List<HotelRoomVO> roomList(Long[] rno);
		
	// 상품 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(@Param("pageObject") PageObject pageObject);
	
	// 상세보기 조회수 1 증가
	public Integer increase(@Param("no") Integer no);
	
	// 상세보기
	public HotelVO view(@Param("no") Integer no);
	public List<HotelImageVO> hotelImageList(@Param("no") Integer no);
	public List<HotelRoomVO> hotelRoomList(@Param("no") Integer no);
	public List<RoomImageVO> roomImageList(@Param("rno") Long rno);
	public List<HotelVO> amenitiesList(@Param("no") Integer no);
	
	// 수정때메 만든 서비스
	public HotelRoomVO roomView(@Param("rno") Long rno, @Param("no") Integer no);
	
	//---- 상품 등록 
		// 1. 호텔 등록
		public Integer write(HotelVO vo);
		// 2. 호텔 이미지 등록
		public Integer writeHotelImage(List<HotelImageVO> list);
		// 
		public Long[] getRnos(List<HotelRoomVO> list);
		// 3. 객실 등록 
		public Integer writeHotelRoom(List<HotelRoomVO> list);
		// 4. 객실 이미지 등록
		public Integer writeRoomImage(List<HotelRoomVO> list);
		// 5. 편의시설 등록
		public Integer writeAmenities(List<HotelAmenitiesVO> list);
		// 6. 객실 조회
		public List<HotelRoomVO> searchRoom(Integer no);
		
		// ------------------ 수정 ------------------------
		public Integer update(HotelVO vo);
		
		// ------------------ 객실 수정 ------------------------
		public Long updateRoom(HotelRoomVO vo);
		
		// 편의시설 가져오기
		public List<AmenitiesVO> getAmenities(@Param("amenitiesNo") Integer amenitiesNo);
		// 특정 호텔의 편의시설 가져오기
		public List<HotelAmenitiesVO> getHotelAmenitiesNo(@Param("no") Integer no);
		
		public Integer updateAmenities(HotelAmenitiesVO hotelAmenitiesVO);

		// 호텔 이미지 수정
		public Integer changeImage(HotelVO vo);
		
		// 호텔 이미지 수정
		public Integer changeDetailImage(HotelVO vo);
		
		// 호텔 추가 이미지 수정
		public Integer changeHotelImage(HotelImageVO hotelImageVO);
		
		// 객실 이미지 수정
		public Integer changeRoomImage(HotelRoomVO roomVO);
		
		// 객실 이미지 수정
		public Integer changeRoomImages(RoomImageVO roomImageVO);
		
		// 편의시설 수정 & 삭제
		public Integer deleteAmenities(@Param("no") Integer no);
		
		// 호텔 삭제
		public Integer delete(HotelVO vo);
		
}
