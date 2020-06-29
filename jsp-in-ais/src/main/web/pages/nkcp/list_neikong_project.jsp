<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="4" class="edithead"
						style="text-align: left; width: 100%;">
						<s:property escape="false"
							value="@ais.framework.util.NavigationUtil@getNavigation('/ais/nkcp/listNeiKongProject.action')" />
					</td>
				</tr>
			</table>
			<div align="center">
				<display:table id="row" name="psoList" class="its"
					pagesize="${baseHelper.pageSize}" partialList="true"
					size="${baseHelper.totalRows}" sort="external" defaultsort="2"
					defaultorder="descending"
					requestURI="${contextPath}/nkcp/listNeiKongProject.action">
					<display:column title="状态" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="is_closed">
						<c:choose>
							<c:when test="${row.is_closed=='closed'}">已关闭</c:when>
							<c:otherwise>进行中</c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="项目编号" headerClass="center"
						style="WHITE-SPACE: nowrap" property="project_code" sortName="project_code"
						sortable="true" />
					<display:column title="项目名称" headerClass="center" sortable="true" sortName="project_name"
						media="html">
						<s:if
							test="${row.is_closed=='running'} || @ais.project.ProjectSysParamUtil@isClosedProjectCanView()">
							<c:set var="isUserInMembers" value="false" />
							<c:forEach items="${row.proMembers}" var="proMember">
								<c:if test="${user.floginname==proMember.userId}">
									<c:set var="isUserInMembers" value="true" />
								</c:if>
							</c:forEach>
							<s:if test="${isUserInMembers}">
								<a
									href="<s:url action="view" namespace="/project" includeParams="none"></s:url>?crudId=${row.formId}"
									target="_blank">${row.project_name}</a>
							</s:if>
							<s:else>
								<a
									href="<s:url action="view" namespace="/project" includeParams="none"></s:url>?viewPermission=full&crudId=${row.formId}"
									target="_blank">${row.project_name}</a>
							</s:else>
						</s:if>
						<s:else>
							${row.project_name}
						</s:else>
					</display:column>
					<display:column title="项目类别" headerClass="center" class="center"
						property="pro_type_name" sortable="true" sortName="pro_type_name"
						style="WHITE-SPACE: nowrap" />
					<display:column title="所属单位" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center"
						property="audit_dept_name" maxLength="10" sortable="true" sortName="audit_dept_name"/>
					<display:column title="准备" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="prepare_closed">
						<c:choose>
							<c:when test="${row.prepare_closed==null}">未执行</c:when>
							<c:when test="${row.prepare_closed=='1'}">已完成</c:when>
							<c:when test="${row.prepare_closed=='0'}">进行中</c:when>
							<c:otherwise>未执行</c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="实施" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="actualize_closed">
						<c:choose>
							<c:when test="${row.actualize_closed==null}">未执行</c:when>
							<c:when test="${row.actualize_closed=='1'}">已完成</c:when>
							<c:when test="${row.actualize_closed=='0'}">进行中</c:when>
							<c:otherwise>未执行</c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="终结" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="report_closed">
						<c:choose>
							<c:when test="${row.report_closed==null}">未执行</c:when>
							<c:when test="${row.report_closed=='1'}">已完成</c:when>
							<c:when test="${row.report_closed=='0'}">进行中</c:when>
							<c:otherwise>未执行</c:otherwise>
						</c:choose>
					</display:column>
					<s:if test="@ais.project.ProjectSysParamUtil@isArchivesEnabled()">
						<display:column title="档案" headerClass="center"
							style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="archives_closed">
							<c:choose>
								<c:when test="${row.archives_closed==null}">未执行</c:when>
								<c:when test="${row.archives_closed=='1'}">已完成</c:when>
								<c:when test="${row.archives_closed=='0'}">进行中</c:when>
								<c:otherwise>未执行</c:otherwise>
							</c:choose>
						</display:column>
					</s:if>
					<s:if
						test="@ais.project.ProjectSysParamUtil@isReworkStageEnabled()">
						<display:column title="整改" headerClass="center"
							style="WHITE-SPACE: nowrap" class="center" sortable="true" sortName="rework_closed">
							<c:choose>
								<c:when test="${row.rework_closed==null}">未执行</c:when>
								<c:when test="${row.rework_closed=='1'}">已完成</c:when>
								<c:when test="${row.rework_closed=='0'}">进行中</c:when>
								<c:otherwise>未执行</c:otherwise>
							</c:choose>
						</display:column>
					</s:if>
					<display:column title="操作" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" media="html">
						<s:if test="${row.actualize_closed=='1'}">
							<a href="${contextPath}/nkcp/viewIndex.action?projectFormId=${row.formId}">查看</a>
						</s:if>
						<s:else>
							<a href="${contextPath}/nkcp/index.action?projectFormId=${row.formId}">处理</a>
						</s:else>
					</display:column>
					<display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>
			</div>
		</center>
	</body>
</html>