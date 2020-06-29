<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-底稿-添加、编辑、查看</title>
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
var isView = "${view}" == true || "${view}" == "true" ? true : false;
var tabTitle = isView ? '查看' : '编辑';
$(function(){
	if("${noManu}" == "1"){
		top.$.messager.alert("提示信息","当前${lastlevelName}还没有生成底稿","warning", function(){			
			aud$closeTopDialog();
		});
		setTimeout(aud$closeTopDialog,0);
	}

	$('#btnBar').hide();
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	//设置编辑或者查看
	isView ?  $('.editElement, #manu_attachmentBtn').remove() : $('.viewElement').remove();

	if(!isView){
		$('#mSaveBtn2').bind('click', function(){
			saveManu(true);
		});
		$('#mSaveBtn').bind('click', function(){		
			saveManu(false);
		});	
		//alert("${manu.rvEnd}")
		$('#mPostBtn').bind('click', function(){
			//manuSubmitApproval();
			saveManu(true, true);
		});

		setPostBtnStatus();

	}else{
		$("#mSaveBtn,#mSaveBtn2,#mPostBtn").remove();
	}
	
	function setPostBtnStatus(){
		//alert($('#manu_manuStatusCode').val())
		if($('#manu_manuStatusCode').val() == '0'){
			$("#mPostBtn").show();
		}else{
			$("#mPostBtn").hide();
		}
	}
	
	//是否复核完毕，如果完毕就不需要提交按钮了
	if("${manu.rvEnd}" == 1){
		$("#mPostBtn").remove();
	}
	
	$("#mCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	//autosize textarea
	var textareaIds = ["businessStatus", "testProcedures","conclusionExplain","workResult"];
	$.each(textareaIds, function(n, tsuffix){		
		autoTextarea(isView ?  $('#view_'+tsuffix)[0] : $('#manu_'+tsuffix)[0]);
	});
	
	//根据矩阵层级，动态生成底稿所属层级属性td
	genMatrixLevelTd("${matrixLevelNames}", $('#manu_superiorNames').val(), $('#manu_superiorCodes').val(), $('#matrixLevelInfo')[0], 
		function(index, len, title){
			var a = [];
			a.push("所属");
			a.push(title);
			a.push("名称");
			return a.join(''); 
		});
	
	// 初始化附件上传
    $('#manu_attachment').fileUpload({
    	fileGuid:$('#manu_attachmentId').val(),
        /*
       	文件上传后，回显方式选择， 默认：1
        1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
        2：以文件名列表形式展示，一个文件名称就是一行
        3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
        */
    	echoType:2,
    	// 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
    	uploadFace:1,
        triggerId:'manu_attachmentBtn',
        isDel:!isView,
        isEdit:!isView
    })
    
    isView ? $('#fileUploadBtn').remove() : null;
    
    //保存底稿
	function saveManu(isClose, isPostManu){
		 //保存底稿前，保存样本量
		 if(aud$saveSampleCapacity(true)){
		   	 aud$saveForm('manuForm', "${contextPath}/intctet/evaluationActualize/saveManu.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;
					 if(data.type == 'info'){
						 //回显字段
						 if(data){
							 for(var p in data){
								 var v = data[p];
								 //alert(p+"="+v)
								 $('#manu_'+p).val(v);
								 $('#view_'+p).text(v);
							 }
						 }
						 isPostManu ? manuSubmitApproval() : null;
						 refreshParentWin();
						 setPostBtnStatus();
						 if(isClose){
							 var curTabId = aud$getActiveTabId() || parent.aud$getActiveTabId();
							 if(curTabId && parentTabId){	
								window.setTimeout(function(){
								 	aud$closeTab(curTabId, parentTabId);							
								},0);
							 }
						 }
					 }
				 }
			 });
		 }
	}
    
	//刷新评价工具-底稿列表
    function refreshParentWin(){
		 var tabWin = aud$parentDialogWin();
		 //alert(tabWin +"\n"+ tabWin.aud$manuGrid);
		 tabWin && tabWin.aud$manuGrid ? tabWin.refresh() : null;
    }
	
	//底稿批量提交
	function manuSubmitApproval(){
		try{
			var manuIds = ['${manu.manuId}'];
			if(manuIds && manuIds.length){
				$.ajax({
					url : "${contextPath}/intctet/evaluationActualize/manuSubmitApproval.action",
					dataType:'json',
					type:"post",
					data:{
						'batchMauIds':manuIds.join(',')
					},
					beforeSend:function(){
						return true;
					},
					success: function(data){ 
						data.msg ? showMessage1(data.msg) : null;	
						if(data.type == 'info'){
							refreshParentWin();
							aud$closeTopDialog();
						}
					},
					error:function(data){
						top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
					}
				});
			}
		}catch(e){
			alert('manuSubmitApproval:\n'+e.message);
		}
	}
    
	//生成矩阵层级的tr，td
	function genMatrixLevelTd(titles, titleValues, titleCodes, target, formatFn){
		try{
			if(titles && titleValues && titleCodes && target){
				var mArr = titles.split(",");
				var vArr = titleValues.split(",");
				var cArr = titleCodes.split(",");
				//alert("mArr="+mArr+"\nvArr="+vArr+"\ncArr="+cArr);
				var mLen = mArr.length;
				var vLen = vArr.length;
				if(vLen <= mLen){				
					var curTr = null;
					var tdcount = 2;
					var lastColSpan = vLen%2 == 0 ? 1 : tdcount + 1;
					$.each(vArr, function(i, titleVal){
						var t = i%tdcount;
						var titleTd = null, valTd = null;
						var title = mArr[i];
						var isLast = i == vLen -1;
	                    if(t == 0){
	                        curTr = document.createElement('tr');
	                        $(target).append(curTr);
	                    }
	                    if(t == 0 || t == 1){                  	
		                    titleTd = $("<td class='EditHead' nowrap style='width:15%;border-bottom-width:0px;'></td>").appendTo(curTr);
		                    valTd = $("<td class='editTd' nowrap colSpan="+(isLast ? lastColSpan : 1)+" style='width:35%;border-bottom-width:0px;'></td>").appendTo(curTr);
		                    $("<span title='单击查看["+title+"]' style='cursor:pointer;color:blue;'>"+titleVal+"</span>")
		                    .attr('isLast', isLast).appendTo(valTd[0]).bind('click', function(etobj){
		                    	viewMatrixLevel(etobj, title, cArr[i])
		                    });
		                    //alert('isLast='+isLast+"\n"+valTd[0].outerHTML)
		                    $(titleTd).html(formatFn ? formatFn(i, mLen, title) : title);
	                    }
					});
				}
			}
		}catch(e){
			alert("genMatrixLevelTd:\n"+e.message)
		}
	}

	//查看矩阵层级的信息
	function viewMatrixLevel(etobj, title, nodeCode){
		try{
			if(nodeCode){			
				var isLast = false;//$(etobj.target).attr('isLast');
				isLast = isLast == 'true' ? true : (isLast == 'false' ? false : false);
				var s1 = "${contextPath}/intctet/mainProcess/"
				var sAction = isLast ? "editControlPoint" : "showSubProcessList";
				var reqUrl = s1;
				if(isLast){
					reqUrl += "editControlPoint.action?proCp=true&view=true&cpCode=${manu.cpCode}"
				}else{
					reqUrl += "showSubProcessList.action?view=true&nodeCode="+nodeCode;
				}
				aud$openNewTab(title + "查看", reqUrl, true);
			}else{
				showMessage1('查询参数NodeCode为空')
			}
		}catch(e){
			alert("viewMatrixLevel:\n"+e.message)
		}
	}
	
	//查看${lastlevelName}信息
	$('#view_cpCode').bind('click', function(){		
		try{
			if("${manu.cpCode}"){
				var cpUrl= "${contextPath}/intctet/mainProcess/editControlPoint.action?proCp=true&view=true&projectId=${manu.projectId}&cpId=${manu.cpId}";
				//alert('cpUrl='+cpUrl);
				aud$openNewTab("项目${lastlevelName}查看", cpUrl, true);
			}else{
				showMessage1('查询参数cpCode为空');
			}
		}catch(e){
			alert("viewProControPoint:\n"+e.message)
		}	
	});
	
	//样本量批量增加
	$('#manu_sampleSize').bind('change', function(){
		var count = $(this).val();
		if(aud$checkNumber(count)){
			//alert(aud$batchAppendSample)
			aud$batchAppendSample(count, "${manu.projectId}", "${manu.manuId}"); 
		}else{
            top.$.messager.alert('提示信息', '样本量必须为正整数','error',function(){
            	$('#manu_sampleSize').val('').focus();
            });
		}
	});

	$('#btnBar').show();
	
	
	//样本量查看
	$('#view_testSample').bind('click', function(){
		var topDialog = new aud$createTopDialog({
			title:'测试样本量参照表',
			url:'${contextPath}/intctet/sysManage/testSample/initSamplePage.action?view=true'
		});
		topDialog.open();
	});
	
	//设置测试结论说明是否必填
	if($('#manu_testConclusion') == '无效'){
	  $('#manu_conclusionExplain').addClass('required');
	  $('#conclusionExplain_reqflag').show();
	}else{
	  $('#manu_conclusionExplain').removeClass('required');
	  $('#conclusionExplain_reqflag').hide();
	}
});

