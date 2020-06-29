<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
	<title>经济责任人基本信息查看</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>	
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#info").find("textarea").each(function(){
				autoTextarea(this);
			});
			var text = $('#veiwrzjl').val().replaceAll('\n','<br/>').replaceAll('\r','<br/>');
			$('#rzjlTd').html(text);
			var windowW = $('table').width();
			$("#td1").css('width',windowW*0.15);
			$("#td3").css('width',windowW*0.15);
			$("#td2").css('width',windowW*0.35);
			$("#td4").css('width',windowW*0.35);
		});
	</script>
</head>
<body style="margin: 0;padding: 0;">
	<div region="center" id="info" fit="true" border="0" style="width:100%;height: 100%;overflow: hidden">
		  <div class= "easyui-tabs" border="0" fit= "true">
			<div id='one' title='基本信息' border="0">
<%--				<div style="text-align:left;padding:5px;">--%>
<%--					<s:if test="${from == jzview }">--%>
<%--						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='${contextPath}/mng/economyduty/economyDutyAction!list.action?audobjid=${audobjid}&status=${status}'">返回</a>&nbsp;&nbsp;--%>
<%--					</s:if>--%>
<%--					<s:else>--%>
<%--						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='${contextPath}/mng/economyduty/economyDutyAction!listEconomy.action?audobjid=&status='">返回</a>&nbsp;&nbsp;--%>
<%--					</s:else>--%>
<%--				</div>--%>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tableInfo">
					<tr><td nowrap class="EditHead" colspan="4" style="text-align: left"><b>经济责任人基本信息</b></td></tr>
					<tr>
						<td class="EditHead" id="td1" nowrap="nowrap">姓名</td>
						<td class="editTd" id="td2">
							<s:textfield cssClass="noborder" name="econDutyBaseInfo.name" size="37" disabled="true"
							             cssStyle="border:0px;background-color:#fff;color:#000;" maxlength="30" />
						</td>
						<td class="EditHead" nowrap="nowrap">性别</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.sex" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">出生日期</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.birth" />
						</td>
						<td class="EditHead" nowrap="nowrap">民族</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.nation" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">籍贯</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.nativePlace" />
						</td>
						<td class="EditHead" nowrap="nowrap">政治面貌</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.polityVisage" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">职称级别</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.technicalPost" />
						</td>
						<td class="EditHead" nowrap="nowrap">执业资格</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.competence" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">手机</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.mobileTelephone" />
						</td>
						<td class="EditHead" nowrap="nowrap">电子邮箱
						</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.email" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">所属被审计单位</td>
						<td class="editTd" colspan="3">
							<s:property value="econDutyBaseInfo.company" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">最近一次审计期间结束</td>
						<td class="editTd" colspan="3">
							<s:property value="econDutyBaseInfo.audit_end_time"/>
						</td>
					</tr>



					<tr><td nowrap class="EditHead" colspan="4" style="text-align: left"><b>${econDutyBaseInfo.company}任职情况说明</b></td></tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">在职状态</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.incumbencyState" />
						</td>
						<td class="EditHead" id="td3" nowrap="nowrap" >员工编号</td>
						<td class="editTd" id="td4">
							<s:textfield cssClass="noborder" name="econDutyBaseInfo.personCode" size="37" disabled="true"
										 cssStyle="border:0px;background-color:#fff;color:#000;" maxlength="30" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">工作部门
						</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.department" />
						</td>
						<td class="EditHead" nowrap="nowrap">职务</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.duty" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">任职开始日期</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.beginDate" />
						</td>
						<td class="EditHead" nowrap="nowrap">任职文件号</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.beginDocNum" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">任职结束日期</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.endDate" />
						</td>
						<td class="EditHead" nowrap="nowrap">离职文件号</td>
						<td class="editTd">
							<s:property value="econDutyBaseInfo.endDocNum" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">经济责任描述</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" disabled="true" rows="3" name="econDutyBaseInfo.bewrite" cssStyle="width:100%;height:100%;overflow-y:hidden;color:#000;background:#fff" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap="nowrap">附件</td>
						<td class="editTd" colspan="3">
							<div id="doubtReasionFile" class="easyui-fileUpload"
									 data-options="fileGuid:'${econDutyBaseInfo.accessory}', 
									               isAdd:false,
									               isEdit:false,
									               isDel:false,
									               isView:true,
									               isDownload:true,
									               isdebug:true,
									               spaceSumibtFiles:false"></div>
						</td>
					</tr>
				</table>
			</div>
			
			<div id='two' title='任职经历'>
<%--				<div style="text-align:left;padding:5px;">--%>
<%--				<s:if test="${from == jzview }">--%>
<%--						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='${contextPath}/mng/economyduty/economyDutyAction!list.action?audobjid=${audobjid}&status=${status}'">返回</a>&nbsp;&nbsp;--%>
<%--					</s:if>--%>
<%--					<s:else>--%>
<%--						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='${contextPath}/mng/economyduty/economyDutyAction!listEconomy.action?audobjid=&status='">返回</a>&nbsp;&nbsp;--%>
<%--					</s:else>--%>
<%--				</div>--%>
				<form action="" id="serchForm">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tab2">
						<tr>
							<td class="EditHead" width="15%">
								任职经历
							</td>
							<td id="rzjlTd" class="editTd" width="85%" colspan="3">
								<s:textarea id="veiwrzjl" cssClass="noborder" disabled="true" rows="3" name="econDutyBaseInfo.through" cssStyle="width:100%;height:100%;border:0;overflow-y:hidden;color:#000;background:#fff" />	
							</td>
						</tr>
					</table>
				</form>
			</div>
	
			<div id='three' title='在审项目信息' style="overflow: hidden;">
				<iframe src="${contextPath}/mng/economyduty/economyDutyAction!toProject.action?id=${id}&status=${status}&audobjid=${audobjid}&from=${from}"
					frameborder="0" width="100%" height="98%" scrolling="no"></iframe>
			</div>
			
			<div id='four' title='历史项目信息' style="overflow:hidden;">
				<iframe src="${contextPath}/mng/economyduty/economyDutyAction!toHisProject.action?id=${id}&status=${status}&audobjid=${audobjid}&from=${from}"
					frameborder="0" width="100%" height="98%" scrolling="no"></iframe>
			</div>
		</div>
	</div>
</body>
</html>
