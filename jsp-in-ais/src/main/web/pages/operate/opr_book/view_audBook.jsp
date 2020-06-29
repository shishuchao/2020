<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>审计查询书</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<link href="${contextPath}/resources/csswin/subModal.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<s:head theme="ajax" />
<script type="text/javascript">

	function toSave() {
		var memberForm = document.getElementById('bookForm');
		memberForm.submit();
	}

</script>
</head>
<body>
	<s:form id="bookForm" action="saveAudBook"
		namespace="/operate/audBook">
		<table id="audBookTable" cellpadding=0 cellspacing=1 border=0  class="ListTable" align="center">
				<s:hidden name="audBook.formId"/>
  	  			<s:hidden name="audBook.fname"/>
  	  			<s:hidden name="audBook.floginname"/>
  	  			<s:hidden name="audBook.project_id"/>
				<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
				<tr >
					<td colspan="4" style="text-align:center" class="EditHead">&nbsp;审计查询书信息</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:10%">查询书状态</td>
					<td class=editTd style="width:39%">
						<s:property value="audBook.book_statusName"/> 
					</td>
					<td class="EditHead" nowrap style="width:10%">查询书编号</td>
					<td class="editTd" id="planCodeDiv" style="width:39%">
						<s:property value="audBook.book_code"/> 
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap>查询书名称</td>
					<td class="editTd" >
						<s:property value="audBook.book_name"/> 
					</td>
					<td class="EditHead" nowrap>被审计单位</td>
					<td class="editTd" >
						<s:property value="audBook.audit_object_name"/> 
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap>
					查询事项
					<br/>
					</td>
					<td class=editTd colspan="3">
		
			<s:textarea cssClass="noborder"  name="audBook.query_item"   readonly="true" rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
						
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap>查询要求
					<br/>
					</td>
					<td class=editTd colspan="3">
						<s:textarea cssClass="noborder"  name="audBook.query_requirements"   readonly="true" rows="6" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
				
					</td>
				</tr>
			</table>
				<s:if test="${param.winview == 'benpage'}">
		<div align="right" style="width: 96%;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
				onclick="window.location.href='${contextPath}/operate/audBook/getlistBooks.action?projectview=${param.projectview}&view=${view}&project_id=${audBook.project_id}'">返回</a>
<!--				 <input type="button" value="返回"-->
<!--				onclick="window.location.href='${contextPath}/operate/audBook/getlistBooks.action?project_id=${audBook.project_id}'" />-->
		</div>
		</s:if>
		<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>	
	</s:form>
	<div region="south"  border="0">
		<s:if test="${ isEnableFlag != 'Y' || isArchives =='1' }">
			<div id="aud_book_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudObject.formId}' ,isAdd:false,isDel:false,callbackGridHeight:200"></div>
		</s:if>
		<s:else>
			<div id="aud_book_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudObject.formId}' ,callbackGridHeight:200"></div>
		</s:else>
	</div>
</body>
<script type="text/javascript">
$("#bookForm").find("textarea").each(function(){
	autoTextarea(this);
});
</script>
</html>
