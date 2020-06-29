<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-认定控制缺陷</title>
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
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	
	//设置编辑或者查看
	isView ?  $('.editElement').remove() : $('.viewElement').remove();
	isView ? $('#fileUploadBtn').remove() : null;
	
	//autosize textarea
	var textareaIds = ["defectDescription", "defectCause", "riskEffect", "suggestDescription"];
	$.each(textareaIds, function(n, tsuffix){		
		autoTextarea(isView ?  $('#view_'+tsuffix)[0] : $('#defect_'+tsuffix)[0]);
	});
	
	if(!isView){
		$('#mSaveBtn2').bind('click', function(){
			saveDefect(true);
		});
		$('#mSaveBtn').bind('click', function(){		
			saveDefect(false);
		});		
	}else{
		$("#mSaveBtn,#mSaveBtn").remove();
	}
	$("#mCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});

	// 初始化附件上传
    $('#defectAttachment').fileUpload({
    	fileGuid:$('#defect_attachmentId').val(),
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
    
    //保存控制缺陷
    function saveDefect(isClose){
		try{		 
		   	 aud$saveForm('defectForm', "${contextPath}/intctet/evaluationActualize/saveConfirmCtrlDefect.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						 //回显字段
						 if(data){
							 for(var p in data){
								 var v = data[p];
								 $('#defect_'+p).val(v);
							 }
						 }
						 var parentWin = aud$parentDialogWin();
						 parentWin.aud$defectGrid ?  parentWin.aud$defectGrid.refresh() : null;
						 
						 if(isClose){		
							 aud$closeTopDialog();
						 }
					 }
				 }
			 });
		}catch(e){
			alert("saveDefect:\n"+e.message);
		}
	}
   
	//查看缺陷等级
	$('#view_defectLevel').bind('click', function(){
		new aud$createTopDialog({
			title:'缺陷等级标准查看',
			url:'${contextPath}/intctet/sysManage/defectLevel/initDefectPage.action?view=true'
		}).open();
	});
	//处理double金额显示的科学计数法, 并转换成千分位显示
	aud$handleMoneyEFormat("defect",["relateLoss"], isView);
});
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<<body style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;margin:0px 0px -1px 0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
			<a href="javascript:void(0)" id='mSaveBtn' class="easyui-splitbutton"   
	        data-options="menu:'#muItem',iconCls:'icon-save'">保存</a>   
			<div id="muItem" style="width:100px;">   
			    <div id='mSaveBtn2' data-options="iconCls:'icon-save'">保存并关闭</div>
			</div>  
 			<a id='mCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>	
	</div>
	<div region='center' border='0' >
		<form id="defectForm" name="defectForm">
			<input type='hidden'  id='defect_cdId' name='defect.cdId' value="${defect.cdId}"/>
			<input type='hidden'  id='defect_projectId' name='defect.projectId' value="${defect.projectId}"/>
			<input type='hidden'  id='defect_manuId' name='defect.manuId' value="${defect.manuId}"/>
			<input type='hidden'  id='defect_manuIndex' name='defect.manuIndex' value="${defect.manuIndex}"/>
			<input type='hidden'  id='defect_mpCode' name='defect.mpCode' value="${defect.mpCode}"/>
			<input type='hidden'  id='defect_mpName' name='defect.mpName' value="${defect.mpName}"/>
			<input type='hidden'  id='defect_cpCode' name='defect.cpCode' value="${defect.cpCode}"/>
			<input type='hidden'  id='defect_cpId' name='defect.cpId' value="${defect.cpId}"/>
			<input type='hidden'  id='defect_cpName' name='defect.cpName' value="${defect.cpName}"/>
			<table class="ListTable" align="center" style='table-layout:fixed;width:100%;margin:0px;'>
				<tr style="height:0px;">
					<td style="width:15%;"></td><td style="width:35%;"></td>
					<td style="width:15%;"></td><td style="width:35%;"></td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>内控缺陷简述</td>
					<td class="editTd"    colspan='3'>
						<input type='text' id='defect_defectName' name='defect.defectName' value="${defect.defectName}"
						title='内控缺陷简述' class="noborder editElement clear required len50" />
						<span id='view_defectName' class="noborder viewElement clear" >${defect.defectName}</span>
						<font class='editElement' color='red'>（50字以内）</font>
					</td>					

				</tr>
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>内控缺陷编号</td>
					<td class="editTd"   >
						<input type='hidden' id='defect_defectCode' name='defect.defectCode' value="${defect.defectCode}"
						 title="内控缺陷编号" class="noborder  clear" />
						<span id='view_defectCode' class="noborder  clear" >${defect.defectCode}</span>
					</td>
					<td class="EditHead"  nowrap>涉及单位及部门</td>
					<td class="editTd"   >
						<input type='text' id='defect_involveDept' name='defect.involveDept' value="${defect.involveDept}"
						 class="noborder editElement clear" />
						<span id='view_involveDept' class="noborder viewElement clear" >${defect.involveDept}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap>内控缺陷描述</br>
						<font class='editElement' color='red'>（1000字以内）</font>
					</td>
					<td class="editTd"   colSpan="3">
						<textarea  title="内控缺陷描述" id='defect_defectDescription' name='defect.defectDescription' 
						class="noborder editElement clear len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${defect.defectDescription}</textarea>
						<textarea id='view_defectDescription' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${defect.defectDescription}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap>缺陷成因</br>
						<font class='editElement' color='red'>（1000字以内）</font>
					</td>
					<td class="editTd"   colSpan="3">
						<textarea  title="内控缺陷描述" id='defect_defectCause' name='defect.defectCause' 
						class="noborder editElement clear  len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${defect.defectCause}</textarea>
						<textarea id='view_defectCause' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${defect.defectCause}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>缺陷类型</td>
					<td class="editTd"   >
						<input type='text' id='defect_defectTypeName' name='defect.defectTypeName' value="${defect.defectTypeName}" 
						 title='缺陷类型' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='defect_defectTypeCode' name='defect.defectTypeCode' value="${defect.defectTypeCode}" 
						 title='缺陷类型Code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'缺陷类型选择',
				                  onlyLeafClick:true,
								  param:{
									'plugId':'710020',
								    'whereHql':'type=\'710020\'',
								    'customRoot':'缺陷类型',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_defectTypeName' class="noborder viewElement clear" >${defect.defectTypeName}</span>
					</td>
					<td class="EditHead"  nowrap>涉及的损失/错报的金额</td>
					<td class="editTd"   >
						<input type='text' id='defect_relateLoss' name='defect.relateLoss' value="${defect.relateLoss}"
						class="noborder editElement clear  money len20"/>
						<span id='view_relateLoss' class="noborder viewElement clear" >${defect.relateLoss}</span>万元
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap>风险及影响</br>
						<font class='editElement' color='red'>（1000字以内）</font>
					</td>
					<td class="editTd"   colSpan="3">
						<textarea  title="风险及影响" id='defect_riskEffect' name='defect.riskEffect' 
						class="noborder editElement clear  len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${defect.riskEffect}</textarea>
						<textarea id='view_riskEffect' class="noborder viewElement clear" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${defect.riskEffect}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>初步认定结果</td>
					<td class="editTd"   >
						<input type='text' id='defect_initialIdentify' name='defect.initialIdentify' value="${defect.initialIdentify}" 
						 title='初步认定结果' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='defect_initialIdentifyCode' name='defect.initialIdentifyCode' value="${defect.initialIdentifyCode}" 
						 title='初步认定结果Code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'初步认定结果选择',
				                  onlyLeafClick:true,
								  param:{
									'plugId':'DefectLevel',
								    'customRoot':'初步认定结果',
								  	'rootParentId':'notnull',
				                    'beanName':'DefectLevel',
				                    'treeId'  :'dlId',
				                    'treeText':'dlLevel',
				                    'treeParentId':'code',
				                    'treeOrder':'code'
				                  }
						})"></a>
						<span id='view_initialIdentify' class="noborder viewElement clear" >${defect.initialIdentify}</span>
						<a id='view_defectLevel' title="缺陷等级标准查看" class="easyui-linkbutton" iconCls="icon-view" 
						style='border-width:0px;'></a>
					</td>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>整改建议</td>
					<td class="editTd"   >
						<input type='text' id='defect_mendAdvice' name='defect.mendAdvice' value="${defect.mendAdvice}" 
						 title='整改建议' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='defect_mendAdviceCode' name='defect.mendAdviceCode' value="${defect.mendAdviceCode}" 
						 title='整改建议Code' class="noborder editElement clear required" readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'整改建议选择',
				                  onlyLeafClick:true,
								  param:{
									'plugId':'710030',
								    'whereHql':'type=\'710030\'',
								    'customRoot':'整改建议',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_mendAdvice' class="noborder viewElement clear" >${defect.mendAdvice}</span>	
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>整改建议描述</br>
						<font class='editElement' color='red'>（1000字以内）</font>
					</td>
					<td class="editTd"   colSpan="3">
						<textarea  title="整改建议描述" id='defect_suggestDescription' name='defect.suggestDescription' 
						class="noborder editElement clear required len1000" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${defect.suggestDescription}</textarea>
						<textarea id='view_suggestDescription' class="noborder viewElement clear required" 
						style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${defect.suggestDescription}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap>整改责任单位</td>
					<td class="editTd"   >
						<input type='hidden' id='defect_accountabilityUnit' name='defect.accountabilityUnit' value="${defect.accountabilityUnit}" 
						 class="noborder   " readonly/>
						<input type='hidden' id='defect_accountabilityUnitCode' name='defect.accountabilityUnitCode' value="${defect.accountabilityUnitCode}" 
						  class="noborder   " readonly/>
						<span id='view_accountabilityUnit' class="noborder  " >${defect.accountabilityUnit}</span>
					</td>
					<td class="EditHead"  nowrap>整改主责部门</td>
					<td class="editTd"   >
						<input type='text' id='defect_accountabilityDept' name='defect.accountabilityDept' 
					    value="${defect.accountabilityDept}" readonly
						class="noborder editElement clear "/>
						<input type='hidden' id='defect_accountabilityDeptCode' name='defect.accountabilityDeptCode' title="审计单位ID"  
						value="${defect.accountabilityDeptCode}" readonly
						class="noborder editElement clear "/>
						<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
	                             title:'整改主责部门选择',
								 param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
					              }                                  
							})"></a>
						<span id='view_accountabilityDept' class="noborder viewElement clear" >${defect.accountabilityDept}</span>	
					</td>
				</tr>
					
				<tr>
					<td class="EditHead"  nowrap>整改责任人</td>
					<td class="editTd"   >
						<input type='text' id='defect_personLiable' name='defect.personLiable' value="${defect.personLiable}"
						class="noborder editElement clear" />
						<span id='view_personLiable' class="noborder viewElement clear" >${defect.personLiable}</span>
					</td>
					<td class="EditHead"  nowrap>联系电话</td>
					<td class="editTd"   >
						<input type='text' id='defect_telephone' name='defect.telephone' value="${defect.telephone}"
						class="noborder editElement clear phone len15" />
						<span id='view_telephone' class="noborder viewElement clear" >${defect.telephone}</span>
					</td>
				</tr>	
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>整改期限</td>
					<td class="editTd"   colSpan="3">
						<span class='editElement'>
							<input type='text' id='defect_mendDeadlineBegin' name='defect.mendDeadlineBegin'   value="${defect.mendDeadlineBegin}"
							title="整改期限-开始" class="easyui-datebox noborder clear required" editable="false"/>
						</span>	
						<span class='editElement'>&nbsp;至&nbsp;</span>
						<span class='editElement'>	
							<input type='text' id='defect_mendDeadlineEnd' name='defect.mendDeadlineEnd' compareval="gte&defect_mendDeadlineBegin"  value="${defect.mendDeadlineEnd}"
							title="整改期限-结束" class="easyui-datebox noborder clear required" editable="false"
							compareval="gte&defect_mendDeadlineBegin" />
						</span>
						<span id='view_mendDeadlineBegin' class="noborder viewElement clear">
						${defect.mendDeadlineBegin}&nbsp;至&nbsp;${defect.mendDeadlineBegin}</span>
					</td>
				</tr>	
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>监督检查人</td>
					<td class="editTd"   >
						<input type='text' id='defect_checkPeople' name='defect.checkPeople' value="${defect.checkPeople}"
						 title="监督检查人" class="noborder editElement clear required"  readonly/>
						<input type='hidden' id='defect_checkPeopleCode' name='defect.checkPeopleCode' value="${defect.checkPeopleCode}" 
						 title="监督检查人Code" class="noborder  editElement clear required " readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
					    	onclick="showSysTree(this,{
			                                  title:'监督检查人选择',
			                                  treeTabTitle1:'小组成员',
									          queryBox:false,
									          noMsg:true,
									          allleaf:true,
									          onlyLeafClick:true,
											  param:{
											  	'plugId':'InterMember_editManu',
											  	'rootParentId':'notnull',
											  	'whereHql':aud$genGroupWhere('${groupId}'),
							                    'beanName':'InterMember',
							                    'treeId'  :'userId',
							                    'treeText':'userName',
							                    'treeParentId':'role',
							                    'treeOrder':'role',
				                                'customRoot':'小组成员',
				                                'serverCache':false,
            									'isOracle':false
							                  }
											})"></a>
						<span id='view_checkPeople' class="noborder  viewElement clear" >${defect.checkPeople}</span>
							
					</td>
					<td class="EditHead"  nowrap>检查方式</td>
					<td class="editTd"   >
						<input type='text' id='defect_checkMethod' name='defect.checkMethod' value="${defect.checkMethod}" 
						 title='检查方式' class="noborder editElement clear " readonly/>
						<input type='hidden' id='defect_checkMethodCode' name='defect.checkMethodCode' value="${defect.checkMethodCode}" 
						 title='检查方式Code' class="noborder editElement clear " readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'检查方式选择',
				                  onlyLeafClick:true,
								  param:{
									'plugId':'710040',
								    'whereHql':'type=\'710040\'',
								    'customRoot':'检查方式',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_checkMethod' class="noborder viewElement clear" >${defect.checkMethod}</span>	
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap>缺陷分类</td>
					<td class="editTd"   >
						<input type='text' id='defect_defectClasf' name='defect.defectClasf' value="${defect.defectClasf}"
						 title="缺陷分类" class="noborder editElement clear "  readonly/>
						<input type='hidden' id='defect_defectClasfCode' name='defect.defectClasfCode' value="${defect.defectClasfCode}" 
						 title="缺陷分类Code" class="noborder  editElement clear  " readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'缺陷分类选择',
				                  onlyLeafClick:true,
								  param:{
									'plugId':'710042',
								    'whereHql':'type=\'710042\'',
								    'customRoot':'缺陷分类',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  },
				                  onAfterSure:function(dms,mcs){
				               	  	var mc = mcs[0];
				               	  	if(mc){
				               	  		if(mc.indexOf('其他') == 0){
				               	  			$('#defect_defectClasf').removeAttr('readonly');
				               	  		}else{
				               	  			$('#defect_defectClasf').attr('readonly', 'readonly');
				               	  		}
				               	  	}     	  	
				                  }
						})"></a>
						<span id='view_defectClasf' class="noborder  viewElement clear" >${defect.defectClasf}</span>
							
					</td>
					<td class="EditHead"  nowrap>所属内控要素</td>
					<td class="editTd"   >
						<input type='text' id='defect_blInnerCtrlEle' name='defect.blInnerCtrlEle' value="${defect.blInnerCtrlEle}" 
						 title='所属内控要素' class="noborder editElement clear " readonly/>
						<input type='hidden' id='defect_blInnerCtrlEleCode' name='defect.blInnerCtrlEleCode' value="${defect.blInnerCtrlEleCode}" 
						 title='所属内控要素Code' class="noborder editElement clear " readonly/>
						<a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'所属内控要素选择',
				                  onlyLeafClick:true,
								  param:{
									'plugId':'710041',
								    'whereHql':'type=\'710041\'',
								    'customRoot':'所属内控要素',
								  	'rootParentId':'0',
				                    'beanName':'CodeName',
				                    'treeId'  :'id',
				                    'treeText':'name',
				                    'treeParentId':'pid',
				                    'treeOrder':'name'
				                  }
						})"></a>
						<span id='view_blInnerCtrlEle' class="noborder viewElement clear" >${defect.blInnerCtrlEle}</span>	
					</td>
				</tr>	
				<tr>
					<td class="EditHead"  nowrap>附件</br>
						<div id="fileUploadBtn"></div>
					</td>
					<td class="editTd"  colspan="3">
						<input type="hidden" id="defect_attachmentId" name="defect.attachmentId" value="${defect.attachmentId}" />
						<div id="defectAttachment" style="height:150px;overflow:auto;"></div>
					</td>
				</tr>	
			</table>
		</form>	
	</div>
</body>
</html>