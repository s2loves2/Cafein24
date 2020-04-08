<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cafeStart</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2dd25abaad9c711dd38bcb2ac8770c77&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2dd25abaad9c711dd38bcb2ac8770c77"></script>
</head>
<body>
	<c:set var="user" value="${user}"/>
	<form action="searchCafe" method="POST">
		<input type="text" name="cafe_name" placeholder="카페이름 입력">
		<button type="submit">
			검색하기 <img src="">
		</button>
		<br>
	</form>
	<br>
	<c:forEach items="${cafeList}" var="cafe">
		${cafe.cafe_name} <br>
		${cafe.cafe_addr} <br>
		${cafe.cafe_tel} <br>
		${cafe.cafe_star} <br>
		<c:if test="${user == null }">
			<a href="#" id="cafedetail_btn" onclick="detail()">
				<img src="img/${cafe.cafe_img}" style="width:100px;height:100px;">
			</a>
			<script type="text/javascript">
				function detail(){
					alert('로그인해주세요!!');
					location.href = "goLogin";
				}
			</script>
		</c:if>
		<c:if test="${user != null}">
			<a href="cafeDetail/${cafe.cafe_code}" id="cafedetail_btn">
				<img src="img/${cafe.cafe_img}" style="width:100px;height:100px;">
			</a>		
		</c:if>
		<br>
	</c:forEach>
	<div id="map" style="width: 500px; height: 400px;"></div>
	
	<script>
		/*
		 	 비트캠프 서초센터 지도 좌표 : 37.503105, 127.024282
		 */
		 
		 var cafes = "${cafeList}";
		 console.log(cafes);
		 if(cafes == "[]") alert('해당 카페는 찾을 수 없습니다.');
		
		// 지도를 표시할 컨테이너
		var container = document.getElementById('map');
		var options = {
			// 지도 중심
			center : new kakao.maps.LatLng(37.503105, 127.024282),
			// 지도 확대 레벨
			level : 4
		};
		
		// 지도 생성
		var map = new kakao.maps.Map(container, options);
		
		// 주소-좌표 변환 객체
		var geocoder = new kakao.maps.services.Geocoder();
		
		<c:forEach items="${cafeList}" var="cafe">
			// 주소로 좌표 검색
			geocoder.addressSearch('${cafe.cafe_addr}', function(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					console.log('검색 완료');
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					// 위치 마커로 표시
					var marker = new kakao.maps.Marker({
						map: map,
						position: coords,
						title: '${cafe.cafe_name}'
					})
				}
				
				var iwContent = "<div style='padding:5px;'>${cafe.cafe_name}</div>";
				var infowindow = new kakao.maps.InfoWindow({
					content: iwContent
				})
				
				kakao.maps.event.addListener(marker, 'mouseover', function(){
					infowindow.open(map, marker);
				});
				
				kakao.maps.event.addListener(marker, 'mouseout', function(){
					infowindow.close();
				});
				
			}) // geocoder.addressSearch() end
		</c:forEach> // c:forEach end
	</script>
</body>
</html>