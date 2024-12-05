<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>trip plan view</title>
<link rel="stylesheet" href="/css/main.css">
<style type="text/css">

.modal {
	background: transparent;
}
.themaDiv {
	height: 240px;
}
.tripDetailDiv:first-child {
	width: 40px; height: 40px;
	padding: 4px; float:left; text-align: center;
}
.tripDetailDiv {
	width: 40px; height: 40px;
	padding: 4px; float:right; text-align: center;
}
.tripDetailDiv:hover {
	cursor: pointer;
}
.tripDetailDiv:active {
	border: 0 solid #6c757d; border-radius: 50%;
	background: #e0e0e0;	
}
.themaDiv > .card-body {
	position: absolute;
    bottom: 0; /* 컨테이너의 하단에 정렬 */
    margin: 0; /* 필요에 따라 마진 조정 */
}
.tripThema, .tripDate {
	font-weight: bolder;
}
.tripDate {
	Padding: 5px;
}
.tripPeriod, .tripPlace {
	float: left;
	margin-right: 10px; 
	margin-bottom: 0
}
.tripDateBtn {
	margin: 10px 10px 0 0;
}
.tripDateBtn:last-child {
	margin-right: 0;
}
/* 방문지 관리 ----------------------------------------- */
.planListDiv {
	padding: 10px 0;
}
.deleteBtn {
	width: 30px; height: 30px;
	padding-top:4px;
	float: right; text-align: center;
}
.deleteBtn:hover {
	cursor: pointer;
}
.deleteBtn:active {
	border-radius: 50%;
	background: #e0e0e0;	
}
#citySearchModal .cityList:hover {
	cursor: pointer;
	border: 2px solid #fd7e14;
}
.tripPlanDiv { 
	padding: 15px 50px;
	margin: 0 auto;
} 
.tripPlanDiv > div:first-child { 
	border-top: 1px solid #5a5c69;
} 
.tripPlanDiv > div { 
	border-bottom: 1px solid #5a5c69;
} 
.tripPlace p {
	margin-bottom: 8px;
}
.tripDateBtn{
	border:1px solid #343a40;
}
.planList:hover {
	cursor: pointer;
	border: 1px solid orange;
} 
.placeCard:hover {
	cursor: pointer;
	border: 1px solid orange;
} 
.cancelBtn {
	border:1px solid #858796;
	border-radius: 10px%;
}
</style>
<!-- 구글 지도 api -->
<!-- <script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKx6hwWeIT3qTG3uNkPVFbIkob4joaPcY&callback=initMap&v=weekly&libraries=marker""></script> -->
<!-- 지도 스크립트 부분 -->
<script type="text/javascript">
// $(function(){
// 	let map = google.maps.Map;
// 	async function initMap() {
// 	    const { Map } = await google.maps.importLibrary("maps");
// 	    // 마커 생성 부분
// 	    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
// 	    const map = new Map(document.getElementById("map"), {
// 	        // 중심지의 위도/경도
// 	    	center: { lat: 37.738835, lng: 127.045888 },
// 	        zoom: 14,
// 	        mapId: "4504f8b37365c3d0",
// 	    });
// 	    const marker = new AdvancedMarkerElement({
// 	      map,
// 	      position: { lat: 37.738835, lng: 127.045888 },
// 	    });
// 	}
	
// 	initMap();
// });
</script>
<script type="text/javascript">
	$(function(){
		// 여행 등록 번호 가져오기
		window.tno = $(".tripViewDiv").find(".tno").val();
		// alert('tno : ' + tno);
		
		// 시작일, 종료일 가져오기
		window.startDate = $(".tripContent .tripStartDateBlock").text().replace(/[\s\t]+/g, '');
		// alert('startDate : ' + startDate + ', startDate 타입: ' + typeof startDate);
		window.endDate = $(".tripContent .tripEndDateBlock").text().replace(/[\s\t]+/g, '');
		// alert('endDate : ' + endDate + ', endDate 타입: ' + typeof endDate);
		
		// 여행지 번호 가져오기
		window.cityNum = $(".tripViewDiv").find(".cityNum").val();
	});
