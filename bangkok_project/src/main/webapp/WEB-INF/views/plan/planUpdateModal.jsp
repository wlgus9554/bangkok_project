<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal" id="planUpdateModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">일정 수정하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<form method="post" action="/planAjax/planUpdate.do">
				<input name="tno" class="tno" type="hidden">
				<input value="${vo.pno }" name="pno" class="pno" type="hidden">
				<div class="modal-body">
					<!-- 여행지 사진 -->
					<div class="form-group placeImage">
						<div class="img-thumbnail form-control" style="width:100%; height: 60%;">
							<img src="${vo.imageFile }" alt="placeImg" width="100%" height="100%">
						</div>
					</div>
					<div class="form-group tripPeriodForm">
						<label for="tripDate">여행 날짜</label>
						<input type="hidden" name="tripDate" class="tripDate" value="${vo.tripDate }">
						<div class="btn btn-block tripPeriodBtn" 
							style="border:1px solid #d1d3e2; text-align: left; padding:6px 12px; pointer-events: none;">
							<span id="dateRange">
								<fmt:formatDate value="${vo.tripDate }" pattern="yyyy-MM-dd"/>
							</span>
						</div>
					</div>
					<div class="form-group tripPlaceForm" style="display: none;">
						<label for="no">여행 장소</label>
						<input type="hidden" name="no" class="noInput" value="${vo.no }">
						<div class="btn btn-block placeSearchBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							${vo.place}
						</div>
					</div>
					<div class="form-group tripTimeForm">
						<label for="tripTime">여행 시간</label>
						<input class="form-control tripTimeInput" placeholder="${vo.tripTime}" 
							readonly style="background: transparent; display: none;">
						<div class="row tripTimeBlock">
							<div class="col-12">
								<select name="tripTime"
									class="custom-select tripTime" style="width: 100%">
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for=planComment>상세 내용</label>
						<input class="form-control planComment" 
							placeholder="${(!empty vo.planComment)?vo.planComment:'상세 정보를 추가해 보세요.' }"
							style="background: transparent;" name="planComment">
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button class="btn btn-dark modalUpdateBtn">Update</button>
					<button type="button" class="btn cancelBtn"
						data-dismiss="modal">cancel</button>
				</div>
			</form>
		</div>
	</div>
</div>
