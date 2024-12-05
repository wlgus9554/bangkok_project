<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<style>
.lineDiv {
	background: #f2f2f2;
	padding: 10px;
	border-radius: 30px;
	margin-bottom: 10px;
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 15px;
	margin-top: 50px;
}

.lineDiv img {
	border-radius: 10px;
	width: 80%; /* 기본 이미지 크기 */
}

.rounded.sub_image {
	width: 60%; /* 서브이미지 크기 줄이기 */
	height: auto; /* 비율에 맞게 높이 자동 조정 */
}

.rounded.image {
	width: 100px; /* 메인 이미지 크기 */
	height: auto; /* 비율에 맞게 높이 자동 조정 */
}

.eventTitle {
	font-size: 16px;
	margin-top: 10px;
	text-align: center;
	color: white;
	font-family: 'Pretendard-Regular';
	font-weight: 500;
}

.carousel-item {
	display: flex;
	justify-content: center;
	transition: opacity 0s ease-in-out; /* 전환 시간을 0.3초로 조정 */
	opacity: 0; /* 기본적으로 모든 슬라이드의 투명도를 0으로 설정 */
}

.dataRow {
	flex: 1; /* 각 데이터 항목이 같은 비율로 공간을 차지하도록 */
	text-align: center;
	padding: 5px;
	cursor: pointer; /* 이미지에만 포인터 커서 설정 */
	max-width: 33%; /* 최대 너비를 33%로 설정하여 3개가 한 줄에 들어가게 함 */
}

.carousel-item {
	border: none; /* 기본 테두리 제거 */
}

.container-event {
	position: relative;
	background-color: #FF7F50;
	border-radius: 30px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
	margin: 0 auto;
	max-width: 70%; /* 최대 너비를 800px로 설정 (원하는 값으로 변경 가능) */
	padding-left: 30px;
}

/* 슬라이드의 기본 CSS 설정 */
.carousel-item {
	opacity: 0; /* 기본적으로 모든 슬라이드의 투명도를 0으로 설정 */
}

/* 현재 활성 슬라이드의 opacity를 1로 설정 */
.carousel-item.active {
	opacity: 1;
}

/* 화살표 버튼 스타일 */
.arrow {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: white; /* 배경색을 하얗게 */
	color: black; /* 화살표 색상을 검정색으로 */
	border: none;
	border-radius: 50%; /* 동그랗게 만들기 */
	width: 40px; /* 너비 조정 */
	height: 40px; /* 높이 조정 */
	display: flex; /* 중앙 정렬을 위해 flex 사용 */
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: center; /* 수평 중앙 정렬 */
	cursor: pointer;
	z-index: 10;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}

.arrow.left {
	left: -10px;
}

.arrow.right {
	right:10px;
}

.a, .arrow {
    text-decoration: none; /* 기본 언더바 제거 */
}

.arrow:hover {
    text-decoration: none; /* 마우스 오버 시 언더바 제거 */
}
</style>

<br>
<br>
<h4
	style="margin-left: 16%; font-family: 'Pretendard-Regular'; margin-bottom: 20px;">이벤트
	&#183; 혜택</h4>
<div class="container-event">
	<div id="eventCarousel" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<c:forEach items="${eventList}" var="vo" varStatus="status">
				<c:if test="${status.index % 3 == 0}">
					<div
						class="carousel-item <c:if test="${status.index == 0}">active</c:if>">
				</c:if>
				<div class="dataRow" data-event-no="${vo.eventNo}">
					<div class="lineDiv">
						<img class="rounded sub_image" src="${vo.sub_image}"
							alt="Event Image"> <img class="rounded image"
							src="${vo.image}" alt="Event Image">
					</div>
					<p class="eventTitle">${vo.title}</p>
				</div>
				<c:if test="${status.index % 3 == 2 || status.last}">
		</div>
		<!-- 그룹 종료 -->
		</c:if>
		</c:forEach>
	</div>
	<a class="arrow left" href="#eventCarousel" role="button"
		data-slide="prev"> <i class="material-icons">keyboard_arrow_left</i>
	</a> <a class="arrow right" href="#eventCarousel" role="button"
		data-slide="next"> <i class="material-icons">keyboard_arrow_right</i>
	</a>

</div>
</div>
<script>
	// Carousel 이벤트에 대해 처리
	$('#eventCarousel').on('slide.bs.carousel', function() {
		$('.carousel-item').css('opacity', '0'); // 모든 슬라이드를 투명하게
	});

	$('#eventCarousel').on('slid.bs.carousel', function() {
		$('.carousel-item.active').css('opacity', '1'); // 활성 슬라이드만 보이도록
	});
</script>
