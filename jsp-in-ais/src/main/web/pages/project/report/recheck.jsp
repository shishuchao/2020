<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>复核审理</title>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<style type="text/css">
  .datagrid-body {
  overflow:hidden;
  }
 /*  审批流中人员的选择需要下拉框 */
 .datagrid-view2 .datagrid-body {
  overflow:auto;
  }

 #projectReportForm .datagrid-view2 .datagrid-body {
  overflow:hidden;
  }
</style>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''&&taskInstanceId!=-1">
	<body class="easyui-layout" onload="end();" style="margin: 0;padding: 0;overflow-y:auto;overflow-x:hidden">
</s:if>
<s:else>
	<body class="easyui-layout" style="margin: 0;padding: 0;overflow:hidden;">
</s:else>
	<s:form id="projectReportForm" action="save" namespace="/project/report" >
		<div align="right" style="width:100%;position:absolute;top:0px;right:10px;text-align: right;z-index: 1000;;">
			<s:if test="${param.view ne 'view' and report_closed ne 1}">
				<s:if test="${taskInstanceId eq 0}">
					<s:if test="${flag eq 1}">
						<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
					</s:if>
				</s:if>
				<s:else>
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
				</s:else>
				</s:if>
			<s:if test="${flag == '1' } && ${param.view !='view'}">
				<a href="javascript:void(0);" id="reportViewSetting" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="reportViewSetting();">设置报告查看权限</a>&nbsp;  
			</s:if>
		</div>
		 <div region='center' border="0" style="margin-top:3%;overflow: hidden;">	
		<table id="tableReport" class="easyui-datagrid" data-options="fit:false,fitColumns:true,nowrap:false,striped:true,border:true" style="width: 100%;" border="0">
			<thead>
				<tr>
					<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1}">
							
					<th data-options="field:'fileType',width:'8%',halign:'center'">文件类型</th>
					<th data-options="field:'fileName',width:'14%',halign:'center'">文件名称</th>
					<th data-options="field:'createDate',width:'8%',halign:'center',align:'center'">创建日期</th>
					<th data-options="field:'creator',width:'5%',halign:'center',align:'center'">创建人</th>
					<th data-options="field:'updated',width:'10%',halign:'center',align:'center'">最后编辑日期</th>
					<th data-options="field:'updator',width:'8%',halign:'center',align:'center'">最后编辑人</th>
					<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
					<th data-options="field:'attachments',width:'18%',halign:'center',align:'left'">附件</td>
					<th data-options="field:'operateattachments',width:'12%',halign:'center',align:'center'">附件操作</td>
					</s:if>
					<s:else>
					<th data-options="field:'fileType',width:'15%',halign:'center'">文件类型</th>
					<th data-options="field:'fileName',width:'13%',halign:'center'">文件名称</th>
					<th data-options="field:'createDate',width:'12%',halign:'center',align:'center'">创建日期</th>
					<th data-options="field:'creator',width:'8%',halign:'center',align:'center'">创建人</th>
					<th data-options="field:'updated',width:'12%',halign:'center',align:'center'">最后编辑日期</th>
					<th data-options="field:'updator',width:'8%',halign:'center',align:'center'">最后编辑人</th>
					<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
					<th data-options="field:'attachments',width:'17%',halign:'center',align:'left'">附件</td>

					
					</s:else>
				</tr>
			</thead>
			<tbody >
				<s:if test="${dinggaoName != null}">
				<tr>
					<td>${dinggaoName}</td>
					<td><s:property value="redinggao.fileName"/></td>
					<td>
							<s:property value="redinggao.fileTime" />
						</td>
					<td>
							<s:property value="redinggao.uploader_name" />
						</td>
					<td>
							<s:property value="redinggao.fileEditTime" />
						</td>
					<td>
							<s:property value="redinggao.remark_name" />
						</td>
					<td>
							<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
						 		<s:if test="varMap['createshenjizuWrite']==null?true:varMap['createshenjizuWrite']">
									<a href="javascript:;" onclick="showTemplateList()">创建</a>
							 	</s:if> 
								<s:if
									test="varMap['editshenjizuWrite']==null?false:varMap['editshenjizuWrite'] && redinggao.fileId != null ">
										<a href="javascript:void(0);"
											onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="redinggao.fileId"/>&reportAutoSaveInterval=${reportAutoSaveInterval}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
								</s:if>
							</s:if>
							<s:if test="redinggao!=null">
								<s:if test="${ flag == '1' || (flag != '1' && viewAuth == '1')}">
									<a href="javascript:void(0);"
										onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="redinggao.fileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									<a href="${contextPath}/commons/file/downloadFile.action?fileId=<s:property value='redinggao.fileId'/>">下载</a>
								</s:if>
							</s:if>
						
					</td>
					<td>
						<div id="shenjizuFiles"></div>
					</td>
					
					<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
					<td>
						<s:if test="varMap['editshenjizuWrite']==null?false:varMap['editshenjizuWrite'] and ${param.view != 'view'}">
							<div id="shenjizuBtn"></div>
						</s:if>
						</td>
					</s:if>
					
				</tr>
				</s:if>
				<s:if test="${shanghuiName != null}">
				<tr>
					<td>${shanghuiName}</td>
					<td><s:property value="shanghui.fileName" /></td>
					<td>
							<s:property value="shanghui.fileTime" />
						</td>
					<td>
							<s:property value="shanghui.uploader_name" />
						</td>
					<td>
							<s:property value="shanghui.fileEditTime" />
						</td>
					<td>
							<s:property value="shanghui.remark_name" />
						</td>
						<td>
							<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
								<s:if test="varMap['createshanghuiWrite']==null?false:varMap['createshanghuiWrite']"> 
									<a href="javascript:;" onclick="createshanghui()">创建</a>
							 	</s:if> 
								<s:if test="varMap['editshanghuiWrite']==null?false:varMap['editshanghuiWrite']">
									<s:if test="shanghui!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="shanghui.fileId"/>&reportAutoSaveInterval=${reportAutoSaveInterval}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
									</s:if>
								</s:if>
							</s:if>
							<s:if test="shanghui!=null">
								<s:if test="${ flag == '1' || (flag != '1' && viewAuth == '1')}">
									<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=<s:property value="shanghui.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									<a href="${contextPath}/commons/file/downloadFile.action?fileId=<s:property value='shanghui.fileId'/>">下载</a>
								</s:if>
							</s:if>
						
					</td>
					<td>
						<div id="shanghuiFiles"></div>
					</td>
					
					<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
					<td>
						<s:if test="varMap['editshanghuiWrite']==null?false:varMap['editshanghuiWrite'] and ${param.view != 'view'}">
							<div id="shanghuiBtn"></div>
						</s:if>
						</td>
					</s:if>
					
				</tr>
				</s:if>
				<s:if test="${shenjijureportName != null}">
				<tr >
					<td>${shenjijureportName}</td>
					<td><s:property value="shenjijureport.fileName" /></td>
					<td>
							<s:property value="shenjijureport.fileTime" />
						</td>
					<td>
							<s:property value="shenjijureport.uploader_name" />
						</td>
					<td>
							<s:property value="shenjijureport.fileEditTime" />
						</td>
					<td>
							<s:property value="shenjijureport.remark_name" />
						</td>
						<td>
						
							<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
								<s:if test="varMap['createshenjijureportWrite']==null?false:varMap['createshenjijureportWrite']"> 
									<a href="javascript:;" onclick="createshenjijureport()">创建</a>
								</s:if> 
								<s:if test="varMap['editshenjijureportWrite']==null?false:varMap['editshenjijureportWrite']">
									<s:if test="shenjijureport!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="shenjijureport.fileId"/>&reportAutoSaveInterval=${reportAutoSaveInterval}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
									</s:if>
								</s:if>
							</s:if>
							<s:if test="shenjijureport!=null">
								<s:if test="${ flag == '1' || (flag != '1' && viewAuth == '1')}">
									<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=<s:property value="shenjijureport.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									<a href="${contextPath}/commons/file/downloadFile.action?fileId=<s:property value='shenjijureport.fileId'/>">下载</a>
								</s:if>	
							</s:if>
						
					</td>
					<td>
						<div id="shenjijureportFiles"></div>
					</td>
					
					<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
					<td>
						<s:if test="varMap['editshenjijureportWrite']==null?false:varMap['editshenjijureportWrite'] and ${param.view != 'view'}">
							<div id="shenjijureportBtn"></div>
						</s:if>
						</td>
					</s:if>
					
				</tr>
				</s:if>
				<s:if test="${juedingshuName != null}">
				<tr>
					<td>${juedingshuName}</td>
					<td><s:property value="juedingshu.fileName" /></td>
					<td>
							<s:property value="juedingshu.fileTime" />
						</td>
					<td>
							<s:property value="juedingshu.uploader_name" />
						</td>
					<td>
							<s:property value="juedingshu.fileEditTime" />
						</td>
					<td>
							<s:property value="juedingshu.remark_name" />
						</td>
					<td>
							<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
								 <s:if test="varMap['createjuedingshuWrite']==null?false:varMap['createjuedingshuWrite']"> 
									<a href="javascript:;" onclick="createjuedingshu()">创建</a>
								 </s:if>
								<s:if test="varMap['editjuedingshuWrite']==null?false:varMap['editjuedingshuWrite']">
									<s:if test="juedingshu!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="juedingshu.fileId"/>&reportAutoSaveInterval=${reportAutoSaveInterval}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
									</s:if>
								</s:if>
							</s:if>
							<s:if test="juedingshu!=null">
								<s:if test="${ flag == '1' || (flag != '1' && viewAuth == '1')}">
									<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=<s:property value="juedingshu.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									<a href="${contextPath}/commons/file/downloadFile.action?fileId=<s:property value='juedingshu.fileId'/>">下载</a>
								</s:if>
							</s:if>
						
					</td>
					<td>
						<div id="juedingshuFiles"></div>
					</td>
					
						<s:if test="${param.view ne 'view' and taskInstanceId ne -1 and report_closed ne 1 and flag eq 1}">
						<td>
							<s:if test="varMap['editjuedingshuWrite']==null?false:varMap['editjuedingshuWrite']">
								<div id="juedingshuBtn"></div>
							</s:if>
							</td>
						</s:if>
					
				</tr>
				</s:if>
			</tbody>
		</table>
		<div class="easyui-panel" border=false style="height: 450px;">
			<div id="proInfoDiv" style="display: none;">
				<jsp:include page="/pages/project/start/edit_start_include.jsp" />
			</div>
			<%-- <s:form id="projectReportForm" action="save" namespace="/project/report"> --%>
				<s:hidden name="crudObject.formId" />
				<s:hidden name="crudObject.sucai" />
				<s:hidden name="crudObject.caogao" />
				<s:hidden name="crudObject.chugao" />
				<s:hidden name="crudObject.nidinggao" />
				<s:hidden name="crudObject.dinggao" />
				<s:hidden name="crudObject.qitafujian" />
				<s:hidden name="crudObject.shanghui" />
				<s:hidden name="crudObject.shenjijureport" />
				<s:hidden name="crudObject.juedingshu" />
		        <s:hidden name="recheck" value="${recheck}"/>
		        <s:hidden name="project_id" value="${crudObject.project_id}"/>
				<s:hidden name="crudObject.qitafujian" />
				<input type="hidden" name="view" value="${param.view }">
				<div align="center">
					<s:if test="${param.taskview ne 'view' and (taskInstanceId ne -1)}">
						<div align="center">
							<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
						</div>
					</s:if>
					<br />
					<%-- <s:if test="${param.view ne 'view' and report_closed ne 1}">
						<div align="right" style="width:97%">
								<s:hidden name="crudObject.qitafujian" />
								<s:if test="${taskInstanceId eq 0}">
									<s:if test="${flag eq 1}">
										<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
									</s:if>
								</s:if>
								<s:else>
									<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
								</s:else>
						</div>
					</s:if> --%>
					<div align="center">
						<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
					</div>
		
				</div>
			<%-- </s:form> --%>
		</div>

		<div id="accelerys" align="center">
			<s:property escape="false" value="qitafujian" />
		</div>
	</div>
		</s:form>
