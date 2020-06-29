<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.task.model.AudDoubt" />
 

 


<html>
	<head>
	 

		<script type="text/javascript">
		function backList(){
		 var type='1';
		if('${type}'=='YD'){
		type='2';
		}else{
		type='3'
		}
		
		<%if("true".equals(request.getParameter("owner"))){%>
		
		
		   var u='${pageContext.request.contextPath}/operate/doubtExt/doubtUiOwner.action?owner=true&groupCode=<%=request.getParameter("groupCode")%>&type=FX&project_id=${project_id}&taskId=${taskId}&taskPid=${taskId}'
            window.parent.Usp.doTabLoad({
               tabId:'common-data-dataframe-tab-owner',
               pid:'common-data-dataframe-tab4-owner',
               url:u
               });
        <%}else{%>
        
           var u='${pageContext.request.contextPath}/operate/doubtExt/doubtUi.action?type=FX&project_id=${project_id}&taskId=${taskId}&taskPid=${taskId}'
            window.parent.Usp.doTabLoad({
               tabId:'common-data-dataframe-tab',
               pid:'common-data-dataframe-tab4',
               url:u
               });
                            
        <%}%>
		
        
        }
		
          function onBodyLoaded(){
           backList()
          }
     </script>
	</head>
	<body onload="onBodyLoaded()" >

 
	</body>
</html>
