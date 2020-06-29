<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
       <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>风险报告查看</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
</head>
<body>
	<div class='easyui-layout' fit='true' border='0'>
		<div region="center" style="overflow-x:hidden " border='0'>
	<s:form id="riskReportForm" action="saveRiskReport" namespace="/riskManagement/management/riskReport">
				<div border="false" style="text-align:right;padding-right:20px;">
			
			<s:if test="${ param.todoback ne '1' }">
		   <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location.href='${contextPath}/riskManagement/management/riskReport/riskReportList.action'">返回</a> 
			</s:if>
			<s:else>
			<s:if test="${taskInstanceId!=null&&taskInstanceId>0} || ${todoback == '1' }">
		    <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>		 
			</s:if>
			</s:else> 
			<%-- <s:if test="crudObject.id!=null">
				<td>
				<%@include file="/pages/bpm/list_toBeStart.jsp"%>
				</td>
			</s:if> --%>
		</div>
		<table id="riskReportTable" cellpadding=0 cellspacing=1 border=0  class="ListTable" align="center">

				<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
				<tr >
					<td colspan="4" class=EditHead style="text-align:center" >&nbsp;全面风险管理报告</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">编号</td>
					<td class="editTd" style="width:40%;">
							<s:property value="crudObject.serial_num" /> 
						</td>
					<td class="EditHead" style="width:10%;"><font color="red">*</font>名称</td>
						<td class="editTd" style="width:40%;">
							<s:property value="crudObject.riskReportName" /> 
						</td>
				</tr>
				
					<tr>
					<td class="EditHead" style="width:15%;"><font color="red">*</font>所属年度</td>
					<td class="editTd" style="width:40%;">	    
					<s:property value="crudObject.year" /> 	    
						</td>
					<td class="EditHead" style="width:10%;">状态</td>
						<td class="editTd" style="width:40%;">
						<s:property value="crudObject.rp_statusName" /> 
						<s:hidden  name="crudObject.rp_statusName"/>
						<s:hidden  name="crudObject.rp_status"/>
						<s:hidden  name="crudObject.id"/>
						</td>
				</tr>
				
					<tr>
					<td class="EditHead" style="width:15%;"><font color="red">*</font>编制单位</td>
					<td class="editTd" style="width:40%;">
					<s:property value="crudObject.audit_dept_name" /> 	   
						</td>
					<td class="EditHead" style="width:10%;">报告类型</td>
					<td class="editTd" style="width:40%;">
				
							<s:property value="crudObject.reportTypeName" /> 	
						</td>
					
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">编制人</td>
					<td class="editTd" style="width:40%;">
						<s:property value="crudObject.create_author_name" /> 
						<s:hidden name="crudObject.create_author_name"/>
						<s:hidden name="crudObject.create_author"/>
						</td>
					<td class="EditHead" style="width:10%;">编制时间</td>
						<td class="editTd" style="width:40%;">
						<s:property value="crudObject.createDate" /> 
						</td>
				</tr>
				<td class="EditHead" style="width:15%;">报告内容描述</td>
						<td class=editTd colspan="3">
						<s:textarea  id="contentDescription" title="报告内容描述" cssClass="noborder" name="crudObject.contentDescription" rows="6" cssStyle="width:100%;overflow:hidden;line-height:150%;" readonly="true"/>
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
				<s:hidden name="crudObject.file_id"/>
		</table>
			 <%@include file="/pages/bpm/list_transition.jsp"%> 
		

		<s:hidden name="back"/>
			<%-- <div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>  --%>
		</s:form>

	</div>
<%-- 	 <div region="south" border="0">
				<div id="manu_file" class="easyui-fileUpload" data-options="fileGuid:'${crudObject.file_id}',isAdd:false,isEdit:false,isDel:false,callbackGridHeight:200"></div>

	 </div> --%>
</div>
</div>	
<script type="text/javascript">
  $(function(){
		 $('#head'+"_${crudObject.file_id}").fileUpload({
				fileGuid:'${crudObject.file_id}' == ''?'1':'${crudObject.file_id}',
				echoType:2,
				isAdd:false,
				isDel:false,
				isEdit:false,
				uploadFace:1,
				triggerId:false
			});
  })


</script>
</body>
</html>