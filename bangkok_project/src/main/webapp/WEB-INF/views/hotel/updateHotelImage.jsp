<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>

<script type="text/javascript">
$(function(){
	
	 // (핵심코드)- 체크박스 기존 데이터 불러오면서 리스트 출력
    for(let i=0;i<amenitiesPick.length;i++) {
    	let amenitiesNo = amenitiesPick[i].amenitiesNo;
    	$(`.amenitiesCheckBox[value=\${amenitiesNo}]`).prop("checked",true);
    }
}
</script>

</head>
<body>
<div class="container">
	<form action="updateHotelImage.do">
		<fieldset class="border p-4" id="amenitiesFieldSet">
				<legend class="w-auto px-2">
					<b style="font-size: 14pt;">[편의시설]</b>
				</legend>
				<div id="amenitiesDiv" class="form-inline">
					<c:forEach items="${amenitieslist}" var="amenity">

						<div class="form-check form-check-inline">
							<input class="form-check-input amenitiesCheckBox" type="checkbox"
								id="amenities${amenity.amenitiesNo}" name="selectedAmenities"
								value="${amenity.amenitiesNo}" /> <label
								class="form-check-label" for="amenities${amenity.amenitiesNo}">${amenity.amenitiesName}</label>
						</div>
					</c:forEach>
				</div>
			</fieldset>
	</form>
</div>
</body>
</html>
