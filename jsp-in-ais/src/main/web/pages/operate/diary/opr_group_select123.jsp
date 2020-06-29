
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


	<s:text id="title" name="分工一览表"></s:text>





<html>
<script language="javascript">

		 //生成
      function generate(tz,project_id,taskPid,taskId)
		  {
		     var title = "项目组成员列表";
		     //d_type=document.getElementsByName("type")[0].value;
		     //window.paramw = "模态窗口";
            // window.showModalDialog('${contextPath}/operate/task/project/editGroup.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type+'&&project_id=${project_id}', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
		     showPopWin('${contextPath}/operate/task/project/memberList.action?project_id='+project_id+'&taskPid='+taskPid+'&taskId='+taskId,700,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		      
	                    
	  } 
	  
	  
    function closeGenW(s){
	  window.location.reload();
	  //window.parent.document.frames[s].location.reload(); 
	
    }
	  
 
</script>
 
   <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
 
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
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
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<s:head />
	</head>







<body>   
 
   

<center>
<s:form id="myform" >

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
</table>
 <!--  div   id="tableContainer"   class="tableContainer" align="center">-->${str}<!--  /div>-->

 
</s:form>

</center>
</body>
</html>
