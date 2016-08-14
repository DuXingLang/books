<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.BookSingle"%>
<!-- 通过动作标识，获取ShopCar类实例 -->
<jsp:useBean id="myCar" class="toolbean.ShopCar" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>图书信息</title>
<link rel="stylesheet" type="text/css" href="css/shopcar.css"/>
</head>
<body>
<%
	ArrayList buylist = myCar.getBuylist(); //获取实例中用来存储购买的商品的集合
	float total = 0; //用来存储应付金额
%>
	<div class="header">
		<h2 class="title">购物车</h2>
		<span class="info">图书信息</span>
		<span class="price">价格</span>
		<span class="count">数量</span>
	</div>
	<div class="main">
	<%
		if (buylist == null || buylist.size() == 0) {
	%>
	<h3 class="null">您的购物车为空！</h3>
	<%
		} else {
			for (int i = 0; i < buylist.size(); i++) {
				BookSingle single = (BookSingle) buylist.get(i);
				String bookId = single.getBookId(); //获取商品的编号
				String bookName = single.getBookName(); //获取商品名称
				String bookAuthor = single.getBookAuthor();
				String bookPublish = single.getBookPublish();
				String bookImg = single.getBookImg();
				float bookPrice = single.getBookPrice(); //获取商品价格
				int bookNum = single.getBookNum(); //获取购买数量				
				float money = ((int) ((bookPrice * bookNum + 0.05f) * 10)) / 10f; //计算当前商品总价，并进行四舍五入
				total += money; //计算应付金额
	%>
	<div class="book">
		<img src="d:\\booksImg\<%=bookImg%>" alt="<%=bookImg%>"/>
		<div class="bookinfo">
			<p>
				<span class="bookName">《<%=bookName %>》</span>
				<span class="price">￥<%=bookPrice*bookNum %></span>
				<span class="num"><%=bookNum %></span>
			</p>
			<p><span class="bookAuthor">作者：&nbsp;<%=bookAuthor %></span></p>
			<p><span class="bookPublish">出版社：<%=bookPublish %></span></p>
			<p>
				<span class="bookPrice">单价：&nbsp;<%=bookPrice %></span>
				<a class="delete" href="docar.jsp?action=remove&bookId=<%=single.getBookId()%>">移除</a>
			</p>
		</div>
	</div>
	<%
		}
		}
	%>
	<div class="footer">
		<p class="footer-1">
			<span class="money">应付金额：￥<%=total %></span>
			<a class="pay" href="docar.jsp?action=pay">付款</a>
		</p>
		<p class="footer-2">
			<a class="clear" href="docar.jsp?action=clear">清空购物车</a>
			<a class="shop" href="fenyeShow.jsp">继续购物</a>
		</p>
	</div>
<% session.setAttribute("buylist", buylist);%>
	</div>
</body>
</html>