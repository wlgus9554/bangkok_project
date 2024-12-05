<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실 수정</title>

<script type="text/javascript">
$(function(){
}
</script>

</head>
<body>
	<div class="container">
		<h2>Room Update</h2>
		<form action="updateRoom.do" method="post"
			enctype="multipart/form-data">
			<div class="form-group">
				<input class="no" type="hidden" name="no"
					value="${hotelRoomList.no }"> <input class="rno"
					type="hidden" name="rno" value=${hotelRoomList.rno }>
			</div>
			<div id="roomDiv col">
				<label>객실 타입</label> <select name="room_type" class="custom-select"
					style="width: 100%">
					<option value="Standard"
						${hotelRoomList.room_type == 'Standard' ? 'selected' : ''}>Standard</option>
					<option value="Deluxe"
						${hotelRoomList.room_type == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
					<option value="Suite"
						${hotelRoomList.room_type == 'Suite' ? 'selected' : ''}>Suite</option>
					<option value="Premiere"
						${hotelRoomList.room_type == 'Premiere' ? 'selected' : ''}>Premiere</option>
				</select>
			</div>


			<div class="form-group">
				<label for="room_title">Room Name</label> <input
					class="form-control" name="room_title" id="room_title" required
					value="${hotelRoomList.room_title }">
			</div>
			<div class="rounded-lg p-3 my-2 form-row"
				style="background-color: white">
				<div class="form-group col">
					<label>인원수</label> <input type="number" name="people"
						class="form-control" value="${hotelRoomList.people }" min="1">
				</div>
				<div class="form-group col">
					<label>객실 수</label> <input type="number" name="room_number"
						class="form-control" value="${hotelRoomList.room_number }" min="1">
				</div>
			</div>
			<div class="form-group">
				<label for="room_content">객실 소개</label>
				<textarea class="form-control" name="room_content" id="room_content"
					rows="7">${hotelRoomList.room_content }</textarea>
			</div>
			<div class="form-group col">
				<label for="price">정가</label> <input class="form-control"
					name="price" id="price" required value="${hotelRoomList.price }">
			</div>
			<div class="mt-3">
				<button type="submit" class="btn btn-primary">수정</button>
				<button type="reset" class="btn btn-warning">새로입력</button>
				<button type="button" class="cancelBtn btn btn-success" onclick="history.back()">취소</button>
			</div>
		</form>
	</div>
</body>
</html>
