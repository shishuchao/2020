<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>工作方案明细列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<s:head theme="ajax" />
<script language="javascript">

</script>
</head>
<body class="easyui-layout">
	<div region="center" fit="true" >
		<div class="easyui-panel" style="overflow:hidden;width:100%;padding:0px;height: 35%" title="补充性审计文书">
			<s:form id="workprogramDetailForm" action="saveWorkprogramDetail" namespace="/workprogram">
			    <s:hidden name="projectid" value="${projectid}"/>
			    <table id="workprogramdetailTable"  class="ListTable_change" align="center" style="width:100%;">
			        <tr>
			            <td align="left" style="display:none" class="EditHead">阶段名称</td>
			            <td align="left" class="EditHead"  style='text-align:left;' nowrap>流程节点</td>
			            <td align="left" class="EditHead"  style='text-align:left;' nowrap>是否必做</td>
			            <td align="left" class="EditHead"  style='text-align:left;' nowrap>对应模板</td>
			            <td align="left" class="EditHead"  style='text-align:left;' nowrap>阶段性文书</td>
			        </tr>
			        <c:forEach items="${projectStageList}" var="projstage">
			            <tr>
			                 <c:choose>
			                  <c:when test="${empty projstage.wppdList}">
			                        <td style="display:none" id="${projstage.stagecode}" rowspan='1' align="left" class="EditHead"> ${projstage.stagename} </td>
			                  </c:when>
			                   <c:otherwise>
			                        <td style="display:none" id="${projstage.stagecode}" rowspan='<c:out value="${fn:length(projstage.wppdList)}"></c:out>' align="left" class="EditHead"> ${projstage.stagename}</td>
			                   </c:otherwise>
			                  </c:choose>
			               <c:choose>
			                   <c:when test="${empty projstage.wppdList}">
			                        <td align="left" class="EditHead">&nbsp;</td>
			                        <td align="left" class="EditHead">&nbsp;</td>
			                        <td align="left" class="EditHead">&nbsp;</td>
			                        <td align="left" class="EditHead">&nbsp;</td>
			                   </c:when>
			                   <c:otherwise>
			                   <c:forEach items="${projstage.wppdList}" var="wppd" begin="0" end="0">
			                        <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
			                        <td align="left" class="editTd">${wppd.needdo}</td>
			                       <td align="left" class="editTd">${wppd.templateFileUrl}</td> 
			                        <td class="editTd" style="text-align: left;">
										<div id="shenjizuFiles_${wppd.projdetailid}"></div>
									</td>
									 <s:if test="${param.view ne 'view' }">
			                           <td class="editTd" style="text-align: center;" hidden="true">
			                        	<div id="shenjizuBtn_${wppd.projdetailid}"></div> 
			                           </td>
			                        </s:if>	
			                   </c:forEach>
			                   </c:otherwise>
			                </c:choose>
			                 </tr>
			                <c:if test="${not empty projstage.wppdList}">
			                   <c:if test="${fn:length(projstage.wppdList)>1}">
			                         <c:forEach items="${projstage.wppdList}" begin="1" var="wppd" varStatus="state">
			                         <tr>
			                            <td align="left" class="editTd">${wppd.workprogramdetailname}</td>
			                            <td align="left" class="editTd">${wppd.needdo}</td>
			                            <td align="left" class="editTd">${wppd.templateFileUrl}</td> 
				                        <td class="editTd" style="text-align: left;">
											<div id="shenjizuFiles_${wppd.projdetailid}"></div>
										</td>
										 <s:if test="${param.view ne 'view' }">
			                               <td class="editTd" style="text-align: center;" hidden="true">
			                        	     <div id="shenjizuBtn_${wppd.projdetailid}"></div>
			                        	   </td>
			                              </s:if>
			                         </tr>                    
			                        </c:forEach>
			                    </c:if>
			                </c:if>
			        </c:forEach>
			    </table>
			</s:form>
		</div>
		<div style='height:65%;width:100%;padding:0px;'  class="easyui-panel" title="整改跟踪信息">
			 <table id='trackList'>
			</table> 
		</div>
		<div id="planName" title=" " style="overflow:hidden;padding:0px">
	            <iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
  	</div>
	<script type="text/javascript">

	$(function(){
		<c:forEach items="${projectStageList}" var="projstage">
			<c:forEach items="${projstage.wppdList}" var="wppd" >
				$('#shenjizuFiles'+"_${wppd.projdetailid}").fileUpload({
					fileGuid:'${wppd.uploadfileid}'==''?'${wppd.projdetailid}':'${wppd.uploadfileid}',
					echoType:2,
					isDel:false,
					isEdit:false,
					uploadFace:1,
					triggerId:'shenjizuBtn'+'_${wppd.projdetailid}'
				});
			</c:forEach>
		</c:forEach>
	});
			
			$(function(){
				$('#trackList').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/auditTrackingList.action?querySource=grid&project_id=${project_id}&isrework=true&permission=full&view=view",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					selectOnCheck:false,
					columns:[[
						/*{field:'id',title:'主键',width:'50', hidden:true, align:'center'},*/
						{field:'serial_num',title:'问题编号',align:'center',width:'10%', sortable:true},
						{field:'problem_all_name',title:'问题类别',width:'13%',sortable:true, halign:'center',align:'left'},
						{field:'problem_name',title:'问题点',width:'12%', halign:'center',align:'left',sortable:true,
                            formatter:function(value,row,index){
                                return '<a href=\"javascript:void(0)\" onclick=\"toOpenProblemWindow(\''+row.manuscript_id+'\',\''+row.id+'\',\''+row.project_id+'\');\">'+row.audit_con+'</a>';
                            }
						},
						{field:'problem_money',title:'涉及金额(万元)',width:'7%', halign:'center',align:'right',sortable:true,
							formatter:aud$gridFormatMoney
						},
						{field:'problemCount',title:'发生数量(个)',sortable:true,width:'7%', halign:'center',align:'right',
                            formatter:function(value,row,index){
                                return value ? "<label title='"+value+"'>"+value+"</label>" : 0;
                            }
						},
						{field:'problem_grade_name',title:'审计发现类型', width:'10%', halign:'center',align:'left',sortable:true},
						{field:'examine_creater_name',title:'监督检查人', width:'10%', halign:'center',align:'left',sortable:true},
						{field:'mend_state',title:'整改状态', width:'10%', halign:'center',align:'left',sortable:true},
						{field:'operate',title:'整改跟踪',align:'center',width:'10%',
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.id+'\');\">信息跟踪</a>';
					}	
						}
					]]   
				}); 
				
			});
			function trackInfo(id){
				var project_id = '${project_id}';
				var permission = '${permission}';
				var interaction = '${interaction}';
				var idEdit = '${isEdit}';
				var trackUrl = "${contextPath}/proledger/problem/editAudTrackingLedger.action?id="+id+"&project_id=${project_id}&isEdit=${isEdit}&permission=${permission}&interaction=${interaction}&wpd_stagecode=${wpd_stagecode}&view=${param.view}";
				$('#showPlanName').attr("src",trackUrl);
	            $('#planName').window('open');
			}
			$('#planName').window({
	            width:1000, 
	            height:500,  
	            modal:true,
	            collapsible:false,
	            maximizable:true,
	            minimizable:false,
	            closed:true,
	            maximized:true
	        });
			function closeWin(){
				$('#planName').window('close');
			}
			function saveCloseWin(){
				$('#planName').window('close');
				showMessage2("保存成功！");
			}
			function toOpenProblemWindow(manuscript_id, problemId, projectId){
				//var viewSjwtUrl  = "${contextPath}/proledger/problem/view.action?manuscript_id=" + manuscript_id + "&isView=true&id=" + problemId + "&interaction=${interaction}&project_id=" + projectId;
				var viewSjwtUrl  = "${contextPath}/proledger/problem/viewMiddle.action?id=" + problemId + "&interaction=${interaction}&project_id=" + projectId;
				aud$openNewTab('查看问题',viewSjwtUrl,true);
			}
		</script>
</body>
</html>