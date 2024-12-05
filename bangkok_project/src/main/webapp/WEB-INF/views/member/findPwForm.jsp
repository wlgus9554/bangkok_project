<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<style>
.pwContainer {
	max-width: 500px;
	margin: 100px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	font-family: 'goorm-sans-code';
}

h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

label {
	display: block;
	margin-bottom: 10px;
	font-weight: bold;
	color: #555;
}

input[type="text"], input[type="email"], input[type="tel"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

.pwBtn {
	width: 100%;
	padding: 12px;
	background-color: #ff6600;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

.pwBtn:hover {
	background-color: #e65c00;
}

#pwBtnCancle {
	background-color: #ccc !important; /* 우선순위를 높임 */
	color: black; /* 텍스트 색상 */
	border: none; /* 기본 테두리 제거 */
	border-radius: 5px; /* 모서리 둥글게 */
	padding: 10px; /* 여백 */
	cursor: pointer; /* 커서 모양 변경 */
	margin-top: 10px; /* 상단 여백 추가 */
	width: 100%; /* 너비 100% */
}

#pwBtnCancle:hover {
	background-color: #b3b3b3 !important; /* hover 상태 색상 */
}
</style>
</head>
<body>
	<div class="container pwContainer">
		<h2>비밀번호 찾기</h2>
		<form action="/member/findPw.do" method="post">
			<div>
				<label for="name">이름</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div>
				<label for="email">이메일</label> <input type="email" id="email"
					name="email" required>
			</div>
			<div>
				<label for="tel">전화번호</label> <input type="text" id="tel" name="tel"
					required>
			</div>
			<button type="submit" class="pwBtn">비밀번호 찾기</button>
			<button type="button" class="btn-cancel" id="pwBtnCancle"
				onclick="window.location.href='/main/main.do'">취소</button>
		</form>
		<div>${msg}</div>
		<!-- 결과 메시지 표시 -->
	</div>
	<!-- 모달 코드 -->
	<div class="modal fade" id="msgModal" tabindex="-1" role="dialog"
		aria-labelledby="msgModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<p id="modalMessage">${msg}</p>
					<!-- 메시지를 여기에 출력 -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modalCloseButton">확인</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			var msg = "${msg}"; // JSP에서 전달된 메시지
			if (msg) {
				$('#msgModal').modal('show'); // 모달 표시
			}

			// 모달 확인 버튼 클릭 시 리다이렉트
			$('#modalCloseButton').on('click', function() {
				window.location.href = '/member/findPwForm.do'; // 메인 페이지로 리다이렉트
			});
		});
	</script>
</body>
</html>

