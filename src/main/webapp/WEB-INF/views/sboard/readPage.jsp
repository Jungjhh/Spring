<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../board/header.jsp"%>
<body>
	<form role="form" method="post">
		<input type="text" name="bno" value="${boardVO.bno }"
			readonly="readonly"> <input type="text" name='page'
			value="${cri.page}"> <input type="text" name='perPageNum'
			value="${cri.perPageNum}"> <input type="text"
			name='searchType' value="${cri.searchType }"> <input
			type="text" name='keyword' value="${cri.keyword }">
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
	<br>
	<br>
	
	<div class="row">
		<h3>ADD NEW REPLY</h3>
		<input type="text" placeholder="user id" id="newReplyWriter">
		<input type="text" placeholder="reply text" id="newReplyText">
		<button type="submit" id="replyAddBtn">add reply</button>
	</div>

	<ul class="timeline">
		<li id="repliesDiv"><span>Replies List</span></li>
	</ul>
	
	
	<div>
		<ul id="pagination" class="pagination">

		</ul>
	</div>
	
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog"  style="z-index:1050">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" style="position:absolute; right:10px; top:10px;">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p>
						<input type="text" id="replytext" class="form-control">
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="bt btn-info" id="replyModBtn" data-toggle="modal"
								data-target="#modifyModal">Modify</button>
					<button type="button" class="bt btn-danger" id="replyDelBtn" data-toggle="modal"
								data-target="#modifyModal">Delete</button>
					<button type="button" class="bt btn-default" data-toggle="modal"
								data-target="#modifyModal">Close</button>
				</div>
			</div>
		</div>
	</div>
				
		<script id="template" type="text/x-handlebars-template">
			{{#each .}}
				<li class="replyLi" data-rno={{rno}}>
					<i class="fa fa-comments bg-blue"></i>
					<div class="timeline-item">
						<span>날짜 : {{prettifyDate
							regdate}}</span>
						<div>글 번호 : {{rno}}</div>
						<div>아이디 : {{replyer}}</div>
						<span>댓글 : </span><span class="timeline-body">{{replytext}}</span>
						<div class="timeline-footer">
							<a class="btn btn-primary btn-xs" data-toggle="modal"
								data-target="#modifyModal">Modify</a>
						</div>
					</div>
				</li>			
			{{/each}}
		</script>
	
	
	<script>

	var bno = ${boardVO.bno};
	var replyPage = 1;
	
	var printData = function(replyArr, target, templateObject) {
		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	};
	
	var printPaging = function(pageMaker, target) {
		var str = "";
		if (pageMaker.prev) {
			str += "<li><a href=" + (pageMaker.startPage - 1)
					+ "> 전 </a></li>";
		}
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? "class=active" : "";
			str += "<li " +strClass+"><a href="+i+">" + i + "</a></li>"
		}

		if (pageMaker.next) {
			str += "<li><a href=" + (pageMaker.endPage + 1)
					+ "> 후 </a></li>";
		}
		target.html(str)
	};
	
	function getPage(pageInfo) {
		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

		})
	}
	
	$(".timeline").on("click", ".replyLi", function(event){
		var reply = $(this);
		
		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));
	
	
	})

	</script>
	<script>
		$(function() {
			if ($(".timeline li").length > 1) {
				console.log("댓글있자너ㅎ")
				return;

			}
			getPage("/replies/" + bno + "/1");

		})
		$(".pagination").on("click", "li a", function(event) {
			event.preventDefault();

			replyPage = $(this).attr("href");
			getPage("/replies/" + bno + "/" + replyPage);
		})
	</script>


	<script>
		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" + date;

		})


	</script>
	<script>
		$("#replyAddBtn").on("click", function(){
			
			var replyerObj = $("#newReplyWriter");
			var replytextObj = $("#newReplyText");
			var replyer = replyerObj.val();
			var replytext = replytextObj.val();
			
			$.ajax({
				type:'post',
				url:'/replies/',
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType:'text',
				data:JSON.stringify({
					bno:bno,
					replyer:replyer,
					replytext:replytext
				}),
				success:function(result){
					console.log("result:"+result);
					if(result=='success'){
						replyPage=1;
						getPage("/replies/"+bno+"/"+replyPage);
						replyerObj.val("");
						replytextObj.val("");
						alert("등록 완료")
					}
				}
				
			})
			
		})
		$("#replyModBtn").on("click",function(){
		
			var rno=$(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"put"
				},
				dataType:'text',
				data:JSON.stringify({
					replytext:replytext
				}),
				success:function(result){
					if(result=='success'){
						getPage("/replies/"+bno+"/"+replyPage);
						alert("수정 성공!")
					}
				}
				
			})
			
		})
		
		$("#replyDelBtn").on("click", function(){
			
			var rno=$(".modal-title").html();
			var replytext=$("#replytext").val();
			
			$.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":'delete'
				},
				dataType:'text',
				success:function(result){
					console.log("result:"+result);
					if(result=='success'){
						getPage("/replies/"+bno+"/"+replyPage);
						alert("삭제 됐다!")
					}
				}
				
			})
			
		})
		
	</script>
	<script>
		$(function() {
			var formObj = $("form[role = 'form']");

			console.log(formObj);

			$('.btn1').on("click", function() {
				formObj.attr("action", "/sboard/modifyPage");
				formObj.attr("method", "get");
				formObj.submit();
			})
			$('.btn2').on("click", function() {
				formObj.attr("action", "/sboard/removePage")
				formObj.submit();
			})
			$('.btn3').on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/sboard/list");
				formObj.submit();
			})
		})
	</script>


</body>
</html>