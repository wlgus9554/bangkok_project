<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편의시설</title>

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f8f9fa;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

h2 {
	color: #333;
	font-weight: bold;
	margin-bottom: 30px;
}

.amenities-card {
	background-color: #fff;
	border: none;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.amenities-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
}

.amenities-card h4 {
	color: #000; /* 글씨 색상을 검정색으로 변경 */
	font-size: 1.25rem;
	font-weight: 600;
	margin-bottom: 10px;
}

.amenities-card p {
	color: #666;
	font-size: 0.95rem;
	margin-bottom: 15px;
}

.amenities-card button {
	font-size: 0.875rem;
	margin-right: 10px;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-danger:hover {
	background-color: #c82333;
}

#addCategoryBtn {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	font-size: 1.5rem;
	color: #28a745;
	cursor: pointer;
	border: none;
	background: none;
	padding: 0;
}

#addCategoryBtn:hover {
	color: #218838;
}

.custom-switch {
	margin-bottom: 20px;
}

.modal-header {
	background-color: #007bff;
	color: white;
	border-bottom: none;
}

.modal-footer {
	border-top: none;
}
.btn-update {
    background-color: #ff8533; /* 수정 버튼 배경 색상 */
    border-color: #ff8533; /* 수정 버튼 테두리 색상 */
    color: #fff; /* 수정 버튼 텍스트 색상 */
}

.btn-update:hover {
    background-color: #e27a2f; /* 수정 버튼 호버 시 색상 */
    border-color: #e27a2f; /* 수정 버튼 호버 시 테두리 색상 */
}
.btn-modal {
    background-color: #ff8533; /* 수정 버튼 배경 색상 */
    border-color: #ff8533; /* 수정 버튼 테두리 색상 */
    color: #fff; /* 수정 버튼 텍스트 색상 */
}

.btn-modal:hover {
    background-color: #e27a2f; /* 수정 버튼 호버 시 색상 */
    border-color: #e27a2f; /* 수정 버튼 호버 시 테두리 색상 */
}
</style>

<script type="text/javascript">
	$(function() {
	    if (window.location.pathname === "/amenities/list.do") {
	        $("#switch1").prop("checked", true);
	    }

	    $("#switch1").change(function() {
	        if (!$(this).is(":checked")) {
	            location.href = "/hotel/list.do";
	        }
	    });

	    $("#addCategoryBtn").click(function() {
	        openModal("편의시설 추가", 0, "", "write.do", "추가");
	    });

	    $(".updateBtn").click(function() {
	        let amenitiesCard = $(this).closest(".amenities-card");
	        let amenitiesNo = amenitiesCard.find("h4").data("amenitiesNo");
	        let amenitiesName = amenitiesCard.find("h4").text().trim();

	        return openModal("편의시설 수정", amenitiesNo, amenitiesName, "update.do", "수정");
	    });

	    $(".deleteBtn").click(function() {
	        let amenitiesCard = $(this).closest(".amenities-card");
	        let amenitiesNo = amenitiesCard.find("h4").data("amenitiesNo");
	        let amenitiesName = amenitiesCard.find("h4").text().trim();

	        return openModal("편의시설 삭제", amenitiesNo, amenitiesName, "delete.do", "삭제");
	    });

	    $(".btn-secondary").click(function() {
	        $("#categoryModal").modal("hide");
	    });

	    function openModal(title, amenitiesNo, amenitiesName, url, btnName) {
	        $("#categoryModal .modal-title").text(title);
	        $("#modalAmenitiesNo").val(amenitiesNo);
	        $("#modalAmenitiesName").val(amenitiesName);
	        $("#modalForm").attr("action", url);
	        $("#submitBtn").text(btnName);
	        $("#categoryModal").modal("show");

	        return false;
	    }
	});
</script>

</head>
<body>
	<div class="container">
		<div class="custom-control custom-switch">
			<input type="checkbox" class="custom-control-input" id="switch1">
			<label class="custom-control-label" for="switch1">Hotel List</label>
		</div>

		<!-- 페이지 상단: 편의시설 리스트 -->
		<div class="row">
			<div class="col-12 d-flex justify-content-between align-items-center">
				<h2>편의시설 리스트</h2>
				<button class="btn" id="addCategoryBtn"><i class="fa fa-plus"></i></button>
			</div>
		</div>

		<div class="row">
			<c:forEach items="${list }" var="vo">
				<div class="col-md-4">
					<div class="amenities-card">
						<h4 class="card-title" data-amenities-no="${vo.amenitiesNo}">${vo.amenitiesName}</h4>
						<p><strong>번호:</strong> ${vo.amenitiesNo }</p>
						<button class="btn btn-update btn-sm updateBtn">수정</button>
						<button class="btn btn-danger btn-sm deleteBtn">삭제</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 카테고리 추가 모달 -->
	<div class="modal fade" id="categoryModal" tabindex="-1"
		aria-labelledby="categoryModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- 모달 헤더 -->
				<div class="modal-header" style="background-color: #ff8533;">
					<h5 class="modal-title" id="categoryModalLabel">편의시설 추가</h5>
				</div>

				<!-- 모달 폼 -->
				<form method="post" id="modalForm">
					<input type="hidden" name="amenitiesNo" id="modalAmenitiesNo" value="0">

					<!-- 모달 바디 -->
					<div class="modal-body">
						<div class="mb-3">
							<label for="modalAmenitiesName" class="form-label">편의시설명</label>
							<input type="text" class="form-control" name="amenitiesName"
								id="modalAmenitiesName" required>
						</div>
					</div>

					<!-- 모달 풋터 -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-modal" id="submitBtn" style="background-color: #ff8533;">추가</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
