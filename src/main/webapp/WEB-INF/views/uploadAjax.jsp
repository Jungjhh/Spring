<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
.fileDrop {
	width: 100%;
	height: 200px;
	border: 1px dotted blue;
}
</style>
</head>
<body>
	<h3>Ajax를 통한 업로드</h3>
	<div class="fileDrop"></div>
	<div class="uploadedList"></div>

	<script>
		function checkImageType(fileName) {

			var pattern = /jpg$|gif$|png$|jpeg$/i;

			return fileName.match(pattern);
		}
		
		
		function getOriginalName(fileName){
			if(checkImageType(fileName)){
				return;
			}
			var idx = fileName.indexOf("_")+1;
			return fileName.substr(idx);
			
		}
		
		$(".fileDrop").on("dragenter dragover", function(event) {
			console.log("왔다리갔다리")
			event.preventDefault();
		})
		$(".fileDrop").on(
				"drop",
				function(event) {

					var files = event.originalEvent.dataTransfer.files;
					var file = files[0]

					var formData = new FormData();
					formData.append("file", file);

					$.ajax({
						url : '/uploadAjax',
						data : formData,
						dataType : 'text',
						processData : false,
						contentType : false,
						type : 'POST',
						success : function(data) {
							var str = "";
							console.log(data);

							if (checkImageType(data)) {
								str = "<div>"
										+ "<img src='displayFile?fileName="
										+ data + "'/>" + data + "<div>";

							} else {
								str = "<div><a href='displayFile?fileName="+data+"'>" + getOriginalName(data) +"</div>"
							}
							$(".uploadedList").append(str);
						}

					})

					event.preventDefault();
				})
	</script>

</body>
</html>