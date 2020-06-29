<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.task.model.AudDoubt" />
 

 


<html>
	<head>
	 

		<script type="text/javascript">
		function backList(){
	     var u = '${pageContext.request.contextPath}/operate/diaryExt/diaryList.action?pro_id=<%=request.getParameter("pro_id")%>'
          window.parent.Usp.doTabLoad({
               tabId:'operate-index-tab',
               pid:'common-data-dataframe-tab12',
               url:u
               }); 
}
		
          function onBodyLoaded(){
           backList()
          }
     </script>
	</head>
	<body onload="onBodyLoaded()" >

 
	</body>
</html>
