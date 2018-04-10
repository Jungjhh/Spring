<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<body>
<form role="form" method="post">
	<div>title</div>
	<input type="text" value="${boardVO.title }" name="title" >
	<div>content</div>
	<input type="text" value="${boardVO.content }" name="content">
	<div>writer</div>
	<input type="text" value="${boardVO.writer }" readonly="readonly" name="writer">

	<button type="submit" class="btn1">save</button>
	<button type="submit" class="btn2">cancel</button>

</form>
<script>
	$(function(){
		var formObj = $("form[role='form']");
		
		$(".btn1").on('click', function(){
			formObj.submit();
		})
		$(".btn2").on("click", function(){
			self.location="/board/listAll";
		})
		
	})
</script>

</body>
</html>