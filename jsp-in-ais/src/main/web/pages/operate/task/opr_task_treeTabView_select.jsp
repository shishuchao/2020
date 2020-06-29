<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>实施方案详细信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<s:head theme="ajax" />
		
		<script type="text/javascript">
          function getCheckValue(){
           var  v1=copyArchivesInfoFrame.getCheckValue2();
           alert(v1);
            return v1;
          }
          </script>
	</head>

	<body>
		<s:tabbedPanel id='test' theme='ajax' selectedTab='<%=request.getParameter("selectedTab")%>'>
  
			<s:div id='proc' label='审计事项' theme='ajax'
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame"
					src="${contextPath}/operate/task/showTreeListViewSelect.action?project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="380"></iframe>
			</s:div>
		</s:tabbedPanel>
	</body>
</html>