<script type="text/javascript">
function openNewWin(link){
   
    var udswin = window.open(
        link, '','height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

    udswin.moveTo(0, 0);
    udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
   
}
/*
* 创建审计报告定稿
*/
function createdinggao(){
	top.$.messager.confirm('提示信息','确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!',function(isFound){
		if(isFound){
			window.location.href="/ais/project/report/createdinggao.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
		}
	});
}
/*
* 创建审计上会报告
*/
function createshanghui(){
	top.$.messager.confirm('提示信息','确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!',function(isFound){
		if(isFound){
			var h = window.screen.availHeight;
			var w = window.screen.width;
            openNewWin("/ais/project/report/createshanghui.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}");
		}
	});
}
function doStart(){
	if(!AccoutFlowFinished()){
		return false;
	}
	document.getElementById('projectReportForm').action = "start.action";
	document.getElementById('projectReportForm').submit();
}

/**
*	归档提取文档之前校验查询书和取证记录是否完成   by wk 2016-12-13  之前这个校验在台账提交
*/
function AccoutFlowFinished(project_id){
	var flag = true;
	$.ajax({
		type:'get',
		url:'${contextPath}/project/report/checkLedgerProblemsNoOPr.action',
		data:{project_id:'${crudObject.project_id}'},
		dataType:'json',
		async:false,
		cache:false,
		success:function(data){
			if(data.type=='yes'){
				top.$.messager.show({
					title:'提示信息',
					msg:data.Mes,
					width:500,
					height:'auto',
					showType:'slide',
					timeout:5000
				});
				flag = false;
			}
		}
	}); 
	return flag;
}
/*
* 创建审计局报告（签报）
*/
function createshenjijureport(){
	top.$.messager.confirm('提示信息','确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!',function(isFound){
		if(isFound){
			var h = window.screen.availHeight;
			var w = window.screen.width;
           openNewWin("/ais/project/report/createshenjijureport.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}");
		}
	});
}
/*
* 创建审计决定书
*/
function createjuedingshu(){
	 
   //原铁路选择模板创建方式 
   //theTieLuCreatejuedingshu();


	top.$.messager.confirm('提示信息','确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!',function(isFound){
		if(isFound){
			var h = window.screen.availHeight;
			var w = window.screen.width;
            openNewWin("/ais/project/report/createjuedingshu.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}");
		}
	});
}

/** 
原铁路选择模板创建方式 
*/
function theTieLuCreatejuedingshu(){
	var project_name='${crudObject.project_name}';
	var project_id='${crudObject.project_id}';
	var crudId='${crudObject.formId}';
	var taskInstanceId='${taskInstanceId}';
    jQuery.ajax({
			url:'${contextPath}/operate/manuExt/pandManuTem.action?type=decision&project_id=${crudObject.project_id}',
			type:'POST',
			dataType:'text',
			async:false,
			success:function(data){
				if(data == 2) {
					// 初始化生成表格
					$('#templateList').datagrid({
						url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=decision&project_id=${crudObject.project_id}",
						method:'post',
						showFooter:false,
						rownumbers:true,
						striped:true,
						autoRowHeight:false,
						fit: true,
						fitColumns:true,
						idField:'id',
						border:false,
						singleSelect:true,
						remoteSort: false,
						columns:[[
							{field:'name',
								title:'模板名称',
								width:200,
								halign:'center',
								align:'left',
								sortable:true
							},
							{field:'operate',
								title:'操作',
								width:100,
								align:'center',
								formatter:function(value,row,index){
									var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\',\''+crudId+'\',\''+project_name+'\',\''+project_id+'\',\''+taskInstanceId+'\');\">创建</a>';
									return link;
								}
							}
						]]
					});

					$('#templateWindow').window({
						title:'选择审计决定书模板',
						width:600,
						height:400,
						modal:true,
						collapsible:false,
						maximizable:true,
						minimizable:false
					});
				}else if(data == 0){
					showMessage1('请维护对应的模板！');
				}else{
					expManu(data,crudId,project_name,project_id,taskInstanceId);
				}
			},
			error:function(){
				showMessage1('出错啦！');
			}
});
}
/*
 * 创建审计决定书
 */
function expManu(templateId,crudId,project_name,project_id,taskInstanceId){
	top.$.messager.confirm('提示信息','确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!',function(isFound){
		if(isFound){
			var h = window.screen.availHeight;
			var w = window.screen.width;
         openNewWin("/ais/project/report/createjuedingshu.action?templateId="+templateId+"&project_id="+project_id+"&crudId="+crudId+"&taskInstanceId="+taskInstanceId+"&todoback=${todoback}&project_name="+encodeURI(project_name));
			  $("#templateWindow").window({"onOpen":function(){
				 $("#templateWindow").window('close');
			 }});  
			//window.location.href="/ais/project/report/createjuedingshu.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
		}
	});
}

//上传附件
function Upload(id,delete_flag,edit_flag){
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	var rv = window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+id+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,'refresh','dialogWidth:700px;dialogHeight:450px;status:yes');
	if(!rv){
		window.location.reload();
	}else{
		window.location.reload();
	}
}

