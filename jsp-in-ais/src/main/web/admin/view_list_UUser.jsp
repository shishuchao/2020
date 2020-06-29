<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
</head>
<body>
<%--<h1 align="center">对象列表</h1>--%>
		<display:table  name="objectList"  id="row" 
			requestURI="admin/viewlistUUser.action" 
			pagesize="${baseHelper.pageSize}" partialList="true" 
			size="${baseHelper.totalRows}" sort="external"
			class="its">
				<display:column  title="用户ID" >
					<a href="<s:url action="editUUser"><s:param name="view" value="true"/></s:url>&uUser.fuserid=${row.fuserid}">${row.fuserid}</a>
				</display:column>
				<display:column property="fdepid" title="用户所属部门ID" ></display:column>
				<display:column property="fcode" title="用户编码" ></display:column>
				<display:column property="fname" title="用户名称" ></display:column>
				<display:column property="floginname" title="登录名称" ></display:column>
				
				<display:column property="fphone" title="电话" ></display:column>
				<display:column property="fmobile" title="手机" ></display:column>
				<display:column property="femail" title="Email" ></display:column>
				<display:column property="fsex" title="性别" ></display:column>
				<display:column property="faddress" title="家庭地址" ></display:column>
				<display:column property="flevel" title="隶属于" ></display:column>
				<display:column property="fstate" title="状态" ></display:column>
				<display:column property="fborn" title="出生日期" format="{0,date,yyyy-MM-dd}"></display:column>
				
		</display:table>

  
</body>
</html>
