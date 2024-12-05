<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>호텔 상세보기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
/* 전체 컨테이너 스타일 */
.container {
	margin-top: 20px; /* 컨테이너 상단 여백 */
}

/* 호텔 헤더 스타일 */
.hotel-header {
	font-size: 2.5rem; /* 헤더 폰트 크기 */
	font-weight: bold; /* 헤더 폰트 두께 */
	margin: 0; /* 기본 여백 제거 */
}

/* 호텔 헤더 컨테이너 스타일 */
.hotel-header-container {
	/* 	display: flex; /* Flexbox 사용 */ */
	justify-content: space-between; /* 헤더 내 아이템 간 공간 배분 */
	align-items: center; /* 아이템 중앙 정렬 */
}

/* 버튼 컨테이너 스타일 */
.button-container {
	display: flex; /* Flexbox 사용 */
	gap: 10px; /* 버튼 간 간격 */
}

/* 호텔 서브헤더 스타일 */
.hotel-subheader {
	font-size: 1rem; /* 서브헤더 폰트 크기 */
	font-weight: lighter; /* 서브헤더 폰트 두께 */
	color: #6c757d; /* 서브헤더 색상 */
	margin-top: 5px; /* 서브헤더 상단 여백 */
}

/* 카드 스타일 */
.card {
	margin-top: 20px; /* 카드 상단 여백 */
}

/* 카드 헤더 스타일 */
.card-header, .horizontal-card .card-header, .horizontal-card .card-footer
	{
	background-color: #f8f9fa; /* 배경 색상 */
	font-size: 1.5rem; /* 헤더 폰트 크기 */
	font-weight: bold; /* 헤더 폰트 두께 */
	padding: 15px; /* 헤더 패딩 */
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 아이템 중앙 정렬 */
	justify-content: center; /* 아이템 중앙 정렬 */
}

/* 카드 본문 스타일 */
.card-body p {
	font-size: 1rem; /* 본문 폰트 크기 */
	line-height: 1.5; /* 본문 줄 높이 */
}

/* 캐러셀 내부 스타일 */
.carousel-inner {
	pointer-events: none; /* 내부 클릭 비활성화 */
}

/* 캐러셀 아이템 스타일 */
.carousel-inner .carousel-item {
	pointer-events: auto; /* 아이템 클릭 활성화 */
}

/* 수평 카드 스타일 */
.horizontal-card {
	display: flex; /* Flexbox 사용 */
	flex-direction: row; /* 수평 정렬 */
	border: 1px solid #ddd; /* 테두리 스타일 */
	border-radius: 8px; /* 모서리 둥글기 */
	overflow: hidden; /* 내용이 넘칠 경우 숨기기 */
}

/* 수평 카드 본문 스타일 */
.horizontal-card .card-body {
	flex: 3; /* Flex 비율 설정 */
	padding: 15px; /* 본문 패딩 */
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 아이템 중앙 정렬 */
	justify-content: center; /* 아이템 중앙 정렬 */
	background-color: #fff; /* 배경 색상 */
}

/* 사용자 정의 버튼 스타일 */
.custom-btn {
	background-color: #007bff; /* 버튼 배경 색상 */
	color: white; /* 버튼 텍스트 색상 */
	border: none; /* 테두리 없음 */
	padding: 10px 20px; /* 버튼 패딩 */
	border-radius: 25px; /* 모서리 둥글기 */
	font-size: 16px; /* 버튼 폰트 크기 */
	transition: background-color 0.3s, transform 0.3s; /* 전환 효과 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}

/* 사용자 정의 버튼 호버 스타일 */
.custom-btn:hover {
	background-color: #0056b3; /* 호버 시 배경 색상 */
}

/* 이미지 컨테이너 스타일 */
.image-container {
	position: relative; /* 절대 위치 요소를 위한 상대 위치 설정 */
	display: inline-block; /* 인라인 블록으로 표시 */
}

/* 이미지 변경 버튼 스타일 */
.changeButton {
	position: absolute; /* 절대 위치 */
	top: 10px; /* 상단 위치 */
	right: 10px; /* 오른쪽 위치 */
	background-color: rgba(0, 0, 0, 0.7); /* 반투명 배경 */
	color: white; /* 텍스트 색상 */
	border: none; /* 테두리 없음 */
	padding: 3px 6px; /* 버튼 패딩 */
	font-size: 12px; /* 폰트 크기 */
	cursor: pointer; /* 커서 포인터 모양 */
	border-radius: 3px; /* 모서리 둥글기 */
}

/* 캐러셀 캡션 스타일 */
.carousel-caption {
	position: absolute; /* 절대 위치 */
	bottom: 20px; /* 하단 위치 */
	left: 50%; /* 중앙 정렬을 위한 왼쪽 위치 */
	transform: translateX(-50%); /* 중앙 정렬을 위한 변환 */
	width: 100%; /* 전체 너비 */
	text-align: center; /* 텍스트 중앙 정렬 */
}

/* 사용자 정의 버튼 상단 여백 */
.custom-btn {
	position: absolute;
	bottom: 20px; /* 버튼을 이미지의 하단에 고정 */
	left: 50%;
	transform: translateX(-50%); /* 버튼을 가운데 정렬 */
	z-index: 10; /* 이미지 위에 버튼이 보이도록 z-index 설정 */
}

/* 호텔 이미지 슬라이더 스타일 */
#imageCarousel .carousel-item img {
	height: 700px; /* 호텔 이미지 높이 조정 */
	object-fit: cover; /* 이미지가 프레임에 맞도록 조정 */
	width: 100%; /* 이미지가 가로로 꽉 차게 */
}

