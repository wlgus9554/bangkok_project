package com.bangkok.category.service;

import java.util.List;
import com.bangkok.category.vo.CategoryVO;

public interface CategoryService {

	// category list
	public List<CategoryVO> list();
	
	
	public List<CategoryVO> getbigList();

}
