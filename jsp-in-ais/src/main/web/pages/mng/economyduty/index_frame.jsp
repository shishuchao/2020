<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
			<style type="text/css"> 
	#container{
		width:100%;height: 90%;
	}
	#content{
		width: 20%;text-align: left;float: left;height: 100%;
	}
	#sidebar{
		width: 80%;text-align: left;float: right;height: 100%;
	}
</style>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable">
			<tr class="listtablehead">
				<td align="left" class="edithead">
				<s:if test="${status=='edit'}">
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/economyduty/economyDutyAction!frame.action?status=edit')" />
				</s:if>
				<s:else>
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/economyduty/economyDutyAction!frame.action')" />
				</s:else>
				</td>
			</tr>
		</table>
<div id="container">
  <div id="content">
	<iframe name="leftTree" width="100%" frameborder="0" height="100%" 
		src="<s:url action="economyDutyAction!tree"></s:url>"></iframe>
  </div>
  <div id="sidebar">
		<iframe name="_basefrm" width="100%" frameborder="0" height="100%" src="${contextPath}/blank.jsp"></iframe>
  </div>
</div>
	</body>
</html>
