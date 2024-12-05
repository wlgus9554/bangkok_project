package com.bangkok.cityPlace.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.cityPlace.vo.CityVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface CityPlaceMapper {

	public List<CityVO> cityList();
	public List<InfoVO> placeList(@Param(value = "pageObject") PageObject pageObject, 
			@Param(value = "cityNum") Long cityNum);
	
}
