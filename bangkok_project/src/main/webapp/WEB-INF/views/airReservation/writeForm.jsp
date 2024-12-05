<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>항공 예약 폼</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
	rel="stylesheet">
<style type="text/css">
:root {
    --main-color: #ff8c19;
    --secondary-color: #ffb163;
    --lighter-color: #e0e0e7;
    --light-color: #b0b0c0; /* 어두운 색상 */
    --dark-color: #52500e; /* 어두운 색상 */
    
    --font-small: 14px; /* 작은 글꼴 크기 */
    --font-large: 20px; /* 큰 글꼴 크기 */
}

.a {
    text-decoration: none;
    color: inherit;
}

ul {
    list-style: none;
    padding: 0; /* ul의 기본 패딩 제거 */
}

h1, h2, h3 {
    font-weight: 700;
    line-height: 1.25;
    margin: 0 0 0.5em; /* 단위 추가 */
}

.container {
    max-width: 1100px;
    margin: 0 auto;
    padding: 2em; /* 내부 여백 조정 */
    background-color: white; /* 배경 색상 하얀색 */
    border-radius: 15px; /* 모서리 둥글기 */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}


.form-box {
    display: flex;
    flex-direction: row;
    margin-top: 5em;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
    border-radius: 15px;
    background-color: #ffe8d1;
}

.form-box .progress {
    position: relative;
    padding: 1em;
}

.logo {
    font-size: 1.75rem;
    font-weight: 800;
    color: var(--dark-color);
    padding: 40px 48px;
    text-align: center;
}

.logo span {
    color: var(--main-color);
}

.form-box form {
    width: 100%;
    padding: 3em;
    background-color: white;
}

form > div {
    max-width: 1000px;
    margin: 0 auto;
}

form > div p {
    color: var(--light-color);
    margin-bottom: 2em;
}

form > div > div:not(.checkbox) {
    display: flex;
    flex-direction: column;
    margin-bottom: 2em;
}

form :where(input, select) {
    height: 40px;
    border-radius: 7px;
    outline-color: var(--secondary-color);
    border: 1px solid var(--light-color);
    background-color: transparent;
    transition: border-color 0.3s; /* 테두리 색상 전환 효과 */
}

form label {
    font-size: var(--font-small);
    margin-bottom: 0.5em;
    font-weight: 600;
}

form .grouping {
    display: flex;
}

input-group {
    display: flex;
}

input-group input {
    max-width: 100%;
    text-align: center;
    margin-right: 1em; 
}

form .grouping input {
    max-width: 70px;
    text-align: center;
    margin-right: 1em; 
}

form .checkbox input {
    height: auto;
}

form > div:not(.btn-group) {
    display: none;
}

form > div.active {
    display: block;
}

.btn-group {
    display: flex;
    flex-wrap: wrap;
    gap: 1em;
    margin-top: 2em;
}

.btn-group [class*="btn-"] {
    background-color: var(--main-color);
    color: white;
    padding: 1em 2.5em;
    border: 4px solid var(--secondary-color);
    border-radius: 30px;
    cursor: pointer;
    transition: background-color .3s, border-color .3s ease-out;
}

.btn-group [class*="btn-"]:disabled {
    background-color: var(--light-color);
    border-color: var(--lighter-color);
    cursor: not-allowed; /* 비활성 상태에서 커서 변경 */
}

.btn-group [class*="btn-"]:hover:not(:disabled) {
    background-color: var(--dark-color);
    border-color: var(--light-color);
}

::placeholder {
    color: var(--light-color);
}

