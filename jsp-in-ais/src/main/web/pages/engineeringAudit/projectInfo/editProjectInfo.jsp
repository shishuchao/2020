<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
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
	autoTextarea(isView ?  $('#view_remarks')[0] : $('#proInfo_remarks')[0]);
	autoTextarea(isView ?  $('#view_eaProjectGeneral')[0] : $('#proInfo_eaProjectGeneral')[0]);
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	
	var fileGuid = "${fileGuid}" || "${proInfo.attachmentId}";
	$('#proInfo_attachmentId').val(fileGuid);
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
		$("#proSaveBtn").bind('click', function(){
			
		   	 aud$saveForm('proInfoTemplateForm', "${contextPath}/ea/project/saveProject.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						var pid = data.pid;
						//alert('pid='+pid)
						if(pid){
							 $('#proInfo_pid').val(pid);
						}
						//是否从项目送审窗口打开
						var winSelect = "${winSelect}";
						
						var frameWin = parent.aud$parentDialogWin();
						frameWin.proInfoList.refresh(); 
						
						parent.$('#proApv').data('isload',false);
					 }
				 }
			 });
		});
	}else{
		//$("#proSaveBtn").remove();north
		$('#prolayout').layout('remove', 'north'); 
	}
	$('#prolayout').layout('resize'); 
	
	//处理double金额显示的科学计数法, 并转换成千分位显示
	aud$handleMoneyEFormat("proInfo",["initApvAmount"], isView);	
});

var startDate = "${proInfo.planStartDate}" || "";
var endDate = "${proInfo.planCompleteDate}" || "";
function changeDate() {
    if (startDate.length>0 && endDate.length>0){
        var dateSpan = Date.parse(endDate) - Date.parse(startDate);
        if (dateSpan < 0 ){
            showMessage1("计划开工日期不能晚于计划竣工日期！");
            dateSpan = 0;
        }
        //dateSpan = Math.abs(dateSpan);
        var iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
        $("#proInfo_planLimitDays").val(iDays);
    }
}
function onChangeStartDate(date) {
    startDate = getDate(date);
    changeDate();
}
function onChangeCompleteDate(date){
    endDate = getDate(date);
    changeDate();
}

