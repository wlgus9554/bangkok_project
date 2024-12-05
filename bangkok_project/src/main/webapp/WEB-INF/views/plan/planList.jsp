<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<head>
<style type="text/css">
.btnDiv-v {
	margin: 10px 0;
	position: absolute;
	z-index: 1;
}
</style>
<script type="text/javascript">
$(function(){
	$(".btnDiv-v").hide();
});
</script>
</head>

<body>
<c:forEach items="${planDetailList }" var="vo">
	<div class="row">
	<!-- 일정 순서 아이콘 -->
	<div class="col-sm-1" style="padding-left: 0;">
		<div class="bg-dark text-white" 
			style="width:20px; height: 20px; margin: 0 auto; border-radius: 50px; font-weight: bolder;
			font-size:13px; text-align: center;"><i class="fa fa-map-marker"></i></div>
		<div style="border-right:1px solid #343a40; width: 0; height: 100%; margin: 0 auto;"></div>
	</div>
	<!--일정 리스트 -->
	<div class="col-sm-11" style="padding-left: 0;">
	<b>${vo.tripTime}</b>
	<div class="card mt-2 mb-3" style="height: 130px;">
		<div class="card-body planList" style="padding: 10px;">
			<div class="placeInfo">
				<input type="hidden" value="${vo.tripDate }" class="tripDate" name="tripDate">
				<input type="hidden" value="${vo.pno }" class="pno" name="pno">
				<!-- 여행지 사진 div -->
				<div class="img-thumbnail float-left">
					<img src="${vo.imageFile }" alt="placeImg" width="100" height="100">
				</div>
				<div class="float-left tripPlace"
					style="width: 70%; margin-left: 10px; padding-top:10px;">
					<p  style="font-weight:bold; font-size:15px;">${vo.cate_name}</p>
					<p class="place" style="font-weight:bold; font-size:15px;">${vo.place}</p>
				</div>
			</div>
			<div class="deleteBtn">
				<p class="m-0">
					<i class="fa fa-ellipsis-v"></i>
				</p>
			</div>
		</div>
		<div class="btnDiv-v btn-group btn-group-sm float-right">
			<button class="btn btn-sm btn-dark m-2 updateBtn">수정</button>
			<button class="btn btn-sm btn-danger my-2 removeBtn">삭제</button>
		</div>
	</div> <!-- end of .card -->
	</div> <!-- end of .col-md-11 -->
	</div> <!-- end of row -->
</c:forEach>

</body>