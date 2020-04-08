<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>viewCafe</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
<body>
	<form name="form1" method="post">
		<DIV style="TEXT-ALIGN: center">
			<h2>
				수정 하기 &nbsp;&nbsp;&nbsp; <input type="button" value="메뉴등록"
					onclick="location.href='/myapp/ItemRegister/${cafe.cafe_code}'">
			</h2>

		</DIV>
		<table border="1" style="margin-left: auto; margin-right: auto;">
			<tr>
				<td>카페코드</td>
				<td><input type="text" name="cafe_code" value="${cafe.cafe_code}"></td>
			</tr>
			<tr>
				<td>카페명</td>
				<td><input type="text" name="cafe_name" value="${cafe.cafe_name}"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="cafe_addr" value="${cafe.cafe_addr}"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="cafe_tel" value="${cafe.cafe_tel}"></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td><input type="file" id="cafe_img" name="cafe_img" value="${cafe.cafe_img}"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="등록" onclick="javascript: form.action='/myapp/admin/modifyCafe.do'" /> 
				<input type="submit" value="취소" onclick="javascript: form.action='/myapp/admin/listCafe.do'" />
				</td>
			</tr>
		</table>
		<br>
	</form>
	<div style="text-align: center;">
		<h2>리뷰 목록</h2>
	</div>
	
	<table border="1" style="margin: auto;">
		<thead>
			<tr>
				<th>NO</th>
				<th>별점</th>
				<th>아이디</th>
				<th>내용</th>
				<th>날짜</th>
				<th>삭제</th>
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
					<td><button type="button" onclick="location.href='/myapp/admin/commentDelete.do/${comment.cnum}'">삭제</button> </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>