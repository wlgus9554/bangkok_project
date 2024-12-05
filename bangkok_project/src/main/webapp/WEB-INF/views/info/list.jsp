<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style type="text/css">

.dataRow:hover{
	opacity: 70%; /* 데이터 행에 마우스를 올렸을 때 투명도 조정 */
	cursor: pointer; /* 커서를 포인터로 변경 */
}

.imageDiv{
	background: none; /* 이미지 감싸는 div의 배경 없음 */
}

.title{
  text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 표시 */
  overflow: hidden; /* 넘치는 부분 숨김 */
  display: -webkit-box; /* Flexbox 모델 사용 */
  -webkit-box-orient: vertical; /* 수직 정렬 */
  -webkit-line-clamp: 2; /* 최대 두 줄 표시 */
 }
 
 .pagination {
        display: flex; /* Flexbox를 사용한 페이지네이션 */
        justify-content: center; /* 중앙 정렬 */
        margin: 20px 0; /* 위아래 여백 */
    }
 
</style>

<script type="text/javascript">
$(function(){
	
	// 제목의 높이를 맞추기 위해 각 제목의 높이를 배열에 저장
	let titleHeights = [];
	
	$(".title").each(function(idx, title){
		console.log($(title).height()); // 각 제목의 높이 로그
		titleHeights.push($(title).height()); // 높이 배열에 추가
	});
	console.log(titleHeights.join(", "));
	
	let maxTitleHeight = Math.max.apply(null, titleHeights); // 최대 높이 계산
	console.log(maxTitleHeight);
	
	$(".title").height(maxTitleHeight); // 모든 제목의 높이를 최대 높이로 설정
	
	// 이미지 사이즈 조정 (5:4 비율)
	let imgWidth = $(".imageDiv:first").width(); // 첫 번째 이미지의 너비
	let imgHeight= $(".imageDiv:first").height(); // 첫 번째 이미지의 높이
	console.log("image width=" + imgWidth + ", height=" + imgHeight);
	
	// 비율에 맞춰 높이 계산
	let height = imgWidth / 5 * 4; 
	$(".imageDiv").height(height); // 모든 이미지 div의 높이 조정
	
	// 각 이미지에 대해 높이를 기준으로 너비 조정
	$(".imageDiv > img").each(function(idx, image){
		if($(image).height() > height){ // 이미지가 계산된 높이보다 크면
			let image_width = $(image).width();
			let image_height = $(image).height();
			let width = height / image_height * image_width; // 비율에 따라 너비 계산
			
			console.log("changed image width = " + width);
			
			$(image).height(height); // 이미지 높이 줄이기
			$(image).width(width); // 이미지 너비 조정
		}
	});

	// 데이터 행 클릭 시 상세 페이지로 이동
	 $(".dataRow").click(function(){
		 	let no = $(this).data("no"); // 클릭한 행의 데이터 번호 가져오기
	        location = "view.do?no=" + no + "&${pageObject.pageQuery}"; // 상세 페이지로 이동
	    });

    // 페이지당 항목 수 변경 시 폼 제출
    $("#perPageNum").change(function(){
        $("#searchForm").submit();
    });

    // 검색 키와 페이지당 항목 수 초기화
    $("#key").val("${(empty pageObject.key) ? 't' : pageObject.key}");
    $("#perPageNum").val("${(empty pageObject.perPageNum) ? '10' : pageObject.perPageNum}");
    
	// 카테고리 클릭 시 해당 카테고리의 데이터만 표시
	$("#categories a.nav-link").on("click", function () {
		var currentTag = $(this); // 현재 클릭한 태그
		var cateCode = currentTag.attr("data-cate-code1"); // 카테고리 코드 가져오기
		$("#categories a.nav-link").removeClass("active"); // 활성화된 클래스 제거
		currentTag.addClass("active"); // 현재 태그에 활성화 클래스 추가
		$(".row .dataRow").each(function () {
			var currentRow = $(this); // 현재 행
			var currentRowCateCode = currentRow.attr("data-cate-code1"); // 현재 행의 카테고리 코드
			
			if (cateCode === currentRowCateCode) {
				currentRow.show(); // 카테고리 코드가 일치하면 행 표시
			} else {
				currentRow.hide(); // 일치하지 않으면 행 숨김
			}
			
			if (cateCode === "all") {
				currentRow.show(); // "전체" 선택 시 모든 행 표시
			}
		});
	});
});
</script>

</head>
<body>

<div class="container">
    <img src="/upload/info/tripinfo-title.png" class="mx-auto d-block" style="max-width: 100%; height: auto;">
<br>
    <form action="list.do" id="searchForm">
        <input name="page" value="1" type="hidden"> <!-- 페이지 번호 숨김 필드 -->
        <div class="row">
            <div class="col-md-8">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <select name="key" id="key" class="form-control">
                            <option value="t">title</option>
                            <option value="c">content</option>
                            <option value="tc">title/content</option>
                        </select>
                    </div>
                    <input type="text" class="form-control" placeholder="검색" id="word" name="word" value="${pageObject.word}">
                    <div class="input-group-append">
                        <button class="btn btn-outline-primary">
                            <i class="fa fa-search"></i> <!-- 검색 아이콘 -->
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="float-right">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Rows/Page</span>
                        </div>
                        <select id="perPageNum" name="perPageNum" class="form-control">
                            <option>6</option>
                            <option>9</option>
                            <option>12</option>
                            <option>15</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>
    
        <!-- 카테고리 탭 -->
    <ul id="categories" class="nav nav-tabs" style="margin-bottom: 20px;">
    	<li class="nav-item">
            <a href="javascript:void(0)" class="nav-link active cate_names" data-cate-code1="all">전체</a> <!-- 전체 보기 -->
        </li>
        <li class="nav-item">
        <!-- <a href=javascript:void(0) : 함수 호출 -->
            <a href="javascript:void(0)" class="nav-link cate_names" data-cate-code1="1">오락</a> <!-- 오락 카테고리 -->
        </li>
        <li class="nav-item">
            <a href="javascript:void(0)" class="nav-link cate_names" data-cate-code1="2">명소</a> <!-- 명소 카테고리 -->
        </li>
    </ul>

    <c:if test="${empty list}">
        <div class="jumbotron">
            <h3>Data does not exist.</h3> <!-- 데이터가 없을 경우 메시지 -->
        </div>
    </c:if>

    <div class="row">
    <c:forEach items="${list}" var="vo" varStatus="vs">
        <div class="col-md-4 dataRow" data-no="${vo.no }" data-cate-code1="${vo.cate_code1}">
            <div class="card" style="width:100%">
                <div class="imageDiv text-center align-content-center">
                    <img class="card-img-top" src="${vo.imageFile}"> <!-- 이미지 표시 -->
                </div>
                <div class="card-body">
                    <div class="card-title">
                        <span>${vo.title} </span> <!-- 제목 표시 -->
                        <br>
                       <span>${vo.countrycode}</span> <!-- 국가 코드 표시 -->
                       <br>
                        <span>${vo.cityname}</span> <!-- 도시 이름 표시 -->
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
        <!-- 페이지네이션 처리 -->
        <div>
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>

    <!-- 로그인 상태에 따른 작성 버튼 -->
      <c:if test="${!empty login}">
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-dark btn-sm">write</a>
      </c:if>
</div>
</body>
</html>