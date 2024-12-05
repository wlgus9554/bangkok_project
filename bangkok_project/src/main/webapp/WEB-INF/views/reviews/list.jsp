<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제목</title>
<style type="text/css">
.back{
	font-size:30px;
	color:#000;
}
.back:hover{
	cursor: pointer;
}
.title{
	margin-bottom:30px;
	margin-top: 30px;
	font-weight:600;
	font-size:1.3rem;
}
.ratings-container {
    display: grid;
    grid-template-columns: 1fr 1fr; /* 두 개의 열로 설정 */
    gap: 10px; /* 각 항목 간의 간격 */
    background-color: white; /* 배경색 */
    padding: 10px; /* 안쪽 여백 */
    border-radius: 10px; /* 둥근 모서리 */
    font-family: Arial, sans-serif;
    text-align: center;
}

.rating-item {
    display: flex;
    justify-content: space-between;
}

.rating {
    font-weight: bold;
}
.horizontal-line {
    width: 99%; /* 선의 길이 조절 */
    margin: 0 auto; /* 중앙 정렬 */
    border-top: 1px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 선 */
    margin: 20px 0 20px 0;
}
.last-review {
    background-color: #f4f4f4;  /* 배경색 */
    border-radius: 50px;        /* 둥근 모서리 */
    padding: 10px;              /* 내부 여백 */
    width: 100%;                /* 너비 설정 */
    text-align: center;         /* 텍스트 가운데 정렬 */
    color: #777;                /* 텍스트 색상 */
    font-size: 14px;            /* 폰트 크기 */
    font-family: Arial, sans-serif; /* 폰트 스타일 */
    box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
    margin: 20px 0;             /* 위아래 여백 */
}
.star-rating i {
    font-size: 15px;  /* 아이콘 크기 설정 */
    margin-right: 0.5px;  /* 별 사이의 간격 설정 */
}
.vertical-line {
	height: 99%; /* 선의 높이 조절 */
	border-left: 3px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 세로 선 */
	margin: 10px 0 10px 10px;
}
.likeButton:hover{
	cursor: pointer;
}
.wrap-text {
    white-space: pre-wrap; /* 공백을 유지하되 줄바꿈 허용 */
    word-wrap: break-word; /* 단어가 길면 줄바꿈 */
    width: 145ch; /* 30 글자 기준으로 줄바꿈 */
}
</style>
<script type="text/javascript">
$(function(){
	$(".back").click(function(){
	    window.history.back();  // 뒤로 가기 동작
	});
	
	$(document).on('click', '.likeButton', function() {
	    let reviewNo = $(this).data('reviews-no'); // 리뷰 번호
	//    alert(reviewNo);

	    $.ajax({
	        url: 'count.do', // 좋아요 증가를 위한 URL
	        type: 'POST',
	        data: { reviewNo: reviewNo},
	        success: function(response) {
	            //console.log('Success:', response);
	            let currentCount = parseInt($('#likeCount').text()) || 0; // 현재 좋아요 수
	            $('#likeCount').text(currentCount + response); // 응답에 따라 증가 또는 감소
	            if(response === 0){
					alert("좋아요를 하셨습니다.");	            	
	            }else{
	            	alert("좋아료를 취소하셨습니다.");
	            }
	            location.reload();
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	            alert('좋아요 처리하는데 실패했습니다.');
	        }
	    });
	});
	function setStarRating(container, avgRating) {
	    let starFull = '<i class="fas fa-star" style="color:rgb(253, 189, 0);"></i>';
	    let starHalf = '<i class="fas fa-star-half-alt" style="color:rgb(253, 189, 0);"></i>';
	    let starEmpty = '<i class="far fa-star" style="color:rgb(253, 189, 0);"></i>';
	    
	    // 별점 총 5개 중 몇 개를 채울지 계산
	    let stars = "";
	    for (let i = 1; i <= 5; i++) {
	        if (avgRating >= i) {
	            stars += starFull;
	        } else if (avgRating >= i - 0.5) {
	            stars += starHalf;
	        } else {
	            stars += starEmpty;
	        }
	    }

	    $(container).html(stars); // 별점을 해당 container에 넣기
	}

	// 문서 로드 후 실행
	$(function(){
	    // 전체 평균 별점 설정 (예: 4.5는 동적으로 변경 가능)
	    setStarRating('.star-rating-total', 4.5);  // '.star-rating-total'로 전체 별점 평균 표시

	    // 각 리뷰의 별점 넣기
	    $('.star-rating').each(function(){
	        let serviceRating = parseFloat($(this).data('service'));
	        let cleanRating = parseFloat($(this).data('clean'));
	        let convenienceRating = parseFloat($(this).data('convenience'));
	        let amenitiesRating = parseFloat($(this).data('amenities'));

	        // 네 가지 항목의 평균 별점 계산
	        let avgRating = (serviceRating + cleanRating + convenienceRating + amenitiesRating) / 4;

	        // 해당 리뷰에 맞는 별점 설정
	        setStarRating(this, avgRating);
	    });
	});
	$(function() {
	    let totalService = 0, totalClean = 0, totalConvenience = 0, totalAmenities = 0;
	    let reviewCount = $('.star-rating').length; // 리뷰 개수

	    $('.star-rating').each(function() {
	        totalService += parseFloat($(this).data('service')) || 0;  // NaN 방지
	        totalClean += parseFloat($(this).data('clean')) || 0;      // NaN 방지
	        totalConvenience += parseFloat($(this).data('convenience')) || 0;  // NaN 방지
	        totalAmenities += parseFloat($(this).data('amenities')) || 0;  // NaN 방지
	    });

	    // 각 카테고리별 평균 계산
	    let avgService = totalService / reviewCount;
	    let avgClean = totalClean / reviewCount;
	    let avgConvenience = totalConvenience / reviewCount;
	    let avgAmenities = totalAmenities / reviewCount;

	    // 별점 표시 (amenities 평균 표시)
	    $('.ratings-container .rating-item').eq(0).find('.rating').text(avgService.toFixed(1));
	    $('.ratings-container .rating-item').eq(1).find('.rating').text(avgClean.toFixed(1));
	    $('.ratings-container .rating-item').eq(2).find('.rating').text(avgConvenience.toFixed(1));
	    $('.ratings-container .rating-item').eq(3).find('.rating').text(avgAmenities.toFixed(1));  // amenities 반영
	});
	$(function() {
	    let totalAvgRating = 0; // 전체 평균을 저장할 변수
	    let count = 0; // 총 별점 그룹의 개수를 세기 위한 변수

	    // 각 star-rating 요소에서 데이터 속성값을 가져와 평균을 계산
	    $('.star-rating').each(function() {
	        let serviceRating = parseFloat($(this).data('service')) || 0;
	        let cleanRating = parseFloat($(this).data('clean')) || 0;
	        let convenienceRating = parseFloat($(this).data('convenience')) || 0;
	        let amenitiesRating = parseFloat($(this).data('amenities')) || 0;

	        // 개별 항목 평균 계산
	        let avgRating = (serviceRating + cleanRating + convenienceRating + amenitiesRating) / 4;

	        // 총 평균에 더하고 카운트 증가
	        totalAvgRating += avgRating;
	        count++;
	    });

	    // 총 평균 계산 (모든 항목 평균의 평균)
	    let finalAvgRating = totalAvgRating / count;

	    // 평균값을 h1.average-rating에 넣기 (소수점 첫째자리까지)
	    $('.average-rating').text(finalAvgRating.toFixed(1));
	});
	//닉네임 마스크킹 처리하는 함수 
	$(document).ready(function() {
	    // 닉네임 마스킹 처리하는 함수
	    function maskNickName(nickName) {
	        const length = nickName.length;
	        
	        if (length > 2) {
	            // 닉네임 절반을 표시하고 나머지 절반을 *
	            const visiblePart = nickName.slice(0, Math.ceil(length / 2));
	            const maskedPart = '*'.repeat(Math.floor(length / 2));
	            return visiblePart + maskedPart;
	        } else if (length === 2) {
	            return nickName[0] + '*'; // 두 글자 닉네임은 첫 글자만 표시
	        } else {
	            return nickName; // 한 글자는 마스킹하지 않음
	        }
	    }

	    // nickname 클래스를 가진 요소에 마스킹된 닉네임 설정
	    $('.nickname').each(function() {
	        let originalNickName = $(this).data('nickname'); // data 속성에서 닉네임을 가져옴
	        let maskedNickName = maskNickName(originalNickName); // 마스킹 처리
	        $(this).find('.nicknameSpan').text(maskedNickName); // nicknameSpan에 마스킹된 닉네임 넣기
	    });
	});
});
</script>

