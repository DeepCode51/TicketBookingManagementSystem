<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="${pageContext.request.contextPath}/bootstrap3/js/jquery-1.11.2.min.js"></script>
<link href="${pageContext.request.contextPath}/css/alogin.css" rel="stylesheet" type="text/css" />
<title>管理员登录</title>
<script type="text/javascript">
	function login(){
		var userName=$("#userName").val();
		var password=$("#password").val();
		if(userName==null||userName==""){
			document.getElementById("error").innerHTML="用户名不能为空！";
			return;
		}
		if(password==null||password==""){
			document.getElementById("error").innerHTML="密码不能为空！";
			return;
		}
		$.post("${pageContext.request.contextPath}/manager_login.action",{'manager.userName':userName,'manager.password':password},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						window.location.href="${pageContext.request.contextPath}/admin/main.jsp";
					}else{
						document.getElementById("error").innerHTML="用户名或密码错误！";
					}
				}
			);
	}
</script>
</head>
<body>
<form id="form1" name="form1" action="${pageContext.request.contextPath}/user_adminUser.action" method="post">
	<div class="MAIN">
		<ul>
			<li class="top"></li>
			<li class="top2"></li>
			<li class="topA"></li>
			<li class="topB">
				<span> 
					<a href="http://www.java1234.com" target="_blank"><img src="${pageContext.request.contextPath}/image/login/logo.gif" alt="" style="" /></a>
				</span>
			</li>
			<li class="topC"></li>
			<li class="topD">
			<ul class="login">
				<br>
				<br>
				<br>
				<br>
				<li><span class="left">用户名：</span> <span style=""> <input id="userName" name="manager.userName" type="text" class="txt" value="${manager.userName }" /> </span></li>
				<li><span class="left">密&nbsp;&nbsp;&nbsp;码：</span> <span style=""> <input id="password" name="manager.password" type="password" class="txt" value="${manager.password }" onkeydown= "if(event.keyCode==13)form1.submit()"/> </span></li>
			</ul>
			</li>
			<li class="topE"></li>
			<li class="middle_A"></li>
			<li class="middle_B"></li>
			<li class="middle_C"><span class="btn"> <img alt="" src="${pageContext.request.contextPath}/image/login/btnlogin.gif" onclick="login()"/> </span>&nbsp;&nbsp;<span ><font color="red" id="error"></font></span></li>
			<li class="middle_D"></li>
			<li class="bottom_A"></li>
			<li class="bottom_B"></li>
		</ul>
	</div>
</form>
</body>
</html>