<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${cafe.cafe_name}</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

</head>
<body>
	<c:set var="isWish" value="${isWish}" />

	${cafe.cafe_name} <br>
	${cafe.cafe_addr} <br>
	${cafe.cafe_tel} <br>
	${cafe.cafe_star} <br>
	<img src="/myapp/img/${cafe.cafe_img}" style="width:100px;height:100px;"> <br>
	
	<div id="wish_div">
		<c:if test="${isWish == false}">
			<button type="button" id="wish_btn">★ 즐겨찾기 추가</button>		
		</c:if>
		<c:if test="${isWish == true}">
			<button type="button" id="wish_delete_btn">★ 즐겨찾기 삭제</button>
		</c:if>
	</div>
	<p>미리 주문하기(취소 불가)</p>
	<select id="product_choice" name="product_choice">
		<option value="">메뉴 선택</option>
		<c:forEach items="${productList}" var="product">
			<option value="${product.product_name}">${product.product_name}</option>
		</c:forEach>
	</select>
	
	<form action="/myapp/insertOrderList.do" method="post">
		<input type="hidden" value="${cafe.cafe_code}" name="cafe_code">
		<div id="menu_div">
		</div>
		<div id="menu_account">
		</div>
	</form>
	
	<br> <br> <br>
	
	<!-- comment board paging control start -->	
	<table border="1">
		<thead>
			<tr>
				<th>No</th>
				<th>별점</th>
				<th>작성자</th>
				<th>내용</th>
				<th>일자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${commentList}" var="comment" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${comment.user_star}</td>
					<td>${comment.user_id}</td>
					<td>${comment.content}</td>
					<td>${comment.comment_date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<table>
		<tr>
			<c:if test="${pageMaker.prev}">
				<td>
					<a href='<c:url value="/cafeDetail/${cafe.cafe_code}?page=${pageMaker.startPage-1}"/>'>&laquo;</a>
				</td>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<td>
					<a href='<c:url value="/cafeDetail/${cafe.cafe_code}?page=${idx}"/>'>${idx}</a>
				</td>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<td>
					<a href="<c:url value="/cafeDetail/${cafe.cafe_code}?page=${pageMaker.endPage+1}" />">&raquo;</a>
				</td>
			</c:if>
		</tr>
	</table>
	<!-- comment board paging control end -->
	
	<br> <br> <br>
	
	<p>	
		별점주기
		<select id="user_star" name="user_star">
			<option value=5.0>★★★★★</option>
			<option value=4.0>★★★★</option>
			<option value=3.0>★★★</option>
			<option value=2.0>★★</option>
			<option value=1.0>★</option>
		</select>  
	</p>
	<p>
		<textarea id="comment_content" rows="4" cols="50" autofocus="autofocus" placeholder="댓글을 입력해주세요(100자 이내)" maxlength="100"></textarea>
		<button type="button" id="comment_btn">작성하기</button>
	</p>
</body>
<script>
	$(function() {
		insertWishList();
		deleteWishList();
		comment();
		menu();
	}); // main
	
	// comment insert
	function comment(){
		$('#comment_btn').on('click', function() {
			$.ajax({
				url: '/myapp/commentInsert.do',
				type: 'POST',
				data:{
					user_id: '${user.user_id}',
					cafe_code: '${cafe.cafe_code}',
					content: $('#comment_content').val(),
					comment_date: getToday(),
					user_star: $('#user_star').val()
				}				
			}).done(function(data) {
				alert('작성 완료되었습니다.');
				location.reload();
			}).fail(function(request, error, status) {
				console.log("code : " + request.status + "\n");
				console.log("msg : " + request.responseText + "\n");
				console.log("error : " + error + "\n");
				alert('comment insert fail');
			})
		})
	}
	
	// 현재 날짜 구하기 (format : yyyy.MM.dd)
	function getToday() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		
		if((month + "").length < 2){
			month = "0" + month;
		}
		
		if((date + "").length < 2){
			date = "0" + date;
		}
		
		return today = "" + year + "." + month + "." + date;
	}
	
	// 메뉴 드롭박스 이벤트
	function menu(){
		var priceAll = 0;
		var productList = new Array();
		
		$('#product_choice').on('change', function(){
			var product_name = $('#product_choice').val();
			var product_price = productPrice(product_name);
			var menuInfo = '<p><input type="text" readonly="readonly" name="product_name" value="'+product_name+'">' +
				'&nbsp;&nbsp;&nbsp;&nbsp;' + product_price + '</p>';
			$('#menu_div').append(menuInfo);

			priceAll += product_price;
			var account = '<p> 총 합계금액 &nbsp;&nbsp;&nbsp; <input type="text" readonly="readonly" name="product_price" value="'+priceAll+'">' +
			'<input type="submit" value="주문하기" style="margin-left:10px;">' + '</p>';
			$('#menu_account').html(account);
		})
	} 	
	
	// 물품 가격 구하기!
	function productPrice(product_name) {
		var product_price = 0;
		$.ajax({
			url: '/myapp/searchProductPrice.do',
			type: 'POST',
			data: {
				cafe_code: '${cafe.cafe_code}',
				product_name: product_name
			},
			dataType: 'json',
			async: false,
			success: function(data) {
				product_price = data.price;
			},
			error: function(request, error, status) {
				console.log("code : " + request.status + "\n");
				console.log("msg : " + request.responseText + "\n");
				console.log("error : " + error + "\n");
				alert('searchProductPrice fail');
			}
		})
		
		return product_price;
	}
	
	// 즐겨찾기 추가
	function insertWishList() {		
		$('#wish_btn').on('click', function(event) {
			event.preventDefault();
			var wish = {
				user_id: '${user.user_id}',
				cafe_code: '${cafe.cafe_code}',
				cafe_name: '${cafe.cafe_name}',
				cafe_addr: '${cafe.cafe_addr}'
			};
			$.ajax({
				url: '/myapp/insertWishList.do',
				type: 'POST',
				data: wish,
				dataType: 'text',
				async: false,
				success: function(data) {
					console.log('insert : ' + data);
					if(data == 'success'){
						var delete_btn = '<button type="button" id="wish_delete_btn">★ 즐겨찾기 삭제</button>';
						alert('즐겨찾기에 추가 되었습니다.');
						$('#wish_btn').remove();
						$('#wish_div').html(delete_btn);
						deleteWishList();
					}
					else if (data == 'fail') alert('이미 추가하셨습니다.');
				},
				error: function(request, error, status) {
					console.log("code : " + request.status + "\n");
					console.log("msg : " + request.responseText + "\n");
					console.log("error : " + error + "\n");
					alert('fail! fail! fail! fail! fail! fail! fail! fail!');
				}
			});
		})
	}
	
	// 즐겨찾기 제거
	function deleteWishList(){
		$('#wish_delete_btn').on('click', function(event){
			event.preventDefault();
			$.ajax({
				url: '/myapp/deleteWishList.do',
				type: 'POST',
				data: {
					user_id: '${user.user_id}',
					cafe_code: '${cafe.cafe_code}'
				},
				dataType: 'text',
				success: function(data) {
					var add_btn = '<button type="button" id="wish_btn">★ 즐겨찾기 추가</button>';
					alert('즐겨찾기에서 삭제 되었습니다.');
					$('#wish_delete_btn').remove();
					$('#wish_div').html(add_btn);
					insertWishList();
				},
				error: function(request, error, status) {
					console.log("code : " + request.status + "\n");
					console.log("msg : " + request.responseText + "\n");
					console.log("error : " + error + "\n");
					alert('delete fail');
				}
			})
		})
	}
</script>
</html>