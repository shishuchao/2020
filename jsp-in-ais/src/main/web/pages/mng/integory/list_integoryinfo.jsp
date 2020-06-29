<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/calendar.js"></SCRIPT>		
		
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		
		
	</head>
	<script type="text/javascript">
	function resetSearch(){
		//document.getElementsByName("isblack")[0].value="";
		document.getElementsByName("unitname")[0].value="";
		document.getElementsByName("integoryinfoW.auditunitname")[0].value="";
		document.getElementsByName("integoryinfoW.auditunitid")[0].value="";
		document.getElementsByName("zzdj")[0].value="";
		document.getElementsByName("zzyxqx")[0].value="";
		//document.getElementsByName("zytc")[0].value="";
		
		document.forms[0].action="${contextPath}/resmngt/integory/list_integoryinfo.action";
		document.forms[0].submit();
	}
	</script>
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
	<body>
			<table class="ListTable" style='display:none;'>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('${contextPath}/resmngt/integory/list_integoryinfo.action?flag=modify')"/>
					</td>
				</tr>
			</table>
			<div id="container" class='easyui-layout' fit='true'>
  				<div id="content" title="<%--<img  style='vertical-align: middle; cursor: hand;' onclick=$('img[alt=操作帮助]').trigger('click') src='/ais/images/portal/default/window/icon-question-new.gif' />&nbsp;--%>部门树" region='west' split='true'>
					<iframe scrolling="auto" name="f_left" width="100%" frameborder="0"
						height="100%"
						src="<%=request.getContextPath()%>/resmngt/integory/orgDeptList.action"></iframe>
				 </div>
  				<div id="sidebar" title='详细信息' region='center' style='overflow:hidden;'>
  					<div class='easyui-panel' fit='true'>
						<iframe scrolling="auto" name="childBasefrm" width="900px" frameborder="0" height="400px"
						src="${contextPath}/resmngt/integory/searchIntegory.action"></iframe>
					</div>
				</div>
			</div>
	</body>