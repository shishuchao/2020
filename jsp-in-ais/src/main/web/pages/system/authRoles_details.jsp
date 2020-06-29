<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<!-- authRole_details.jsp  -->
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title></title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
	<table>
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/system/allRoles.action')"/>
			</td>
		</tr>
	</table>
<!-- ...... -->
	<display:table name="m_list" id="row" class="its" pagesize="20" excludedParams="*"
				size="listSize" requestURI="/system/allRoles.action">
		<display:column title="名称" property="fname" sortable="true" style="width:30%;white-space:nowrap;"  class="center" headerClass="center"></display:column>		
		<display:column title="备注" sortable="true" property="fnote" style="width:20%" class="center" headerClass="center"></display:column>		
		<display:column title="所属公司" sortable="true" property="companyName" style="width:20%"  class="center" headerClass="center"></display:column>
		<display:column title="角色类型" sortable="true" property="fscopename" style="width:20%"  class="center" headerClass="center"></display:column>		
		<display:column title="操作" style="width:10%"  class="center" headerClass="center">
			<a href="<%=request.getContextPath()%>/system/authRoleDetails.action?authRole.froleid=${row.froleid} " target="blank">详细信息</a>
		</display:column>		
	</display:table>
	</body>
</html>