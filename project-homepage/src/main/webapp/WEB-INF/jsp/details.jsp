<%@page import="java.io.IOException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.hover {
	position: relative;
}

.hover span {
	display: none;
}

a.hover:hover span {
	background-color: rgb(220, 234, 253);
	color: black;
	display: block;
	position: absolute;
	top: 3em;
	left: 5em;
	padding: 0.2em 0.6em;
	border: 1px solid black;
	text-decoration: none;
	font-size: 3pt;
	width: 88px;
}
</style>
<meta charset="UTF-8">
<title>details</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js"
	crossorigin="anonymous"></script>

<style type="text/css">
</style>
</head>
<body style="width: 800px; margin: auto;">
	<c:set var="didlike" value="${didlike}" />
	<h1 style="display: inline;">
		<a href="/home">home</a>
	</h1>
	<c:set var="id" value="${id }" />
	<c:set var="login_status" value="${login_status }" />
	<c:if test="${login_status==true }">
		<h3 style="display: inline;">
			<a class="btn btn-info" href="/logout"
				style="position: relative; left: 593px;">Sign out</a>
		</h3>
	</c:if>
	<c:if test="${login_status!=true }">
		<h3 style="display: inline;">
			<a class="btn btn-info" href="/loginform"
				style="position: relative; left: 593px;">Sign in</a>
		</h3>
	</c:if>


	<c:set var="u" value="${list}"></c:set>
	<table class="table table-hover" style="width: 800px; margin: auto;">
		<h3>Post details</h3>
		<tr>
			<td>num: ${u.num }</td>
			<td>title: ${u.title }</td>
			<td>author: ${u.author }</td>
		</tr>
		<tr>
			<td>attachment : <c:forEach var="v" items="${attach}">

					<a class="hover"
						href="/download?u_num=${v.u_num}&file_exe=${v.file_exe }">${v.filename}.${v.file_exe }<span>click
							to download</span></a>
					<c:if test="${login_status==true }">
						<c:if test="${u.author==id}">
							<form action="/delteatt" method="POST" onsubmit="return delatt()"
								style="display: inline;">
								<input type="hidden" name="num" value="${u.num }"> <input
									type="hidden" name="filename" value="${v.filename }">
								<button type="submit" class="btn btn-info">Del</button>
							</form>
						</c:if>
					</c:if>
				</c:forEach>
			</td>
			<td>date : ${u.wdate }</td>
			<td>hit : ${u.hit }</td>
		</tr>
		<tr style="pointer-events: none; border-bottom: hidden;">
			<td style="height: 200px;" colspan="6" style="word-break:break-all;">${u.contents }</td>
		</tr>
	</table>
	<a href="javascript:like(${u.num },'${id}')" class="btn btn-info"
		style="width: 50px; margin-left: 300px; margin-right: 300px; margin-bottom: 10px; font-size: small;">
		<c:if test="${didlike==1 }">
			<i id="like" class="fas fa-heart" style="color: rgb(0, 255, 255)"></i>

		</c:if> 
		<c:if test="${didlike!=1 }">
			<i id="like" class="fas fa-heart"></i>
		</c:if> 
		<span id="like_n">${u.like_n}</span>
	</a>

	<table class="table table-hover" style="width: 800px; margin: auto;">
		<tr>
			<td><a href="javascript:comment_a(${u.num })"
				class="btn btn-info" role="button">Leave a comment</a><a
				href="/board/1" class="btn btn-info" role="button"
				style="margin-left: 5px">list</a></td>
			<td colspan="2" style="text-align: right;"><c:if
					test="${login_status==true }">
					<c:if test="${u.author==id}">
						<form action="/delete" method="POST" onsubmit="return del()"
							style="display: inline;">
							<input type="hidden" name="num" value="${u.num }">
							<button type="submit" class="btn btn-info">Delete</button>
						</form>
						<form action="/update_a" method="POST" onsubmit="return update()"
							style="display: inline;">
							<input type="hidden" name="num" value="${u.num }">
							<button type="submit" class="btn btn-info">Update</button>
						</form>
					</c:if>
				</c:if></td>
		</tr>


	</table>


	<br>

	<script type="text/javascript">
	var didlike=${didlike};
	function like(num, id) {
		
		if(${login_status}==true){
			if(didlike==0){
				//좋아요
				$.ajax({
					url : '/like',
					method : 'post',
					data : {'num' : num,
						'id': id},
					dataType : 'text',
					success : function(res) {
						$('#like').css('color', 'rgb(0, 255, 255)');
						$('#like_n').text(res);
						didlike=1;
					},
					error : function(xhr, status, err) {
						alert("System error");
					}
				});
			}else{
				//좋아요 취소
				$.ajax({
					url : '/like_cancle',
					method : 'post',
					data : {'num' : num,
						'id': id},
					dataType : 'text',
					success : function(res) {
						$('#like').css('color', 'rgb(255,255, 255)');
						$('#like_n').text(res);
						didlike=0;
					},
					error : function(xhr, status, err) {
						alert("System error");
					}
				});
				
			}
		}else alert("Please sign in")
	}
	function del() {
		if(confirm("Are you sure delete it?")){
			return true;		
		}else{
			return false;
		}
	}
	function update() {
		if(confirm("If you proceed with the modification, the attachment will be removed.")){
			return true;
		}else{
			return false;
		}
	}
	function delatt(num,filename) {
		if(confirm("Are you sure you want to delete it?")){
			return true;
		}else{
			return false;
		}
	}
	function comment_a(num) {
		if(${login_status}){
			location.href='/comment_a/'+num;
		}else{
			alert("You can upload after sign in.");
			location.href='/loginform';
		}
	}
</script>
</body>
</html>