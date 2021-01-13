<%@page import="java.io.IOException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="EUC-KR">
<title>Guest Book</title>

</head>
<body style="margin: auto; width: 400px;">
	<h1><a href="/home">home</a></h1>

	<h3>update form</h3>
	<c:set var="u" value="${list}"></c:set>

	<form action="/update" method="post" enctype="multipart/form-data" style="display: inline;">
		<input type="hidden" name="num" value="${u.num }">
		<input type="hidden" name="author" value="${u.author }"> 
		<input type="hidden" name="wdate" value="${u.wdate }"> num : ${u.num}<br> author : ${u.author }<br>
		<label>title:</label><input class="form-control" style="display: inline;" type="text" name="title" value="${u.title }" required="required" ><br>
		<div class="form-group">
			<label for="comment">Comment:</label>
			<textarea class="form-control" rows="5" id="comment" name="contents" required="required">${u.contents }</textarea>
		</div>
		<label>File</label><input type="file" name="files" multiple="multiple"><br>
		<button type="submit" class="btn btn-info">submit to update</button>
	</form>

	<a href="/board/1" class="btn btn-info" role="button">list</a>
</body>
</html>