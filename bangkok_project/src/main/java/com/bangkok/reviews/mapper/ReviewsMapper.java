package com.bangkok.reviews.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.reviews.vo.ReviewsVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface ReviewsMapper {

	// 이벤트 리스트
	public List<ReviewsVO > list(Integer no);
	
	// 이벤트 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(PageObject pageObject);
	
	
	// 보기
	public ReviewsVO  view(Long reservation_no);

	// 등록
	public Integer write(ReviewsVO vo);
	// 글등록 트랜젝션 처리 테스트
	// public Integer writeTx(ReviewsVO  vo);
	
	// 수정
	public Integer update(ReviewsVO vo);
	
	// 삭제
	public Integer delete(ReviewsVO vo);
	//리뷰 등록 여부 확인
	public Integer hasReview(ReviewsVO vo);

	public String getHasReview(Long reservation_no);

	public Integer hasReviewMinus(ReviewsVO vo);

	public Integer likeCount(ReviewsVO vo);

    public String isLiked(ReviewsVO vo);

    public Integer plus(ReviewsVO vo);

    public Integer minus(ReviewsVO vo);

	public Integer deleteLike(ReviewsVO vo);

	public List<ReviewsVO> menuList(Integer no);

	
}
