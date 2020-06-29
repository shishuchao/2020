<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<base target="_self">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title></title>
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		
		
		<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>





	</head>
	<body >
		<center>
			<s:form action="send" namespace="/commons/mail"
				name="form1">
				<!-- 引入项目的信息 -->
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="6" align="center" class="edithead">
							&nbsp;发送报告阶段文档
						</td>
					</tr>
						<tr class="listtablehead">
						<td align="left" class="ListTableTr11" nowrap="nowrap">
							<font color="red">*</font>邮件地址:
						</td>
						<td class="listtabletr22"   align="right" colspan="5">
					  		 <s:textfield  name="mailuri" cssStyle="width:90%" />
					  		 <s:hidden name="project_name" value="<%=request.getParameter("projname")%>"/>
						</td>
					</tr>
				</table>

				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="6" align="left" class="edithead">
							&nbsp;审计报告
						</td>
					</tr>

					<tr class="listtablehead">
						<td align="center" class="listtabletr1" nowrap="nowrap">
							选项
						</td>
						<td align="center" class="listtabletr1" nowrap="nowrap">
							附件名称
						</td>
					</tr>
					<s:iterator value="reportList" status="index">
						<tr class="listtablehead">
							<td align="center" class="listtabletr2">
								<input name="crudids" type="checkbox" value="<s:property value="fileId" />"/>
							</td>
							<td align="center" class="listtabletr2">
								<s:property value="fileName" />
							</td>
						</tr>
					</s:iterator>
				</table>
				
				<p>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="6" align="left" class="edithead">
							&nbsp;征求意见稿
						</td>
					</tr>

					<tr class="listtablehead">
						<td align="center" class="listtabletr1" nowrap="nowrap">
							选项
						</td>
						<td align="center" class="listtabletr1" nowrap="nowrap">
							附件名称
						</td>
					</tr>
					<s:iterator value="ideaList" status="index">
						<tr class="listtablehead">
							<td align="center" class="listtabletr2">
								<input name="crudids" type="checkbox" value="<s:property value="fileId" />"/>
							</td>
							<td align="center" class="listtabletr2">
								<s:property value="fileName" />
							</td>
						</tr>
					</s:iterator>
				</table>
				
				<p>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="6" align="left" class="edithead">
							&nbsp;报告初稿
						</td>
					</tr>

					<tr class="listtablehead">
						<td align="center" class="listtabletr1" nowrap="nowrap">
							选项
						</td>
						<td align="center" class="listtabletr1" nowrap="nowrap">
							附件名称
						</td>
					</tr>
					<s:iterator value="signList" status="index">
						<tr class="listtablehead">
							<td align="center" class="listtabletr2">
								<input name="crudids" type="checkbox" value="<s:property value="fileId" />"/>
							</td>
							<td align="center" class="listtabletr2">
								<s:property value="fileName" />
							</td>
						</tr>
					</s:iterator>
				</table>
				<p>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="6" align="left" class="edithead">
							&nbsp;报告终稿
						</td>
					</tr>

					<tr class="listtablehead">
						<td align="center" class="listtabletr1" nowrap="nowrap">
							选项
						</td>
						<td align="center" class="listtabletr1" nowrap="nowrap">
							附件名称
						</td>
					</tr>
					<s:iterator value="maincontentList" status="index">
						<tr class="listtablehead">
							<td align="center" class="listtabletr2">
								<input name="crudids" type="checkbox" value="<s:property value="fileId" />"/>
							</td>
							<td align="center" class="listtabletr2">
								<s:property value="fileName" />
							</td>
						</tr>
					</s:iterator>
				</table>
<div align="center">
                <s:submit value="发送" />
</div>
			</s:form>

		</center>
	</body>
</html>
