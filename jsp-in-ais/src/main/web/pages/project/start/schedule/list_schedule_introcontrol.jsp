<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>排程列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<link href="<%=basePath%>styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div>
			<a href="javascript:window.location.href='${contextPath}/project/schedule!scheduleList.action?crudId=${crudId}'" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</a>
		</div>
		<table>
			<thead>
				<tr class="ListTableTrCenter" style="background-color: #EEF7FF; font-weight: bold;">
					<td style="text-align: center; width: 14%">
						分组名称
					</td>
					<td style="text-align: center; width: 14%">
						测试地区
					</td>
					<td style="text-align: center; width: 14%">
						被测试单位
					</td>
					<td style="text-align: center; width: 23%">
						人员分配
					</td>
					<td style="text-align: center; width: 8%">
						计划天数
					</td>
					<td style="text-align: center; width: 23%">
						计划日期
					</td>
					<s:if test="#request.stage != 'impl'">
					<td style="text-align: center; width: 5%">
						操作
					</td>
					</s:if>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#request.memberGroupList.{?#this.groupType != 'zhengti'}" id="memberGroup">
					<tr class="ListTableTrCenter" style="background-color: white;">
						<td style="text-align: center; width: 14%; vertical-align: middle" class="ListTableTd">
							<s:property value="#memberGroup.groupName" />
						</td>
						<td style="text-align: center; width: 14%; vertical-align: middle" class="ListTableTd">
							<s:property value="#memberGroup.area" />
						</td>
						<td style="text-align: center; width: 14%;" class="ListTableTd">
							<s:iterator value="#memberGroup.proMemberScheduleList" id="Schedule" status="st">
								<tt><s:property value="#Schedule.auditobjectname" />
								</tt>
								<br>
							</s:iterator>
						</td>
						<td style="text-align: center; width: 23%" class="ListTableTd">
							<s:iterator value="#memberGroup.proMemberScheduleList" id="Schedule">
								<tt><s:property value="#Schedule.auditperson" />
								</tt>
								<br>
							</s:iterator>
						</td>
						<td style="text-align: center; width: 8%" class="ListTableTd">
							<s:iterator value="#memberGroup.proMemberScheduleList" id="Schedule">
								<tt><s:property value="#Schedule.plantime" />
								</tt>
								<br>
							</s:iterator>
						</td>
						<td style="text-align: center; width: 23%" class="ListTableTd">
							<s:iterator value="#memberGroup.proMemberScheduleList" id="Schedule">
								<tt><s:property value="#Schedule.starttiem" />&nbsp;至&nbsp;<s:property value="#Schedule.endtime" />
								</tt>
								<br>
							</s:iterator>
						</td>
						<s:if test="#request.stage != 'impl'">
						<td style="text-align: center; width: 5%" class="ListTableTd">
						       <%
						         String isSee = (String)request.getAttribute("isSee");
						         System.out.println(isSee);
						         if("y".equals(isSee)){
						       %>
								<s:iterator value="#memberGroup.proMemberScheduleList" id="Schedule">
									<tt><a href="javascript:void(0)" onclick="doModify('<s:property value="#Schedule.scheduleid"/>','<s:property value="#memberGroup.proInfo.formId"/>','<s:property value="#memberGroup.groupName"/>','<s:property value="#memberGroup.area"/>','<s:property value="#memberGroup.groupId"/>')" style="cursor: pointer;">修改</a>
									</tt>
									<!-- <tt><a href="javascript:void(0)" onclick="doDel('<s:property value="#Schedule.scheduleid"/>','<s:property value="#memberGroup.proInfo.formId"/>')" style="cursor: pointer;">删除</a></tt> -->
									<br>
								</s:iterator>
							   <%} %>
						</td>
						</s:if>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</body>
	<script type="text/javascript">
function doModify(scheduleId,projectId,groupName,area,groupId){
  window.location = "<%=basePath%>project/schedule!schduleModifyList.action?scheduleId="+scheduleId+"&crudId="+projectId+"&groupName="+encodeURI(encodeURI(groupName))+"&area="+encodeURI(encodeURI(area))+"&groupId="+groupId;
}

function doDel(scheduleId,projectId){
  if(confirm("确定删除该排程？")){
    window.location = "<%=basePath%>project/schedule!schduleDel.action?scheduleId="+scheduleId+"&crudId="+projectId;
  }
}

</script>
</html>