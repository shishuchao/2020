<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title>AIS审计作业系统</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="${smvc}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${smvc}/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout2/css/layout.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout2/css/themes/light.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/easyui/querytable.css" rel="stylesheet" type="text/css" />
	<style>
		.longTD{
			overflow:hidden;
			white-space:nowrap;
			text-overflow:ellipsis;
		}
	</style>

<body class="page-header-fixed page-container-bg-solid">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top" style="height: 65px;">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner ">
		<div class="page-actions" style="height: 65px;line-height: 32px;width: 5%;">
			<div class="btn-group">
				<a class="btn btn-circle btn-default btn-sm" href="#proDialog" data-toggle="modal">
					<i class="fa fa-refresh"></i> 项目切换
				</a>
			</div>
		</div>
		<!-- BEGIN PAGE TOP -->
		<div class="page-top" style="height: 65px;">
			<ul class="nav navbar-nav pull-right" style="margin-top: 25px;cursor: pointer;">
				<li class="dropdown dropdown-extended quick-sidebar-toggler">
					<i class="icon-logout"></i>
				</li>
			</ul>
			<div class="top-menu" style="width: 90%;">
				<div class="mt-element-step">
					<div class="row step-thin" id="steps">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container" style="margin-top: 67px;">
	<!-- BEGIN CONTENT -->
		<!-- BEGIN CONTENT BODY -->
		<div class="page-content" style="margin: 5px;">
			<div class="row ">
				<div class="col-md-12">
					<div class="tabbable tabbable-custom" id="tab-bar" role="tablist">
						<ul class="nav nav-tabs">
						</ul>
						<div class="tab-content">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END CONTENT BODY -->
	<!-- END CONTENT -->
	<a href="javascript:;" class="page-quick-sidebar-toggler">
		<i class="icon-login" style="color:white;"></i>
	</a>
	<div class="page-quick-sidebar-wrapper" data-close-on-body-click="false" style="background: #3cb1bb;width: 270px;">
		<div class="page-quick-sidebar" style="background: #3cb1bb;">
			<ul class="nav nav-tabs">
				<li class="active">
					<a href="javascript:;" data-target="#auditTool" data-toggle="tab" style="font-size: 25px;">审计工具
					</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="auditTool" style="font-size: 18px;">
					<a style="font-size: 18px;" class="btn default btn-block" href="#proInfo" data-toggle="modal"> 项目信息 </a>
					<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="ProjectIndex.goMenu('成员信息','${contextPath}/project/getlistMembers.action?view=${view }&crudId=${projectStartObject.formId }','1008')"> 成员信息 </a>
					<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="ProjectIndex.goMenu('实施方案','${contextPath}/operate/template/view.action?view=${view }&project_id=${projectStartObject.formId }','1003')"> 实施方案 </a>
					<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="ProjectIndex.goMenu('审计文书','${contextPath}/pages/operate/manu/law_redirect.jsp?projectId=${projectStartObject.formId}','13')"> 审计文书 </a>
					<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="ProjectIndex.goMenu('审计分工','${contextPath}/operate/task/project/showContentTypeWorkView.action?owner=true&project_id=${projectStartObject.formId }&view=${view }','fengong')"> 审计分工 </a>
					<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="ProjectIndex.goMenu('被审计单位资料','${contextPath}/auditAccessoryList/list.action?cruProId=${projectStartObject.formId }&pro_type=${projectStartObject.pro_type }&pro_type_child=${projectStartObject.pro_type_child}&view=${view }','1005')"> 被审计单位资料 </a>
					<s:if test="${editAccountBook eq 'Y'}">
						<s:if test="${viewAccountBook eq 'Y'}">
							<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="ProjectIndex.goMenu('被审计单位账套','${contextPath}/project/prepare/accountbookEdit.action?projectId=${projectStartObject.formId}','auditbook')"> 被审计单位账套 </a>
						</s:if>
					</s:if>
					<s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
						<a href="javascript:;" style="font-size: 18px;" class="btn default btn-block" onclick="zxsj();"> 大数据审计 </a>
					</s:if>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END CONTAINER -->
