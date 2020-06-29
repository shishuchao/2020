<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script language="javascript">
		function _edit(){
			var cbxs = document.getElementsByName("ids");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
				}
			}
			if(cbx_count>1){
				alert("不能同时修改多个账户信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要修改的账户!");
				return false;
			}
		
			document.forms[1].action = "editBankAccount.action";
			document.forms[1].submit();
		}
		function delVal(){
			var cbxs = document.getElementsByName("ids");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
				}
			}
			if(cbx_no==-1){
				alert("没有选择要删除的账户!");
				return false;
			}
			if( window.confirm('确认删除吗？')){
				document.forms[1].action="deleteBankAccount.action";
				document.forms[1].submit();
			}
		}
		function cleanForm(){
			document.getElementsByName("bankAccount.openBank")[0].value = "";
			document.getElementsByName("bankAccount.openName")[0].value = "";
			document.getElementsByName("bankAccount.accoTypeCode")[0].selectedIndex = -1;
			document.getElementsByName("bankAccount.accoStateCode")[0].selectedIndex = -1;
			
			document.forms[0].action="${contextPath}/mng/audobj/object/searchBankAccount.action";
			document.forms[0].submit();
		}
		</script>
</head>
<body>
<center>
		<s:form namespace="/mng/audobj/object">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="ListTableTr11" nowrap="nowrap">
						开户银行
					</td>
					<TD class="ListTableTr22">
						<s:textfield name="bankAccount.openBank"/>
					</TD>
					<TD align="center" class="ListTableTr11" nowrap="nowrap">
						账户性质
					</TD>
					<TD class="ListTableTr22">
						<s:select name="bankAccount.accoTypeCode" list="basicUtil.accoTypeList4Search" emptyOption="true" listKey="code" listValue="name" />
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD align="center" class="ListTableTr11" nowrap="nowrap">
						开户名称
					</TD>
					<TD class="ListTableTr22">
						<s:textfield name="bankAccount.openName"></s:textfield>
					</TD>
					<TD class="ListTableTr11" nowrap="nowrap">
						账户状态
					</TD>
					<TD class="ListTableTr22">
						<s:select name="bankAccount.accoStateCode" list="basicUtil.accoStateList" emptyOption="true" listKey="code" listValue="name" />
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="searchBankAccount" value="查询"/>
							&nbsp;&nbsp;
							<s:button  onclick="cleanForm()"  value="重置"></s:button>
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="pid"></s:hidden>
			<s:hidden name="status"></s:hidden>
		</s:form>
<s:form namespace="/mng/audobj/object">
			<s:hidden name="listStatus"/>
<display:table name="bankAccountList" id="row" requestURI="${contextPath}/mng/audobj/object/searchBankAccount.action" class="its"
	pagesize="${baseHelper.pageSize}" partialList="true" 
	size="${baseHelper.totalRows}" sort="external"
	defaultsort="2" defaultorder="descending">
	
	<s:if test="${status == 'edit'}">
	<display:column title="选择" headerClass="center">
		<input type="checkbox" name="ids" value="${row.id}">
	</display:column>
	</s:if>
	<display:column property="accoState" title="账户状态" sortable="true" headerClass="center" sortName="accoState"></display:column>
	<display:column title="开户银行" sortable="true" headerClass="center" class="center" sortName="openBank">
		<a href="${contextPath}/mng/audobj/object/viewBankAccount.action?bankAccountId=${row.id}&pid=${pid}&status=${status}">${row.openBank }</a>
	</display:column>
	<display:column property="account" title="账号" sortable="true" headerClass="center" class="center" sortName="account"></display:column>
	<display:column property="openName" title="开户名称" sortable="true" headerClass="center" sortName="openName"></display:column>
	<display:column property="accoType" title="账户性质" sortable="true" headerClass="center" class="center" sortName="accoType"></display:column>
	<display:column property="openDate" title="开户日期" sortable="true" headerClass="center" class="center" sortName="openDate"></display:column>
	<display:column property="outDate" title="注销日期" sortable="true" headerClass="center" sortName="outDate"></display:column>
</display:table>
</center><br>
	<s:if test="${status == 'edit'}">
	<div align="right">
		<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/audobj/object/addBankAccount.action?pid=${pid}&status=${status}'">
		&nbsp;&nbsp;
		<s:button onclick="delVal()" value="删除"/>
		&nbsp;&nbsp;
		<s:button onclick="_edit()" value="修改"></s:button>
		&nbsp;&nbsp;
		<input type="button" onclick="selall_inform('ids', true)" value="全选">
		&nbsp;&nbsp;
		<input type="button" onclick="selall_inform('ids', false)" value="全不选">
		&nbsp;&nbsp;
	</div>
	</s:if>
	<s:hidden name="pid"></s:hidden>
	<s:hidden name="status"></s:hidden>
</s:form>
</body>
</html>
