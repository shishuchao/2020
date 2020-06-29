<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'台账分析子表查看'"></s:text>
<html>
	<script language="javascript">
		function backList() {
			//返回上级list页面
			var url = "${contextPath}/ledger/ledgerAnalyseSon/list.action";
			myform.action = url;
			myform.submit();
	
		}
	</script>
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/ais.css">
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	
	<head>
		<title><s:property value="#title" /></title>
		<s:head />
	</head>

	<body>
		<center>
			<s:form id="myform" action="view" namespace="/ledger/ledgerAnalyseSon">
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">&nbsp; <s:property value="#title" /></td>
					</tr>
				</table>
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="titletable1">
						<td>po对应:</td>
						<td><s:property value="ledgerAnalyseSon.code" /></td>
					</tr>
					<tr class="titletable1">
						<td>po对应的名称:</td>
						<td><s:property value="ledgerAnalyseSon.name" /></td>
					</tr>
					<tr class="titletable1">
						<td>类型:</td>
						<td>
							<s:if test="${ledgerAnalyseSon.type==1}">
								分类字段
							</s:if> 
							<s:else>
								统计字段
							</s:else>
						</td>
					</tr>
				</table>
				<s:hidden name="ledgerAnalyseSon.id" />
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>
		</center>
	</body>
</html>
