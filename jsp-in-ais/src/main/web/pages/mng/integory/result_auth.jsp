<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>11</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		
		<style type="text/css">
td {
	font-size: 12px;
}

.ListTableTra {
	BACKGROUND-COLOR: #DDEEFF;
	width: 10%;
	height: 14;
	vertical-align: middle;
	text-align: right;
	font-size: 12px
}

.ListTableTrb {
	BACKGROUND-COLOR: #ffffff;
	width: 23%;
	height: 14;
	padding-left: 5px;
}

.ListTableTrc {
	BACKGROUND-COLOR: #ffffff;
	height: 14;
	padding-left: 5px;
}
</STYLE>
		<script type="text/javascript">
	function openw(){
	window.paramw = "模态窗口";
    var str = window.showModalDialog("main_integory_add.action", window, "dialogWidth:900px;dialogHeight:800px");
	}
	
	function batch(){
	  window.open("${contextPath}/resmngt/integory/batch_edit_integory.jsp","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
</script>

	</head>

	<body>

		<%
			request.setAttribute("integoryinfo_List", session
					.getAttribute("integoryinfo_List"));
			session.removeAttribute("integoryinfo_List");
		%>
		<s:form namespace="/resmngt/integory" name="integoryinfo_List"
			onsubmit="return delOrEdit('interoryId');" id="integoryinfo_List" >

			<display:table name="integoryinfo_List" id="row"
				requestURI="${contextPath}/resmngt/integory/search_auth.action"
				class="its" pagesize="5" size="100%">
				
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
		
		</s:form>

	</body>
</html>
