<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 

<title></title>
</head>
<body>
	<s:form action="search" namespace="/pages/assist/suport/lawsLib" method="post">
		<s:hidden name="m_str" value="${m_str}"></s:hidden>
		<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
		<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
		<s:hidden name="m_view" value="${m_view}"></s:hidden>
	</s:form>
</body>
<script type="text/javascript">
	
	document.forms[0].submit();
</script>
</html>