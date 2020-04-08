<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
	<h1>메뉴 수정/등록하기</h1>
	<table border="1">
		<thead>
			<tr>
				<th>메뉴명</th>
				<th>가격</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody id="tblShow">
			<c:forEach items="${productList}" var="product">
				<tr>
					<td>${product.product_name}</td>
					<td>${product.product_price}</td>
					<td><a href="/myapp/deleteItem.do/${product.product_code}">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- <form action="/myapp/productInsert.do" method="post"> -->
		상품코드 : <input type="text" id="product_code" name="product_code"> <br> 
		카페코드 : <input type="text" id="cafe_code" name="cafe_code" value="${cafe_code}" readonly="readonly"> <br> 
		상품가격 : <input type="number" id="product_price" name="product_price"> <br> 
		상품이름 : <input type="text" id="product_name" name="product_name"> <br>
		<select id="product_type" name="product_type">
			<option value=0>HOT</option>
			<option value=1>ICE</option>
		</select>
		<button type="button" id="productInsert_btn">등록</button> 
		<!-- <input type="submit" value="등록"> -->
	<!-- </form> -->
</body>

<script type="text/javascript">
$(function(){
	insertProduct();
})

function insertProduct(){
	$('#productInsert_btn').on('click', function() {
		// 버튼을 클릭했을 때 우리가 해야할 일 
		$.ajax({
			url: '/myapp/productInsert.do',
			type: 'POST',
			data:{
				product_code: $('#product_code').val(),
				cafe_code: $('#cafe_code').val(),
				product_price: $('#product_price').val(),
				product_name: $('#product_name').val(),
				product_type: $('#product_type').val()
			},
			dataType: 'text',
		}).done(function(data){
			alert(data + ' : 등록이 완료되었습니다.');
			location.reload();
		}).fail(function(request, status, error){
			console.log("code : " + request.status + "\n");
			console.log("msg : " + request.responseText + "\n");
			console.log("error : " + error + "\n");
			alert('product insert fail');
		})
		
	})
}

</script>

</html>