</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;margin:0px;overflow:hidden;'>
		<div id='btnBar' style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
			<a href="javascript:void(0)" id='mSaveBtn' class="easyui-splitbutton"   
	        data-options="menu:'#muItem',iconCls:'icon-save'">保存</a>   
			<div id="muItem" style="width:100px;">   
			    <div id='mSaveBtn2' data-options="iconCls:'icon-save'">保存并关闭</div>
			</div>   
			<a id='mPostBtn'  class="easyui-linkbutton" iconCls="icon-ok" style='border-width:0px;'>提交审批</a>
 			<a id='mCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>	
	</div>
	<div region='center' border='0' title="" split="true" id="layoutCenter">
		<!-- 底稿表单 -->
		<form id="manuForm" name="manuForm" >
			<input type="hidden" id="manu_superiorNames" name="manu.superiorNames" value="${manu.superiorNames}"/>
			<input type="hidden" id="manu_superiorCodes" name="manu.superiorCodes" value="${manu.superiorCodes}"/>
			<input type="hidden" id="manu_mpName" name="manu.mpName" value="${manu.mpName}"/>
			<input type="hidden" id="manu_mpCode" name="manu.mpCode" value="${manu.mpCode}"/>
			<input type="hidden" id="manu_manuId" name="manu.manuId" value="${manu.manuId}"/>
			<table id="matrixLevelInfo" 
				class="ListTable" align="center" style='width:100%;table-layout:fixed;margin-top:0px;border:0px;'>
			</table>
			<table class="ListTable" align="center" style='width:100%;table-layout:fixed;margin-top:-2px;'>
				<tr style="height:0px;">
					<td style="width:15%;"></td><td style="width:35%;"></td>
					<td style="width:15%;"></td><td style="width:35%;"></td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>${lastlevelName}编码</td>
					<td class="editTd"   colspan="3">
						<input type='hidden' id='manu_cpCode' name='manu.cpCode' value="${manu.cpCode}" readonly/>
						<span id='view_cpCode' class="noborder" title='单击查看[${lastlevelName}]' style='cursor:pointer;color:blue;'>${manu.cpCode}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>${lastlevelName}</td>
					<td class="editTd"   colspan="3">
						<input type='hidden' id='manu_cpName' name='manu.cpName' value="${manu.cpName}" readonly/>
						<span id='view_cpName' class="noborder " >${manu.cpName}</span>
					</td>
				</tr>		
				<tr>
					<td class="EditHead" nowrap><font class='editElement' color='red'>*</font>底稿索引</td>
					<td class="editTd">
						<input type='hidden' id='manu_manuIndex' name='manu.manuIndex' value="${manu.manuIndex}" readonly/>
						<span id='view_manuIndex'>${manu.manuIndex}</span>
					</td>
					<td class="EditHead" nowrap><font class='editElement' color='red'>*</font>底稿编号</td>
					<td class="editTd">
						<input type='hidden' id='manu_manuCode' name='manu.manuCode' value="${manu.manuCode}" readonly/>
						<span id='view_manuCode'>${manu.manuCode}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>被评价单位</td>
					<td class="editTd"   style="width:35%;" >
						<span id='view_evaluatedUnit' class="noborder clear" >${manu.evaluatedUnit}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>负责部门</td>
					<td class="editTd"   style="width:35%;">
						<input type='text' id='manu_responsibleDept' name='manu.responsibleDept' value="${manu.responsibleDept}" 
						 title='负责部门' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='manu_responsibleDeptCode' name='manu.responsibleDeptCode' value="${manu.responsibleDeptCode}" 
						 title='负责部门Code' class="noborder editElement clear required" readonly/>
						<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'负责部门选择',
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></a>
						<span id='view_responsibleDept' class="noborder viewElement clear" >${manu.responsibleDept}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>业务现状
					</br><font class='editElement' color='red'>（2000字以内）</font></td>
					<td class="editTd"  colspan="3">
						<textarea  title="业务现状" id='manu_businessStatus' name='manu.businessStatus' class="noborder editElement clear required len2000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${manu.businessStatus}</textarea>
						<textarea id='view_businessStatus' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${manu.businessStatus}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>执行频率</td>
					<td class="editTd"   style="width:35%;">
						<input type='text' id='manu_executionFrequency' name='manu.executionFrequency' value="${manu.executionFrequency}" 
						 title='执行频率' class="noborder editElement clear " readonly/>
						<input type='hidden' id='manu_executionFrequencyCode' name='manu.executionFrequencyCode' value="${manu.executionFrequencyCode}" 
						 title='执行频率Code' class="noborder editElement clear " readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'执行频率选择',
				                  onlyLeafClick:true,
					          	  noMsg:true,
					              queryBox:false,
								  param:{
									'plugId':'710012',
								    'whereHql':'type=\'710012\'',
								    'customRoot':'执行频率',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_executionFrequency' class="noborder viewElement clear" >${manu.executionFrequency}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap>全年发生交易</td>
					<td class="editTd"   style="width:35%;">
						<input type='text' id='manu_yearDeal' name='manu.yearDeal' value="${manu.yearDeal}" 
						 title='全年发生交易' class="noborder editElement clear  " />
						<span id='view_yearDeal' class="noborder viewElement clear" >${manu.yearDeal}</span>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>实际控制方式</td>
					<td class="editTd"   colspan="3">
						<input type='text' id='manu_actualControl' name='manu.actualControl' value="${manu.actualControl}" 
						 title='实际控制方式' class="noborder editElement clear " readonly/>
						<input type='hidden' id='manu_actualControlCode' name='manu.actualControlCode' value="${manu.actualControlCode}" 
						 title='实际控制方式Code' class="noborder editElement clear " readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'实际控制方式选择',
				                  onlyLeafClick:true,
					          	  noMsg:true,
					              queryBox:false,
								  param:{
									'plugId':'710013',
								    'whereHql':'type=\'710013\'',
								    'customRoot':'实际控制方式',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_actualControl' class="noborder viewElement clear" >${manu.actualControl}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>测试步骤或程序
					</br><font class='editElement' color='red'>（2000字以内）</font></td>
					<td class="editTd"  colspan="3">
						<textarea  title="测试步骤或程序" id='manu_testProcedures' name='manu.testProcedures' class="noborder editElement clear required len2000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${manu.testProcedures}</textarea>
						<textarea id='view_testProcedures' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${manu.testProcedures}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>测试结论</td>
					<td class="editTd"   style="width:35%;">
						<input type='text' id='manu_testConclusion' name='manu.testConclusion' value="${manu.testConclusion}" 
						 title='测试结论' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='manu_testConclusionCode' name='manu.testConclusionCode' value="${manu.testConclusionCode}" 
						 title='测试结论code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'测试结论选择',
				                  onlyLeafClick:true,
					          	  noMsg:true,
					              queryBox:false,
								  param:{
									'plugId':'710014',
								    'whereHql':'type=\'710014\'',
								    'customRoot':'测试结论',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  },
				                  onAfterSure:function(dms, mcs){
				                	  if(mcs[0] == '无效'){
				                		  $('#manu_conclusionExplain').addClass('required');
				                		  $('#conclusionExplain_reqflag').show();
				                	  }else{
				                		  $('#manu_conclusionExplain').removeClass('required');
				                		  $('#conclusionExplain_reqflag').hide();
				                	  }
				                  }
						})"></a>
						<span id='view_testConclusion' class="noborder viewElement clear" >${manu.testConclusion}</span>
					</td>
				
					<td class="EditHead" style="width:15%;" nowrap>底稿状态</td>
					<td class="editTd"   style="width:35%;">
						<input type='hidden' id='manu_manuStatus'     name='manu.manuStatus'     value="${manu.manuStatus}" readonly/>
						<input type='hidden' id='manu_manuStatusCode' name='manu.manuStatusCode' value="${manu.manuStatusCode}" readonly/>
						<span id='view_manuStatus' class="noborder" >${manu.manuStatus}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>
						<font id='conclusionExplain_reqflag' class='editElement' color='red' style='display:none;'>*</font>测试结论说明
					</td>
					<td class="editTd"  colSpan="3">
						<textarea  title="测试结论说明" id='manu_conclusionExplain' name='manu.conclusionExplain' class="noborder editElement clear required len2000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${manu.conclusionExplain}</textarea>
						<textarea id='view_conclusionExplain' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${manu.conclusionExplain}</textarea>
						
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>工作成果
						</br><font class='editElement' color='red'>（1000字以内）</font>
					</td>
					<td class="editTd"  colSpan="3">
						<textarea  title="工作成果" id='manu_workResult' name='manu.workResult' class="noborder editElement clear  len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${manu.workResult}</textarea>
						<textarea id='view_workResult' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${manu.workResult}</textarea>
						
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>复核人</td>
					<td class="editTd"  style="width:35%;">
						<input type='text' id='manu_reviewer' name='manu.reviewer' value="${manu.reviewer}" 
						 title='复核人' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='manu_reviewerId' name='manu.reviewerId' value="${manu.reviewerId}" 
						 title='复核人code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
					    	onclick="showSysTree(this,{
			                                  title:'复核人选择',
			                                  treeTabTitle1:'${groupTypeName}',
									          queryBox:false,
									          noMsg:true,
									          allleaf:true,
									          onlyLeafClick:true,
											  param:{
											  	'plugId':'InterMember_editManu',
											  	'rootParentId':'notnull',
											  	'whereHql':'projectFormId=\'${manu.projectId}\' and mrlLevel ||\',\' like \'%1,%\' and '+aud$genGroupWhere('${groupId}'),
							                    'beanName':'InterMember',
							                    'treeId'  :'userId',
							                    'treeText':'userName',
							                    'treeParentId':'role',
							                    'treeOrder':'role',
				                                'customRoot':'${groupName}',
				                                'serverCache':false,
            									'isOracle':false
							                  }
											})"></a>	
						<span id='view_reviewer' class="noborder viewElement clear" >${manu.reviewer}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap>复核时间</td>
					<td class="editTd"   style="width:35%;">
						<span class="noborder" >${manu.reviewTime}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>测试时间</td>
					<td class="editTd"   style="width:35%;">
						<span  class="noborder">${manu.testTime}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap>测试人</td>
					<td class="editTd"   style="width:35%;">
						<span  class="noborder">${manu.tester}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>有关证据资料</br>
						<div id="manu_attachmentBtn"></div>
					</td>
					<td class="editTd"  colSpan="3">
						<input type="hidden" id="manu_attachmentId" name="manu.attachmentId" value="${manu.attachmentId}" />
						<div id="manu_attachment" style="height:150px;overflow:auto;"></div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>样本量</td>
					<td class="editTd"  colspan='3'>
						<input type='text' id='manu_sampleSize' name='manu.sampleSize' value="${manu.sampleSize}" 
						 title='样本量' class="noborder editElement clear required number" />
						<span id='view_sampleSize' class="noborder viewElement clear" >${manu.sampleSize}</span>
						<a id='view_testSample' title="测试样本量参照表" class="easyui-linkbutton" iconCls="icon-view" style='border-width:0px;'></a>
					</td>
				</tr>
			</table>
		</form>		
		<!-- 样本量 -->
		<jsp:include flush="true" page="/pages/interCtrlEvaluation/actualize/showSampleCapacityList.jsp" />	
		<!-- 认定缺陷 -->
		<jsp:include flush="true" page="/pages/interCtrlEvaluation/actualize/showConfirmCtrlDefectList.jsp" />
		<!-- 底稿提交流转信息 -->
		<jsp:include flush="true" page="/pages/interCtrlEvaluation/actualize/showReviewInfoList.jsp" />
	</div>
</body>
</html>