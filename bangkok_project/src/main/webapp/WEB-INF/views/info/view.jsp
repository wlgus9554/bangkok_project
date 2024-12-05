<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title></title>
   
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCHpAskOsD0WfaS0dnmp7ebS7uFoSExh90" async defer></script> <!-- Google Maps API 포함 -->
    <style>
    
        .map-container {
            height: 300px; /* 지도 높이 설정 */
            margin: 20px 0; /* 지도 여백 설정 */
        }
        .card {
            margin: 20px 0; /* 카드 간격 설정 */
        }
        .btn {
            margin-top: 10px; /* 버튼 간격 설정 */
        }
    </style>
</head>
<body>

<div class="container">
    <!-- 선택된 카테고리의 데이터 표시 -->
    <div class="tab-content">
  
    
        <div id="cate_name${param.cate_code1}" class="container tab-pane active">
            <div class="card">
                <div class="card-header">
                  <input id="no" type="hidden" value="${vo.no }">
                    <h4>${vo.title}</h4> <!-- 제목 표시 -->
                    <p><strong>${vo.writer}</strong></p> <!-- 작성자 표시 -->
                    <p><strong><fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/></strong></p> <!-- 작성 날짜 포맷 -->
                </div>

                <div id="demo" class="carousel slide" data-ride="carousel"> <!-- 이미지 슬라이더 -->
                    <ul class="carousel-indicators"> <!-- 슬라이더 인디케이터 -->
                    	 <li data-target="#demo" data-slide-to="0" class="active"></li>
                        <c:forEach var="image" items="${imageList}" varStatus="vs">
                            <li data-target="#demo" data-slide-to="${vs.index + 1}" ></li>
                        </c:forEach>
                    </ul>


                    <div class="carousel-inner"> <!-- 슬라이더 내부 -->
                        <div class="carousel-item active"> <!-- 첫 번째 이미지 활성화 -->
	                        <img src="${vo.imageFile}" alt="Image0" class="d-block w-100"> <!-- 이미지 표시 -->
	                    </div>
                      		<c:forEach var="imagevo" items="${imageList}" varStatus="vs">
                      			<div class="carousel-item">
                              	  <img src="${imagevo.filename}" alt="Image${vs.index + 1}" class="d-block w-100"> <!-- 이미지 표시 -->
                        		</div>
                        	</c:forEach>
                        </div>
                    </div>

                    <a class="carousel-control-prev" href="#demo" data-slide="prev"> <!-- 이전 버튼 -->
                        <span class="carousel-control-prev-icon"></span>
                    </a>
                    <a class="carousel-control-next" href="#demo" data-slide="next"> <!-- 다음 버튼 -->
                        <span class="carousel-control-next-icon"></span>
                    </a>
                </div>

                <!-- 지도 표시 -->
                <div id="map-div" class="map-container"></div> <!-- 지도 표시할 div -->

                <div class="card-body">
                    <p class="card-text">${vo.content}</p> <!-- 내용 표시 -->
                </div>
            </div>
        </div>
    </div>
    
    <div class="tripReply"></div>
    

    <!-- 리스트 페이지로 돌아가는 버튼 -->
    <a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-dark btn-sm">list</a>
    
    <!-- 로그인한 사용자가 관리자일 경우 수정 및 삭제 버튼 표시 -->
     <c:if test="${!empty login && login.gradeNo == 9}">
        <a href="updateForm.do?no=${param.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-dark btn-sm">update</a> <!-- 수정 버튼 -->
        <a href="delete.do?no=${vo.no}&deleteFileName=${imagevo.filename}&perPageNum=${param.perPageNum}" class="btn btn-dark btn-sm" id="deleteBtn">delete</a> <!-- 삭제 버튼 -->
     </c:if>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        // 장소의 좌표 설정
	    var placePoints = {
	        1: {lat: 34.665790, lng: 135.432312},  // 유니버셜 스튜디오 좌표
	        2: {lat: 34.65461349487305, lng: 135.42892456054688},  // 가이유칸 수족관 좌표
	        3: {lat: 34.0792, lng: -118.402},   // 베버리 힐즈 좌표
	        4: {lat: 22.197284698486328, lng: 113.5422134399414}, // 몬테 요새 좌표
	        5: {lat: 37.582880, lng: 126.975552} // 경복궁 좌표


	    };
	    var placeName = {
		    	1: "Universal Studios Japan", // 장소 이름
		    	2: "가이유칸 수족관",
		    	3: "베버리 힐즈",
		    	4: "Mount Fortress", 
		    	5: "경복궁"
		    };

	    // 지도 초기화 함수
	    function initMap(location, elementId, title) {
	        let map = new google.maps.Map(document.getElementById(elementId), {
	            zoom: 14, // 줌 레벨
	            center: location // 중심 좌표 설정
	        });
	
	        new google.maps.Marker({
	            position: location, // 마커 위치
	            map: map, // 마커가 표시될 지도
	            title: title // 마커 제목
	        });
	    }
	    
        let no = $("#no").val();
        
     // 댓글 데이터 가져오기
        $(".tripReply").load("/tripReplyAjax/list.do?no=" + no);
	    
	    $('[data-toggle="tooltip"]').tooltip(); // 툴팁 초기화

        // 삭제 버튼 클릭 시 확인 대화상자 표시
        $("#deleteBtn").click(function() {
            return confirm("정말 삭제하시겠습니까?");
        });

//         // 카테고리 클릭 시 해당 카테고리로 이동
//         $(".cate_names").click(function() {
//             let cate_code1 = $(this).data("cate_code1");
//             if (!$(this).hasClass("active")) {
//                 location = "list.do?cate_code1=" + cate_code1; // 카테고리 목록으로 이동
//             }
//         });

        // JSP에서 3개의 값을 처리
        var placeKey = ${param.no}; // 현재 장소의 키
        var coords = placePoints[placeKey]; // 해당 장소의 좌표를 가져옴
        
        // 좌표가 유효할 경우에만 지도 초기화
        if (coords) {
            initMap(coords, 'map-div', placeName[placeKey]);  // 해당 장소의 지도 생성
        } else {
            console.error("해당 장소에 대한 좌표가 없습니다: " + placeKey); // 좌표가 없을 경우 에러 로그
        }
        
    });
</script>


</body>
</html>