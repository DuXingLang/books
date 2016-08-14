<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="sun.misc.Signal"%>
<%@page import="java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="toolbean.Connectdb"%>
<!DOCTYPE html>
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
	.search{
		width:100%;
		height:30px;
		text-align:center;
		margin-bottom:20px;
	}
</style>
</head>
<body>
<%
		ResultSet rs = (ResultSet) session.getAttribute("rs");	
%>
	<div class="main">
		<h2 class="title">图书销售时间表</h2>
		<div class="search">
			<form action="getSalesDate.jsp?type=date" method="post">
				时间：<input name="date1" type="date">--<input name="date2" type="date">&nbsp;&nbsp;
				图书编码：<input type="text" name="bookId1">&nbsp;&nbsp;
				<input type="submit" value="搜索">
			</form>
		</div>
		<table border="1" width="800" rules="none" cellspacing="0" cellpadding="0" align="center">
			<tr align="center" height="30" bgcolor="lightgrey">
				<td>图书编码</td>
				<td>图书类型</td>
				<td>图书名称</td>
				<td>图书销量</td>
				<td>销售时间</td>
			</tr>
<%
		if(!rs.next()){
%>
			<tr height="100">
				<td colspan="5" align="center">图书尚未售出！</td>
			</tr>
<%
		}else{
			do{
%>
			<tr align="center" height="40">
				<td><a href="getSalesDate.jsp?bookId=<%=rs.getString("bookId")%>&type=single"><%=rs.getString("bookId") %></a></td>
				<td><%=rs.getString("typeName") %></td>
				<td><%=rs.getString("bookName") %></td>
				<td><%=rs.getInt("sales") %></td>
				<td><%=rs.getString("salesDate") %></td>
			</tr>
<%
			}while(rs.next());
		}
%>
			<tr height="40">
				<td colspan="5" align="center">
					<a href="salesinfo.jsp">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="statistic.jsp">查看销售统计</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>