<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
		function editVal(){
			var cbxs = document.getElementsByName("ids");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
				}
			}
			
			if(cbx_count>1){
				alert("不能同时修改多个项目信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要修改的项目!");
				return false;
			}
			
			document.forms[1].action="edit.action";
			document.forms[1].submit();
		}
		function delVal(){
			var cbxs = document.getElementsByName("ids");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
				}
			}
			if(cbx_no==-1){
				alert("没有选择要删除的项目!");
				return false;
			}
			if( window.confirm('确认删除吗？')){
				document.forms[1].action="delete.action";
				document.forms[1].submit();
				}
		}
		function cleanForm(){
			document.getElementsByName("proName")[0].value = "";
			document.getElementsByName("deptName")[0].value = "";
			document.getElementsByName("proMana")[0].value = "";
			
			document.forms[0].action="${contextPath}/mng/audobj/history/list.action?outsideHistory.action";
			document.forms[0].submit();
		}
		</script>
</head>
<body>
<center>
		<s:form namespace="/mng/audobj/history">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						项目名称
					</td>
					<TD class="listtabletr1">
						<s:textfield name="proName" />
					</TD>
					<TD class="listtabletr1">
						审计单位
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="deptName" />
					</TD>
					<TD class="listtabletr1">
						项目负责人
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="proMana" />
					</TD>
				</tr>
				<tr class="listtablehead" align="right">

					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="list" value="查询"/>&nbsp;&nbsp;
							<s:button  onclick="cleanForm()"  value="重置"></s:button>
						</div>
					</td>

				</tr>
			</TABLE>
			<s:hidden name="status"></s:hidden>
			<s:hidden name="listStatus"/>
			<s:hidden name="outsideHistory.objectId"></s:hidden>
</s:form>
<s:form namespace="/mng/audobj/history" onsubmit="return delOrEdit('ids');">
<display:table name="list" id="row1" requestURI="${contextPath}/mng/audobj/history/list.action?outsideHistory.action" class="its" 
	pagesize="${baseHelper.pageSize}" partialList="true" 
	size="${baseHelper.totalRows}" sort="external"
	defaultsort="2" defaultorder="descending">
	<s:if test="${status!='view'}">
		<display:column>
			<input type="checkbox" name="ids" value="${row1.id}">
		</display:column>
	</s:if>
	<display:column title="项目名称" sortable="true" headerClass="center" sortName="projectName">
		<a href="${contextPath}/mng/audobj/history/detail.action?outsideHistory.id=${row1.id}&outsideHistory.objectId=${row1.objectId}&status=${status}">${row1.projectName}</a>
	</display:column>
	<display:column property="startDate" title="审计开始日期" sortable="true" headerClass="center" sortName="startDate"></display:column>
	<display:column property="endDate" title="审计结束日期" sortable="true" headerClass="center" sortName="endDate"></display:column>
	<display:column property="department" title="审计单位" sortable="true" headerClass="center" sortName="department"></display:column>
	<display:column property="projectDirector" title="项目负责人" sortable="true" headerClass="center" sortName="projectDirector"></display:column>
</display:table>
<br>
<div align="right">
<s:if test="${status!='view'}">
	<s:button value="增加" onclick="window.location='${contextPath}/mng/audobj/history/add.action?outsideHistory.objectId=${outsideHistory.objectId}'"></s:button>
		&nbsp;&nbsp;
	<s:button id="delete" value="删除" onclick="delVal()" ></s:button>
		&nbsp;&nbsp;
	<s:button id="editbtn" value="修改" onclick="editVal()"></s:button>
		&nbsp;&nbsp;
		<input type="button" onclick="selall_inform('ids', true)" value="全选">
		&nbsp;&nbsp;
		<input type="button" onclick="selall_inform('ids', false)" value="全不选">
		&nbsp;&nbsp;
</s:if>
</div>
			<s:hidden name="status"></s:hidden>
			<s:hidden name="listStatus"/>
			<s:hidden name="outsideHistory.objectId"></s:hidden>
		</s:form>
</center>
</body>
</html>