function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
	top.$.messager.confirm('提示信息','确认删除吗?',function(isDel){
		if(isDel){
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
			{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
			xxx);
			function xxx(data){
			  	window.location.reload();
			}
		}
	});
}
function exportManuscriptUNITERMAll(){
	  $("#dx").attr("src","");
	  var uniterm_url = "${contextPath}/commons/oaprint/exportManuscriptUNITERMAll.action?project_id=${crudObject.project_id}&t="+new Date().getTime();
	  $("#dx").attr("src",uniterm_url); 
}
function exportManuscriptCOMPREHENSIVEAll(){
	 $("#zh").attr("src","");
	 var comprehensive_url = "${contextPath}/commons/oaprint/exportManuscriptCOMPREHENSIVEAll.action?project_id=${crudObject.project_id}";
	 $("#zh").attr("src",comprehensive_url); 
}

/*
* 流程启动前提示和检验
*/
function beforStartProcess(){
	if(!AccoutFlowFinished()){
		return false;
	}
	var iscreateshenjizu = "${varMap['createshenjizuRequired']}";
	var dinggaoId = "${redinggao.fileId}";
	if(iscreateshenjizu == 'true'&& (dinggaoId == null ||dinggaoId == "")){
		showMessage1("${dinggaoName}必须创建!");
		return false;
	}
	
	var isCreateshanghui = "${varMap['createshanghuiRequired']}";
	var shanghuiId = "${shanghui.fileId}";
	if(isCreateshanghui == 'true'&& (shanghuiId == null ||shanghuiId == "")){
		showMessage1("${shanghuiName}必须创建!");
		return false;
	}
	var isCreatesjju = "${varMap['createshenjijureportRequired']}";
	var shenjijuId = "${shenjijureport.fileId}";
	if(isCreatesjju == 'true'&& (shenjijuId == null ||shenjijuId == "")){
		showMessage1("${shenjijureportName}必须创建!");
		return false;
	}
	var isCreatejueding = "${varMap['createjuedingshuRequired']}";
	var juedingId = "${juedingshu.fileId}";
	if(isCreatejueding == 'true'&& (juedingId == null ||juedingId == "")){
		showMessage1("${juedingshuName}必须创建！");
		return false;
	}
	return true;
}

