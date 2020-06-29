<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>组间授权列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/project/permission/listAll.action')"/>
				</td>
			</tr>
		</table>
		<s:form action="listAll" namespace="/project/actualize" method="post">
			<div align="center">
				<display:table id="row" name="projectList" pagesize="10" class="its"
					requestURI="${contextPath}/project/permission/listAll.action">
					<display:column property="project_name" title="项目名称" headerClass="center" style="WHITE-SPACE: pre-wrap" 
							sortable="true" sortProperty="project_name" />
					<display:column property="plan_type_name" class="center" title="计划类别" headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column property="pro_type_name" class="center" title="项目类别" headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column property="plan_grade_name" class="center" title="计划等级" headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column property="pro_starttime" class="center" title="开始日期" headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column property="pro_endtime" class="center" title="结束日期" headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
					<display:column property="audit_dept_name" title="审计单位" headerClass="center" class="center" sortable="true" />
					<display:column title="操作" headerClass="center" class="center">
						<a href="${contextPath}/project/permission/edit.action?pso.formId=${row.formId}">修改</a>&nbsp;&nbsp;
						<a href="${contextPath}/project/permission/view.action?pso.formId=${row.formId}" target="_blank">查看</a>&nbsp;&nbsp;
					</display:column>
					
					<display:setProperty name="paging.banner.placement" value="bottom" />
					
				</display:table>
				
			</div>
		</s:form>
	</body>
</html>
