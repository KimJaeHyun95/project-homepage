<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<tiles:insertAttribute name="header"></tiles:insertAttribute>
	<tiles:insertAttribute name="content"></tiles:insertAttribute>
	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
</body>
</html>