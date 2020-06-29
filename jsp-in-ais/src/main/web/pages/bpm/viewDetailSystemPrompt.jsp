<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>查看系统通知</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${pageContext.request.contextPath}/styles/main/ais.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/calendar.js"></SCRIPT>
		<SCRIPT type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/ais_functions.js"></SCRIPT>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
   //回退
	function backsSys(){
	var url = "${contextPath}/bpm/systemprompt/viewTenDays.action";
    window.location = url;
	}
	
	
	function sub(){
	    var description =  document.getElementsByName("sp.description")[0].value;
 	if(document.getElementsByName("sp.description")[0].value==""){
		window.alert("通知内容不能为空!");
		document.getElementsByName("sp.description")[0].focus();
		return false;
	}


 	if(document.getElementsByName("sp.userName")[0].value==""){
		window.alert("通知接收人不能为空!");
		return false;
	}
	
	    document.msqForm.action="${pageContext.request.contextPath}/bpm/systemprompt/sendSystemPrompt.action";
		msqForm.submit();
	}
		</script>
	</head>

	<body>
		<s:form name="msqForm" action="sendSystemPrompt"
			namespace="/bpm/systemprompt" method="post">
			<s:hidden name="back_url"></s:hidden>
			
			
						<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						系统通知详细信息
					</td>
				</tr>
			</table>
			
			
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
					<tr>
					<td class="listtabletr1">
						<font color="red">*</font>通知内容
					</td>
					<td class="listtabletr2" colspan="3">
						<s:textarea name="sp.description" readonly="true"  cssStyle="width:100%;height:20;overflow-y:visible"></s:textarea>
					</td>
				</tr>
				
				<tr>
					<td class="listtabletr1">
						<font color="red">*</font>选择接受人：
					</td>
					<td class="listtabletr2">
					<s:property  value="sp.userName" />
					</td>

					<td class="listtabletr1">
						发送人：
					</td>
					<td class="listtabletr2">
					<s:property value="sp.sendUserName"/>
					</td>
				</tr>
	</table>

			<div id="accelerys" align="left" style="margin-left: 10px">
				<s:property escape="false" value="accessoryList" />
			</div>
		<br><div  align="center">
						&nbsp;
						
						<s:button value="关 闭" onclick="javascript:window.close();"></s:button>
						&nbsp;
</div>
						
		</s:form>
	</body>
</html>
