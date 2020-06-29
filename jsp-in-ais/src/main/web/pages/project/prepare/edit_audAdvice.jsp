<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计通知书</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
</head>

<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body class="easyui-layout" onload="end();" style="overflow: hidden">
</s:if>
<s:else>
	<body class="easyui-layout" onload="start();" style="overflow: hidden">
</s:else>

<div region="north" border="0" style="height:90%;">
	<table class="easyui-datagrid" data-options="fit:true,fitColumns:true,border:false">
		<thead>
			<tr>
				<th data-options="field:'fileType',width:'15%',halign:'center',align:'center'">被审计单位</th>
				<!-- <th data-options="field:'adviceCode',width:'15%',halign:'center',align:'center'">审计通知书编号</th> -->
				<th data-options="field:'fileName',width:'20%',halign:'center',align:'center'">文件名称</th>
				<th data-options="field:'createDate',width:'12%',halign:'center',align:'center'">创建日期</th>
				<th data-options="field:'creator',width:'10%',halign:'center',align:'center'">创建人</th>
				<th data-options="field:'updated',width:'12%',halign:'center',align:'center'">最后编辑日期</th>
				<th data-options="field:'updator',width:'10%',halign:'center',align:'center'">最后编辑人</th>
				<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="audAdviceFiles" status="audAdviceFile">
			<tr>
				<td>${audit_object_name}</td>
				<%-- <td >
				<span id='audadvice_${fileId}'></span>
				</td> --%>
				<td >
				<span title='${fileName}'>${fileName}</span>
				</td>
				<!-- 此次改动是为了解决金格控件出现问题时不显示文件名称，
					如果出现显示文件类型，审计通知书编号和文件名称时则将后面的字段也按照文件名称的写法
					如果再次出现只显示文件类型，审计通知书编号，后面的不显示，则只能说明是金格控件问题    不能修改 -->
				<%-- <td><s:property value="audAdviceFile.fileName" /></td> --%>
				<td>
						<%-- <s:property value="audAdviceFile.fileTime"/> --%>
						<span title="${fileTime}">${fileTime}</span>
					</td>
				<td>
					
							<span title="${uploader_name}">${uploader_name}</span>
					</td>
				<td>
					
						<span title="${fileEditTime}">${fileEditTime}</span>
					</td>
				<td>
			     	<span title="${remark_name}">${remark_name}</span>
			
					</td>
				<td>
					<s:if test="${projectStartObject.archives_closed != 1 && approveFlag==1}">
						<a href="javascript:;" onclick="showTemplateList('${fileId}','${audit_object_name}')">创建</a>
						<s:if test="fileTime!=null">
							<a href="javascript:;" onclick="editurl('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="fileId"/>')">编辑</a>
						</s:if>
					</s:if>
					<s:if test="fileTime!=null">
						<%-- <a href="javascript:;" onclick="editurl('${contextPath}/commons/file/downloadFile.action?fileId=<s:property value="fileId"/>')">下载</a> --%>
						<a href="javascript:;" onclick="editurl('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=<s:property value="fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
					</s:if>
				</td>
			</tr>
			</s:iterator>
		</tbody>
	</table>
	<div id="accelerys" align="center">
		<s:property escape="false" value="qitafujian" />
	</div>
</div>


<div region="center" style="width:100%;" border="0" >
	<s:form id="projectAudAdviceForm" action="save" namespace="/project/prepare/audAdvice">
		<s:hidden name="crudObject.formId" />
		<s:hidden name="crudObject.project_id" />
		<s:hidden name="crudObject.audAdvice_file_id" />
		<s:hidden name="crudObject.projectName" />
		<s:hidden name="processName" />
  	  	<s:hidden name="project_name" />
  	  	<s:hidden name="formNameDetail" />
		<input type="hidden" name="view" value="${param.view }"/>
	   <s:if test="${taskInstanceId ne -1}">
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>
		</s:if>
		<br />
		<div align="center">
			<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
		</div>
		<%-- <s:if test="${param.view ne 'view'}">
			<div align="right" style="padding-right:10px;">
				<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
			</div>
		</s:if> --%>

	</s:form>
</div>


