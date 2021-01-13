<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body style="width: 300px; margin: auto;" >
	<h1><a href="/home">home</a></h1>
	<c:set var="login_result" value="${login_result }"/>
	<form action="/login" method="post">
			<label>id</label><input id="id" class="form-control" type="text" name="uid" required="required"><br>
			<label>password</label><input class="form-control" type="password" name="upw" required="required">	
			<c:if test="${login_result==true }">
			<div style="color: red; font-size:small; word-spacing:-1px;">This ID is not registered or Password does not match.</div>
			</c:if>
			<br>
			<button type="submit" class="btn btn-info">Sign in</button>
	</form>

<a href="/create_account">Create account</a><br><a href="/forgot">Forgot your id/password?</a>
</body>
</html>