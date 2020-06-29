
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>评价项目报告</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''&&taskInstanceId!=-1">
	<body class="easyui-layout" onload="end();" style="margin: 0;padding: 0;overflow:hidden;" fit="true" border="0">
</s:if>
<s:else>
	<body class="easyui-layout"  style="margin: 0;padding: 0;overflow:hidden;" fit="true" border="0">
</s:else>
<div region="north" style="height:30px;overflow:hidden;" >
	<s:form id="projectReportForm" action="save" namespace="/intctet/evaProjectReport">	
		<s:if test="${view ne 'view' and taskInstanceId ne -1 and evPlan.reportClosed ne 1 and evaluationReport!=null}">
			<div align="right" style="width:100%">
				<s:if test="${taskInstanceId eq 0}">
					<s:if test="${canSubmit eq 'yes'}">
						<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
					</s:if>
				</s:if>
				<s:else>
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
				</s:else>
			</div>
		</s:if>
		<s:hidden name="crudObject.id" />
	    <s:hidden name="project_id" value="${crudObject.project_id}"/>
	    <s:hidden name="crudObject.formId" />
	    <s:hidden name="crudObject.proName" />
	    <s:hidden name="crudObject.creator" />
	    <s:hidden name="crudObject.creatorId" />
		<input type="hidden" name="view" value="${view }">
		
		<!--
			<s:if test="${taskview ne 'view' and (taskInstanceId ne -1)}">
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>
			</s:if>
			<br />
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
		  -->
	</s:form>
</div>
<div region='center' border="0" style='overflow:auto;' split="true">
	<table class="ListTable" align="center" style='table-layout:fixed;width:100%;padding:0px;margin:0px;'>
		<tr style="height:0px;">
			<td style="width:15%;"></td><td style="width:35%;"></td>
			<td style="width:15%;"></td><td style="width:35%;"></td>
		</tr>
		<tr>
			<td class="EditHead" style="width:15%;border-top-width:0px;" nowrap>文件类型</td>
			<td class="editTd" style="width:85%;border-top-width:0px;" colspan="3">
				${jGReportName }
			</td>
		</tr>
		<tr>
			<td class="EditHead" style="width:15%;" nowrap>文件名称</td>
			<td class="editTd" style="width:85%;" colspan="3">
				<s:property value="evaluationReport.fileName"/>
				<s:if test="${view ne 'view' and taskInstanceId ne -1 }">
			 		<s:if test="varMap['createAssessmentReportWrite']==null?false:varMap['createAssessmentReportWrite']">
						<a href="javascript:void(0);" onclick="showTemplateList()">创建</a>
				 	</s:if> 
				 		<s:if test="evaluationReport!=null">
					<s:if test="varMap['editAssessmentReportWrite']==null?false:varMap['editAssessmentReportWrite'] && evaluationReport.fileId != null ">
							<a href="javascript:void(0);"
								onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="evaluationReport.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
					 </s:if>
					</s:if>
				</s:if>
				<s:if test="evaluationReport!=null">
					<a href="javascript:void(0);"
						onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="evaluationReport.fileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
						<a href="${contextPath}/commons/file/downloadFile.action?fileId=<s:property value='evaluationReport.fileId'/>">下载</a>
				</s:if>
			</td>
		</tr>
		<tr>
			<td class="EditHead" style="width:15%;" nowrap>创建人</td>
			<td class="editTd" style="width:35%;">
				<s:property value="evaluationReport.uploader_name" />
			</td>
			<td class="EditHead" style="width:15%;" nowrap>创建日期</td>
			<td class="editTd" style="width:35%;">
				<s:property value="evaluationReport.fileTime" />
			</td>
		</tr>
		<tr>
			<td class="EditHead" style="width:15%;" nowrap>最后编辑人</td>
			<td class="editTd" style="width:35%;">
				<s:property value="evaluationReport.remark_name" />
			</td>
			<td class="EditHead" style="width:15%;" nowrap>最后编辑日期</td>
			<td class="editTd" style="width:35%;">
				<s:property value="evaluationReport.fileEditTime" />
			</td>
		</tr>
		<tr>
			<td class="EditHead" style="width:15%;" nowrap>附件</br>	
				<s:if test="${view ne 'view' and taskInstanceId ne -1}">
		<%-- 			<s:if test="varMap['editshenjizuWrite']==null?false:varMap['editshenjizuWrite'] and ${param.view != 'view'}"> --%>
						<div id="shenjizuBtn"></div>
				<%-- 	</s:if> --%>
				</s:if>
			</td>
			<td class="editTd" style="width:85%;" colspan="3">
				<div id="shenjizuFiles" style="height:100px;overflow:auto;"></div>
			</td>
		</tr>
	</table>
		<!-- 
		<table >
			<thead>
				<tr>
					<s:if test="${view ne 'view' and taskInstanceId ne -1 and evPlan.reportClosed ne 1 }">
					<th data-options="field:'fileType',width:'12%',halign:'center'">文件类型</th>
					<th data-options="field:'fileName',width:'10%',halign:'center'">文件名称</th>
					<th data-options="field:'creator',width:'5%',halign:'center',align:'center'">创建人</th>
					<th data-options="field:'createDate',width:'8%',halign:'center',align:'center'">创建日期</th>
					<th data-options="field:'updator',width:'8%',halign:'center',align:'center'">最后编辑人</th>
					<th data-options="field:'updated',width:'10%',halign:'center',align:'center'">最后编辑日期</th>
					<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
					<th data-options="field:'attachments',width:'19%',halign:'center',align:'left'">附件</td>
					<th data-options="field:'operateattachments',width:'12%',halign:'center',align:'center'">附件操作</td>
					</s:if>
					<s:else>
					<th data-options="field:'fileType',width:'12%',halign:'center'">文件类型</th>
					<th data-options="field:'fileName',width:'15%',halign:'center'">文件名称</th>
					<th data-options="field:'creator',width:'7%',halign:'center',align:'center'">创建人</th>
					<th data-options="field:'createDate',width:'12%',halign:'center',align:'center'">创建日期</th>
					<th data-options="field:'updator',width:'10%',halign:'center',align:'center'">最后编辑人</th>
					<th data-options="field:'updated',width:'10%',halign:'center',align:'center'">最后编辑日期</th>
					<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
					<th data-options="field:'attachments',width:'19%',halign:'center',align:'left'">附件</td>
					</s:else>

				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${jGReportName }</td>
					<td><s:property value="evaluationReport.fileName"/></td>
						<td>
							<s:property value="evaluationReport.uploader_name" />
						</td>
					<td>
							<s:property value="evaluationReport.fileTime" />
						</td>
					<td>
							<s:property value="evaluationReport.remark_name" />
						</td>
					<td>
							<s:property value="evaluationReport.fileEditTime" />
						</td>
				
					<td>

						
					</td>
					<td>
						<div id="shenjizuFiles"></div>
					</td>
					<td>
					<s:if test="${view ne 'view' and taskInstanceId ne -1}">
			<%-- 			<s:if test="varMap['editshenjizuWrite']==null?false:varMap['editshenjizuWrite'] and ${param.view != 'view'}"> --%>
							<div id="shenjizuBtn"></div>
					<%-- 	</s:if> --%>
					</s:if>
					</td>
				</tr>
				</tbody>
				</table>
	
 -->


	<s:if test="${taskview ne 'view' and (taskInstanceId ne -1)}">
		<div align="center">
			<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
		</div>
	</s:if>
	<br />
	<div align="center">
		<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
	</div>
