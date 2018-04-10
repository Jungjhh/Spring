<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<body>
	<form role="form" method="post">
		<input type="text" name="bno" value="${boardVO.bno }"
			readonly="readonly">
			<input type="text" name='page' value="${cri.page}">
			<input type="text" name='perPageNum' value="${cri.perPageNum}"> 
	</form>
	<div>title</div>
	<input type="text" value="${boardVO.title }" readonly="readonly">
	<div>content</div>
	<input type="text" value="${boardVO.content }" readonly="readonly">
	<div>writer</div>
	<input type="text" value="${boardVO.writer }" readonly="readonly">

	<button type="button" class="btn1">modify</button>
	<button type="button" class="btn2">remove</button>
	<button type="button" class="btn3">listAll</button>

	<script>
		$(function() {
			var formObj = $("form[role = 'form']");
	
			console.log(formObj);
	
			$('.btn1').on("click", function() {
				formObj.attr("action", "/board/modifyPage");
				formObj.attr("method", "get");
				formObj.submit();
			})
			$('.btn2').on("click",function(){
				formObj.attr("action","/board/removePage")
				formObj.submit();
			})
			$('.btn3').on("click", function(){
				formObj.attr("method", "get");
				formObj.attr("action", "/board/listPage");
				formObj.submit();
			})
		})
	</script>

</body>
</html>