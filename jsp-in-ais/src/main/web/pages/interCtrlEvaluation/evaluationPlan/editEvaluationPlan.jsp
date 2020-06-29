<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>评价项目计划添加、修改、查看</title>
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
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	/* 备注和描述输入框自扩展 */
	autoTextarea(isView ?  $('#view_remarks')[0] : $('#crudObject_remarks')[0]);
	autoTextarea(isView ?  $('#view_description')[0] : $('#crudObject_description')[0]);
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	
	var fileGuid = "${fileGuid}" || "${crudObject.attachmentId}";
	$('#crudObject_attachmentId').val(fileGuid);
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
 	/* 不走流程的时候的保存方法 */
	if(!isView){		
		$("#epSaveBtn").bind('click', function(){
			 var proCategoryValue = $('#crudObject_proCategoryCode').combobox('getText');//项目类别
        	 $("#crudObject_proCategory").val(proCategoryValue);
			 var workprogramid=$("#workprogramid").val();
			 if(workprogramid==""){
				 showMessage1("请维护对应项目类别的工作方案")
				 return false;
			 }
			 if (!checkForm()){
			 	return  false;
			 }
			 evaPlanForm.action = "${contextPath}/intctet/evaProject/evaPlan/saveEvaPlan.action?workprogramid="+workprogramid;
			 evaPlanForm.submit();
		   	 /* aud$saveForm('evaPlanForm', "${contextPath}/intctet/evaProject/evaPlan/saveEvaPlan.action?workprogramid="+workprogramid, function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						$('#crudObject_proCode').val(data.proCode);
						//aud$getTabIframByTabId(parentTabId).evaluationPlanList.refresh(); 
						aud$parentDialogWin().evaluationPlanList.refresh();
						$("#epCloseBtn").trigger('click');
					 }
				 }
			 }); */
		});
	}else{
		$("#epSaveBtn").remove();
	}
 	
	$("#epCloseBtn").bind('click', function(){
		if(isView){
			aud$closeTab(curTabId, parentTabId);
		}else{
			aud$parentDialogWin().refresh();
			aud$closeTab(curTabId, parentTabId);
		}
	});
	
	$('#eplayout').layout('resize'); 

	$("#crudObject_proCategoryCode").combobox({
		onChange:function(newOption,oldOption){
			projectTypeChangeHandler(newOption,oldOption);
		}	
	})
	
	if("${taskInstanceId}" == "0" && "${crudObject.epStatus}" >= 2){
		$("#submitButton").hide();
	}
	
	$('#crudObject_proCategoryCode').combobox("setValue", "${crudObject.proCategoryCode}");
	if(!"${crudObject.proCode}"){		
		$('#epYear').combobox('setValue','${curYear}');
		$('#epMonth').combobox('setValue','${curMonth}');
	}
	
});
/* 显示工作方案 */
function showWorkProgram(){
    var wpid = document.getElementsByName("workprogramid");
    //如果有子项
    if(wpid){
        if(wpid.length){
            var wpidobj = wpid[0];
            var wpvalue = wpidobj.value;
            if(wpvalue!=""){
        		var url = "${contextPath}/workprogram/viewWorkProgram.action?wpid="+wpvalue;
        		aud$openNewTab('工作方案查看',url,true);
            }else{
            	alert("没有定义该项目类别的工作方案模板，请去工作方案模块中进行维护!");
            }
        }
    }
}
function setWorkProgramId(){
    var projtype = document.getElementsByName("crudObject.proCategoryCode");
    var pvalue = "";
    if(projtype){
        //针对如果projtypedisable，struts就会产生一个hiden的input
        if(projtype.length==1){
        	projtype = projtype[0];
        }else if(projtype.length==2){
        	projtype = projtype[1];
        }
        if(projtype){
        	pvalue = projtype.value || "${crudObject.proCategoryCode}";
        }
    }
    if(pvalue != null && pvalue != undefined){ 	
	    $.ajax({
	    	url:"${contextPath}/intctet/evaProject/evaPlan/getWorkprogram.action",
	    	dataType:"json",
	    	data:{id:pvalue},
	    	type:"post",
	    	success:function(data) {
	    		var workProgramId=data.workProgramId;
	    		$("#workprogramid").val(workProgramId);
	    		document.getElementById('showWorkProgram').innerHTML='&nbsp;<a href="javascript:void(0);" onclick="showWorkProgram()">查看对应工作方案</a>';
	    	}
	    })
    }
}
	/* 项目类别改变的时候更新要显示的工作方案 */
	function projectTypeChangeHandler(newOption,oldOption){
		setWorkProgramId();
		var currentProjectCode = newOption;
		if (currentProjectCode!=null && currentProjectCode != ""){
			document.getElementById('showWorkProgram').innerHTML='&nbsp;<a href="javascript:void(0);" onclick="showWorkProgram()">查看对应工作方案</a>';
		}else{
			document.getElementById('showWorkProgram').innerHTML='';
		}
	}