.form-container {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.row {
    display: flex;
    gap: 10px;
}

.form-group {
    flex: 1;
}

.passenger-item {
    width: 100%;
    padding: 10px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 0 5px rgba(255, 140, 25, 0.5); /* 빛나는 효과 */
    transition: box-shadow 0.3s; /* 마우스 오버 시 효과를 부드럽게 */
}

.passenger-item:hover {
    box-shadow: 0 0 10px rgba(255, 140, 25, 1); /* 마우스 오버 시 더 밝게 */
}

.baggage-container {
    display: flex;
    flex-direction: column; /* 수직으로 배치 */
    margin-top: 20px;
    box-shadow: 0 0 5px rgba(255, 140, 25, 0.5); /* 빛나는 효과 */
}

.baggage-item {
    margin-top: 10px; /* 위쪽 여백 */
    display: flex; /* Flexbox를 사용하여 자식 요소를 가로로 배치 */
    margin-bottom: 10px; /* 아래쪽 여백 */
}

.baggage-input {
    padding: 10px; /* 여백 */
    border-radius: 5px; /* 모서리 둥글기 */
    margin-right: 10px; /* 입력 필드 사이의 간격 */
    transition: border-color 0.3s; /* 테두리 색상 전환 효과 */
}

.baggage-input:last-child {
    margin-right: 0; /* 마지막 입력 필드 오른쪽 여백 제거 */
}

.baggage-input:focus {
    border-color: #ff8c19; /* 포커스 시 테두리 색상 */
    box-shadow: 0 0 5px rgba(255, 140, 25, 0.5); /* 포커스 시 그림자 효과 */
}

.btn {
    background-color: #ff8c19; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    border: none; /* 버튼 테두리 제거 */
    border-radius: 15px; /* 버튼 모서리 둥글기 */
    padding: 10px 15px; /* 버튼 여백 */
    cursor: pointer; /* 커서 변경 */
    transition: background-color 0.3s; /* 버튼 색상 전환 효과 */
}

.btn:hover {
    background-color: #e07b13; /* 마우스 오버 시 색상 변경 */
}

.header {
    background-color: #ff7043; /* 따뜻한 주황색 */
    color: white;
    padding: 20px;
    text-align: center;
    border-bottom: 2px solid #e64a19;
}

.header h1 {
    font-size: 28px;
    margin: 0;
    letter-spacing: 1px;
}

.header p {
    margin: 10px 0 0;
    font-size: 16px;
}

/* 좌측 섹션 */
.left-section {
    padding: 30px;
    max-width: 1200px;
    margin: 20px auto;
    background-color: white;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

.journey-info {
    width: 700px;
}


/* 여정 정보 */
.journey-info h2 {
    font-size: 24px;
    margin-bottom: 20px;
    color: #ff7043;
    border-bottom: 2px solid #ddd;
    padding-bottom: 10px;
}

.journey-info .details div {
    margin: 10px 0;
}

.journey-info strong {
    font-weight: bold;
    color: #e64a19;
}

/* 왕복/편도 여정 스타일 */
.row {
    display: flex;
    justify-content: space-between;
    gap: 20px;
}

.col-md-6 {
    width: 48%;
}

</style>

<script>

$(function () {
	
	$(".btnReservation").click(function () {
		let x = uuidv4();

		$(".reservationLabel").val(x);
		console.log(x);

	});
	
	const nextButton = document.querySelector('.btn-next');
	const prevButton = document.querySelector('.btn-prev');
	const formSections = document.querySelectorAll('.form-step'); // Select all form sections
	let active = 0; // Start from the first form section

	// Function to handle the next button click
	nextButton.addEventListener('click', () => {
	    if (active < formSections.length - 1) {
	        active++;
	        updateProgress();
	    }
	});

	// Function to handle the previous button click
	prevButton.addEventListener('click', () => {
	    if (active > 0) {
	        active--;
	        updateProgress();
	    }
	});

	// Function to update the visibility of form sections
	const updateProgress = () => {
	    // Update visibility of form sections
	    formSections.forEach((section, i) => {
	        section.classList.toggle('active', i === active); // Add 'active' class to the current section
	    });

	    // Disable the previous button on the first section and the next button on the last section
	    prevButton.disabled = (active === 0);
	    nextButton.disabled = (active === formSections.length - 1);
	};

	// Initial call to set the correct state
	updateProgress();
	
	// 성인은 현재일보다 19년 전까지로 생일을 지정가능 
	let today = new Date();

	let adult_maxDate = new Date(today.getFullYear() - 19, today.getMonth(), today.getDate());
	let adult_minDate = new Date(today.getFullYear() - 100, today.getMonth(), today.getDate());
	
	let child_minDate = new Date(today.getFullYear() - 13, today.getMonth(), today.getDate());
	let child_maxDate = new Date(today.getFullYear() - 6, today.getMonth(), today.getDate());
	
	let adult_PassportmaxDate = new Date(today.getFullYear() + 10, today.getMonth(), today.getDate());
	let chin_PassportmaxDate = new Date(today.getFullYear() + 5, today.getMonth(), today.getDate());
	
	let infant_minDate = new Date(today.getFullYear() - 2, today.getMonth(), today.getDate());
	
	// Adult Datepicker
	$(".adult_datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
	    "maxDate": adult_maxDate,
	    "minDate" : adult_minDate
	});
	
	// Child Datepicker
	$(".child_datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
	    "maxDate": child_maxDate,
	    "minDate" : child_minDate
	});
	
	// Infant Datepicker
	$(".infant_datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
	    "maxDate": today,
	    "minDate" : infant_minDate
	});
	
	// Passport Datepicker (for adult)
	$(".adult_passport_datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
	    "minDate": today,
	    "maxDate": adult_PassportmaxDate
	});
	
	// Passport Datepicker (for children)
	$(".child_passport_datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
	    "minDate": today,
	    "maxDate": chin_PassportmaxDate
	});

	
    // Populate nationality dropdown
    $.getJSON("/ajax/getCountry.do")
        .done(function(data) {
            let countryList = data.countryList;
            if (Array.isArray(countryList)) {
                let options = '<option value="">선택하세요</option>';
                countryList.forEach(function(vo) {
                    options += '<option value="' + vo.countryCode + '">' + vo.countryEng + '</option>';
                });
                $('select[id^="nationality-"]').each(function() {
                    $(this).html(options);
                });
            } else {
                console.error('Expected an array but got:', countryList);
            }
        })
        .fail(function(xhr, status, err) {
            console.error("AJAX 오류:", xhr, status, err);
            alert("국가 리스트 데이터를 가져오는 중 오류 발생");
        });


});