/*
 * 提交流程表单
 */
function toSubmit(){
	if(!AccoutFlowFinished()){
		return false;
	}
	var iscreateshenjizu = "${varMap['createshenjizuRequired']}";
	var dinggaoId = "${redinggao.fileId}";
	if(iscreateshenjizu == 'true'&& (dinggaoId == null ||dinggaoId == "")){
		showMessage1("${dinggaoName}必须创建!");
		return false;
	}
	
	var isCreateshanghui = "${varMap['createshanghuiRequired']}";
	var shanghuiId = "${shanghui.fileId}";
	if(isCreateshanghui == 'true'&& (shanghuiId == null ||shanghuiId == "")){
		showMessage1("${shanghuiName}必须创建!");
		return false;
	}
	var isCreatesjju = "${varMap['createshenjijureportRequired']}";
	var shenjijuId = "${shenjijureport.fileId}";
	if(isCreatesjju == 'true'&& (shenjijuId == null ||shenjijuId == "")){
		showMessage1("${shenjijureportName}必须创建!");
		return false;
	}
	var isCreatejueding = "${varMap['createjuedingshuRequired']}";
	var juedingId = "${juedingshu.fileId}";
 	if(isCreatejueding == 'true'&& (juedingId == null ||juedingId == "")){
		showMessage1("${juedingshuName}必须创建！");
		return false;
	} 

    <s:if test="isUseBpm=='true'">
    if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
        var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
        if(actor_name==null||actor_name==''){
            showMessage1('下一步处理人不能为空！');
            return false;
        }
    }
    </s:if>
    <s:else>
    </s:else>

	top.$.messager.confirm('提示信息','您确认提交吗?',function(isSubmit){
		if(isSubmit){
			document.getElementById('submitButton').disabled=true;
	        var startForm = document.getElementById('projectReportForm');
	        <s:if test="isUseBpm=='true'">
	        startForm.action="<s:url action="submit" includeParams="none"/>";
	        </s:if>
	        <s:else>
	        startForm.action="<s:url action="directSubmit" includeParams="none"/>";
	        </s:else>
			startForm.submit();
		}else{
			return false;
		}
	});
}
	$(function(){
		var report_closed = "${report_closed}";
		if($('#shenjizuFiles').length > 0){
			$('#shenjizuFiles').fileUpload({
				fileGuid:'${crudObject.shenjizu_accessory}',
				echoType:2,
				<s:if test="varMap['editshenjizuWrite']==null?false:varMap['editshenjizuWrite'] && ${param.view !='view'} && ${flag == '1'}">
				isDel:true,
				</s:if>
				<s:elseif test="${viewAuth == '1'}">
				isDel:false,
				isEdit:false,
				</s:elseif>
				<s:else>
				isDel:false,
				isEdit:false,
				isView:false,
				isDownload:false,
				</s:else>
				uploadFace:1,
				triggerId:'shenjizuBtn'
			});
		}
		if($('#shanghuiFiles').length > 0){
			$('#shanghuiFiles').fileUpload({
				fileGuid:'${crudObject.shanghui_accessory}',
				echoType:2,
				<s:if test="varMap['editshanghuiWrite']==null?false:varMap['editshanghuiWrite'] && ${param.view !='view'}  && ${flag == '1'}">
				</s:if>
				<s:elseif test="${viewAuth == '1'}">
				isDel:false,
				isEdit:false,
				</s:elseif>
				<s:else>
				isDel:false,
				isEdit:false,
				isView:false,
				isDownload:false,
				</s:else>
				uploadFace:1,
				triggerId:'shanghuiBtn'
			});
		}
		if($('#shenjijureportFiles').length > 0){
			$('#shenjijureportFiles').fileUpload({
				fileGuid:'${crudObject.shenjijureport_accessory}',
				echoType:2,
				<s:if test="varMap['editshenjijureportWrite']==null?false:varMap['editshenjijureportWrite'] && ${param.view !='view'} && ${flag == '1'}">
				</s:if>
				<s:elseif test="${viewAuth == '1'}">
				isDel:false,
				isEdit:false,
				</s:elseif>
				<s:else>
				isDel:false,
				isEdit:false,
				isView:false,
				isDownload:false,
				</s:else>
				uploadFace:1,
				triggerId:'shenjijureportBtn'
			});
		}
		if($('#juedingshuFiles').length > 0){
			$('#juedingshuFiles').fileUpload({
				fileGuid:'${crudObject.juedingshu_accessory}',
				echoType:2,
				<s:if test="varMap['editjuedingshuWrite']==null?false:varMap['editjuedingshuWrite'] && ${param.view !='view'} && ${flag == '1'}">
				</s:if>
				<s:elseif test="${viewAuth == '1'}">
				isDel:false,
				isEdit:false,
				</s:elseif>
				<s:else>
				isDel:false,
				isEdit:false,
				isView:false,
				isDownload:false,
				</s:else>
				uploadFace:1,
				triggerId:'juedingshuBtn'
			});
		}
	});
	/*
	 * 创建审计报告初稿
	 */
	function createshenjizu(templateId){
		//审计问题一览，如果入报告没处理，对那些问题进行提示，需要进行处理，否则不能创建初稿
		var flag = true;
		$.ajax({
			type:'get',
			url:'${contextPath}/project/report/checkLedgerProblemsNoOPr.action',
			data:{project_id:'${crudObject.project_id}'},
			dataType:'json',
			async:false,
			cache:false,
			success:function(data){
				if(data.type=='yes'){
					top.$.messager.show({
						title:'提示信息',
						msg:data.Mes,
						width:500,
						height:'auto',
						showType:'slide',
						timeout:5000
					});
					flag = false;
				}
			}
		});

		if(flag){
			top.$.messager.confirm('确认对话框','确定要使用此模板创建报告吗？之前创建的报告内容将全部丢失!',function(r){
				if(r){
					var h = window.screen.availHeight;
					var w = window.screen.width;
					var projectName = "${crudObject.project_name}";
                   openNewWin("${contextPath}/project/report/createshenjizu.action?templateId="+templateId+"&crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}&todoback=${todoback}&project_id=${crudObject.project_id}&project_name="+encodeURI(projectName));
				//	window.showModalDialog("/ais/project/report/createjuedingshu.action?        templateId="+templateId+"&project_id="+project_id+"&crudId="+crudId+"&taskInstanceId="+taskInstanceId+"&todoback=${todoback}&project_name="+encodeURI(project_name),window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');

				}
			});
		}else{
			return false;
		}
	}
	//审计报告模板列表
	function showTemplateList(){
		// 初始化生成表格
		$('#templateList').datagrid({
			url : "<%=request.getContextPath()%>/unitary/nc/autoreport/reportTemplateList.action?template.projectTypeCode=${projectStartObject.pro_type},${projectStartObject.pro_type_child}&crudId=${crudObject.formId}&fromType=report",
			method:'post',
			showFooter:false,
			rownumbers:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:true,
			idField:'id',
			border:false,
			singleSelect:true,
			remoteSort: false,
			columns:[[
				{field:'name',
					title:'模板名称',
					width:200,
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'operate',
					title:'操作',
					width:100,
					align:'center',
					formatter:function(value,row,index){
						var link = '<a href=\"javascript:void(0);\" onclick=\"createshenjizu(\''+row.templateId+'\');\">创建报告</a>';
						return link;
					}
				}
			]]
		});

		$('#templateWindow').window({
			title:'选择报告模板',
			width:600,
			height:400,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false
		});
	}
	function reportViewSetting(){
		var project_id='${crudObject.project_id}';
		// 初始化生成表格
		$('#proMembersList').datagrid({
			url : "<%=request.getContextPath()%>/project/getlistMembers.action?querySource=grid&crudId="+project_id,
			method:'post',
			showFooter:true,
			rownumbers:true,
			pagination:false,
			striped:true,
			autoRowHeight:false,
			fit:true,
			idField:'proMemberId',
			fitColumns: false,	
			border:false,
			singleSelect:false,
			remoteSort: false,
			toolbar:[
						{
							id:'ok',
							text:'确认',
							iconCls:'icon-ok',
							handler:function(){
								reportSetting();
							}
						}
					],
			columns:[[
				{field:'proMemberId',title:"复选框", halign:'center',checkbox:true, align:'center'},
				{field:'userName',title:'项目成员',width:'30%',halign:'center',align:'left',sortable:true,
					formatter:function(value,row,index){
						if(row.isOutSystem!='Y') {
							return '<a style="color:blue" onclick="showUser(\''+row.userId+'\');" href="javascript:void(0);">'+value+'</a>&nbsp;';
						}
						return value;
					}
				},
				{field:'roleName',title:'项目角色',width:'30%',halign:'center',align:'left',sortable:true},
				{field:'groupName',title:'所属分组',halign:'center',width:'30%',align:'center',sortable:true},
			]],
			//默认选中有查看权限的审计人员    tyj
			onLoadSuccess:function(){ 
				$.ajax({
					type:'POST',
					url:'${contextPath}/project/report/getHaveSettingShowPerson.action',
					data:{'project_id':'${crudObject.project_id}'},
					dataType:'json',
					async:false,
					cache:false,
					success:function(data){
						if(data.person.length > 0){
							var arr = data.person.split(",");
							for(var i=0;i<arr.length;i++){
								var rows = $('#proMembersList').datagrid("getRows");
								for(var j=0;j<rows.length;j++){
									if(rows[j].userId == arr[i]){
										$('#proMembersList').datagrid('selectRow',j);
									}
								}
							}
						}
					}
				}); 
	        },
		});
		$('#proMembersWindow').window({
			title:'设置报告查看权限',
			width:600,
			height:400,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false
		});
	}
	
	function reportSetting(){
		var selectedRows = $('#proMembersList').datagrid('getChecked');//返回是个数组; 
		if(selectedRows.length>0){
			var ids = "";
			for(var i=0;i<selectedRows.length;i++){
				ids += selectedRows[i].userId + ",";
			}
			$.ajax({
				type:'POST',
				url:'${contextPath}/project/report/reportViewSetting.action',
				data:{'project_id':'${crudObject.project_id}','ids':ids},
				dataType:'json',
				async:false,
				cache:false,
				success:function(data){
					if(data.type == 'ok'){
						showMessage1('设置成功!');
						$('#proMembersWindow').window('close');
					}
				}
			}); 
		}else{
			$.messager.show({title:'提示信息',msg:'请选择审计人员!'});
        	return;
		}
	}
</script>
<div id="templateWindow">
	<table id="templateList"></table>
</div>
<div id="proMembersWindow">
	<table id="proMembersList"></table>
</div>
<iframe id="dx" src="" style="display:none;"></iframe>
<iframe id="zh" src="" style="display:none;"></iframe>
</body>
</html>
