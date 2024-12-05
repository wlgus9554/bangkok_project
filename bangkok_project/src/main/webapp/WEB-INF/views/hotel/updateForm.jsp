<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Update</title>
<script defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAcseD0Ef2zBeEW5pzXqHnB7ql8s9om-6Q&callback=initMap"></script>

<style type="text/css">
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 500px;
}

/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.file-input {
	display: none; /* 파일 입력 필드는 숨김 */
}

.upload-btn {
	display: inline-block;
	padding: 8px 16px; /* Bootstrap btn-sm 보다 큰 패딩 값 */
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

.preview-img {
	margin-top: 20px;
	max-width: 300px; /* 이미지 미리보기 최대 너비 */
	height: 300px;
	width: 300px;
	display: none; /* 처음에는 미리보기 이미지 숨김 */
	object-fit: cover;
}
</style>
<script type="text/javascript">
$(function() {
	
    let roomIndex = 1; // 첫 번째 객실은 이미 있으므로 1부터 시작      
    
    $("#addRoomBtn").click(function() {
        let appendRoomTag = `
            <div class="room-entry">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6><b>객실 입력 ${roomIndex}</b></h6>
                <div class="input-group-append">
                    <button type="button" class="btn btn-danger removRoomBtn">
                        <i class="fa fa-close"></i>
                    </button>
                </div>
            </div>

            <div class="rounded-lg shadow-sm p3 row bg-light">      
                <div class="col-md-4 ImgInputDiv">               
                    <button type="button" class="upload-btn uploadBtn mt-2">Image</button>
                    <!-- 숨겨진 파일 입력 -->
                    <input type="file" name="roomImageFile" class="file-input fileInput" accept="image/*">
                    <!-- 미리보기 이미지 -->
                    <img class="preview-img imagePreview rounded" src="#" alt="이미지 미리보기">               
                </div>      
                <div class="col-md-8" id="roomInputDiv">
                    <div class="form-row p-3">
                        <div class="form-group col">
                            <label for="room_title">Room Name</label> 
                            <input class="form-control" name="list[\${roomIndex}].room_title" id="room_title" required>
                        </div>
                        <div id="roomDiv col">
                            <label>객실 타입</label>
                            <select name="list[\${roomIndex}].room_type" class="custom-select" style="width: 100%">
                                <option selected>Standard</option>
                                <option>Deluxe</option>
                                <option>suite</option>
                                <option>Premiere</option>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label for="price">정가</label> 
                            <input class="form-control" name="list[\${roomIndex}].price" id="price" required value="0">
                        </div>
                    </div>
                    <div class="rounded-lg p-3 form-row" style="background-color: white">
                        <div class="form-group col-12">
                            <label for="room_content">객실 소개</label>
                            <textarea class="form-control" name="list[\${roomIndex}].room_content" id="room_content" rows="4"></textarea>
                        </div>
                    </div>
                    <div class="rounded-lg p-3 my-2 form-row" style="background-color: white">
                        <div class="form-group col">
                            <label>인원수</label> 
                            <input type="number" name="list[\${roomIndex}].people" class="form-control" value="1" min="1">
                        </div>
                        <div class="form-group col">
                            <label>객실 수</label> 
                            <input type="number" name="list[\${roomIndex}].room_number" class="form-control" value="1" min="1">
                        </div>
                    </div>
                </div>
                <fieldset class="border col-xl" id="roomImageFieldSet_\${roomIndex}">
                    <legend class="w-auto px-2">
                        <b style="font-size: 14pt;">[객실 이미지 추가]</b>
                        <button type="button" class="btn btn-primary btn-sm addRoomImageBtn" data-room-index="\${roomIndex}">add RoomImage</button>
                    </legend>
                    <div class="input-group mb-3">
                        <input class="form-control roomImageFiles" type="file" name="list[\${roomIndex}].roomImage[0]" required>
                    </div>
                </fieldset>
            </div>
        `;

        $("#roomFieldSet").append(appendRoomTag);

        // 인덱스 증가
        roomIndex++;
    });

    // 객실 입력 블록 제거 처리
    $("#roomFieldSet").on("click", ".removRoomBtn", function() {
        $(this).closest(".room-entry").remove();
    });
    
    
    //이미지 선택 이벤트
    $("#roomFieldSet").on("click",".uploadBtn",function() {
        $(this).next().click();
    });
    
    // 파일 선택 시 미리보기
    $("#roomFieldSet").on('change','.fileInput', function(event) {
       const file = event.target.files[0];
       const $this = $(this); // 현재 이벤트가 발생한 요소를 변수로 저장         
       
       if (file) {            
          
          const reader = new FileReader();
        
          reader.onload = function(e) {
             $this.closest(".ImgInputDiv").find("img").prop('src', e.target.result).show(); // 이미지 미리보기 src 설정 및 보여주기
          }
           reader.readAsDataURL(file); // 파일 읽기
         }
    });
    
  //첨부 이미지 추가 처리
    $("#addHotelImageBtn").click(function() {
       console.log("addHotelImageBtn");
      let appendImageTag = `
          <div class="input-group mb-3">
              <input class="form-control imageFiles" type="file" name="imageFiles">
              <div class="input-group-append">
                  <button type="button" class="btn btn-danger removeImageBtn">
                      <i class="fa fa-close"></i>
                  </button>
              </div>
          </div>
      `;
      $("#imageFieldSet").append(appendImageTag);
      imageCnt++;
    });

    //첨부 이미지 제거 처리
    $("#imageFieldSet").on("click", ".removeImageBtn", function() {
      $(this).closest(".input-group").remove();
      imageCnt--;
       });
    
 // 객실 첨부 이미지 추가 처리
    $("#roomFieldSet").on("click", ".addRoomImageBtn", function() {
        let roomIndex = $(this).data("room-index");
       let roomImageCnt = $(this).closest("#roomImageFieldSet_" + roomIndex).find(".roomImageFiles").length;
        let appendRoomImageTag = `
            <div class="input-group mb-3">
                <input class="form-control roomImageFiles" type="file" name="list[\${roomIndex}].roomImage[\${roomImageCnt}]">
                <div class="input-group-append">
                    <button type="button" class="btn btn-danger removeImageBtn">
                        <i class="fa fa-close"></i>
                    </button>
                </div>
            </div>
        `;
        $("#roomImageFieldSet_" + roomIndex).append(appendRoomImageTag);
        
    });

    // 객실 첨부 이미지 제거 처리
    $("#roomFieldSet").on("click", ".removeImageBtn", function() {
        $(this).closest(".input-group").remove();
        
    });
    
    // JSP에서 전달된 List<VO>를 자바스크립트로 받기
    let amenitiesPick = [
        <c:forEach var="pick" items="${amenitiesPick}">
            {
                "amenitiesNo": "${pick.amenitiesNo}",
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

   
    
 });
</script>

</head>
<body>
	<div class="container">
		<h2>Hotel Update</h2>
		<form action="update.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">
			<div class="form-group">
				<input class="no" type="hidden" name="no" value="${vo.no }">
			</div>
			<div class="form-group">
				<label for="title">Hotel Name</label> <input class="form-control"
					name="title" id="title" required value="${vo.title }">
			</div>
			<div class="form-group">
				<label>등급 : &nbsp;</label>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="rating" value="5"
						${vo.rating == 5 ? 'checked' : ''}>5
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="rating" value="4"
						${vo.rating == 4 ? 'checked' : ''}>4
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="rating" value="3"
						${vo.rating == 3 ? 'checked' : ''}>3
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="rating" value="2"
						${vo.rating == 2 ? 'checked' : ''}>2
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="rating" value="1"
						${vo.rating == 1 ? 'checked' : ''}>1
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="content">호텔 소개</label>
				<textarea class="form-control" name="content" id="content" rows="7">${vo.content }</textarea>
			</div>
			<div class="form-group">
				<label for="tel" class="label"> 연락처: </label> <input type="text"
					class="form-control" placeholder="'-'포함 입력" id="tel" name="tel"
					value="${vo.tel }">
			</div>
			<div class="form-group">
				<label for="notice">공지사항</label>
				<textarea class="form-control" name="notice" id="notice" rows="7">${vo.notice }</textarea>
			</div>
			<div class="form-group">
				<label for="address">주소 입력</label> <input type="text" id="address"
					name="address" class="form-control" placeholder="상세주소를 입력하세요"
					required value="${vo.address }">
			</div>
			<div class="form-group">
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="accommodations" value="국내 숙소"
						${vo.accommodations == '국내 숙소' ? 'checked' : ''}>국내 숙소
					</label>
				</div>
				<div class="form-check-inline">
					<label class="form-check-label"> <input type="radio"
						class="form-check-input" name="accommodations" value="해외 숙소"
						${vo.accommodations == '해외 숙소' ? 'checked' : ''}>해외 숙소
					</label>
				</div>
			</div>

			<div class="mt-3">
				<button type="submit" class="btn btn-primary">수정</button>
				<button type="reset" class="btn btn-warning">새로입력</button>
				<button type="button" class="cancelBtn btn btn-success" onclick="history.back()">취소</button>
			</div>
		</form>
	</div>
</body>
</html>