</div>
<div id="templateWindow">
	<table id="templateList"></table>
</div>
</body>
<script type="text/javascript">
$(function(){
	$('#shenjizuFiles').fileUpload({
		fileGuid:'${crudObject.assessmentReportAccessory}',
		echoType:2,
		<s:if test="varMap['editAssessmentReportWrite']==null?false:varMap['editAssessmentReportWrite']">
		</s:if>
		<s:else>
		isDel:false,
		isEdit:false,
		</s:else>
		uploadFace:1,
		triggerId:'shenjizuBtn'
	});
})
  function showTemplateList(){
	// 初始化生成表格
	$('#templateList').datagrid({
		url : "<%=request.getContextPath()%>/unitary/nc/autoreport/reportTemplateList.action?template.projectTypeCode=${evPlan.proCategoryCode}&crudId=${crudObject.formId}&fromType=evaluationReport",
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
					var link = '<a href=\"javascript:void(0);\" onclick=\"createReport(\''+row.templateId+'\');\">创建评价报告</a>';
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
  function createReport(templateId){
	  // 检查点是否已完成
/* 		var flag = true;
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
		if(flag){ */
			top.$.messager.confirm('确认对话框','确定要使用此模板创建评价报告吗？之前创建的评价报告内容将全部丢失!',function(r){
				if(r){
					var h = window.screen.availHeight;
					var w = window.screen.width;
					window.showModalDialog("${contextPath}/intctet/evaProjectReport/createEvaProjectReport.action?templateId="+templateId+"&crudId=${crudObject.id}&taskInstanceId=${taskInstanceId}&todoback=${todoback}&project_id=${crudObject.project_id}&project_name=${crudObject.proName}",window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
				}
			});
		/* }else{
			return false;
		} */
  }
  
   function doStart(){

		document.getElementById('projectReportForm').action = "start.action";
		document.getElementById('projectReportForm').submit();
	} 

	/**
	*	归档提取文档之前校验查询书和取证记录是否完成   by wk 2016-12-13  之前这个校验在台账提交
	*/
	function AccoutFlowFinished(project_id){
		var result = 'YES';
		var messages = '';
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/ledger/prjledger/projectLedgerNew', action:'accoutFlowFinished', executeResult:'false' }, 
			{'projectStartFormId':'${crudObject.project_id}'},
			xxx);
		function xxx(data){
			result = data['accoutFlowFinished'];
			messages = data['messages'];
		} 
		if(result=='YES'){
			return true;
		}else{
			showMessage1(messages);
			return false;
		}
	}
	

	/*
	* 流程启动前提示和检验
	*/
	function beforStartProcess(){
	/* 	if(!AccoutFlowFinished()){
			return false;
		} */
		var iscreateEvaReport = "${varMap['createAssessmentReportRequired']}";
		var dinggaoId = "${evaluationReport.fileId}";
		if(iscreateEvaReport == 'true'&& (dinggaoId == null ||dinggaoId == "")){
			showMessage1("${jGReportName}必须创建!");
			return false;
		}
		

		return true;
	}
	
	/*
	 * 提交流程表单
	 */
	function toSubmit(){
	/* 	if(!AccoutFlowFinished()){
			return false;
		} */
		var iscreateEvaReport = "${varMap['createAssessmentReportRequired']}";
		var shanghuiId = "${evaluationReport.fileId}";
		if(iscreateEvaReport == 'true'&& (shanghuiId == null ||shanghuiId == "")){
			showMessage1("${jGReportName}必须创建!");
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
</script>
</html>