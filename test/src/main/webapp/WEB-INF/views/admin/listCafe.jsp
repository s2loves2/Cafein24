<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페목록</title>

</head>
<body>
	<DIV style="TEXT-ALIGN: center">
		<h2>카페목록</h2>
	</DIV>
	<DIV style="TEXT-ALIGN: right">
		<input type="button" value="카페등록" onclick="location.href='/myapp/admin/registCafe.do'">
	</DIV>


	<table border="1" style="margin-left: auto; margin-right: auto;">
		<tr>
			<th>코드</th>
			<th>카페이름</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="row" items="${list}">
			<tr>
				<td>${row.cafe_code}</td>
				<td>${row.cafe_name}</td>
				<td>${row.cafe_addr}</td>
				<td>${row.cafe_tel}</td>
				<td align="center"><a href="/myapp/admin/${row.cafe_code}">수정하기</a></td>
				<td><a href="/myapp/admin/delete/${row.cafe_code}">삭제하기</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>