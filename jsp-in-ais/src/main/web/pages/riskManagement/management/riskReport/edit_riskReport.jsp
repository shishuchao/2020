<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>风险报告</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
   		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	  <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	  
	  
	  <style type="text/css">
/* 浮动最上层 */
#div1 {
	z-index: 2;
}

#div2 {
	z_index: 1;
}
</style>
</head>

<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();sucFun();"  >
	</s:if>
	<s:else>
		<body onload="sucFun();" >
	</s:else>
	<div fit="true" border='0' class='easyui-layout'>
		<div region="center" style="overflow-x:hidden " border='0'>
	<s:form id="riskReportForm" action="saveRiskReport" namespace="/riskManagement/management/riskReport">
	   <div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" >
		<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
			<tr class="EditHead">
			<td  >
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';toSave()">保存</a>&nbsp;&nbsp;
			<s:if test="${ param.todoback ne '1' }">
		   <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location.href='${contextPath}/riskManagement/management/riskReport/riskReportList.action'">返回</a> 
			</s:if>
			<s:else>
			<s:if test="${taskInstanceId!=null&&taskInstanceId>0} || ${todoback == '1' }">
		    <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>		 
			</s:if>
			</s:else> 
			<s:if test="crudObject.id!=null">

				<%@include file="/pages/bpm/list_toBeStart.jsp"%>
			</s:if>
		</td>
	</tr>
			
   </table>

		</div>
		<div style="position:relative;margin-top: 40px;"id="div2">
		<table id="riskReportTable" cellpadding=0 cellspacing=1 border=0  class="ListTable" align="center">

				<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
				<tr >
					<td colspan="4" class=EditHead style="text-align:center" >&nbsp;全面风险管理报告</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">编号</td>
					<td class="editTd" style="width:40%;">
					<s:textfield name="crudObject.serial_num" title="风险编号"  maxlength="50" id="serial_num" cssClass="noborder"/>
						
						</td>
					<td class="EditHead" style="width:10%;"><font color="red">*</font>名称</td>
						<td class="editTd" style="width:40%;">
						<s:textfield name="crudObject.riskReportName" title="风险名称"  maxlength="50" id="riskReportName" cssClass="noborder"/>
						</td>
				</tr>
				
					<tr>
					<td class="EditHead" style="width:15%;"><font color="red">*</font>所属年度</td>
					<td class="editTd" style="width:40%;">	    
						    <select id="year" class="easyui-combobox" name="crudObject.year" style="width:150px;" data-options="panelHeight:'auto',editable:false">
								   <option value="">&nbsp;</option>
								   <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)">
									 <s:if test="${crudObject.year==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
									 </s:if>
									 <s:else>
										 <option value="<s:property value="key"/>"><s:property value="value"/></option>
									 </s:else>
								   </s:iterator>
								</select>		
								    
						</td>
					<td class="EditHead" style="width:10%;">状态</td>
						<td class="editTd" style="width:40%;">
						<s:property value="crudObject.rp_statusName" /> 
						<s:hidden  name="crudObject.rp_statusName"/>
						<s:hidden  name="crudObject.rp_status"/>
						<s:hidden  name="crudObject.id"/>
						<s:hidden name="crudObject.file_id"/>
				        <s:hidden name="crudObject.formId" />
						</td>
				</tr>
				
					<tr>
					<td class="EditHead" style="width:15%;"><font color="red">*</font>编制单位</td>
					<td class="editTd" style="width:40%;">
						<s:buttonText2 cssClass="noborder" id="audit_dept_name" name="crudObject.audit_dept_name" hiddenId="auditDeptId" hiddenName="crudObject.audit_dept" doubleOnclick="showSysTree(this,{
										title:'请选择组织结构',
										defaultDeptId:'${user.fdepid}',
										url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1'
										
									})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" readonly="true" display="${varMap['audit_deptRead']}" doubleDisabled="!(varMap['audit_deptWrite']==null?true:varMap['audit_deptWrite'])" />
						</td>
					<td class="EditHead" style="width:10%;">报告类型</td>
					<td class="editTd" style="width:40%;">
					  <select editable="false" id="reportType" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.reportType" style="width:80%" >
							       <option value="">&nbsp;</option>
							       <s:iterator value="basicUtil.risk_ReportTypeList" id="entry">
							         <option value="<s:property value="code"/>"><s:property value="name"/></option>
							       </s:iterator>
						</select>
						<s:hidden name="crudObject.reportTypeName" id="reportTypeName"/>
						</td>
					
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">编制人</td>
					<td class="editTd" style="width:40%;">
						<s:property value="crudObject.create_author_name" /> 
						<s:hidden name="crudObject.create_author_name"/>
						<s:hidden name="crudObject.create_author"/>
						<s:hidden name="crudObject.createDate"/>
						</td>
					<td class="EditHead" style="width:10%;">编制时间</td>
						<td class="editTd" style="width:40%;">
						<s:property value="crudObject.createDate" /> 
						</td>
				</tr>
				<td class="EditHead" style="width:15%;">报告内容描述</td>
						<td class=editTd colspan="3">
					<s:textarea  id="contentDescription" title="报告内容描述" cssClass="noborder" name="crudObject.contentDescription" rows="6" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
					<input type="hidden" id="crudObject.contentDescription.maxlength" value="1000">
						
						</td>
					
				</tr>	
				<tr>
    				<td class="EditHead">
    					附件
					</td>
    					<td class=editTd colspan="3">
    					<div id="head_${crudObject.file_id}" style="float: left"></div>
    					<div id="content_${crudObject.file_id}" style="float: right"></div>
    				</td>
    			</tr>

		</table>
		
			 <%@include file="/pages/bpm/list_transition.jsp"%> 
		

		<s:hidden name="back"/>
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div> 
		</div>
		</s:form>

	</div>
	<%-- <div region="south" border="0">
		<div id="manu_file" class="easyui-fileUpload"
			data-options="fileGuid:'${crudObject.file_id}',callbackGridHeight:200"></div>
	</div> --%>
