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
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>审计项目档案文件列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<script language="javascript">
		function selall_inform(name,selected){//全选处理  
		    if (selected==null || selected===''){
		   		 selected=true;
		    }
		    var checkbox=document.getElementsByName(name); 	
			    for(var i=0;i<checkbox.length;i++)
			     checkbox[i].checked=selected;   	    	  
		} 
		function savePower(){
			var power_status = 'true';
			var fileIds = document.getElementsByName("fileIds")
			var fileIdsString ="";
			if(fileIds != null && fileIds.length > 0){
				for(var i=0;i<fileIds.length;i++){
					if(fileIds[i].checked){
						fileIdsString += fileIds[i].value+",";
					}
				}
			}
			if(fileIdsString == null || fileIdsString == ''){
				showMessage1("请选择授权查看的文件！");
				return false;
			}else{
				$.messager.confirm('确认','项目档案授权文件已选择，是否保存？',function(flag){
					if (flag){
						DWREngine.setAsync(false);
						DWREngine.setAsync(false);DWRActionUtil.execute({ namespace:'/archives/borrow', action:'affirmPowerInit', executeResult:'false' },
						{'file_id':fileIdsString.replace(/\s+$|^\s+/g,""),'project_id':'${project_id}','borrowFormId':'${borrowFormId}',
						'power_status':power_status.replace(/\s+$|^\s+/g,"")},xxx);
						function xxx(data){
							showMessage1("档案授权成功!");
							close_win();
						} 
					} else {
			 			return false;
			 		}
				});
			}
		}
		//关闭项目档案授权窗口
		function close_win(){
   			window.parent.closeWin('fileSQ');
   		}
	</script>
<body class="easyui-layout">
	<div region="center">
	  <table cellpadding=0 cellspacing=1 border=0
		    class="ListTable" width="100%" align="center">
		    <tr >
		        <td colspan="4" style="text-align:left;" class="edithead">
		            <div style="display: inline;">
		               审计项目档案名称：
		               <s:if test="${archive_name!=null && archive_name!=''&& archive_name!='null'}">
		               		<s:property value="archive_name" escape="false"/>
		               </s:if>
		            </div>
		        </td>
		    </tr>
		    
		</table>
		 <table id="archivesdetailTable"  class="ListTable" >
		 	<tr>
		    	<td colspan="10" style="text-align:right;" class="editTd">
		            <div align="right" style="display: inline;">
		            	<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="selall_inform('fileIds',true)">全选</a>
                    	<a class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="selall_inform('fileIds',false)">全不选</a>
		            </div>
		    		
		    	</td>
		    </tr>
	        <tr>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">审计阶段</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">流程节点</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">是否必做</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">文件类型</td>
	            <td style='text-align:center;' class="EditHead" nowrap="nowrap">审计文书</td>
	        </tr>
	        <c:forEach items="${projectStageList}" var="projstage">
	            <tr>
	               <c:choose>
	                  <c:when test="${empty projstage.wppdArchivesList}">
	                        <td id="${projstage.stagecode}" rowspan='1' style="text-align: center" nowrap="nowrap" class="EditHead">${projstage.stagename}</td>
	                  </c:when>
	                  <c:otherwise>
	                        <td id="${projstage.stagecode}" nowrap="nowrap" rowspan='<c:out value="${fn:length(projstage.wppdArchivesList)}"></c:out>' style="text-align: center" class="EditHead">${projstage.stagename}</td>
	                  </c:otherwise>
	               </c:choose>
	               <c:choose>
	                   <c:when test="${empty projstage.wppdArchivesList}">
	                        <td align="left" class="editTd">&nbsp;</td>
	                        <td style="text-align: center" class="editTd">&nbsp;</td>
	                        <td align="left" class="editTd" nowrap="nowrap">&nbsp;</td>
	                        <td align="left" class="editTd" nowrap="nowrap">&nbsp;</td>
	                   </c:when>
	                   <c:otherwise>
	                   <c:forEach items="${projstage.wppdArchivesList}" var="wppd" begin="0" end="0">
	                        <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
	                        <td style="text-align: center" class="editTd">${wppd.needdo}</td>
	                        <td align="left" class="editTd" nowrap="nowrap">
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
	                            <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
	                            <td style="text-align: center" class="editTd"> ${wppd.needdo}</td>
	                            <td align="left" class="editTd" nowrap="nowrap">
		                        <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
		                        <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
		                        <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
		                        <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
		                        </td>
	                            <td align="left" class="editTd" nowrap="nowrap">${wppd.uploadFileUrl }</td>
	                         </tr>                    
                        </c:forEach>
                    </c:if>
                </c:if>
        	 </c:forEach>
	         <tr>
          		<td align="right" class="editTd" colspan="6" style="text-align: right;">
                     <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savePower()">保存</a>
                     <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="close_win()">关闭</a>
          		</td>
       		 </tr>
	     </table>
	</div>
</body>
</html>
