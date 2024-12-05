package com.bangkok.info.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.bangkok.cityPlace.vo.CityVO;

import lombok.Data;

@Data
public class InfoVO {
	
		private Long no;
		private String title;
		private String content;
		private String writer;
		private Integer cityNum;
		private String cityname;
		private String countrycode;
		private String place;
		private Date writeDate;
		private String imageFile;
		private String filename;
		private Integer cate_code1;
		private String cate_name;
		private Integer lat; // 위도
		private Integer lng; // 경도
		
		public List<CityVO> getCityList() {
		    List<CityVO> cityList = new ArrayList<>();
		    // 데이터베이스에서 도시 리스트를 가져오는 로직
		    return cityList;
		}


}
