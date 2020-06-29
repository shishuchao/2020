<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script language="javascript">
	function edit(){
	    var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
		{'project_id':s},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
	  if(result=='1'){
	  }else{
	  alert("只有组长、副组长和主审有权限修改方案！");
	  return false;
	  }
	   window.open('${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}','pro','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	function goedit3(){
//返回上级list页面
    var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
		{'project_id':s},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
	  if(result=='1'){
	  }else{
	  alert("只有组长、副组长和主审有权限回传改方案！");
	  return false;
	  }
	var title="回传方案";
    window.open('${contextPath}/operate/task/generate.action?project_id=${project_id}','ret','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    
    
}
function goedit4(){
//返回上级list页面
	location.href='${contextPath}/pages/operate/task/excel_redirect.jsp?project_id=${project_id}';//

}
	</script>
	</head>
	<body>
		<s:button value="修改方案" onclick="edit();" />
		&nbsp;&nbsp;
		<s:button value="回传方案" onclick="goedit3();" />
		&nbsp;&nbsp;
		<s:button value="导出方案" onclick="goedit4();" />
	<body>
</html>