</script>
<!-- 여행 계획 스크립트 부분 -->
<script type="text/javascript" src="/js/planList.js"></script>
<script type="text/javascript">
	$(function(){
		// 이벤트 처리 ---------------------------------------------------
		// 여행 수정 - 0. 수정 모달 출력
		$("#tripUpdateDiv").click(function(){
			// 여행 기간 유지 -1. 버튼 텍스트 유지
			// 모달창 출력
			$("#tripUpdateModal").modal("show");
		});
		
		// 여행 수정 - 1. 날짜 수정
		$("#tripUpdateModal .tripPeriodBtn").click(function(){
			$("#tripUpdateModal").modal("hide");
			$("#datePickerModal").modal("show");
		});
		
		// 방문지 관리 및 일정 관리 ----------------------------------------------------------
		// 리스트 >> 자바스크립트 + load()
		
		// 상세보기 >> tripPlanDiv > planListDiv > tripPlanList > planList
// 	 	$(".tripPlanDiv").on("click", ".placeInfo", function(){
// 	 		console.log("일정 클릭");
// 	 		// 여행지 방문 번호(pno) 수집
// 			let pno = $(this).find(".pno").val();
// 			console.log("pno : " + pno);
			
// 			$(".planModalsDiv").load("/planAjax/getPlanView.do?tno=" + tno + "&pno=" + pno)
// 			// 여행 시간 출력 형태
// 			$("#planWriteModal").find(".tripTimeInput").css("display", "block");
// 			$("#planWriteModal").find(".tripTimeBlock").css("display", "none");
			
// 			$("#planWriteModal").find(".modal-footer .modalMultiBtn").hide();
// 			$("#planWriteModal").modal("show"); // 모달 표시
			
// 		});
		
		// 모달 출력 오류 코드 해결
	 	$(".tripPlanDiv").on("click", ".placeInfo", function(){
	 		console.log("일정 클릭");
	 		// 여행지 방문 번호(pno) 수집
			let pno = $(this).find(".pno").val();
			console.log("pno : " + pno);
			
			$(".planModalsDiv").load("/planAjax/getPlanView.do?tno=" + tno + "&pno=" + pno, 
					function(){
				// 여행 시간 출력 형태
				$("#planWriteModal").find(".tripTimeInput").css("display", "block");
				$("#planWriteModal").find(".tripTimeBlock").css("display", "none");
				
				$("#planWriteModal").find(".modal-footer .modalMultiBtn").hide();
				$("#planWriteModal").modal("show"); // 모달 표시
			});
	 	});
		
		// 등록 >> tripPlanDiv > planListDiv > planWriteBtn
		// 등록할 데이터 ) 장소, 날짜, 시간, 내용, login.email
		// 여행지 선택 클릭 이벤트
		$(".tripPlanDiv").on("click", ".planWriteBtn", function(){
			console.log(cityNum);
			$(this).closest(".planListDiv")
     			.siblings(".planModalsDiv").load("/cityPlaceAjax/getPlaceList.do?cityNum=" + cityNum 
     					+ "&${pageObject.pageQuery}", 
					function(){
				// placeSearchModal 세팅 및 출력
				$("#placeSearchModal").modal("show");
			});
		});
		
		// placeCard 클릭 이벤트 >> planWriteModal로 내용 이동
        $(".planModalsDiv").on("click", ".placeCard", function() {
            console.log("여행지 클릭");
            
         	let goPlace = $(this);
         	let placeImg = $(this).find(".card-img-top").attr("src");
         	
			// 날짜 가져오기 및 확인
         	let planListDiv = goPlace.closest('.planModalsDiv').siblings(".planListDiv");
	        console.log("Plan List Div:", planListDiv); // 추가된 콘솔 로그
	        
	        let tripDate = planListDiv.find(".planListBtn").data("tripdate");
	        console.log("Trip Date:", tripDate); // Trip Date 확인
         	
         	$(this).closest(".planModalsDiv").load("/planAjax/getPlanWriteForm.do", function(){
         		
	            $("#placeSearchModal").modal("hide");
				
	         	// 여행 등록 번호 저장
				$("#planWriteModal").find(".tno").attr("value", tno);
				$("#planWriteModal").find(".pno").remove();
				
				// 제목 설정
				$("#planWriteModal").find(".modal-header h4").text("장소 추가하기");
				
	            
		        let placeText = goPlace.find('.card-body .place').text();
	            
		        $("#planWriteModal .tripPlaceForm").find('.placeSearchBtn span').text(placeText);
	            console.log("Place Text: " + placeText);
	            
				
				// 여행 날짜 설정
		        $("#planWriteModal").find(".tripPeriodForm .tripDate").attr("value", tripDate);
		        $("#planWriteModal").find(".tripPeriodForm .tripPeriodBtn").text(tripDate);
				
				// 여행지 정보 저장
	            $("#planWriteModal .placeImage").find('.img-thumbnail img')
					.attr('src', placeImg);
	            $("#planWriteModal .tripPlaceForm").find('.noInput')
					.attr('value', goPlace.closest('.dataRow').data('no'));
	            
	         	// 시간 선택 옵션 생성 
	    		for (let hour = 0; hour < 25; hour++) {
	                for (let minute = 0; minute < 60; minute += 5) {
	                    let formattedHour = String(hour).padStart(2, '0');
	                    let formattedMinute = String(minute).padStart(2, '0');
	                    
	                 	// 12:00 옵션에 selected 속성 추가
	                    let isSelected = (formattedHour == '12' && formattedMinute == '00') ? ' selected' : '';
	                    
	                    $("#planWriteModal").find(".tripTime")
	                    	.append('<option' + isSelected + '>' + formattedHour + ':' + formattedMinute +'</option>');
	                }
	            }
	            
	            $("#planWriteModal .tripPlaceForm").css("display", "block");
	         	// 상세 내용
				$("#planWriteModal").find(".modal-body .planComment").removeAttr("readonly");
	         	// 전송 버튼
				$("#planWriteModal").find(".modal-footer .modalUpdateBtn").hide();
	            
				$('.modal-backdrop').remove();
	            $("#planWriteModal").modal("show");
         	});
        });
		
		// 일정 수정 - 0. 모달 출력 >> 날짜, 시간, 코멘트
		$(".tripPlanDiv").on('click', '#planWriteModal .modalUpdateBtn', function(){
			// alert("일정 수정");
			
			let pno = $(this).closest(".modal-content").find(".pno").val();
			console.log("pno : " + pno);
			let tripTime = $(this).closest(".modal-content").find(".tripTimeInput").val();
			
			$(this).closest(".planModalsDiv").load("/planAjax/getPlanUpdateForm.do?tno=" + tno + "&pno=" + pno, 
					function(){
				// tno 저장
				$("#planUpdateModal").find(".tno").attr("value", tno);
				// 여행 날짜
				$("#planUpdateModal").find(".tripPeriodBtn").css("pointer-events", "auto");
				$("#planUpdateModal").find(".tripPeriodForm .tripDate").val($(this).closest(".tripPlanDiv")
							.find(".planListBtn").data("tripdate"));
				// 여행 장소
				$("#planUpdateModal").find(".modal-body .tripPlaceForm").css("display", "block");
				
				// 여행 시간 선택 옵션 생성 
	    		for (let hour = 0; hour < 25; hour++) {
	                for (let minute = 0; minute < 60; minute += 5) {
	                    let formattedHour = String(hour).padStart(2, '0');
	                    let formattedMinute = String(minute).padStart(2, '0');
	                    
	                	// 12:00 옵션에 selected 속성 추가
	                    let isSelected = (tripTime == formattedHour + ':' + formattedMinute) ? ' selected' : '';
	                    
	                    $("#planUpdateModal").find(".tripTime")
	                    	.append('<option' + isSelected + '>' + formattedHour + ':' + formattedMinute +'</option>');
	                }
	            }
				
				// 전송 버튼
				$("#planUpdateModal").find(".modal-footer .btn-dark").css("display", "block");
				
				// 모달 표시
				$('.modal-backdrop').remove();
				$("#planUpdateModal").modal("show"); 
			});
		});
	    
		// datePicker 클릭 이벤트
		$(".tripPlanDiv").on("click", ".tripPeriodBtn", function(){
			$("#planUpdateModal").modal("hide");
			
			$(".dateModal").removeClass("modal-xl");
			$(".dateModal").addClass("modal-md");
			$("#datePickerModal .backType").hide();
			$("#datePickerModalLabel strong").text('언제 갈까요?');
			$('.goType i').remove();
			$('.goType b').text('여행 날짜');

			$("#datePickerModal").modal("show");
		});
		
		// 일정 삭제 - 1. 모달 출력
		$(".tripPlanDiv").on('click', '.deleteBtn', function() {
		    // alert('일정 삭제 하기');
		    
		    // pno저장
		    let pno = $(this).closest('.planList').find('.pno').val();
		    console.log('pno : ' + pno);
		    
		    // place
		    let place = $(this).closest(".planList").find(".place").text();
		    console.log("place : " + place);
		    
		    $(this).closest(".planListDiv").siblings(".planModalsDiv")
		    	.load("/planAjax/getPlanWriteForm.do", function() {
		            // form action 지정
		    		$("#planWriteModal").find("form").attr("action", 
		    				"/planAjax/planDelete.do?tno=" + tno + "&pno=" + pno);
		            
		    		// tno 저장
		            $("#planWriteModal").find(".tno").val(tno);
		            // pno 저장
		            $("#planWriteModal").find(".pno").val(pno);
		            
		            // 모달 중앙 배치
		            $("#planWriteModal").find(".modal-dialog").addClass("modal-dialog-centered");
		            // 모달 제목 변경
		            $("#planWriteModal").find(".modal-title").text("일정을 삭제할까요?");
		            // 모달 내용 지우기
		            $("#planWriteModal").find(".modal-body .form-group").remove();
		            
		            // 내용 채우기
		            $("#planWriteModal").find(".modal-body").addClass("text-center")
		                .text("일정을 삭제하면 복구할 수 없습니다. [" + place + "]을(를) 삭제하시겠어요?");
		            
		            $("#planWriteModal").find(".modal-footer .modalUpdateBtn").hide();
		            $("#planWriteModal").find(".modal-footer .modalMultiBtn").removeClass("btn-dark")
		                .addClass("btn-danger").text("remove");
		        
		            $("#planWriteModal").modal("show");
		        });

		});
		
		// .cancelBtn 클릭 이벤트 ---------------------------------------------------
		$(".tripPlanDiv").on("click", ".cancelBtn", function(){
			$(".modal").modal("hide");
			$('.modal-backdrop').remove();
		});
		
		// #datePickerModal 관련 정적 이벤트 ---------------------------------------------------
		$('.tripPeriodBtn').click(function() {
		
			// 새로 오픈 될 때 기존의 도착일 - 출발일 유지
			$("#inputSchedule").val("");
			$('#dateRange').text("도착일" + " ~ " + "출발일");
	        $("#selectedDepartDate").val(startDate);
	        $("#selectedArriveDate").val(endDate);
	
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
		
		//초기값을 도착일(startDate)로 설정해줘야 합니다.
	    $('#departureCalendar').datepicker('setDate', startDate); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		
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
	    
	 	 //초기값을 출발일(endDate)로 설정해줘야 합니다.
	    $('#arrivalCalendar').datepicker('setDate', endDate); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
		
	    // "일정 선택 완료" 버튼 클릭 시 선택된 날짜를 표시
	    $('#confirmDateBtn').click(function() {
	        if ($("#selectedArriveDate").val() != null && $("#selectedArriveDate").val() != "") {
	            $('#dateRange').text($("#selectedDepartDate").val() + " ~ " + $("#selectedArriveDate").val());
		        // tripUpdateModal show
		        $("#tripUpdateModal").find(".tripPeriodForm .tripStartDateInput")
		        	.attr("value", $("#selectedDepartDate").val());
		        $("#tripUpdateModal").find(".tripPeriodForm .tripEndDateInput")
		    		.attr("value", $("#selectedArriveDate").val());
		        $('.modal-backdrop').remove();
		        $('#tripUpdateModal').modal('show');
	        } else { // 방문지(여행지) 수정
	        	$('#planUpdateModal #dateRange').text($("#selectedDepartDate").val());
	            $("#planUpdateModal").find(".tripPeriodForm .tripDate")
	                .attr("value", $("#selectedDepartDate").val());
	            $('#planUpdateModal').modal('show');
	        }
	        // 모달 창 닫기
	        console.log($("#selectedDepartDate").val()  + " ~ " + $("#selectedArriveDate").val());
	        $('#datePickerModal').modal('hide');
	    });
		
	});
</script>

</head>
<body>

<div class="container">

<div class="row" style="margin-top: 30px;">
	<div class="col-md-7"> <!-- 계획 영역 -->
		<div class="tripViewDiv">
			<input type="hidden" value="${vo.tno }" name="tno" class="tno">
			<input type="hidden" value="${vo.cityNum }" name="cityNum" class="cityNum">
			<div class="card themaDiv">
				<div>
					<!-- 리스트로 돌아가기 버튼 -->
					<div class="float-left">
						<div class="mx-3 mt-3 mb-2 tripDetailDiv" onclick="location='list.do'">
							<i class="material-icons" style="font-size:30px;">arrow_back</i>
						</div>
					</div>
					<!-- 여행 계획 수정 & 삭제 버튼 -->
					<div class="float-right">
						<div class="mx-3 mt-3 mb-2 tripDetailDiv" id="tripUpdateDiv">
							<i class="fa fa-gear" style="font-size:30px;"></i>
						</div>
					</div>
				</div>
				<div class="card-body tripContent">
					<h2 class="card-title tripThema">${vo.tripThema }</h2>
					<p class="card-text tripPeriod">
						<!--시작일 / 종료일 저장 -->
						<!--시작일 / 종료일 출력 -->
						<i class="fa fa-calendar-o"></i> 
						<span class="tripStartDateBlock">
							<fmt:formatDate value="${vo.tripStartDate }" pattern="yyyy-MM-dd" />
						</span> → 
						<span class="tripEndDateBlock">
							<fmt:formatDate value="${vo.tripEndDate }" pattern="yyyy-MM-dd" />
						</span>
					</p>
					<p class="card-text tripPlace">
						<i class="fa fa-map-marker"></i> ${vo.countryKor }, ${vo.cityName}
					</p>
				</div>
			</div>
			<div class="commentDiv" style="margin-top:7px;">
				<input type="hidden" class="tripCommentVal" value="${vo.tripComment}">
				<input readonly style="width:100%; border: none; background: transparent;" class="tripComment"
					placeholder="${(!empty vo.tripComment)?vo.tripComment:'어떤 여행인가요? (선택사항)' }">
			</div>
		</div>
		<!-- 일자별 버튼 -->
		<div class="planDateDiv" style="padding:0 10px;"></div>
		<!-- 날짜 리스트 -->
		<div class="tripPlanDiv px-0"></div>
	</div>
	
	<div class="col-md-5"> <!-- 지도 영역 -->
		<div id="map" style="height: 800px; z-index: 0;"></div>
	</div>
</div>
</div> <!-- end of container -->

<!-- start to datepickerModal -->
<jsp:include page="datePickerModal.jsp" />
<!-- end of datepickerModal -->

<!-- start to tripUpdateModal -->
<div class="modal" id="tripUpdateModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">여행 상세 정보 수정</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<form method="post" action="update.do">
				<!-- Modal body -->
				<div class="modal-body">
					<!--사용자 로그인 아이디 -->
					<input type="hidden" value="${login.email }" name="email">
					<!-- 여행 등록 번호 -->
					<input type="hidden" class="tno" name="tno" value="${vo.tno }">
					<!-- 여행 기간 설정 -->
					<div class="form-group tripPeriodForm">
						<label for="tripPeriodBtn">날짜 또는 여행 기간</label>
						<input type="hidden" name="tripStartDate" class="tripStartDateInput">
						<input type="hidden" name="tripEndDate" class="tripEndDateInput">
						<button type="button" class="btn btn-block tripPeriodBtn"
							style="border:1px solid #d1d3e2; text-align: left">
							<span id="dateRange">
								<span class="tripStartDateBlock">
									<fmt:formatDate value="${vo.tripStartDate }" pattern="yyyy-MM-dd" />
								</span> → 
								<span class="tripEndDateBlock">
									<fmt:formatDate value="${vo.tripEndDate }" pattern="yyyy-MM-dd" />
								</span>
							</span>
						</button>
					</div>
					<div class="form-group">
						<label for="tripThema">여행 이름</label>
						<input class="form-control" value="${vo.tripThema }"
							id="tripThema" name="tripThema" required maxlength="80">
					</div>
					<!-- 여행지 검색 구간 -->
					<div class="form-group tripPlaceForm">
						<label for="cityNum">여행지</label>
						<div class="form-control">${vo.countryKor }, ${vo.cityName}</div>
					</div>
					<div class="form-group">
						<label for="tripComment">설명(선택사항)</label>
						<textarea class="form-control" id="tripComment" name="tripComment" maxlength="1000"
							rows="2"></textarea>
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-dark modalMultiBtn" 
						style="width: 80px;">Go</button>
					<button type="button" class="btn btn-outline-secondary cancelBtn" 
						style="width: 80px;" data-dismiss="modal">cancel</button>
				</div>
			</form>
		
		</div>
	</div>
</div>
<!-- end of modal -->

</body>
</html>