/* 流程提交方法 */
function checkForm(){
	var workprogramid=$("#workprogramid").val();
	if(workprogramid==""){
		showMessage1("请维护对应项目类别的工作方案")
		return false;
	}

	if (!audEvd$validateform("evaPlanForm")){
		return  false;
	}
	var crudObject_evaStart = $("#crudObject_evaStart").datebox("getValue");
	if (!aud$isNotBlank(crudObject_evaStart)){
		showMessage1("评价期间开始不能为空！");
		return  fasle;
	}

	var crudObject_evaEnd = $("#crudObject_evaEnd").datebox("getValue");
	if (!aud$isNotBlank(crudObject_evaEnd)){
		showMessage1("评价期间结束不能为空！");
		return  fasle;
	}

	var crudObject_planStart = $("#crudObject_planStart").datebox("getValue");
	if (!aud$isNotBlank(crudObject_planStart)){
		showMessage1("计划开始不能为空！");
		return  fasle;
	}

	var crudObject_planEnd = $("#crudObject_planEnd").datebox("getValue");
	if (!aud$isNotBlank(crudObject_planEnd)){
		showMessage1("计划结束不能为空！");
		return  fasle;
	}
	if (!validateDate('crudObject_evaStart','crudObject_evaEnd')){
		return  false;
	}
	if (!validateDate('crudObject_planStart','crudObject_planEnd')){
		return  false;
	}
	if (!validateDate2()){
		return  false;
	}
	
	var crudObject_remarks = $("#crudObject_remarks").val(); 
	if (crudObject_remarks.length> 100) {
		showMessage1("备注的长度不能大于100字！");
		return false;
	}
    return true;
}

/*
    校验两个日期大小顺序
*/
function validateDate(beginDateId,endDateId){
	var s1 = $('#'+beginDateId);
	var e1 = $('#'+endDateId);
	if(s1 && e1){
		var s = s1.datebox('getValue');
		var e = e1.datebox('getValue');
		if(s!='' && e!=''){
			var s_date=new Date(s.replace("-","/"));
			var e_date=new Date(e.replace("-","/"));
			if(s_date.getTime()>e_date.getTime()){
				$.messager.alert("错误","日期开始必须小于等于结束!");
				return false;
			}
		}
	}
	return true;
}

/*
    校验审计期间要小于项目时间
*/
function validateDate2(){
	var e1 = $('#crudObject_planEnd').datebox('getValue');
	var e2 = $('#crudObject_evaEnd').datebox('getValue');
	if(e1!=''&& e2!=''){
		var e1_date=new Date(e1.replace("-","/"));
		var e2_date=new Date(e2.replace("-","/"));
		if(e2_date.getTime()>e1_date.getTime()){
			$.messager.alert("错误","评价期间结束必须小于等于计划结束日期!");
			return false;
		}
	}
	return true;
}

