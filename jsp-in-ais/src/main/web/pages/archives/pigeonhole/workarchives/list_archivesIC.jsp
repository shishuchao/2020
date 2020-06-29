<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% 
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="expires" content="0">
		<title>审计项目档案文件列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
	</head>
	<script type="text/javascript">
		function readMenuScriptMInArchives(menuscript_id,contextPath){
			var url = contextPath+'/operate/manu/viewAll.action?crudId='+menuscript_id;
			$("#viewAudDoubtFrame").attr("src",url);
			$('#viewAudDoubtDiv').window('open');
		}
		function readAudDoudt(doubt_id,contextPath){
			var url = contextPath + "/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
			$("#viewManuScriptFrame").attr("src",url);
			$('#viewManuScriptDiv').window('open');
		}
		function back(){
			window.location.href="${contextPath}/archives/pigeonhole/searchArchivesList4adminIC.action";
		}
		
		function doSearch(){
			 document.getElementById("exportForm").submit();	
		}
	</script>
<body >
	<center>
	<s:form id="exportForm" action="exprotArchivesList" namespace="/archives/workprogram/pigeonhole" method="post">
	 <s:hidden name="project_id"/>
		<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	        <tr>
	            <td class="EditHead" style='text-align:center;' nowrap="nowrap">审计阶段</td>
	            <td class="EditHead" style='text-align:center;' nowrap="nowrap">流程节点</td>
	            <td class="EditHead" nowrap="nowrap" style='text-align:center;' nowrap="nowrap">是否必做</td>
	            <td class="EditHead" style='text-align:center;' nowrap="nowrap">文件类型</td>
	            <td class="EditHead" nowrap="nowrap" style='text-align:center;'>审计文书</td>
	        </tr>
	        <c:forEach items="${projectStageList}" var="projstage">
            <tr>
                 <c:choose>
                  <c:when test="${empty projstage.wppdArchivesList}">
                        <td id="${projstage.stagecode}" rowspan='1' align="left" nowrap="nowrap" class="EditHead"> ${projstage.stagename} </td>
                  </c:when>
                   <c:otherwise>
                        <td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdArchivesList)}"></c:out>' align="left" class="EditHead"> ${projstage.stagename}</td>
                   </c:otherwise>
                </c:choose>
                <c:choose>
                   <c:when test="${empty projstage.wppdArchivesList}">
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd">&nbsp;</td>
                        <td align="left" class="editTd" nowrap="nowrap">&nbsp;</td>
                   </c:when>
                   <c:otherwise>
	                   <c:forEach items="${projstage.wppdArchivesList}" var="wppd" begin="0" end="0">
	                        <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
	                        <td align="left" class="editTd" style='text-align:center;' nowrap="nowrap">${wppd.needdo}</td>
	                        <td align="center" class="editTd" nowrap="nowrap">
	                        <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
	                        <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
	                        <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
	                        <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
	                        </td>
	                        <td align="left" class="editTd" nowrap="nowrap">${wppd.uploadFileUrl}</td>
	                   </c:forEach>
                   </c:otherwise>
                 </c:choose>
             </tr>
             <c:if test="${not empty projstage.wppdArchivesList}">
                <c:if test="${fn:length(projstage.wppdArchivesList)>1}">
                      <c:forEach items="${projstage.wppdArchivesList}" begin="1" var="wppd" varStatus="state">
                      <tr>
                         <td align="left" class="editTd" nowrap="nowrap" >${wppd.workprogramdetailname}</td>
                         <td align="left" class="editTd" style='text-align:center;'>${wppd.needdo}</td>
                         <td align="left" class="editTd" nowrap="nowrap">
		                     <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
		                     <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
		                     <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
		                     <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
	                     </td>
                         <td align="left" class="editTd" >${wppd.uploadFileUrl }</td>
                      </tr>                    
                     </c:forEach>
                 </c:if>
             </c:if>
        </c:forEach>
    </table>
	   </s:form>
	   		<div style="text-align:right;padding-right:20px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="doSearch()">导出</a>&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back()">返回</a>
			</div>
    </center>
    <div id="viewManuScriptDiv" title=" " style='overflow:hidden;padding:0px;'> 	  		
		<iframe id="viewManuScriptFrame" name="viewManuScriptFrame" title="审计底稿" src="" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>				
	</div>
	<div id="viewAudDoubtDiv" title=" " style='overflow:hidden;padding:0px;'> 	  		
		<iframe id="viewAudDoubtFrame" name="viewAudDoubtFrame" title="审计疑点" src="" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>				
	</div>
	<div id="viewEvidence" title="查看取证记录" style="overflow:hidden;padding:0px">
		<iframe id="viewEvidenceSrc" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
	<div id="viewAudBook" title="查看审计查询书" style="overflow:hidden;padding:0px">
		<iframe id="viewAudBookSrc" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
	<div id="viewDiGao" title="查看底稿" style="overflow:hidden;padding:0px">
		<iframe id="viewDiGaoSrc" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
</body>
<script>
	function readMenuScriptArchives(project_id,contextPath){
		var url = contextPath+"/operate/manuExt/mainUi.action?projectview=view&project_id="+project_id;
		$('#viewDiGaoSrc').attr("src",url);
		$('#viewDiGao').window('open');
	}
	function readEvidenceArchives(project_id,contextPath){
		var url = contextPath+"/project/evidence/listEvidence.action?project_id="+project_id;
		$('#viewEvidenceSrc').attr("src",url);
		$('#viewEvidence').window('open');
	}
	function readAudBookArchives(project_id,contextPath){
		var url = contextPath+"/operate/audBook/getlistBooks.action?project_id="+project_id;
		$('#viewAudBookSrc').attr("src",url);
		$('#viewAudBook').window('open');
	}
	$(function(){
		//初始化审计底稿窗口
		$('#viewManuScriptDiv').window({   
			width:996,   
			height:480,   
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});
		//初始化审计疑点窗口
		$('#viewAudDoubtDiv').window({   
			width:996,   
			height:480,   
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true
		});
		$('#viewDiGao').window({
			width:950, 
			height:450,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
		});
		$('#viewAudBook').window({
			width:950, 
			height:450,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
		});
		$('#viewEvidence').window({
			width:950, 
			height:450,  
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
		});
	});
</script>
</html>
