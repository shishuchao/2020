<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>合同信息添加、修改、查看</title>
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
	/* autoTextarea(isView ?  $('#view_remarks')[0] : $('#ct_remarks')[0]); */
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	
	var fileGuid = "${fileGuid}" || "${ct.attachmentId}";
	$('#ct_attachmentId').val(fileGuid);
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
		$("#ctSaveBtn").bind('click', function(){
			 var inviteTdValue = $('#inviteTdCode').combobox('getText');//是否招标合同
        	 var bankGuaranteeValue = $('#bankGuaranteeCode').combobox('getText');//是否银行保函
        	 $("#inviteTd").val(inviteTdValue);
        	 $("#bankGuarantee").val(bankGuaranteeValue);
		   	 aud$saveForm('contractInfoForm', "${contextPath}/ea/contractInfo/saveContract.action?pid="+pid, function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						 var ctId = data.ctId;
						 if(ctId){
							$('#ct_ctId').val(ctId);
						}
						//是否从项目送审窗口打开
						var winSelect = "${winSelect}";
						if(winSelect == true || winSelect == 'true'){
							var frameWin = aud$getTabIframByTabId(parentTabId);
							var dvapWin = frameWin.$('#projectInfo').get(0).contentWindow;
							var winIframe = dvapWin.$('#contractInfo').find('iframe');
							winIframe.get(0).contentWindow.contractInfoList.refresh(); 
						}else{
							var frameWin = aud$parentDialogWin();
							var winIframe = frameWin.$('#contractInfo').get(0).contentWindow;
	    			 		winIframe.contractInfoList.refresh();  					
						}
						aud$closeTopDialog();
					 }
				 }
			 });
		});
	}else{
		$("#ctSaveBtn").remove();
	}
	$("#ctCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	$('#ctlayout').layout('resize'); 
	
	//处理double金额显示的科学计数法
	aud$handleMoneyEFormat("ct",["ctSigningAmount","acceptanceCost"], isView);
});
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id="ctlayout" class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
		    <a id='ctSaveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
 			<a id='ctCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>
	</div>
	<div region='center' border='0'>
		<form  id='contractInfoForm' name='contractInfoForm' method="POST" style="border:0px;padding:0px;margin:0px;">
			<input type='hidden' id="ct_ctId" name="ct.ctId"  class="noborder editElement clear" value="${ct.ctId}"/>
			<input type='hidden' id='ct_attachmentId' name='ct.attachmentId' class="noborder editElement" value="${ct.attachmentId}" style='width:500px;'/>    			
			<table class="ListTable" align="center" style="table-layout:fixed;width:100%;border:0px;padding:0px;margin:0px;">
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>合同编号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctNumber' name='ct.ctNumber' title='合同编号' value="${ct.ctNumber}" 
						class="noborder editElement clear len50 required"/>
						<span id='view_ctNumber' class="noborder viewElement clear" style='width:50%;display:inline;'>
						${ct.ctNumber }</span>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>合同名称</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctName' name='ct.ctName' title='合同名称' value="${ct.ctName}" 
						class="noborder editElement clear len100 required"/>
						<div id='view_ctName' class="noborder viewElement clear" style='width:50%;display:inline;'>${ct.ctName}</div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">合同类型</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctType' name='ct.ctType' title='合同类型'	 value="${ct.ctType}" readonly class="noborder editElement clear"/>
						<input type='hidden' id='ct_ctTypeCode' name='ct.ctTypeCode' title='合同类型code'	value="${ct.ctTypeCode}" class="noborder editElement clear"/>
						<a class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
									onclick="showSysTree(this,{
		                                  title:'合同类型选择',
		                                  onlyLeafClick:true,
										  param:{
											'plugId':'6004',
										  	'rootParentId':'0',
						                    'beanName':'CodeName',
						                    'whereHql':'type=\'6004\'',
						                    'treeId'  :'id',
						                    'treeText':'name',
						                    'treeParentId':'pid',
						                    'treeOrder':'code'
						                 }                                  
								})"></a>						
						<span id='view_ctType' class="noborder viewElement clear" style='width:50%;display:inline;'>${ct.ctType}</span>
					</td>
					<td class="EditHead" style="width:15%;">合同属性</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctAttr' name='ct.ctAttr' title='合同属性' value="${ct.ctAttr}" class="noborder editElement clear" readonly/>
						<input type='hidden' id='ct_ctAttrCode' name='ct.ctAttrCode' title='合同属性code' value="${ct.ctAttrCode}"  class="noborder editElement clear"/>
						<a class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
									onclick="showSysTree(this,{
		                                  title:'合同属性选择',
		                                  onlyLeafClick:true,
										  param:{
											'plugId':'6005',
										  	'rootParentId':'0',
						                    'beanName':'CodeName',
						                    'whereHql':'type=\'6005\'',
						                    'treeId'  :'id',
						                    'treeText':'name',
						                    'treeParentId':'pid',
						                    'treeOrder':'code'
						                 }                                  
								})"></a>
						<div id='view_ctType' class="noborder viewElement clear" style='width:50%;display:inline;'>${ct.ctAttr}</div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">合同甲方</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctPartA' name='ct.ctPartA' value="${ct.ctPartA}" 
						class="noborder editElement clear len100"/>
						<div id='view_ctPartA' class="noborder viewElement clear" style='width:50%;display:inline;'>
						${ct.ctPartA}</div>
					</td>
					<td class="EditHead" style="width:15%;">合同乙方</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctPartB' name='ct.ctPartB' value="${ct.ctPartB}"
						class="noborder editElement clear len100"/>
						<div id='view_ctPartB' class="noborder viewElement clear" style='width:50%;display:inline;'>
						${ct.ctPartB}</div>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">合同丙方</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctPartC' name='ct.ctPartC' value="${ct.ctPartC}" 
						class="noborder editElement clear len100"/>
						<div id='view_ctPartC' class="noborder viewElement clear" style='width:50%;display:inline;'>
						${ct.ctPartC}</div>
					</td>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>合同签订金额</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_ctSigningAmount' name='ct.ctSigningAmount' value="${ct.ctSigningAmount}" 
						class="noborder editElement clear len50 money required"/>
						<div id='view_ctSigningAmount' class="noborder viewElement clear" style='width:50%;display:inline;'>${ct.ctSigningAmount}</div>元
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">是否招标合同</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='inviteTd' name='ct.inviteTd' value="${ct.inviteTd}" 
						class="noborder editElement clear"/>
						<s:if test="${view!=true}">
							<select class="easyui-combobox" id="inviteTdCode" name="ct.inviteTdCode" style="width:150px;" editable="false">
					   	    	<option value="">&nbsp;</option>
						      	<s:iterator value="#@java.util.LinkedHashMap@{0:'否',1:'是'}" id="status">
						      		<s:if test="${ct.inviteTdCode==key}">							      			
						         		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						      		</s:if>
						      		<s:else>							       	 	
						      			<option value="<s:property value="key"/>"><s:property value="value"/></option>
						         	</s:else>
						      	</s:iterator>							      	
					    	</select>
					    </s:if>
					    <s:else>
					    	<div id='view_inviteTd' class="noborder viewElement clear" style='width:50%;display:inline;'>
					    	${ct.inviteTd}</div>
				    	</s:else>
					</td>
					<td class="EditHead" style="width:15%;">中标金额</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='ct_acceptanceCost' name='ct.acceptanceCost' value="${ct.acceptanceCost}" 
						class="noborder editElement clear len50 money"/>
						<div id='view_acceptanceCost' class="noborder viewElement clear" style='width:50%;display:inline;'>${ct.acceptanceCost}</div>元
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">合同签订日期</td>
					<td class="editTd" style="width:35%;">
						<div class='editElement'>
							<input type='text' id='ct_signedDate' name='ct.signedDate' value="${ct.signedDate}" 
							class="easyui-datebox noborder  clear" editable="false"/>
						</div>
							<div id='view_signedDate' class="noborder viewElement clear" style='width:50%;display:inline;'>
							${ct.signedDate}</div>
					</td>
					<td class="EditHead" style="width:15%;">是否银行保函</td>
					<td class="editTd" style="width:35%;">
						<input type='hidden' id='bankGuarantee' name='ct.bankGuarantee' value="${ct.bankGuarantee}" 
						class="noborder editElement clear"/>
						<s:if test="${view != true}">
							<select class="easyui-combobox" id="bankGuaranteeCode" name="ct.bankGuaranteeCode" style="width:150px;" editable="false">
					   	    	<option value="">&nbsp;</option>
					      	 	<s:iterator value="#@java.util.LinkedHashMap@{0:'否',1:'是'}" id="status">
									<s:if test="${ct.bankGuaranteeCode==key}">
						         		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       		</s:if>
						       		<s:else>
						       	 		<option value="<s:property value="key"/>"><s:property value="value"/></option>						       	 		
									</s:else>
						      	</s:iterator>
					    	</select>
					    </s:if>
					    <s:else>
				    		<span id='view_bankGuarantee' class="noborder viewElement clear" style='width:50%;display:inline;'>${ct.bankGuarantee}</span>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;">创建日期</td>
					<td class="editTd" style="width:35%;">
						<div class='editElement'>
							<span id='ct_createTime'  class="noborder editElement clear" datatype='date'>${ct.createTime}</span>
							<span id='view_createTime' class="noborder viewElement clear" datatype='date'
							style='width:50%;display:inline;'>${ct.createTime}</span>
					</td>
					<td class="EditHead" style="width:15%;">最后修改日期</td>
					<td class="editTd" style="width:35%;">
						<span id='ct_createTime'  class="noborder editElement clear" datatype='date'>${ct.modifyTime}</span>
						<span id='view_createTime' class="noborder viewElement clear" datatype='date'
						style='width:50%;display:inline;'>${ct.modifyTime}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" >合同主要内容</td>
					<td class="editTd" colspan='3'>
						<textarea type='text' id='ct_ctContent' name='ct.ctContent' 
						class="noborder editElement clear len2000" style='border-width:0px;height:50px;width:99%;'>${ct.ctContent}</textarea>
						<textarea id='view_ctContent' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${ct.ctContent}</textarea>
					</td>							
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" >合同摘要条款</td>
					<td class="editTd" colspan='3'>
						<textarea type='text' id='ct_ctAbstractClause' name='ct.ctAbstractClause' 
						class="noborder editElement clear len2000" style='border-width:0px;height:50px;width:99%;'>${ct.ctAbstractClause}</textarea>
						<textarea id='view_ctAbstractClause' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${ct.ctAbstractClause}</textarea>
					</td>							
				</tr>	
				<tr>
					<td class="EditHead" style="width:15%;" >合同付款条款</td>
					<td class="editTd" colspan='3'>
						<textarea type='text' id='ct_ctPaymentClause' name='ct.ctPaymentClause'
						class="noborder editElement clear len2000" style='border-width:0px;height:50px;width:99%;'>${ct.ctPaymentClause}</textarea>
						<textarea id='view_ctPaymentClause' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${ct.ctPaymentClause}</textarea>
					</td>							
				</tr>	
				<tr>
					<td class="EditHead" style="width:15%;" >备注</td>
					<td class="editTd" colspan='3'>
						<textarea type='text' id='ct_remarks' name='ct.remarks' 
						class="noborder editElement clear len2000" style='border-width:0px;height:50px;width:99%;'>${ct.remarks}</textarea>
						<textarea id='view_remarks' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${ct.remarks}</textarea>
					</td>							
				</tr>					
			</table>
		</form>
			</div>			
			<div region="south" style="overflow:hidden;" border='0' title="">
                <div id="edit_attachFile" class=" editElement "></div>
                <div id="view_attachFile" class=" viewElement "></div>
			</div>
		</div>
	</div>
	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>