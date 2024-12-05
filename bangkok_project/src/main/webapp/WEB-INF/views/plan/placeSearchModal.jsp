<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<script type="text/javascript">
$(function(){
	$("#perPageNum").change(function(){
        $("#searchForm").submit();
    });

    $("#key").val("${(empty pageObject.key) ? 't' : pageObject.key}");
    $("#perPageNum").val("${(empty pageObject.perPageNum) ? '10' : pageObject.perPageNum}");
});
</script>

<div class="modal" id="placeSearchModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">어디를 가볼까요?</h4>
				<button type="button" class="close cancelBtn" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
			<!-- 검색 리스트 -->
			<form action="/cityPlaceAjax/getPlaceList.do" id="searchForm">
			    <input name="page" value="1" type="hidden">
			    <div class="row">
			        <div class="col-md-12">
			            <div class="input-group mb-3">
			                <input type="text" class="form-control" placeholder="검색" id="word" name="word" value="${pageObject.word}">
			                <div class="input-group-append">
			                    <button class="btn" type="button" 
			                    	style="border:1px solid #ced4da; border-left:0px; color:#cccccc; padding: 0 20px;">
			                        <i class="fa fa-search"></i>
			                    </button>
			                </div>
			            </div>
			        </div>
			    </div>
			</form>
			
			<c:if test="${empty placeList}">
			<div class="jumbotron">
			    <h3>Data does not exist.</h3>
			</div>
			</c:if>
			
			<c:if test="${!empty placeList}">
			<c:forEach items="${placeList}" var="vo">
				<div class="dataRow pr-0" data-no="${vo.no }">
					<div class="card placeCard" style="height:80px;">
						<div class="card-body" style="padding:10px;">
							<div class="img-thumbnail float-left">
								<img src="${vo.imageFile}" alt="placeImg" width="50" height="50">
							</div>
							<div class="float-left" 
								style="width: 60%; margin-left: 10px;">
								<p class="cityName" style="font-weight:bold; font-size:15px;">
									<span class="place">${vo.place}</span>, <br>
									<span class="cityName">${vo.cityname}</span>
								</p>
							</div>
						</div>
					</div>
			    </div>
			</c:forEach>
			</c:if>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary cancelBtn" 
					style="width: 80px;" data-dismiss="modal">cancel</button>
			</div>
		
		</div>
	</div>
</div>