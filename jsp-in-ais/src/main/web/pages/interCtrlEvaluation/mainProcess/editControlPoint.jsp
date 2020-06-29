<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-${levelName}</title>
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
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
if("${errMsg}"){
	top.$.messager.alert("提示信息","${errMsg}","error",function(){
		aud$closeTab();
	});
}
$(function(){	
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var parentTabId = '${parentTabId}';	
	isView ?  $('.editElement').hide() : $('.viewElement').hide();	
	
	var textareaIds = ["cpName","ruleAndLaw","testStep","remark"];
	$.each(textareaIds, function(n, tsuffix){		
		autoTextarea(isView ?  $('#view_'+tsuffix)[0] : $('#cp_'+tsuffix)[0]);
	});
	
	var curTabId = aud$getActiveTabId();
	$("#cpCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	if(!isView){
		$('#cpSaveBtn2').bind('click', function(){
			saveCPForm(true);
		});
		$('#cpSaveBtn').bind('click', function(){		
			saveCPForm(false);
		});		
	}else{
		$("#cpSaveBtn,#cpSaveBtn2").remove();
	}
	
	function saveCPForm(isClose){
		 var cpAction = $('#proCp').val() == 'true' ? 'saveProControlPoint' : 'saveControlPoint';
	   	 aud$saveForm('cpForm', "${contextPath}/intctet/mainProcess/"+cpAction+".action", function(data){
			 if(data){
				 data.msg ? showMessage1(data.msg) : null;	
				 if(data.type == 'info'){
					 var cpId = data.cpId;
					 if(cpId){
						 $('#cp_cpId').val(cpId);
					 }
					 try{						 
						 // 刷新${levelName}列表
						 var mainFrameWin = aud$getTabIframByTabId(parentTabId);
						 var controlPointWin = mainFrameWin.$('#rightIfm').get(0).contentWindow;
						 controlPointWin.aud$cpCallbackFn({"id":"${cp.cpCode}"});	
					 }catch(e){ }
					 
					 if(isClose){
						 window.setTimeout(function(){							 
							$("#cpCloseBtn").trigger('click');
						 },0)
					 }
				 }
			 }
		 });
	}

	// 初始化附件上传
    $('#cpAttachment').fileUpload({
    	fileGuid:$('#cp_attachmentId').val(),
        /*
       	文件上传后，回显方式选择， 默认：1
        1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
        2：以文件名列表形式展示，一个文件名称就是一行
        3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
        */
    	echoType:2,
    	// 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
    	uploadFace:1,
        triggerId:'fileUploadBtn',
        isDel:!isView,
        isEdit:!isView
    })
    
    isView ? $('#fileUploadBtn').remove() : null;
	
});
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<<body style='padding:0px;margin:0px;overflow:hidden;' id="cplayout" class='easyui-layout' border='0' fit='true'> 
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;margin:0px;;border-bottom:1px solid #cccccc;width:100%;'>
			<a href="javascript:void(0)" id='cpSaveBtn' class="easyui-splitbutton"   
	        data-options="menu:'#muItem',iconCls:'icon-save'">保存</a>   
			<div id="muItem" style="width:100px;">   
			    <div id='cpSaveBtn2' data-options="iconCls:'icon-save'">保存并关闭</div>
			</div>  
 			<a id='cpCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>
		
	</div>
	<div region='center' border='0' >
		<form id="cpForm" name="cpForm" >
			<input type='hidden' id="proCp" name="proCp" value="${proCp}"/>
			<input type='hidden' id="cp_cpId" name="cp.cpId" value="${cp.cpId}"/>
			<input type='hidden' id="cp_riskCode" name="cp.riskCode" value="${cp.riskCode}"/>
			<table class="ListTable" align="center" style='table-layout:fixed;width:100%;margin-top:-4px;'>
				<tr style="height:0px;">
					<td style="width:15%;"></td><td style="width:35%;"></td>
					<td style="width:15%;"></td><td style="width:35%;"></td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color=red>*</font>${levelName}编号</td>
					<td class="editTd"  colspan="3">
						<input type='text' id='cp_cpCode' name='cp.cpCode' value="${cp.cpCode}" style='border-width:0px;'
						title='${levelName}编号' class="noborder editElement clear required" readonly/>
						<span id='view_cpCode' class="noborder viewElement clear" >${cp.cpCode}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>${levelName}
					</br><font class='editElement' color=red>（1000字以内）</font></td>
					<td class="editTd"  colspan="3">
						<textarea  id='cp_cpName' name='cp.cpName' class="noborder editElement clear len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${cp.cpName}</textarea>
						<textarea id='view_cpName' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${cp.cpName}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>相关制度/规章
					</br><font class='editElement' color=red>（2000字以内）</font></td>
					<td class="editTd" style="width:85%;" colspan="3">
						<textarea  id='cp_ruleAndLaw' name='cp.ruleAndLaw' class="noborder editElement clear len2000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${cp.ruleAndLaw}</textarea>
						<textarea id='view_ruleAndLaw' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${cp.ruleAndLaw}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>控制责任部门</td>
					<td class="editTd" colspan="3">
						<input type='text' id='cp_ctrlDept' name='cp.ctrlDept' value="${cp.ctrlDept}"
						 title='控制责任部门' class="noborder editElement clear" />
						<span id='view_ctrlDept' class="noborder viewElement clear">${cp.ctrlDept}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>控制的重要程度</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='cp_ctrlImportName' name='cp.ctrlImportName' value="${cp.ctrlImportName}"
						title='控制的重要程度' class="noborder editElement clear" readonly/>
						<input type='hidden' id='cp_ctrlImportCode' name='cp.ctrlImportCode'  value="${cp.ctrlImportCode}"
						title='控制的重要程度Code' class="noborder editElement clear" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'控制的重要程度-选择',
				                  onlyLeafClick:true,
				                  queryBox:false,
								  param:{
					                'plugId':'710001',
								    'whereHql':'type=\'710001\'',
								  	'rootParentId':'0',
								  	'customRoot':'控制的重要程度',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'id'
				                  }
						})"></a>
						<span id='view_ctrlImportName' class="noborder viewElement clear" >${cp.ctrlImportName}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap>控制频率</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='cp_ctrlSeqName' name='cp.ctrlSeqName' value="${cp.ctrlSeqName}"
						title='控制频率' class="noborder editElement clear" readonly/>
						<input type='hidden' id='cp_ctrlSeqCode' name='cp.ctrlSeqCode'  value="${cp.ctrlSeqCode}"
						title='控制频率Code' class="noborder editElement clear" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'控制频率-选择',
				                  onlyLeafClick:true,
				                  queryBox:false,
								  param:{
				                    'plugId':'710002',
								    'whereHql':'type=\'710002\'',
								    'customRoot':'控制频率',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'id'
				                  }
						})"></a>
						<span id='view_ctrlSeqName' class="noborder viewElement clear" >${cp.ctrlSeqName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>控制类型</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='cp_ctrlTypeName' name='cp.ctrlTypeName' value="${cp.ctrlTypeName}"
						title='控制类型' class="noborder editElement clear" readonly/>
						<input type='hidden' id='cp_ctrlTypeCode' name='cp.ctrlTypeCode'  value="${cp.ctrlTypeCode}"
						title='控制类型Code' class="noborder editElement clear" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'控制类型-选择',
				                  onlyLeafClick:true,
				                  queryBox:false,
								  param:{
				                    'plugId':'710003',
								    'whereHql':'type=\'710003\'',
								  	'rootParentId':'0',
								  	'customRoot':'控制类型',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'id'
				                  }
						})"></a>
						<span id='view_ctrlTypeName' class="noborder viewElement clear" >${cp.ctrlTypeName}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap>控制方式</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='cp_ctrlModeName' name='cp.ctrlModeName' value="${cp.ctrlModeName}"
						title='控制方式' class="noborder editElement clear" readonly/>
						<input type='hidden' id='cp_ctrlModeCode' name='cp.ctrlModeCode'  value="${cp.ctrlModeCode}"
						title='控制方式Code' class="noborder editElement clear" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'控制方式-选择',
				                  onlyLeafClick:true,
				                  queryBox:false,
								  param:{
				                    'plugId':'710004',
								    'whereHql':'type=\'710004\'',
								  	'rootParentId':'0',
								  	'customRoot':'控制方式',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'id'
				                  }
						})"></a>
						<span id='view_ctrlModeName' class="noborder viewElement clear" >${cp.ctrlModeName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color=red>*</font>适用层级</td>
					<td class="editTd" colspan="3">
						<input type='text' id='cp_levelName' name='cp.levelName' value="${cp.levelName}"
						title='适用层级' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='cp_levelCode' name='cp.levelCode'  value="${cp.levelCode}"
						title='适用层级Code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'适用层级-选择',
				                  onlyLeafClick:true,
				                  queryBox:false,
				                  checkbox:true,
								  param:{
				                    'plugId':'710005',
								    'whereHql':'type=\'710005\'',
								  	'rootParentId':'0',
								  	'customRoot':'适用层级',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'id'
				                  }
						})"></a>
						<span id='view_levelName' class="noborder viewElement clear" >${cp.levelName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color=red>*</font>适用行业板块</td>
					<td class="editTd" colspan="3">
						<input type='text' id='cp_indtSectorName' name='cp.indtSectorName' value="${cp.indtSectorName}"
						title='适用行业板块' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='cp_indtSectorCode' name='cp.indtSectorCode'  value="${cp.indtSectorCode}"
						title='适用行业板块Code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'适用行业板块-选择',
				                  onlyLeafClick:true,
				                  checkbox:true,
				                  queryBox:false,
								  param:{
				                    'plugId':'1025',
								    'whereHql':'type=\'1025\'',
								  	'rootParentId':'0',
								  	'customRoot':'适用行业板块',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_indtSectorName' class="noborder viewElement clear" >${cp.indtSectorName}</span>
					</td>
	
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color=red>*</font>底稿索引</td>
					<td class="editTd" colspan="3">
						<input type='text' id='cp_manuIndex' name='cp.manuIndex' value="${cp.manuIndex}"
						 title='底稿索引' class="noborder editElement clear required" style='border-width:0px;'/>
						<span id='view_ctrlDept' class="noborder viewElement clear">${cp.manuIndex}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color=red>*</font>测试步骤
					</br><font class='editElement' color=red>（2000字以内）</font></td>
					<td class="editTd"  colspan="3">
						<textarea  title="测试步骤" id='cp_testStep' name='cp.testStep' class="noborder editElement clear required len2000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${cp.testStep}</textarea>
						<textarea id='view_testStep' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${cp.testStep}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>备注
					</br><font class='editElement' color=red>（1000字以内）</font></td>
					<td class="editTd"  colspan="3">
						<textarea  id='cp_remark' name='cp.remark' class="noborder editElement clear len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${cp.remark}</textarea>
						<textarea id='view_remark' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${cp.remark}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>附件</br>
						<div id="fileUploadBtn"></div>
					</td>
					<td class="editTd"  colspan="3">
						<input type="hidden" id="cp_attachmentId" name="cp.attachmentId" value="${cp.attachmentId}" />
						<div id="cpAttachment" style="height:150px;overflow:auto;"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />	
</body>
</html>