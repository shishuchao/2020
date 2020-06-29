<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>整改跟踪阶段</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();" style="padding:0px;margin:0px;">
</s:if>
<s:else>
	<body  style="padding:0px;margin:0px;" >
</s:else>
<!-- -->
<s:if test="${param.supervisorcode != 'view' }">
	<div  style='padding:0px;overflow:hidden;position:absolute;top:0px;right:2px;z-index:9011;display:none;' id="flowBtns">	
		<s:form id="flowForm" cssStyle="padding:0px;margin:0px;">
			<s:hidden name="crudObject.formId"/>
			<s:hidden name="crudObject.epId"/>
			<s:hidden name="crudObject.proName"/>
			<s:hidden name="crudObject.proCode"/>
			<s:hidden name="crudObject.fileRework"/>
		</s:form> 
	</div>
</s:if>

<iframe id="reworkWorkProgram"
	src="${contextPath}/intctet/defectRectification/initDefectRectPage.action?formId=${crudObject.epId}&taskInstanceId=${taskInstanceId}&view=true"
	frameborder="0" width="100%" height="100%"  
	marginheight='0'  marginwidth='0'  scrolling='no'></iframe>

<s:if test="taskInstanceId!=null&&taskInstanceId!='-1'">
		<div align="center">
			<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>
</s:if>
<script type="text/javascript">
 	$(function(){
		var offset = 5; 		
 		$('#reworkWorkProgram').css('height', $(window).height() - offset);
 		//setIframeHeight("reworkWorkProgram");
 	})
	/* 获取子 页面的 高度 */
	function setIframeHeight(id){
	    try{
	        var iframe = document.getElementById(id);
	        var fla = false ;
	        if(iframe.attachEvent){
	            iframe.attachEvent("onload", function(){
	            	fla = true;
	                iframe.height =  iframe.contentWindow.document.documentElement.scrollHeight +  300;
	            });
	            //IE8
	            if(!fla && iframe ){
	               var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow; 
	                 if (iframeWin.document.body) {
	                    iframe.height = (iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight) + 300 ;
	                   }
	            }
	            return;
	        }else{
	            iframe.onload = function(){
	               iframe.height = iframe.contentDocument.body.scrollHeight +  300;
	            };
	            return;                 
	        }     
	    }catch(e){
	        throw new Error('setIframeHeight Error');
	    }
	} 

		</script>
</body>
</html>