/* 객실 이미지 슬라이더 스타일 */
#roomCarousel .carousel-item img {
	width: 100%; /* 이미지의 가로 크기를 100%로 설정 */
	height: 400px; /* 이미지의 세로 크기를 고정 (원하는 크기로 조정 가능) */
	object-fit: cover; /* 이미지가 고정된 크기에 맞게 잘리도록 설정 */
}

/* 객실 캐러셀 높이 조정 */
.room-carousel {
	width: 100%; /* 전체 너비 */
	max-width: 600px; /* 최대 너비 제한 */
	height: 400px; /* 객실 캐러셀 높이 */
}

/* 객실 캐러셀 아이템 및 자체 높이 조정 */
.room-carousel .carousel-item, .room-carousel {
	height: 400px; /* 높이 설정 */
}

/* 객실 캐러셀 내비게이션 버튼 높이 조정 */
.room-carousel .carousel-control-prev, .room-carousel .carousel-control-next
	{
	height: 100%; /* 100% 높이 */
}

/* 버튼 그룹 스타일 */
.btn-grade {
	display: flex; /* Flexbox 사용 */
	justify-content: flex-end; /* 오른쪽 끝으로 배치 */
}

/* 버튼 간격 스타일 */
.btn-grade .btn {
	margin-left: 10px; /* 필요 시 버튼 간 간격 추가 */
}
/* 캐러셀의 둥근 모서리 스타일 */
.carousel {
	border-radius: 15px; /* 모서리를 둥글게 */
	overflow: hidden; /* 내용이 모서리를 넘지 않도록 설정 */
}
</style>



