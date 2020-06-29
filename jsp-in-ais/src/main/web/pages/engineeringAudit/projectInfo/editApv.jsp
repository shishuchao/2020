<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<title>工程项目信息添加、修改、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){

	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var curDate = "${curDate}";
	autoTextarea(isView ?  $('#view_apvRemarks')[0] : $('#apv_apvRemarks')[0]);
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	
	var fileGuid = "${fileGuid}" || "${apv.apvAttachmentId}";
	$('#apv_apvAttachmentId').val(fileGuid);
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
		$("#apvSaveBtn").bind('click', function(){			
		   	 aud$saveForm('projectApvForm', "${contextPath}/ea/project/saveApv.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						var apvId = data.apvId;
						if(apvId){
							 $('#apv_apvId').val(apvId);
						}
						var frameWin = aud$parentDialogWin();
						var winIframe = frameWin.$('#proApv').get(0).contentWindow;
    			 		winIframe.projectApvList.refresh(); 
    			 		aud$closeTopDialog();
					 }
				 }
			 });
		});
	}else{
		$("#apvSaveBtn").remove();
	}
	$("#apvCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	$('#apvlayout').layout('resize'); 
	
	//处理double金额显示的科学计数法
	aud$handleMoneyEFormat("apv",["initApvAmount","apvAmountAdd","apvAmountAll"], isView);	
	
	
	$('#apv_apvAmountAdd').bind('change', function(){
		$('#apv_apvAmountAll').val(parseInt($('#apv_initApvAmount').val()) + parseInt($(this).val()));
	});

});
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="apvlayout" class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
			<s:if test="${apv.apvType=='调整' or param.display=='true' }">
		    	<a id='apvSaveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
		    </s:if>
 			<a id='apvCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>
	</div>
	<div region='center' border='0'>
		<form  id='projectApvForm' name='projectApvForm' method="POST" >
			<input type='hidden' id="apv_apvId" name="apv.apvId"  value="${apv.apvId}" class="noborder editElement clear"/>
			<input type='hidden' id="apv_pid" name="apv.pid"  value="${apv.pid}" class="noborder editElement clear"/>
			<input type='hidden' id='apv_apvAttachmentId' name='apv.apvAttachmentId' value="${apv.apvAttachmentId}" 
			class="noborder editElement" style='width:500px;'/>    	
			<input type='hidden' name="apv.constUnit" value="${apv.constUnit}"/>		
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;">批复类型</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_apvType' name='apv.apvType' style='width:100%;border-width:0px;' 
						value="${apv.apvType}" title="批复类型" class="noborder editElement clear len100" readonly/>
						<span id='view_apvType' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvType}</span>
					</td>
					<td class="EditHead" style="width:15%;">初始批复金额</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_initApvAmount' name='apv.initApvAmount' style='width:100%;border-width:0px;' 
						value="${apv.initApvAmount}" title="批复类型" class="noborder editElement clear" readonly/>
						<span id='view_initApvAmount' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.initApvAmount}</span> 元
					</td>			
				</tr>	
				<tr>
					<td class="EditHead" style="width:15%;">初始批复文号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_initApvNum' name='apv.initApvNum' title='初始批复文号'  style='width:100%;border-width:0px;' 
						value="${apv.initApvNum}" class="noborder editElement clear len50" readonly/>
						<span id='view_initApvNum' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.initApvNum}</span>
					</td>
					<td class="EditHead" style="width:15%;">初始批复文件名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_initApvFileName' name='apv.initApvFileName' title='初始批复文件名称' value="${apv.initApvFileName}"
						style='width:100%;border-width:0px;' class="noborder editElement clear len100" readonly/>
						<sapn id='view_initApvFileName' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.initApvFileName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>批复年度</td>
					<td class="editTd" style="width:35%;">
						<input type="text" id='apv_apvYear' name="apv.apvYear" value="${apv.apvYear}" class="noborder editElement clear" style='width:100%;border-width:0px;' readonly/>
						<span id='view_apvYear' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvYear}</span>
					</td>
					<td class="EditHead" style="width:15%;">批复单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_apvUnit' name='apv.apvUnit' value="${apv.apvUnit}" title="批复单位" style='width:100%;border-width:0px;'
						style='width:50%;display:inline;' class="noborder editElement clear " readonly/>
						<span id='view_apvUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvUnit}</span>
					</td>
				</tr>
				<s:if test="${apv.apvType=='调整' or param.display=='true' }">
					<tr>
						<td class="EditHead" style="width:15%;"><font color=red>*</font>追加批复文号</td>
						<td class="editTd" style="width:35%;">
							<input type='text' id='apv_apvNumAdd' name='apv.apvNumAdd' title='追加批复文号' value="${apv.apvNumAdd}" 
							class="noborder editElement required clear len50"/>
							<span id='view_apvNumAdd' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvNumAdd}</span>
						</td>
						<td class="EditHead" style="width:15%;"><font color=red>*</font>追加批复文件名称</td>
						<td class="editTd" style="width:35%;">
							<input type='text' id='apv_apvFileNameAdd' name='apv.apvFileNameAdd' title='追加批复文件名称' value="${apv.apvFileNameAdd}"
							class="noborder editElement clear required len100"/>
							<sapn id='view_initApvFileName' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvFileNameAdd}</span>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%;"><font color=red>*</font>追加批复金额</td>
						<td class="editTd" style="width:35%;">
							<input type='text' id='apv_apvAmountAdd' name='apv.apvAmountAdd' value="${apv.apvAmountAdd}" title="追加批复金额" 
							class="noborder editElement clear required len50 money"/>
							<span id='view_initApvAmount' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvAmountAdd}</span> 元
						</td>
						<td class="EditHead" style="width:15%;">追加批复类型</td>
						<td class="editTd" style="width:35%;">
							<input type='text' id='apv_apvTypeAdd' name='apv.apvTypeAdd' value="${apv.apvTypeAdd}" title="追加批复类型" 
							class="noborder editElement clear len100" readonly/>
							<input type='hidden' id='apv_apvTypeAddCode' name='apv.apvTypeAddCode' value="${apv.apvTypeAddCode}" title="追加批复类型" 
							class="noborder editElement clear len100"/>
							<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
								onclick="showSysTree(this,{
	                                  title:'追加批复类型选择',
	                                  onlyLeafClick:true,
									  param:{
									  	'rootParentId':'0',
					                    'beanName':'CodeName',
					                    'whereHql':'type=\'6009\'',
					                    'plugId':'6009',
					                    'treeId'  :'id',
					                    'treeText':'name',
					                    'treeParentId':'pid',
					                    'treeOrder':'code'
					                 }                                  
							})"></img>
							<span id='view_constUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.apvTypeAdd}</span>
						</td>
					</tr>
				</s:if>
				<tr>
					<td class="EditHead" style="width:15%;">批复总金额</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_apvAmountAll' name='apv.apvAmountAll' value="${apv.apvAmountAll}" title="批复总金额" 
						style='width:100%;border-width:0px;' class="noborder editElement clear len100" readonly/>
						<span id='view_apvAmountAll' class="noborder viewElement clear">${apv.apvAmountAll}</span> 元
					</td>							
					<td class="EditHead" style="width:15%;">工程规模</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='apv_eaScale' name='apv.eaScale' value="${apv.eaScale}" title="工程规模" 
						style='width:100%;border-width:0px;' class="noborder editElement clear len200" readonly/>
						<span id='view_eaScale' class="noborder viewElement clear" style='width:50%;display:inline;'>${apv.eaScale}</span>
					</td>
				</tr>				
				<tr>
					<td class="EditHead" style="width:15%;" >备注</td>
					<td class="editTd" colspan='3'>
						<textarea  id='apv_apvRemarks' name='apv.apvRemarks' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${apv.apvRemarks}</textarea>
						<textarea id='view_apvRemarks' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${apv.apvRemarks}</textarea>
					</td>							
				</tr>							
			</table>	
		</form>			
	</div>
	<div region="south" style="overflow:hidden;" border='0' >
              <div id="edit_attachFile" class="editElement"></div>
              <div id="view_attachFile" class="viewElement"></div>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>