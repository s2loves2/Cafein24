<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
	<c:set var="user" value="${user}" />
	<c:if test="${user == null}">
		<a href="goJoin">회원가입</a>
		<input type="button" value="로그인" onClick="location.href='goLogin'">
	</c:if>
	<c:if test="${user != null}">
		<a href="myPage.do">마이페이지</a>
		<input type="button" value="로그아웃" onClick="location.href='logout'">
	</c:if>
	
	<br>
	<input type="button" value="시작하기" onClick="location.href='cafeStart'">
</body>
</html>