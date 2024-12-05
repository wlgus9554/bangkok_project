<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="container">
	<h3>여행정보 수정</h3>
	
	<form action="update.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="page" value="${param.page }">
	<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">


		 <div class="form-group">
		    <label for="no">번호</label>
			<input id="no" name="no" class="form-control" value = "${vo.no }"
			 readonly >
		  </div>

		<div class="form-group">
                <label for="title">제목</label>
                <input id="title" name="title" required class="form-control" maxlength="100"
                value="${vo.title }"
                       pattern="^[^ .].{2,99}$"
                       title="맨 앞에 공백문자는 불가하며, 3~100자 내로 입력해주세요."
                       placeholder="제목은 3자 이상 100자 이내로 입력해주세요.">
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" required
                
                          rows="7" placeholder="첫 글자는 공백문자나 줄바꿈을 입력할 수 없습니다."> ${vo.content }</textarea>
            </div>
            
            <div class="form-group">
                <label for="place">작성자</label>
                <input class="form-control" id="writer" name="writer" value="admin" required readonly
                          ></input>
            </div>
            

 <div class="form-group">
                <label for="place">장소명</label>
                <input class="form-control" id="place" name="place" required
                          placeholder="장소명은 공백문자나 줄바꿈을 입력할 수 없습니다."></input>
            </div>

<!--             <div class="form-group"> -->
<!--                 <label for="imageFile">대표 사진</label> -->
<!--                 <input class="form-control" name="imageFile" id="imageFile" required type="file"> -->
<!--             </div> -->


<!--             <div class="form-group" id="imageFieldSet"> -->
<!--                 <label for="filename">추가 사진</label> -->
<!--                 <input class="form-control" name="filename" id="filename" type="file"> -->
<!--             </div> -->



		<button type="submit" class="btn btn-dark btn-sm">update</button>
		<button type="reset" class="btn btn-dark btn-sm">reset</button>
		<button type="button" onclick="history.back();" class="btn btn-dark btn-sm">prev</button>
		
	</form>
	
</div>
</body>
</html>