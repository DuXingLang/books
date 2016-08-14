<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.BookSingle"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>图书信息</title>
<link rel="stylesheet" type="text/css" href="css/fenyeShow.css"/>
</head>
<body>
<%
	ArrayList bookslist = (ArrayList) session.getAttribute("bookslist");
%>
	<div class="header">
		<h2 class="title">欢迎购买图书</h2>
		<div class="option">
			<span>图书类别</span>
			<a class="all" href="index.jsp?click=all">全部</a>
			<a class="computer" href="index.jsp?click=computer">计算机类</a>
			<a class="literature" href="index.jsp?click=literature">文学类</a>
			<a class="history" href="index.jsp?click=history">历史类</a>
			<a class="philosophy" href="index.jsp?click=philosophy">哲学类</a>
			<a class="other" href="index.jsp?click=other">其它</a>
			<a class="shopcar" href="shopcar.jsp">查看购物车</a>
		</div>
	</div>
	<div class="main">
	<%
		int cpage = 1; //当前页
		int startline = 1; //每页的第一行
		int pagesize = 15; //每页显示多少行
		int count = bookslist.size(); //总共有多少行数据
		int pagecount = (count + pagesize - 1) / pagesize; //总共多少页
	%>
	<%
		String strcpage = request.getParameter("cpage");
		if (strcpage == null || strcpage == "") {
			cpage = 1;
		} else {
			cpage = Integer.parseInt(strcpage);
			if (cpage < 1)
				cpage = 1;
			if (cpage > pagecount)
				cpage = pagecount;
		}
		startline = (cpage - 1) * pagesize;
	%>
	<%
		if (bookslist == null || bookslist.size() == 0) {
	%>
		<h3 class="null">没有商品可显示！</h3>
	<%
		} else {
			int dpagesize = 0;
			if (cpage < pagecount) {
				dpagesize = startline + pagesize - 1;
			} else if (cpage == pagecount) {
				dpagesize = count - 1;
			}
	%>
		<div class="content">
	<%
			for (int i = startline; i <= dpagesize; i++) {
				BookSingle single = (BookSingle) bookslist.get(i);
	%>
	<div class="book">
		<a href="detail.jsp?cpage=cpage&id=<%=i%>"><img src="d:\\booksImg\<%=single.getBookImg() %>" alt="书籍图片" /></a>
		<span class="bookName">《<%=single.getBookName() %>》</span>
		<span class="bookAuthor">作者：<%=single.getBookAuthor() %></span>
		<span class="bookPublish">出版社：<%=single.getBookPublish() %></span>
		<em class="bookPrice">价格：￥<%=single.getBookPrice() %></em>
		<em class="bookCount">库存：<%=single.getBookCount() %></em>
		<a href="docar.jsp?action=buy&id=<%=i%>&num=1" class="dogood">购买</a>
	</div>
	<%
		}
	%>
	</div>
	<table class="mytable">
	<tr height="50" align="center">
		<td width="60">第<%=cpage%>页
		</td>
		<td width="60">共<%=pagecount%>页
		</td>
		<td width="60"><a href="fenyeShow.jsp?cpage=<%=cpage - 1%>">上一页</a></td>
		<td width="60"><a href="fenyeShow.jsp?cpage=<%=cpage + 1%>">下一页</a></td>
		<td align="center" width="180">
			<form action="fenyeShow.jsp" method="post">
				转到第<input type="text" name="cpage" size=3 maxlength="3"/>页 <input
					type="submit" value="确定"/>
			</form>
		</td>
	</tr>
	</table>
	<%
		}
	%>
		<div class="management">
			<a href="login.jsp">后台登录</a>
		</div>
	</div>
</body>
</html>
