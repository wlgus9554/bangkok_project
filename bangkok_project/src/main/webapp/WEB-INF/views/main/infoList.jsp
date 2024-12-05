<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<style>
.card-container {
    display: flex;
    flex-wrap: wrap; /* 카드들이 줄바꿈되도록 */
    justify-content: center; /* 카드들이 중앙에 정렬되도록 설정 */
    margin: 0 auto;
    padding-left: 5px; /* 원하는 값으로 조정 */
}

.infoRow {
    width: 300px; /* 카드 너비 고정 */
    margin: 15px; /* 카드 간격 조정 */
}

.card {
    position: relative;
    overflow: hidden; /* 자식 요소가 카드 밖으로 나가지 않도록 설정 */
    max-width:90%;
}

.imageDiv {
    position: relative; /* 자식 요소의 절대 위치를 설정하기 위해 */
}

.card-img-top {
    width: 100%;
    height: 200px; /* 이미지 높이 고정 */
    object-fit: cover; /* 이미지 비율 유지 */
}

.card-title {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    font-size: xx-large;
    color: white;
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7);
}
.infoRow:hover {
    cursor: pointer;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    $(".infoRow").click(function() {
        let no = $(this).data("no");
        if (!no) {
            alert("여행 정보 번호가 없습니다.");
            return;
        }
        location = "/info/view.do?no=" + no + "&inc=1";
    });
});
</script>

<h4 style="margin-left: 16%; font-family: 'Pretendard-Regular'; margin-bottom: 20px;">여행정보</h4>

<div class="container card-container">
    <div class="row">
        <c:forEach items="${infoList}" var="vo" varStatus="status">
            <c:if test="${status.index < 4}"> <!-- 4개까지만 표시 -->
                <div class="col-md-3 mb-3"> <!-- 카드 아래쪽에 마진 추가 -->
                    <div class="infoRow" data-no="${vo.no}">
                        <div class="card">
                            <div class="imageDiv text-center align-content-center">
                                <img class="card-img-top" src="${vo.imageFile}" alt="${vo.cityname}">
                                <div class="card-title">
                                    <span>${vo.cityname}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
