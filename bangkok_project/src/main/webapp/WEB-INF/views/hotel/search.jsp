<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<style type="text/css">
.search-section {
    display: flex;
    justify-content: space-between;
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
}

.search-item {
    flex-grow: 1;
    text-align: center;
    padding: 10px 0;
    color: #555;
    font-size: 14px;
    position: relative;
}

.icon-search, .icon-calendar, .icon-people {
    display: flex;
    align-items: center;
    justify-content: center;
}

.icon-search i, .icon-calendar i, .icon-people i {
    margin-right: 5px;
    font-size: 16px;
    color: #aaa;
}

.search-item:not(:last-child)::after {
    content: '';
    position: absolute;
    right: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 1px;
    height: 30px;
    background-color: #ddd;
}
.search-text {
    margin-left: 8px; /* 아이콘과 텍스트 사이의 간격 */
}
#searchHotel:hover {
	cursor:pointer;
	border:1px solid #E37027 !important;
	border-radius: 10px;
}
</style>
<script type="text/javascript">
$(function() {
    $(".checkBtn").click(function() {
        let search = $("#searchInput").val();
        $(".search-text").text(search);
        $('#HotelSearchModal').modal('hide');
        $("#searchInput").val("");
        
        let searcha = $(".search-text").text();
        //console.log(searcha);
        
        // 수정된 부분: 올바르게 입력 필드에 값 설정
        $("#searchHotels").val(searcha);
        
        // 확인 출력
		//console.log($("#searchHotels").val());
    });
    $("#enter").click(function(){
    	$(".formTest").submit();
    });
});
</script>


<jsp:include page="allModal.jsp"/>
     <span class="icon-search col-md-4" id="searchHotel" style="width: 300px;"data-toggle="modal" 
	data-target="#HotelSearchModal" >
       <i class="fas fa-search mySearch" style="margin-right: 8px;"><span class="search-text">여행지나 숙소를 검색해보세요.</span></i> 
      </span>
	<span class="d-flex align-items-center col-md-3" id="inputDate" data-toggle="modal" 
	data-target="#datePickerModal">
	<i class="material-icons mr-3" style="font-size:22px">date_range</i> 
	<b><span id="dateRange">체크인 ~ 체크아웃</span></b>
	</span>
	<span class="d-flex align-items-center col-md-3" id="passenger" data-toggle="modal" data-target="#personModal">
    <i class="fa fa-user mr-3" style="font-size:24px"></i> 
    <b><span id="totalPassenger">총 1명</span></b>
	</span>
	<span class="col-md">
	<button class="btn btn-primary" id="enter" style="width: 150px; height: 50px;">검색</button>
	</span>
	<form action="/hotel/list.do" class="formTest">
	<input id="searchHotels" name="searchHotel" type="hidden">
	<input id="checkIns" name="checkIn" type="hidden">
	<input id="checkOuts"name="checkOut" type="hidden">
	<input id="checkPeople" name="checkPeople" type="hidden">
	</form>


<!-- 모달 -->
<div class="modal fade" id="HotelSearchModal" tabindex="-1" role="dialog" aria-labelledby="HotelSearchLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="border-radius: 10px;">
            <!-- 모달 헤더 -->
            <div class="modal-header" style="background-color: #ffa500; color: white; text-align: center; border-top-left-radius: 10px; border-top-right-radius: 10px;">
                <h5 class="modal-title" id="HotelSearchLabel" style="font-weight: 700;">호텔 검색</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white;">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <!-- 모달 바디 -->
            <div class="modal-body" style="text-align: left; padding: 20px;">
                <input type="text" class="form-control" id="searchInput" placeholder="여행지나 숙소를 검색하세요..." style="height: 45px; font-size: 1.1rem; font-weight: 500;"/>
            </div>

            <!-- 모달 푸터 -->
            <div class="modal-footer" style="justify-content: space-between; padding: 10px 20px;">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" style="width: 100px;">취소</button>
                <button type="button" class="btn btn-primary checkBtn" style="background-color: #ff8c00; border-color: #ff8c00; width: 100px;">확인</button>
            </div>
        </div>
    </div>
</div>