<script type="text/javascript">
	$(function() {
		// 리뷰 Ajax
	
		// JSP에서 JSTL의 forEach를 이용해 amenities 데이터를 자바스크립트 배열로 변환
	    var amenitiesPick = [];
	    
	    <c:forEach items="${amenitiesList}" var="amenity">
	        amenitiesPick.push({
	            amenitiesNo: '${amenity.amenitiesNo}',
	        });
	    </c:forEach>
	        console.log(amenitiesPick);
	    // amenitiesPick에 있는 선택된 편의시설을 체크 상태로 설정
	    for (let i = 0; i < amenitiesPick.length; i++) {
	        let amenitiesNo = amenitiesPick[i].amenitiesNo; // 선택된 편의시설 번호
	        $(`.amenitiesCheckBox[value='\${amenitiesNo}']`).prop("checked", true); // 체크박스 선택
	    }
		
		// 객실 추가 이미지 데이터를 세팅한다. - each(무한반복) - 핵심코드
		$(".hotelRoomList").each(
				function() {
					let rno = $(this).find(".rno").val();
					$(this).find(".hotelRoom").load(
							"/ajax/getRoomImageList.do?rno=" + rno+"&no=${param.no}");
				});
		
		// 호텔 추가 이미지 수정
		$(".changeHotelImages").click(
				function() {
					// 값 가져오기
					let hotel_image_name = $(this).closest(".carousel-item")
							.find("img").prop("src");
					let hotel_image_no = $(this).closest(".carousel-item")
							.data("hotel_image_no");

					// 숨겨진 입력 필드에 값 설정 - 셋팅하는것
					$("#hotel_image_no").val(hotel_image_no);
					$("#hotel_image_name").val(hotel_image_name);
				});

		// 객실 이미지 변경
// 		$(".changeRoomImageBtn").click(function() {
// 					let rno = $(this).closest(".room-carousel").data("rno");
// 					alert(rno);
// 					let room_image_name = $(this).closest(".room-carousel")
// 							.find("img").prop("src");

// 					$(".rno").val(rno);
// 					$("#room_image_name").val(room_image_name);
// 				});
		
		// 객실 이미지 변경
		// Ajax를 사용했을때는 on을 사용해서 Ajax를 호출하는 태그의 id를 $("oo")안에 적고 ".click", 
		// "어떤것을 클릭했을때", function()실행한다.
		$(".hotelRoom").on("click", ".changeRoomImageBtn", function() {
// 			alert("test");
			let rno = $(this).closest(".room-carousel").find(".hotelRoomList").data("rno");
// 			alert(rno);
			let room_image_name = $(this).closest(".room-carousel").find("img").prop("src");

			$(".rno").val(rno);
			
			$("#room_image_name").val(room_image_name);
		});
		
// 		// 객실 추가 이미지 변경
		$(".hotelRoom").on("click", ".changeRoomImagesBtn", function(){
			let room_image_no = $(this).closest(".roomImageImg").find(".roomImageList").data("room_image_no");
			let room_image_name = $(this).closest(".roomImageImg").find("img").prop("src");
			let rno = $(this).closest(".room-carousel").find(".hotelRoomList").data("rno");

			$("#changeRoomImagesModal .no").val(${vo.no});
			$("#changeRoomImagesModal .room_image_no").val(room_image_no);
			$("#changeRoomImagesModal #room_image_name").val(room_image_name);
			$("#changeRoomImagesModal .rno").val(rno);
		});
		
		$(document).on("click", ".room-carousel img", function() {
		    // 선택한 이미지의 src 속성을 가져옴
		    let room_image_name = $(this).prop("src");
		    // 모달 창의 .modal-body에 이미지를 삽입
		    $("#roomBigImageModal .modal-body").html('<img src="' + room_image_name + '" class="img-fluid" alt="Room Image">');
		    // 모달 창 열기
		    $("#roomBigImageModal").modal('show');
		});


		// 리스트 버튼
		$("#listBtn").click(function() {
			location = "list.do?page=${param.page}&perPageNum=${param.perPageNum}"
					+ "&key=${param.key}&word=${param.word}";
		});
		
		let no = $(".review").data("no");
	//	console.log("no -------" + no);
		$(".review").load("/ajax/menuList.do?no=" + no);
	
	});
</script>

