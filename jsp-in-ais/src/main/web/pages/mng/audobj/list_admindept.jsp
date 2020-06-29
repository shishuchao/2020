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
			function _edit(){
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
					alert("不能同时修改多个单位信息！");
					return false;
				}
				if(cbx_no==-1){
					alert("没有选择要修改的单位!");
					return false;
				}
			
				document.forms[1].action = "editAdminDept.action";
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
					alert("没有选择要删除的单位!");
					return false;
				}
				if( window.confirm('确认删除吗？')){
					document.forms[1].action="deleteAdminDept.action";
					document.forms[1].submit();
				}
			}
			function cleanForm(){
				document.getElementsByName("adminDept.checkDept")[0].value = "";
				document.getElementsByName("adminDept.isPenalize")[0].value = "";
				window.document.forms[0].action='${contextPath}/mng/audobj/object/searchAdminDept.action';
				window.document.forms[0].submit();
				
				document.forms[0].action="${contextPath}/mng/audobj/object/searchAdminDept.action";
				document.forms[0].submit();
			}
		</script>
</head>
<body>
<center>
		<s:form namespace="/mng/audobj/object">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="ListTableTr11" nowrap="nowrap">
						检查单位
					</td>
					<TD class="ListTableTr22">
						<s:textfield name="adminDept.checkDept" />
					</TD>
					<TD align="center" class="ListTableTr11" nowrap="nowrap">
						是否被处罚
					</TD>
					<TD class="ListTableTr22">
						<s:select name="adminDept.isPenalize" list="#@java.util.LinkedHashMap@{'':'', '是':'是', '否':'否'}" required="true" />
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="searchAdminDept" value="查询"/>&nbsp;&nbsp;
							<s:button onclick="cleanForm()"  value="重置"></s:button>
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="status"/>
			<s:hidden name="pid"/>
		</s:form>
<s:form namespace="/mng/audobj/object" onsubmit="return delOrEdit('ids');">
			<s:hidden name="status"/>
			<s:hidden name="pid"/>
	<display:table name="adminDeptList" id="row" requestURI="${contextPath}/mng/audobj/object/searchAdminDept.action" class="its" 
		pagesize="${baseHelper.pageSize}" partialList="true" 
		size="${baseHelper.totalRows}" sort="external"
		defaultsort="2" defaultorder="descending" >
		
		<s:if test="${status == 'edit'}">
		<display:column title="选择" headerClass="center">
			<input type="checkbox" name="ids" value="${row.id}">
		</display:column>
		</s:if>
		<display:column title="检查单位" sortable="true" headerClass="center" sortName="checkDept">
			<a href="${contextPath}/mng/audobj/object/viewAdminDept.action?adminDeptId=${row.id}&pid=${pid}&status=${status}">${row.checkDept }</a>
		</display:column>
		<display:column property="beginDate" title="检查开始日期" sortable="true" headerClass="center" class="center" sortName="beginDate"></display:column>
		<display:column property="endDate" title="检查结束日期" sortable="true" headerClass="center" class="center" sortName="endDate"></display:column>
		<display:column property="isPenalize" title="是否被处罚" sortable="true" headerClass="center" sortName="isPenalize"></display:column>
	</display:table>
	</center><br>
	<s:if test="${status == 'edit'}">
	<div align="right">
		<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/audobj/object/addAdminDept.action?pid=${pid}&status=${status}'">
		&nbsp;&nbsp;
		<s:button value="删除" onclick="delVal()"/>
		&nbsp;&nbsp;
		<s:button value="修改" onclick="_edit()"></s:button>
		&nbsp;&nbsp;
		<input type="button" onclick="selall_inform('ids', true)" value="全选">
		&nbsp;&nbsp;
		<input type="button" onclick="selall_inform('ids', false)" value="全不选">
		&nbsp;&nbsp;
	</div>
	</s:if>
</s:form>
</body>
</html>
