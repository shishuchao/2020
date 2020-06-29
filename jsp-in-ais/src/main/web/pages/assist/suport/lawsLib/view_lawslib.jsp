<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<s:if test="${assistSuportLawslib.id=='0'}">
	<s:text id="title" name="'添加对象'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改对象'"></s:text>
</s:else>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:head theme="simple" />
		<title>法律法规</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	</head>
	<!-- view_lawslib.jsp -->
<script type="text/javascript">
	function goback(){
		var _marked = document.getElementById('marked').value;
		//window.history.go(-1);
		window.location.href="/ais/pages/assist/suport/lawsLib/search.action?mCodeType=flfg&nodeid=${nodeid}&m_view=view";
	}
</script>
	<body  style="overflow:hidden;">
		<div class="easyui-layout" style='overflow:hidden;' fit='true' border='0'>
			<div region="center" border='0'>
				<s:form action="save" namespace="/pages/assist/suport/lawsLib"
					theme="simple">
					<s:hidden name="nodeid" value="${nodeid}" />
					<s:hidden name="assistSuportLawslib.categoryFk"
						value="${assistSuportLawslib.categoryFk}" />
					<s:hidden name="assistSuportLawslib.id"
						value="${assistSuportLawslib.id}" />
					<s:hidden id="marked" name="marked"></s:hidden>
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" style="width:15%;">
								名称
							</td>
							<td class="editTd" style="width:35%;word-break:break-all;">
								${assistSuportLawslib.title}
	
							</td>
							<td class="EditHead" style="width:15%;">
								文号
							</td>
							<td class="editTd" style="width:35%;">
								${assistSuportLawslib.codification}
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								颁布单位
							</td>
							<td class="editTd">
								${assistSuportLawslib.promulgationDept}
	
							</td>
							<td class="EditHead">
								类别
							</td>
							<td class="editTd">
								${assistSuportLawslib.category}
	
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								有效性
							</td>
							<td class="editTd">
								${assistSuportLawslib.effective}
							</td>
							<td class="EditHead">
								颁布日期
							</td>
							<td class="editTd">
								<s:if test="!${empty(assistSuportLawslib.promulgationDate)}">
								${fn:substring(assistSuportLawslib.promulgationDate, 0, 10)}
								</s:if>
							</td>
							</tr>
							<tr>
							<td class="EditHead">
								生效日期
							</td>
							<td class="editTd">
							<s:if test="!${empty(assistSuportLawslib.effctiveDate)}">
								${fn:substring(assistSuportLawslib.effctiveDate, 0, 10)}
								</s:if>
							</td>
						
							<td class="EditHead">
								失效日期
							</td>
							<td class="editTd">
							<s:if test="!${empty(assistSuportLawslib.invalidationDate)}">
								${fn:substring(assistSuportLawslib.invalidationDate, 0, 10)}
							</s:if>
							</td>
							</tr>
							<tr>
								<td class="EditHead">
									创建单位
								</td>
								<td class="editTd">
								${assistSuportLawslib.sundept}
								</td>
								<td class="EditHead">
								</td>
								<td class="editTd">
								</td>
							</tr>
						<tr>
							<td class="EditHead">
								正文
							</td>
							<td colspan="3" class="editTd">${assistSuportLawslib.content}</td>
						</tr>
					<tr>
						<td class="EditHead">
							<div style="float:right;">附件</div> 
						</td>
						<td class="editTd" colspan="3">
							<div data-options="fileGuid:'${assistSuportLawslib.muuid}',uploadFace:1,triggerId:'myUploadId',isEdit:false,isDownload:false,isDel:false" class="easyui-fileUpload" style="padding:0px;"></div>
						</td>
					</tr>					
						</table>
				</s:form>
			</div>
		</div>
	</body>
</html>