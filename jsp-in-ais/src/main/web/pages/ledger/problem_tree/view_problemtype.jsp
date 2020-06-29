<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>问题类别</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<style type="text/css">
td {
	font-size: 12px;
}

.ListTableTra {
	BACKGROUND-COLOR: #DDEEFF;
	width: 20%;
	height: 14;
	vertical-align: middle;
	text-align: center;
	font-size: 12px
}

.ListTableTrb {
	BACKGROUND-COLOR: #ffffff;
	width: 28%;
	height: 14;
	padding-left: 5px;
}

.ListTableTrc {
	height: 14;
	padding-left: 5px;
}
</STYLE>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/project/javascript/checkEmpty.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/validate.js"></script>
		<script language="javascript">
		function flushLeft(){
			parent.tree.location.reload();
		}			
	</script>
</head>
<body onload="flushLeft();">
	<table>
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				问题类别
			</td>
		</tr>
	</table>
	
	<s:form name="problemtype"
					action="/ledger/problemledger/save_problemtype.action"
					namespace="/ledger/problemledger">
		<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="tab1">
			<tr>
				<td class="ListTableTr11">
					<FONT color=red>*</FONT>&nbsp;问题类别编号
				</td>
				<td class="ListTableTr22">	
					${ledgerTemplateNew.code}		
				</td>
				<td class="ListTableTr11">
					<FONT color=red>*</FONT>&nbsp;问题类别
				</td>
				<td class="ListTableTr22">	
					${ledgerTemplateNew.name}		
				</td>
			</tr>
			<s:hidden name="ledgerTemplateNew.id"></s:hidden>
			<s:hidden name="ledgerTemplateNew.fid"></s:hidden>
			<s:hidden name="ledgerTemplateNew.isSort"></s:hidden>
		</table>
		<input name="add_problemtype" type="button" 
			onClick="window.location.href='<%=request.getContextPath()%>/ledger/problemledger/edit.action?id=${ledgerTemplateNew.id }'"
			value="修改">
		
	</s:form>
	
</body>
</html>