<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 리스트</title>
<style type="text/css">
#back:hover{
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function(){
	//orderStateRadio 바꿀때 마다 폼 submit
	$(".orderStateRadio").change(function() {
		$(this).submit();
	});
	$("#back").click(function(){
		location = "list.do";
	});
	// perPageNum 처리
	$("#perPageNum").change(function() {
		//alert("change perPageNum");
		// page는 1페이지 + 검색 데이터 전부 보낸다.
		$("#search").submit();
	});
	//일괄 수정 버튼에 마우스 올렸을때 popover등장
	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip();   
	});	
	// perPageNum 처리
	$("#perPageNum").change(function(){
		// alert("change perPageNum");
		// page는 1페이지 + 검색 데이터를 전부 보낸다.
		$("#searchForm").submit();
	});
	
	// 검색 데이터 세팅
	$("#key").val('${(empty pageObject.key)?"n":pageObject.key}');
	// perPageNum 세팅
	$("#perPageNum")
	.val('${(empty pageObject.perPageNum)?"10":pageObject.perPageNum}');
	
});
</script>
</head>
<body>
<div class="container">
<i class="material-icons" style="font-size:30px" id="back">arrow_back </i>
<form action="adminList.do" id="searchForm">
<input name="page" value="1" type="hidden">
  <div class="row">
  	<div class="col-md-8">
  		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		      <select name="key" id="key" class="form-control">
		      	<option value="n">이름</option>
		      	<option value="t">연락처</option>
		      	<option value="mt">결제 수단</option>
		      	<option value="ty">결제 방식</option>
		      	<option value="hn">호텔 이름</option>
		      	<option value="rn">객실 이름</option>
		      	<option value="ntmttyhnrn">모두</option>
		      </select>
		  </div>
		  <input type="text" class="form-control" placeholder="검색"
		   id="word" name="word" value="${pageObject.word }">
	  <div class="input-group-append">
	      <button class="btn btn-outline-primary">
	      	<i class="fa fa-search"></i>
	      </button>
	  </div>
	</div>
 	</div>
	  	<div class="col-md-4">
			  		<!-- 너비를 조정하기 위한 div 추가. float-right : 오른쪽 정렬 -->
			  		<div style="width: 200px;" class="float-right">
					  <div class="input-group mb-3">
					    <div class="input-group-prepend">
					      <span class="input-group-text">Rows/Page</span>
					    </div>
					    <select id="perPageNum" name="perPageNum" class="form-control">
					    	<option>10</option>
					    	<option>15</option>
					    	<option>20</option>
					    	<option>25</option>
					    </select>
					  </div>
				  </div>
			  	</div>
			 </div>
			</form>
<div class="row">
	<div class="col-6">
		<!-- 주문 상태에 의한 정렬을 보내주는 폼 -->
		<form class="orderStateRadio mb-3 float-right" action="adminList.do">				
			<div class="custom-control custom-radio custom-control-inline">		  
				<input type="radio" class="custom-control-input" id="all" name="optList" value="">  	
		    	<label class="custom-control-label" for="all">
		    		모두
		    	</label>
		  	</div>						
			<div class="custom-control custom-radio custom-control-inline">		  
				<input type="radio" class="custom-control-input" id="ordCopm" name="optList" value="예약 완료">  	
		    	<label class="custom-control-label" for="ordCopm">
		    		예약 완료
		    	</label>
		  	</div>
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="stdBy" name="optList" value="예약 취소">
		    	<label class="custom-control-label" for="stdBy">예약 취소</label>
		  	</div>
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="ing" name="optList" value="입실 전">
		    	<label class="custom-control-label" for="ing">입실 전</label>
		  	</div>
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="comp" name="optList" value="미입실">
		    	<label class="custom-control-label" for="comp">미입실</label>
		  	</div>		
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="cu" name="optList" value="퇴실 완료">
		    	<label class="custom-control-label" for="cu">퇴실 완료</label>
		  	</div>		
		  	<!-- 페이지 정보 넘기기 -->
		  	<input type="hidden" name="key" value="${param.key }">
		  	<input type="hidden" name="word" value="${param.word }">
		  	<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		</form>	
	</div>				  		
</div>	

<!-- 여기에 원하는 테이블이나 내용을 추가하세요 -->
<table class="table" style="font-size: 13.5px;">
	<thead>
		<tr>
			<th>예약 번호</th>
			<th>이름</th>
			<th>연락처</th>
			<th>예약자 정보</th>
			<th>가격</th>
			<th>예약 상태</th>
			<th>결제 방식</th>
			<th>결제 수단</th>
			<th>호텔 이름</th>
			<th>객실 이름</th>
			<th>인원 수</th>
		</tr>
	</thead>
		<c:forEach items="${busy }" var="vo">
	<tbody>
		<tr>
			<td>${vo.reservation_no }</td>
			<td>${vo.name }</td>
			<td>${vo.tel }</td>
			<td>${vo.name }</td>
			<td>${vo.price }</td>
			<td>
				<form action="changeStatus.do" method="post">
				<input name="reservation_no" value="${vo.reservation_no}" type="hidden">
				<div class="input-group mb-4">
			    <select class="form-control" name="paymentStatus">
					<option value="예약 취소"  ${(vo.paymentStatus=='예약 취소')?"selected":""}>예약 취소</option>
					<option value="예약 완료"  ${(vo.paymentStatus=='예약 완료')?"selected":""}>예약 완료</option>
					<option value="입실 전" ${(vo.paymentStatus=='입실 전')?"selected":""}>입실 전</option>
					<option value="퇴실 완료" ${(vo.paymentStatus=='퇴실 완료')?"selected":""}>퇴실 완료</option>
					<option value="미입실" ${(vo.paymentStatus=='미입실')?"selected":""}>미입실</option>
			       </select>
			    <div class="input-group-append">
				    <button class="btn btn-outline-primary" type="submit">변경</button>
				  </div>
				  </div>
				  </form>
			</td>
			<td>${vo.paymentMethod }</td>
			<td>${vo.payment_Type }</td>
			<td>${vo.title }</td>
			<td>${vo.room_type }</td>
			<td>${vo.people }</td>
		</tr>
	</tbody>
		</c:forEach>
</table>
	<div class="pagination justify-content-center">
		<pageNav:pageNav listURI="adminList.do" pageObject="${pageObject }"></pageNav:pageNav>
	</div>		

</div>
</body>
</html>