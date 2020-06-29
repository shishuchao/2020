<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<s:text id="title" name="计划管理-->个人计划'"></s:text>
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
							<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/plan/personalprogramme/list.action')"/>
						</div>
						<div style="display: inline;width:20%;text-align: right;">
							<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
						</div>
					</td>
				</tr>
			</table>
			
			<s:form namespace="/plan/personalprogramme" action="list" method="post">
				<table id="searchTable" width="100%" border=0 cellPadding=0 cellSpacing=1
					class=ListTable align="center"  style="display: none;">
					<tr class="ListTableTr1" width="20%">
						<td class="ListTableTr11">
							标题
						</td>
						<td class="ListTableTr2">
							<s:textfield name="personalProgramme.title"></s:textfield>
						</td>
						<td class="ListTableTr11">
							参与人
						</td>
						<td class="ListTableTr2">
							<s:textfield name="personalProgramme.parter"></s:textfield>
						</td>
					</tr>
					<tr class="ListTableTr1" width="20%">
						<td class="ListTableTr11">
							开始时间
						</td>
						<td class="ListTableTr2">
							<s:textfield name="personalProgramme.startTime" readonly="true"
								title="单击选择日期" onclick="calendar()"></s:textfield>
						</td>
						<td class="ListTableTr11">
							结束时间
						</td>
						<td class="ListTableTr2">
							<s:textfield name="personalProgramme.endTime" readonly="true"
								title="单击选择日期" onclick="calendar()"></s:textfield>
						</td>
					</tr>
					<tr class="ListTableTr1" width="20%">
						<td class="listtabletr11" width="19%" colspan="4" align="right">
							<div align="right">
								<input type="button" value="重 置"
									onClick="window.location.href='<%=request.getContextPath()%>/plan/personalprogramme/list.action'">

								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" onclick="search()" value="查 询">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						</td>
					</tr>

				</table>
			</s:form>
			<display:table name="list" id="row"
				requestURI="${contextPath}/plan/personalprogramme/list.action"
				class="its" pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external" defaultsort="2" 
				defaultorder="descending">
				<display:column property="title" title="标题" headerClass="center"
					sortable="true" sortName="title" class="center"></display:column>

				<display:column property="startTime" title="开始时间"
					headerClass="center" sortable="true" sortName="startTime" class="center"></display:column>

				<display:column property="endTime" title="结束时间" headerClass="center" sortName="endTime"
					 sortable="true" class="center"></display:column>

				<display:column property="parter" title="参与人" headerClass="center" sortName="parter"
					 sortable="true" class="center"></display:column>

				<display:column title="是否提醒" sortName="isRemind"
					headerClass="center" style="WHITE-SPACE: nowrap" sortable="true" class="center">
					<s:if test="${'Y'==row.isRemind}">
						是
					</s:if>
					<s:elseif test="${'N'==row.isRemind}">
						否
					</s:elseif>
					<s:else>
					
					</s:else>	
				</display:column>
				<display:column title="操作" headerClass="center" class="center">
					<a href="${contextPath}/plan/personalprogramme/edit.action?id=${row.id}">修改</a>&nbsp;&nbsp;
					<a href="javascript:;" onclick="del('${row.id }')">删除</a>&nbsp;&nbsp;
					<a href="${contextPath}/plan/personalprogramme/view.action?id=${row.id}"
						target="_blank">查看</a>&nbsp;&nbsp;
				</display:column>
			</display:table>
			
			<div id="buttonDiv" align="right" style="width: 97%">
				<input type="button" name="add" value="增 加"
				onclick="javascript:window.location='<s:url action="edit"><s:param name="isnew" value="true"/></s:url>'">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			
		</center>
		
		<script type="text/javascript">
			function del(id){
				var flag = window.confirm('确认提交吗?');
				if(flag){
					var url = "${contextPath}/plan/personalprogramme/delete.action?id="+id;
					window.location = url;
				}
			}
					
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
