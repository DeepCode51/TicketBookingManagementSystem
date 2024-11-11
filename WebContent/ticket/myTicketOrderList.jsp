<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">

	function refund(id){
		if(confirm("您确认要退票吗？")){
			$.post("${pageContext.request.contextPath}/ticket_refund.action",{id:id},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						alert("退票成功！");
						window.location.href="${pageContext.request.contextPath}/ticket_myTicketOrderList.action";
					}
				}
			);
		}
	}
	
	function search2(fromCity,id){
		var toCity="";
		if(fromCity!="" && fromCity!=null){
			$("#id").val(id);		
			$("#fromCity").val(fromCity);		
		}else{
			fromCity=$("#fromCity").val();
			toCity=$("#toCity").val();
		}
		$.post("${pageContext.request.contextPath}/flight_list2.action",{'s_flight.fromCity':fromCity,'s_flight.toCity':toCity},
				function(result){
					$('#flightTable tr:not(:first)').empty();
					var dataObj=eval("("+result+")");
					var ft=document.getElementById("flightTable");
					var newTr; // 行
					var newTd0; // 第一列
					var newTd1; // 第二列
					var newTd2; // 第三列
					var newTd3; // 第四列
					var newTd4; // 第五列
					var newTd5; // 第六列
					for(var i=0;i<dataObj.rows.length;i++){
						var flight=dataObj.rows[i];
						newTr=ft.insertRow();
						newTd0=newTr.insertCell();
						newTd1=newTr.insertCell();
						newTd2=newTr.insertCell();
						newTd3=newTr.insertCell();
						newTd4=newTr.insertCell();
						newTd5=newTr.insertCell();
						newTd0.innerHTML='<input type="radio" name="newFlightId" value='+flight.id+' />';
						newTd1.innerHTML=flight.name;
						newTd2.innerHTML=flight.fromCity+"-"+flight.toCity;
						newTd3.innerHTML=flight.fromTime.substring(0,10);
						newTd4.innerHTML=flight.fromTime.substring(11,16)+"-"+flight.toTime.substring(11,16);
						newTd5.innerHTML=flight.ecPrice;
						
					}
				}
			);

	}
	
	
	function save(){
		var id=$("#id").val();	// 获取原先的订单ID
		var newFilghtId=$("input:radio[name='newFlightId']:checked").val();
		if(newFilghtId==undefined){
			alert("请选择您要改签的航班");
		}else{
			$.post("${pageContext.request.contextPath}/ticket_meal.action",{'id':id,'newFlightId':newFilghtId},
					function(result){
						var result=eval('('+result+')');
						if(result.error){
							document.getElementById("error2").innerHTML=result.error;
						}else{
							alert("改签成功！");
							window.location.href="${pageContext.request.contextPath}/ticket_myTicketOrderList.action";
						}
					}
				);
		}
	}
</script>
<div style="padding-left: 10px;">

<div class="panel panel-default">
  <div class="panel-heading">我的订票</div>
  <c:choose>
         	<c:when test="${ticketOrderList.size() ==0}">
         		<p style="padding: 40px">您没有订票信息！</p>
         	</c:when>
         	<c:otherwise>
		  <table class="table" >
		        <thead>
		          <tr>
		          	<th>订单</th>
		          	<th>航班</th>
		            <th>订购日期</th>
		            <th>订购数量</th>
		            <th>票价</th>
		            <th>总价</th>
		            <th>操作</th>
		          </tr>
		        </thead>
		        <tbody id="t2">
				         <c:forEach var="ticketOrder" items="${ticketOrderList }">
				          <tr>
				            <td>${ticketOrder.orderNo }</td>
				            <td>
				            	${ticketOrder.flight.name }<br/>
				            	${ticketOrder.flight.fromCity } - ${ticketOrder.flight.toCity }<br/>
				            	<fmt:formatDate value="${ticketOrder.flight.fromTime }" type="date" pattern="yyyy-MM-dd"/><br/>
				            	<fmt:formatDate value="${ticketOrder.flight.fromTime }" type="date" pattern="HH:mm"/> - <fmt:formatDate value="${ticketOrder.flight.toTime }" type="date" pattern="HH:mm"/>
				            </td>
				            <td><fmt:formatDate value="${ticketOrder.orderTime }" type="date" pattern="yyyy-MM-dd"/></td>
				            <td>${ticketOrder.num }</td>
				            <td>${ticketOrder.price }</td>
				            <td>${ticketOrder.num * ticketOrder.price }</td>
				            <td><a href="javascript:refund(${ticketOrder.id })">退票</a><br/><br/>
				                    <a href="" data-toggle="modal" data-target="#myModal" onclick="search2('${ticketOrder.flight.fromCity }',${ticketOrder.id })">改签</a></td>
				          </tr>
				         </c:forEach>
		        </tbody>
		      </table>
         	</c:otherwise>
         </c:choose>
</div>
</div>


<div class="modal fade " id="myModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog" >
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">机票改签（请选择要改签的航班）</h4>
      </div>
      <div class="modal-body">
      	  <div>
      	  	出发地点：<input type="text" id="fromCity"  name="s_flight.fromCity"  style="width: 150px"/>&nbsp;&nbsp;
      	  	到达地点：<input type="text" id="toCity" name="s_flight.toCity"  style="width: 150px"/>&nbsp;&nbsp;
      	  	<input type="button" value="搜索"  onclick="search2('')"/>
      	  </div>
      	  <br/>
          <table class="table" id="flightTable">
        <thead>
          <tr>
            <th>#</th>
          	<th>航班</th>
            <th>航线</th>
            <th>出发日期</th>
            <th>起落时间</th>
            <th>票价</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
      </div>
      <div class="modal-footer">
      	<input type="hidden" id="id"/>
        <button type="button" class="btn btn-primary" onclick="save()">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
