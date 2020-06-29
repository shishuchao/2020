<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center">
	<div class="easyui-panel" title="浏览统计" fit="true" border="false">
		<table id="tab1"  border=0 class="ListTable" >
			<tr >
				<td  class="EditHead" style="text-align:center;width:14%;">年度/月度<div>浏览次数</div></td>
				<td  class="EditHead" style="text-align:center;width:6%;">1月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">2月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">3月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">4月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">5月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">6月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">7月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">8月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">9月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">10月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">11月</td>
				<td  class="EditHead" style="text-align:center;width:6%;">12月</td>
				<td colspan="4" class="EditHead" style="text-align:center;width:14%;">全年统计</td>
			</tr>
			<%
				java.util.Map<String, int[]> resultMap = (java.util.Map)request.getAttribute("result");
				java.util.Set<java.util.Map.Entry<String, int[]>> set = resultMap.entrySet();
		        for (java.util.Iterator<java.util.Map.Entry<String, int[]>> it = set.iterator(); it.hasNext();) {
		        	out.print("<tr>");
		            java.util.Map.Entry<String, int[]> entry = (java.util.Map.Entry<String, int[]>) it.next();
		            out.print("<td class=\"editTd\" style=\"text-align:center;\">"+entry.getKey()+"</td>");
		            for(int i=0;i<13;i++){
		            	out.print("<td class=\"editTd\" style=\"text-align:center;\">"+(entry.getValue()[i])+"</td>");
		            }
		            out.print("</tr>");
		        }
			 %>
		</table>
		</div>
		</div>
	</body>
</html>
