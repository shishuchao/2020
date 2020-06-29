<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目关闭列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
					<div style="display: inline;width:80%;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/project/listProjectOfWait4Close.action')"/>
					</div>
				</td>
			</tr>
		</table>
			<div align="center">
				<display:table id="row" name="projectList" pagesize="10" class="its"
					requestURI="${contextPath}/project/listProjectOfWait4Close.action">
					<display:column title="选择" media="html" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center">
						<input type="radio" name="crudIds" value="${row.formId}" />
					</display:column>
					<display:column title="项目状态" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true">
						<c:choose>
							<c:when test="${row.is_closed=='close'}">已关闭</c:when>
							<c:otherwise>正在执行</c:otherwise>
						</c:choose>
					</display:column>

					<display:column title="项目编号" headerClass="center"
						style="WHITE-SPACE: nowrap" property="project_code"
						sortable="true" />

					<display:column title="项目名称" property="project_name" headerClass="center"
						 sortable="true"  media="html" />

					<display:column title="项目类别" headerClass="center" class="center"
						property="pro_type_name" sortable="true"
						style="WHITE-SPACE: nowrap" />
					
					<display:column title="所属单位" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center"
						property="audit_dept_name" maxLength="10" sortable="true" />
						
					<display:column title="准备" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true">
						<c:choose>
							<c:when test="${row.prepare_closed==null}">未执行</c:when>
							<c:when test="${row.prepare_closed=='1'}">已完成</c:when>
							<c:when test="${row.prepare_closed=='0'}">进行中</c:when>
							<c:otherwise>未执行</c:otherwise>
						</c:choose>
					</display:column>
					
					<display:column title="实施" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true">
						<c:choose>
							<c:when test="${row.actualize_closed==null}">未执行</c:when>
							<c:when test="${row.actualize_closed=='1'}">已完成</c:when>
							<c:when test="${row.actualize_closed=='0'}">进行中</c:when>
							<c:otherwise>未执行</c:otherwise>
						</c:choose>
					</display:column>
					
					<display:column title="终结" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center" sortable="true">
						<c:choose>
							<c:when test="${row.report_closed==null}">未执行</c:when>
							<c:when test="${row.report_closed=='1'}">已完成</c:when>
							<c:when test="${row.report_closed=='0'}">进行中</c:when>
							<c:otherwise>未执行</c:otherwise>
						</c:choose>
					</display:column>
					<s:if test="@ais.project.ProjectSysParamUtil@isXMTZEnabled()">
						<display:column title="台账" headerClass="center"
							style="WHITE-SPACE: nowrap" class="center" sortable="true">
							<c:choose>
								<c:when test="${row.account_closed==null}">未执行</c:when>
								<c:when test="${row.account_closed=='1'}">已完成</c:when>
								<c:when test="${row.account_closed=='0'}">进行中</c:when>
								<c:otherwise>未执行</c:otherwise>
							</c:choose>
						</display:column>
					</s:if>
					<s:if test="@ais.project.ProjectSysParamUtil@isArchivesEnabled()">
						<display:column title="档案" headerClass="center"
							style="WHITE-SPACE: nowrap" class="center" sortable="true">
							<c:choose>
								<c:when test="${row.archives_closed==null}">未执行</c:when>
								<c:when test="${row.archives_closed=='1'}">已完成</c:when>
								<c:when test="${row.archives_closed=='0'}">进行中</c:when>
								<c:otherwise>未执行</c:otherwise>
							</c:choose>
						</display:column>
					</s:if>
					<s:if test="@ais.project.ProjectSysParamUtil@isReworkStageEnabled()">
						<display:column title="整改" headerClass="center"
							style="WHITE-SPACE: nowrap" class="center" sortable="true">
							<c:choose>
								<c:when test="${row.rework_closed==null}">未执行</c:when>
								<c:when test="${row.rework_closed=='1'}">已完成</c:when>
								<c:when test="${row.rework_closed=='0'}">进行中</c:when>
								<c:otherwise>未执行</c:otherwise>
							</c:choose>
						</display:column>
					</s:if>
					<display:setProperty name="paging.banner.placement" value="bottom" />
					
				</display:table>
				
			</div>
			
			<div align="right" style="width: 98%">
				<input type="button" value="关闭项目" onclick="closeProject()">
			</div>
			
		<script type="text/javascript">
		
			/*
			*  关闭项目
			*/
			function closeProject(){
				var projectRadios = document.getElementsByName("crudIds");
				
				if(projectRadios.length<1){
					alert('请选择至少一个项目');
					return;
				}
				for(var i=0;i<projectRadios.length;i++){
					if(projectRadios[i].checked){
						if(confirm('确定关闭项目吗?')){
							window.location.href="${contextPath}/project/closeProject.action?crudId="+projectRadios[i].value;
						}
						break;
					}
				}
			}
			
		</script>
	</body>
</html>