</head>
<body>
<div class="container">
	<!-- 제목 부분 -->
	<div class="row">
		<div class="col-md-5">
			<i class="fa fa-angle-left back"></i>
		</div>
		<div class="col-md">
			<h4 style="font-weight: 700; color:#000">후기(<c:out value="${fn:length(list)}"/>)</h4>
		</div>
  	</div>
  	<!-- 내용 부분 -->
  	<div class="title">숙소 평가</div>
	<div class="row">
	   <div class="col-md-9">
        <i class="fas fa-star" style="color:rgb(253, 189, 0);font-size:60px;"></i>
        <h1 class="average-rating bigStar" style="font-size:4rem;display: inline-block;">0.0</h1>
    	</div>
		<div class="col-md">
		<div class="ratings-container">
		    <div class="rating-item">
		        <span>친절도</span> <span class="rating"></span>
		    </div>
		    <div class="rating-item">
		        <span>청결도</span> <span class="rating"></span>
		    </div>
		    <div class="rating-item">
		        <span>편의성</span> <span class="rating"></span>
		    </div>
		    <div class="rating-item">
		        <span>위치</span> <span class="rating"></span>
		    </div>
		</div>
		</div>
  	</div>
  	<!-- 반복되는 리스트 부분 -->
  	<div class="row">
  	<div class="col-md-11"></div>
  	<div class="col-float-right" style="margin:30px 0 0 0;">좋아요순<i class="fa fa-angle-down"></i></div>
  	</div>
  	<c:forEach items="${list }" var="vo">
  	<div class="horizontal-line"></div> <!-- 얇은 선  -->
  	<div class="float-right">${vo.reviewDate }</div>
  	<div class="star-rating" data-service=${vo.service_Rating } data-clean=${vo.cleanliness_Rating } 
  	data-convenience=${vo.convenience_Rating } data-amenities=${vo.amenities_Rating }>
	</div>
<div class="row">
    <span class="vertical-line col-md-0" style="height: 50px;"></span>
    <span class="col-md-3 nickname" style="margin: 10px 0;" data-nickname="${vo.nickName}">
        <span class="nicknameSpan"></span>
        <br>${vo.room_type}
</span>
</div>
	<c:if test="${!empty login }">
	 <i class="fa fa-thumbs-o-up float-right likeButton" style="font-size:24px"data-reviews-no="${vo.reviewNo}">  <span id="likeCount">${vo.count }</span></i>
	</c:if>
	<b>${vo.reviewTitle }</b>
	<br>
	<pre class="wrap-text">${vo.reviewContent }</pre>
  	</c:forEach>
  	
  	<div class="last-review">
    마지막 후기입니다
	</div>
</div>
</body>
</html>