</div>
</div>	
	<script type="text/javascript">
	$(function(){
		if('${crudObject.year}' != null){
			$('#year').combobox('select','${crudObject.year}');
		}
		if('${crudObject.reportType}' != null){
			$('#reportType').combobox('select','${crudObject.reportType}');
		}
		
		$("#contentDescription").attr("maxlength",1000); // 
		
		$("#riskReportTable").find("textarea").each(function(){
			autoTextarea(this);
		});
		
		
		 $('#head'+"_${crudObject.file_id}").fileUpload({
				fileGuid:'${crudObject.file_id}' == ''?'1':'${crudObject.file_id}',
				echoType:2,
				isDel:true,
				isEdit:false,
				uploadFace:1,
				triggerId:'content'+'_${crudObject.file_id}'
			});
	});
	
	
	function sucFun(){
		if($("#sucFlag").val()=='1'){
			$("#sucFlag").val('');
			showMessage2('保存成功！');
		 }        		
		}
	function toSubmit(option){	
	    var reportTypeName = 	$('#reportType').combobox('getText'); //报告类型
	    if(reportTypeName != null && reportTypeName != ""){
	    	$('#reportTypeName').val(reportTypeName);
	    }
		var flowForm = document.getElementById('riskReportForm');
			<s:if test="isUseBpm=='true'">
				if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
				{
					var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
					if(actor_name==null||actor_name=='')
					{	
						$.messager.show({title:'提示信息',msg:'下一步处理人不能为空！'});
						return false;
					}
				}
			</s:if>
			parent.$.messager.confirm('确认', '确认提交流程吗？请确认!', function(flag){
				if (flag){
					document.getElementById('submitButton').disabled=true;
					<s:if test="isUseBpm=='true'">
					flowForm.action="<s:url action="submit" includeParams="none"/>";
					</s:if>
					<s:else>
					flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
					</s:else>
					flowForm.submit();
				}else{
					return false;
				}
			});
	}
	
	function toSave(){
		var audit_dept = document.getElementsByName("crudObject.audit_dept")[0].value;
		if(audit_dept==''||audit_dept==null){
			top.$.messager.show({title:'提示信息',msg:'请选择审计单位!'});
			return false;
		}	
		
		var riskReportName=document.getElementById('riskReportName').value;
		if(riskReportName == ''||riskReportName == null){
			$.messager.show({title:'提示信息',msg:'风险报告名称不能为空！'});
			return false;
		}

	    var reportTypeName = 	$('#reportType').combobox('getText'); //报告类型
	    if(reportTypeName != null && reportTypeName != ""){
	    	$('#reportTypeName').val(reportTypeName);
	    }
		
		document.getElementById('riskReportForm').submit();
	}
	
	function doStart(){
		document.getElementById('riskReportForm').action = "start.action";
		document.getElementById('riskReportForm').submit();
	}
	</script>
</body>
</html>