<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보 수정</title>
<style>
body {
	font-family: 'goorm-sans-code';
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.container {
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center; /* 모든 내용을 중앙 정렬 */
}

.btn-group {
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 가운데 정렬 */
	max-width: 20%; /* 원하는 너비 설정 */
	margin: 0 auto; /* 가로 중앙 정렬 */
}

h2 {
	text-align: center;
	margin-bottom: 30px;
	color: #333;
}

/* 프로필 사진 */
.profile-img {
	display: block;
	margin: 0 auto;
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 50%; /* 원형 이미지로 만들기 */
	border: 4px solid #ddd;
	cursor: pointer; /* 클릭 가능하게 커서 변경 */
}

#fileInput {
	display: none; /* 파일 입력 숨기기 */
}

/* 정보 그리드 */
.info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr; /* 2열 그리드 */
	gap: 20px;
	margin-top: 20px;
}

.info-grid div {
	padding: 15px;
	background-color: #f9f9f9;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.info-grid div label {
	font-weight: bold;
	display: block;
	margin-bottom: 5px;
	color: #555;
}

.info-grid div input {
	width: 100%;
	padding: 8px;
	box-sizing: border-box;
	border-radius: 5px;
	border: 1px solid #ddd;
	font-size: 16px;
}

.info-grid div span {
	display: block;
	font-size: 16px;
	color: #333;
}

