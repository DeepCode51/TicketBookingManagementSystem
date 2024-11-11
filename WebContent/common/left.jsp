<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	// 登录
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
		$.post("${pageContext.request.contextPath}/user_login.action",{'user.userName':userName,'user.password':password},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						window.location.href="${pageContext.request.contextPath}/flight_indexList.action";
					}else{
						document.getElementById("error").innerHTML="用户名或密码错误！";
					}
				}
			);
	}
	
	// 安全退出
	function logout(){
		if(confirm("您确认要退出系统吗？")){
			$.post("${pageContext.request.contextPath}/user_logout.action",{},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						window.location.href="${pageContext.request.contextPath}/flight_indexList.action";
					}
				}
			);
		}
	}
	
	// 用户注册
	function register(){
		var userName=$("#userName2").val();
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();
		var email=$("#email").val();
		if(userName==null||userName==""){
			document.getElementById("error2").innerHTML="用户名不能为空！";
			return;
		}
		if(pwd==null||pwd==""){
			document.getElementById("error2").innerHTML="密码不能为空！";
			return;
		}
		if(pwd2==null||pwd2==""){
			document.getElementById("error2").innerHTML="确认密码不能为空！";
			return;
		}
		if(pwd!=pwd2){
			document.getElementById("error2").innerHTML="确认密码和密码不一致！";
			return;
		}
		if(email==null||email==""){
			document.getElementById("error2").innerHTML="邮件为空！";
			return;
		}
		$.post("${pageContext.request.contextPath}/user_register.action",{'user.userName':userName,'user.password':pwd,'user.email':email},
				function(result){
					var result=eval('('+result+')');
					if(result.error){
						document.getElementById("error2").innerHTML=result.error;
					}else{
						alert("注册成功！请登录！");
						window.location.href="${pageContext.request.contextPath}/flight_indexList.action";
					}
				}
			);
	}
	
	function resetValue(){
		$("#fromCity").val("");
		$("#toCity").val("");
		$("#fromTime").val("");
	}
</script>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">用户信息</h3>
  </div>
  <div class="panel-body">
  	    <c:if test="${currentUser!=null }">
  	    </c:if>
  	    <c:choose>
  	    	<c:when test="${currentUser!=null }">
  	    		<p>欢迎旅客：<strong>${currentUser.userName }</strong>&nbsp;&nbsp;<a href="javascript:logout()"><font color="black">【安全退出】</font></a></p>
  	    		<a href="${pageContext.request.contextPath}/main_userCenter.jsp" target="_blank"><font color="red"><strong>进入个人中心</strong></font></a></p>
  	    	</c:when>
  	    	<c:otherwise>
  	    		<form  method="post"  action="${pageContext.request.contextPath}/user/login.action"  >
					  <table>
					  	<tr height="40px;">
					  		<td>用户名：</td>
					  		<td><input type="text"  id="userName" /></td>
					  	</tr>
					  	<tr height="40px;">
					  		<td>密码：</td>
					  		<td><input type="password" id="password"/></td>
					  	</tr>
					  	<tr height="40px;">
					  		<td><input type="button" value="登录" onclick="login()"/></td>
					  		<td>&nbsp;&nbsp;<input type="button" value="注册" data-toggle="modal" data-target="#myModal"/>&nbsp;&nbsp;<span id="error" style="color: red"></span></td>
					  	</tr>
					  </table>
					</form>
  	    	</c:otherwise>
  	    </c:choose>
    	
  </div>
</div>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">航班查询</h3>
  </div>
  <div class="panel-body">
    	<form method="post"  action="${pageContext.request.contextPath}/flight_list.action"  >
		  <table>
		  	<tr height="40px;">
		  		<td>出发地点：</td>
		  		<td><input type="text" id="fromCity"  name="s_flight.fromCity"  value="${s_flight.fromCity}"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>到达地点：</td>
		  		<td><input type="text" id="toCity" name="s_flight.toCity" value="${s_flight.toCity }"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>出发日期：</td>
		  		<td><input type="text" id="fromTime"  class="Wdate" onclick="WdatePicker()" name="s_flight.fromTime" value="<fmt:formatDate value="${s_flight.fromTime }" type="date" pattern="yyyy-MM-dd"/>"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td><input type="submit" value="搜索"/></td>
		  		<td>&nbsp;&nbsp;<input type="button" value="重置" onclick="resetValue()"/></td>
		  	</tr>
		  </table>
		</form>
  </div>
</div>


<div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width: 350px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">用户注册</h4>
      </div>
      <div class="modal-body">
       	  <table align="center">
		  	<tr height="40px;">
		  		<td>用户名：</td>
		  		<td><input type="text"  id="userName2"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>密码：</td>
		  		<td><input type="password" id="pwd"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>确认密码：</td>
		  		<td><input type="password" id="pwd2"/></td>
		  	</tr>
		  	<tr height="40px;">
		  		<td>邮件：</td>
		  		<td><input type="text" id="email"/></td>
		  	</tr>
		  	<tr>
		  		<td colspan="2"><span id="error2" style="color: red"></span></td>
		  	</tr>
		  </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="register()">注册</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>