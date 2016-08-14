<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.BookSingle"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	ArrayList bookslist = (ArrayList) session.getAttribute("bookslist");
%>
<style type="text/css">
a {
	text-decoration: none;
}
.title{
	font-size:20px;
	font-weight:bold;
}
.addbook,.salesinfo{
	display:inline-block;
	width:70px;
	height:35px;
	text-align:center;
	line-height:35px;
	border-radius:5px;
	background-color:#B2B7BC;
}
.bookImg{
	height:50px;
	width:auto;
}
</style>
<table border="1" width="900" rules="none" cellspacing="0"
	cellpadding="0">
	<tr height="50">
		<td colspan="9" align="center" class="title">书城书籍信息如下</td>
	</tr>
	<tr align="center" height="30" bgcolor="lightgrey">
		<td>编码</td>
		<td>类型</td>
		<td>书名</td>
		<td>作者</td>
		<td>出版社</td>
		<td>图片</td>
		<td>单价（元/本）</td>
		<td>库存</td>
		<td>操作</td>
	</tr>
	<%
		int cpage = 1; //当前页
		int startline = 1; //每页的第一行
		int pagesize = 6; //每页显示多少行
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
	<tr height="100">
		<td colspan="9" align="center">没有书籍信息可显示！</td>
	</tr>
	<%
		} else {
			int dpagesize = 0;
			if (cpage < pagecount) {
				dpagesize = startline + pagesize - 1;
			} else if (cpage == pagecount) {
				dpagesize = count - 1;
			}
			for (int i = startline; i <= dpagesize; i++) {
				BookSingle single = (BookSingle) bookslist.get(i);
	%>
	<tr height="60" align="center">
		<td><a href="updatebooks.jsp?id=<%=i %>"><%=single.getBookId()%></a></td>
		<td><%=single.getTypeName()%></td>
		<td><%=single.getBookName()%></td>
		<td><%=single.getBookAuthor()%></td>
		<td><%=single.getBookPublish()%></td>
		<td><img src="d:\\booksImg\<%=single.getBookImg()%>" class="bookImg"></img></td>
		<td><%=single.getBookPrice()%></td>
		<td><%=single.getBookCount()%></td>
		<td><a href="dobooks.jsp?action=delete&id=<%=i%>">删除</a></td>
	</tr>
	<%
		}
	%>
	<tr height="50" align="center">
		<td>第<%=cpage%>页
		</td>
		<td>共<%=pagecount%>页
		</td>
		<td><a href="booksinfo.jsp?cpage=<%=cpage - 1%>">上一页</a></td>
		<td><a href="booksinfo.jsp?cpage=<%=cpage + 1%>">下一页</a></td>
		<td colspan="5">
			<form action="booksinfo.jsp" method="post">
				转到第<input type="text" name="cpage" size="3" maxlength="3"/>页 <input
					type="submit" value="确定"/>
			</form>
		</td>
	</tr>
	<%
		}
	%>
	<tr height="50">
		<td align="center" colspan="9">
			<a class="addbook" href="addbooks.jsp">添加图书</a>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="salesinfo" href="salesinfo.jsp">销售信息</a>
		</td>
	</tr>
</table>
<%
	session.setAttribute("bookslist", bookslist);
%>