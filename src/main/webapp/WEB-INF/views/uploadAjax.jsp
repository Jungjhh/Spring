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
		
		function getImageLink(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);
			
			return front+end;
			
		}
		function getOriginalImageName(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			var idx = fileName.indexOf("_")+1;
			var idx2 = fileName.indexOf("_", idx);
			return fileName.substr(idx2);
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
										+"<a href='displayFile?fileName="+getImageLink(data)+"' target='_blank'>"
										+ "<img src='displayFile?fileName="
										+ data + "'/>" + getOriginalImageName(data) + "</a>"
										+"<small data-src="+data+"> X</small></div>";

							} else {
								str = "<div><a href='displayFile?fileName="+data+"'>" + getOriginalName(data) +"</a>"
								+"<small data-src="+data+"> X</small></div>";
							}
							$(".uploadedList").append(str);
						}

					})

					event.preventDefault();
				})
				
	</script>
	<script>
		$(".uploadedList").on("click", "small", function(event){
			
			var that=$(this);
			
			console.log(that);
			
			$.ajax({
				url:"deleteFile",
				type:"post",
				data:{fileName:$(this).attr("data-src")},
				dataType:"text",
				success:function(result){
					if(result=='deleted'){
						alert("삭제됐다!!")
						that.parent("div").remove();
					}
				}
				
			})
				
		})
	</script>

</body>
</html>