let baggageTypes = []; // 수하물 종류 데이터를 저장할 배열
let basePrice = 0; // 기본 요금을 저장할 변수

// 페이지 로드 시 기본 요금을 설정
document.addEventListener('DOMContentLoaded', function() {
    // 기본 요금 가져오기 (departPrice + arrivePrice)
    let departPrice = parseFloat(document.querySelector('input[name="departPrice"]').value) || 0;
    let arrivePrice = parseFloat(document.querySelector('input[name="arrivePrice"]').value) || 0;
    basePrice = departPrice + arrivePrice;

    // 초기 총액 설정
    document.getElementById('totalPrice').textContent = `총액: \${basePrice}원`;
    document.getElementById('total_Price').value = basePrice;
});

function addBaggage() {
    let container = document.getElementById('baggage-container');
    let index = container.children.length;
    let baggageItem = document.createElement('div');

    baggageItem.classList.add('baggage-item');
    baggageItem.id = `baggage-item-\${index}`;

    baggageItem.innerHTML = `
        <div class="baggage-input">
            <label for="baggageTypeID-\${index}">수하물 종류:</label>
            <select class="form-control" name="baggages[\${index}].baggageTypeID" id="baggageTypeID-\${index}" style="margin-left: 10px;" onchange="updateBaggageDescription(\${index})">
                <option value="">선택하세요</option>
            </select>
        </div>
        <div class="baggage-input">
            <label for="baggage-weight-\${index}" style="margin-left: 20px;">무게 (kg):</label>
            <input type="number" id="baggage-weight-\${index}" placeholder="예: 20" min="0" oninput="validateBaggageWeight(\${index})" name="baggages[\${index}].baggage_weight">
            <div id="additionalCost-\${index}" style="color:blue;"></div>
        </div>
        <button type="button" onclick="removeBaggage(this)" class="btn">제거</button>
    `;

    container.appendChild(baggageItem);

    // 서버에서 수하물 종류 데이터를 가져와 옵션을 추가합니다.
    $.getJSON("/ajax/getBaggageType.do")
    .done(function(data) {
        let baggageList = data.baggageTypeList;
        if (Array.isArray(baggageList)) {
            // 수하물 종류 데이터를 갱신
            baggageTypes = baggageList.map(item => ({
                id: item.baggageTypeID,
                description: item.description,
                maxWeight: item.maxweight,
                price: item.price,
                baggageType: item.baggage_Type
            }));
            let options = '<option value="">선택하세요</option>';
            baggageList.forEach(function(vo) {
                options += `<option value="\${vo.baggageTypeID}">\${vo.baggage_Type} (최대 무게: \${vo.maxweight}kg)</option>`;
            });
            $(`#baggageTypeID-\${index}`).html(options);
        } else {
            console.error('배열이 예상되었지만:', baggageList);
        }
    })
    .fail(function(xhr, status, err) {
        console.error("AJAX 오류:", xhr, status, err);
        alert("수하물 종류 리스트 데이터를 가져오는 중 오류 발생");
    });
}

