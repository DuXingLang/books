<%@page import="sun.misc.Signal"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.BookSingle"%>
<%@ page import="java.sql.*"%>
<%@ page import="toolbean.Connectdb"%>
<%
		String sql;
	try{
		String click = "all";
		click = request.getParameter("click");
		if(click.equals("all")){
			sql = "select * from books_table";
		}else if(click.equals("computer")){
			sql = "select * from books_table where booktype='0001'";
		}else if(click.equals("literature")){
			sql = "select * from books_table where booktype='0002'";
		}else if(click.equals("history")){
			sql = "select * from books_table where booktype='0003'";
		}else if(click.equals("philosophy")){
			sql = "select * from books_table where booktype='0004'";
		}else if(click.equals("other")){
			sql = "select * from books_table where booktype='0005'";
		}else{
			sql = "select * from books_table";
		}
	}catch(Exception e){
		sql = "select * from books_table";
	}
		Connectdb baseConnection = new Connectdb();
		ResultSet rs = baseConnection.executeQuery(sql);//执行SQL语句并取得结果集
%>
<% 		ArrayList <BookSingle> bookslist = new ArrayList <BookSingle> (); //用来存储商品
		while(rs.next()){
			//定义一个GoodsSingle类对象来封装商品信息			
			BookSingle single = new BookSingle();
			single.setBookId(rs.getString("bookId"));//封装书籍编号信息
			//single.setTypeName(rs.getString("typeName"));
			single.setBookType(rs.getString("bookType"));//封装书籍类型信息
			single.setBookName(rs.getString("bookName")); //封装书籍名称信息
			single.setBookAuthor(rs.getString("bookAuthor"));
			single.setBookPublish(rs.getString("bookPublish"));
			single.setBookImg(rs.getString("bookImg"));
			single.setBookPrice(rs.getFloat("BookPrice")); //封装书籍价格信息
			single.setBookCount(rs.getInt("bookCount")); //封装商品的库存信息
			single.setBookNum(1);  //封装购买数量信息
			bookslist.add(single); //保存商品到goodslist集合对象中
	}%>
<%
	session.setAttribute("bookslist", bookslist); //保存商品列表到session中
	response.sendRedirect("fenyeShow.jsp"); //跳转到show.jsp页面显示商品
%>