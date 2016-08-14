<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="valuebean.BookSingle"%>
<%@ page import="toolbean.MyTools"%>
<%@ page import="toolbean.Connectdb"%>
<%@ page import="javax.swing.JOptionPane"%>
<%@ page import="java.util.*,com.jspsmart.upload.*" errorPage="" %>
<html>
<head>
<title>document</title>
</head>
<body>
<%
	Connectdb dobooks = new Connectdb();
	String bookId = request.getParameter("bookId");
	// 新建一个SmartUpload对象
	SmartUpload su = new SmartUpload();
	// 上传初始化
	su.initialize(pageContext);
	// 设定上传限制
	// 1.限制每个上传文件的最大长度。
	su.setMaxFileSize(10000000);
	// 2.限制总上传数据的长度。
	su.setTotalMaxFileSize(20000000);	
	// 上传文件
	su.upload();
	// 将上传文件全部保存到指定目录
	//int count = su.save("//booksImg");
	int count = su.save("d:"+"\\"+"booksImg");
	System.out.println("mm"+bookId);
	com.jspsmart.upload.File file = su.getFiles().getFile(0);
	String bookImg = file.getFileName();
	String sql = "update books_table set bookImg='" + bookImg + "' where bookId='" + bookId + "'";
	dobooks.executeUpdate(sql);
	response.sendRedirect("getbooks.jsp");	
%>
</body>
</html>