</head>
<body>

	<!-- ****************************** 호텔 대표 이미지 변경 ****************************** -->
	<div class="container">
		<c:if
			test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
			대표 이미지 변경 :
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#changeImageModal">이미지 변경</button>
		</c:if>
		<br> <br>
		<!-- ****************************** 호텔 상세보기 이미지(슬라이드) ****************************** -->
		<div id="imageCarousel" class="carousel slide">
			<div class="carousel-inner">
				<!-- 첫 번째 이미지: detail_image_name -->
				<div class="carousel-item active">
					<img src="${vo.detail_image_name}" class="d-block w-100 main-image"
						alt="호텔 상세 이미지">
					<!-- 이미지 변경 버튼 추가 -->
					<div class="carousel-caption d-none d-md-block">
						<c:if
							test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
							<button type="button" class="custom-btn changeImageBtn"
								data-toggle="modal" data-target="#changeDetailImageModal">
								이미지 변경</button>
						</c:if>
					</div>
				</div>

				<!-- 두 번째 이후 이미지: hotel_image_name -->
				<c:if test="${!empty hotelImageList}">
					<c:forEach items="${hotelImageList}" var="hotelImageVO">
						<div class="carousel-item"
							data-hotel_image_no="${hotelImageVO.hotel_image_no}">
							<img src="${hotelImageVO.hotel_image_name}"
								class="d-block w-100 main-image" alt="호텔 이미지">
							<!-- 이미지 변경 버튼 추가 -->
							<div class="carousel-caption d-none d-md-block">
								<c:if
									test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
									<button type="button" class="custom-btn changeHotelImages"
										data-toggle="modal" data-target="#changeHotelImageModal">
										이미지 변경</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>

			<!-- 이전/다음 버튼 -->
			<a class="carousel-control-prev" href="#imageCarousel" role="button"
				data-slide="prev"> <span class="carousel-control-prev-icon"
				aria-hidden="true"></span> <span class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#imageCarousel" role="button"
				data-slide="next"> <span class="carousel-control-next-icon"
				aria-hidden="true"></span> <span class="sr-only">Next</span>
			</a>
		</div>

		<!-- ****************************** 호텔 상세보기 이미지(슬라이드) 끝 ****************************** -->

		<div class="review" data-no=${vo.no }></div>
		<!-- 연한 줄 -->
		<hr style="border: 0.5px solid #ddd; margin: 20px 0;">

		<!-- ****************************** 호텔 상세 내용 ****************************** -->
		<h2 class="hotel-header">${vo.title}</h2>
		<div class="row">
			<div class="hotel-header-container col-md-6"
				style="background-color: #ffffff; 
				height : max;
				border: 1px solid #ccc; /* 두께, 스타일, 색상 */ 
				border-radius: 10px;">
				<div>
					<p class="hotel-subheader">${vo.rating}성급</p>
				</div>
				<div>
					<p>호텔 소개: ${vo.content}</p>
				</div>
				<div>
					<p>전화번호 : ${vo.tel }</p>
				</div>
				<div>
					<p>주소 : ${vo.address }</p>
				</div>
				<div>
					<p>숙소분류 : ${vo.accommodations }</p>
				</div>
				<div class="notice-card" style="border: 1px solid #ccc; /* 두께, 스타일, 색상 */
				border-radius: 10px;">
					<pre style="white-space: pre-wrap; overflow-wrap: break-word; height: 150px;"><strong>공지사항</strong> :
					 ${vo.notice }
					</pre>
				</div>
				<div class="button-container" style="margin-bottom: 30px;">
					<button class="btn btn-dark" id="listBtn">리스트</button>
					<c:if
						test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
						<a
							href="updateForm.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
							class="btn btn-dark">수정</a>
						<button class="btn btn-danger" id="deleteBtn" data-toggle="modal"
							data-target="#deleteModal">삭제</button>
					</c:if>
				</div>
			</div>
			<!-- ****************************** 호텔 상세내용 끝 ****************************** -->

			<!-- ****************************** 편의시설 ****************************** -->
			<div class="amenitiesViewDiv col-md-6" 
			style="background-color: #ffffff;
			border: 1px solid #ccc; /* 두께, 스타일, 색상 */ 
			border-radius: 10px;">
				<b style="font-size: 14pt;">[편의시설]</b>
				<c:if
					test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
					<button type="button" class="btn btn-primary updateAmenitiesBtn"
						data-toggle="modal" data-target="#amenitiesModal">편의시설 수정</button>
				</c:if>
				<ul>
					<c:forEach items="${amenitiesList}" var="amenitiesVO">
						<li style="background-color: #ffffff;">${amenitiesVO.amenitiesName}</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- ****************************** 편의시설 끝 ****************************** -->

		<!-- 연한 줄 -->
		<hr style="border: 0.5px solid #ddd; margin: 20px 0;">

		<!-- ****************************** 객실 이미지 및 내용 ****************************** -->
		<h2>객실 목록</h2>
		<c:forEach items="${hotelRoomList}" var="hotelRoomVO">
			<div class="card hotelRoomList mb-4 shadow-sm"
				style="border-radius: 10px;" data-rno="${hotelRoomVO.rno}">
				<input type="hidden" name="rno" value="${hotelRoomVO.rno}"
					class="rno">
				<div class="card-body d-flex justify-content-between" style="position: relative; height: 100%;">
				<div class="col-md-7">
					<div class="hotelRoom"></div>
				</div>
				<div class="col-md-5">
					<div class="info-container ml-3">
					<div>
						<p>
							<strong style="font-size: 25px;">${hotelRoomVO.room_type}
								&nbsp; ${hotelRoomVO.room_title}</strong>
						</p>
					</div>
					<div>
						<p>
							<strong>가격:</strong>
							<fmt:formatNumber value="${hotelRoomVO.price}" pattern="#,###" />
							원
						</p>
					</div>
					<div>
						<p>
							<strong>인원수:</strong> ${hotelRoomVO.people} 명
						</p>
					</div>
					<div>
						<p>
							<strong>남은 객실:</strong> ${hotelRoomVO.room_number} 개
						</p>
					</div>
					<div>
					    <pre style="white-space: pre-wrap; overflow-wrap: break-word; height: 150px;">
					        <strong>객실 정보</strong>: ${hotelRoomVO.room_content}
					    </pre>
					</div>

				
					<!-- 버튼을 card-body 안의 우측 하단에 배치 -->
					<div class="btn-grade" style="position: absolute; bottom: 10px; right: 10px;">
						<c:if
							test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
							<a
								href="updateRoomForm.do?rno=${hotelRoomVO.rno}&no=${hotelRoomVO.no}"
								class="btn btn-dark">수정</a>
						</c:if>
						<a href="/hotel_reservations/writeForm.do?rno=${hotelRoomVO.rno }"
							class="btn btn-dark">예약하기</a>
					</div>
					</div>
				</div>
			</div>
			</div>
		</c:forEach>

		<!-- ****************************** 객실 내용 및 이미지 끝 ****************************** -->
	</div>

	<!-- ********************************************************************************* -->
	<!-- ****************************** 여기서 부터는 모달 입니다 ****************************** -->
	<!-- ********************************************************************************* -->

	<!-- ****************************** The image Modal ****************************** -->
	<div class="modal" id="changeImageModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">바꿀 이미지 선택하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="changeImage.do" method="post"
					enctype="multipart/form-data" class="changeImage">
					<!-- 숨겨서 넘겨야할 데이터 - 이미지 번호, 현재 파일이름(삭제) -->
					<input name="no" value="${vo.no }" type="hidden"
						data-no="${vo.no }"> <input name="deleteFileName"
						value="${vo.image_name }" type="hidden">
					<!-- 페이지 정보도 넘긴다. -->
					<input name="page" value="${param.page }" type="hidden"> <input
						name="perPageNum" value="${param.perPageNum }" type="hidden">
					<input name="key" value="${param.key }" type="hidden"> <input
						name="word" value="${param.word }" type="hidden">
					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<label for="imageFile">첨부 이미지</label> <input id="imageFile"
								name="imageFile" required class="form-control" type="file">
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ****************************** the end image modal ****************************** -->

	<!-- ****************************** The Detail_image Modal ****************************** -->
	<div class="modal" id="changeDetailImageModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">바꿀 이미지 선택하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="changeDetailImage.do" method="post"
					enctype="multipart/form-data">
					<!-- 숨겨서 넘겨야할 데이터 - 이미지 번호, 현재 파일이름(삭제) -->
					<input name="no" value="${vo.no }" type="hidden"> <input
						name="deleteFileName" value="${vo.detail_image_name }"
						type="hidden">
					<!-- 페이지 정보도 넘긴다. -->
					<input name="page" value="${param.page }" type="hidden"> <input
						name="perPageNum" value="${param.perPageNum }" type="hidden">
					<input name="key" value="${param.key }" type="hidden"> <input
						name="word" value="${param.word }" type="hidden">
					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<label for="detailImageFile">첨부 이미지</label> <input
								id="detailImageFile" name="detailImageFile" required
								class="form-control" type="file">
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ****************************** The end detail_image_modal ****************************** -->

	<!-- ****************************** The Hotel_image_name Modal ****************************** -->
	<div class="modal" id="changeHotelImageModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">바꿀 이미지 선택하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="changeHotelImage.do" method="post"
					enctype="multipart/form-data">
					<!-- 숨겨서 넘겨야할 데이터 - 이미지 번호, 현재 파일이름(삭제) -->
					<input type="hidden" name="no" value="${vo.no }" class="no">
					<input type="hidden" id="hotel_image_no" name="hotel_image_no"
						value="${hotelImageVO.hotel_image_no}"> <input
						name="deleteFileName" id="hotel_image_name"
						value="${hotelImageVO.hotel_image_name}" type="hidden">

					<!-- 페이지 정보도 넘긴다. -->
					<input name="page" value="${param.page}" type="hidden"> <input
						name="perPageNum" value="${param.perPageNum}" type="hidden">
					<input name="key" value="${param.key}" type="hidden"> <input
						name="word" value="${param.word}" type="hidden">

					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<label for="hotelImageFile">첨부 이미지</label> <input
								id="hotelImageFile" name="hotelImageFile" required
								class="form-control" type="file" multiple>
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ****************************** the end hotel_image modal ****************************** -->

	<!-- ****************************** The room_image(roomVO) Modal ****************************** -->
	<div class="modal" id="changeRoomImageModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">바꿀 이미지 선택하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="changeRoomImage.do" method="post"
					enctype="multipart/form-data">
					<!-- 숨겨서 넘겨야할 데이터 - 이미지 번호, 현재 파일이름(삭제) -->
					<input type="hidden" name="no" value="${vo.no }" class="no">
					<input type="hidden" name="rno" value="${hotelRoomVO.rno }"
						class="rno"> <input name="deleteFileName"
						id="room_image_name" value="${hotelRoomVO.room_image_name}"
						type="hidden">

					<!-- 페이지 정보도 넘긴다. -->
					<input name="page" value="${param.page}" type="hidden"> <input
						name="perPageNum" value="${param.perPageNum}" type="hidden">
					<input name="key" value="${param.key}" type="hidden"> <input
						name="word" value="${param.word}" type="hidden">

					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<label for="roomImageFile">첨부 이미지</label> <input
								id="roomImageFile" name="roomImageFile" required
								class="form-control" type="file">
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ****************************** The end room_image(roomVO) modal ****************************** -->

	<!-- ****************************** The room_image(room_imageVO) Modal ****************************** -->
	<div class="modal" id="changeRoomImagesModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">바꿀 이미지 선택하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="changeRoomImages.do" method="post"
					enctype="multipart/form-data">
					<!-- 숨겨서 넘겨야할 데이터 - 이미지 번호, 현재 파일이름(삭제) -->
					<input type="hidden" name="no" value="${vo.no }" class="no">
					<input type="hidden" name="rno" value="${hotelRoomVO.rno }"
						class="rno"> <input type="hidden" name="room_image_no"
						value="${roomImageVO.rno }" class="room_image_no"> <input
						name="deleteFileName" id="room_image_name"
						value="${roomImageVO.room_image_name}" type="hidden">

					<!-- 페이지 정보도 넘긴다. -->
					<input name="page" value="${param.page}" type="hidden"> <input
						name="perPageNum" value="${param.perPageNum}" type="hidden">
					<input name="key" value="${param.key}" type="hidden"> <input
						name="word" value="${param.word}" type="hidden">

					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<label for="roomImagesFile">첨부 이미지</label> <input
								id="roomImagesFile" name="roomImagesFile" required
								class="form-control" type="file" multiple>
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ****************************** The end room_image(roomVO) modal ****************************** -->

	<!-- ****************************** The amenities checkBox modal ****************************** -->
	<!-- The Modal -->
	<div class="modal fade" id="amenitiesModal">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<form action="updateAmenities.do" method="post">
					<!-- 숨겨서 넘겨야할 데이터 - 이미지 번호, 현재 파일이름(삭제) -->
					<input type="hidden" name="no" value="${vo.no }" class="no">
					<!-- 페이지 정보도 넘긴다. -->
					<input name="page" value="${param.page}" type="hidden"> <input
						name="perPageNum" value="${param.perPageNum}" type="hidden">
					<input name="key" value="${param.key}" type="hidden"> <input
						name="word" value="${param.word}" type="hidden">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">편의시설 수정</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<fieldset class="border p-4" id="amenitiesFieldSet">
							<legend class="w-auto px-2">
								<b style="font-size: 14pt;">[편의시설]</b>
							</legend>
							<div id="amenitiesDiv" class="form-inline">
								<c:forEach items="${amenitiesAlllist}" var="amenitiesVO">
									<div class="form-check form-check-inline">
										<input class="form-check-input amenitiesCheckBox"
											type="checkbox" id="amenities${amenitiesVO.amenitiesNo}"
											name="selectedAmenities" value="${amenitiesVO.amenitiesNo}" />
										<label class="form-check-label"
											for="amenities${amenitiesVO.amenitiesNo}">${amenitiesVO.amenitiesName}</label>
									</div>
								</c:forEach>
							</div>
						</fieldset>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button id="AmenitiesBtn" class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- ****************************** The Room BigImage Modal  ****************************** -->
	<!-- The Modal -->
	<div class="modal" id="roomBigImageModal">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Room Image</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body"></div>


			</div>
		</div>
	</div>

	<!-- deleteBtn modal -->
	<!-- The Modal -->
	<div class="modal fade" id="deleteModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">삭제 경고창</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<form action="delete.do" method="post">
					<input type="hidden" name="no" value="${vo.no }">
					<!-- Modal body -->
					<div class="modal-body">
						<div class="form-group">
							<p>호텔을 삭제합니다.</p>
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button class="btn btn-danger">삭제</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
					</div>

				</form>

			</div>
		</div>
	</div>

</body>
</html>
