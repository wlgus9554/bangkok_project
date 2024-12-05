<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>

<script type="text/javascript">
	$(function(){
		// 제목 해당 태그 중 제일 높은 것을 이용하여 모두 맞추기
		// console.log($(".title"));
		let titleHeights = [];
		
		$(".title").each(function(idx, title){
			console.log($(title).height());
			titleHeights.push($(title).height());
		});
		console.log(titleHeights.join(", "));
		
		let maxTitleHeight = Math.max.apply(null, titleHeights);
		console.log(maxTitleHeight);
		
		$(".title").height(maxTitleHeight);
		
		// 이미지 사이즈 조정 5:4
		let imgWidth = $(".imageDiv:first").width();
		let imgHeight= $(".imageDiv:first").height();
		console.log("image width=" + imgWidth + ", height=" + imgHeight)
		// 높이 계산 - 너비는 동일하다. : 이미지와 이미지를 감싸고 있는 div의 높이로 사용
		let height = imgWidth / 5 * 4;
		// 전체 imageDiv의 높이를 조정한다.
		$(".imageDiv").height(height);
		// 이미지 배열로 처리하면 안된다. foreach 사용 - jquery each()
		$(".imageDiv > img").each(function(idx, image){
			//alert(image);
			//alert(height);
			//alert($(image).height());
			// 이미지가 계산된 높이 보다 크면 줄인다.
			if($(image).height() > height){
				let image_width = $(image).width();
				let image_height = $(image).height();
				let width = height  / image_height * image_width;
				
				console.log("chaged image width = " + width);
				
				// 이미지 높이 줄이기
				$(image).height(height);
				// 이미지 너비 줄이기
				$(image).width(width);
				
			}
		});		
	})
</script>

<form action="list.do" id="searchForm">
    <input name="page" value="1" type="hidden">
    <div class="row">
        <div class="col-md-12">
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
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>

<c:if test="${empty placeList}">
<div class="jumbotron">
    <h3>Data does not exist.</h3>
</div>
</c:if>

<div class="row">
	<c:forEach items="${placeList}" var="vo" varStatus="vs">
		<div class="col-md-4 dataRow" data-no="${vo.no }">
			<div class="card placeCard" style="width:100%">
				<div class="imageDiv text-center align-content-center">
				    <img class="card-img-top" src="${vo.imageFile}">
				</div>
				<div class="card-body">
				    <div class="card-title">
				       <span class="cityName">${vo.cityname}</span> <br>
				 		<span class="place">${vo.place}</span>
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
