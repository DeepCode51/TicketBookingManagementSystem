<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

	var url;
	
	function searchTicketOrder(){
		$("#dg").datagrid('load',{
			"s_ticketOrder.orderNo":$("#s_ticketOrderNo").val(),
			"s_ticketOrder.user.userName":$("#s_ticketOrderUserName").val()
		});
	}
	
	function deleteTicketOrder(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("ticket_deleteTicketOrder.action",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功删除！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","删除失败！");
					}
				},"json");
			}
		});
		
	}
	
	
	function formatFlightName(val,row){
		return row.flight.name;
	}
	
	function formatUserName(val,row){
		return row.user.userName;
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="订单管理" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true"
	 url="ticket_list.action" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th field="orderNo" width="100" align="center">订单号</th>
	 		<th field="orderTime" width="100" align="center">订购时间</th>
	 		<th field="flight.name" width="100" align="center"  formatter="formatFlightName">航班名称</th>
	 		<th field="user.userName" width="100" align="center"  formatter="formatUserName">用户名</th>
	 		<th field="spaceType" width="100" align="center">座舱类型</th>
	 		<th field="price" width="100" align="center">票价</th>
	 		<th field="num" width="100" align="center">订购数量</th>
	 		<th field="totalPrice" width="100" align="center">总价</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:deleteTicketOrder()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除订单</a>
		</div>
		<div>
			&nbsp;订单号：<input type="text" id="s_ticketOrderNo" size="20" onkeydown="if(event.keyCode==13) searchTicketOrder()"/>
			&nbsp;用户名：<input type="text" id="s_ticketOrderUserName" size="20" onkeydown="if(event.keyCode==13) searchTicketOrder()"/>
			<a href="javascript:searchTicketOrder()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	
</body>
</html>