</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="prolayout" class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
		    <a id='proSaveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>			
		</div>
	</div>
	<div region='center' border='0'>
		<form  id='proInfoTemplateForm' name='proInfoTemplateForm' method="POST" style="border:0px;padding:0px;margin:0px;">
			<input type='hidden' id="proInfo_pid" name="proInfo.pid"  value="${proInfo.pid}" class="noborder editElement clear"/>
			<input type='hidden' id='proInfo_attachmentId' name='proInfo.attachmentId' value="${proInfo.attachmentId}" class="noborder editElement" style='width:500px;'/>    			
			<table class="ListTable" align="center" style='table-layout:fixed;width:100%;border:0px;padding:0px;margin:0px;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>初始批复文号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_initApvNum' name='proInfo.initApvNum' title='初始批复文号' value="${proInfo.initApvNum}" class="noborder editElement clear len50"/>
						<span id='view_initApvNum' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.initApvNum}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>初始批复文件名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_initApvFileName' name='proInfo.initApvFileName' title='初始批复文件名称' value="${proInfo.initApvFileName}"class="noborder editElement clear required len100"/>
						<sapn id='view_initApvFileName' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.initApvFileName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>批复年度</td>
					<td class="editTd" style="width:35%;">
						<s:if test="${view !=true}">
							<select id="apvYear" class="easyui-combobox" name="proInfo.apvYear" style="width:150px;" data-options="panelHeight:'auto',editable:false">
							   <option value="">&nbsp;</option>
							   <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(5,5)">
								 <s:if test="${proInfo.apvYear ==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
								 </s:if>
								 <s:else>
									 <option value="<s:property value="key"/>"><s:property value="value"/></option>
								 </s:else>
							   </s:iterator>
							</select>
						</s:if>
						<s:else>
							<span id='view_apvYear' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.apvYear}</span>
						</s:else>
					</td>
					<td class="EditHead" style="width:15%;">批复单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_apvUnit' name='proInfo.apvUnit' value="${proInfo.apvUnit}" title="批复单位" class="noborder editElement clear len100"/>
						<span id='view_apvUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.apvUnit}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>初始批复金额</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_initApvAmount' name='proInfo.initApvAmount' value="${proInfo.initApvAmount}" title="初始批复金额" class="noborder editElement clear required len50 money"/>
						<span id='view_initApvAmount' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.initApvAmount}</span>元
					</td>
					<td class="EditHead" style="width:15%;">建设单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_constUnit' name='proInfo.constUnit' value="${proInfo.constUnit}" title="建设单位" class="noborder editElement clear len100"/>
						<span id='view_constUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.constUnit}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">施工单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_buildUnit' name='proInfo.buildUnit' value="${proInfo.buildUnit}" title="施工单位" class="noborder editElement clear len100"/>
						<span id='view_buildUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.buildUnit}</span>
					</td>
					<td class="EditHead" style="width:15%;">设计单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_designUnit' name='proInfo.designUnit' value="${proInfo.designUnit}" title="设计单位" class="noborder editElement clear len100"/>
						<span id='view_designUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.designUnit}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">监理单位</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_superUnit' name='proInfo.superUnit' value="${proInfo.superUnit }" class="noborder editElement clear"/>
						<span id='view_superUnit' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.superUnit }</span>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>工程项目编号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_eaProjectNum' name='proInfo.eaProjectNum' value="${proInfo.eaProjectNum}" title="工程项目编号" class="noborder editElement clear required len50"/>
						<span id='view_eaProjectNum' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.eaProjectNum}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>工程项目名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_eaProjectName' name='proInfo.eaProjectName' value="${proInfo.eaProjectName}"  title="工程项目名称" class="noborder editElement clear required len100"/>
						<span id='view_eaProjectName' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.eaProjectName}</span>
					</td>
					<td class="EditHead" style="width:15%;">工程地点</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_eaPlace' name='proInfo.eaPlace' value="${proInfo.eaPlace}" title="工程地点" class="noborder editElement clear len200"/>
						<span id='view_eaPlace' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.eaPlace}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">工程规模</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_eaScale' name='proInfo.eaScale' value="${proInfo.eaScale}" title="工程规模" class="noborder editElement clear len200"/>
						<span id='view_eaScale' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.eaScale}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>工程类型</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_eaType' name='proInfo.eaType' title="工程类型 "  value="${proInfo.eaType}" readonly
						 class="noborder editElement clear"/>
						<input type='hidden' id='proInfo_eaTypeCode' name='proInfo.eaTypeCode' title="工程类型code"  value="${proInfo.eaTypeCode}"
						class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'工程类型选择',
                                  onlyLeafClick:true,
								  param:{
									 'serverCache':false,
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'whereHql':'type=\'6002\'',
				                    'plugId':'6002',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'code'
				                 }                                  
						})"></img>
						<span id='view_eaType' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.eaType}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">工程性质</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_eaProperty' name='proInfo.eaProperty' title="工程性质" value="${proInfo.eaProperty}" readonly
							   class="noborder editElement clear"/>
						<input type='hidden' id='proInfo_eaPropertyCode' name='proInfo.eaPropertyCode' title="工程性质code"  value="${proInfo.eaPropertyCode}"
							   class="noborder editElement clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							  onclick="showSysTree(this,{
                                  title:'工程性质选择',
                                  onlyLeafClick:true,
								  param:{
									 'serverCache':false,
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'whereHql':'type=\'6003\'',
				                    'plugId':'6003',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'code'
				                 }
						})"></img>
						<span id='view_eaPropertyCode' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.eaProperty}</span>
					</td>
					<td class="EditHead" style="width:15%;">建设用地（亩）</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_constLandCount' name='proInfo.constLandCount' title="建设用地"  value="${proInfo.constLandCount}" class="noborder editElement clear len50 double"/>
						<div id='view_constLandCount' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.constLandCount}</div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">建筑面积（平方米）</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_constAreaCount' name='proInfo.constAreaCount' title="建筑面积" value="${proInfo.constAreaCount}" class="noborder editElement clear len50 double"/>
						<span id='view_constAreaCount' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.constAreaCount}</span>
					</td>
					<td class="EditHead" style="width:15%;">计划开工日期</td>
					<td class="editTd" style="width:35%;">
						<div class='editElement'>
							<input type='text' id='proInfo_planStartDate' name='proInfo.planStartDate' title="计划开工日期" value="${proInfo.planStartDate}" class="easyui-datebox noborder  clear" 
							editable="false" data-options="onSelect:onChangeStartDate"/>
						</div>
						<span id='view_planStartDate' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.planStartDate }</span>
					</td>
				<tr>
					<td class="EditHead" style="width:15%;" >计划竣工日期</td>
					<td class="editTd" style="width:35%;">
						<div class='editElement'>
							<input type='text' id='proInfo_planCompleteDate' name='proInfo.planCompleteDate' title="计划竣工日期" value="${proInfo.planCompleteDate}" class="easyui-datebox noborder  clear" 
							editable="false" data-options="onSelect:onChangeCompleteDate"/>
						</div>
						<span id='view_planCompleteDate' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.planCompleteDate}</span>
					</td>
					<td class="EditHead" style="width:15%;">计划工期（天）</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='proInfo_planLimitDays' name='proInfo.planLimitDays' title="计划工期" value="${proInfo.planLimitDays}" class="noborder editElement clear len50 number"/>
						<span id='view_planLimitDays' class="noborder viewElement clear" style='width:50%;display:inline;'>${proInfo.planLimitDays}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" >创建日期</td>
					<td class="editTd" style="width:35%;">
						<span id='proInfo_createTime'  class="noborder editElement clear" datatype='date'>${proInfo.createTime}</span>
						<span id='view_createTime' class="noborder viewElement clear" datatype='date'
							  style='width:50%;display:inline;'>${proInfo.createTime}</span>
					</td>
					<td class="EditHead" style="width:15%;" >最后修改日期</td>
					<td class="editTd" style="width:35%;">
						<span id='proInfo_modifyTime'  class="noborder editElement clear" datatype='date'>${proInfo.modifyTime}</span>
						<span id='view_modifyTime' class="noborder viewElement clear" datatype='date'
						style='width:50%;display:inline;'>${proInfo.modifyTime}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" >工程概况</td>
					<td class="editTd" colspan='3'>
						<textarea type='text' id='proInfo_eaProjectGeneral' name='proInfo.eaProjectGeneral' class="noborder editElement clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${proInfo.eaProjectGeneral}</textarea>
						<textarea id='view_eaProjectGeneral' class="noborder viewElement clear" style='width:100%; height:50px;overflow:auto;;display:inline;'>${proInfo.eaProjectGeneral}</textarea>
					</td>							
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" >备注</td>
					<td class="editTd" colspan='3'>
						<textarea  id='proInfo_remarks' name='proInfo.remarks' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${proInfo.remarks}</textarea>
						<textarea id='view_remarks' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${proInfo.remarks}</textarea>
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