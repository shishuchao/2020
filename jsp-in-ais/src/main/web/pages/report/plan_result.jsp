<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title></title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	</head>
	<body class="easyui-layout" style="overflow: hidden;" fit="true">
		<div region="center">
			<table id="tab1"  class="ListTable" >
				<tr>
					<td colspan="41" >
					<div style='float:left;padding:5px;'>单位：<%=request.getParameter("tjdw") %></div>
					<div style='float:right;padding:5px;'>${year }年度</div>
					</td>
				</tr>
				<tr>
					<td rowspan="2"  class="EditHead" nowrap="nowrap">序号</td>
					<td rowspan="2" style="text-align:center;" class="EditHead">项目名称</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">一</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">二</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">三</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">四</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">五</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">六</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">七</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">八</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">九</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">十</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">十一</td>
					<td colspan="3" style="text-align:center;" class="EditHead" nowrap="nowrap">十二</td>
					<td rowspan="2" style="text-align:center;" class="EditHead" nowrap="nowrap">项目组长</td>
					<td rowspan="2" style="text-align:center;" class="EditHead" nowrap="nowrap">项目主审</td>
					<td rowspan="2" style="text-align:center;" class="EditHead" nowrap="nowrap">项目参审</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
					<td class="EditHead" nowrap="nowrap">上</td>
					<td class="EditHead" nowrap="nowrap">中</td>
					<td class="EditHead" nowrap="nowrap">下</td>
				</tr>
				<%
					java.util.Map<String, String[]> resultMap = (java.util.Map)request.getAttribute("result");
					java.util.Set<java.util.Map.Entry<String, String[]>> set = resultMap.entrySet();
					int xh = 1;
					for (java.util.Iterator<java.util.Map.Entry<String, String[]>> it = set.iterator(); it.hasNext();) {
						out.print("<tr>");
						java.util.Map.Entry<String, String[]> entry = (java.util.Map.Entry<String, String[]>) it.next();
						out.print("<td class=\"editTd\">"+xh+"</td>");
						out.print("<td class=\"editTd\" nowrap=\"nowrap\">"+entry.getValue()[39]+"</td>");
						for(int i=0;i<36;i++){
							out.print("<td bgcolor=\""+(entry.getValue()[i]==null?"white":entry.getValue()[i])+"\"></td>");
						}
						out.print("<td class=\"editTd\" nowrap=\"nowrap\">"+(entry.getValue()[36]==null?"":entry.getValue()[36])+"</td>");
						out.print("<td class=\"editTd\" nowrap=\"nowrap\">"+(entry.getValue()[37]==null?"":entry.getValue()[37])+"</td>");
						out.print("<td class=\"editTd\" nowrap=\"nowrap\">"+(entry.getValue()[38]==null?"":entry.getValue()[38])+"</td>");
						out.print("</tr>");
						xh++;
					}
				 %>
			</table>
		</div>
	</body>
</html>
