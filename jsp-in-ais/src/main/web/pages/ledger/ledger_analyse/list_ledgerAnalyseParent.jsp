<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	   <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:text id="title" name="'台账分析父表'"></s:text>
		<title><s:property value="#title" />列表</title>
		<link rel="stylesheet" type="text/css" href="${contextPath}/styles/main/ais.css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
			function deleteDel(id){
				if(window.confirm("确定执行删除操作吗?")){
		        	 window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseParent/delete.action?id="+id;
		        }else{
		        	return false;
		        }
		    }
		    function sonList(id){
		    	 window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseSon/enter.action?id="+id;
		    }
	
		    function analyseList(id,code){
		    	 window.location.href="${pageContext.request.contextPath}/ledger/ledgerAnalyseParent/analyseList.action?fid="+id+"&poName="+code;
		    }
		</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property
							escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/ledgerAnalyseParent/list.action')" />
					</td>
				</tr>
			</table>
			<display:table name="list" id="row" class="its" pagesize="15"
				requestURI="${contextPath}/ledger/ledgerAnalyseParent/list.action">			
				<display:column property="code" title="表的PO名称" sortable="true"></display:column>
				<display:column property="name" title="名字" sortable="true"></display:column>
				<display:column title="操作" class="center" headerClass="center">
					<!-- <a-->
					<!--	href="<s:url action="edit"><s:param name="id" value="'${row.id}'"/></s:url>">修改</a>&nbsp;&nbsp;-->
					<!-- <a-->
					<!--	href="javascript:void(0);" onclick="return deleteDel('${row.id}');">删除</a>&nbsp;&nbsp;-->
					<a href="javascript:void(0);" onclick="winopen('${contextPath}/ledger/ledgerAnalyseParent/view.action?id=${row.id}',600,800)">查看</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="return sonList('${row.id}');">进入子表列表</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="return analyseList('${row.id}','${row.code}');">统计分析模型设置</a>&nbsp;&nbsp;
				</display:column>
			</display:table>
			<br>
			<br>
			<!-- <input type="button" name="add" value="增加"-->
			<!-- onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/></s:url>'">-->
		</center>
	</body>
</html>
