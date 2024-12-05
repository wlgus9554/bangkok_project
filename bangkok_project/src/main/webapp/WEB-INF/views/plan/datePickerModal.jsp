<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- start to datePickerModal -->
<div class="modal" id="datePickerModal">
	<div class="modal-dialog modal-xl modal-dialog-centered dateModal"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="datePickerModalLabel">
					<strong>여행 기간이 어떻게 되시나요?</strong>
				</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- 달력이 표시될 곳 -->
				<div class="row ">
					<div class="col goType">
						<div style="text-align: center;" class="mb-2">
							<i class="material-icons mb-0 mr-2"
								style="font-size: 18px; color: #E37027">flight_land</i> <b>
								여행지 도착일</b>
						</div>
						<div id="departureCalendar" class="mb-3"></div>
					</div>
					<div class="col backType">
						<div style="text-align: center;" class="mb-2">
							<i class="material-icons mb-0 mr-2"
								style="font-size: 18px; color: #E37027">flight_takeoff</i> <b>
								여행지 출발일</b>
						</div>
						<div id="arrivalCalendar" class="mb-3"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer align-items-bottom">
				<div class="form-inline">
					<span class="goType"> <label for="selectedDepartDate"
						class="float-left"> <i class="material-icons mb-0 mr-2"
							style="font-size: 18px; color: #E37027">flight_takeoff</i> <b>
								도착일</b>
					</label> <br> <input class="form-control mr-3 mb-3"
						id="selectedDepartDate" placeholder="도착일" readonly>
					</span> <span class="mr-3 backType"> ~ </span> <span class="backType">
						<label for="selectedArriveDate" class="float-left"> <i
							class="material-icons mb-0 mr-2"
							style="font-size: 18px; color: #E37027">flight_land</i> <b>출발일</b>
					</label> <br> <input class="form-control mr-3 mb-3"
						id="selectedArriveDate" placeholder="출발일" readonly>
					</span>
				</div>
				<button type="button" id="confirmDateBtn" class="btn btn-primary">일정
					선택 완료</button>
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- end of datePickerModal -->
