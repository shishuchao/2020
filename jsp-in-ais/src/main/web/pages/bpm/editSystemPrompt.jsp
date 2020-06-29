<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<title>发送系统通知11</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/csswin/subModal.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/scripts/calendar.js"></SCRIPT>
<SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/scripts/ais_functions.js"></SCRIPT>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/dwr/engine.js'></script>

<!-- 长度验证 -->
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<!-- 上传附件 -->
<script type="text/javascript" src="${contextPath}/scripts/swfload/uploadFile.js"></script>

<script type="text/javascript">
	//附件上传
	function Upload() {
		var contextPath = '${contextPath}';
		var table_name = 'flow_systemPrompt';
		var table_guid = 'guid';
		var guid = '<s:property value="sp.guid"/>';
		var deletePermission = 'true';
		var isEdit = 'true';
		var idName = 'accelerys';
		var title = '系统通知附件信息'
		var width = 700;
		var height = 450;
		uploadFile(contextPath, table_name, table_guid, guid, deletePermission, isEdit, idName, title, width, height);
	}
	//删除附件
	function deleteFile(fileId, guid, isDelete, isEdit, appType, title) {
		var boolFlag = window.confirm("确认删除吗?");
		if (boolFlag == true) {
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/commons/file',
				action : 'delFile',
				executeResult : 'false'
			}, {
				'fileId' : fileId,
				'deletePermission' : isDelete,
				'isEdit' : isEdit,
				'guid' : guid,
				'appType' : appType,
				'title' : title
			}, xxx);
			function xxx(data) {
				document.getElementById(guid).parentElement.innerHTML = data['accessoryList'];
			}
		}
	}
	//回退
	function backsSys() {
		var url = "${contextPath}/bpm/systemprompt/viewTenDays.action";
		window.location = url;
	}

	function sub() {
		var description = document.getElementsByName("sp.description")[0].value;
		if (document.getElementsByName("sp.description")[0].value == "") {
			window.alert("通知内容不能为空!");
			document.getElementsByName("sp.description")[0].focus();
			return false;
		}

		if (document.getElementsByName("sp.userName")[0].value == "") {
			window.alert("通知接收人不能为空!");
			return false;
		}
		var ifClose = "${ifClose}";
		if (ifClose == "") {
			ifClose = "no";
		}
		document.msqForm.action = "${pageContext.request.contextPath}/bpm/systemprompt/sendSystemPrompt.action?ifClose=" + ifClose;
		msqForm.submit();
	}
</script>
</head>

<body>
	<s:form name="msqForm" action="sendSystemPrompt" id="msqForm" namespace="/bpm/systemprompt" method="post">
		<s:hidden name="back_url"></s:hidden>


		<table width="100%">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead"><s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/bpm/systemprompt/viewTenDays.action')" /></td>
			</tr>
		</table>


		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr>
				<td class="listtabletr1"><font color="red">*</font>通知内容</td>
				<td class="listtabletr2"><s:textarea name="sp.description" cssStyle="width:100%;height:20;overflow-y:visible" /> <input type="hidden" id="sp.description.maxlength" value="1000"></td>
			</tr>

			<tr>
				<td class="listtabletr1"><font color="red">*</font>选择接受人</td>
				<td class="listtabletr2"><s:buttonText2 id="userName" hiddenId="userId" name="sp.userName" cssStyle="width:96%" hiddenName="sp.userId" doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/searchsystem/userindex.jsp&paraname=sp.userName&paraid=sp.userId&p_issel=1&p_item=1&orgtype=1',600,500,'人员选择')" doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" display="true" doubleDisabled="false" /></td>
			</tr>

			<tr>
				<td class="listtabletr1">发送人</td>
				<td class="listtabletr2"><s:textfield name="sp.sendUserName" readonly="true" /> <s:hidden name="sp.sendUserId" /></td>
			</tr>
		</table>

		<br>
		<div id="accelerys" align="left" style="margin-left: 10px">
			<s:property escape="false" value="accessoryList" />
		</div>
		<div align="right">
			<s:button onclick="Upload()" value="上传附件"></s:button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<div align="center">
			&nbsp;
			<s:button value="发 送" onclick="return sub();"></s:button>

			<s:button value="返 回" onclick="backsSys();"></s:button>
			&nbsp;
		</div>
		<!-- 隐藏字段 -->
		<s:hidden name="sp.guid"></s:hidden>
	</s:form>
</body>
</html>
