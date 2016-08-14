<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="sun.misc.Signal"%>
<%@ page import="java.sql.*"%>
<%@ page import="toolbean.Connectdb"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>图书销售表</title>
<style type="text/css">
	*{
		margin:0;
		padding:0;
		font-family:"Microsoft Yahei";
		font-size:16px;
	}
	a{
		text-decoration:none;
	}
	.main{
		position:relative;
		width:800px;
		left:50%;
		margin-left:-400px;
	}
	.title{
		display:block;
		width:100%;
		height:60px;
		line-height:60px;
		border-bottom:1px #999 solid;
		margin-bottom:20px;
		text-align:center;
		font-size:20px;
	}
</style>
</head>
<body>
<%
		//String sql = "select * from sales_table where bookId='00010001'";
		String sql = "select sales_table.bookId,type_table.typeName,sales_table.bookName,sales_table.sales "+
					"from sales_table,type_table where sales_table.bookType=type_table.bookType";
		Connectdb connection = new Connectdb();
		ResultSet rs = connection.executeQuery(sql);//执行SQL语句并取得结果集
%>
	<div class="main">
		<h2 class="title">图书销售表</h2>
		<table border="1" width="600" rules="none" cellspacing="0" cellpadding="0" align="center">
			<tr align="center" height="30" bgcolor="lightgrey">
				<td>图书编码</td>
				<td>图书类型</td>
				<td>图书名称</td>
				<td>图书销量</td>
			</tr>
<%
		if(!rs.next()){
%>
			<tr height="100">
				<td colspan="4" align="center">图书尚未售出！</td>
			</tr>
<%
		}else{
			do{
%>
			<tr align="center" height="40">
				<td><%=rs.getString("bookId") %></td>
				<td><%=rs.getString("typeName") %></td>
				<td><%=rs.getString("bookName") %></td>
				<td><%=rs.getInt("sales") %></td>
			</tr>
<%
			}while(rs.next());
		}
%>
			<tr height="40">
				<td colspan="4" align="center">
					<a href="booksinfo.jsp">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="statistic.jsp">查看销售统计</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="getSalesDate.jsp?type=all">查看销售时间</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>