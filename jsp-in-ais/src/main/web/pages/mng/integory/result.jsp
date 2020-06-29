<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>11</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript">
	
	function modi(){
		var ids =  validateSel('interoryIds');
		if(ids=='false'){
			return false;
		}
		id=ids.split(',');
		if (ids.length>1 && id[1]!=null && id[1]!=''){
			alert("只能选一条数据修改！");
			return false;
		}
		window.location.href = "${contextPath}/resmngt/integory/updateIntegory.action?interoryId="+id[0];
	}
	function delOrEdit(){
		if(validateSel('interoryIds')=='false')
			return false;
		if(window.confirm('确认删除吗？删除后该中介将不被引用！')){
			return true;
		}else{
			return false;
		}
	}
	function validateSel(tagName){
		var ids = "";
		var id;
		var objs = document.getElementsByName(tagName);
		for(i=0; i<objs.length; i++){
			if(objs[i].checked)
				ids += objs[i].value + ",";
		}
		if(ids==null || ids==''){
			alert("请选择一条数据！");
			return "false";
		}
		return ids;
	}
</script>

	</head>

	<body  >

		<%
			request.setAttribute("integoryinfo_List", session
					.getAttribute("integoryinfo_List"));
			session.removeAttribute("integoryinfo_List");
		%>
		<s:form namespace="/resmngt/integory" name="integoryinfo_List"
			onsubmit="return delOrEdit('interoryIds');" id="integoryinfo_List" >
			<div align="center">
			<display:table name="integoryinfo_List" id="row"
				requestURI="${contextPath}/resmngt/integory/searchIntegory.action"
				class="its" pagesize="5" size="100%">
				<s:hidden name="auditunitid"></s:hidden>
				<display:column>
					<input type="checkbox" name="interoryIds"
						value="${row.interoryId }">
				</display:column>
				<display:column property="unitname" title="机构名称" sortable="true"></display:column>
				<display:column property="auditunitname" title="所属审计部门" sortable="true"></display:column>
				<display:column property="zzdj" title="资质等级" sortable="true"></display:column>
				<display:column property="zzyxqx" title="资质有效期限" sortable="true"></display:column>
				<display:column property="linkman" title="联系人"></display:column>
				<display:column property="phone" title="联系人电话"></display:column>
				<display:column title="操作">
					<a href="javascript:void(0);"
					onclick="javascript:window.open('${contextPath}/resmngt/integory/info_integoryinfo.action?interoryId=${row.interoryId }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
				</display:column>
				
			</display:table>
			</div>
			<div align="right">
				<s:button onclick="window.location.href ='${contextPath}/resmngt/integory/add_integoryinfo.action';" value="增加" />
				&nbsp;&nbsp;&nbsp;&nbsp;
				<s:button value="修改" onclick="modi();"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<s:submit onclick="return "
					action="loguotIntegory" value="删除" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			</div>
			
		</s:form>

	</body>
</html>
