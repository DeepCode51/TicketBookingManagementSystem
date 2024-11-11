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
	
	function searchAircraft(){
		$("#dg").datagrid('load',{
			"s_aircraft.name":$("#s_aircraftName").val()
		});
	}
	
	function deleteAircraft(){
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
				$.post("aircraft_deleteAircraft.action",{ids:ids},function(result){
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
	
	
	function openAircraftAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加客机信息");
		url="aircraft_save.action";
	}
	
	
	function saveAircraft(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
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
	
	function openAircraftModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑客机信息");
		$("#name").val(row.name);
		$("#buyDate").datebox("setValue",row.buyDate);
		$("#useDate").datebox("setValue",row.useDate);
		$("#remark").val(row.remark);
		url="aircraft_save.action?aircraft.id="+row.id;
	}
	
	function resetValue(){
		$("#name").val("");
		$("#buyDate").datebox("setValue","");
		$("#useDate").datebox("setValue","");
		$("#remark").val("");
	}
	
	function closeAircraftDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="客机管理" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true"
	 url="aircraft_list.action" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th field="name" width="100" align="center">客机名称</th>
	 		<th field="buyDate" width="100" align="center">购买日期</th>
	 		<th field="useDate" width="100" align="center">服役日期</th>
	 		<th field="remark" width="200" align="center">备注</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openAircraftAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openAircraftModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteAircraft()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;客机名称：&nbsp;<input type="text" id="s_aircraftName" size="20" onkeydown="if(event.keyCode==13) searchAircraft()"/>
			<a href="javascript:searchAircraft()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 470px;height:300px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>客机名称：</td>
	 				<td><input type="text" id="name" name="aircraft.name" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>购买日期：</td>
	 				<td><input type="text" id="buyDate" name="aircraft.buyDate" class="easyui-datebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>服役日期：</td>
	 				<td><input type="text" id="useDate" name="aircraft.useDate" class="easyui-datebox"  required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>备注：</td>
	 				<td colspan="4">
	 				    <textarea rows="4" cols="40" id="remark" name="aircraft.remark" ></textarea>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveAircraft()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeAircraftDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>