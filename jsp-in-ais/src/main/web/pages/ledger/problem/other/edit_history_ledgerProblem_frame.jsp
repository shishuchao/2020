<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <s:head theme="ajax" />
</head>
<body  style="overflow:hidden;" class="easyui-layout">
<div region="center" border="0px">
    <div class="easyui-tabs" fit="true" id="test" border="0px">
        <div title="整改问题" style="overflow:hidden;" border="0px">
            <iframe id="workplanId" src="${pageContext.request.contextPath}/proledger/problem/editDigao.action?project_id=${project_id}&tableType=1&id=${id}"
                    frameborder=0 width="100%" height="100%"></iframe>
        </div>
 <!--         <div title="整改信息" style="overflow:hidden;display: none;" id="examineIframeDiv" border="0px" >
            <iframe id="examineIframe" src=""
                    frameborder=0 width="100%" height="100%"></iframe>
         </div> -->
    </div>
</div>
<script type="text/javascript">

<%--  $(function(){
		 $('#test').tabs({		 
		 onSelect:function(title){
			 if ( title == "整改信息"){
				 if ($('#examineIframe')){
					 var historyUrl ="<%=request.getContextPath()%>/proledger/problem/historyProblemRec.action?project_id=${project_id}&id=${id}"
                     $('#examineIframe').attr('src', historyUrl);
                 }
			 } 
		 }
	 });		 
 })

 /*刷新历史问题 */
 function flushHistoryProblem(){
	 document.getElementById("examineIframeDiv").style.display="block";//显示
 }
 
 
 function showIframe(){
	 var id = "${id}";
	 if (id != null && id != ""){
		 flushHistoryProblem();
	 }
 } --%>
</script>
</body>
</html>
