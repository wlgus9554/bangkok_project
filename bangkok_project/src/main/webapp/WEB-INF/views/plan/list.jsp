<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>plan main</title>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">

.myTrip, .tripWriteBtn, .tripThema {
	color: #6c757d;
}
.tripWriteBtn {
	border:1px solid #5a5c69;
}
.tripWriteBtn:hover {
	color: #ffffff;
	cursor: pointer;
}
#citySearch .cityList:hover {
	cursor: pointer;
	border: 2px solid #fd7e14;
}
.tripThema:hover {
	text-decoration: underline;
	cursor: pointer;
}
.card {
	height: 140px;
	margin-bottom: 30px;
}
.trip {
	float: left;
	margin-right: 10px; 
}
.orderBlock:hover {
	cursor: pointer;
}
.orderBlock {
    user-select: none; /* 모든 브라우저에서 텍스트 선택을 방지합니다 */
}
.tripDeleteBtn {
	width: 40px; height: 40px;
	padding: 7px;
	float: right; text-align: center;
}
.tripDeleteBtn:hover {
	cursor: pointer;
	border-radius: 50%;
}
.tripDeleteBtn:active {
	background: #e0e0e0;	
}
#citySearchModal .card-body {
	cursor: pointer;
}
</style>
<script src="/js/main.js"></script>
<script type="text/javascript">

