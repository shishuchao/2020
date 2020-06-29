<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:text id="title" name="'台账分析子表'"></s:text>
		<title><s:property value="#title" />列表</title>
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/ais.css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
		    function deleteForm(id,fid){
		        if(window.confirm("确定执行删除操作吗?")){
		        	 window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseSon/delete.action?id="+id+"&fid="+fid;
		        }else{
		        	return false;
		        }
		        
		    }
		</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
				<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
			</table>
			<display:table name="list" id="row" requestURI="${contextPath}/ledger/ledgerAnalyseSon/enter.action" class="its" pagesize="15">		
				<display:column property="code" title="po对应" sortable="true"></display:column>			
				<display:column property="name" title="po对应的名称" sortable="true"></display:column>			
				<display:column  title="类型" sortable="true">
					<s:if test="${row.type==1}">
					分类字段
					</s:if>
					<s:else>
					统计字段
					</s:else>
				</display:column>	
				<display:column title="操作" headerClass="center" class="center">
					<!-- <a href="<s:url action="edit"><s:param name="id" value="'${row.id}'"/><s:param name="fid" value="'${row.fid}'"/></s:url>">修改</a>&nbsp;&nbsp;-->
					<!-- <a href="javascript:void(0);" onclick="return deleteForm('${row.id}','${row.fid}');">删除</a>&nbsp;&nbsp;-->
					<a href="javascript:void(0);" onclick="winopen('${contextPath}/ledger/ledgerAnalyseSon/view.action?id=${row.id}',400,800)">查看</a>
					&nbsp;&nbsp;
				</display:column>			
			</display:table>
			<br>
			<br>
			<!--<input type="button" name="add" value="增加" onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/><s:param name="fid" value="id"/></s:url>'">&nbsp;&nbsp;-->
			<input type="button" name="back" value="返回" onclick="javascript:window.location='<s:url action="list" namespace="/ledger/ledgerAnalyseParent"></s:url>'">
		</center>
	</body>
</html>
