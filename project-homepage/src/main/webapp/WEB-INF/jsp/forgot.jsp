<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
<script type="text/javascript">
function idsearch() {
	$.ajax({
		url : '/idSearch',
		method : 'post',
		data : {'name' : $('#uname').val(),
			'phone':$('#uphone').val()},
		dataType : 'text',
		success : function(res) {
			$('#idsearch').text("Your ID is \""+res+"\"")
		},
		error : function(xhr, status, err) {
			alert("A matching ID cannot be found.");
			location.reload();
		}
	});
}

</script>
</head>
<body style="width: 300px; margin: auto;" >
	<h1><a href="/home">home</a></h1>

	<label>name</label><input class="form-control" type="text" id="uname" name="name" required="required"><br>
	<label>phone</label><input class="form-control" type="text" id="uphone" name="phone" required="required"><br>	
	<button type="button" class="btn btn-info" onclick="javascript:idsearch()">ID Search</button>
	<div id="idsearch"></div>

	
<br>
<a href="/create_account">Create account</a>
</body>
</html>