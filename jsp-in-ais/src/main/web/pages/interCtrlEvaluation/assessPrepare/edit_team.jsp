<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目分组</title>
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
	<script type="text/javascript">
	$(function(){
		var isView = "${view}";
		var projectFormId = "${projectFormId}";
		var parentTabId = '${parentTabId}';
		var curTabId = aud$getActiveTabId();
		var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
		isView ?  $('.editElement').hide() : $('.viewElement').hide();
	 	if(!isView){		
			$("#pmgSaveBtn").bind('click', function(){
				 var value = $('#pmg_belongToUnitId').combobox('getText');//项目类别
            	 $("#pmg_belongToUnitName").val(value);
			   	 aud$saveForm('proMemberGroupForm', "${contextPath}/intctet/prepare/assessScheme/saveProteam.action?projectFormId="+projectFormId, function(data){
					 if(data){
						 data.msg ? showMessage1(data.msg) : null;	
						 if(data.type == 'info'){
							var groupId = data.groupId;
							if(groupId){
								 $('#pmg_groupId').val(groupId);
							}
							
							var frameWin = aud$getTabIframByTabId(parentTabId);
							var winIframe = frameWin.$('#proTeam').get(0).contentWindow;
							winIframe.proTeamList.refresh();  
						 }
					 }
				 }); 
			   	 
			});
		}else{
			$("#pmgSaveBtn").remove();
		} 
		$("#pmgCloseBtn").bind('click', function(){
			aud$closeTab(curTabId, parentTabId);
		});
		
		$('#aslayout').layout('resize'); 
	});
	</script>
</head>
<body style="overflow:hidden;">
	<body style='padding:0px;margin:0px;overflow:hidden;' id="eplayout" class='easyui-layout' border='0' fit='true'>
	<div region="north" border="0">
 	    <div align = "right">
 	    	<a id='pmgSaveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>
            <a id='pmgCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a> 
 	   </div>
 	</div>
	<div region='center' border='0'>
		 <form  id='proMemberGroupForm' name='proMemberGroupForm' method="POST" > 
			<input type='hidden' id="pmg_groupId" name="pmg.groupId"  class="noborder editElement clear" value="${pmg.groupId}"/>
			<input type='hidden' id="pmg_projectFormId" name="pmg.projectFormId"  class="noborder editElement clear" value="${projectFormId}"/>
			<input type='hidden' id="pmg_groupType" name="pmg.groupType"  class="noborder editElement clear" value="${pmg.groupType}"/>
			<input type='hidden' id="pmg_groupTypeName" name="pmg.groupTypeName"  class="noborder editElement clear" value="${pmg.groupTypeName}"/>
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>分组名称</td>
					<td class="editTd" style="width:35%;">
					 	<input type='text' id='pmg_groupName' name='pmg.groupName' value="${pmg.groupName}"
						title='分组名称' class="noborder editElement clear required" />
						<span id='view_groupName' class="noborder viewElement clear" >${pmg.groupName}</span>  
						
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>被评价单位</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='pmg_belongToUnitName' name='pmg.belongToUnitName' title="被评价单位" value="${pmg.belongToUnitName}"
						  class="noborder editElement clear required" readonly/>
						 <s:if test="${view != true}">
						 	<select class="easyui-combobox" name="pmg.belongToUnitId" style="width:150px;" id="pmg_belongToUnitId" panelHeight="auto">
							   <option value="">&nbsp;</option>
							   <s:iterator value="mapss">
							       		<s:if test="${pmg.belongToUnitId == key}">
											<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:if>
								 		<s:else> 
											<option value="<s:property value="key"/>"><s:property value="value"/></option>
								 		 </s:else>  
							    </s:iterator> 
							</select>
						 </s:if>
						<s:else>
							<span id='view_belongToUnitName' class="noborder viewElement clear" >${pmg.belongToUnitName}</span>
						</s:else>
					</td>
				</tr>
				
			</table>
		 </form> 		
	  </div>
	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>