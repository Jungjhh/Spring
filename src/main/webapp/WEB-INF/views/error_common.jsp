<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="board/header.jsp" %>
<body>
<h2>에러가 떴어염 >_< </h2>
<h4>${exception.getMessage() }</h4>
<ul>
	<c:forEach items="${exception.getStackTrace() }" var="stack">
		<li>${stack.toString()}</li>
	</c:forEach>
	
</ul>

</body>
</html>