package com.bangkok.category.mapper;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.bangkok.category.vo.CategoryVO;

@Repository
public interface CategoryMapper {

	// list
	public List<CategoryVO> list();
	
	public static List<CategoryVO> getbigList() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