/* 버튼 중앙 배치 */
.btn-group {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.btn-group form {
	margin: 0 10px;
}

/* 반응형 미디어 쿼리 */
@media ( max-width : 768px) {
	.info-grid {
		grid-template-columns: 1fr; /* 1열로 변경 */
	}
}
/* 스타일링을 위한 CSS 클래스 예시 */
.input-field {
	margin-right: 10px;
}

.check-button {
	width: 30%;
	margin-right: 5px;
}

.result-message {
	margin-top: 10px;
}
</style>
<script>
	function triggerFileInput() {
		document.getElementById('fileInput').click();
	}

	function previewImage(event) {
		const reader = new FileReader();
		reader.onload = function() {
			const output = document.getElementById('profileImage');
			output.src = reader.result;
		}
		reader.readAsDataURL(event.target.files[0]);
	}

	function checkNickname() {
		const nickName = document.querySelector('input[name="nickName"]').value;

		$.ajax({
			type : "POST",
			url : "/ajax/checkNickName",
			data : {
				nickName : nickName
			},
			dataType : "json",
			success : function(response) {
				const resultDiv = document.getElementById('unameResult');
				const updateBtn = document.getElementById('updateBtn'); // 수정 버튼

				if (response) { // 닉네임이 중복된 경우
					resultDiv.textContent = "닉네임 사용 불가능";
					resultDiv.style.color = 'red';
					updateBtn.disabled = true; // 수정 버튼 비활성화
				} else { // 닉네임 사용 가능한 경우
					resultDiv.textContent = "닉네임 사용 가능";
					resultDiv.style.color = 'green';
					updateBtn.disabled = false; // 수정 버튼 활성화
				}
			},
			error : function(xhr, status, error) {
				console.error("AJAX 요청 오류:", status, error);
				const resultDiv = document.getElementById('unameResult');
				resultDiv.textContent = "닉네임 확인 중 오류가 발생했습니다.";
				resultDiv.style.color = 'orange';

				const updateBtn = document.getElementById('updateBtn'); // 오류 발생 시 버튼 비활성화
				updateBtn.disabled = true;
			}
		});
	}

	$(document)
			.ready(
					function() {
						$('form')
								.submit(
										function(event) {
											event.preventDefault(); // 기본 폼 제출 방지
											$
													.ajax({
														url : $(this).attr(
																'action'), // action URL 확인
														type : 'POST',
														data : new FormData(
																this),
														contentType : false,
														processData : false,
														dataType : 'json', // JSON 형태로 응답받기
														success : function(
																response) {
															$('#msg')
																	.text(
																			response.msg); // 서버에서 보낸 메시지 표시
															$('#updateModal')
																	.modal(
																			'show');

															// 모달이 닫힐 때 view 페이지로 리다이렉트 처리
															if (response.status === 'success') {
																$(
																		'#updateModal')
																		.off(
																				'hidden.bs.modal')
																		.on(
																				'hidden.bs.modal',
																				function() {
																					// email을 URL 파라미터로 추가
																					let email = $(
																							'input[name="email"]')
																							.val(); // 폼에서 이메일 값 가져오기
																					window.location.href = "/member/view.do?email="
																							+ encodeURIComponent(email); // view 페이지로 리다이렉트
																				});
															}
														},
														error : function(xhr,
																status, error) {
															console
																	.error(
																			'AJAX 요청 오류:',
																			status,
																			error);
															$('#msg')
																	.text(
																			"정보 업데이트에 실패했습니다.");
															$('#updateModal')
																	.modal(
																			'show');
														}
													});
										});

						// 프로필 이미지 미리보기
						$('#fileInput').change(function(event) {
							previewImage(event);
						});
					});

	function previewImage(event) {
		const reader = new FileReader();
		reader.onload = function() {
			const output = document.getElementById('profileImage');
			output.src = reader.result;
		}
		if (event.target.files[0]) {
			reader.readAsDataURL(event.target.files[0]);
		}
	}
	function deleteProfileImage() {
		const profileImage = document.getElementById('profileImage');
		profileImage.src = '/upload/member/Default_Profile.png'; // 기본 이미지 경로로 설정
		document.querySelector('input[name="existingPhoto"]').value = ''; // 기존 이미지 삭제 처리
	}
</script>

</head>
<body>
	<div class="container">
		<h2 class="mt-3">Profile Update</h2>
		<form action="update.do" method="post" enctype="multipart/form-data">
			<!-- 프로필 사진 -->
			<input type="file" id="fileInput" name="photoFile" accept="image/*">
			<input type="hidden" name="existingPhoto" value="${vo.photo}">
			<img src="${vo.photo}" alt="프로필 사진" id="profileImage"
				class="profile-img" onclick="triggerFileInput()">
			<!-- 프로필 삭제 버튼 -->
			<div class="btn-group text-center" role="group">
				<button type="button" class="btn btn-danger" id="deleteProfileBtn"
					onclick="deleteProfileImage()">프로필 삭제</button>
			</div>
			<!-- 사용자 정보 그리드 -->
			<div class="info-grid">
				<input type="hidden" value="${vo.email }" name="email">
				<div>
					<label>닉네임</label> <input type="text" name="nickName"
						value="${vo.nickName}" class="input-field"> <input
						type="button" onclick="checkNickname()" value="중복확인"
						class="btn btn-secondary btn-sm check-button">
					<div id="unameResult" class="result-message"></div>
				</div>
				<div>
					<label>이름</label> <input type="text" name="name" value="${vo.name}">
				</div>
				<div>
					<label>생년월일</label> <input type="date" name="birth"
						value="<fmt:formatDate value='${vo.birth}' pattern='yyyy-MM-dd' />">
				</div>
				<div>
					<label>연락처</label> <input type="tel" name="tel" value="${vo.tel}">
				</div>
				<div>
					<label for="password">비밀번호:</label> <input type="password"
						id="password" name="pw" class="form-control" placeholder="비밀번호 입력">
					<span id="togglePassword" class="password-toggle "><i
						class="fa fa-eye" aria-hidden="true"></i> </span>
					<div id="pwdResult" class="invalid-feedback"></div>
					<div id="pwdResultValid" class="valid-feedback"></div>
				</div>
				<div>
					<label for="confirm-pwd">비밀번호 확인:</label> <input type="password"
						class="form-control" id="confirm-pwd" placeholder="비밀번호 재입력"
						name="confirm-pwd" required> <span
						id="toggleConfirmPassword" class="password-toggle ml-5"><i
						class="fa fa-eye" aria-hidden="true"></i> </span>
					<div id="confirmPwdResult" class="invalid-feedback"></div>
					<div id="confirmPwdResultValid" class="valid-feedback"></div>
				</div>
			</div>

			<!-- 버튼 중앙 배치 -->
			<div class="btn-group text-center" role="group">
				<button class="btn" id="updateBtn" type="submit" disabled
					style="background: orange; color: white;">수정</button>
			</div>
		</form>
	</div>
	<!-- 모달 HTML -->
	<div id="updateModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p id="msg"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<script type="module" src="/js/mainBadWord.js"></script>

</body>
</html>
