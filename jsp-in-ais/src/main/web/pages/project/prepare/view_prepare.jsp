<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
	<head>
		<title>准备阶段</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>    
	</head>

	<body>
			<div id='prepareContent' class="easyui-tabs" fit="true" style="overflow:hidden;">
				<div  title='成员信息' style="overflow:hidden;">
					<iframe id="projectMemberFrame"
							src="${contextPath}/project/members/listMembers.action?projectFormId=<s:property value="crudObject.project_id" />"
							frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
				</div>
				<div id='projectGroupDiv' title='分组信息' style="overflow:hidden;">
						<iframe id="projectGroupFrame"
							src="${contextPath}/project/listGroupsView.action?projectFormId=<s:property value="crudObject.project_id" />"
							frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
				</div>
				<div id='actualizeScheme_outer' title='实施方案' style="overflow:hidden;">
					 <iframe id="actualizeScheme_inner"
							src="${contextPath}/operate/template/view2.action?project_id=<s:property value="crudObject.project_id" />"
							frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
				</div>
                <div id='auditWorkProgramPrepare' title='补充性审计文书' style="overflow:hidden;">
                        <iframe id="prepareWorkProgram"
                            src="${contextPath}/workprogram/viewWorkProgramProjectDetail.action?projectid=<s:property value="crudObject.project_id" />&wpd_stagecode=prepare"
                            frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
                    </div>
                
				<s:if test="projectStartObject.rework">
					<div id='projectReworkInfoDiv' title='后续审计项目信息' style="overflow:hidden;">
					</div>
					
				</s:if>
				<div id='auditAccessoryDiv' title='被审计单位资料' style="overflow:hidden;">
                        <iframe id="prepareWorkProgram"
                            src="${contextPath}/auditAccessoryList/list.action?view=view&cruProId=<s:property value="crudObject.project_id" />&wpd_stagecode=prepare"
                            frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
                </div>
			</div>
		</body>
</html>