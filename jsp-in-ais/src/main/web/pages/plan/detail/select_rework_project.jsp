<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>选择后续项目</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body onload="checkSelectedProject()">
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					选择后续审计项目
				</td>
			</tr>
		</table>
		<div id="listProjectDiv" align="center">
			<display:table id="row" name="reworkProList" pagesize="20"
					class="its" requestURI="${contextPath}/plan/detail/selectReworkProject.action" >
				<display:column title="选择" headerClass="center" style="width:50px;">
					<input type="checkbox" name="project_id" value="${row.formId}" />
					<input type="hidden" id="${row.formId}_name" value="${row.project_name}" />
					<input type="hidden" id="${row.formId}_auditObject" value="${row.audit_object}" />
					<input type="hidden" id="${row.formId}_auditObjectName" value="${row.audit_object_name}" />
				</display:column>
				<display:column title="项目名称" headerClass="center" sortable="true" property="project_name" />
				<display:column title="审计单位" headerClass="center" sortable="true" property="audit_dept_name" />
				<display:column title="被审单位" headerClass="center" sortable="true" property="audit_object_name" />
				<display:column title="启动日期" headerClass="center" sortable="true" property="real_start_time" />
				<display:column title="关闭日期" headerClass="center" sortable="true" property="real_closed_time" />
				<display:column title="项目组长" headerClass="center" sortable="true" property="pro_teamleader_name" />
				<display:setProperty name="paging.banner.placement" value="bottom" />
			</display:table>
		</div>
			
		<div id="buttonDiv" align="right" style="width: 97%">
			<input id="selectButton" type="button" value="确定" onclick="this.style.disabled='disabled';selectFinish()"/>
		</div>
		
		
		<script type="text/javascript">
			/*
				选择后续审计项目
			*/
			function selectFinish(){
				
				var idString = '';
				var nameString = '';
				var auditObjectString = '';
				var auditObjectNameString = '';
				var ids = document.getElementsByName("project_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						idString = idString + ids[i].value + ',';
						nameString = nameString + document.getElementById(ids[i].value+'_name').value + ',';
						auditObjectString = auditObjectString + document.getElementById(ids[i].value+'_auditObject').value + ',';
						auditObjectNameString = auditObjectNameString + document.getElementById(ids[i].value+'_auditObjectName').value + ',';
					}
				}
				if(idString == ''){
					alert('请选择一个项目!');
					return false;
				}
				
				var problemCodes = '${problemCodes}';
				var isHave = 'false';
				var errorMessage = '';
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/plan/detail', action:'isAllProblemHaveProject', executeResult:'false' }, 
					{'problemCodes':problemCodes,'crudObject.reworkProjectIds':idString},
					xxx);
				function xxx(data){
					isHave = data['isHavePlan'];
					errorMessage = data['errorMessage'];
				} 
				if(isHave!='true'){
					alert(errorMessage);
					return false;
				}
				
				window.dialogArguments.document.getElementById('reworkProId').value=idString;
				window.dialogArguments.document.getElementById('reworkProName').value=nameString;
				window.dialogArguments.document.getElementById('audit_object').value=auditObjectString;
				window.dialogArguments.document.getElementById('audit_object_name').value=auditObjectNameString;
				window.close();
			}
			
			/**
			* 页面打开后要选中原来项目中已经选择的项目
			*/
			function checkSelectedProject(){
				
				var reworkProIdString = window.dialogArguments.document.getElementById('reworkProId').value;
				var reworkProCheckboxs = document.getElementsByName('project_id');
				if(reworkProIdString != '' && reworkProCheckboxs != undefined && reworkProCheckboxs.length > 0){
					var reworkProIdArray = reworkProIdString.split(',');
					for(var i=0;i<reworkProCheckboxs.length;i++){
						for(var j=0;j<reworkProIdArray.length;j++){
							if(reworkProCheckboxs[i].value == reworkProIdArray[j]){
								reworkProCheckboxs[i].checked='checked';
							}
						}
					}
					
				}				
				
			}
			
		</script>
		
	</body>
</html>