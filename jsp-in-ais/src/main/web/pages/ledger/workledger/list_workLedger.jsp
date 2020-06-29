<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title><s:property value="#title" />列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>
	<script type="text/javascript">
    function deleteForm(id){
        if(window.confirm("确定执行删除操作吗?")){
        	 window.location.href="${pageContext.request.contextPath}/ledger/workLedger/delete.action?id="+id;
        }else{
        	return false;
        }
        
    }
</script>
	<body>
		<center>
		  <table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" width="100%" align="center">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/workLedger/list.action')" />
					</td>
				</tr>
			</table>
			<display:table name="list" id="row"
				requestURI="${contextPath}/ledger/workLedger/list.action"
				class="its" pagesize="15">
				
				<display:column property="work_name" title="工作名称" sortable="true"></display:column>


				<display:column property="work_startday" title="工作开始日"
					sortable="true"></display:column>

				<display:column property="work_endday" title="工作结束日" sortable="true"></display:column>

				<display:column property="w_creator_name" title="工作人"
					sortable="true"></display:column>

				<display:column property="w_dept_name" title="工作部门名称"
					sortable="true"></display:column>

				<display:column property="work_time" title="记录时间" sortable="true"></display:column>

				<display:column title="操作" headerClass="center" class="center">
					<s:if test="${user.fdepid == row.company_id}">
						<a href="<s:url action="edit"><s:param name="id" value="'${row.id}'"/></s:url>">修改</a>&nbsp;&nbsp;
						<a href="javascript:void(0);" onclick="return deleteForm('${row.id}');">删除</a>&nbsp;&nbsp;
					</s:if>
					<a href="<s:url action="view"><s:param name="id" value="'${row.id}'"/></s:url>"
						target="_blank">查看</a>&nbsp;&nbsp;
	</display:column>
			</display:table>

			<br>
			<br>
			<input type="button" name="add" value="添加"
				onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/></s:url>'">
		</center>
	</body>
</html>


