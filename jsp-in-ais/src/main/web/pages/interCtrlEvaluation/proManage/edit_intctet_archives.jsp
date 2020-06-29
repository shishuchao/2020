<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
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
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script language="javascript">
	
function editwppd(wppdid,wppdupid,index,ledgernode){
	var bObject = event.srcElement;
	var tdObject = bObject.parentNode;
	var trObject = tdObject.parentNode;
	var archives_redfile = '<s:property escape="false" value="@ais.workprogram.util.WorkprogramConstant@ARCHIVES_REDFILE"/>'
	var guid="";
    if(wppdupid){
    	guid=wppdupid;
     }else{
    	 guid="<%=new UUID().toString()%>"+index;
     }
	 
	    var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	    if(ledgernode!=null && archives_redfile==ledgernode){

	    	window.open('${contextPath}/commons/file/welcome4wparchives.action?table_name=mng_aud_wp_pro_arch&table_guid=uploadfile_id&guid='+guid+'&param='+rnm+'&deletePermission=true&wppid='+wppdid+"&rowIndex="+trObject.rowIndex,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	    }else{
	    	var viewUrl = '${contextPath}/commons/file/welcome4wparchives.action?table_name=mng_aud_wp_pro_arch&table_guid=uploadfile_id&guid='+guid+'&param='+rnm+'&deletePermission=true&wppid='+wppdid+"&rowIndex="+trObject.rowIndex;
			$('#toUpload').attr("src",viewUrl);
			$('#upload').window('open');
	    	/* window.open('${contextPath}/commons/file/welcome4wparchives.action?guid='+guid+'&param='+rnm+'&deletePermission=true&wppid='+wppdid+"&rowIndex="+trObject.rowIndex,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no'); */
	    }
}

function editUploadFileUrl(rowIndex,filename,fileid){
	var trObject = document.getElementById("archivesdetailTable").rows(rowIndex/1);
	var fileurl="";
    for(var i=0;i<filename.length;i++){
        fileurl+="<a href='${contextPath}/commons/file/downloadFile.action?fileId="+fileid[i]+"'>"+filename[i]+"</a><br/>"
    }
    if(trObject.cells.length==6){
	   trObject.cells(4).innerHTML=fileurl;
    }else{
    	trObject.cells(3).innerHTML=fileurl;
    }    
}
 /*
  * 导出档案文件zip
  */
  function exportArchivesZip(project_id){
		document.getElementById("layerCenter").style.display = "none";
		document.getElementById("layer").style.display = "";
		
		$.ajax({
			url:'${contextPath}/archives/workprogram/pigeonhole/outZip.action',
			type:'POST',
			data:{'project_id':project_id},
			async:false,
			success:function(data){
				var tempZipName = data;
				if(tempZipName!='NO'){
					var url="${contextPath}/archives/workprogram/pigeonhole/exportFileZip.action?project_id=" + project_id + "&tempZipName=" +　tempZipName;
					document.location.href=url;
					document.getElementById("layerCenter").style.display = "";
					document.getElementById("layer").style.display = "none";
				}else{
					alert("文件压缩失败!");
					$.get('${contextPath}/archives/workprogram/pigeonhole/deleteTempZip.action', {'tempZipName':tempZipName});
				}
			}
		});
		function xx(){}
	}
</script>
 <body style="overflow:auto;">
	<div id="layerCenter" >
	 <s:hidden name="project_id" value="${project_id}"/>
		<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
	        <tr>
	            <th style="text-align: center" class="EditHead">审计阶段</th>
	            <th style="text-align: center" class="EditHead">流程节点</th>
	            <th style="text-align: center" class="EditHead" nowrap="nowrap">是否必做</th>
	            <th style="text-align: center" class="EditHead">文件类型</th>
	            <th style="text-align: center" class="EditHead" nowrap="nowrap">审计文书</th>
	            <th style="text-align: center" class="EditHead">操作</th>
	        </tr>
	        <c:forEach items="${projectStageList}" var="projstage">
            <tr>
                 <c:choose>
                  <c:when test="${empty projstage.wppdArchivesList}">
                        <td id="${projstage.stagecode}" rowspan='1' align="left" class="editTd"> ${projstage.stagename} </td>
                  </c:when>
                   <c:otherwise>
                        <td id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdArchivesList)}"></c:out>' align="left" class="editTd"> ${projstage.stagename}</td>
                   </c:otherwise>
                  </c:choose>
               <c:choose>
                   <c:when test="${empty projstage.wppdArchivesList}">
                        <td align="left" class="ListTableTrStageF">&nbsp;</td>
                        <td align="left" class="ListTableTrStageN">&nbsp;</td>
                        <td align="left" class="ListTableTrStageF">&nbsp;</td>
                        <td align="left" class="ListTableTrStageF" nowrap="nowrap">&nbsp;</td>
                        <td align="left" class="ListTableTrStageF">&nbsp;</td>
                   </c:when>
                   <c:otherwise>
                   <c:forEach items="${projstage.wppdArchivesList}" var="wppd" begin="0" end="0">
                        <td style="text-align:left" class="editTd">${wppd.workprogramdetailname}</td>
                        <td style="text-align:center" class="editTd">${wppd.needdo}</td>
                        <td align="left" class="editTd" nowrap="nowrap">
                        <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
                        <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
                        <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
                        <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
                        </td>
                        <%-- td style="text-align:left" class="editTd" nowrap="nowrap">${wppd.uploadFileUrl}</td>
                        <td align="left" class="editTd">
                        	 <a class="easyui-linkbutton" data-options="iconCls:'icon-upload'"onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','','${wppd.ledgernode}')">上传附件1</a>
                        </td> --%>
                        
                    <s:if test="${wppd.workprogramdetailname =='2.2审计实施'}">
						 <td style="text-align:left;width:500" class="editTd" nowrap="nowrap">
							<td style="text-align:left;width:500" class="editTd" nowrap="nowrap">
								<div style="float: left;">
									<div>${wppd.uploadFileUrl}</div>
									<div id="shenjizuFiles_${wppd.projdetailid}"></div>
								</div>
							</td>
						</td>
                          </s:if>
                          <s:else>
                           <td style="text-align:left;width:500" class="editTd" nowrap="nowrap">
							<div id="shenjizuFiles_${wppd.projdetailid}"></div>
						</td>
                    </s:else>
					<td align="left" class="editTd">
						<div id="shenjizuBtn_${wppd.projdetailid}"></div>
					</td>
                        
                        
                        
                   </c:forEach>
                   </c:otherwise>
                </c:choose>
                 </tr>
                <c:if test="${not empty projstage.wppdArchivesList}">
                   <c:if test="${fn:length(projstage.wppdArchivesList)>1}">
                         <c:forEach items="${projstage.wppdArchivesList}" begin="1" var="wppd" varStatus="state">
                         <tr>
                            <td style="text-align:left" class="editTd">${wppd.workprogramdetailname}</td>
                            <td style="text-align:center" class="editTd">${wppd.needdo}</td>
                            <td class="editTd" nowrap="nowrap">
	                        <s:if test="${projstage.stagename=='准备阶段'}">立项性文件</s:if>
	                        <s:if test="${projstage.stagename=='实施阶段'}">证明性文件</s:if>
	                        <s:if test="${projstage.stagename=='报告阶段'}">结论性文件</s:if>
	                        <s:if test="${projstage.stagename=='整改跟踪阶段'}">整改性文件</s:if>
	                        </td>
                           <%--  <td style="text-align:left;width:500" class="editTd" nowrap="nowrap">${wppd.uploadFileUrl }</td>
                            <td align="left" class="editTd">
                           	 <a class="easyui-linkbutton" data-options="iconCls:'icon-upload'"onclick="editwppd('${wppd.projdetailid}','${wppd.uploadfileid}','${state.index}','${wppd.ledgernode}')">上传附件</a>
                            </td> --%>
                            <s:if test="${wppd.workprogramdetailname =='2.2审计实施'}">
								<td style="text-align:left;width:500" class="editTd" nowrap="nowrap">
								<div style="float: left;">
									<div>${wppd.uploadFileUrl}</div>
									<div id="shenjizuFiles_${wppd.projdetailid}"></div>
								</div>
								</td>
                            </s:if>
                            <s:else>
	                            <td style="text-align:left;width:500" class="editTd" nowrap="nowrap">
									<div id="shenjizuFiles_${wppd.projdetailid}"></div>
								</td>
                            </s:else>
                           
							<td align="left" class="editTd">
								<div id="shenjizuBtn_${wppd.projdetailid}"></div>
							</td>
                         </tr>                    
                        </c:forEach>
                    </c:if>
                </c:if>
        </c:forEach>
	         <tr>
          <td align=right  class="EditHead" colspan="6">
          	 <a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="exportArchivesZip('${project_id}')">导出</a>&nbsp;&nbsp;
			 <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWindow()">关闭</a>
          </td>
        </tr>
	     </table>
	  </div>
	  <div id="layer" style="display: none" align="center">
					<img src="${contextPath}/images/uploading.gif">
					<br>
					<br>
					正在压缩档案文件，请稍候......
			</div>
	<div id="upload" title="上传附件" style="overflow:hidden;padding:0px">
		<iframe id="toUpload" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
	<div id="viewYiDian" title="查看疑点" style="overflow:hidden;padding:0px">
		<iframe id="viewYiDianSrc" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
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
	<script type="text/javascript">
	
	$(function(){
		<c:forEach items="${projectStageList}" var="projstage">
			<c:forEach items="${projstage.wppdArchivesList}" var="wppd" >
				$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
					fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
					echoType:2,
					isDel:true,
					isEdit:false,
					uploadFace:1,
					triggerId:'shenjizuBtn'+'_${wppd.projdetailid}'
				});
			</c:forEach>
		</c:forEach>
	});
	
	
	
	function readAudDoudt(doubt_id,contextPath){
		var url = contextPath + "/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
		$('#viewYiDianSrc').attr("src",url);
		$('#viewYiDian').window('open');
	}
	function readMenuScriptMInArchives(menuscript_id,contextPath){
		var url = contextPath+"/operate/manu/viewAll.action?crudId="+menuscript_id;
		$('#viewDiGaoSrc').attr("src",url);
		$('#viewDiGao').window('open');
	}
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
	$('#upload').window({
		width:950, 
		height:450,  
		modal:true,
		collapsible:false,
		maximizable:true,
		minimizable:false,
		closed:true    
	});
	$('#viewYiDian').window({
		width:950, 
		height:450,  
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
	
	function closeWindow() {
		 var curTabId = aud$getActiveTabId();
		 var parentTabId = '${parentTabId}';
		aud$closeTab(curTabId, parentTabId);
	}
	</script>
</html>
