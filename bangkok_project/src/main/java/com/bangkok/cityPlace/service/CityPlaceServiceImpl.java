package com.bangkok.cityPlace.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.cityPlace.mapper.CityPlaceMapper;
import com.bangkok.cityPlace.vo.CityVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;

@Service
@Qualifier("cityServiceImpl")
public class CityPlaceServiceImpl implements CityPlaceService{

	@Inject
	CityPlaceMapper mapper;

	@Override
	public List<CityVO> cityList() {
		// TODO Auto-generated method stub
		return mapper.cityList();
	}

	@Override
	public List<InfoVO> placeList(PageObject pageObject, Long cityNum) {
		// TODO Auto-generated method stub
		return mapper.placeList(pageObject, cityNum);
	};
	
}
