<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form name="joinForm">
		<input type="text" id="user_id" name="user_id" placeholder="아이디">
		<button type="button" id="id_btn">중복체크</button> <br>
		<input type="password" id="user_pw" name="user_pw" placeholder="비밀번호"> <br>
		<input type="password" id="pw_confirm" placeholder="비밀번호 확인"> <br>
		<input type="text" id="user_nickName" name="user_nickName" placeholder="닉네임">
		<button type="button" id="nickName_btn">중복체크</button> <br>
		<input type="text" id="user_tel" name="user_tel" placeholder="전화번호"> <br>
		<button type="submit" id="join_btn">회원가입</button>
	</form>
</body>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="resources/js/join.js"></script>
</html>