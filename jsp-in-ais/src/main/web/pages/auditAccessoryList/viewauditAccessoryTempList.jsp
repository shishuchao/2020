<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/swfload/uploadFile.js"></script>
	<title>被审计单位资料模板详细查看</title>
</head>
<body>
	<table cellpadding=0 cellspacing=1 border=0 
	    class="ListTable" width="100%" align="center">
	    <tr class="listtablehead">
	        <td colspan="5" align="left" class="topTd">
	            <div style="display: inline;width:80%;">
					查看被审计单位资料模板
	            </div>
	        </td>
	    </tr>
	</table>
	<s:form id="accessoryTemplateFrom" action="${action}" namespace="/auditAccessoryList" onsubmit="return saveval()" method="post">
		<s:hidden name="auditAccessoryTemp.id" />
		<table cellpadding=0 cellspacing=1 border=0
            class="ListTable" width="100%" align="center" id="templateInfo">
				<tr >
					<td align="left" class="EditHead" style="width:10%">模板名称</td>
		  			<td align="left" class="editTd" style="width:40%">
		  				<s:label name="auditAccessoryTemp.templatename" />
		  			</td>
		  			<td align="left" class="EditHead">适用项目类别</td>
		    		<td align="left" class="editTd">
		    			<s:label name="auditAccessoryTemp.pro_type_name" />
					</td>
				</tr>
				<tr>
					<td align="left" class="EditHead">创建人</td>
					<td align="left" class="editTd">
						<s:label name="auditAccessoryTemp.createName" />
					</td>
 					<td align="left" class="EditHead">创建时间</td>
					<td align="left" class="editTd">
						<s:label name="auditAccessoryTemp.createTime" />
					</td>
				</tr>
		</table>
		<div align="right" style="margin-right :10px;margin-top:15px;">
	        <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location='${contextPath}/auditAccessoryList/viewauditAccessoryTemplate.action'">返回模板列表</a>
		</div>
		
	
	<s:if test="${auditAccessoryTemp.id != null}">
		<div id="" align="center" style="margin-top:50px;">
			<table id=""  class="ListTable" align="center">
		        <tr>
		            <td class="EditHead" style='text-align:center;'>&nbsp;</td>
		            <td class="EditHead" style='text-align:center;'>资料清单</td>
		            <td class="EditHead" style='text-align:center;'>是否必传</td>
		            <td class="EditHead" style='text-align:center;'>模板</td>
		            <s:if test="${view == 'edit' && checkOption != 'copy'}">
		           	 	<td class="EditHead" style='text-align:center;'>操作</td>
		            </s:if>
		        </tr>
		        <c:forEach items="${auditAccessoryTemplateList}" var="row" varStatus="index">
                	<tr>
                	    <td class="editTd" style='text-align:center;'>${index.count}</td>
                	    <td class="editTd" style='text-align:left;'>${row.auditProgram }</td>
                	    <td class="editTd" style='text-align:center;'>${row.needDo }</td>
                	    <td style="WHITE-SPACE: nowrap" class="editTd" style='text-align:left;'>
                	        <c:forEach items="${row.templateList }" var="t">
								 <a href="${contextPath}/commons/file/downloadFile.action?fileId=${t.fileId }">${t.fileName }</a>&nbsp;&nbsp;&nbsp;&nbsp;
								 <s:if test="${view == 'edit' && checkOption != 'copy'}">
								    <a onclick="delTemp('${t.fileId }','${row.aaid}')" href="javascript:void(0)">删除</a>
								 </s:if><br>
							</c:forEach>
                	    </td>
               	        <s:if test="${view == 'edit' && checkOption != 'copy'}">
                	    	<td style="width:250px; text-align:center" class="editTd" style='text-align:center;'>
								<a href="javascript:void(0);" onclick="UploadModel('accelerysModel','${row.aaid}')" >上传模板</a>&nbsp;
								<a href="javascript:void(0);" onclick="delTempList('${row.aaid}')">删除资料清单</a>&nbsp;
								<a href="${contextPath}/auditAccessoryList/addAuditAccessoryTemp.action?checkOption=edit&tempId=${row.aaid}">修改资料清单</a>
                	    	</td>
						</s:if>
                	</tr>
                </c:forEach>
		   </table>
		</div>
	</s:if>
	</s:form>
</body>
</html>

<script type="text/javascript">
</script>