<!--项目切换-->
<div class="modal fade modal-scroll bs-modal-lg" id="proDialog" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title">项目切换</h4>
			</div>
			<div class="modal-body"style="height: 460px;">
				<div class="table-scrollable">
					<table id="myProjectsTable" style="table-layout:fixed" class="table table-hover table-light">
						<thead>
						<tr>
							<th style="width: 30%;">项目名称</th>
							<th style="width: 30%;">项目编号</th>
							<th style="width: 20%;">项目角色</th>
							<th style="width: 20%;">当前阶段</th>
						</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty projects}">
									<c:forEach items="${projects}" var="pro">
										<tr ondblclick="ProjectIndex.changeProject('${pro['projectId']}','${pro['projectState']}')">
											<td class="longTD" title="${pro['projectName']}">${pro['projectName']}</td>
											<td class="longTD" title="${pro['projectCode']}">${pro['projectCode']}</td>
											<td class="longTD">
												<c:forEach items="${pro['roleName']}" var="role">
													${role}
												</c:forEach>
											</td>
											<td>
												<c:choose>
													<c:when test="${pro['projectState'] eq 'prepare'}">
														准备
													</c:when>
													<c:when test="${pro['projectState'] eq 'actualize'}">
														实施
													</c:when>
													<c:when test="${pro['projectState'] eq 'report'}">
														终结
													</c:when>
													<c:when test="${pro['projectState'] eq 'archives'}">
														归档
													</c:when>
													<c:when test="${pro['projectState'] eq 'rework'}">
														整改
													</c:when>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>

								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!--项目信息-->
<div class="modal fade modal-scroll bs-modal-lg" id="proInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title">项目信息</h4>
			</div>
			<div class="modal-body"style="height: 460px;">
				<div class="table-scrollable">
					<table id="projectStartTable" class="ListTable" style="width:100%">
						<tr>
							<td class="EditHead">项目名称</td>
							<td class="editTd"><s:property
									value="projectStartObject.project_name" /></td>
							<td class="EditHead">项目编号</td>
							<td class="editTd"><input type="hidden"
													  name="projectStartObject.project_code"
													  value="${projectStartObject.project_code }"> <s:property
									value="projectStartObject.project_code" /></td>
						</tr>
						<tr>
							<td class="EditHead">项目年度</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_year" /></td>
							<td class="EditHead">项目类别</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_type_name" /> &nbsp;&nbsp; <s:property
									value="projectStartObject.pro_type_child_name" /></td>
						</tr>
						<tr>
							<td class="EditHead">计划类别</td>
							<td class="editTd" colspan="3"><s:property
									value="projectStartObject.plan_type_name" /></td>
						</tr>
						<s:if test="${!projectStartObject.nbzwpg}">
							<tr>
								<td class="EditHead">审计单位</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_dept_name" /></td>
								<td class="EditHead">被审计单位</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_object_name" /></td>
							</tr>
						</s:if>
						<s:else>
							<td class="EditHead">测试组织者</td>
							<td class="editTd"><s:property
									value="projectStartObject.audit_dept_name" /></td>
							<td class="EditHead">测内控专岗负责人</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_teamleader_name" /></td>
						</s:else>
						<!-- 工程项目审计 -->
						<s:if test="projectStartObject.gcxmsj">
							<tr id="gcxmTr1">
								<td class="EditHead" id="gcxmTd1">合同金额</td>
								<td class="editTd"><s:property
										value="projectStartObject.contractAmount" />万元</td>
								<td class="EditHead" id="gcxmTd2">项目管理模式</td>
								<td class="editTd"><s:property
										value="projectStartObject.managerType" /></td>
							</tr>
							<tr id="gcxmTr2">
								<td class="EditHead" id="gcxmTd3">开工日期</td>
								<td class="editTd"><s:property
										value="projectStartObject.startProDate" /></td>
								<td class="EditHead" id="gcxmTd4">竣工日期</td>
								<td class="editTd"><s:property
										value="projectStartObject.finishProDate" /></td>
							</tr>
							<tr id="gcxmTr3">
								<td class="EditHead" id="gcxmTd5">项目状态</td>
								<td class="editTd" colspan="3"><s:property
										value="projectStartObject.proStatus" /></td>
							</tr>
						</s:if>

						<s:if test="projectStartObject.jjzrr">
							<tr>
								<td class="EditHead">经济责任人</td>
								<td class="editTd"><s:property
										value="projectStartObject.jjzrrname" /></td>
								<td class="EditHead">是否为总公司党组管理干部</td>
								<td class="editTd"><s:if
										test="${projectStartObject.isDangLeader=='true'}">
									是
								</s:if> <s:else>
									否
								</s:else></td>
							</tr>
						</s:if>
						<s:if test="projectStartObject.rework">
							<tr>
								<td class="EditHead">后续审计项目</td>
								<td class="editTd" colspan="3"><s:property
										value="projectStartObject.reworkProjectNames" /></td>
							</tr>
						</s:if>
						<tr>
							<td class="EditHead">开始日期</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_starttime" /></td>
							<td class="EditHead">结束日期</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_endtime" /></td>
						</tr>
						<s:if test="${!projectStartObject.nbzwpg}">
							<tr>
								<td class="EditHead" nowrap><s:if
										test="varMap['audit_start_timeRequired']">
									<font color=red>*</font>
								</s:if> 审计期间开始</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_start_time" /> <input
										type="hidden" name="projectStartObject.audit_start_time"
										value="${projectStartObject.audit_start_time }"></td>
								<td class="EditHead" nowrap><s:if
										test="varMap['audit_end_timeRequired']">
									<font color=red>*</font>
								</s:if> 审计期间结束</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_end_time" /> <input type="hidden"
																							name="projectStartObject.audit_end_time"
																							value="${projectStartObject.audit_end_time }"></td>
							</tr>
							<tr>
								<td class="EditHead">
									立项依据
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.content" />
								</td>
							</tr>
							<tr>
								<td class="EditHead">
									审计目的
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.audit_purpose" />
								</td>
							</tr>
							<tr >
								<td class="EditHead">
									审计安排
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.audArrange" />
								</td>
							</tr>
							<tr >
								<td class="EditHead">
									审计重点
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.audEmphasis"/>
								</td>
							</tr>

							<tr>
								<td class="EditHead">
									备注
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.plan_remark"/>
								</td>
							</tr>
						</s:if>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    var contextPath = '${smvc}';
    var crudId = '${crudId}';
    var source = '${source}';
    var projectview = '${projectview}';
    var menuIds = '${parents}';
    var stateI = ${stateI};