function removeBaggage(button) {
    button.parentElement.remove();
    calculateTotalPrice();  // 수하물 제거 시 총 가격 재계산
}

function validateBaggageWeight(index) {
    let weightInput = document.getElementById(`baggage-weight-\${index}`);
    let select = document.getElementById(`baggageTypeID-\${index}`);
    let additionalCostDiv = document.getElementById(`additionalCost-\${index}`);
    let selectedBaggage = baggageTypes.find(item => item.id == select.value);

    if (selectedBaggage) {
        let weight = parseFloat(weightInput.value);
        if (weight > selectedBaggage.maxWeight) {
            additionalCostDiv.textContent = '규정된 무게를 초과했습니다. 적절한 수하물 종류를 선택해 주세요.';
            selectedBaggage.value = "";
            weightInput.value = '';  // 무게 입력 초기화
        } else {
            additionalCostDiv.textContent = '';
            calculateTotalPrice();  // 무게가 적합하면 총 가격 재계산
        }
    }
}

function calculateTotalPrice() {
    let totalPrice = basePrice; // 기본 요금부터 시작
    document.querySelectorAll('.baggage-item').forEach((baggageItem, index) => {
        let weightInput = baggageItem.querySelector(`input[id^="baggage-weight-"]`);
        let select = baggageItem.querySelector(`select[id^="baggageTypeID-"]`);
        let additionalCostDiv = baggageItem.querySelector(`#additionalCost-\${index}`);
        let selectedBaggage = baggageTypes.find(item => item.id == select.value);

        if (selectedBaggage && weightInput.value) {
            let weight = parseFloat(weightInput.value);
            if (weight > selectedBaggage.maxWeight) {
                additionalCostDiv.textContent = '규정된 무게를 초과했습니다.';
            } else {
                let price = selectedBaggage.price;  // 선택한 수하물의 기본 가격
                totalPrice += price;  // 수하물 가격을 총 가격에 더함
                additionalCostDiv.textContent = `추가 요금: \${price}원`;
            }
        }
    });

    // 총 가격을 업데이트
    document.getElementById('totalPrice').textContent = `총액: \${totalPrice}원`;

    // 폼에 totalPrice 값을 히든 필드로 추가
    document.getElementById('total_Price').value = totalPrice;
    
    document.getElementById('Form').addEventListener('submit', function(event) {
        calculateTotalPrice();  // 제출 전 총 가격 계산
    });
    	
}

function cardspace() {
	let carddigit = document.getElementById("cardno").value;
	if(carddigit.length == 4 || carddigit.length == 9 || carddigit.length == 14) {
		document.getElementById('cardno').value = carddigit+" ";
		document.getElementById('cardno').max = 1;
	}
}

function addSlashes() {
	let expiredate = document.getElementById("vaildtill").value;
	if(expiredate.length == 2) {
		document.getElementById('vaildtill').value = expiredate+"/";
		document.getElementById('vaildtill').max = 1;
	}
}

