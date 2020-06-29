<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>查看消息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>	
		<style type="text/css">
			table {	margin: 0px 0 0px 0 !important;}
			.mybutton{
				 border:1px solid #59bbe8;
				 padding:2px 2px 0px 2px;
				 FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA);
				 color:#006699;
				 cursor:hand;
			}				
		</style>
		<script type="text/javascript">
		/* 台账审批 */
		function approveEntryAt(apId) {
			var url = "${contextPath}/ea/audAccount/initPage.action?apId="+apId;
			window.location=url;
		};	
		/* 审计报告审批 */
		function approveEntryAc(apId) {
			var url = "${contextPath}/ea/audAccount/initClusionPage.action?apId="+apId;
			window.location=url;
		};		
		</script>
	</head>
<body style="overflow: auto;">
<s:form action="" name="innerMsgForm" namespace="/msg" theme="simple"
	method="post">
	<table align="center" cellpadding=1 cellspacing=1 border=0
		class="ListTable" >
		<tr align="center">
			<td height="45" align="center" colspan="2" nowrap="nowrap"
				class="EditHead" style="width: 10%">
				<div align="center"><b>查看消息</b></div>
			</td>
		</tr>
		<tr class="">
			<td class="EditHead" nowrap="nowrap" style="width: 10%"
				height="45"><b>标&nbsp;&nbsp;&nbsp;题:
				</b>
			</td>
			<td class="editTd" nowrap="nowrap" 
				height="45">${innerMsg.subject}
			</td>
		</tr>
		<tr class="">
			<td class="EditHead" nowrap="nowrap" style="width: 10%"
				height="45"><b>接收人:</b></td>
			<td class="editTd" nowrap="nowrap" 
				height="45">${innerMsg.toUsersName}</td>
		</tr>
		<tr class="">
			<td class="EditHead" nowrap="nowrap" style="width: 10%"
				height="45"><b>外部邮件:</b></td>
			<td class="editTd" nowrap="nowrap" 
				height="45">${innerMsg.toAddresses}</td>
		</tr>
		<tr class="">
			<td valign="middle" nowrap="nowrap" class="EditHead"
				style="width: 10%; height: 200px"><b>内&nbsp;&nbsp;&nbsp;容:
			</b></td>
			<td class="editTd">
			${innerMsg.bodyText}
			</td>
		</tr>
		<tr>
			<td class="EditHead"><b>附 件:</b></td>
			<td class="editTd" align="center" valign="top">
			${attachments}</td>
		</tr>
	</table>

</s:form>
	<!-- 引入公共文件 -->
	<div id="approve" title="查看底稿" style="overflow:hidden;padding:0px">
		<iframe id="approveSrc" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
  <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
