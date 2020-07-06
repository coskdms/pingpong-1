<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty lddto}">
			ㅠㅠ
		</c:when>
		<c:otherwise>
			글번호: ${lddto.seq}<br>
			작성자: ${lddto.id}<br>
			카테고리: ${lddto.category}<br>
			내용: ${lddto.contents}<br>
			부모: ${lddto.parent_seq}
		</c:otherwise>
	</c:choose>
</body>
</html>