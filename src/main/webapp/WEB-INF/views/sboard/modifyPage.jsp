<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../board/header.jsp"%>
<body>
	<form role="form" action="modifyPage" method="post">
		<input type="text" name="bno" value="${boardVO.bno }"> <input
			type="text" name="page" value="${cri.page }"> <input
			type="text" name="perPageNum" value="${cri.perPageNum }"> <input
			type="text" name="keyword" value="${cri.keyword }"> <input
			type="text" name="searchType" value="${cri.searchType }">
		<div>title</div>
		<input type="text" value="${boardVO.title }" name="title">
		<div>content</div>
		<input type="text" value="${boardVO.content }" name="content">
		<div>writer</div>
		<input type="text" value="${boardVO.writer }" readonly="readonly"
			name="writer">

		<button type="button" class="btn1">save</button>
		<button type="button" class="btn2">cancel</button>

	</form>
	<script>
		$(function() {
			var formObj = $("form[role='form']");

			$(".btn1").on('click', function() {
				formObj.submit();
			})
			$(".btn2")
					.on(
							"click",
							function() {
								self.location = "/sboard/list?page=${cri.page}&perPageNum=${cri.perPageNum}&keyword=${cri.keyword}&searchType=${cri.searchType}";
							})

		})
	</script>

</body>
</html>