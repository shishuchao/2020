<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>归档流程-查看</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<style>
		#topDiv {
			position: fixed;
			top: 0;
			z-index: 10000;
			width: 99%;
		}
		#mainDiv{
			margin-top: 40px;
		}
	</style>
	<script type="text/javascript">
   /*
	* 显示或隐藏项目基本信息
	*/
	function triggerProjectInfoDiv(){
		var evt = window.event;
		var eventSrc = evt.target || evt.srcElement;
		var proInfoDiv = document.getElementById('proInfoDiv');
		if(proInfoDiv.style.display=='none'){
			//eventSrc.innerText="隐藏项目信息";
			proInfoDiv.style.display='';
		}else{
			//eventSrc.innerText="展开项目信息";
			proInfoDiv.style.display='none';
		}
	}
	</script>
	<body  style="overflow: auto;">
		<div id="topDiv">
			<table cellpadding=0 cellspacing=0 border=0 align="center" style="width: 100%; background-color: #FAFAFA;">
				<tr>
					<td class="editTd" colspan="4">
						<div style="text-align:right;">
							<s:if test="${view=='com'}">
								<!--<s:button name="" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/archives/pigeonhole/searchArchivesList.action'" />-->
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/archives/pigeonhole/searchArchivesList.action'">返回</a>&nbsp;&nbsp;
							</s:if>
							<s:if test="${view=='admin'}">
								<!--<s:button name="" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/archives/pigeonhole/searchArchivesList4admin.action'" />-->
								<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/archives/pigeonhole/searchArchivesList4admin.action'">返回</a>&nbsp;&nbsp;
							</s:if>

						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="mainDiv">
		<div id="proInfoDiv" >
			<s:if test="${projectStartObject.project_name!=null}">
				 <%@include file="/pages/project/start/edit_start_include_readonly.jsp"%>
			</s:if>
			<s:else>
				<%@include file="/pages/project/start/edit_start_include_readonlyByCrudObject.jsp"%>
			</s:else>
		</div>


		<s:form action="view" namespace="/archives/pigeonhole">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >

					<td align="left" class="EditHead" style="width: 20%">
						档案名称
					</td>
					<td class="editTd" align="right" style="width: 30%">
						<s:property value="crudObject.archives_name" />

					</td>

					<td align="left" class="EditHead" style="width: 20%">
						档案编号
					</td>
					<td class="editTd" align="right" style="width: 30%">
						<s:property value="crudObject.archives_code" />

					</td>
				</tr>

				<tr>
					<td align="left" class="EditHead">
						档案类型
					</td>
					<td class="editTd" align="right">
						<s:property value="crudObject.archives_type_name"/>
					</td>

					<td align="left" class="EditHead">
						档案状态
					</td>
					<td class="editTd" align="right">
						<s:property value="crudObject.archives_status_name" />
					</td>
				</tr>


				<tr class="listtablehead">
					<td align="left" class="EditHead">
						所属年度
					</td>
					<td class="editTd" align="right">

					<s:property value="crudObject.audit_start_time" />
					&nbsp;至&nbsp;
					<s:property value="crudObject.audit_end_time" />
					</td>

					<td align="left" class="EditHead">
						<!-- 档案保存期限(年) -->
					</td>
					<td class="editTd" align="right">

						<%-- <s:property value="crudObject.archives_save_year" /> --%>
					</td>
				</tr>

				<tr >
					<!-- <td align="left" class="listtabletr11">
						秘密等级：
					</td>
					<td class="ListTableTr22" align="right">
						<s:property value="crudObject.archives_secrecy_name" />
					</td> -->

					<td align="left" class="EditHead">
					工作组负责人
				</td>
				<td class="editTd">
					<s:property value="crudObject.principal" />
					<s:hidden name="crudObject.principal"/>
				</td>
					<td align="left" class="EditHead">
						立档单位
					</td>
					<td class="editTd" align="right">


						<s:property value="crudObject.archives_unit_name" />
					</td>
				</tr>



				<tr >
					<td align="left" class="EditHead">
						归档人
					</td>
					<td class="editTd" align="right">
						<s:property value="crudObject.archives_start_man_name" />
					</td>


					<td align="left" class="EditHead">
						归档日期
					</td>
					<td class="editTd" >
						<s:property value="crudObject.archives_time" />
					</td>
				</tr>

				<tr >
				<td align="left" class="EditHead">
					项目时间
				</td>
				<td class="editTd">
					<s:property value="crudObject.audit_start_time" />
					<s:if test="crudObject.audit_start_time != null && crudObject.audit_end_time != null">
					&nbsp;至&nbsp;
					</s:if>
					<s:property value="crudObject.audit_end_time" />
					<s:hidden name="crudObject.audit_end_time"/>
					<s:hidden name="crudObject.audit_start_time"/>
				</td>
				<td align="left" class="EditHead">
					被审计单位
				</td>
				<td class="editTd">
					<s:property value="crudObject.audit_object_or_jjzrrname" />
					<s:hidden name="crudObject.audit_end_time"/>
				</td>
			</tr>
			<tr >
				<td align="left" class="EditHead">
					备注说明
				</td>
				<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" disabled="true" cssStyle="width:100%;line-height:150%;outline:none;background-color:#fff;color:#000;"
						name="crudObject.archivers_comment" />
				</td>
			</tr>

			</table>


			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>

			<s:hidden name="crudId" />
			<s:hidden name="taskInstanceId" />

		</s:form>
		</div>
	</body>
</html>
