<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>台账信息查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var curDate = "${curDate}";
	var accountType = "${param.accountType}";
	var apId="${param.apId}";
	//autoTextarea(isView ?  $('#view_remarks')[0] : $('#td_remarks')[0]);
	var fileContainer =  isView ?  $('.editElement').hide() : $('.viewElement').hide();
	var parentTabId = "${parentTabId}";
	var curTabIdac = aud$getActiveTabId();
	
	// 招标信息表单窗口
    $('#accountWin').dialog({
        title:'台账信息',
        collapsible:false,
        modal:true,
        noheader:true,
        fit:true,
		onOpen:function(){
			audEvd$resizeWin('accountWin');
		},
		onClose:function(){
			aud$closeTab(curTabIdac, parentTabId);
		},
        buttons:isView ? [{
                text:'关闭',
                iconCls:'icon-cancel',
                handler:function(){
                    $('#accountWin').dialog('close');
                }
            }   	
        ] : [{
             text:'保存',
             id:'tiSaveBtn',
             iconCls:'icon-save',
             handler:function(){ 
            	 aud$saveForm('accountForm', "${contextPath}/ea/audAccount/saveAccount.action?apId="+apId+"&accountType="+accountType, function(data){
            		 if(data){
            			 data.msg ? showMessage1(data.msg) : null;	
            			 if(data.type == 'info'){
            				var aid = data.aid;
     						if(aid){
     							 $('#at_aid').val(aid);
     						}
            			 	var frameWin = aud$getTabIframByTabId(parentTabId);
            			 	if(accountType=="account"){
 								var winIframe = frameWin.$('#audAccount').get(0).contentWindow;
 								winIframe.accountList.refresh(); 
 	 							$('#accountWin').dialog('close');
            			 	}
            			 	if(accountType == "audConclusion") {
            			 		var winIframe = frameWin.$('#audConclusion').get(0).contentWindow;
            			 		winIframe.accountList.refresh(); 
     							$('#accountWin').dialog('close');
            			 	}
 							
            			 } 
            		 }
            	 });
             }
         },{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#accountWin').dialog('close');
             }
         }]
    });  
	
    aud$handleMoneyEFormat("at",["ssJe","sdJe","sjJe"], isView);
});
 
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<!-- 招标信息表单窗口 -->
	<div id='accountWin' name='accountWin'>
		<div class='easyui-layout' border='0' fit='true'>
			<div region='center' border='0'>
				<form  id='accountForm' name='accountForm' method="POST" >
					<input type='hidden' id="at_aid" name="at.aid"  class="noborder editElement clear" value="${at.aid}"/>  
					<input type='hidden' id="at_apId" name="at.apId"  class="noborder editElement clear" value="${at.apId}"/>  
					<table class="ListTable" align="center" style='table-layout:fixed;'>
						<tr>
							<td class="EditHead" style="width:20%;">项目名称</td>
							<td class="editTd" style="width:30%;">
								<input type='text' id='at_audProjectName' name='at.audProjectName' value="${at.audProjectName}"
								title='项目名称' style='width:100%;border-width:0px;' class="noborder editElement clear" readonly/>
								 <span id='view_audProjectName' class="noborder viewElement clear">${at.audProjectName}</span>
							</td>
							<td class="EditHead" style="width:20%;">送审单位</td>
							<td class="editTd" style="width:30%;">
								 <input type='text' id='at_audUnit' name='at.audUnit'  value="${at.audUnit}"
								style='width:100%;border-width:0px;' class="noborder editElement clear" readonly/>
						 		<input type="hidden" name="at.audUnitId" value="${at.audUnitId}"/>
								<span id='view_audUnit' class="noborder viewElement clear">${at.audUnit}</span>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;"><font class='editElement' color=red>*</font>送审金额</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='at_ssJe' name='at.ssJe' value="${at.ssJe}"
								title='送审金额' class="noborder editElement clear required money len20"/>
								<div id='view_ssJe' class="noborder viewElement clear" 
								style='width:50%;display:inline;'>${at.ssJe}</div>元
							</td>
							<td class="EditHead" style="width:15%;"><font class='editElement' color=red>*</font>审定金额</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='at_sdJe' name='at.sdJe' value="${at.sdJe}"
								 title='审定金额' class="noborder editElement clear required money len20" />
								<div id='view_sdJe' class="noborder viewElement clear"
								 style='width:50%;display:inline;'>${at.sdJe}</div>元
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;"><font class='editElement' color=red>*</font>审减金额</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='at_sjJe' name='at.sjJe' value="${at.sjJe}"
								class="noborder editElement clear  required money len20"/>
								<div id='view_sjJe' class="noborder viewElement clear" 
								style='width:50%;display:inline;'>${at.sjJe}</div>元
							</td>
							<td class="EditHead" style="width:15%;"><font class='editElement' color=red>*</font>审减比例</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='at_sjScale' 
								name='at.sjScale' class="noborder editElement clear required money" value="${at.sjScale}"/>
								<div id='view_acceptanceCost' 
								class="noborder viewElement clear" style='width:50%;display:inline;'>${at.sjScale}</div>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">向建设单位反馈时间</td>
							<td class="editTd" style="width:35%;">
								<div class='editElement'>
									<input type='text' id='at_feedbackTime' name='at.feedbackTime' value="${at.feedbackTime}"
									class="easyui-datebox noborder clear" editable="false"/>
								</div>
								<div id='view_feedbackTime' class="noborder viewElement clear" style='width:50%;display:inline;'>${at.feedbackTime}</div>
							</td>
							<td class="EditHead" style="width:15%;">反馈方式</td>
							<td class="editTd" style="width:35%;">
								<input type='text' id='at_feedbackWay' 
								name='at.feedbackWay' class="noborder editElement clear" value="${at.feedbackWay}"/>
								<div id='view_feedbackWay' 
								class="noborder viewElement clear" style='width:50%;display:inline;'>${at.feedbackWay}</div>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">反馈结果</td>
							<td class="editTd">
								<input type='text' id='at_feedResult' 
								name='at.feedResult' class="noborder editElement clear" value="${at.feedResult}"/>
								<div id='view_feedResult' 
								class="noborder viewElement clear" style='width:50%;display:inline;'>${at.feedResult}</div>
							</td>
							<td class="EditHead" style="width:15%;"></td>
							<td class="editTd">
							</td>
						</tr>
					
						<tr>
							<td class="EditHead" style="width:15%;">创建日期</td>
							<td class="editTd" style="width:35%;">
								<span id='at_createTime'  class="noborder editElement clear" datatype='date'>${at.createTime}</span>
								<span id='view_createTime' class="noborder viewElement clear" datatype='date'
								style='width:50%;display:inline;'>${at.createTime}</span>
							</td>
							<td class="EditHead" style="width:15%;">最后修改日期</td>
							<td class="editTd" style="width:35%;">
								<span id='at_modifyTime'  class="noborder editElement clear" datatype='date'>${at.modifyTime}</span>
								<span id='view_modifyTime' class="noborder viewElement clear" datatype='date'
								style='width:50%;display:inline;'>${at.modifyTime}</span>
							</td>
						<tr>
					</table>
				</form>			
			</div>
		
		</div>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>