<!DOCTYPE HTML>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<body  style="overflow:hidden;">
		<div class="easyui-layout" style='overflow:hidden;' fit='true' border='0'>
			<div region="center" border='0'>
		<s:form action="save" namespace="/pages/assist/suport/lawsLib"
			theme="simple">
			<s:hidden name="nodeid" value="${nodeid}" />
			<s:hidden name="assistSuportLawslib.categoryFk" value="${assistSuportLawslib.categoryFk}" />
			<s:hidden name="assistSuportLawslib.id" value="${assistSuportLawslib.id}" />
			<table  class="ListTable">
				<tr> 
					<td class="EditHead" nowrap="nowrap" sytle="width:15%">
						名称  
					</td>
					<td class="editTd" sytle="width:35%">
						${assistSuportLawslib.title}
					</td>
					<td class="EditHead" sytle="width:15%">
						案例编号
					</td>
					<td class="editTd" sytle="width:35%">
						${assistSuportLawslib.codification}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						类别
					</td>
					<td class="editTd">
						${assistSuportLawslib.category}

					</td>
					<td class="EditHead">
						创建单位
					</td>
					<td class="editTd">
						${assistSuportLawslib.sundept}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建人
					</td>
					<td class="editTd" colspan="3">
						${assistSuportLawslib.summan}

					</td>
				</tr>
				<tr>
					<td class="EditHead" colspan="4" style="text-align: center;">
						正文
					</td>
				</tr>
				<tr>
					<td colspan="4" class="editTd">${assistSuportLawslib.content}</td>
				</tr>
			</table>
			<div id="accelerys" align="center">
				<s:property escape="false" value="accessoryList" />
			</div>
			<s:hidden name="m_message" value="${m_message}" />
		</s:form>
		</div>
		</div>
	</body>
</html>