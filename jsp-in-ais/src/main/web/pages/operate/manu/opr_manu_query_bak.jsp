<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.task.model.AudDoubt" />
 

 


<html>
	<head>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	        <%%>  

		<script type="text/javascript">
		function backList(){
		<%if("true".equals(request.getParameter("owner"))){%>
		var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&project_id=${project_id}&taskId=${taskId}&taskPid=${taskId}'
		<%}else{%>
	    var u='${pageContext.request.contextPath}/operate/manuExt/mainUi.action?project_id=${project_id}&taskId=${taskId}&taskPid=${taskId}'
         <%}%>    
         reloadHomeByFlow();
         window.location.href=u;
          }
		
          function onBodyLoaded(){
           backList()
          }
          /*
      	* add by qfucee, 2015.10.26
      	* 流程提交时，刷新首页的待办
      	*/
      	function reloadHomeByFlow(){
      	    	// 是否来自审计作业页面
      	   		var isJobPage = false;
      	     	var bodyId = $(top.document).find('body').attr('id');
      	    	if(bodyId == 'projectLayout'){
      	        	isJobPage = true;
      	      	}else if(bodyId == 'mainLayout'){
      	          	isJobPage = false;
      	      	}
      	     	var pageWin = isJobPage ? window.top.opener.parent : window.top; 
      			if(pageWin && pageWin.reloadHomePage){
      	       		pageWin.reloadHomePage();
      			}
      		
      	}
     </script>
	</head>
	<body onload="onBodyLoaded()" >

 
	</body>
</html>
