<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<s:if test="${assistSuportLawslib.id=='0'}">
	<s:text id="title" name="'添加审计经验'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改审计经验'"></s:text>
</s:else>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:head theme="simple" />
		<title>审计经验</title>　<!-- <s:property value="#title" /> -->
	</head>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<body>
		<center>
			<h1>
				<s:property value="" /> <!-- #title -->
			</h1>
			<s:form action="save" namespace="/pages/assist/suport/lawsLib"
				theme="simple">
				<s:hidden name="nodeid" value="${nodeid}" />
				<s:hidden name="assistSuportLawslib.categoryFk"
					value="${assistSuportLawslib.categoryFk}" />
				<s:hidden name="assistSuportLawslib.id"
					value="${assistSuportLawslib.id}" />

		<s:tabbedPanel id='test' theme="ajax">
			<s:div id='one' label='基本信息' theme='ajax' cssStyle="height: 500px;">
				<table 
					class="ListTable">
					<tr>
						<td class="listtabletr11" nowrap="nowrap">
							名称
						</td>
						<td class="listtabletr2">
							${assistSuportLawslib.title}
						</td>
						<td class="listtabletr11" nowrap="nowrap">
							颁布日期
						</td>
						<td class="listtabletr2" nowrap="nowrap">
						<s:if test="!${empty(assistSuportLawslib.promulgationDate)}">
							${fn:substring(assistSuportLawslib.promulgationDate, 0, 10)}
						</s:if>
						</td>
					</tr>
					<tr>
						<td class="listtabletr11">
							颁布单位
						</td>
						<td class="listtabletr2">
							${assistSuportLawslib.promulgationDept}

						</td>
						<td class="listtabletr11">
							经验类别
						</td>
						<td class="listtabletr2">
							${assistSuportLawslib.category}

						</td>
					</tr>
					<tr>
						<td class="listtabletr11">
							创建单位
						</td>
						<td class="listtabletr2">
							${assistSuportLawslib.sundept}
						</td>
						<td class="listtabletr11">
						</td>
						<td class="listtabletr2">
						</td>
					</tr>
					<tr>
						<td class="listtabletr11" colspan="4" style="text-align: center;">
							正文
						</td>
					</tr>
					<tr>
						<td colspan="4" class="listtabletr2">${assistSuportLawslib.content}</td>
					</tr>
					</table>
				
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList" />
				</div>
				
				
				

				<s:hidden name="m_message" value="${m_message}" />
<%--				<s:submit value="保存"/>--%>
			<table style="width:97%;border:0" >
				<tr>
					<td>
						<span style="float:right;">
							<input type="button" name="back" value="返回 " class='button'
				onclick="javascript:window.location.href='../lawsLib/search.action?nodeid=${nodeid}&mCodeType=${mCodeType}&m_view=view'">
						</span>
					</td>
				</tr>
			</table>
			</s:div>
				<%-- 厦门项目 AO导入
				<s:div id='two' label='所需资料' theme="ajax" cssStyle="height: 500px;" href="${contextPath}/pages/assist/suport/lawsLib/assistSuportLawslibAction!zlList.action?eid=${assistSuportLawslib.id}">
				</s:div>
				<s:div id='three' label='审计步骤' theme="ajax" cssStyle="height: 500px;" href="${contextPath}/pages/assist/suport/lawsLib/assistSuportLawslibAction!bzList.action?eid=${assistSuportLawslib.id}">
				</s:div>
				<s:div id='four' label='经验模型' theme="ajax" cssStyle="height: 500px;" href="">
					<iframe src="${contextPath}/pages/assist/suport/lawsLib/assistSuportLawslibAction!mxView.action?eid=${assistSuportLawslib.id}" width="100%" height="100%"></iframe>
				</s:div>
				<s:div id='five' label='适用法规' theme="ajax" cssStyle="height: 500px;" href="${contextPath}/pages/assist/suport/lawsLib/assistSuportLawslibAction!fgList.action?eid=${assistSuportLawslib.id}">
				</s:div>
				<s:div id='six' label='典型案例' theme="ajax" cssStyle="height: 500px;" href="${contextPath}/pages/assist/suport/lawsLib/assistSuportLawslibAction!alList.action?eid=${assistSuportLawslib.id}">
				</s:div>
				--%>
			</s:tabbedPanel>
			</s:form>
		</center>
	</body>
</html>