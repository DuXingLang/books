<%@page import="sun.misc.Signal"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.BookSingle"%>
<%@ page import="java.sql.*"%>
<%@ page import="toolbean.Connectdb"%>
<%
		//String sql = "select * from books_table";
		String sql = "select books_table.bookId,type_table.typeName,books_table.bookName,"+
				"books_table.bookAuthor,books_table.bookPublish,books_table.bookImg,books_table.bookPrice,books_table.bookCount "+
				"from books_table,type_table where books_table.bookType=type_table.bookType";
		Connectdb baseConnection = new Connectdb();
		ResultSet rs = baseConnection.executeQuery(sql);//执行SQL语句并取得结果集
	%>
<% ArrayList <BookSingle> bookslist = new ArrayList <BookSingle> (); //用来存储商品
		while(rs.next()){
			//定义一个GoodsSingle类对象来封装商品信息			
			BookSingle single = new BookSingle();
			single.setBookId(rs.getString("bookId"));//封装书籍编号信息
			single.setTypeName(rs.getString("typeName"));
			//single.setBookType(rs.getString("bookType"));//封装书籍类型信息
			single.setBookName(rs.getString("bookName")); //封装书籍名称信息
			single.setBookAuthor(rs.getString("bookAuthor"));
			single.setBookPublish(rs.getString("bookPublish"));
			single.setBookImg(rs.getString("bookImg"));
			single.setBookPrice(rs.getFloat("BookPrice")); //封装书籍价格信息
			single.setBookCount(rs.getInt("bookCount")); //封装商品的库存信息
			bookslist.add(single); //保存商品到goodslist集合对象中
	}%>
<%
	session.setAttribute("bookslist", bookslist); //保存商品列表到session中
	response.sendRedirect("booksinfo.jsp"); //跳转到booksinfo.jsp页面显示商品
%>