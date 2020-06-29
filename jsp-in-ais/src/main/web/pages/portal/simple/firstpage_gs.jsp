<%@page import="ais.user.model.UUser"%>
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@page import="ais.framework.util.StringUtil"%>
<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="ais.portal.simple.model.Information"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<title>门户3</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath() %>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	</head>
	<body class="easyui-layout">
		<div region="north" style="height: 230px;">
			<table id="pendingTable">
			</table>
		</div>
		<div region="center">
			<table id="projectTable">
				<thead>
					<tr>
						<th data-options="field:'projectCode',width:200,align:'center'">项目编码</th>
						<th data-options="field:'projectName',width:250,align:'center'">项目名称</th>
						<th data-options="field:'projectTypeName',width:100,align:'center'">项目类型</th>
						<th data-options="field:'roleName',width:150,align:'center'">成员角色</th>
						<th data-options="field:'startTime',width:150,align:'center'">开始时间</th>
						<th data-options="field:'endTime',width:150,align:'center'">结束时间</th>
						<th data-options="field:'projectState',width:150,align:'center'">项目阶段</th>
					</tr>
				</thead>
			</table>
		</div>
		<script type="text/javascript">
		$(document).ready(function() {
			parent.document.getElementById('studyGardenBlock').innerHTML = $('#if_studyGardenBlock').html();
			$('#projectTable').datagrid({
				title : '我的项目',
				width : 800,
				height : 'auto',
				nowrap : false,
				striped : true,
				border : false,
				collapsible : false,//是否可折叠的  
				fit : true,//自动大小  
				url : "${contextPath}/project/listMyProjectFirstPage.action",
				remoteSort : false,
				idField : 'projectId',
				singleSelect : false,//是否单选  
				pagination : true,//分页控件  
				rownumbers : true
			//行号  
			});
			//设置分页控件  
			var p = $('#projectTable').datagrid('getPager');
			$(p).pagination({
				pageSize : 10,//每页显示的记录条数，默认为10  
				pageList : [ 10, 15, 20 ],//可以设置每页记录条数的列表  
				beforePageText : '第',//页数文本框前显示的汉字  
				afterPageText : '页    共 {pages} 页',
				displayMsg : '记录数：[{from} - {to}]/{total} 条'
			});
			$('#pendingTable').datagrid({
				width : 800,
				height : 'auto',
				nowrap : false,
				striped : true,
				border : false,
				collapsible : false,//是否可折叠的  
				fit : true,//自动大小  
				url : "${contextPath}/portal/simple/getPendingTask.action",
				remoteSort : false,
				idField : 'formId',
				singleSelect : false,//是否单选  
				pagination : true,//分页控件  
				rownumbers : true,
				columns:[[{
					field:'processName',title:'流程名称',width:200,align:'center'
				},{
					field:'formNameDetail',title:'任务',width:300,align:'center',
					formatter:function(value,rowData,rowIndex){
						var ss = "javascript:window.parent.goMenu('任务处理','/ais"+ rowData['editUrl']+"','task');";
						var s = '<a href="javascript:void(0);" onclick="';
						s = s+ss+'">'+value+'</a>';
						return s;
				}},{
					field:'fromActorName',title:'上一步处理人',width:100,align:'center'
				},{field:'create',title:'处理日期',width:150,align:'center'}
				]]
			});
			//设置分页控件  
			var pp = $('#pendingTable').datagrid('getPager');
			$(pp).pagination({
				pageSize : 10,//每页显示的记录条数，默认为10  
				pageList : [ 10, 15, 20 ],//可以设置每页记录条数的列表  
				beforePageText : '第',//页数文本框前显示的汉字  
				afterPageText : '页    共 {pages} 页',
				displayMsg : '记录数：[{from} - {to}]/{total} 条'
			});
		});
		
		//项目阶段点击操作
		function projectIndex(crudId, stateNo) {
			var udswin = window.open(
					'${contextPath}/project/prepare/projectIndex.action?crudId='
							+ crudId + '&stateNo=' + stateNo, '',
							'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			udswin.moveTo(0, 0);
			udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
		}
	</script>
	
	<div id='if_studyGardenBlock'>	
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style='font-size:12px;'>
			<tr >
				<td width="70%" align="left" valign="middle" bgcolor="#adc6dd" class="name" style="height:25px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
				&nbsp;&nbsp;通知</td>
				<td width="20%" align="center" valign="middle" bgcolor="#adc6dd" style="border-right:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
					<a onclick="window.open('${contextPath}/portal/simple/information/listByType.action?information.type=3','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
					style="font:11px" href="javascript:;" >更多</a>
				</td>
			</tr>
			<tr>
				<td height="<s:property value="map['systemNotify'].size*20"/>" colspan="3" align="center" valign="top">
					<table width="90%" border="0" cellspacing="0" cellpadding="0" valign="top">
						<s:iterator value="map['systemNotify']" id="row">
							<tr>
								<td height="25" class="line" nowrap="nowrap"> 
									<div><span class='span1'>></span>&nbsp;
										<a onclick="window.open('/ais/portal/simple/information/viewByType.action?information.type=3&information.id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
											href="javascript:void(0);" title="${row.title}">
											${row.title}
										</a>
									</div>
								</td>
							</tr>
						</s:iterator>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					&nbsp;
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style='font-size:12px;'>
			<tr>
				<td width="70%" align="left" valign="middle" bgcolor="#adc6dd" class="name" style="height:25px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
				&nbsp;&nbsp;学习园地
				</td>
				<td width="20%" align="center" valign="middle"
					bgcolor="#adc6dd" style="border-right:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
					<a style="font:11px"
					onclick="window.open('${contextPath }/portal/simple/information/gardenPlotSearch.action?view=1','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
					href="javascript:void(0);">更多</a>
				</td>
			</tr>
			<tr>
				<td height="235" colspan="3" align="center" valign="top">
					<table width="90%" border="0" cellspacing="0" cellpadding="0">
						<s:iterator value="map['studyGraden']" id="row">
							<tr>
								<td height="25" class="line"><div>
								<s:if test="${row.new}">
										<span style="font-size:8px;text-align:left;color:#F29110;font-weight:bold;">NEW </span>&nbsp;
									</s:if>
									<s:else><span class='span1'>></span>&nbsp;</s:else>
								<a
										onclick="window.open('${contextPath }/portal/simple/information/gardenPlotView.action?studyGardenPlot.id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
										href="javascript:void(0);" title="${row.title }">
									${row.title}</a></div>
								</td>
							</tr>
					   </s:iterator>
					</table>
				</td>
			</tr>
		</table>	
	</div>
	
</body>
</html>

