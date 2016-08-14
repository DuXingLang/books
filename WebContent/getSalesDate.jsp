<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="valuebean.SalesDetail"%>
<%@ page import="java.sql.*"%>
<%@ page import="toolbean.Connectdb"%>
<%
	String sql;
	try {
		String type = request.getParameter("type");
		if (type.equals("single")) {
			String bookId = request.getParameter("bookId");
			sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
					+ "from sales_date,type_table where sales_date.bookType=type_table.bookType and sales_date.bookId='"
					+ bookId + "' order by sales_date.salesDate desc";
		} else if (type.equals("date")) {
			String date1 = request.getParameter("date1");
			String date2 = request.getParameter("date2");
			String bookId1 = request.getParameter("bookId1");
			System.out.println(bookId1);
			if (bookId1 != null && bookId1 != "") {
				if (date1 != null && date2 != null && date1 != "" && date2 != "") {
					sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
							+ "from sales_date,type_table where sales_date.bookType=type_table.bookType and sales_date.salesDate between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and sales_date.bookId='"
							+ bookId1
							+ "' order by sales_date.salesDate desc";
				} else {
					sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
							+ "from sales_date,type_table where sales_date.bookType=type_table.bookType and sales_date.bookId='"
							+ bookId1
							+ "' order by sales_date.salesDate desc";
				}
			} else if (date1 != null && date2 != null && date1 != "" && date2 != "") {
				sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
						+ "from sales_date,type_table where sales_date.bookType=type_table.bookType and sales_date.salesDate between '"
						+ date1
						+ "' and '"
						+ date2
						+ "' order by sales_date.salesDate desc";
			} else {
				sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
						+ "from sales_date,type_table where sales_date.bookType=type_table.bookType order by sales_date.salesDate desc";
			}
		} else {
			sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
					+ "from sales_date,type_table where sales_date.bookType=type_table.bookType order by sales_date.salesDate desc";
		}
	} catch (Exception e) {
		sql = "select sales_date.bookId,type_table.typeName,sales_date.bookName,sales_date.sales,sales_date.salesDate "
				+ "from sales_date,type_table where sales_date.bookType=type_table.bookType order by sales_date.salesDate desc";
	}
	Connectdb connection = new Connectdb();
	ResultSet rs = connection.executeQuery(sql);//执行SQL语句并取得结果集
%>
<%
	session.setAttribute("rs", rs);
	response.sendRedirect("salesDate.jsp");
%>