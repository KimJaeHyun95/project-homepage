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
<style type="text/css">
body{ background-image: url(../../image/background.jpg);
	background-repeat: no-repeat;
	background-size: 100%;
}
a{
   font-size: 30pt;
}
</style>
</head>
<body style="text-align: center; margin-top: 300px">
	<c:set var="login_status" value="${login_status }"/>
	<c:if test="${login_status==true }">
		<a href="/board/1">Board-list</a><br>
		<a href="/logout" style="font-size: xx-small;">logout</a><br>
	</c:if>
	<c:if test="${login_status!=true }">
		<a href="/board/1">Board-list</a><br>
		<a href="/loginform">Sign-In</a>
	</c:if>
</body>

</html>