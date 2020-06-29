<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>招标信息添加、修改、查看</title>
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
	var pid = "${param.pid}";
	autoTextarea(isView ?  $('#view_remarks')[0] : $('#td_remarks')[0]);
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	
	var fileGuid = "${fileGuid}" || "${td.attachmentId}";
	$('#td_attachmentId').val(fileGuid);
	//alert(fileGuid)
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
		$("#tiSaveBtn").bind('click', function(){
			saveTiForm(false);
		});
		$("#tiSaveBtn2").bind('click', function(){
			saveTiForm(true);
		});
	}else{
		$("#tiSaveBtn, #tiSaveBtn2").remove();
	}
	
	function saveTiForm(isClose){
	   	 aud$saveForm('tenderInfoForm', "${contextPath}/ea/tenderInfo/saveTender.action?pid="+pid, function(data){
			 if(data){
				 data.msg ? showMessage1(data.msg) : null;	
				 if(data.type == 'info'){
					var tdId = data.tdId;
					if(tdId){
						 $('#td_tdId').val(tdId);
					}
					//是否从项目送审窗口打开
					var winSelect = "${winSelect}"; 
					//alert('winSelect='+winSelect) 
					if(winSelect == true || winSelect == 'true'){
						var frameWin = aud$getTabIframByTabId(parentTabId);
						var dvapWin = frameWin.$('#projectInfo').get(0).contentWindow;
						var winIframe = dvapWin.$('#tenderInfo').find('iframe');
						winIframe.get(0).contentWindow.tenderInfoList.refresh(); 
						$("#tiCloseBtn").trigger('click');
					}else{
						frameWin = aud$parentDialogWin();
						var winIframe = frameWin.$('#tenderInfo').get(0).contentWindow;
    			 		winIframe.tenderInfoList.refresh(); 
					}
					
					if(isClose){
					   window.setTimeout(function(){							 
						  $("#tiCloseBtn").trigger('click');
					   },0)
					}
				 }
			 }
		 });
	}
	
	
	$("#tiCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	$('#tilayout').layout('resize'); 
	
	//处理double金额显示的科学计数法
	aud$handleMoneyEFormat("td",["tdControlCost","acceptanceCost"], isView);
});
</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="tilayout" class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'> 			 
			<a id='tiSaveBtn2' class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>	
 			<a id='tiCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>		
 						
		</div>
	</div>
	<div region='center' border='0'>
		<form  id='tenderInfoForm' name='tenderInfoForm' method="POST" style="border:0px;padding:0px;margin:0px;">
			<input type='hidden' id="td_tdId" name="td.tdId"  class="noborder editElement clear" value="${td.tdId}"/>
			<input type='hidden' id="td_pid" name="td.pid"  class="noborder editElement clear" value="${td.pid}"/>   
			<input type='hidden' id='td_attachmentId' name='td.attachmentId' value="${td.attachmentId }"
			 class="noborder editElement" style='width:500px;'/> 			
			<table class="ListTable" align="center" style="table-layout:fixed;width:100%;border:0px;padding:0px;margin:0px;">
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>招标项目编号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='td_tdProjectNumber' name='td.tdProjectNumber' value="${td.tdProjectNumber}"
						title='招标项目编号' class="noborder editElement clear len50 required"/>
						<span id='view_tdProjectNumber' class="noborder viewElement clear" >${td.tdProjectNumber}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>招标项目名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='td_tdProjectName' name='td.tdProjectName' value="${td.tdProjectName}"
						title='招标项目名称' class="noborder editElement clear required"/>
						<span id='view_tdProjectName' class="noborder viewElement len100 clear">${td.tdProjectName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >招标单位</td>
					<td class="editTd" >
						<input type='text' id='td_tdUnit' name='td.tdUnit' title="招标单位" value="${td.tdUnit}"
						 class="noborder editElement clear" />
						 <!-- 
						<input type='hidden' id='td_tdUnitId' name='td.tdUnitId' title="招标单位ID"  value="${td.tdUnitId}"
						class="noborder editElement clear" readonly/>
						<a class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'招标单位选择',
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></a>
						 -->
						<span id='view_tdUnit' class="noborder viewElement clear" >${td.tdUnit}</span>
					</td>
					<td class="EditHead" >招标代理单位</td>
					<td class="editTd" >
						<input type='text' id='td_tdProxyUnit' name='td.tdProxyUnit' value="${td.tdProxyUnit}"
						 title='招标代理单位' class="noborder editElement len100 clear"/>
						<span id='view_tdProxyUnit' class="noborder viewElement clear">${td.tdProxyUnit}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >招标控制价金额</td>
					<td class="editTd" >
						<input type='text' id='td_tdControlCost' name='td.tdControlCost' value="${td.tdControlCost}"
						class="noborder editElement money len20 clear"/>
						<span id='view_tdControlCost' class="noborder viewElement clear" >${td.tdControlCost}</span> 元
					</td>
					<td class="EditHead" >中标金额</td>
					<td class="editTd" >
						<input type='text' id='td_acceptanceCost' 
						name='td.acceptanceCost' class="noborder editElement money len20 clear" value="${td.acceptanceCost}"/>
						<span id='view_acceptanceCost' class="noborder viewElement clear" >${td.acceptanceCost}</span> 元
					</td>
				</tr>
				<tr>
					<td class="EditHead" >发标时间</td>
					<td class="editTd" >
						<span class='editElement'>
							<input type='text' id='td_publishTdTime' name='td.publishTdTime' value="${td.publishTdTime}"
							class="easyui-datebox noborder clear" editable="false"/>
						</span>
						<span id='view_publishTdTime' class="noborder viewElement clear" >${td.publishTdTime}</span>
					</td>
					<td class="EditHead" >招标时间</td>
					<td class="editTd" >
						<span class='editElement'>
							<input type='text' id='td_inviteTdTime' name='td.inviteTdTime' value="${td.inviteTdTime}"
							class="easyui-datebox noborder   clear" editable="false"/>
						</span>
						<span id='view_inviteTdTime' class="noborder viewElement clear">${td.inviteTdTime}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >开标时间</td>
					<td class="editTd">
						<div class='editElement'>
							<input type='text' id='td_startTdTime' name='td.startTdTime' value="${td.startTdTime}"
							class="easyui-datebox noborder clear" editable="false"/>
						</div>
						<span id='view_startTdTime' class="noborder viewElement clear" >${td.startTdTime}</span>
					</td>
					<td class="EditHead" >中标单位</td>
					<td class="editTd">
						<input type='text' id='td_bidUnit' name='td.bidUnit' value="${td.bidUnit}"
						class="noborder editElement len100 clear" editable="false"/>
						<span id='view_bidUnit' class="noborder viewElement clear" >${td.bidUnit}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >创建日期</td>
					<td class="editTd" >
						<span id='td_createTime'  class="noborder editElement clear" datatype='date'>${td.createTime}</span>
						<span id='view_createTime' class="noborder viewElement clear" datatype='date'>${td.createTime}</span>
					</td>
					<td class="EditHead" >最后修改日期</td>
					<td class="editTd" >
						<span id='td_modifyTime'  class="noborder editElement clear" datatype='date'>${td.modifyTime}</span>
						<span id='view_modifyTime' class="noborder viewElement clear" datatype='date'>${td.modifyTime}</span>
					</td>
				<tr>
				<tr>
					<td class="EditHead"  >备注</td>
					<td class="editTd"  colspan='3'>
						<textarea  id='td_remarks' name='td.remarks' class="noborder editElement clear len2000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${td.remarks}</textarea>
						<textarea id='view_remarks' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${td.remarks}</textarea>
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