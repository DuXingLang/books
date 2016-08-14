<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.BookSingle"%>
<%@ page import="toolbean.MyTools"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>图书详细信息</title>
<link rel="stylesheet" type="text/css" href="css/detail.css"/>
<script type="text/javascript">
	function countdown(){
		var num = document.getElementById("num").value;
		if(num>1){
			num=num-1;
		}else{
			num=1;
		}
		document.getElementById("num").value=num;
	}
	function countup(){
		var count = parseInt(document.getElementById("count").value);
		var num = parseInt(document.getElementById("num").value);
		if(num<count){
			num=num + 1;
		}else{
			num=count;
		}
		document.getElementById("num").value=num;
	}
	function doSubmit(myId){
		var num = document.getElementById("num").value;
		window.location.href="docar.jsp?action=buy&id="+myId+"&num="+num;
		return false;
	}
</script>
</head>
<body>
<%
	ArrayList bookslist = (ArrayList) session.getAttribute("bookslist");
	int id = MyTools.strToint(request.getParameter("id"));
	int cpage = MyTools.strToint(request.getParameter("cpage"));
	BookSingle single = (BookSingle) bookslist.get(id);
%>
	<div class="header">
		<h2 class="title">欢迎购买图书</h2>
		<a class="getback" href="fenyeShow.jsp?cpage=<%=cpage%>">返回</a>
		<input type="text" id="count" value="<%=single.getBookCount() %>" />
	</div>
	<div class="main-1">
		<img src="d:\\booksImg\<%=single.getBookImg() %>" alt="书籍图片" />
		<div class="text">
			<span class="bookName"><%=single.getBookName() %></span>
			<span class="bookAuthor">作者：<%=single.getBookAuthor() %></span>
			<span class="bookPublish">出版社：<%=single.getBookPublish() %></span>
			<em class="bookPrice">价格：￥<%=single.getBookPrice() %></em>
			<em class="bookCount" id="bookCount">库存：<%=single.getBookCount() %></em>
			<span>数量：<b onclick="countdown()">-</b><input type="text" name="num" id="num" value="1" /><b onclick="countup()">+</b></span>
			<!--<span>数量：<input type="text" name="num" id="num" value="1" readonly/></span>-->
			<!--<a href="docar.jsp?action=buy&id=<%=id%>" class="dogood">购买</a>-->
			<a href="javascript:doSubmit('<%=id %>')" class="dogood">购买</a>
		</div>
		<div class="main-2">
			<h2>详细介绍</h2>
			<div class="mainbody">
				<p>jsp编程教程是一本很好的jsp学习教材</p>
			</div>
		</div>
	</div>
</body>
</html>