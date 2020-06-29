<%@ page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="UTF-8">
<title>Test</title>
<link href="<%=request.getContextPath()%>/resources/css/site.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/style.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
</head>
<body>
<br>
<br>
<div><s:textfield name="comname" label="组织机构选择"
	theme="xhtml"></s:textfield> <s:textfield name="comid"></s:textfield>
&nbsp; <img
	src="<%=request.getContextPath()%>/resources/images/s_search.gif"
	onclick="showPopWin('system/search/searchdata.jsp?url=<%=request.getContextPath()%>/systemnew/orgList.action&paraname=comname&paraid=comid&p_item=0&orgtype=1',600,450,'组织机构选择')"
	border=0 style="cursor: hand"></div>
<br>	
<div><s:textfield name="duoxianrenyuan" label="人员单选"
	theme="xhtml"></s:textfield> <s:textfield name="comperson"></s:textfield>
&nbsp; <img
	src="<%=request.getContextPath()%>/resources/images/s_search.gif"
	onclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/searchsystem/userindex.jsp&paraname=duoxianrenyuan&paraid=comperson&p_item=1&orgtype=0',600,450,'人员选择')"
	border=0 style="cursor: hand"></div>
<br>
<div><s:textfield name="more_name" label="人员多选"
	theme="xhtml"></s:textfield> <s:textfield name="more_code"></s:textfield>
&nbsp; <img
	src="<%=request.getContextPath()%>/resources/images/s_search.gif"
	onclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/searchsystem/userindex.jsp&paraname=more_name&paraid=more_code&p_issel=1&p_item=1&orgtype=1',600,500,'人员选择')"
	border=0 style="cursor: hand"></div>
</body>
</html>