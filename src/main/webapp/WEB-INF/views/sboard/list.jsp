<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../board/header.jsp"%>
<body>
	<div>
		<select name="selectType">
			<option value="n"
				<c:out value="${cri.searchType==null?'selected':'' }"/>>
				---</option>
			<option value="t"
				<c:out value="${cri.searchType eq 't'?'selected':'' }"/>>
				title</option>
			<option value="c"
				<c:out value="${cri.searchType eq 'c'?'selected':'' }"/>>
				content</option>
			<option value="w"
				<c:out value="${cri.searchType eq 'w'?'selected':'' }"/>>
				writer</option>
			<option value="tc"
				<c:out value="${cri.searchType eq 'tc'?'selected':'' }"/>>
				title or content</option>
			<option value="cw"
				<c:out value="${cri.searchType eq 'cw'?'selected':'' }"/>>
				content or writer</option>
			<option value="tcw"
				<c:out value="${cri.searchType eq 'tcw'?'selected':'' }"/>>
				title or content or writer</option>
		</select> 
		<input type="text" name='keyword' id="keywordInput" value='${cri.keyword}'>
		<button id="searchbtn">Search</button>
		<button id="registerbtn">New Board</button>
	</div>
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
				<td><a
					href="/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${boardList.bno}">${boardList.title }</a></td>
				<td>${boardList.writer}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
						value="${boardList.regdate}" /></td>
				<td>${boardList.viewcnt }</td>
			</tr>
		</c:forEach>
	</table>
	<span>page</span>
	<input type="text" value="${pageMaker.cri.page }">
	<span>perPageNum</span>
	<input type="text" value="${pageMaker.cri.perPageNum }">
	<script>

		var b = '${msg}';
		if (b == "remove") {
			alert("삭제 됐다!!!!!!!!!")
		} else if (b == "modify") {
			alert("수정 됐다!!")
		}

		$(document).ready(
				function() {
					$("#searchbtn").on(
							"click",
							function() {

								self.location = "list"
										+ '${pageMaker.makeQuery(1)}'
										+ "&searchType="
										+ $("select option:selected").val()
										+ "&keyword="
										+ encodeURIComponent($('#keywordInput')
												.val())
							})

					$('#registerbtn').on('click', function() {
						self.location = "register";
					});
				});
	</script>

	<div>
		<ul>
			<c:if test="${pageMaker.prev }">
				<li><a
					href="list${pageMaker.makeSearch(pageMaker.startPage-1) }">왼쪽</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}"
				var="idx">
				<li <c:out value="${pageMaker.cri.page==idx?' class=active':'' }"/>>
					<a href="list${pageMaker.makeSearch(idx)}">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage>0 }">
				<li><a href="list${pageMaker.makeSearch(pageMaker.endPage +1)}">오른쪽</a></li>
			</c:if>
		</ul>
	</div>

</body>
</html>