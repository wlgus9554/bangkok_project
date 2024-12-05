package com.bangkok.cityPlace.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bangkok.cityPlace.vo.CityVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;

@Service
public interface CityPlaceService {

	public List<CityVO> cityList();
	public List<InfoVO> placeList(PageObject pageObject, Long cityNum);
	
}
