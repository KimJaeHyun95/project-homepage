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
	<script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
	<meta charset="EUC-KR">
</head> 

<body style="width: 300px; margin: auto;">
	<h1><a href="/home">home</a></h1>
	<form action="/create_account" method="post" onsubmit="return didCheck()">
			<label>name</label><input class="form-control" type="text" name="name" required="required"><br> 
			<label>phone</label><input id="phone" class="form-control" type="text" name="phone" required="required">
				<button class="btn btn-info" type="button" onClick="phoneCheck(this.form.phone.value)" style="margin-top: 5px">Redundancy check phone number</button>
				<i id="phone_check" class="far fa-check-circle" style="color: rgb(0,123,255); font-size: 22px; position: relative; bottom: 35px; visibility: hidden;"></i>
				<i id="phone_ncheck"  class="far fa-times-circle" style="    color: darkred; font-size: 22px; position: relative; bottom: 72px; left: 270px; visibility: hidden; ;"></i><br>	
			<label>id</label><input id="id" class="form-control" type="text" name="id" required="required">
				<button class="btn btn-info" type="button" onClick="idCheck(this.form.id.value)" style="margin-top: 5px">Redundancy check ID</button><br> 
				<i id="id_check" class="far fa-check-circle" style="color: rgb(0,123,255); font-size: 22px; position: relative; bottom: 72px; left: 271px; visibility: hidden;"></i>
				<i id="id_ncheck"  class="far fa-times-circle" style="    color: darkred; font-size: 22px; position: relative; bottom: 72px; left: 245px; visibility: hidden;"></i><br>	
			<label>password</label><input class="form-control" type="password" id="pw" name="pw" required="required"><br>
			<label>password check</label><input class="form-control" type="password" id="repw" required="required"><br>			
			<button type="submit" class="btn btn-info">create</button>
	</form>

	<script type="text/javascript">
var check=false;
var check_phone=false;
	$("#id").change(function(){
		check=false;
		$('#id_check').css('visibility', 'hidden')
		$('#id_ncheck').css('visibility', 'visible')
	});
	$("#phone").change(function(){
		check_phone=false;
		$('#phone_check').css('visibility', 'hidden')
		$('#phone_ncheck').css('visibility', 'visible')
	});


function idCheck(id) {
	if(id==null){
		alert("ID CAN NOT USE");
	}else{
		$.ajax({
			url : '/idCheck',
			method : 'post',
			data : {'id' : id},
			dataType : 'text',
			success : function(res) {
				if(res=='true'){
					check=true;
					$('#id_check').css('visibility', 'visible')
					$('#id_ncheck').css('visibility', 'hidden')
					alert('You can use this ID.')
				}else{
					alert("ID CAN NOT USE");
					$('#id').val('');
				}
			},
			error : function(xhr, status, err) {
				alert(status + ',' + err);
			}
		});
	}
}
function phoneCheck(phone) {
	if(id==null){
		alert("Phone-number CAN NOT USE");
	}else{
		$.ajax({
			url : '/phoneCheck',
			method : 'post',
			data : {'phone' : phone},
			dataType : 'text',
			success : function(res) {
				if(res=='true'){
					check_phone=true;
					$('#phone_check').css('visibility', 'visible')
					$('#phone_ncheck').css('visibility', 'hidden')
					alert('You can use this Phone-Number.')
				}else{
					alert("Phone number can NOT use");
					$('#phone').val('');
				}
			},
			error : function(xhr, status, err) {
				alert(status + ',' + err);
			}
		});
	}
}
function didCheck() {
	if(($('#pw').val()==$('#repw').val())==false){
		alert("Password does not match.");
		return false;
	}else if(check==false){
		alert('Please check ID Redundancy.')
		return false;
	}else if(check_phone==false){
		alert('Please check Phone-Number Redundancy.')
		return false;	
	}else{
		check =check&&check_phone;
		if(!check){
			alert("System error!");
		}
		return check;
	}
}
</script>
</body>
</html>