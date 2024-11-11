<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	function checkLogin(flightId){
		if('${currentUser}'==''){
			alert("请先登录，然后购票");
		}else{
			window.location.href='${pageContext.request.contextPath}/ticket_preTicketOrder.action?flightId='+flightId;		
		}
	}
	
	function save(){
		var userName=$("#userName").val();
		var password=$("#password").val();
		var trueName=$("#trueName").val();
		var sex=$("#sex").val();
		var sfz=$("#sfz").val();
		var email=$("#email").val();
		var phone=$("#phone").val();
		if(userName==null||userName==""){
			document.getElementById("error2").innerHTML="用户名不能为空！";
			return;
		}
		if(password==null||password==""){
			document.getElementById("error2").innerHTML="密码不能为空！";
			return;
		}
		if(trueName==null||trueName==""){
			document.getElementById("error2").innerHTML="真实姓名不能为空！";
			return;
		}
		if(sex==null||sex==""){
			document.getElementById("error2").innerHTML="请选择性别！";
			return;
		}
		if(sfz==null||sfz==""){
			document.getElementById("error2").innerHTML="身份证不能为空！";
			return;
		}
		if(email==null||email==""){
			document.getElementById("error2").innerHTML="邮件不能为空！";
			return;
		}
		if(phone==null||phone==""){
			document.getElementById("error2").innerHTML="联系电话不能为空！";
			return;
		}
		$.post("${pageContext.request.contextPath}/user_save.action",{'user.id':'${currentUser.id}','user.userName':userName,'user.password':password,'user.trueName':trueName,'user.sex':sex,'user.sfz':sfz,'user.email':email,'user.phone':phone},
				function(result){
					var result=eval('('+result+')');
					if(result.error){
						document.getElementById("error2").innerHTML=result.error;
					}else{
						alert("修改成功！");
						window.location.href="${pageContext.request.contextPath}/user_showUserInfo.action";
					}
				}
			);
	}
</script>
<div style="padding-left: 10px;">
<div class="panel panel-default">
  <div class="panel-heading">用户信息</div>
  <table class="table">
        <thead>
          <tr>
          	<th>编号</th>
            <th>用户名</th>
            <th>密码</th>
            <th>真实姓名</th>
            <th>性别</th>
            <th>邮件</th>
            <th>联系电话</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>${currentUser.id }</th>
            <td>${currentUser.userName }</td>
            <td>${currentUser.password }</td>
            <td>${currentUser.trueName }</td>
            <td>${currentUser.sex }</td>
            <td>${currentUser.email }</td>
            <td>${currentUser.phone }</td>
            <td><input type="button" value="修改" data-toggle="modal" data-target="#myModal"/></td>
          </tr>
        </tbody>
      </table>
</div>
</div>


<div class="modal fade " id="myModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width: 450px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">用户信息修改</h4>
      </div>
      <div class="modal-body">
          <form method="post"  action="${pageContext.request.contextPath}/user_save.action"  >
	       	  <table align="center">
			  	<tr height="40px;">
			  		<td width="100px;">用户名：</td>
			  		<td><input type="text"  id="userName"  name="user.userName" value="${currentUser.userName }" readonly="readonly"/></td>
			  	</tr>
			  	<tr height="40px;">
			  		<td>密码：</td>
			  		<td><input type="text" id="password" name="user.password" value="${currentUser.password }"/></td>
			  	</tr>
			  	<tr height="40px;">
			  		<td>真实姓名：</td>
			  		<td><input type="text" id="trueName" name="user.trueName" value="${currentUser.trueName }"/></td>
			  	</tr>
			  	<tr height="40px;">
			  		<td>性别：</td>
			  		<td>
			  			 <select style="width: 170px;" id="sex" name="user.sex">
							  <option value="">请选择..</option>
							  <option value="男" ${'男'==currentUser.sex?'selected':'' }>男</option>
							  <option value="女" ${'女'==currentUser.sex?'selected':'' }>女</option>
						</select>
			  		</td>
			  	</tr>
			  	<tr height="40px;">
			  		<td>身份证：</td>
			  		<td><input type="text" id="sfz" name="user.sfz" value="${currentUser.sfz }"/></td>
			  	</tr>
			  	<tr height="40px;">
			  		<td>邮件：</td>
			  		<td><input type="text" id="email" name="user.email" value="${currentUser.email }"/></td>
			  	</tr>
			  	<tr height="40px;">
			  		<td>联系电话：</td>
			  		<td><input type="text" id="phone" name="user.phone" value="${currentUser.phone }"/></td>
			  	</tr>
			  	<tr>
			  		<td colspan="2"><span id="error2" style="color: red"></span></td>
			  	</tr>
			  </table>
		  </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="save()">保存</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>