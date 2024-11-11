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
	
	function searchFlight(){
		$("#dg").datagrid('load',{
			"s_flight.name":$("#s_flightName").val(),
			"s_flight.fromCity":$("#s_fromCity").val(),
			"s_flight.toCity":$("#s_toCity").val(),
			"s_flight.fromTime":$("#s_fromTime").datebox("getValue")
		});
	}
	
	function deleteFlight(){
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
				$.post("flight_deleteFlight.action",{ids:ids},function(result){
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
	
	
	function openFlightAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加航班信息");
		url="flight_save.action";
	}
	
	
	function saveFlight(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#flightType").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择航班类型");
					return false;
				}
				if($("#aircraft").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择使用客机");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	
	function openFlightModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑航班信息");
		$("#name").val(row.name);
		$("#flightType").combobox("setValue",row.flightType);
		$("#fromCity").val(row.fromCity);
		$("#fromTime").datebox("setValue",row.fromTime);
		$("#toCity").val(row.toCity);
		$("#toTime").datebox("setValue",row.toTime);
		$("#ecPrice").val(row.ecPrice);
		$("#ecTicketTotal").val(row.ecTicketTotal);
		$("#fcPrice").val(row.fcPrice);
		$("#fcTicketTotal").val(row.fcTicketTotal);
		$("#aircraft").combobox("setValue",row.aircraft.id);
		url="flight_save.action?flight.id="+row.id;
	}
	
	function resetValue(){
		$("#name").val("");
		$("#flightType").combobox("setValue","");
		$("#fromCity").val("");
		$("#fromTime").datebox("setValue","");
		$("#toCity").val("");
		$("#toTime").datebox("setValue","");
		$("#ecPrice").val("");
		$("#ecTicketTotal").val("");
		$("#fcPrice").val("");
		$("#fcTicketTotal").val("");
		$("#aircraft").combobox("setValue","");
	}
	
	function closeFlightDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function formatAircraftName(val,row){
		return row.aircraft.name;
	}
	
	function formatAircraftId(val,row){
		return row.aircraft.id;
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="航班管理" class="easyui-datagrid"
	  pagination="true" rownumbers="true"
	 url="flight_list3.action" fit="true" toolbar="#tb">
	 <thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
		 		<th field="id" width="50" align="center">编号</th>
		 		<th field="name" width="150" align="center">航班名称</th>
		 		<th field="flightType" width="100" align="center">航班类型</th>
		 		<th field="fromCity" width="100" align="center">出发城市</th>
		 		<th field="toCity" width="100" align="center">目的城市</th>
		 		<th field="fromTime" width="150" align="center">出发时间</th>
		 		<th field="toTime" width="150" align="center">到点时间</th>
			</tr>
		</thead>
	 <thead>
	 	<tr>
	 		<th field="ecPrice" width="100" align="center">经济舱票价</th>
	 		<th field="fcPrice" width="100" align="center">头等舱票价 </th>
	 		<th field="ecTicketTotal" width="100" align="center">经济舱总票数</th>
	 		<th field="fcTicketTotal" width="100" align="center">头等舱总票数</th>
	 		<th field="ecTicketRemain" width="100" align="center">经济舱剩余票数</th>
	 		<th field="fcTicketRemain" width="100" align="center">头等舱剩余票数</th>
	 		<th field="aircraft.id" width="100" align="center"  hidden="true" formatter="formatAircraftId">使用客机ID</th>
	 		<th field="aircraft.name" width="100" align="center" formatter="formatAircraftName">使用客机</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openFlightAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openFlightModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteFlight()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;航班名称：<input type="text" id="s_flightName"  style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			&nbsp;出发地点：<input type="text" id="s_fromCity"  style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			&nbsp;到达地点：<input type="text" id="s_toCity"  style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			&nbsp;出发日期：<input type="text" id="s_fromTime"  class="easyui-datebox" style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			<a href="javascript:searchFlight()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 700px;height:350px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>航班名称：</td>
	 				<td><input type="text" id="name" name="flight.name" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>航班类型：</td>
	 				<td>
	 					<select class="easyui-combobox" id="flightType" name="flight.flightType" style="width: 154px;" editable="false" panelHeight="auto">
	 						<option value="">请选择性别</option>
	 						<option value="国内航班">国内航班</option>
	 						<option value="国际航班">国际航班</option>
	 					</select>
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>出发地点：</td>
	 				<td><input type="text" id="fromCity" name="flight.fromCity" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>出发时间：</td>
	 				<td><input type="text" id="fromTime" name="flight.fromTime"  class="easyui-datetimebox"  required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>到达地点：</td>
	 				<td><input type="text" id="toCity" name="flight.toCity" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>到达时间：</td>
	 				<td><input type="text" id="toTime" name="flight.toTime"  class="easyui-datetimebox"  required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>经济舱票价：</td>
	 				<td><input type="text" id="ecPrice" name="flight.ecPrice" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>(经济舱)座位数：</td>
	 				<td><input type="text" id="ecTicketTotal" name="flight.ecTicketTotal" class="easyui-numberbox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>头等舱票价：</td>
	 				<td><input type="text" id="fcPrice" name="flight.fcPrice" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>(头等舱)座位数：</td>
	 				<td><input type="text" id="fcTicketTotal" name="flight.fcTicketTotal" class="easyui-numberbox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>使用客机：</td>
	 				<td colspan="4">
	 				    <input class="easyui-combobox" id="aircraft" name="flight.aircraft.id" data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'aircraft_comboList.action'"/>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveFlight()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeFlightDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>