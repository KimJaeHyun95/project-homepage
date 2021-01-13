<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">
a {
	text-decoration: none;
}

.pagination {
	margin-left: 50px
}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>

</head>
<body style="margin: auto; width: 600px;">
	<h1 style="display: inline;"><a href="/home">home</a></h1>
	<c:set var="login_status" value="${login_status }"/>
	<c:if test="${login_status==true }">
		<h3 style="display: inline;"><a class="btn btn-info" href="/logout" style="position: relative; left: 390px;">Sign out</a></h3>
	</c:if>
	<c:if test="${login_status!=true }">
		<h3 style="display: inline;"><a class="btn btn-info" href="/loginform" style="position: relative; left: 390px;">Sign in</a></h3>
	</c:if>

	<h3>Search List</h3>
	<table class="table table-hover">
		<tr>
			<th>num</th>
			<th>author</th>
			<th>title</th>
			<th>wdate</th>
		</tr>

				<c:forEach var="u" items="${pageList.list }">
					<tr>
						<td>${u.num }</td>
						<td>${u.author }</td>
						<td><a href="/details?num=${u.num}">${u.title}</a></td>
						<td>
							<fmt:parseDate value="${u.wdate}" var="boarddate" pattern="yy-MM-dd"></fmt:parseDate>
							<fmt:formatDate value="${boarddate}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${pageList.pages<5 }">
					<tr>
					<td colspan="4" style="text-align: center; padding-left: 150px;">
					
					<ul class="pagination">
						<c:forEach var="d" begin="1"
							end="${pageList.pages }">
							<c:if test="${pageList.pageNum eq d }">
								<li class="page-item"><a class="page-link" href="#"
									style="font-weight: bold;  color: blue;">${d}</a></li>
							</c:if>
							<c:if test="${pageList.pageNum ne d }">
								<li class="page-item"><a class="page-link"
									href="/search/${d}">${d}</a></li>
							</c:if>

						</c:forEach>
					</ul>
					</td>
					<tr>
				</c:if>
				
				<c:if test="${pageList.pages>4 }">
					<tr>
						<td colspan="4" style="text-align: center; padding-left: 150px;">
							<c:if test="${pageList.pageNum == 1 }">
								<ul class="pagination">
	
									<c:forEach var="d" begin="${pageList.pageNum}"
										end="${pageList.pageNum+4 }">
										<c:if test="${pageList.pageNum eq d }">
											<li class="page-item"><a class="page-link" href="#"
												style="font-weight: bold;  color: blue;">${d}</a></li>
										</c:if>
										<c:if test="${pageList.pageNum ne d }">
											<li class="page-item"><a class="page-link"
												href="/board/${d}">${d}</a></li>
										</c:if>
	
									</c:forEach>
								</ul>
	
							</c:if> <c:if test="${pageList.pageNum == 2 }">
								<ul class="pagination">
	
									<c:forEach var="d" begin="1" end="5">
										<c:if test="${pageList.pageNum eq d }">
											<li class="page-item"><a class="page-link" href="#"
												style="font-weight: bold; color: blue;">${d}</a></li>
										</c:if>
										<c:if test="${pageList.pageNum ne d }">
											<li class="page-item"><a class="page-link"
												href="/board/${d}">${d}</a></li>
										</c:if>
									</c:forEach>
								</ul>
	
							</c:if> <c:if
								test="${pageList.pages-pageList.pageNum >1 and pageList.pageNum !=1 and pageList.pageNum !=2}">
								<ul class="pagination">
	
									<c:forEach var="d" begin="${pageList.pageNum-2 }"
										end="${pageList.pageNum+2 }">
										<c:if test="${pageList.pageNum eq d }">
											<li class="page-item"><a class="page-link" href="#"
												style="font-weight: bold; color: blue;">${d}</a></li>
										</c:if>
										<c:if test="${pageList.pageNum ne d }">
											<li class="page-item"><a class="page-link"
												href="/board/${d}">${d}</a></li>
										</c:if>
									</c:forEach>
								</ul>
	
							</c:if> <c:if test="${pageList.pages-pageList.pageNum == 1}">
								<ul class="pagination">
	
									<c:forEach var="d" begin="${pageList.pageNum-3 }"
										end="${pageList.pageNum+1 }">
	
										<c:if test="${pageList.pageNum eq d }">
											<li class="page-item"><a class="page-link" href="#"
												style="font-weight: bold; color: blue;">${d}</a></li>
										</c:if>
										<c:if test="${pageList.pageNum ne d }">
											<li class="page-item"><a class="page-link"
												href="/board/${d}">${d}</a></li>
										</c:if>
									</c:forEach>
								</ul>
	
							</c:if> <c:if test="${pageList.pages-pageList.pageNum == 0}">
								<ul class="pagination">
	
									<c:forEach var="d" begin="${pageList.pageNum-4 }"
										end="${pageList.pageNum }">
										<c:if test="${pageList.pageNum eq d }">
											<li class="page-item"><a class="page-link" href="#"
												style="font-weight: bold; color: blue;">${d}</a></li>
										</c:if>
										<c:if test="${pageList.pageNum ne d }">
											<li class="page-item"><a class="page-link"
												href="/board/${d}">${d}</a></li>
										</c:if>
									</c:forEach>
								</ul>
	
							</c:if></td>
					</tr>
				</c:if>
			
	</table>

	<a href="/board/1" class="btn btn-info" role="button">Go back to list</a>

	<form action="/search/1" method="post" style="display: inline;">
		<select name="search_as">
			<option value="title">title</option>
			<option value="author" >author</option>
		</select> <input type="text" name="search"  required="required"> <input type="submit" value="search" class="btn btn-info" role="button">
	</form>
	<br><br><br><br><br><br>

</body>
</html>