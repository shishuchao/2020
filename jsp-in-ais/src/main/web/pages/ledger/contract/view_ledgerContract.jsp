
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<s:text id="title" name="'合同台账查看'"></s:text>
<html>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<head>
        <meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>
 <table>
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead">&nbsp;<s:property
			value="#title" /></td>
	</tr>
</table>
	<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11">合同编号:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.c_code"  />
			</td>
			<td class="ListTableTr11">合同名称:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.c_name"  />
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11">合同金额:</td>
			<!--标题栏-->
			<td class="ListTableTr22" colspan="3"><s:property
				value="ledgerContract.c_money" doubles="true" />(万元)
		</tr>
		<tr>
			<td class="ListTableTr11">合同内容:</td>
			<!--标题栏-->
			<td class="ListTableTr22" colspan="3"><s:textarea
				name="ledgerContract.c_context"  cols="3" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">对方单位:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.other_company"  /></td>
			<td class="ListTableTr11">联系人:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.linkman"  /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">评审意见:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.assess_idea"  /></td>
			<td class="ListTableTr11">提出规范要求:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.criterion_ask"  /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">评审条数:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.assess_num" />
			</td>
			<td class="ListTableTr11">提出规范要求条数:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.criterion_num" />
			</td>
		</tr>

		<tr>
			<td class="ListTableTr11">附件</td>
			<td class="ListTableTr22" colspan="3">
			<div id="fjList" align="center"><s:property escape="false"
				value="accessoryList" />
			</div>
			</td>

		</tr>

		<tr>
			<td class="ListTableTr11">评审部门:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.assess_dept"  /></td>
			<td class="ListTableTr11">评审人:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:property
				value="ledgerContract.assess_person"  /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">评审时间:</td>
			<td class="ListTableTr22" colspan="3"><s:property
				value="ledgerContract.assess_date"/></td>
		</tr>

	</table> 
<s:button  value="关闭" onclick="javascript:window.close();"/> 
</center>
</body>
</html>
