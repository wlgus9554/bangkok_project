<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<script type="text/javascript">
	$(function(){
		// 등록란 커서 위치에 따른 버튼 보이기
		$('.replyWriteForm input[name="r_content"]').focus(function(){
			$(this).closest('.media-body')
				.find(".btnDiv-h").css("display", "block");
        }).focusout(function(){
        	$(this).closest('.media-body')
        		.find(".btnDiv-h").css("display", "none");
        });
		
		// 수정 / 삭제 버튼 생성
		$('.fa.fa-ellipsis-h').click(function(){
		    $(this).closest('.media-body').find(".btnDiv-h").toggle(); // 버튼의 보임/숨김을 토글합니다.
		});
		
		// 폼 제출 시 처리
        $('.replyWriteForm form').submit(function(event){
            // 여기서 추가적인 유효성 검사를 할 수 있습니다.
            // 예: 빈 내용 체크
            if ($(this).find('input[name="r_content"]').val().trim() == "") {
                event.preventDefault(); // 기본 제출 방지
                // alert("댓글 내용을 입력하세요."); // 경고 메시지
                return false;
            }
            // 폼이 제출되면 버튼 숨기기
            $('.btnDiv-h').css("display", "none");
        });
		
		// 수정 폼 출력
		$(".replyUpdateBtn").click(function(){
			$("#replyFormModal").find(".modal-title").text("댓글 수정");
			
			$("#replyFormModal").find(".rno")
				.attr("value", $(this).closest(".media-body").find(".card .rno").val());
			
			$("#replyFormModal").find(".form-control")
				.attr("value", $(this).closest(".media-body").find(".card-body").text());
			
			$("#replyFormModal").find("form").attr("action", "/tripReplyAjax/update.do");
			
			$("#replyFormModal").modal("show");
		});
		
		// 삭제 폼 출력
		$(".replyDeleteBtn").click(function(){
			// 모달 제목 변경
			$("#replyFormModal").find(".modal-title").text("댓글 삭제");
			// action 위치 지정
			$("#replyFormModal").find("form").attr("action", "/tripReplyAjax/delete.do");
			
			// 삭제할 데이터 저장하기 - 댓글 번호(rno)
			$("#replyFormModal").find(".rno")
				.attr("value", $(this).closest(".media-body").find(".card .rno").val());
			
			// 기존 모달 내용 지우기
			$("#replyFormModal").find(".card").remove();
			// 새로 채우기
			$("#replyFormModal").find(".modal-body").text("댓글을 삭제하시면 복원할 수 없습니다. 댓글을 삭제하시겠습니까?");
			
			$("#replyFormModal").find(".replyBtn").removeClass("btn-dark")
				.addClass("btn-danger").text("remove");
			
			$("#replyFormModal").modal("show");
		});
	});
</script>
</head>

<body>
<div class="replyWriteForm">
<form action="/tripReplyAjax/write.do" method="post">
	<div class="media p-3" style="border-bottom: 1px solid #e0e0e0">
		<img src="${login.photo }" alt="userPhoto" class="mr-3 mt-3 rounded-circle" style="width:60px;">
		<div class="media-body">
			<c:if test="${!empty login}">
				<input type="hidden" name="email" value="${login.email }">
				<input type="hidden" name="no" value="${param.no }">
				<div class="userInfo">
					<p style="margin:0 8px 8px 0;">
						${login.nickName }
					</p> 
				</div>
			</c:if>
			<div class="card form-group p-0">
				<input class='card-body form-control border-0' name="r_content" style="height: 56px;">
			</div>
			<div class='btnDiv-h btn-group float-right' style="display: none;">
				<button class="btn btn-sm btn-dark">reply</button>
				<button type="button" class="btn btn-sm" style="border:1px solid #858796;">cancel</button>
			</div>
		</div>
	</div>
</form>
</div>
<c:if test="${empty replyList }">
	<div class="alert alert-secondary">
		아직 댓글이 없습니다.
	</div>
</c:if>
<c:if test="${!empty replyList }">
<c:forEach items="${replyList }" var="rvo">
	<div class="media p-3" style="border-bottom: 1px solid #e0e0e0">
		<img src="${vo.photo }" alt="userPhoto" class="mr-3 mt-3 rounded-circle" style="width:60px;">
		<div class="media-body">
			<div class="userInfo">
				<p style="margin:0 8px 8px 0;">
					${rvo.nickName }
					<c:if test="${login.email == rvo.email }">
						<i class="fa fa-ellipsis-h float-right"></i>
					</c:if>
				</p> 
			</div>
			<div class="card" style="min-width: 703px;">
				<input type="hidden" name="rno" class="rno" value="${rvo.rno }">
				<div class="card-body">${rvo.r_content }</div>
			</div>
			<div class='btnDiv-h btn-group float-right' style="display: none;">
				<button type="button" class="btn btn-sm btn-dark m-1 replyUpdateBtn">update</button>
				<button type="button" class="btn btn-sm btn-danger my-1 replyDeleteBtn">delete</button>
			</div>
		</div>
	</div>
</c:forEach>
</c:if>

<div class="modal" id="replyFormModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">Modal Heading</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<form method="post">
			<input type="hidden" name="no" class="no" value="${param.no }">
			<input type="hidden" name="rno" class="rno">
			<input type="hidden" name="email" value="${login.email }">
			<div class="modal-body">
				<div class="card form-group p-0">
					<input class='card-body form-control border-0' name="r_content" style="height: 56px;">
				</div>
			</div>
			
			<!-- Modal footer -->
			<div class="modal-footer">
				<div class='replyBtnDiv-h btn-group float-right'>
					<button class="btn btn-sm btn-dark m-1 replyBtn">update</button>
					<button type="button" class="btn btn-sm my-1" style="border:1px solid #858796;"
						data-dismiss="modal">cancel</button>
				</div>
			</div>
			</form>
			
		</div>
	</div>
</div>

</body>
