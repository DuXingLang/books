<%@ page language="java" contentType="text/html; charset=gb2312"
	pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新增商品</title>
<style type="text/css">
* {
	font-family: "Microsoft YaHei";
}

.nav {
	width: 800px;
	margin: 0 auto;
	background-color: #E1E6F6;
	padding: 20px;
}

.nav form{
	display:block;
	position:relative;
	padding:20px 20px 20px 40px;
	width:340px;
	margin:0 auto;
}

.nav .title {
	display:block;
	width:100%;
	text-align: center;
}

.nav form input[type=text] {
	width: 200px;
	height: 30px;
	margin-left: 10px;
	padding-left: 20px;
}
.nav form select{
	padding-left: 20px;
}
.nav form select,input[type=file]{
	width: 220px;
	height: 30px;
	margin-left: 10px;
}
.nav .btn {
	display:block;
	position:relative;
	text-align: center;
	height: 40px;
}

.btn a {
	display: inline-block;
	text-decoration: none;
	font-size: 12px;
	margin-left: 20px;
}
#bookimg{
	display:none;
	width:80px;
	height:100px;
	margin:0 auto;
}
</style>
<script type="text/javascript">
	function showpic(){
	 	var img= document.getElementById("bookimg");
	 	var file=document.getElementById("bookImg");
	 	img.src=file.value;
	 	img.style.display="block";
	}
</script>
</head>
<body>
	<div class="nav">
		<h2 class="title">新增图书</h2>
		<form method="post" action="dobooks.jsp?action=add" enctype="multipart/form-data" class="myForm">
			<table>
				<tr height="40">
					<td>编码</td>
					<td><input type="text" name="bookId"></td>
				</tr>
				<tr height="40">
					<td>类型</td>
					<td>
						<select name="bookType">
							<option value="0001" selected>计算机</option>
							<option value="0002">文学</option>
							<option value="0003">历史</option>
							<option value="0004">哲学</option>
							<option value="0005">其他</option>
						</select>
					</td>
				</tr>
				<tr height="40">
					<td>书名</td>
					<td><input type="text" name="bookName"></td>
				</tr>
				<tr height="40">
					<td>作者</td>
					<td><input type="text" name="bookAuthor"></td>
				</tr>
				<tr height="40">
					<td>出版社</td>
					<td><input type="text" name="bookPublish"></td>
				</tr>
				<tr height="40">
					<td>图片</td>
					<td><input type="file" name="bookImg" id="bookImg" onchange="showpic()"></td>
				</tr>
				<tr>
					<td colspan="2">
						<img src="#" id="bookimg">
					</td>
				</tr>
				<tr height="40">
					<td>价格</td>
					<td><input type="text" name="bookPrice"></td>
				</tr>
				<tr height="40">
					<td>库存</td>
					<td><input type="text" name="bookCount"></td>
				</tr>
			</table>
			<p class="btn">
				<input type="submit" value="提交">&nbsp;&nbsp; <input
					type="reset" value="重置"> <a href="getbooks.jsp">返回>></a>
			</p>
		</form>
	</div>
</body>
</html>