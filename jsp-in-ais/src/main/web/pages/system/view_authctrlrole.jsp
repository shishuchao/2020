<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<TITLE> 可控角色设置</TITLE>
<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<script language="javascript">
function doClose(){
window.close();
}
</script>
</HEAD>

<BODY>
<display:table name="authCtrlRoleR" id="row" class="its" pagesize="20" excludedParams="*"
				size="listSize" requestURI="/ais/system/authAuthorityAction!authCtrlRoleSet.action?p_froleid=${p_froleid}&view=view;">
<display:column title="已授予角色" property="fpname" sortable="true" style="white-space:nowrap;"></display:column>
</display:table>

</BODY>
</HTML>