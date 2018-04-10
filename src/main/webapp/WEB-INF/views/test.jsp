<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	<style>
		#modDiv{
		width:300px;
		height:100px;
		background-color:gray;
		position:absolute;
		top:50%;
		left:50%;
		margin-top:-50px;
		margin-left:-150px;
		padding:10px;
		z-index:1000;
		}
	</style>
</head>
<body>
	<h2>Ajax Test Page</h2>

	<div>
		<div>
			replyer<input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			text<input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn">Add Reply</button>
	</div>

	<ul id="replies">

	</ul>
	
	<ul class='pagination'>
	
	</ul>
		
		
	<div id=modDiv style="display:none;">
		<div id="modtitle"></div>
		<input type="text" id="replytext">
		<button type="button" id="replyModBtn">Modify</button>
		<button type="button" id="replyDelBtn">delete</button>
		<button type="button" id="closeBtn">Close</button>
	</div>
	<script>
		var bno = 1372;
		var replyPage =1;

		function getAllList() {
			$.getJSON("/replies/all/" + bno,function(data) {
				var str = "";
				console.log(data.length)
				$(data).each(function() {
					str += "<li data-rno='"+this.rno+"' class='replyLi'>"
						+ this.rno
						+ ":"
						+ this.replytext
						+"<button>MOD</button>"
						+ "</li>";
						})
				$("#replies").html(str);
			})
		}
		
		function printPaging(pageMaker){
			var str="";
			
			if(pageMaker.prev){
				str+="<li><a href='"+(pageMaker.startPage-1)+"'> 전 </a></li>";
			}
			for(var i=pageMaker.startPage, len=pageMaker.endPage;i<=len;i++){
				var strClass=pageMaker.cri.page==i?'class=active':'';
				str +="<li "+strClass+"><a href="+i+">"+i+"</a></li>";
			}
			if(pageMaker.next){
				str+="<li><a href='"+(pageMaker.endPage+1)+"'> 후 </a></li>";
			}
			$('.pagination').html(str);
			
		}
		
		
		$(".pagination").on("click", "li a", function(event){
			
			event.preventDefault();
			
			replyPage = $(this).attr("href");
			getPageList(replyPage)
			
		})
		
		function getPageList(page){
			$.getJSON("/replies/"+bno+"/"+page, function(data){
				console.log(data);
				
				var str="";
				
				$(data.list).each(function(){
					str += "<li data-rno="+this.rno+" class='replyLi'>"
					+this.rno+":"+this.replytext
					+"<button>MOD</button> </li>";
				})
				$("#replies").html(str);
				
				printPaging(data.pageMaker);
				
			})
		}
		
		
		$("#replies").on("click", ".replyLi button", function(){
			var reply = $(this).parent();
			
			var rno=reply.attr("data-rno");
			var replytext = reply.text();
			alert(rno+"번 : "+replytext);
			
			$("#modtitle").html(rno);
			$("#replytext").val(replytext);
			$("#modDiv").show("slow");
			
		})
		$("#replyAddBtn").on("click", function() {
				var replyer = $("#newReplyWriter").val();
				var replytext = $("#newReplyText").val();
				var bno = 1372;

				console.log("됐당께")

				$.ajax({
					type : 'post',
					url : '/replies',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : 'text',
					data : JSON.stringify({
						bno : bno,
						replyer : replyer,
						replytext : replytext
					}),
					success : function(result) {
						if (result == 'success') {
							alert("등록 성공!");
							getPageList(replyPage);
						}
					}
				})
		})
		
		$("#replyDelBtn").on("click", function(){
			
			var rno=$('#modtitle').html();
			var replytext=$('#replytext').val();
			
			$.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"DELETE"
				},
				dataType:'text',
				success:function(result){
					console.log("result:"+result);
					if(result=="success"){
						alert("삭제 성공!");
						$("#modDiv").hide("slow");
						getPageList(replyPage);
					}
				}
			})
		})
		$("#replyModBtn").on("click", function(){
			var rno=$("#modtitle").html();
			var replytext=$("#replytext").val();
			
			$.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers:{
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"PUT"
				},
				dataType:'text',
				data:JSON.stringify({
					replytext:replytext
				}),
				success:function(result){
					console.log("result:"+result);
					if(result=='success'){
						alert("수정 완료!")
						$("#modDiv").hide("slow");
						getPageList(replyPage)
					}
				}
				
			
			})
		})
			
		$(function() {
			var bno=1372;
			getPageList(replyPage);	
		})
	</script>
</body>
</html>