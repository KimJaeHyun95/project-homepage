<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
<body style="width: 500px; margin: auto;">
	<h1><a href="/home">home</a></h1>

	<h3>Upload</h3>
	<form action="upload" method="post" enctype="multipart/form-data">
			<c:set var="id" value="${id }" />
			<input type="hidden" name="author" value="${id}">
			<label>title</label><input class="form-control" type="text" name="title" required="required"><br>			
			<div class="form-group">
				<label for="comment">Comment:</label>
				<textarea class="form-control" rows="5" id="comment" name="contents" required="required"></textarea>
				<input readonly="readonly" id="byte" style="width: 60px; margin-left: 358px;" value="0"> / 380(byte)	
			</div>
			<label>File</label><input type="file" name="files" multiple="multiple"><br>
			<button type="submit" class="btn btn-info">submit to upload</button>
			<a href="/board/1" class="btn btn-info" role="button">list</a>
	</form>
	<script type="text/javascript">
	$(document).ready( function() {
        $("#comment").on("propertychange change keyup paste input", function(){
                        
            var thisObject = $(this);
            
            var limit = 380; 
            var str = thisObject.val();
            var strLength = 0;
            var strTitle = "";
            var strPiece = "";
            var check = false;
                    
            for (i = 0; i < str.length; i++){
                var code = str.charCodeAt(i);
                var ch = str.substr(i,1).toUpperCase();
                strPiece = str.substr(i,1)
                
                code = parseInt(code);
                
                if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
                    strLength = strLength + 3; 
                }else{
                    strLength = strLength + 1;
                }
                if(strLength>limit){ 
                    check = true;
                    break;
                }else{
                    strTitle = strTitle+strPiece; 
        	        $("#byte").val(strLength);
                }
            }
            
            if(check){
                alert("characters has been exceeded.");
            }
            
            thisObject.val(strTitle);
            
        });
    });
    
	
</script>
</body>
</html>