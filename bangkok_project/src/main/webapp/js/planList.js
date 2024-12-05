/**
 * 방문지 게시판 객체 생성 by. javascript
 */
 
 $(function(){
 	// 기간에 따른 버튼 만들기 ------------------------------------------
	// 문자열을 Date 객체로 변환
	let startDateObj = new Date(startDate);
	let endDateObj = new Date(endDate);
	
	// 날짜 배열 초기화
	let dateArray = [];

	// 날짜를 순회하여 배열에 추가
	for (let date = startDateObj; date <= endDateObj; date.setDate(date.getDate() + 1)) {
	    // 각 날짜를 'YYYY-MM-DD' 형식으로 포맷팅
	    let formattedDate = date.toISOString().split('T')[0];
	    dateArray.push(formattedDate);
	}
	
	// alert(dateArray); // 결과: 날짜 배열 출력
	// 날짜 배열을 반복하며 버튼 생성
	dateArray.forEach((date, index) => {
		
		let planDateBtn = '';
		planDateBtn += '<div class="btn-group planDateBtn">';
		planDateBtn += '<button type="button" class="btn btn-outline-dark tripDateBtn mr-2" ';
		planDateBtn += 'style="border-radius: 30px;">' + (index + 1) + '일차</button>';
		planDateBtn += '</div>';
		
		$(".planDateDiv").append(planDateBtn);
		
		// 날짜별 버튼
		let planListBtn = '';
		planListBtn += '<div class="planListDiv">';
		planListBtn += '<button type="button" class="btn planListBtn my-1"' 
			+ 'data-tripdate="' + date + '" style="width: 100%;">';
		planListBtn += '<h4 class="card-title text-left tripDate mb-0">';
		planListBtn += date;
		planListBtn += '<span class="float-right"><i class="fa fa-angle-down"></i></span>';
		planListBtn += '</h4>';
		planListBtn += '</button>';
		
		let tripPlanList = '<div class="tripPlanList"></div>';
		
		// 방문지 추가 버튼
		let planWriteBtn = '';
		planWriteBtn += '<div class="row">';
		planWriteBtn += '<div class="col-sm-1" style="padding-left: 0;">';
		planWriteBtn += '<div class="bg-dark text-white" ';
		planWriteBtn += 'style="width:20px; height: 20px; margin: 0 auto; border-radius: 50px; font-weight: bolder; ';
		planWriteBtn += 'font-size:13px; text-align: center;"><i class="fa fa-map-marker"></i></div>';
		planWriteBtn += '<div style="border-right:1px solid #343a40; width: 0; height: 83px; margin: 0 auto;"></div>';
		planWriteBtn += '</div>';
		planWriteBtn += '<div class="col-sm-11" style="padding-left: 0;">';
		planWriteBtn += '<button class="btn btn-outline-dark btn-block planWriteBtn" ';
		planWriteBtn += 'style="margin: 30px 0; padding: 15px 10px; font-size: 17px; border:1px dashed #343a40;">';
		planWriteBtn += '<i class="fa fa-plus"></i> 장소 추가';
		planWriteBtn += '</button>';
		planWriteBtn += '</div>';
		planWriteBtn += '</div>';
		planWriteBtn += '</div>'; // end of .planListDiv

		$(".tripPlanDiv").append('<div>' + planListBtn + tripPlanList + planWriteBtn 
			+ '<div class="planModalsDiv"></div>' + '</div>');

		let nowTripPlanList = $(".tripPlanDiv").children().last().find(".tripPlanList");

		// 일정 리스트 출력
		nowTripPlanList.load("/planAjax/getPlanList.do?tno=" + tno + "&tripDate=" + date);
		
		console.log("주소 : " + "/planAjax/getPlanList.do?tno=" + tno + "&tripDate=" + date);

	});
	
 });