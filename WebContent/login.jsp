<%@ page language="java" contentType="text/html; charset=GB2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>后台管理登录</title>
<link rel="stylesheet" type="text/css" href="css/login.css"/>
</head>
<body>
	<div class="login-main">
		<h2 class="title">后台登录</h2>
		<form name="login" method="post" action="logincase.jsp">
			<table>
				<tr class="inputer">
					<td>用户名：</td>
					<td><input type="text" name="username" class="username"/></td>
				</tr>
				<tr class="inputer">
					<td>密&nbsp;&nbsp;&nbsp;码：</td>
					<td><input type="password" name="password" class="password"/></td>
				</tr>
			</table>
			<p id="sure">
				<input type="submit" value="登录"/>&nbsp;&nbsp;&nbsp;&nbsp; <input
					type="reset" value="重置"/>
			</p>
		</form>
	</div>
</body>
</html>