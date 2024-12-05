<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<style>
.container {
	max-width: 500px;
	margin: 100px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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

input[type="password"], input[type="hidden"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

button {
	width: 100%;
	padding: 12px;
	background-color: #ff6600;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

button:hover {
	background-color: #e65c00;
}

.btn-cancel {
	background-color: #ccc;
	margin-top: 10px;
}

.btn-cancel:hover {
	background-color: #b3b3b3;
}
</style>

</head>
<body>

	<div class="container">
		<h2>비밀번호 재설정</h2>
		<form action="/member/resetPw.do" method="post">
			<input type="hidden" name="token" value="${token}" />
			<div>
				<label for="pw">새 비밀번호</label> <input type="password" id="pw"
					name="pw" required />
			</div>
			<button type="submit">비밀번호 변경</button>
			<button type="button" class="btn-cancel"
				onclick="window.location.href='/main/main.do'">취소</button>
		</form>
		<div>${msg}</div>
		<!-- 메시지 표시 -->
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
            window.location.href = '/main/main.do'; // 메인 페이지로 리다이렉트
        });

        // 모달이 닫힐 때 리다이렉트
        $('#msgModal').on('hidden.bs.modal', function () {
            window.location.href = '/main/main.do'; // 메인 페이지로 리다이렉트
        });
    });
</script>

</body>
</html>