</script>

</head>
<body>
	<div id="page" class="site">
		<div class="container">
			<div class="form-box">
			<!-- Header Section -->
				<header class="header">
					<h1>인천 ${list.firstDeparture } → 후쿠오카 ${list.firstArrival }</h1>
					<p>${list.type}
						|
						<c:if test="${param.aPassenger != null && param.aPassenger != 0}">
	                ${param.aPassenger} 성인
	            </c:if>
						<c:if test="${param.cPassenger != null && param.cPassenger != 0}">
	                , ${param.cPassenger} 어린이
	            </c:if>
						<c:if test="${param.iPassenger != null && param.iPassenger != 0}">
	                , ${param.iPassenger} 유아
	            </c:if>
						| 좌석 등급: ${list.seatGrade }
					</p>
				</header>
	
				<!-- Journey Information Section -->
				<div class="left-section">
					<section class="journey-info">
						<h2>여정 정보</h2>
						<div class="details">
							<c:if test="${list.type == '왕복'}">
								<div>
									<strong>출발 : </strong> ${list.firstDeparture }
								</div>
								<div>
									<strong>도착 : </strong> ${list.firstArrival }
								</div>
								<div>
									<strong>좌석등급: </strong>${list.seatGrade }</div>
								<div>
									<strong>가격 : </strong>${list.departPrice + list.arrivePrice }</div>
							</c:if>
							<c:if test="${list.type == '편도'}">
								<div class="row">
									<div class="col-md-6">
										<div>
											<strong>출발 : </strong> ${list.firstDeparture }
										</div>
										<div>
											<strong>도착 : </strong> ${list.firstArrival }
										</div>
										<div>
											<strong>좌석등급: </strong>${list.seatGrade }</div>
										<div>
											<strong>가격 : </strong>${list.departPrice }</div>
									</div>
									<div class="col-md-6">
										<div>
											<strong>출발 : </strong> ${list.secondDeparture }
										</div>
										<div>
											<strong>도착 : </strong> ${list.secondArrival }
										</div>
										<div>
											<strong>좌석등급 : </strong>${list.seatGrade }</div>
										<div>
											<strong>가격 : </strong> ${list.arrivePrice }
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</section>
				</div>
				
				</div>
				<form action="write.do" method="post" id="Form">
				<input type ="hidden" name = "reservationLabel" class = "reservationLabel">
				<input type="hidden" name="scheduleID" value="${list.scheduleId_a}">
			    <input type="hidden" name="scheduleID" value="${list.scheduleId_d}">
			    <input type="hidden" name="type" value="${list.type}">
			    <input type="hidden" name="aPassenger" value="${param.aPassenger}">
				<input type="hidden" name="cPassenger" value="${param.cPassenger}">
				<input type="hidden" name="iPassenger" value="${param.iPassenger}">
			    <input type="hidden" name="firstDeparture" value="${list.firstDeparture}">
			    <input type="hidden" name="firstArrival" value="${list.firstArrival}">
			    <input type="hidden" name="departPrice" value="${list.departPrice}">
			    <input type="hidden" name="secondDeparture" value="${list.secondDeparture}">
			    <input type="hidden" name="secondArrival" value="${list.secondArrival}">
			    <input type="hidden" name="arrivePrice" value="${list.arrivePrice}">
			    <input type="hidden" name="seatGrade" value="${list.seatGrade}">
			    <input type="hidden" name="status" value="1">
			    
			    <c:if test="${list.seatGrade == '일반석' }">
			    	<input type="hidden" name="classNo" value="1">
			    </c:if>
			    <c:if test="${list.seatGrade == '비즈니스석' }">
			    	<input type="hidden" name="classNo" value="2">
			    </c:if>
			    <c:if test="${list.seatGrade == '일등석' }">
			    	<input type="hidden" name="classNo" value="3">
			    </c:if>
				
					<div class = "form-one form-step active">
						<div class="bg-svg"></div>
						<h2>예약자 정보 확인</h2>
						<p>Enter your personal information correctly</p>
						<div>
							<label>성명</label>
							<input id="r_firstName" name="r_firstName" value="${login.name }">
						</div>
						<div>
							<label>이메일</label>
							<input type="email" id="email" value="${login.email }">
						</div>
						<div class="birth">
							<label>생일</label>
							<div class="grouping">
								<input type="text" pattern="[0-9]*" name="day" value="" min="0" max="31" placeholder="DD">
								<input type="text" pattern="[0-9]*" name="month" value="" min="0" max="12" placeholder="MM">
								<input type="text" pattern="[0-9]*" name="year" value="" min="0" max="2005" placeholder="YYYY">
							</div>
						</div>
						<div>
							<label>휴대폰</label>
							<input type="tel" id="phone" value="${login.tel }">
						</div>
					</div>
					
					<div class="form-two form-step">
					    <div class="bg-svg"></div>
					    <h2 class="form-title">탑승자 정보 등록</h2>
					    <div class="passenger-info-container">
							<c:forEach var="i" begin="1" end="${param.aPassenger}">
							    <div class="passenger-item" style="margin-bottom: 20px;">
							        <h3 class="passenger-title">성인 ${i}</h3>
							
							        <!-- 성과 이름 -->
							        <div class="input-group" style="margin-bottom: 15px;">
									    <div style="display: flex; align-items: center; justify-content: start;">
									        <div style="display: flex; flex-direction: column; width: 48%; margin-right: 23px;">
									            <label for="first-name-${i}-a">성</label>
									            <input type="text" id="first-name-${i}-a" placeholder="예: 홍" name="apassengers[${i-1}].firstName" class="input-field" style="width: 100%;">
									        </div>
									
									        <div style="display: flex; flex-direction: column; width: 48%;">
									            <label for="last-name-${i}-a">이름</label>
									            <input type="text" id="last-name-${i}-a" placeholder="예: 길동" name="apassengers[${i-1}].lastName" class="input-field" style="width: 100%;">
									        </div>
									    </div>
									</div>

							
							        <!-- 국적 -->
							        <div class="input-group" style="margin-bottom: 15px; width: 100%;">
							            <label for="nationality-${i}-a">국적</label>
							            <select class="form-control nationality-${i}" name="apassengers[${i-1}].nationality" id="nationality-${i}-a" style="width: 100%;">
							                <!-- ajax를 이용한 중분류 option 로딩하기 -->
							            </select>
							        </div>
							
							        <!-- 성별 -->
							        <div class="input-group" style="margin-bottom: 15px; width: 100%;">
							            <label for="gender-${i}-a">성별</label>
							            <select id="gender-${i}-a" name="apassengers[${i-1}].gender" style="width: 100%;">
							                <option value="M">남성</option>
							                <option value="F">여성</option>
							            </select>
							        </div>
							
							        <!-- 생일 -->
							        <div class="input-group" style="margin-bottom: 15px;">
							            <label for="birth-${i}-a">생일</label>
							            <div style="display: flex; justify-content: space-between; gap: 10px;">
							                <input class="adult_datepicker" name="apassengers[${i-1}].birth" id="dob-${i}-a">
							            </div>
							        </div>
							
							        <!-- 여권 번호와 만료일 -->
							        <div class="input-group" style="display: flex; justify-content:start; margin-bottom: 15px;">
							            <div style="width: 250px;">
							                <label for="passport-${i}-a">여권 번호:</label>
							                <input type="text" id="passport-${i}-a" name="apassengers[${i-1}].passport_number" placeholder="영문자와 숫자 6~9자리" pattern="[A-Za-z0-9]{6,9}" title="여권 번호는 6~9자리의 영문자와 숫자 조합이어야 합니다." required class="input-field" style="width: 100%;">
							            </div>
							            <div style="width: 100px; margin-left: 30px;">
							                <label for="passport-expiry-${i}-a">여권 만료일</label>
							                <input class="datepicker" id="passport-expiry-${i}-a" name="apassengers[${i-1}].passportEndDate" style="width: 100%;">
							            </div>
							        </div>
							    </div>
							</c:forEach>

							<c:forEach var="i" begin="1" end="${param.cPassenger}">
								 <div class="passenger-item" style="margin-bottom: 20px;">
							        <h3 class="passenger-title">소아 ${i}</h3>
							
							         <!-- 성과 이름 -->
							        <div class="input-group" style="margin-bottom: 15px;">
									    <div style="display: flex; align-items: center; justify-content: start;">
									        <div style="display: flex; flex-direction: column; width: 48%; margin-right: 23px;">
									            <label for="first-name-${i}-a">성</label>
									            <input type="text" id="first-name-${i}-a" placeholder="예: 홍" name="cpassengers[${i-1}].firstName" class="input-field" style="width: 100%;">
									        </div>
									
									        <div style="display: flex; flex-direction: column; width: 48%;">
									            <label for="last-name-${i}-a">이름</label>
									            <input type="text" id="last-name-${i}-a" placeholder="예: 길동" name="cpassengers[${i-1}].lastName" class="input-field" style="width: 100%;">
									        </div>
									    </div>
									</div>
							
							        <!-- 국적 -->
							        <div class="input-group" style="margin-bottom: 15px; width: 100%;">
							            <label for="nationality-${i}-a">국적</label>
							            <select class="form-control nationality-${i}" name="cpassengers[${i-1}].nationality" id="nationality-${i}-a" style="width: 100%;">
							                <!-- ajax를 이용한 중분류 option 로딩하기 -->
							            </select>
							        </div>
							
							        <!-- 성별 -->
							        <div class="input-group" style="margin-bottom: 15px; width: 100%;">
							            <label for="gender-${i}-a">성별</label>
							            <select id="gender-${i}-a" name="cpassengers[${i-1}].gender" style="width: 100%;">
							                <option value="M">남성</option>
							                <option value="F">여성</option>
							            </select>
							        </div>
							
							        <!-- 생일 -->
							        <div class="input-group" style="margin-bottom: 15px;">
							            <label for="birth-${i}-a">생일</label>
							            <div style="display: flex; justify-content: space-between; gap: 10px;">
							                <input class="adult_datepicker" name="cpassengers[${i-1}].birth" id="dob-${i}-a">
							            </div>
							        </div>
							
							        <!-- 여권 번호와 만료일 -->
							        <div class="input-group" style="display: flex; justify-content: start; margin-bottom: 15px;">
							            <div style="width: 250px;">
							                <label for="passport-${i}-a">여권 번호:</label>
							                <input type="text" id="passport-${i}-a" name="cpassengers[${i-1}].passport_number" placeholder="영문자와 숫자 6~9자리" pattern="[A-Za-z0-9]{6,9}" title="여권 번호는 6~9자리의 영문자와 숫자 조합이어야 합니다." required class="input-field" style="width: 100%;">
							            </div>
							            <div style="width: 100px; margin-left: 30px;">
							                <label for="passport-expiry-${i}-a">여권 만료일</label>
							                <input class="datepicker" id="passport-expiry-${i}-a" name="cpassengers[${i-1}].passportEndDate" style="width: 100%;">
							            </div>
							        </div>
							    </div>
							</c:forEach>
							<c:forEach var="i" begin="1" end="${param.iPassenger}">
								<div class="passenger-item" style="margin-bottom: 20px;">
							        <h3 class="passenger-title">영유아 ${i}</h3>
							
							        <!-- 성과 이름 -->
							        <div class="input-group" style="margin-bottom: 15px;">
									    <div style="display: flex; align-items: center; justify-content: start;">
									        <div style="display: flex; flex-direction: column; width: 48%; margin-right: 23px;">
									            <label for="first-name-${i}-a">성</label>
									            <input type="text" id="first-name-${i}-a" placeholder="예: 홍" name="ipassengers[${i-1}].firstName" class="input-field" style="width: 100%;">
									        </div>
									
									        <div style="display: flex; flex-direction: column; width: 48%;">
									            <label for="last-name-${i}-a">이름</label>
									            <input type="text" id="last-name-${i}-a" placeholder="예: 길동" name="ipassengers[${i-1}].lastName" class="input-field" style="width: 100%;">
									        </div>
									    </div>
									</div>
							
							        <!-- 국적 -->
							        <div class="input-group" style="margin-bottom: 15px; width: 100%;">
							            <label for="nationality-${i}-a">국적</label>
							            <select class="form-control nationality-${i}" name="ipassengers[${i-1}].nationality" id="nationality-${i}-a" style="width: 100%;">
							                <!-- ajax를 이용한 중분류 option 로딩하기 -->
							            </select>
							        </div>
							
							        <!-- 성별 -->
							        <div class="input-group" style="margin-bottom: 15px; width: 100%;">
							            <label for="gender-${i}-a">성별</label>
							            <select id="gender-${i}-a" name="ipassengers[${i-1}].gender" style="width: 100%;">
							                <option value="M">남성</option>
							                <option value="F">여성</option>
							            </select>
							        </div>
							
							        <!-- 생일 -->
							        <div class="input-group" style="margin-bottom: 15px;">
							            <label for="birth-${i}-a">생일</label>
							            <div style="display: flex; justify-content: space-between; gap: 10px;">
							                 <input class="adult_datepicker" name="ipassengers[${i-1}].birth" id="dob-${i}-a">
							            </div>
							        </div>
							
							        <!-- 여권 번호와 만료일 -->
							        <div class="input-group" style="display: flex; justify-content: start; margin-bottom: 15px;">
							            <div style="width: 250px;">
							                <label for="passport-${i}-a">여권 번호:</label>
							                <input type="text" id="passport-${i}-a" name="ipassengers[${i-1}].passport_number" placeholder="영문자와 숫자 6~9자리" pattern="[A-Za-z0-9]{6,9}" title="여권 번호는 6~9자리의 영문자와 숫자 조합이어야 합니다." required class="input-field" style="width: 100%;">
							            </div>
							            <div style="width: 100px; margin-left: 30px;">
							                <label for="passport-expiry-${i}-a">여권 만료일</label>
							                <input class="datepicker" id="passport-expiry-${i}-a" name="ipassengers[${i-1}].passportEndDate" style="width: 100%;">
							            </div>
							        </div>
							    </div>
							</c:forEach>
								<h2 class="form-title">수하물 정보</h2>
						        <div id="baggage-container" class="baggage-container" >
						            <!-- Baggage items will be added dynamically here -->
						        </div>
						        <button type="button" class="btn baggageBtn" onclick="addBaggage()">수하물 추가</button>
						</div>
					</div>
					<div class="form-three form-step">
						<div class="bg-svg"></div>
						<h2>결제 방법</h2>
						<div>
							<strong>출발 요금: </strong> ${list.departPrice }
						</div>
						<div>
							<strong>도착 요금: </strong> ${list.arrivePrice }
						</div>
						<div>
							<label>카드 번호</label>
							<input type="text" name="cardno" id="cardno" maxlength="19" oninput="cardspace()" />
						</div>
						<div class="float">
							<label>유효기간
								<input type="text" name="vaildtill" id="vaildtill" maxlength="7" oninput="addSlashes()" />
							</label>
							<label>CVV
								<input type="text" name="cvv" id="cvv" maxlength="3" />
							</label>
						</div>
						<div class="total">
                            <strong>총액: </strong> 
                            <input type="hidden" id="total_Price" name="total_Price" value="${list.departPrice + list.arrivePrice}">
                            <span id="totalPrice">${list.departPrice + list.arrivePrice}원</span>
                        </div>
					</div>
					<div class="btn-group">
					    <button type="button" class="btn-prev" disabled>이전</button>
					    <button type="button" class="btn-next">다음으로</button>
					    <button type="submit" class="btn-submit btnReservation">결제하기</button>
					</div>

				</form>
			</div>
		</div>
	</div>
</body>
</html>