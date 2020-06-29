<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<s:text id="title" name="'行政发文'"></s:text>
		<title><s:property value="#title" />列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
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
	</head>
	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" class="edithead"
						style="text-align: left; width: 100%;">
						<div style="display: inline; width: 80%;">
							<s:property escape="false"
								value="@ais.framework.util.NavigationUtil@getNavigation('/ais/executive/sendfile/list.action')" />
						</div>
						<div style="display: inline; width: 20%; text-align: right;">
							<a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>
						</div>
					</td>
				</tr>
			</table>

			<s:form namespace="/executive/sendfile" action="list" method="post">
				<table id="searchTable" width="100%" border=0 cellPadding=0
					cellSpacing=1 class=ListTable align="center" style="display: none;">
					<tr class="ListTableTr11" width="20%">
						<td width="20%">
							签发人
						</td>
						<td class="ListTableTr">
							<s:buttonText name="sendFile.signerName"
								hiddenName="sendFile.signerId" cssStyle="width:80%"
								doubleOnclick="showPopWin('/pages/system/search/frameselect4s.jsp?url=/pages/system/userindex.jsp&paraname=sendFile.signerName&paraid=sendFile.signerId',600,550)"
								doubleSrc="/resources/images/s_search.gif"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" />
						</td>
						<td width="20%">
							拟稿人
						</td>
						<td class="ListTableTr2">
							<s:buttonText name="sendFile.writerName"
								hiddenName="sendFile.writerId" cssStyle="width:60%"
								doubleOnclick="showPopWin('/pages/system/search/frameselect4s.jsp?url=/pages/system/userindex.jsp&paraname=sendFile.writerName&paraid=sendFile.writerId',600,550)"
								doubleSrc="/resources/images/s_search.gif"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" />
						</td>
					</tr>
					<tr class="ListTableTr11" width="20%">
						<td width="20%">
							拟稿人部门
						</td>
						<td class="ListTableTr2">
							<s:buttonText name="sendFile.writerDept"
								hiddenName="sendFile.WriterDeptId" cssStyle="width:80%"
								doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=sendFile.writerDept&paraid=sendFile.WriterDeptId',600,550)"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" />
						</td>
						<td width="20%">
							发文字号
						</td>
						<td class="ListTableTr2">
							<s:textfield name="sendFile.sendFileNO" cssStyle="width:60%"
								maxlength="25"></s:textfield>
						</td>
					</tr>
					<tr class="ListTableTr11" width="20%">
						<td width="20%">
							编号日期
						</td>
						<td class="ListTableTr2">
							<s:textfield name="sendFile.refeDate" readonly="true"
								title="单击选择日期" cssStyle="width:80%" onclick="calendar()"></s:textfield>
						</td>
						<td width="20%">
							签发日期
						</td>
						<td class="ListTableTr2">
							<s:textfield name="sendFile.signerDate" readonly="true"
								title="单击选择日期" cssStyle="width:60%" onclick="calendar()"></s:textfield>
						</td>
					</tr>
					<tr class="ListTableTr11" width="20%">
						<td width="20%">
							标题
						</td>
						<td class="ListTableTr2">
							<s:textfield name="sendFile.title" cssStyle="width:80%"
								maxlength="50"></s:textfield>
						</td>
						<td width="20%">
							印发单位
						</td>
						<td class="ListTableTr2">
							<s:textfield name="sendFile.publishUnit" cssStyle="width:60%"
								maxlength="25"></s:textfield>
						</td>
					</tr>

					<tr class="ListTableTr1" width="20%">
						<td class="listtabletr11" width="19%" colspan="6" align="right">
							<div align="right">
								<input type="button" value="重 置"
									onClick="window.location.href='/ais/executive/sendfile/list.action'">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<s:submit value="查 询" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
						</td>
					</tr>

				</table>
			</s:form>

			<display:table name="list" id="row"
				requestURI="${contextPath}/executive/sendfile/list.action"
				class="its" pagesize="15" cellpadding="1">
				<display:column property="signerName" title="签发人" sortable="true"></display:column>

				<display:column property="writerName" title="拟稿人" sortable="true"></display:column>

				<display:column property="writerDept" title="拟稿人部门" sortable="true"></display:column>

				<display:column property="sendFileNO" title="发文字号" sortable="true"></display:column>

				<display:column property="refeDate" title="编号日期" sortable="true"></display:column>

				<display:column property="signerDate" title="签发日期" sortable="true"></display:column>

				<display:column property="title" title="标题" sortable="true"></display:column>

				<display:column property="publishUnit" title="印发单位" sortable="true"></display:column>

				<display:column property="createTime" title="创建时间" sortable="true"></display:column>
				<display:column title="操作">
					<s:if test="${row.currentTaskId ==''||row.currentTaskId==null}">
						<a
							href="${contextPath}/executive/sendfile/edit.action?crudId=${row.formId}"
							onclick="return confirm('确认要启动项目吗?');">启动</a>&nbsp;&nbsp;
					</s:if>
					<s:elseif test="${row.currentTaskId=='10'}">
						<a
							href="${contextPath}/executive/sendfile/edit.action?crudId=${row.formId}">处理</a>&nbsp;&nbsp;
					</s:elseif>
					<a
						href="${contextPath}/executive/sendfile/view.action?crudId=${row.formId}"
						target="_blank">查看</a>&nbsp;&nbsp;
					<!-- <a href="${contextPath}/executive/sendfile/delete.action?crudId=${row.formId}">删除</a>&nbsp;&nbsp; -->
				</display:column>
			</display:table>
			<br>
			<br>
			<div align="right">
				<input type="button" name="add" value="添加"
					onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/></s:url>'">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</center>
	</body>
</html>