$(function(){
	// 이벤트 처리
	// 뷰 이동
	$(".tripThema").click(function(){
		let tno = $(this).find(".tno").val();
		// alert(tno);
		location = "view.do?tno=" + tno;
		// return false;
	});
	
	// 여행 리스트 정렬 방식
	$(".dropdown-item").click(function(event){
		event.preventDefault(); // 기본 링크 클릭 동작 방지
        // Get the text of the clicked item
        let order = $(this).text();
        // Update the span with the selected text
        $('.orderList').text(order);
	});
	
	// 여행 등록 - 1. 기간 선택 ------------------------------------------
	// datePicker 관련 이벤트
	$('.tripWriteBtn').click(function() {
		
		// 새로 오픈 될 때 검색 데이터 지우기
		$("#inputSchedule").val("");
		$('#dateRange').text("도착일" + " ~ " + "출발일");
        $("#selectedDepartDate").val("");
        $("#selectedArriveDate").val("");

	});
	
	// 날짜 입력 설정 - datepicker
	let now = new Date();
	
	// Datepicker를 초기화
    $('#departureCalendar').datepicker({
    	// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 오늘까지만의 날짜를 선택 가능
		minDate : now,
		onSelect: function(dateText) {
// 			let dateAddTime = dateText + " 00:00:00" 
//             $("#selectedDepartDate").val(dateAddTime);
            $("#selectedDepartDate").val(dateText);
		}
    });
	
	//초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#departureCalendar').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	
    $('#arrivalCalendar').datepicker({
    	// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 오늘까지만의 날짜를 선택 가능
		minDate : now,
		onSelect: function(dateText) {
//             let dateAddTime = dateText + " 00:00:00" 
//             $("#selectedArriveDate").val(formattedDate);
            $("#selectedArriveDate").val(dateText);
		}
    });
    
 	 //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#arrivalCalendar').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	
    // "일정 선택 완료" 버튼 클릭 시 선택된 날짜를 표시
    $('#confirmDateBtn').click(function() {
        if ($("#selectedArriveDate").val() != null) {
            $('#dateRange').text($("#selectedDepartDate").val() + " ~ " + $("#selectedArriveDate").val());
            $("#dDate").val($("#selectedDepartDate").val());
            $("#aDate").val($("#selectedArriveDate").val());
        } else { // 항공 상품 관리 - 편도 일 때
        	$('#dateRange').text($("#selectedDepartDate").val());
        	$("#dDate").val($("#selectedDepartDate").val());
        }
        // 모달 창 닫기
        console.log($("#selectedDepartDate").val()  + " ~ " + $("#selectedArriveDate").val());
        $('#datePickerModal').modal('hide');
        $('.modal-backdrop').remove();
        // tripWriteModal show
        $("#tripWriteModal").find(".tripPeriodForm .tripStartDateInput")
        	.attr("value", $("#selectedDepartDate").val());
        $("#tripWriteModal").find(".tripPeriodForm .tripEndDateInput")
    		.attr("value", $("#selectedArriveDate").val());
        $('#tripWriteModal').modal('show');
    });
    
	// 여행 등록 - 3. citySearchModal 보이기
	$("#citySearchBtn").click(function(){
		
		// alert('여행지 검색창');
		$(".citySearchDiv").load("/cityPlaceAjax/getCityList.do", function(){
			// 원래 입력란 지우기
			$("#tripWriteModal").modal("hide");
			// 검색 창 보이기
			$("#citySearchModal").modal("show");
		});
		
		// let cityName = $(this).val();
		// alert(cityName);
	});
	
	// 여행 등록 - 4. 도시선택
	$(".citySearchDiv").on("click", ".cityList", function(){
		// alert("여행지 선택");
		// 여행지 번호 조회
		let cityNum = $(this).find(".cityNum").val(); // this - cityList class
		// 여행지명 조회
		let cityName = $(this).find(".cityName").text();
		// alert("cityNum : " + cityNum + ", tripPlace : " + tripPlace);
		// 여행지 번호를 tripWriteModal 의 cityNum input 에 저장
		$("#tripWriteModal").find(".tripPlaceForm .cityNum").attr("value", cityNum);
		// 여행지명을 버튼에 저장
		$("#tripWriteModal").find("#citySearchBtn span").text(cityName);
		// 검색 창 지우기
		$("#citySearchModal").modal("hide");
		// 원래 입력란 보이기
		$("#tripWriteModal").modal("show"); 
		
	});
	
	// 도시 검색 -> 등록 창으로 돌아가기
	$("#citySearchModal .cancelBtn").click(function(){
		// 검색 창 지우기
		$("#citySearch").hide();
		// 원래 입력란 보이기
		$("#tripWriteModal").show();
	})
	
	// tripPeriodBtn 버튼 클릭 시 달력 보이기
	
	// 여행 삭제 모달 표시
	$(".tripDeleteBtn").click(function(){
		// 여행 등록 번호 가져오기
		let tno = $(this).closest(".row").find(".tno").val();
		// alert(tno);
		let tripThema = $(this).closest(".row").find(".tripThema").text();
		// alert(tripThema);
		// action 위치 지정
		$("#tripWriteModal").find("form").attr("action", "delete.do");
		// 모달 중앙 배치
		$("#tripWriteModal").find(".modal-dialog").addClass("modal-dialog-centered");
		// 모달 제목 변경
		$("#tripWriteModal").find(".modal-title").text("여행을 삭제할까요?");
		// 모달 내용 지우기
		$("#tripWriteModal").find(".modal-body .form-group").remove();
		
		// 내용 채우기
		$("#tripWriteModal").find(".modal-body").addClass("text-center")
			.text("여행을 삭제하면 복구할 수 없습니다. [" + tripThema + "]을(를) 삭제하시겠어요?");
		
		// input 태그 만들기
		let tnoInput = $("#tripWriteModal").find("form");
		tnoInput.append("<input type='hidden' value='" + tno + "' name=tno>")
		
		// $("#tripWriteModal").find("form").add("form input").val(tno);
		
		// 삭제 버튼 만들기
		$(".modal-footer").find("#modalMultiBtn").removeClass("btn-dark")
			.addClass("btn-danger").text("remove");
		
		$("#tripWriteModal").modal("show");
	});
	
});

</script>

</head>
<body>

<div class="container">
	
<h2 class="myTrip mt-4 font-weight-bold text-center">내 여행</h2>

<c:if test="${empty tripList}">
	<div class="alert alert-secondary" style="margin-top:16px;">
		<h5 class="text-center font-weight-bolder mb-0">어디로 떠나 볼까요? [ 새로운 여행 떠나기 ] 로 여행 계획을 만들어 보아요!</h5>
	</div>
</c:if>

<button class="btn btn-outline-dark btn-block tripWriteBtn" 
	data-toggle="modal" data-target="#datePickerModal"
	style="margin: 30px 0; padding: 15px 10px; font-size: 17px;">
	<i class="fa fa-plus"></i> 새로운 여행 떠나기
