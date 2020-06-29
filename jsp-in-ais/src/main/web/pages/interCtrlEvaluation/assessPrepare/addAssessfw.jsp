<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>确定评价方案添加、修改、查看</title>
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
<script type="text/javascript">
$(function(){
	var isView = "${view}";
	/* autoTextarea(isView ?  $('#view_remarks')[0] : $('#ep_remarks')[0]);
	autoTextarea(isView ?  $('#view_description')[0] : $('#ep_description')[0]); */
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	var projectFormId =  "${projectFormId}";
	$("#sscope_interProId").val(projectFormId);
	var fileGuid = "${fileGuid}";
	$('#ep_attachmentId').val(fileGuid);
	// 附件上传初始化
    $('#'+fileContainer).fileUpload({
        fileGuid:fileGuid,
        isAdd:!isView,
        isEdit:!isView,
        isDel:!isView,
        isView:true,
        isDownload:true,
        isdebug:false
    });
	
	// 根据fileGuid刷新附件列表
	function reloadFile(fileContainer, fileGuid){
        $('#'+fileContainer).fileUpload('property','fileGuid', fileGuid);
		$('#'+fileContainer).fileUpload('reloadFile');
	}
	
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
 
	if(!isView){		
		$("#fwSaveBtn").bind('click', function(){
	/* 	   	 aud$saveForm('sureassessScopeForm', "${contextPath}/intctet/prepare/assessScheme/saveSureScope.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						var formId = data.formId;
						if(formId){
							 $('#sscope_formId').val(formId);
						}
						var frameWin = aud$getTabIframByTabId(parentTabId);
						var winIframe = frameWin.$('#sureFw').get(0).contentWindow;
						winIframe.surefwList.refresh(); 
						aud$closeTab(curTabId, parentTabId);
					 }
				 }
			 }); */
			 
			 var auditCode = document.getElementById('sscope_auditCode').value;
        	 var projectFormId = parent.$('#projectFormId').val();
        	 var flag = ispjdw("${projectFormId}",auditCode);
        	 if(flag== "N" && checkSave()){
        		 alert(checkSave());
        		 alert("ceshiss");
            	 aud$saveForm('sureassessScopeForm', "${contextPath}/intctet/prepare/assessScheme/saveSureScope.action?projectFormId="+projectFormId, function(data){
            		 if(data){
            			data.msg ? showMessage1(data.msg) : null;	
            			if(data.type == 'info'){
            				var formId = data.formId;
    						if(formId){
            					$('#sscope_formId').val(formId);
    						}
    						var frameWin = aud$getTabIframByTabId(parentTabId);
    						var winIframe = frameWin.$('#sureFw').get(0).contentWindow;
    						winIframe.surefwList.refresh(); 
    						aud$closeTab(curTabId, parentTabId);
            			}
            		 }
            	 });
        	 }
        	 if(flag== "Y"){
        		 showMessage1('此项目已经存在此被评价单位!');
				 return false;
        	 }
		});
	}else{
		$("#fwSaveBtn").remove();
	}
	$("#fwCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	$('#eplayout').layout('resize'); 
});

	//根据被评价单位选择带出所在城市和所属板块
	function getCityPlate(){
		var auditCode = document.getElementById('sscope_auditCode').value;
		if (auditCode != ''){
			var result = "";
			$.ajax({
				url:'${contextPath}/intctet/prepare/assessScheme/getcityPlate.action?auditCode='+auditCode,
				//async:false,
				type:'POST',
				success:function(data){
					if(data['success']!=null){
						var text = data['success'];
						var value = text.split("#");
						if(value[0]=="null"){
							$("#sscope_cityName").val("");
						}else{
							$("#sscope_cityName").val(value[0]);
						}
						if(value[1]=="null"){
							$("#sscope_cityCode").val("");
						}else{
							$("#sscope_cityCode").val(value[1]);
						}
						if(value[2]=="null"){
							$("#sscope_tradePlateCode").val("");
						}else{
							$("#sscope_tradePlateCode").val(value[2]);
						}
						if(value[3]=="null"){
							$("#sscope_levelCode").val("");
						}else{
							$("#sscope_levelCode").val(value[3]);
						}
						if(value[4]=="null"){
							$("#sscope_levelName").val("");
						}else{
							$("#sscope_levelName").val(value[4]);
						}
						if(value[5]=="null"){
							$("#sscope_tradePlateName").val("");
						}else{
							$("#sscope_tradePlateName").val(value[5]);
						}
			    		
					}
				}
			});
			return result;
		}
	}

	//  验证同一个项目不能有相同的被审计单位
	function ispjdw(projectFormId,sscope_auditCode){
		var result = "";
		$.ajax({
			url:'${contextPath}/intctet/prepare/assessScheme/ispjdwBypId.action?projectFormId='+projectFormId+'&sscope_auditCode='+sscope_auditCode,
			async:false,
			type:'POST',
			success:function(data){
				if(data.result == 0){
					result= "N";
				}else{
					result= "Y";
				}
			}
		});
		return result;
	}
	
	//保存验证
	function checkSave(){
		var cityName = $("#sscope_cityName").val();
		var tradePlateName = $("#sscope_tradePlateName").val();
		var levelName = $("#sscope_levelName").val();
		if(cityName.replace(/\s+$|^\s+/g,"")==""){
            top.$.messager.alert('警告',"所在城市不能为空，请去组织机构中进行维护!","error");
            return false;
        }
		if(tradePlateName.replace(/\s+$|^\s+/g,"")==""){
            top.$.messager.alert('警告',"所属行业不能为空，请去组织机构中进行维护!","error");
            return false;
        }
		if(levelName.replace(/\s+$|^\s+/g,"")==""){
            top.$.messager.alert('警告',"机构级次不能为空，请去组织机构中进行维护!","error");
            return false;
        }
		return true;
	}
</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
	<body style='padding:0px;margin:0px;overflow:hidden;' id="eplayout" class='easyui-layout' border='0' fit='true'>
	<div region="north" border="0">
 	    <div align = "right">
 	    	<a id='fwSaveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>
            <a id='fwCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a> 
 	   </div>
 	</div>
	<div region='center' border='0'>
		<form  id='sureassessScopeForm' name='sureassessScopeForm' method="POST" >
			<input type='hidden' id="sscope_interProId" name="sscope.interProId"  class="noborder editElement clear" value="${projectFormId}"/>
			<input type='hidden' id="sscope_formId" name="sscope.formId"  class="noborder editElement clear" value="${sscope.formId}"/>  
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>编号</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='sscope_scopecode' name='sscope.scopecode' value="${sscope.scopecode}"
						title='编号' class="noborder clear" readOnly/>
						<span id='view_scopecode' class="noborder  clear" >${sscope.scopecode}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>被评价单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='sscope_auditName' name='sscope.auditName' title="被评价单位" value="${sscope.auditName}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='sscope_auditCode' name='sscope.auditCode' title="被评价单位ID"  value="${sscope.auditCode}"
						class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'被评价单位选择',
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode',
				                  },
				                  onAfterSure:getCityPlate
						})"></img>
						<span id='view_auditName' class="noborder viewElement clear" style='width:50%;display:inline;'>${sscope.auditName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
					<font class="editElement"  color=red>*</font>所在城市
					</td>
					<td class="editTd"  style="width:200px" colspan="1">
					<input type='text' id='sscope_cityName' name='sscope.cityName' title="所在城市" value="${sscope.cityName}"
						 class="noborder editElement clear required" readonly/>
					<span id='view_cityName' name='sscope.cityName' class="noborder viewElement clear" style='width:50%;display:inline;'>${sscope.cityName}</span> 
					<input type='hidden' id='sscope_cityCode' name='sscope.cityCode' title="所在城市code"  value="${sscope.cityCode}"
						class="noborder editElement clear"/>
					</td>
					<td class="EditHead">
						<font class="editElement"  color=red>*</font>所属行业板块
					</td>
					<td class="editTd">
						<input type='hidden' id='sscope_tradePlateCode' name='sscope.tradePlateCode'  title="所属板块code"  value="${sscope.tradePlateCode}" class="noborder editElement clear"/>
						<input type='text' id='sscope_tradePlateName' name='sscope.tradePlateName' title="所属板块" value="${sscope.tradePlateName}"
						 class="noborder editElement clear required" readonly/>
						<span id='view_tradePlateName' class="noborder viewElement clear" style='width:50%;display:inline;'>${sscope.tradePlateName}</span>
					</td>			
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class="editElement"  color=red>*</font>机构级次</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='sscope_levelName' name='sscope.levelName' value="${sscope.levelName}"
						title='机构级次' class="noborder editElement clear required required" readonly/>
						<input type='hidden' id='sscope_levelCode' name='sscope.levelCode'  value="${sscope.levelCode}"
						title='机构级次Code' class="noborder editElement clear required" readonly/>
						<span id='view_levelName' class="noborder viewElement clear" >${sscope.levelName}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap></td>
					<td class="editTd" style="width:35%;">
					</td>
				</tr>
			</table>
		</form>			
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>