<script type="text/javascript">
	/*
	 * 创建审计通知书
	 */
	function doStart(){
		document.getElementById('projectAudAdviceForm').action = "start.action";
		document.getElementById('projectAudAdviceForm').submit();
	}
	/*
		上传其它审计报告附件
	 */
	function Upload(id, filelist) {
		var num = Math.random();
		var rnm = Math.round(num * 9000000000 + 1000000000);/*随机参数清除模态窗口缓存*/
		window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="crudObject.qitafujian"/>&&param=' + rnm + '&&deletePermission=<s:property value="%{varMap.deleteuploadqitafujianRead}"/>&&isEdit=<s:property value="%{varMap.edituploadqitafujianRead}"/>&&title=' + encodeURI(encodeURI("其它审计附件信息")), accelerys, 'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	/*
	* 流程启动前提示和检验
	*/	
	function beforStartProcess(){
		if('<s:property value="approveFlag" />'!='1'){
			top.$.messager.alert('警告','只有项目组长、副组长、主审、负责人才可以提交!','info');
			return false;
		}else{
			return true;
		}
	}	
	
	/*
	 * 提交流程表单
	 */
	function toSubmit() {
		var fileName = "${audAdviceFile.fileName}";
		if(fileName == null ||fileName == ""){
			top.$.messager.alert('警告','审计通知书必须创建!','info');
			return false;
		}
		top.$.messager.confirm('确认','您确认提交吗?',function(r){
		    if (r){    
		    	document.getElementById('submitButton').disabled = true;
				var startForm = document.getElementById('projectAudAdviceForm');
				<s:if test="isUseBpm=='true'">
					if($("#transitionDiv").children("select").length>0||$("#transitionDiv").children("input").length>0){
						var toactorid=document.getElementsByName('formInfo.toActorId')[0].value;
					      if(toactorid == ""||toactorid ==null){
					    	  $.messager.alert('警告','下一步处理人不能为空！!','info');
					    	  document.getElementById('submitButton').disabled = false;
					    	  return false;
					      }				
					}
				startForm.action = "<s:url action="submit" includeParams="none"/>";
				</s:if>
				<s:else>
				startForm.action = "<s:url action="directSubmit" includeParams="none"/>";
				</s:else>
				startForm.submit();
		    } else{
		    	return false;
		    }   
		}); 
	}
	//审计通知书模板列表
	function showTemplateList(fileId, audit_object_name){
		// 初始化生成表格
		$('#templateList').datagrid({
			url : "<%=request.getContextPath()%>/project/prepare/audAdvice/templateList.action?crudId=${crudId}&project_id=${project_id}&taskInstanceId=${taskInstanceId}",
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
						var link = '<a href=\"javascript:void(0);\" onclick=\"createshenjitongzhishu(\''+row.templateId+'\',\''+fileId+'\',\''+audit_object_name+'\');\">选择模板</a>';
						return link;
					}
				}
			]]
		});

		$('#templateWindow').window({
			title:'选择审计通知书模板',
			width:600,
			height:400,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false
		});
	}
	function createshenjitongzhishu(templateId,fileId,audit_object_name){
		var flag = true;
		$.ajax({
			   type: "POST",
			   async: false,
			   url: "${contextPath}/project/prepare/audAdvice/checkCreator.action",
			   data: {"project_id":"${project_id}"},
			   success: function(reV){
					if(reV=='suc'){
						
					}else{
						top.$.messager.alert('警告','只有项目组长、主审才可以创建!','info');
						flag = false;
						return false;
					}
			   }
			});	
		if(flag){
			top.$.messager.confirm('确认对话框','确定要使用此模板创建审计通知书吗？之前创建的审计通知书内容将全部丢失!',function(r){
				if(r){
					//var h = window.screen.availHeight;
					//var w = window.screen.width;
				//	window.showModalDialog("${contextPath}/project/prepare/audAdvice/edit!createAudAdvice.action?audit_object_name="+encodeURI(audit_object_name)+"&fileId="+fileId+"&crudId=${crudId}&project_id=${project_id}&taskInstanceId=${taskInstanceId}&templateId="+templateId,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
					var link = "${contextPath}/project/prepare/audAdvice/edit!createAudAdvice.action?audit_object_name="+encodeURI(audit_object_name)+"&fileId="+fileId+"&crudId=${crudId}&project_id=${project_id}&taskInstanceId=${taskInstanceId}&templateId="+templateId;   
				    var udswin = window.open(link, '','height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

				    udswin.moveTo(0, 0);
				    udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
				}
			});
		}else{
			return false;
		}
	}

	function editurl(url){
		window.open(url,"", "width="+screen.availWidth +"px,height="+screen.availHeight +"px,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no");

	}

	/*
	* 流程启动前提示和检验
	*/
	function beforStartProcess(){
		var fileName = "${audAdviceFile.fileName}";
		if(fileName == null ||fileName == ""){
			top.$.messager.alert('警告','审计通知书必须创建!','info');
			return false;
		}
		return true;
	}	
	var audit_objects = '${projectStartObject.audit_object}'.split(',');
	if('${crudObject.audAdvice_file_id}'.indexOf('_') != -1) {
		for(i in audit_objects) {
			$('#audadvice_' + audit_objects[i] + '_${projectStartObject.formId}').text('${projectStartObject.audit_notice_code}');
			$('#audadvice_' + audit_objects[i] + '_${projectStartObject.formId}').attr('title','${projectStartObject.audit_notice_code}');
		}
	} else {
		$('#audadvice_${crudObject.audAdvice_file_id}').text('${projectStartObject.audit_notice_code}');
		$('#audadvice_${crudObject.audAdvice_file_id}').attr('title','${projectStartObject.audit_notice_code}');
	}
	
   $('#audadvice').text('${projectStartObject.audit_notice_code}');
   $('#audadvice').attr('title','${projectStartObject.audit_notice_code}')
</script>
	<!-- 创建审计通知书 -->
<div id="templateWindow">
	<table id="templateList"></table>
</div>
</body>
</html>