</button>


<c:if test="${!empty tripList }">
<div class="orderBlock dropdown text-right" 
	style="margin-bottom: 16px;">
	<p class="dropdown-toggle" data-toggle="dropdown">
		정렬기준 : <span class="orderList">마지막 수정일</span>
	</p>
	<div class="dropdown-menu dropdown-menu-right">
		<a class="dropdown-item" href="list.do?order=asc">작성일</a>
		<a class="dropdown-item" href="list.do?order=desc">마지막 수정일</a>
    </div>
</div>

<c:forEach items="${tripList }" var="vo"> <!-- start of 여행 테마 리스트 -->
	<div class="card">
		<div class="card-body">
			<div class="row">
				<div class="col-md-3"> <!-- 도시 사진 -->
					<div style="height: 98px;">
						<img src="${vo.cityImg }" class="rounded" alt="cityImg" width="100%" height="100%">
					</div>
				</div>
				<div class="col-md-9">
					<div class="row">
						<div class="col-9 tripThema">
							<h4 class="card-title font-weight-bolder">
								<input type="hidden" name="tno" class="tno" value="${vo.tno }">
								${vo.tripThema }
							</h4>
						</div>
						<div class="col-3">
							<!-- 여행 삭제 버튼 -->
							<div class="tripDeleteBtn">
								<h4 class="m-0">
									<i class="fa fa-ellipsis-v"></i>
								</h4>
							</div>
						</div>
					</div>
					<p class="card-text trip">
						<i class="fa fa-calendar-o"></i> 
						<fmt:formatDate value="${vo.tripStartDate }" pattern="yyyy-MM-dd" /> 
						→ <fmt:formatDate value="${vo.tripEndDate }" pattern="yyyy-MM-dd" />
					</p>
					<p class="card-text"><i class="fa fa-map-marker"></i> ${vo.countryKor }, ${vo.cityName}</p>
				</div>
			</div>
		</div>
	</div>
</c:forEach> <!-- end of 여행 테마 리스트 -->
</c:if>
</div> <!-- end of container -->


<jsp:include page="datePickerModal.jsp" />

<!-- start to modal -->
<div class="modal" id="tripWriteModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">여행 떠나기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<form method="post" action="write.do">
				<!--사용자 로그인 아이디 -->
				<input type="hidden" value="${login.email }" name="email">
				<!-- Modal body -->
				<div class="modal-body">
					<!-- 여행 기간 설정 -->
					<div class="form-group tripPeriodForm">
						<label for="tripPeriodBtn">날짜 또는 여행 기간</label>
						<button type="button" class="btn btn-block" id="tripPeriodBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							<span id="dateRange">여행 기간이 어떻게 되시나요?</span>
						</button>
						<input type="hidden" name="tripStartDate" class="tripStartDateInput">
						<input type="hidden" name="tripEndDate" class="tripEndDateInput">
					</div>
					<div class="form-group">
						<label for="tripThema">여행 이름</label>
						<input class="form-control" placeholder="ex.파리로 떠나는 가을 휴가" 
							id="tripThema" name="tripThema" required maxlength="80">
					</div>
					<!-- 여행지 검색 구간 -->
					<div class="form-group tripPlaceForm">
						<label for="cityNum">여행지</label>
						<input type="hidden" class="cityNum" name="cityNum">
						<button type="button" class="btn btn-block" id="citySearchBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							<span>여행을 어디로 떠나시나요?</span>
						</button>
						<!-- 여행 도시 게시판 리스트 + 버튼 추가 -->
						<!-- Ajax 로 로드하기 -->
					</div>
					<div class="form-group">
						<label for="tripComment">설명(선택사항)</label>
						<textarea class="form-control" id="tripComment" name="tripComment" maxlength="1000"
							rows="2"></textarea>
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-dark" id="modalMultiBtn">Go</button>
					<button type="button" class="btn btn-outline-secondary cancelBtn" 
						data-dismiss="modal" style="border:1px solid #858796;">cancel</button>
				</div>
			</form>
		
		</div>
	</div>
</div>
<!-- end of modal -->
<div class="citySearchDiv"></div>

</body>
</html>