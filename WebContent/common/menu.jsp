<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
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
</script>
<div class="list-group">
  <a href="#" class="list-group-item active">
    系统菜单
  </a>
	  <a href="${pageContext.request.contextPath}/user_showUserInfo.action" class="list-group-item">个人信息</a>
	  <a href="${pageContext.request.contextPath}/ticket_myTicketOrderList.action" class="list-group-item">订票管理</a>
	  <a href="javascript:logout()" class="list-group-item">安全退出</a>
</div>