<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel</title>
<style type="text/css">
/* CSS 스타일 */
.dataRow:hover {
	opacity: 0.7; /* 투명도 */
	cursor: pointer;
}

.imageDiv {
	background: black;
	overflow: hidden; /* 카드 내부를 넘지 않도록 설정 */
}

.imageDiv img {
	width: 100%;
	height: 400px; /* 원하는 이미지 높이 설정 */
	object-fit: cover; /* 이미지 비율 유지하며 카드에 맞추기 */
}

.title {
	text-overflow: ellipsis;
	overflow: hidden;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
}
</style>
<script type="text/javascript">
	$(function() {
		// 이벤트 처리
		$(".dataRow").click(
				function() {
					let no = $(this).find(".no").val();
					console.log("no = " + no);
					location = "view.do?no=" + no + "&inc=1&"
							+ "${pageObject.pageQuery}";
				});

		// 호텔 카드 클릭 이벤트 처리
		$(".dataRow").click(
				function() {
					let no = $(this).find(".no").val();
					console.log("no = " + no);
					location = "view.do?no=" + no + "&inc=1&"
							+ "${pageObject.pageQuery}";
				});

		// 토글 스위치 클릭 시 페이지 이동
		$("#switch1").change(function() {
			if ($(this).is(":checked")) {
				// amenities로 이동
				location.href = "/amenities/list.do"; // "/amenities/list.do"로 페이지 이동
			} else {
				// 호텔 목록으로 돌아가기
				location.href = "/hotel/list.do"; // "/hotel/list.do"로 페이지 이동
			}
		});

	});
</script>
</head>
<body>
	<div class="container">
			<div class="custom-control custom-switch"
				style="display: inline-block; margin-top: 10px;">
				<input type="checkbox" class="custom-control-input" id="switch1">
				<c:if test="${!empty login && login.gradeNo == 9 }">
					<label class="custom-control-label" for="switch1">Amenities</label>
				</c:if>
			</div>
	<!-- 토글 스위치 -->
		<div class="backGroundImg"
			style="background-image: url(/upload/hotel/lobby/qqq.jpg);
				   background-size: cover; /* 이미지가 요소 크기에 맞게 조정 */
   				   background-position: center; /* 이미지의 중앙을 기준으로 위치 */
   				   height: 400px; /* 또는 다른 적절한 높이 */
   				   text-align: center;
   				   border-radius: 10px;
   				   ">
			<h2 style="	background-color: #f2f2f2;
						display: inline-block;
						margin: 150px;
						font-size: 70px;
						color: #4d2600;
						font-family: 'Pacifico', cursive; font-size: 70px;
						border-radius: 10px;
						">Hotel</h2>
		</div>
		<br><br>
		
		<form>
			<input name="page" value="1" type="hidden"> <input
				id="pageQuery" name="pageQuery" value="${pageObject.perPageNum }"
				type="hidden">
			
		</form>
		<!-- 탭 메뉴 -->
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link ${(param.accommodations==1||empty param.accommodations)?'active':'' }" data-bs-toggle="tab" href="list.do?accommodations=1"
				style="color:#ff9900;">국내 숙소</a>
			</li>
			<li class="nav-item" >
				<a class="nav-link ${(param.accommodations==2)?'active':'' }" data-bs-toggle="tab" href="list.do?accommodations=2"
				style="color:#ff9900;">해외 숙소</a>
			</li>
		</ul>
		<c:if test="${empty list }">
			<div class="jumbotron">
				<h4>데이터가 존재하지 않습니다.</h4>
			</div>
		</c:if>
		<c:if test="${!empty list }">
			<div class="row">
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
				<c:forEach items="${list }" var="vo" varStatus="vs">
					<!-- 줄바꿈처리 - 찍는 인덱스 번호가 2의 배수이면 줄바꿈을 한다. -->
					<c:if test="${(vs.index != 0) && (vs.index % 2 == 0) }">
            ${"</div>"}
            ${"<div class='row'>"}
        </c:if>
					<!-- 데이터 표시 시작 -->
					<div class="col-md-6 dataRow">
						<div class="card" style="width: 100% style="border-radius: 10px;"">
							<div>
								<input class="no" type="hidden" value="${vo.no }">
							</div>
							<div class="imageDiv text-center" style="border-radius: 10px;">
								<img class="card-img-top" src="${vo.image_name }" alt="image"
									">
							</div>
							<div class="card-body">
								<strong class="card-title"> ${vo.title } </strong>
								<p class="card-text title">
								<div>
									<span class="rating">${vo.rating }성급</span>
								</div>
								<div>
									<fmt:formatNumber value="${vo.price }" />
									원
								</div>
								<div>
									<span class="address">${vo.address }</span>
								</div>
								</p>
							</div>
						</div>
					</div>
					<!-- 데이터 표시 끝 -->
				</c:forEach>
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 끝 -->
			</div>


			<!-- 페이지 네이션 처리 -->
			<div>

				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
			</div>

		</c:if>
		<br><br>
		<!-- 리스트 데이터 표시의 끝 -->
		<c:if test="${login!=null && (login.email == vo.email || login.gradeNo > 4) }">
			<a href="writeForm.do?perPageNum=${pageObject.perPageNum }"
				class="btn btn-primary">등록</a>
		</c:if>
	</div>
</body>
</html>