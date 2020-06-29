<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
<head>
<title>列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<script type='text/javascript'
	src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<script type="text/javascript">
    function deleteForm(id){
        if(window.confirm("确定执行删除操作吗?")){
        	 window.location.href="${pageContext.request.contextPath}/ledger/contract/ledgerContract/delete.action?id="+id;
        }else{
        	return false;
        }
        
    }

    function resetButton(){
    	document.getElementsByName("ledgerContract.c_code")[0].value="";
    	document.getElementsByName("ledgerContract.c_name")[0].value="";
    	document.getElementsByName("ledgerContract.c_context")[0].value="";
    	document.getElementsByName("ledgerContract.other_company")[0].value="";
    	document.getElementsByName("ledgerContract.c_money")[0].value="";
    	document.getElementsByName("option")[0].value="";
    }
</script>
</head>
<body>
<center>
<table>
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead"><s:property
			escape="false"
			value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/contract/ledgerContract/list.action')" />
		</td>
	</tr>
</table>
<s:form id="queryform" action="list"
	namespace="/ledger/contract/ledgerContract" method="post">
	<table id="table" cellpadding=0 cellspacing=1 border=0
		bgcolor="#409cce" class="ListTable">
		<tr class="listtablehead">
			<td align="left" class="listtabletr11">合同编号：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerContract.c_code" cssStyle="width:100%" /></td>
			<td align="left" class="listtabletr11">合同名称：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerContract.c_name" cssStyle="width:100%" /></td>
		</tr>
		<tr class="listtablehead">
			<td align="left" class="listtabletr11">合同内容：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerContract.c_context" cssStyle="width:100%" /></td>
			<td align="left" class="listtabletr11">对方单位：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerContract.other_company" cssStyle="width:100%" /></td>
		</tr>
		<tr class="listtablehead">
			<td align="left" class="listtabletr11">合同金额：</td>
			<td align="left" class="listtabletr22">
			<s:select list="#{'=':'=','>=':'>=','<=':'<='}" listKey="key" listValue="value" name="option" emptyOption="true"></s:select>
			<s:textfield
				name="ledgerContract.c_money" cssStyle="width:50%" />
			</td>
			<td align="left" class="listtabletr11"></td>
			<td align="left" class="listtabletr22"></td>
		</tr>
		<tr class="listtablehead">
			<td align="right" class="listtabletr1" colspan="4">
			<DIV align="right"><s:submit value="查询"
				cssStyle="width:100" /> 
				<s:button value="重置" cssStyle="width:100"
				onclick="resetButton();"></s:button></DIV>
			</td>
		</tr>
	</table>
</s:form> <display:table name="list" id="row"
	requestURI="${contextPath}/ledger/contract/ledgerContract/list.action"
	class="its" pagesize="15">

	<display:column property="c_code" title="合同编号" sortable="true"
		headerClass="center" style="width:5%;word-break : break-all;"></display:column>

	<display:column property="c_name" title="合同名称" sortable="true"
		headerClass="center" style="width:20%;word-break : break-all;"></display:column>

	<display:column property="c_context" title="合同内容" sortable="true"
		headerClass="center" style="width:25%;word-break : break-all;"></display:column>

	<display:column title="合同金额（万元）" headerClass="center"
		style="width:5%;word-break : break-all;">
		<fmt:formatNumber value="${row.c_money}" pattern="###,###.##"
			type="currency" minFractionDigits="2"></fmt:formatNumber>
	</display:column>

	<display:column property="other_company" title="对方单位" sortable="true"
		headerClass="center" style="width:10%;word-break : break-all;"></display:column>

	<display:column title="操作" headerClass="center" class="center"
		style="width:10%;word-break : break-all;">
		<a
			href="<s:url action="edit"><s:param name="id" value="'${row.id}'"/></s:url>">修改</a>&nbsp;&nbsp;
		<a href="javascript:void(0);" onclick="return deleteForm('${row.id}');">删除</a>&nbsp;&nbsp;
		<a
			href="<s:url action="view"><s:param name="id" value="'${row.id}'"/></s:url>"
			target="_blank">查看</a>&nbsp;&nbsp;
	</display:column>
</display:table> <br>
<br>
<input type="button" name="add" value="添加"
	onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/></s:url>'">
</center>
</body>
</html>
