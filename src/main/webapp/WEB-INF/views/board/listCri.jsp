<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<body>
	<table>
		<tr>
			<th>bno</th>
			<th>title</th>
			<th>writer</th>
			<th>content</th>
			<th>viewcnt</th>
		</tr>
		<c:forEach items="${list}" var="bb">
			<tr>
				<td>${bb.bno }</td>
				<td><a href="/board/read?bno=${bb.bno}">${bb.title }</a></td>
				<td>${bb.writer}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
						value="${bb.regdate}" /></td>
				<td>${bb.viewcnt }</td>
			</tr>
		</c:forEach>
	</table>
	<script>
		var a = '${result}';
		if (a == "success") {
			alert("됐다!!!!!!!!!")
		}
	</script>

</body>
</html>