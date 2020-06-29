<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>借阅日志
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
		 	/*
		 	 * 查看借阅详细信息
		 	 */
			function viewLog(formId){  
				var url = "${contextPath}/archives/borrow/viewLog.action?crudId="+formId;
				window.location = url;
			}
		</script>
	</head>
	<body>
		<center>


			<s:form action="borrowLog" namespace="/archives/borrow"
				name="form">
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
							档案管理==>项目档案==>借阅日志

						</td>
					</tr>

				</table>
			</s:form>
		

			<display:table name="allArchivesList" id="row"
				requestURI="/archives/borrow/singleArchivesBorrowLog.action"
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				defaultsort="2" defaultorder="descending"
				class="its" cellpadding="1">
				<display:column title="序号" headerClass="center" class="center"
					value="${row_rowNum}"></display:column>
				<display:column property="archive_name" title="档案名称"
					 style="WHITE-SPACE: nowrap;width:120" headerClass="center" class="center" sortName="archive_name" sortable="true"></display:column>
				<display:column property="start_borrow_man_name" title="档案借阅发起人"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="start_borrow_man_name" sortable="true"></display:column>
				<display:column property="start_borrow_unit_name" title="档案借阅发起人单位"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="start_borrow_unit_name" sortable="true"></display:column>
				<display:column property="in_borrow_man_name" title="内部借阅人"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="in_borrow_man_name" sortable="true"></display:column>
				<display:column property="in_borrow_unit_name" title="内部借阅人单位"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="in_borrow_unit_name" sortable="true"></display:column>
				<display:column property="start_borrow_time" title="档案借阅起始时间"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="start_borrow_time" sortable="true"></display:column>
				<display:column property="end_borrow_time" title="档案借阅终止时间"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="end_borrow_time" sortable="true"></display:column>
				<display:column property="borrow_status" title="档案借阅状态"
					 style="WHITE-SPACE: nowrap" headerClass="center" class="center" sortName="borrow_status" sortable="true"></display:column>
				<display:column title="操作" headerClass="center" class="center">
					<s:a href="javascript:;" onclick="viewLog('${row.formId }');">详细</s:a>
				</display:column>
				<display:setProperty name="paging.banner.placement" value="bottom" />
			</display:table>

		</center>
		<div align="right">
		<s:button  value="关 闭"  title="关闭窗口"  onclick="window.close();"/>
</div>
	</body>
</html>
