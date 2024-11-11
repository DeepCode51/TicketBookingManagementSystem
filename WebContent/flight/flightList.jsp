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
</script>
<div style="padding-left: 10px;">

<div class="panel panel-default" style="margin-bottom: 0px;">
  <div class="panel-heading">航班查询结果</div>
  <table class="table">
        <thead>
          <tr>
          	<th>航班</th>
            <th>航线</th>
            <th>出发日期</th>
            <th>起落时间</th>
            <th>票价</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
         <c:forEach var="f1" items="${flightList}">
          <tr>
            <td>${f1.name }</th>
            <td>${f1.fromCity } - ${f1.toCity }</td>
            <td><fmt:formatDate value="${f1.fromTime }" type="date" pattern="MM-dd"/></td>
            <td><fmt:formatDate value="${f1.fromTime }" type="date" pattern="HH:mm"/> - <fmt:formatDate value="${f1.toTime }" type="date" pattern="HH:mm"/></td>
            <td>${f1.ecPrice } </td>
            <td><a href="javascript:checkLogin(${f1.id })">订票</a></td>
          </tr>
         </c:forEach>
        </tbody>
      </table>
</div>
<nav >
	<ul class="pagination">
		${pageCode }
	</ul>
</nav>
</div>