function toSubmit(act){
  try{
      if(checkForm()){//提交前校验
          var isUseBpm = '${isUseBpm}';
          /* alert(isUseBpm) */
          if(isUseBpm == 'true'){
              if(document.getElementsByName('isAutoAssign')[0].value=='false'){
                  var actor_name=document.getElementsByName('formInfo.toActorId_name')[0].value;
                  if(actor_name==''){
                      top.$.messager.alert("提示信息",'下一步处理人不能为空！', 'error');
                      return false;
                  }
              }
          }
          if(confirm('确认提交吗?')){
              if(isUseBpm == 'true'){
            	  evaPlanForm.action="<s:url action="submit" includeParams="none"/>";
            	  evaPlanForm.submit();
              }else{
                  $.ajax({   
                      url:'${contextPath}/intctet/evaProject/evaPlan/directSubmit.action',
                      data: $('#evaPlanForm').serialize(),  
                      type: "post",
                      success:function(data){   
                          top.$.messager.alert("提示信息",data.msg, data.type, function(){
                              if(data.type != 'error'){
                                  //parent.closeSelectedTab();
                            	  aud$parentDialogWin().refresh();
                            	  $("#epCloseBtn").trigger('click');
                              }
                          }); 
                      },
                      error:function(xmlhttp,parseError,errorThrown){
                          top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                      }   
                  });            
              }
              return true;
           }else{
              return false;
           }
      }
  }catch(e){
      alert('toSubmit:\n'+e.message);
  }
}
function doStart(){
 	/* alert('doStart') */
 	var isUseBpm = '${isUseBpm}';
	
 	/* alert("isUseBpm:"+isUseBpm) */
 	if(isUseBpm){
 		$('#evaPlanForm').submit();
 	}
 }
 
function sucFun(){
	var sucFlag = $("#sucFlag").val();
	if(sucFlag == '0')
		$.messager.show({title:'提示信息',msg:'保存项目计划成功！'});
	else if(sucFlag == '1')
		$.messager.show({title:'提示信息',msg:'修改项目计划成功！'});
	else if(sucFlag == '2')
		$.messager.show({title:'提示信息',msg:'无法获得项目计划对象！'});
	else if(sucFlag == '3')
		$.messager.show({title:'提示信息',msg:'保存项目计划失败！'});
	else if(sucFlag == '4')
		$.messager.show({title:'提示信息',msg:'内控评价组织机构没有维护简称，无法生成项目编号！'});
	$("#sucFlag").val('');
}
</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
<s:if test= "taskInstanceId!=null && taskInstanceId!=''" >
	<body onload ="end();setWorkProgramId();sucFun();" style='padding:0px;margin:0px;overflow:hidden;' id="eplayout" class='easyui-layout' border='0' fit='true'>
</s:if>
<s:else>
	<body onload="setWorkProgramId();sucFun();" style='padding:0px;margin:0px;overflow:hidden;' id="eplayout" class='easyui-layout' border='0' fit='true'>
