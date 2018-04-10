<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<body>
	<form role="form" method="post">
		<input type="text" name="bno" value="${boardVO.bno }"
			readonly="readonly">
	</form>
	<div>title</div>
	<input type="text" value="${boardVO.title }" readonly="readonly">
	<div>content</div>
	<input type="text" value="${boardVO.content }" readonly="readonly">
	<div>writer</div>
	<input type="text" value="${boardVO.writer }" readonly="readonly">

	<button type="submit" class="btn1">modify</button>
	<button type="submit" class="btn2">remove</button>
	<button type="submit" class="btn3">listAll</button>

	<script>
		$(function() {
			var formObj = $("form[role = 'form']");
	
			console.log(formObj);
	
			$('.btn1').on("click", function() {
				formObj.attr("action", "/board/modify");
				formObj.attr("method", "get");
				formObj.submit();
			})
			$('.btn2').on("click",function(){
				formObj.attr("action","/board/remove")
				formObj.submit();
			})
			$('.btn3').on("click", function(){
				self.location="/board/listAll";
			})
		})
	</script>

</body>
</html>