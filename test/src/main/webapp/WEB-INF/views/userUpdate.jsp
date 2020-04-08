<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
</head>
<body>
	<h1>회원정보수정</h1>
	<form action="memberUpdate.do" method="POST">
		<input type="text" name="user_id" value="${user.user_id}" readOnly> <br>
		<input type="text" name="user_nickName" value="${user.user_nickName}" placeholder="닉네임"> <br>
		<input type="password" name="user_pw" placeholder="비밀번호"> <br>
		<input type="password" placeholder="비밀번호 확인"> <br>
		<input type="text" name="user_tel" value="${user.user_tel}" placeholder="연락처"> <br>
		<input type="submit" value="수정하기">
	</form>
</body>
</html>