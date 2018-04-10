<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<body>
	<table>
		<tr>
			<th>bno</th>
			<th>title</th>
			<th>writer</th>
			<th>content</th>
			<th>viewcnt</th>
		</tr>
		<c:forEach items="${list}" var="boardList">
			<tr>
				<td>${boardList.bno }</td>
				<td><a href="/board/readPage${pageMaker.makeQuery(pageMaker.cri.page) }&bno=${boardList.bno}">${boardList.title }</a></td>
				<td>${boardList.writer}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
						value="${boardList.regdate}" /></td>
				<td>${boardList.viewcnt }</td>
			</tr>
		</c:forEach>
	</table>
	<span>page</span><input type="text" value="${pageMaker.cri.page }">
	<span>perPageNum</span><input type="text" value="${pageMaker.cri.perPageNum }">
	<script>
		var a = '${result}';
		if (a == "success") {
			alert("됐다!!!!!!!!!")
		}
		var b = '${msg}';
		if (b == "remove") {
			alert("삭제 됐다!!!!!!!!!")
		}else if(b=="modify"){
			alert("수정 됐다!!")
		}
	</script>

	<div>
		<ul>
			<c:if test="${pageMaker.prev }">
				<li><a href="listPage?page=${pageMaker.startPage -1}">왼쪽</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}"
				var="idx">
				<li <c:out value="${pageMaker.cri.page==idx?' class=active':'' }"/>>
					<a href="listPage?page=${idx}">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage>0 }">
				<li><a href="listPage?page=${pageMaker.endPage +1}">오른쪽</a></li>
			</c:if>
		</ul>
	</div>

</body>
</html>