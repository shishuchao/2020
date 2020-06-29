<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/css/main.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
</head>
<body>
<%--<h1 align="center">对象列表</h1>--%>
		<div align="center">
		<display:table  name="${objectList}"  id="row" class="its" pagesize="15" requestURI="admin/listUOrg.action">
				<display:column property="fid" title="ID" ></display:column>
				<display:column property="fcode" title="编码" ></display:column>
				<display:column property="fname" title="公司/部门名称" ></display:column>
				<display:column property="flogogram" title="简称" ></display:column>
				<display:column property="ftype" title="类型" ></display:column>
				<display:column property="fleader" title="负责人" ></display:column>
				
				<display:column property="fphone" title="电话" ></display:column>
				<display:column property="fmobile" title="手机" ></display:column>
				<display:column property="femail" title="email" ></display:column>
				<display:column property="ffax" title="传真" ></display:column>
				<display:column  title="操作" >
					<a href="<s:url action="editUOrg"><s:param name="uOrganization.fid" value="${row.fid}"/></s:url>">修改</a>&nbsp&nbsp
					
				<a href="<s:url action="delUOrg"><s:param name="uOrganization.fid" value="${row.fid}"/></s:url>">删除</a>
				</display:column>
		</display:table>
		</div>
<%--<input type="button" name="add" value="增加" onclick="javascript:window.location='<s:url action="edit"><s:param name="industrySet.id" value="0"/></s:url>'">--%>
  ${message}
</body>
</html>
