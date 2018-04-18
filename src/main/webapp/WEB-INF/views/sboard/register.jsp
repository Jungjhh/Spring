<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../board/header.jsp"%>
<body>

	<form role="form" method="post" id="registerForm">
		<div>
			<span>title</span> <input type="text" name="title">
		</div>
		<div>
			<span>content</span> <input type="text" name="content">
		</div>
		<div>
			<span>writer</span> <input type="text" name="writer" value='${login.uid }'>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">File DROP here</label>
			<div class="fileDrop"></div>

		</div>
		<div>
			<ul class="mailbox-attachments clearfix uploadedList">
			
			</ul>
		</div>

		<button type="submit">제출하시오</button>
	</form>
	<script>
		var a = '${msg}'

		if (a == "regist") {
			alert("등록 성공!")
		}
	</script>
	<script id="template" type="text/x-handlebars-template">
		
<li class="upload">
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
	<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		<span data-src="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"></span>
<small data-src="{{fullName}}">X</small>
	</div>
</li>
</script>

<script>

	var template = Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	
	})
	
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		
		var file=files[0];
		
		var formData = new FormData();
		
		formData.append("file", file);
		
		$.ajax({
			url:'/uploadAjax',
			data:formData,
			dataType:'text',
			processData:false,
			contentType:false,
			type:'POST',
			success:function(data){
				
				var fileInfo = getFileInfo(data);
				
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
				
			}
			
		})
		
	})
	
	$("#registerForm").submit(function(event){
		
		event.preventDefault();
		
		var that = $(this);
		
		console.log(that);
		var str="";
		
		$(".uploadedList .delbtn").each(function(index){
			
			str+="<input type='hidden' name='files["+index+"]' value='"+$(this).attr("data-src")+"'>";
			console.log(this);
			
		})
		
		that.append(str);
		
		that.get(0).submit(); 
		 
	})
	
	$(".uploadedList").on("click", "small", function(event){
		
		var that = $(this);
		
		console.log(that);
		
		$.ajax({
			
			url:"/deleteFile",
			type:"post",
			data:{fileName:$(this).attr("data-src")},
			dataType:"text",
			success:function(result){
				if(result=='deleted'){
					alert("deleted!")
					that.parent("div").parent("li").remove();
				}
			}
			
		})
		
	})
</script>
</body>
</html>