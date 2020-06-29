<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	</head>
<body>
	<table id="tab1" cellpadding=0 cellspacing=1 border=0  class="ListTable" style="margin-right:5px">
		<tr>
			<td rowspan="2" class="EditHead" nowrap>姓名\月份</td>
			<td colspan="3" style="text-align:center;" class="EditHead">1月</td><td colspan="3" class="EditHead" style="text-align:center;">2月</td><td colspan="3" class="EditHead" style="text-align:center;">3月</td><td colspan="3" class="EditHead" style="text-align:center;">4月</td><td colspan="3" class="EditHead" style="text-align:center;">5月</td><td colspan="3" class="EditHead" style="text-align:center;">6月</td><td colspan="3" class="EditHead" style="text-align:center;">7月</td><td colspan="3" class="EditHead" style="text-align:center;">8月</td><td colspan="3" class="EditHead" style="text-align:center;">9月</td><td colspan="3" class="EditHead" style="text-align:center;">10月</td><td colspan="3" class="EditHead" style="text-align:center;">11月</td><td colspan="3" class="EditHead" style="text-align:center;">12月</td><td colspan="4" class="EditHead" style="text-align:center;">全年统计</td>
		</tr>
		<tr >
			<td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td>
			<td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td>
			<td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td>
			<td class="EditHead" nowrap="nowrap">组长</td><td class="EditHead" nowrap="nowrap">主审</td><td class="EditHead" nowrap="nowrap">组员</td><td class="EditHead" nowrap="nowrap">合计</td>
		</tr>
		<%
			java.util.Map<String, int[]> resultMap = (java.util.Map)request.getAttribute("result");
			java.util.Set<java.util.Map.Entry<String, int[]>> set = resultMap.entrySet();
	        for (java.util.Iterator<java.util.Map.Entry<String, int[]>> it = set.iterator(); it.hasNext();) {
	        	out.print("<tr>");
	            java.util.Map.Entry<String, int[]> entry = (java.util.Map.Entry<String, int[]>) it.next();
	            out.print("<td class=\"editTd\">"+entry.getKey()+"</td>");
	            for(int i=0;i<40;i++){
	            	out.print("<td class=\"editTd\">"+(entry.getValue()[i]>0?entry.getValue()[i]:"")+"</td>");
	            }
	            out.print("</tr>");
	        }
		 %>
	</table>
</body>
</html>
