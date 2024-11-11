<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	function checkForm(){
		var num=$("#num").val();
		if(num==null||num==""){
			alert("请输入订购数量！");
			return false;
		}
	    if($('input[name="price_type"]:checked').val().split("-")[1]==1){  // 经济舱
			if(num>${flight.ecTicketRemain}){
				alert("经济舱余票为${flight.ecTicketRemain}，请调整订购数量！");
				return false;
			}
		}else{
			if(num>${flight.fcTicketRemain}){
				alert("头等舱余票为${flight.fcTicketRemain}，请调整订购数量！");
				return false;
			}
		}
		return true;
	}
</script>
<div style="padding-left: 10px;">

<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">订购机票</h3>
  </div>
  <div class="panel-body">
  	<form action="${pageContext.request.contextPath}/ticket_saveTicketOrder.action" method="post" onsubmit="return checkForm()">
	  	<table cellpadding="20" cellspacing="20" >
	  		<tr height="40px;" >
	  			<td> &nbsp;&nbsp;航班：</td>
	  			<td>${flight.name}</td>
	  		</tr>
	  		<tr height="40px;">
	  			<td>&nbsp;&nbsp;航线：</td>
	  			<td>${flight.fromCity } -> ${flight.toCity }</td>
	  		</tr>
	  		<tr height="40px;">
	  			<td>&nbsp;&nbsp;出发到点时间：</td>
	  			<td><fmt:formatDate value="${flight.fromTime }" type="date" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${flight.toTime }" type="date" pattern="yyyy-MM-dd  HH:mm"/></td>
	  		</tr>
	  		<tr height="60px;">
	  			<td>&nbsp;&nbsp;票价：</td>
	  			<td>
	  				<input type="radio"  id="type1" name="price_type"  value="${flight. ecPrice}-1"  checked="checked"/>${flight. ecPrice}元(经济舱)<br/>
	  				<input type="radio"  id="type2" name="price_type"  value="${flight. fcPrice}-2"/>${flight. fcPrice}元(头等舱)<br/>
	  			</td>
	  		</tr>
	  		<tr height="40px;">
	  			<td>&nbsp;&nbsp;订购数量：</td>
	  			<td>
	  				<input type="text"  id="num" name="ticketOrder.num"  style="width: 40px;text-align: center;" value="1"/>
	  			</td>
	  		</tr>
	  		<tr height="40px;">
	  			<td>
	  				&nbsp;&nbsp;<input type="submit" value="提交"/>
	  				<input type="hidden" name="ticketOrder.user.id" value="${currentUser.id }"/>
	  				<input type="hidden" name="ticketOrder.flight.id" value="${flight.id }"/>
	  			</td>
	  			<td>
	  			</td>
	  		</tr>
	  	</table>
   </form>
  </div>
</div>
</div>