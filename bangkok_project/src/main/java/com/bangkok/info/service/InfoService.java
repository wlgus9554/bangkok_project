package com.bangkok.info.service;

import java.util.List;

import com.bangkok.category.vo.CategoryVO;
import com.bangkok.cityPlace.vo.CityVO;
import com.bangkok.info.vo.InfoImageVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;

public interface InfoService {


		public List<InfoVO> list(PageObject pageObject, String cityname, String countrycode
				, String imageFile);


		public InfoVO view(Long no);
		public List<InfoImageVO> imageList(Long no);
		

		public Integer write(InfoVO vo, List<InfoImageVO> imageList);


		public Integer update(InfoVO vo);
		
		public Integer delete(InfoVO vo);
		
		


}