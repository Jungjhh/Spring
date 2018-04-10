<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<body>

<form role="form" method="post">
	<div>
		<span>title</span>
		<input type="text" name="title">		
	</div><div>
		<span>content</span>
		<input type="text" name="content">		
	</div><div>
		<span>writer</span>
		<input type="text" name="writer">		
	</div>
	<button type="submit">제출하시오</button>
</form>

</body>
</html>