</s:else>
	<div region='center' border='0'>
		<form  id='evaPlanForm' name='tenderInfoForm' method="POST" >
			<!-- 流程表单，必须配置，并且页面中只能有一个form表单，且流程配置信息也都要写到表单里 -->
 	    	<div align = "right"  style='padding:5px;border-bottom:1px solid #cccccc;'>
                <s:if test="${view!='true'}">
                    <a id='epSaveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>
                    <s:if test="${crudObject.formId !=null}">
                        <!-- 显示流程相关的按钮 -->
                        <jsp:include flush="true"   page="/pages/bpm/list_toBeStart.jsp" />
                    </s:if>
                </s:if>
                <a id='epCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>
 	   		</div>
 	   		<input type='hidden' id="crudObject_creator" name="crudObject.creator"  class="noborder editElement clear" value="${crudObject.creator}"/> 
 	   		<input type='hidden' id="crudObject_creatorId" name="crudObject.creatorId"  class="noborder editElement clear" value="${crudObject.creatorId}"/> 
 	   		<input type='hidden' id="crudObject_createTime" name="crudObject.createTime"  class="noborder editElement clear" value="${crudObject.createTime}"/> 
 	   		
			<input type='hidden' id="crudObject_formId" name="crudObject.formId"  class="noborder editElement clear" value="${crudObject.formId}"/>  
			<input type='hidden' id='crudObject_attachmentId' name='crudObject.attachmentId' value="${crudObject.attachmentId }"
			class="noborder editElement" style='width:500px;'/>
			<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
			<input type='hidden' id='workprogramid' name='workprogramid' class="noborder editElement" style='width:500px;'/> 			
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>编号</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='crudObject_proCode' name='crudObject.proCode' value="${crudObject.proCode}"
						title='编号' class="noborder clear" readOnly/>
						<span id='view_proCode' class="noborder  clear" >${crudObject.proCode}</span>
					</td>
					<td class="EditHead" style="width:15%;">计划状态</td>
					<td class="editTd" style="width:35%;">
						<s:if test="${crudObject.epStatus==null }">
							<input type='hidden' id='crudObject_epStatus' name='crudObject.epStatus' title="计划状态" value="0"
								   class="noborder clear" readonly/>
							<span>计划草稿</span>
						</s:if>
						<s:else>
							<input type='hidden' id='crudObject_epStatus' name='crudObject.epStatus' title="计划状态" value="${crudObject.epStatus}"
								   class="noborder  clear" readonly/>
							<span>${crudObject.epStatusName}</span>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>计划年度</td>
					<td class="editTd" style="width:35%;">
						<s:if test="${view !=true}">
							<select id="epYear" class="easyui-combobox" name="crudObject.epYear" style="width:150px;" data-options="panelHeight:'auto',editable:false">
							   <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(5,5)">
								 <s:if test="${crudObject.epYear ==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
								 </s:if>
								 <s:else>
									 <option value="<s:property value="key"/>"><s:property value="value"/></option>
								 </s:else>
							   </s:iterator>
							</select>
						</s:if>
						<s:else>
							<span id='view_epYear' class="noborder viewElement clear" style='width:50%;display:inline;'>${crudObject.epYear}</span>
						</s:else>
					</td>
					<td class="EditHead" >计划月份</td>
					<td class="editTd" style="width:55%;">
						<s:if test="${view !=true}">
							<select id="epMonth" class="easyui-combobox" name="crudObject.epMonth" style="width:150px;" data-options="panelHeight:'auto',editable:false">
							   <s:iterator value="@ais.project.ProjectUtil@getmonthlist()">
								 <s:if test="${crudObject.epMonth ==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
								 </s:if>
								 <s:else>
									 <option value="<s:property value="key"/>"><s:property value="value"/></option>
								 </s:else>
							   </s:iterator>
							</select>
						</s:if>
						<s:else>
							<span id='view_apvYear' class="noborder viewElement clear" style='width:50%;display:inline;'>${crudObject.epMonth}</span>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>项目名称</td>
					<td class="editTd" >
						<input type='text' id='crudObject_epName' name='crudObject.epName' value="${crudObject.epName}"
						title="项目名称" class="noborder editElement clear required"/>
						<span id='view_epName' class="noborder viewElement clear" >${crudObject.epName}</span>
					</td>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>计划类别</td>
					<td class="editTd" >
						<input type='text' id='crudObject_epCategory' name='crudObject.epCategory' title="计划类别" value="${crudObject.epCategory}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='crudObject_epCategoryCode' name='crudObject.epCategoryCode' title="计划类别Code"  value="${crudObject.epCategoryCode}"
						class="noborder editElement clear" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'计划类别选择',
                                  onlyLeafClick:true,
								  param:{
									'customRoot':'计划类别',
									'serverCache':false,
									'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'whereHql':'type=\'53\'',
				                    'plugId':'53',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'code'
				                 }                                  
						})"></a>
						<span id='view_epCategory' class="noborder viewElement clear" >${crudObject.epCategory}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>项目类别</td>
					<td class="editTd" >
						<input type='hidden' id='crudObject_proCategory' name='crudObject.proCategory' title="项目类别" value="${crudObject.proCategory}"
						  class="noborder editElement clear required" readonly/>
						 <s:if test="${view != true}">
						 	<select class="easyui-combobox"   name="crudObject.proCategoryCode" 
						 	style="width:150px;" id="crudObject_proCategoryCode" panelHeight="auto">
								<s:iterator value="basicUtil.proCategoryList" id="entry">
									<s:if test="${crudObject.proCategoryCode == code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
						 </s:if>
						<s:else>
							<span id='view_proCategory' class="noborder viewElement clear" >${crudObject.proCategory}</span>
						</s:else>
					</td>
					<td class="EditHead" >工作方案模板</td>
					<td class="editTd">
						<div id="showWorkProgram" style="float: left;"></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>内控评价组织者</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='crudObject_evaOrgan' name='crudObject.evaOrgan' title="内控评价组织者" value="${crudObject.evaOrgan}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='crudObject_evaOrganCode' name='crudObject.evaOrganCode' title="内控评价组织者Code"  value="${crudObject.evaOrganCode}"
						class="noborder editElement clear"/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'内控评价组织者选择',
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></a>
						<span id='view_evaDept' class="noborder viewElement clear" style='width:50%;display:inline;'>${crudObject.evaOrgan}</span>
					</td>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>评价专岗负责人</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='crudObject_principal' name='crudObject.principal' title="评价专岗负责人" value="${crudObject.principal}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='crudObject_principalCode' name='crudObject.principalCode' title="评价专岗负责人Code"  value="${crudObject.principalCode}"
						class="noborder editElemecrudObjectnt clear"/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'请选择评价专岗负责人',
                                  type:'treeAndUser',
                                  defaultDeptId:'${user.fdepid}',
                                  defaultUserId:'${user.floginname}',
                                  singleSelect:true,
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></a>
						<span id='view_principal' class="noborder viewElement clear" style='width:50%;display:inline;'>${crudObject.principal}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>评价期间开始</td>
					<td class="editTd" >
						<s:if test="${view !=true }">
							<input type='text' id='crudObject_evaStart' name='crudObject.evaStart' value="${crudObject.evaStart}"
							class="noborder  easyui-datebox  clear required" editable="false" title="评价期间开始"/>
						</s:if>
						<s:else>
							<span id='view_evaStart' class="noborder viewElement clear" datatype='date'>${crudObject.evaStart}</span>
						</s:else>
					</td>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>评价期间结束</td>
					<td class="editTd" >
						<s:if test="${view !=true }">
							<input type='text' id='crudObject_evaEnd' name='crudObject.evaEnd' value="${crudObject.evaEnd}"
							class="easyui-datebox  noborder clear required" editable="false" title="评价期间结束"/>
						</s:if>
						<s:else>
							<span id='view_evaEnd' class="noborder viewElement clear" datatype='date'>${crudObject.evaEnd}</span>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>计划开始日期</td>
					<td class="editTd" >
						<s:if test="${view !=true }">
							<input type='text' id='crudObject_planStart' name='crudObject.planStart' value="${crudObject.planStart}"
							class="easyui-datebox  noborder clear required" editable="false" title="计划开始日期"/>
						</s:if>
						<s:else>
							<span id='view_planStart' class="noborder viewElement clear" datatype='date'>${crudObject.planStart}</span>
						</s:else>
					</td>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>计划结束日期</td>
					<td class="editTd" >
						<s:if test="${view !=true }">	
							<input type='text' id='crudObject_planEnd' name='crudObject.planEnd' value="${crudObject.planEnd}"
							class="easyui-datebox noborder clear required" editable="false" title="计划结束日期"/>
						</s:if>
						<s:else>
							<span id='view_planEnd' class="noborder viewElement clear" datatype='date'>${crudObject.planEnd}</span>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  >备注</td>
					<td class="editTd"  colspan='3'>
						<textarea  id='crudObject_remarks' name='crudObject.remarks' class="noborder editElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.remarks}</textarea>
						<textarea id='view_remarks' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.remarks}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  >描述<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div></td>
					<td class="editTd"  colspan='3'>
						<textarea  id='crudObject_description' name='crudObject.description' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.description}</textarea>
						<textarea id='view_description' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.description}</textarea>
					</td>
				</tr>				
			</table>
			
			<s:if test="${taskInstanceId ne -1}">
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>		
			</s:if>
			
			<div align="center">
				<jsp:include flush="true"
					page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
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