</script>
<!--[if lt IE 9]>
<script src="${smvc}/index/assets/global/plugins/respond.min.js"></script>
<script src="${smvc}/index/assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<script src="${smvc}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>

<script src="${smvc}/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/scripts/app.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/layouts/layout2/scripts/layout.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<link href="${smvc}/easyui/1.4/themes/metro/easyui.css" rel="stylesheet" type="text/css"/>
<link href="${smvc}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css"/>
<script src="${smvc}/easyui/1.4/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${smvc}/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="${smvc}/scripts/base64_Encode_Decode.js" type="text/javascript"></script>
<script src="${smvc}/index/projectindex.js" type="text/javascript"></script>
<script type="text/javascript">
    /**
     * 在线审计
     */
    function zxsj(){
        if(${view eq 'view'}){
            alert('当前为预览状态。不可操作！');
            return;
        }
        var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
        var projectCode = document.getElementsByName("projectStartObject.project_code")[0].value;
        var auditStartTime = document.getElementsByName("projectStartObject.audit_start_time")[0].value;
        if(auditStartTime==''){
            alert('审计期间没有定义,无法在线作业!');
            return false;
        }
        var start_1=auditStartTime.split("-")[0];
        var start_2=auditStartTime.split("-")[1];
        var start_3=auditStartTime.split("-")[2];

        if(start_2.length==1){
            start_2 = '0' + start_2;
        }
        if(start_3.length==1){
            start_3 = '0' + start_3;
        }

        var start=start_1+start_2+start_3;

        var auditEndTime = document.getElementsByName("projectStartObject.audit_end_time")[0].value;
        if(auditEndTime==''){
            alert('审计期间没有定义,无法在线作业!');
            return false;
        }
        var end_1=auditEndTime.split("-")[0];
        var end_2=auditEndTime.split("-")[1];
        var end_3=auditEndTime.split("-")[2];

        if(end_2.length==1){
            end_2 = '0' + end_2;
        }
        if(end_3.length==1){
            end_3 = '0' + end_3;
        }

        var end=end_1+end_2+end_3;

        /*var queryString = encode64(encodeURI(""+projectCode+","+start+","+end+",${user.floginname}"));
        var url ="http://"+host+"/login.jsp?p="+queryString;*/
        var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
        var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
        var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
        var udswin=window.open(url,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
        udswin.moveTo(0,0);
        udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
    }
</script>

</body>

</html>

