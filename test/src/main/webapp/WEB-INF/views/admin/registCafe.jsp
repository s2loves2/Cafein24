<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<h2 style="text-align: center;">카페 등록하기</h2>
	<form name="form1" method="post" action="insert.do">
		<table border="1" style="margin-left: auto; margin-right: auto;">
			<tr>
				<td>코드</td>
				<td><input name="cafe_code"></td>
			</tr>
			<tr>
				<td>카페명</td>
				<td><input name="cafe_name"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="cafe_addr"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input name="cafe_tel"></td>
			</tr>
			<tr>
				<td>카페 이미지</td>
				<td><input type="file" name="cafe_img"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="등록">
					<input type="reset" value="취소"></td>
			</tr>

		</table>
	</form>

</body>
</html>