package com.bangkok.hotel.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bangkok.amenities.vo.AmenitiesVO;
import com.bangkok.hotel.mapper.HotelMapper;
import com.bangkok.hotel.vo.HotelAmenitiesVO;
import com.bangkok.hotel.vo.HotelImageVO;
import com.bangkok.hotel.vo.HotelRoomVO;
import com.bangkok.hotel.vo.HotelVO;
import com.bangkok.hotel.vo.RoomImageVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
//Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("hotelServiceImpl")
public class HotelServiceImpl implements HotelService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private HotelMapper mapper;
	
	// 상품 리스트
	@Override
	public List<HotelVO> list(PageObject pageObject) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
//	@Override
	public List<HotelRoomVO> roomList(Long[] rno){
		return mapper.roomList(rno);
	}
	// 상품 글보기
	@Override
	@Transactional
	public HotelVO view(Integer no, int inc) {
		log.info("view() 실행");
		if(inc == 1) mapper.increase(no);
		return mapper.view(no);
	}
	
	public List<HotelImageVO> hotelImageList(Integer no) {
		log.info("viewHotelImageList() 실행");
		return mapper.hotelImageList(no);
	}
	
	@Override
	public List<HotelRoomVO> hotelRoomList(Integer no) {
		// TODO Auto-generated method stub
		return mapper.hotelRoomList(no);
	}
	
	@Override
	public List<RoomImageVO> roomImageList(Long rno) {
		// TODO Auto-generated method stub
		return mapper.roomImageList(rno);
	}
	@Override
	public List<HotelVO> amenitiesList(Integer no) {
		// TODO Auto-generated method stub
		return mapper.amenitiesList(no);
	}
	
	
	// 호텔, 객실 등록
	@Override
	@Transactional
	public Integer write(HotelVO vo,  
			List<HotelImageVO> hotelimageList,
			List<HotelRoomVO> hotelRoomList,
			Integer[] hotelAmenitiesList
			) {
		Integer result = null;
		
		mapper.write(vo);
		
		// 호텔 추가 이미지 
		if(hotelimageList != null && hotelimageList.size() > 0) {
			for(HotelImageVO hotelimageVO : hotelimageList)
				hotelimageVO.setNo(vo.getNo());
			mapper.writeHotelImage(hotelimageList);
		}
		
		Long[] rnos = mapper.getRnos(hotelRoomList);
		
		// 객실
		if (hotelRoomList != null && hotelRoomList.size() > 0) {
			int i = 0;
			boolean empty = true;
			for (HotelRoomVO roomVO : hotelRoomList) {
				if(roomVO.getRoom_image_names() != null && roomVO.getRoom_image_names().size() > 0)
					empty = false;
				roomVO.setNo(vo.getNo());
				roomVO.setRno(rnos[i++]);
			}
			mapper.writeHotelRoom(hotelRoomList);
			if(!empty)
				mapper.writeRoomImage(hotelRoomList);
		}
		
		// 편의시설 
		List<HotelAmenitiesVO> amenitiesList = null;
		if(hotelAmenitiesList != null && hotelAmenitiesList.length > 0) {
			for(Integer amenitiesNo : hotelAmenitiesList) {
				if(amenitiesList == null) amenitiesList = new ArrayList<>(); 
				HotelAmenitiesVO amenitiesVO = new HotelAmenitiesVO();
				amenitiesVO.setAmenitiesNo(amenitiesNo);
				amenitiesVO.setNo(vo.getNo());
				amenitiesList.add(amenitiesVO);
			}
				mapper.writeAmenities(amenitiesList);
		}
		
		
		return result;
	}
	
	// 호텔 수정
	@Override
	public Integer update(HotelVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	// 객실 수정
	@Override
	public Long updateRoom(HotelRoomVO rvo) {
		log.info(rvo);
		return mapper.updateRoom(rvo);
	}
	
	// 편의시설 가져오기
	@Override
	public List<AmenitiesVO> getAmenities(Integer amenitiesNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<HotelAmenitiesVO> getHotelAmenitiesNo(Integer no) {
	    return mapper.getHotelAmenitiesNo(no); // 데이터베이스에서 가져오기
	}

	@Override
	public HotelRoomVO roomView(Long rno, Integer no) {
		// TODO Auto-generated method stub
		return mapper.roomView(rno, no);
	}

	@Override
	public Integer changeImage(HotelVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeImage(vo);
	}
	
	@Override
	public Integer changeDetailImage(HotelVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeDetailImage(vo);
	}

	@Override
	public Integer changeHotelImage(HotelImageVO hotelImageVO) {
		// TODO Auto-generated method stub
		return mapper.changeHotelImage(hotelImageVO);
	}

	@Override
	public Integer changeRoomImage(HotelRoomVO roomVO) {
		// TODO Auto-generated method stub
		log.info("ddddddddddddddddddddddddddddddddddddddddddddddddd"+roomVO.getRno());
		return mapper.changeRoomImage(roomVO);
	}


	@Override
	public Integer changeRoomImages(RoomImageVO roomImageVO) {
		// TODO Auto-generated method stub
		return mapper.changeRoomImages(roomImageVO);
	}
	
	@Override
	@Transactional
	public Integer updateAmenities(Integer no, List<HotelAmenitiesVO> list) {
		// TODO Auto-generated method stub
		mapper.deleteAmenities(no);
		return mapper.writeAmenities(list);
	}
	
	// 호텔 삭제
		@Override
		public Integer delete(HotelVO vo) {
			log.info(vo);
			return mapper.delete(vo);
		}
}