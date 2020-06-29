<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>送审项目添加、修改、查看</title>
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
$(function(){
	isdebug = true;
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var curDate = "${curDate}";
	autoTextarea(isView ?  $('#view_remarks')[0] : $('#ap_remarks')[0]);
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView || "${ap.apStatusCode}"=='3' || "${ap.apStatusCode}"=='4' ?  $('.editElement').hide() : $('.viewElement').hide();
	var fileGuid = "${fileGuid}" || "${ap.attachmentId}";
	$('#ap_attachmentId').val(fileGuid);
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
	$('#dvlayout').layout('resize'); 
	//保存送审项目
	function save(isClose){
	   	 aud$saveForm('dvAudProjectForm', "${contextPath}/ea/dvAudProject/saveAp.action", function(data){
			 if(data){
				 data.msg ? showMessage1(data.msg) : null;	
				 if(data.type == 'info'){
					 var apId = data.apId;
					 if(apId){
						//回填项目ID
						$('#ap_apId').val(apId);
						aud$setDatumParam(false);
						//启用项目送审资料清单
						parent.$('#qtab').tabs('enableTab',1);
						parent.$('#qtab').tabs('select',1);
					 }
					 // 刷新tab页里面的dvAudProjectList列表
					 var parentTabId = parent.$('#parentTabId').val();
					 aud$getTabIframByTabId(parentTabId).dvAudProjectList.refresh();
					 if(isClose){
						 setTimeout(function(){						 
						 	aud$closeTopDialog();
						 }, 100);
					 }
					try{						
						//刷新我的项目
						var homeIfm = aud$getTabIframByTabId('home');
						if(homeIfm && homeIfm.projectAuditFirstPage){
	   						homeIfm.projectAuditFirstPage.myProjectTable();
						}
					}catch(e){}	
				 }
			 }
		 });
	}
	function submit(){
		try{
			var apId = "${ap.apId}";
			var proId = "${ap.proId}";
			var apStatusCode = "${ap.apStatusCode}";
			var t = apStatusCode == '1' ? '送审' : apStatusCode == '2' ? '受理' : apStatusCode == '3' ? '完成' : '提交';
			if(apStatusCode == '3'){
				var rtData = isComplete([apId])
				var confirmMsg = rtData.isComplete ? '项目完成后，项目台账和审计结论将不能再录入！确认'+t+'吗?' : '【'+rtData.audProjectName+'】项目台账或审计结论信息未填或者审批流程未走完，不能完成项目';
				if(rtData.isComplete){
					top.$.messager.confirm('提示信息', confirmMsg, function(r){
						r ? saveSumibtForm() : null;
					});
				}else{
					top.$.messager.alert('提示信息', confirmMsg, 'warning');
				}
			}else{
				saveSumibtForm();
			}
			
			function saveSumibtForm(){				
				aud$saveForm('dvAudProjectForm', "${contextPath}/ea/dvAudProject/saveAp.action", function(data){
					if(data){
						var apIds = data.apId;
						var proIds = data.proId;
						 if(apIds && proIds){
							//回填项目ID
							var proId = "${ap.proId}";
							if(apStatusCode == '3'){
								aud$post(apIds,proIds,apStatusCode);
							}else{								
								top.$.messager.confirm('提示信息','确认'+t+"吗?",function(r){ 
									if(r){
					    				aud$post(apIds,proIds,apStatusCode);
									}
								});
							}
						 }else{
							 showMessage1("参数错误");
						 }
					}
				}); 	
			}
		}catch(e){
			alert('submit:'+e.message);
		}
	}
	
	window.dvRetreat = dvRetreat;
	function dvRetreat(){
		try{
			top.$.messager.confirm('提示信息','确认要退回吗?',function(r){ 
				if(r){
    				aud$post("${ap.apId}","${ap.proId}","0");
				}
			});
		}catch(e){
			
		}
	}
	
	
    //项目是否可以“完成”，检查项目的完整性，台账和结论是否填写
    function isComplete(idArr){
    	var rt = {};
    	if(idArr == null || idArr.length == 0){
    		rt.errMsg = "项目ID为空";
    		rt.isComplete = false;
    	}else{   		
			$.ajax({
				url:"${contextPath}/ea/dvAudProject/validatePro.action",
				type:"post",
				data: {
					'apIds' :idArr.join(",")
				},
				async: false,
				dataType:"json",
				beforeSend:function(){
					if(idArr && idArr.length){
						aud$loadOpen();
						return true;
					}else{
						showMessage1('要验证的记录为空！');
						return false;
					}
				},
				success: function(data){
					aud$loadClose();
					rt = data;
				},
				error:function(data){
					aud$loadClose();
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
    	}
		return rt;
    }
	
	
	window.dvSave = save;
	window.dvSubmit = submit;
	$('#etdAgencySelect').combobox({
		panelHeight:50,
		editable:false,
		onSelect:function(item){
			var value = item.value;
			setEtAgency(value, item.text);
			setEtTr(value);
		}
	});
	
	//设置“是否委托中介机构”状态
	var etSelectVal = '${ap.etdAgencyCode}' || '1';
	$('#etdAgencySelect').combobox('setValue',etSelectVal);
	setEtAgency(etSelectVal, etSelectVal == '1' ? '是' : '否');
	setEtTr(etSelectVal)
	
	function setEtAgency(value, text){
		$('#ap_etdAgencyCode').val(value);
		$('#ap_etdAgency').val(text);
	}
	
	function setEtTr(selectValue){
		$('#agencyTr').css('display', selectValue == '0' ? 'none' : '');
		if(selectValue == '0'){
			$('#ap_agencyNames, #ap_agencyIds, #ap_agMemberNames, #ap_agMemberIds').removeClass('required');
		}else if(selectValue == '1'){
			$('#ap_agencyNames, #ap_agencyIds, #ap_agMemberNames, #ap_agMemberIds').addClass('required');			
		}
		
	}
	// 显示窗口，选择项目 招标 合同 等信息, 批量注册方法
	$.each(['proInfo', 'tender', 'contract', 'agency', 'agencyMembers'], function(n, tname){
		//从列表中选择
		$("#select_"+tname).bind('click', function(){
			var winTitle = $(this).attr('title') || "请选择送审信息";
			var winUrl = "";
			/* 工程项目与招标信息、合同信息的选择实现联动并进行校验 */
			if(tname=="agencyMembers") {
				var id=$("#ap_agencyId").val();
				var ids=$("#ap_agencyIds").val();
				var agencyId=id==""?"${ap.agencyIds}":id;
				if(ids=="") {
					showMessage1("请先选择中介机构！");
					return false;
				}		
				winUrl = selectAction[tname]+"&agencyId="+agencyId;
			}else if(tname=="tender"||tname=="contract"){
				var id=$("#select_proInfo_id").val();
				var ids=$("#select_proInfo_ids").val();
				var pid=id==""?ids:id;
				if(id=="") {
					showMessage1("请先选择工程项目！");
					return false;
				}
				winUrl = selectAction[tname]+"&pid="+pid;
			}else {
				winUrl = selectAction[tname];
			}
			if(winTitle && winUrl){			
				//aud$openNewTab(winTitle, winUrl, true);
				
				new aud$createTopDialog({
					'url':winUrl,
					'title':winTitle,
					onClose:showOrHideSelectView
				}).open();
			}
			
		});
		//查看详情
		$("#view_"+tname).bind('click', function(){
			var bid = $("#select_"+tname+"_id").val();
			var title = $(this).attr('title') || "查看送审信息";
			if(bid){
				 //打开一个tab，显示查看界面
				aud$openNewTab(title, selectAction[tname + "View"] + "&"+selectAction[tname + "Id"]+"=" + bid, true);
			}else{
				var errMsg = "查询所需ID为空，请确定是否选择了业务记录";
				//showMessage1(errMsg);
				top.$.messager.alert('提示信息',errMsg, 'error', function(){
					
				});
			}
		});
	});	
	var selectAction = {
		'proInfo'    :'${contextPath}/ea/project/initPage.action?winSelect=true',
		'proInfoView':'${contextPath}/ea/project/showFrame.action?view=true',
		'proInfoId'  :'pid',		
		'tender'     :'${contextPath}/ea/tenderInfo/initPage.action?winSelect=true',
		'tenderView' :'${contextPath}/ea/tenderInfo/editTender.action?view=true',
		'tenderId'   :'tdId',		
		'contract'     :'${contextPath}/ea/contractInfo/initPage.action?winSelect=true',
	  	'contractView' :'${contextPath}/ea/contractInfo/editContractInfo.action?view=true',
	  	'contractId'   :'ctId',
	  	'agency'       :'${contextPath}/ea/agency/initPage.action?winSelect=true',
	  	'agencyMembers':'${contextPath}/ea/agency/showEmployee.action?winSelect=true&display=true',
	}
	
	//处理double金额显示的科学计数法
	if("${ap.apStatusCode}"=='1'){
		aud$handleMoneyEFormat("ap",["audCost","approvalCost"], isView);
	}else{
		aud$handleMoneyEFormat("view",["audCost","approvalCost"], true);
	}
		
	//设置父页面tab页（审计台账、审计结论）
	parent.aud$setConclustionTab( "${ap.apStatusCode}");
	//设置送审项目资料请求url的参数，审计项目类型改变时，把相关参数拼接后填充到父页面字段
	aud$setDatumParam(false);

	//编辑状态，启用项目送审资料清单
	$('#ap_apId').val() ? parent.$('#qtab').tabs('enableTab',1) : null;
		
    //把frame页面窗口ID赋给里面iframe，用于iframe里面的页面打开新窗口后，访问iframe
	setTimeout(function(){
		var topDialogTargetId = parent.aud$getActiveDialogTargetId();
		$('body').attr("topDialogTargetId", topDialogTargetId);
	},0)
    
    function showOrHideSelectView(){   	
		$('#view_tender').css('display', $('#ap_tdProjectNumber').val() ? "" : 'none'); 
		$('#view_contract').css('display', $('#ap_ctNumber').val() ? "" : 'none'); 
    }

	showOrHideSelectView();
		
	if(isView){
		parent.$('#dvSave,#dvSubmit,#dvRetreat').hide();
	}else{
		parent.$('#dvSave, #dvSubmit').show();
		if("${ap.apStatusCode}" =='2'){
			parent.$('#dvSubmit').find('.l-btn-text').html("受理");
			parent.$('#dvRetreat').show();
		}else if("${ap.apStatusCode}" =='3'){
			parent.$('#dvSave,#dvRetreat').remove();
			parent.$('#dvSubmit').show();
			parent.$('#dvSubmit').find('.l-btn-text').html("完成");
			/*
			if($('#ap_accountState').val() == "2" && $('#ap_conclusionState').val() == "2"){
				isView ? parent.$('#dvSave,#dvSubmit').remove() : parent.$('#dvSave,#dvSubmit').show();
			} */
			var qtabIndex = $('#ap_accountState').val() == '0' || $('#ap_accountState').val() == '' ? 2 : ($('#ap_conclusionState').val() == '0' || $('#ap_conclusionState').val() == '' ? 3 : 0);
			parent.$('#qtab').tabs('select',qtabIndex);
		}else if("${ap.apStatusCode}" =='4'){
			parent.$('#dvSave,#dvSubmit,#dvRetreat').remove();
		}
	}
	
	
});
//更新父页面送审资料iframe请求url的参数
function aud$setDatumParam(isload){
	parent.$('#audDatumParam').val("&audUnitId=${ap.audUnitId}&apStatusCode=${ap.apStatusCode}&sortCode="+$('#ap_audTypeCode').val()+"&apId="+$('#ap_apId').val()+"&apName=${ap.audProjectName}");
	parent.$('#audDatum').data('isload',isload);
}

//生成项目送审编号
function aud$genSerialNumber(apStatusCodes, apStatusNames){
	try{
		var apStatusCode = apStatusCodes[0];
		var apStatusName = apStatusNames[0];
		
		//alert(apStatusName + "\n"+apStatusCode);
		
		// 如果apStatusCode不进行重新生成
		if(apStatusCode == $('#ap_audTypeCode').attr('oldValue')){
			return;
		}
		//更新父页面送审资料iframe请求url的参数
		aud$setDatumParam(false);
		
		$.ajax({
			url : '${contextPath}/ea/dvAudProject/genSerialNumber.action',
			dataType:'json',
			type: "post",
			///async:false,
			data: {
				'apStatusCode':apStatusCode,
				'apId':$('#ap_apId').val()
			},
			beforeSend:function(){
			     var check = false;
				 if(apStatusCode != null && apStatusCode != "" && apStatusName){
					 check = true;
					 frloadOpen()
				 }else{
					 top.$.messager.show({title:'提示信息',msg:'apStatusCode为空不能获得流水号，请检查项目类型配置！'});
				 }
				 return check;
			},
			success: function(data){
				frloadClose();
				if(data.number){
					var valarr = [];
					valarr.push($('#ap_audUnit').val());
					valarr.push("(");
					valarr.push(apStatusName);
					valarr.push(")(");
					valarr.push(data.number);
					valarr.push(")"); 
					$('#ap_audNumber').val(valarr.join(''));
					$odlValuedTyapStatusCoder('odlValue', apStatusCode);
				}
			},
			error:function(data){
				frloadClose();
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
	}catch(e){
		alert("aud$genSerialNumber errmsg:\n"+e.message);
	}
}
function aud$post(apId,proId,apStatusCode){
	$.ajax({
		url : "${contextPath}/ea/dvAudProject/postAp.action",
		type: "post",
		data: {
			'apIds' :apId,
			'proIds':proId,
			'apStatusCode':parseInt(apStatusCode)+1
		},
		dataType:'json',
		beforeSend:function(){
			if(apStatusCode == "3"){				
			    var check = false;
				if($('#ap_accountState').val() != "2"){
					top.$.messager.alert('提示信息','项目台账-审批还未完成！', 'warning', function(){				 
						parent.$('#qtab').tabs('select',2);
					});
				 }else if($('#ap_conclusionState').val() != "2"){
					top.$.messager.alert('提示信息','审计结论-审批还未完成！', 'warning', function(){				 
						parent.$('#qtab').tabs('select',3);
					});
				 }else{
					check = true;
					aud$loadOpen();				 
				 }
				 return check;
			}else{
				return true;
			}
			
		},
		success: function(data){
			aud$loadClose();
			data.msg ? showMessage1(data.msg) : null;	
			if(data.type == 'info'){
				try{						
					//刷新我的项目
					var homeIfm = aud$getTabIframByTabId('home');
					if(homeIfm && homeIfm.projectAuditFirstPage){
   						homeIfm.projectAuditFirstPage.myProjectTable();
					}
				}catch(e){}	
				try{
					var parentTabId = parent.$('#parentTabId').val();
					aud$getTabIframByTabId(parentTabId).dvAudProjectList.refresh();						
				}catch(e){}
			}
			parent.aud$closeTab();
			        
		},
		error:function(data){
			aud$loadClose()
			top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
		}
	});
}



</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id='dvlayout' class='easyui-layout' border='0' fit='true'>
	<div region='center' border='0'>
		<input type='hidden' id="ea_apStatusCode" value="${ap.apStatusCode}"/>
		<form id="dvAudProjectForm" name="dvAudProjectForm" style="margin:0px;padding:0px;">
			<input type='hidden' id="ap_apId" name="ap.apId"  value="${ap.apId}" class="noborder editElement clear" />  
			<input type='hidden' id='ap_attachmentId' name='ap.attachmentId' value="${ap.attachmentId}"
			 class="noborder editElement" /> 	
			<input type='hidden' id='ap_clsAttachId' name='ap.clsAttachId' value="${ap.clsAttachId}"
			 class="noborder editElement" /> 
			<input type="hidden" id="ap_accountState"    name="ap.accountState"    value="${ap.accountState}"/>	
			<input type="hidden" id="ap_conclusionState" name="ap.conclusionState" value="${ap.conclusionState}"/>	
			<table class="ListTable" align="center" style='table-layout:fixed;width:100%;border:0px;margin:0px;padding:0px; '>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font color=red>*</font>工程项目编号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ap_eaProjectNum' name='ap.eaProjectNum' value="${ap.eaProjectNum}"
						 class="noborder editElement clear required len100"  readonly />
						<input type='hidden' id='select_proInfo_id' name='ap.proId' value="${ap.proId}"
						title="工程项目ID" class="noborder editElement clear required" readonly />
						<input type='hidden' id='select_proInfo_ids' title="工程项目IDs"   readonly
							class="noborder editElement clear "/>
						<span id='view_eaProjectNum' class="noborder viewElement clear">${ap.eaProjectNum}</span>
						<s:if test="${ap.apStatusCode=='1' }">
							<a id='select_proInfo' title='工程项目选择' class="easyui-linkbutton editElement" iconCls="icon-search" style='border-width:0px;'></a>
						</s:if>
						<a id='view_proInfo'   title='工程项目查看' class="easyui-linkbutton" iconCls="icon-view" style='border-width:0px;'></a>
					</td>
					<td class="EditHead" style="width:15%;" nowrap><font color=red>*</font>工程项目名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ap_eaProjectName' name='ap.eaProjectName' value="${ap.eaProjectName}"
						title='工程项目名称' class="noborder editElement clear required" readonly/>
						<span id='view_eaProjectName' class="noborder viewElement clear" >${ap.eaProjectName}</span>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:20%;"><font color=red>*</font>审计项目名称</td>
					<td class="editTd" style="width:30%;">
						<s:if test="${ap.apStatusCode=='1' }">
							<input type='text' id='ap_audProjectName' name='ap.audProjectName' value="${ap.audProjectName}"
							title='审计项目名称' class="noborder editElement clear required len400"/>
							<span id='view_audProjectName' class="noborder viewElement clear" >${ap.audProjectName}</span>
						</s:if>
						<s:else>
							<span id='view_audProjectName' class="noborder editElement clear" >${ap.audProjectName}</span>
							<span id='view_audProjectName' class="noborder viewElement clear" >${ap.audProjectName}</span>
						</s:else>
					</td>
					<td class="EditHead" style="width:20%;"><font color=red>*</font>审计类型</td>
					<td class="editTd" style="width:30%;">
						<input type='text' id='ap_audType' name='ap.audType' value="${ap.audType}"
						title='审计类型' class="noborder editElement clear required len100" readonly/>
						<input type='hidden' id='ap_audTypeCode' name='ap.audTypeCode' oldValue="${ap.audTypeCode}" value="${ap.audTypeCode}"
						title='审计类型Code' class="noborder editElement clear required len100" readonly/>
						<s:if test="${ap.apStatusCode=='1' }">
							<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
								onclick="showSysTree(this,{
									  title:'审计类型选择',
					                  onlyLeafClick:true,
									  param:{
										'plugId':'6001',
									    'whereHql':'type=\'6001\'',
									    'customRoot':'审计类型',
									  	'rootParentId':'0',
					                    'beanName':'CodeName',
					                    'treeId'  :'id',
					                    'treeText':'name',
					                    'treeParentId':'pid',
					                    'treeOrder':'name'
					                  },
					                  onAfterSure:aud$genSerialNumber
							})"></a>
						</s:if>
						<span id='view_audType' class="noborder viewElement clear" >${ap.audType}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" >招标项目编号</td>
					<td class="editTd" >
						<input type='text' id='ap_tdProjectNumber' name='ap.tdProjectNumber'  value="${ap.tdProjectNumber}"
						 class="noborder editElement clear" readonly/>
						<input type='hidden' id='select_tender_id' name='ap.tdId'  value="${ap.tdId}"
						class="noborder editElement clear" readonly/>
						<span id='view_tdProjectNumber' class="noborder viewElement clear" >${ap.tdProjectNumber}</span>
						<s:if test="${ap.apStatusCode=='1' }">
							<a id='select_tender' title="招标信息选择" class="easyui-linkbutton editElement" iconCls="icon-search" style='border-width:0px;'></a>
						</s:if>
						<a id='view_tender'   title="招标信息查看" class="easyui-linkbutton" iconCls="icon-view" style='border-width:0px;'></a>
					</td>
					<td class="EditHead" >招标项目名称</td>
					<td class="editTd" >
						<input type='text' id='ap_tdProjectName' name='ap.tdProjectName' value="${ap.tdProjectName}"readonly
						 title='招标项目名称' class="noborder editElement clear" />
						<span id='view_tdProjectName' class="noborder viewElement clear">${ap.tdProjectName}</span>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" >合同编号</td>
					<td class="editTd" >
						<input type='text' id='ap_ctNumber' name='ap.ctNumber'  value="${ap.ctNumber}"
						 class="noborder editElement clear" readonly/>
						<input type='hidden' id='select_contract_id' name='ap.ctId'  value="${ap.ctId}"
						class="noborder editElement clear" readonly/>
						<span id='view_ctNumber' class="noborder viewElement clear" >${ap.ctNumber}</span>
						<s:if test="${ap.apStatusCode=='1' }">
							<a id='select_contract' title="合同信息选择"  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'></a>
						</s:if>
						<a id='view_contract'   title="合同信息查看" class="easyui-linkbutton" iconCls="icon-view" style='border-width:0px;'></a>
					</td>
					<td class="EditHead" >合同名称</td>
					<td class="editTd" >
						<input type='text' id='ap_ctName' name='ap.ctName' value="${ap.ctName}"readonly
						  class="noborder editElement clear"/>
						<span id='view_ctName' class="noborder viewElement clear" >${ap.ctName}</span>
					</td>
				</tr>
				<!-- 项目送审提交后显示 -->
				<s:if test="${view == true || ap.apStatusCode != '1'}">
					<tr>
						<td class="EditHead" style="width:20%;"><font color=red>*</font>审计项目负责人</td>
						<td class="editTd" style="width:30%;">
							<input type='text' id='ap_proHeader' name='ap.proHeader' value="${ap.proHeader}" readonly
							title='审计项目负责人' class="noborder editElement clear required"/>
							<input type='hidden' id='ap_proHeaderId' name='ap.proHeaderId' title="审计项目负责人ID"  value="${ap.proHeaderId}"
							class="noborder editElement clear required" readonly/>
							<a id='' class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
								onclick="showSysTree(this,{
	                                  title:'项目负责人选择',
									  param:{
									  	'rootParentId':'0',
					                    'beanName':'UOrganizationTree',
					                    'treeId'  :'fid',
					                    'treeText':'fname',
					                    'treeParentId':'fpid',
					                    'treeOrder':'fcode'
					                 },
					                 type:'treeAndEmployee',
					                 singleSelect:true
							})"></a>
							<span id='view_audProjectName' class="noborder viewElement clear" >${ap.proHeader}</span>
						</td>
						<td class="EditHead" ><font color=red>*</font>项目组成员</td>
						<td class="editTd" >
							<input type='text' id='ap_memberNames' name='ap.memberNames'  title="项目组成员" value="${ap.memberNames}" 
							  class="noborder editElement clear required" readonly/>
							<input type='hidden' id='ap_memberIds' name='ap.memberIds' title="项目组成员ID"  value="${ap.memberIds}" 
							class="noborder editElement clear required" readonly/>
							<a id='' class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
								onclick="showSysTree(this,{
	                                  title:'项目成员选择',
									  param:{
									  	'rootParentId':'0',
					                    'beanName':'UOrganizationTree',
					                    'treeId'  :'fid',
					                    'treeText':'fname',
					                    'treeParentId':'fpid',
					                    'treeOrder':'fcode'
					                 },
					                 type:'treeAndEmployee',
					                 singleSelect:false
							})"></a>
							<span id='view_memberNames' class="noborder viewElement clear" >${ap.memberNames}</span>
						</td>
					</tr>
					<tr>
						<td class="EditHead" ><font color=red>*</font>是否委托中介机构</td>
						<td class="editTd" colspan="3">
							 <span class='editElement'>
								<select id="etdAgencySelect" class="easyui-combobox">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
								<input type='hidden' id="ap_etdAgency"     name="ap.etdAgency"     value="${ap.etdAgency}"/>
								<input type='hidden' id="ap_etdAgencyCode" name="ap.etdAgencyCode" value="${ap.etdAgencyCode}"/>						
							</span>
							<span id='view_etdAgency' class="noborder viewElement clear" >${ap.etdAgency}</span>
						</td>
					</tr>	
					<tr id='agencyTr'>
						<td class="EditHead" ><font color=red>*</font>中介机构名称</td>
						<td class="editTd" >
							<input type='text' id='ap_agencyNames' name='ap.agencyNames' title="中介机构名称" value="${ap.agencyNames}" readonly
							 class="noborder editElement clear "/>
							<input type='hidden' id='ap_agencyIds' name='ap.agencyIds' title="中介机构ID"  value="${ap.agencyIds}" readonly
							class="noborder editElement clear "/>
							<a id='select_agency' title="中介机构名称选择" class="easyui-linkbutton editElement" iconCls="icon-search" style='border-width:0px;'></a>
							<span id='view_agencyNames' class="noborder viewElement clear" >${ap.agencyNames}</span>
						</td>
						<td class="EditHead"  nowrap><font color=red>*</font>中介机构项目组成员</td>
						<td class="editTd" >
							<input type='text' id='ap_agMemberNames' name='ap.agMemberNames' title="中介机构项目组成员" value="${ap.agMemberNames}" readonly
							 class="noborder editElement clear "/>
							 <input type='hidden' id='ap_agencyId' readonly	 class="noborder editElement clear "/>
							<input type='hidden' id='ap_agMemberIds' name='ap.agMemberIds' title="中介机构项目组成员ID"  value="${ap.agMemberIds}" readonly
							class="noborder editElement clear "/>
							<a id="select_agencyMembers" title="中介机构项目组成员选择" class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'></a>
							<span id='view_agMemberNames' class="noborder viewElement clear" >${ap.agMemberNames}</span>
						</td>
					</tr>
					<tr>
						<td class="EditHead" ><font color=red>*</font>项目开始时间</td>
						<td class="editTd" >
							<span class='editElement'>
								<input type='text' id='ap_projectStartTime' name='ap.projectStartTime' value="${ap.projectStartTime}"
								class="easyui-datebox noborder clear required" editable="false" title='项目开始时间'/>
							</span>
							<span id='view_projectStartTime' class="noborder viewElement clear">${ap.projectStartTime}</span>
						</td>
						<td class="EditHead" ><font color=red>*</font>项目结束时间</td>
						<td class="editTd" >
							<span class='editElement'>
								<input type='text' id='ap_projectEndTime' name='ap.projectEndTime' compareval="gte&ap_projectStartTime"  value="${ap.projectEndTime}"
								class="easyui-datebox noborder clear required" editable="false" title='项目结束时间'/>
							</span>
							<span id='view_projectEndTime' class="noborder viewElement clear">${ap.projectEndTime}</span>
						</td>
					</tr>			
				</s:if>
				<tr>
					<td class="EditHead" ><font color=red>*</font>送审金额</td>
					<td class="editTd" >
						<s:if test="${ap.apStatusCode=='1' }">
							<input type='text' id='ap_audCost' name='ap.audCost' value="${ap.audCost}"
							class="noborder editElement clear required money len20"/>
							<span id='view_audCost' class="noborder viewElement clear" >${ap.audCost}</span> 元
						</s:if>
						<s:else>
							<span id='view_audCost' class="noborder">${ap.audCost}</span> 元
						</s:else>
					</td>
					<td class="EditHead" ><font color=red>*</font>项目批复金额</td>
					<td class="editTd" >
						<s:if test="${ap.apStatusCode=='1' }">
							<input type='text' id='ap_approvalCost' 
							name='ap.approvalCost' class="noborder editElement clear required money len20" value="${ap.approvalCost}"/>
							<span id='view_approvalCost' class="noborder viewElement clear" >${ap.approvalCost}</span> 元
						</s:if>
						<s:else>
							<span id='view_approvalCost' class="noborder">${ap.approvalCost}</span> 元
						</s:else>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" >送审编号</td>
					<td class="editTd"  colspan='3'>
						<input type='text' id='ap_audNumber' name='ap.audNumber'  value="${ap.audNumber}"readonly
							style='width:100%;'
						 class="noborder editElement clear"/>
						<span id='view_audNumber' class="noborder viewElement clear" >${ap.audNumber}</span>
					</td>

				</tr>
				<tr>
					<td class="EditHead" >送审单位</td>
					<td class="editTd">
						<input type='text' id='ap_audUnit' name='ap.audUnit'  value="${ap.audUnit}"
						 style='border-width:0px;'
						 class="noborder editElement clear" readonly/>
						 <input type="hidden" name="ap.audUnitId" value="${ap.audUnitId}"/>
						<span id='view_audUnit' class="noborder viewElement clear">${ap.audUnit}</span>
					</td>
					<td class="EditHead" ><font color=red>*</font>审计单位</td>
					<td class="editTd" >
						<input type='text' id='ap_audObjectNames' name='ap.audObjectNames' title="审计单位" value="${ap.audObjectNames}" readonly
						class="noborder editElement clear required"/>
						<input type='hidden' id='ap_audObjectIds' name='ap.audObjectIds' title="审计单位ID"  value="${ap.audObjectIds}" readonly
						class="noborder editElement clear required"/>
						<s:if test="${ap.apStatusCode=='1' }">
							<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
								onclick="showSysTree(this,{
		                             title:'审计单位选择',
									 param:{
									  	'rootParentId':'0',
					                    'beanName':'UOrganizationTree',
					                    'treeId'  :'fid',
					                    'treeText':'fname',
					                    'treeParentId':'fpid',
					                    'treeOrder':'fcode'
						              }                                  
								})"></a>
						</s:if>
						<span id='view_audObjectNames' class="noborder viewElement clear" >${ap.audObjectNames}</span>	
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" >送审人</td>
					<td class="editTd" >
						<input type='text' id='ap_audPerson' name='ap.audPerson' value="${ap.audPerson}"
							style='width:100%;border-width:0px;' readonly
						  class="noborder editElement clear"/>
						<input type='hidden' id='ap_audPersonId' name='ap.audPersonId' value="${ap.audPersonId}" readonly
						  class="noborder editElement clear"/>
						<span id='view_audPerson' class="noborder viewElement clear">${ap.audPerson}</span>
					</td>
					<td class="EditHead" >送审时间</td>
					<td class="editTd" >
						<input type='text' id='ap_audDate' name='ap.audDate' value="${ap.audDate}"
							style='width:98%;border-width:0px;'
						  class="noborder editElement clear" readonly/>
						<span id='view_audDate' class="noborder viewElement clear" >${ap.audDate}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead">送审说明</br><font color=DarkGray>(限2000字)</font></td>
					<td class="editTd"  colspan='3'>
						<textarea  id='ap_remarks' name='ap.remarks' class="noborder editElement clear len2000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${ap.remarks}</textarea>
						<textarea id='view_remarks' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${ap.remarks}</textarea>
					</td>
				</tr>
				<s:if test="${view == true || ap.apStatusCode != '1'}">
					<tr>
						<td class="EditHead" >受理人</td>
						<td class="editTd" >
							<input type='text' id='ap_acceptPerson' name='ap.audPerson' value="${ap.acceptPerson}"
								style='width:100%;border-width:0px;' readonly
							  class="noborder editElement clear"/>
							<input type='hidden' id='ap_acceptPersonId' name='ap.acceptPersonId' value="${ap.acceptPersonId}" readonly
							  class="noborder editElement clear"/>
							<span id='view_acceptPerson' class="noborder viewElement clear">${ap.acceptPerson}</span>
						</td>
						<td class="EditHead" >受理时间</td>
						<td class="editTd" >
							<input type='text' id='ap_acceptDate' name='ap.acceptDate' value="${ap.acceptDate}"
								style='width:98%;border-width:0px;'
							  class="noborder editElement clear" readonly/>
							<span id='view_audDate' class="noborder viewElement clear" >${ap.acceptDate}</span>
						</td>
					</tr>
				</s:if>
			</table>
		</form>		
	</div>
	<div region="south" style="overflow:hidden;" border='0' title="">
	     <div id="edit_attachFile" class="editElement"></div>
	     <div id="view_attachFile" class="viewElement"></div>
	</div>
	

	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
   <jsp:include flush="true" page="/pages/engineeringAudit/dvAudProject/infoSelect.jsp" />
</body>
</html>