<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	   	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:text id="title" name="'统计分析模型列表'"></s:text>
		<title><s:property value="#title" /></title>
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/ais.css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
			function deleteDel(id){
				if(window.confirm("确定执行删除操作吗?")){
		        	 window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseParent/deleteAnalyseTemplate.action?poName=${poName}&fid=${fid}&id="+id;
		        }else{
		        	return false;
		        }
		    }
	
		    function addAnalyse(){
		    	    window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseParent/editAnalyseTemplate.action?id=0&poName=${poName}&fid=${fid}";
			}
	
			function backList(){
				window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseParent/list.action";
				
			}
		</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						统计分析模型列表
					</td>
				</tr>
			</table>
			<display:table name="list" id="row" class="its" pagesize="15"
				requestURI="${contextPath}/ledger/ledgerAnalyseParent/analyseList.action">
				<display:column property="name" title="模型名称" class="center" headerClass="center"></display:column>
				<display:column property="leftcodes" title="分类字段" sortable="true" class="center" headerClass="center"></display:column>
				<display:column property="rightcodes" title="统计字段" sortable="true" class="center" headerClass="center"></display:column>
				<display:column title="操作" class="center" headerClass="center">
					<a href="<s:url action="editAnalyseTemplate" namespace="/ledger/ledgerAnalyseParent" includeParams="none"></s:url>?id=${row.id}&poName=${poName}&fid=${fid}">修改</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="return deleteDel('${row.id}');">删除</a>&nbsp;&nbsp;
				</display:column>
			</display:table>
			<br>
			<br>
			<input type="button" name="add" value="增加" onclick="return addAnalyse();">&nbsp;&nbsp;<input type="button" name="backList" value="返回" onclick="return backList();">
		</center>
	</body>
</html>
