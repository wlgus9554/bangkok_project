<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행정보 등록</title>
    <style>
        .container {
            margin: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .map-section {
            margin: 20px 0;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {
            let appendImageTag = `
                <div class="input-group mb-3 imageFilesDiv">
                    <input class="form-control imageFiles" type="file" name="sub_image" required>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-dark btn-sm removeImageBtn">
                            <i class="fa fa-close"></i> 제거
                        </button>
                    </div>
                </div>
            `;

            let imageCnt = 1;

            // 첨부 이미지 추가
            $("#addImageBtn").click(function() {
                if (imageCnt >= 3) {
                    alert("최대 3개의 이미지만 추가할 수 있습니다.");
                    return false;
                }
                $("#imageFieldSet").append(appendImageTag);
                imageCnt++;
            });

            // 첨부 이미지 제거 처리
            $("#imageFieldSet").on("click", ".removeImageBtn", function() {
                $(this).closest(".input-group").remove(); // 해당 이미지 파일 입력 그룹 삭제
                imageCnt--; // 이미지 개수 감소
            });

            // 카테고리 선택 시 처리
            $(".form-check-input[name='cate_code1']").on("click", function() {
                var cateCode = $(this).data("cate_code1"); // data-cate_code1 속성에서 카테고리 코드 가져오기
                console.log("선택된 카테고리 코드: " + cateCode);
            });
            
     // 도시 정보 선택 시 처리
        $(".form-check-input[name='cityNum']").on("click", function() {
            var cityNum = $(this).val(); // value 속성에서 cityNum 가져오기
            console.log("선택된 도시정보: " + cityNum);
        });
     
  // 카테고리 가져오기 AJAX 요청
     $("#cate_code1").load("ajax/getcateList.do?cate_code1=" + $("#cate_code1").val());

     // 도시 가져오기 AJAX 요청
     $("#cityNum").load("ajax/cityList.do?cityNum=" + $("#cityNum").val());


    </script>
</head>
<body>
    <div class="container">
        <h3>여행정보 등록</h3>
        <form action="write.do" method="post" enctype="multipart/form-data">
            <input name="perPageNum" value="${param.perPageNum}" type="hidden">

<!--             선택된 도시 번호를 저장하는 숨겨진 input -->
<!--             <input type="hidden" id="selectedCityNum" name="selectedCityNum"> -->

            <div class="form-group">
                <label for="category">카테고리 선택</label>
                <c:forEach items="${cateList}" var="vo">
                    <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="cate_code1"
                            value="${vo.cate_code1}" data-cate_code1="${vo.cate_code1}" required> ${vo.cate_name}
                        </label>
                    </div>
                </c:forEach>
            </div>


	<div class="form-group">
	<label for="cityNum">도시 선택</label>
		<c:forEach items="${cityList }" var="vo">
		<div class="form-check-inline">
		<label class="form-check-label">
		<input type="radio" class="form-check-input" name="cityNum"
		value="${vo.cityNum }" data-cityNum="${vo.cityNum }" required> ${vo.cityName } 
		</label>
		</div>
		</c:forEach>
	</div>
            

            <div class="form-group">
                <label for="title">제목</label>
<!--                 <input id="title" name="title" required class="form-control" maxlength="100" -->
<!--                        pattern="^[^ .].{2,99}$" -->
<!--                        title="맨 앞에 공백문자는 불가하며, 3~100자 내로 입력해주세요." -->
<!--                        placeholder="제목은 3자 이상 100자 이내로 입력해주세요."> -->
      <input id="title" name="title" required class="form-control" maxlength="100"
       pattern="^(?! )[^\n]{3,100}$"
       title="제목은 공백으로 시작할 수 없으며, 3~100자 이내로 입력해야 합니다."
       placeholder="제목은 3자 이상 100자 이내로 입력해주세요.">
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" required
                          rows="7" placeholder="첫 글자는 공백문자나 줄바꿈을 입력할 수 없습니다."></textarea>
            </div>
            
            <div class="form-group">
                <label for="writer">작성자</label>
                <input class="form-control" id="writer" name="writer" value="admin" required readonly>
            </div>
            
            <div class="form-group">
                <label for="place">장소명</label>
                <input class="form-control" id="place" name="place" required
                          placeholder="장소명은 공백문자나 줄바꿈을 입력할 수 없습니다.">
            </div>
            
            <div class="form-group">
                <label for="mainFile">대표 사진</label>
                <input class="form-control" name="mainFile" id="mainFile" required type="file">
            </div>

            <div class="form-group" id="imageFieldSet">
                <label for="sub_image">추가 사진</label>
                <input class="form-control" name="sub_image" type="file" required>
            </div>


            <button class="btn btn-dark btn-sm" type="submit">write</button>
            <button type="reset" class="btn btn-dark btn-sm">reset</button>
            <button type="button" onclick="history.back();" class="btn btn-dark btn-sm">prev</button>
        </form>
    </div>
</body>
</html>
