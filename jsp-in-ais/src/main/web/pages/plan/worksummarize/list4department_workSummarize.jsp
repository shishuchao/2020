<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<s:text id="title" name="'计划管理-->工作总结'"></s:text>
		<title><s:property value="#title" />列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
			function search(){
				document.forms[0].submit();
			}
		</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
						<div style="display: inline;width:80%;">
							<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/plan/worksummarize/list4department.action')"/>
						</div>
						<div style="display: inline;width:20%;text-align: right;">
							<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
						</div>
					</td>
				</tr>
			</table>
			
			<s:form namespace="/plan/worksummarize" action="list4department"
				method="post">
				<table id="searchTable" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center"  style="display: none;">
					<tr class="ListTableTr1" width="20%" >
						<td class="ListTableTr11">
							标题
						</td>
						<td class="ListTableTr2">
							<s:textfield name="workSummarize.title"></s:textfield>
						</td>
						<td class="ListTableTr11">
							总结类型
						</td>
						<td class="ListTableTr2">
							<s:select name="workSummarize.summarizeTypeId" emptyOption="true"
								list="basicUtil.summaryTypeList" listKey="code" listValue="name" />
						</td>
						<td class="ListTableTr11">
							提交时间
						</td>
						<td class="ListTableTr2"> 
							<s:textfield name="workSummarize.submitTime" readonly="true"
								title="单击选择日期" 
								onclick="calendar()"></s:textfield>
						</td>
					</tr>

					<tr class="ListTableTr1" width="20%">
						<td class="listtabletr11" width="19%" colspan="6" align="right">
							<div align="right">
								<input type="button" value="重 置"
									onClick="window.location.href='<%=request.getContextPath()%>/plan/worksummarize/list4department.action'">
								
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" onclick="search()" value="查 询">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						</td>
					</tr>

				</table>
			</s:form>
				<display:table name="list" id="row"
					requestURI="${contextPath}/plan/worksummarize/list4department.action"
					class="its" pagesize="${baseHelper.pageSize}" partialList="true" 
					size="${baseHelper.totalRows}" sort="external" defaultsort="2" defaultorder="descending">
				
				<display:column property="title" headerClass="center"  class="center" title="标题" sortable="true" sortName="title"></display:column>

				<display:column property="summarizeType" headerClass="center"  class="center" title="总结类别"
					sortable="true" sortName="summarizeType"></display:column>

				<display:column property="submitTime" headerClass="center"  class="center" title="提交时间" sortable="true" sortName="submitTime"></display:column>
				
				<display:column property="username" headerClass="center"  class="center" title="提交人" sortable="true" sortName="username"></display:column>
				
				<display:column title="操作">
					<a href="${contextPath}/plan/worksummarize/view.action?id=${row.id}"
						target="_blank">查看</a>&nbsp;&nbsp;
				</display:column>
			</display:table>
		</center>
		<script type="text/javascript">
		
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('searchTable').style.display;
				if(isDisplay==''){
					document.getElementById('searchTable').style.display='none';
				}else{
					document.getElementById('searchTable').style.display='';
				}
			}
		
		</script>
		
	</body>
</html>
