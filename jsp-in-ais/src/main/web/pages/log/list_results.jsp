<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
			
			<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
			<link href="${contextPath}/ais/css/main.css" rel="stylesheet" type="text/css">
		<title>日志统计信息</title>
	</head>
	<body>	
		<table style="padding: 0;border-spacing: 0;border-collapse: 0;width:96%;">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/log/list.action')"/>
			</td>
		</tr>
	</table>

		<!-- 列表FORM -->
		<s:form namespace="/log" action="listResult.action?onLonLine=${onLine}" method="post" theme="simple">
			<display:table name="list" id="row" requestURI="${contextPath}/log/listResult.action?onLine=${onLine}" class="its"
				pagesize="20" style="width:96%">
				<input type="hidden" id="logAuthority" name="logAuthority" value="${logAuthority}">
				<display:column property="searchInfo" title="查询条件" sortable="true" headerClass="center" class="center">
				</display:column>
				<display:column property="searchSize" title="记录数" sortable="true" headerClass="center" class="center">
				</display:column>
			</display:table>
<br><br>
			<div align="center">
				<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<%=request.getContextPath()%>/log/delResultLog.action?onLine=${onLine}&logAuthority=${logAuthority}';"
					value="清空" />
				<input type="button" class="btn3_mouseout"
					onmouseover="this.className='btn3_mouseover'"
					onmouseout="this.className='btn3_mouseout'"
					onmousedown="this.className='btn3_mousedown'"
					onmouseup="this.className='btn3_mouseup'"
					onclick="location.href='<%=request.getContextPath()%>/log/search.action?onLine=${onLine}&logAuthority=${logAuthority}';"
					value="返回" />

				&nbsp;&nbsp;&nbsp;
			</div>			
		</s:form>
		<br>
	</body>
</html>
