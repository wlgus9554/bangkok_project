<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="roomCarousel${hotelRoomVO.rno}" class="carousel slide room-carousel">
    <div class="carousel-inner">
        <!-- 첫 번째 이미지 room_image_name(hotel_room) -->
        <div class="carousel-item active position-relative hotelRoomList" data-rno="${hotelRoomVO.rno}">
            <img src="${hotelRoomVO.room_image_name}" class="d-block w-100" alt="Room Image">
            <div class="carousel-caption d-none d-md-block text-center">
                <!-- 이메일 비교 후 버튼 표시 -->
                <c:if test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
                    <button type="button" class="custom-btn changeRoomImageBtn"
                            data-toggle="modal" data-target="#changeRoomImageModal">이미지 변경</button>
                </c:if>
            </div>
        </div>

        <!-- 두 번째 이후 이미지: room_image_name(room_image) -->
        <c:forEach items="${roomImageList}" var="roomImageVO">
            <div class="carousel-item position-relative" id="${roomImageVO.room_image_no}">
            <input type="hidden" name="email" value="${vo.email }">
                <div class="roomImageImg">
                    <div class="image-container roomImageList" data-room_image_no=${roomImageVO.room_image_no}>
                        <img src="${roomImageVO.room_image_name}" class="d-block w-100 main-image" alt="호텔 이미지">
                        <div class="carousel-caption d-none d-md-block text-center">
                            <!-- 이메일 비교 후 버튼 표시 -->
                            <c:if test="${login!=null && (login.email == vo.email || login.gradeNo == 9) }">
                                <button type="button" class="custom-btn changeRoomImagesBtn"
                                        data-toggle="modal" data-target="#changeRoomImagesModal">이미지 변경</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>

    <!-- Carousel Controls -->
    <a class="carousel-control-prev" href="#roomCarousel${hotelRoomVO.rno}" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#roomCarousel${hotelRoomVO.rno}" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
