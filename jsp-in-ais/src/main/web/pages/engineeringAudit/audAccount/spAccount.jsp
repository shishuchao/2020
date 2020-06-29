<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>审批页面</title>
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
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	var type="${param.type}";
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	autoTextarea(isView ?  $('#view_spcontent')[0] : $('#spat_spcontent')[0]);

	$('#mPostBtn').bind('click', function(){
		postInfo();
	});
	$('#completeBtn').bind('click', function(){
		postInfo(true);
	});
	$('#mCloseBtn').bind('click', function(){
		aud$closeTopDialog();
	});
	
	
	
	function postInfo(isComplete){
		if(isComplete){
			$('#spat_nextPeople, #spat_nextPeopleid').removeClass("required");
			$("#spat_nextPeopleR").hide();
		}
		aud$saveForm('spaccountForm', "${contextPath}/ea/audAccount/submitSpAccount.action?oldSaid=${oldSaid}&aid=${aid}&apId=${apId}&type="+type, function(data){
			 if(data){
				 data.msg ? showMessage1(data.msg) : null;	
				 if(data.type == 'info'){
					try{						
						//刷新待办事项
						if(!isComplete){							
	    					var homeIfm = aud$getTabIframByTabId('home');
							if(homeIfm && homeIfm.projectAuditFirstPage){
	       						homeIfm.projectAuditFirstPage.toDoTable();
							}
						}
					}catch(e){
						//alert(e.message);
					}	
					
					try{	
	   					 if("${fromtodo}" == 'true'){//从待办发起
							 //alert(data.said+"\n${apId}\n"+type)
	   						 if(isComplete){
	   							 completeInfo(data.said, "${apId}", type);
	   						 }else{
   								aud$closeParentDialog();
   								aud$closeTopDialog();
	   						 }
						 }else{
							 if(isComplete){
	   							 completeInfo(data.said, "${apId}", type);
	   						 }
							 
							 
		    				 var frameWin = aud$parentDialogWin();
		    				 var winIframe = null;
		    				 if(type=="audConclusion"){//审计结论
								 $('#mCloseBtn').trigger('click');
	        				 	 winIframe = frameWin.$('#audConclusion').get(0).contentWindow;
		        				 if(winIframe){
		        				 	winIframe.conInfoList.refresh();
		        					winIframe.$('#createBtn, #approveBtn,#completeBtn').remove();
		        				 }
		    				 }else if(type=="account"){//项目台账
								 $('#mCloseBtn').trigger('click');
	        				 	 winIframe = frameWin.$('#audAccount').get(0).contentWindow;
		        				 if(winIframe){
		        					winIframe.spAccountInfo.refresh();
	        						var accountWin = winIframe.$('#b_ifr')[0].contentWindow;
	        						if(accountWin){        							
		        						accountWin.$('#approveBtn,#completeBtn').remove();
		        						accountWin.aud$readonlyFormView();
	        						}
		        				 }
		    				 }
						 }
					 }catch(e){
						 //alert(e.message)
					 }
				 }
			 }
		 });
	 }
	
	//审批完成
	 function completeInfo(said, apId, type){
			$.ajax({
				url : "${contextPath}/ea/audAccount/completeAccount.action",
				dataType:'json',
				type:"post",
				data:{
					"said":said,
					"apId":apId,
					"type":type
				},
				success: function(data){
					data.msg ? showMessage1(data.msg) : null;
					if(data.type == "info"){
						try{
							//刷新待办事项
		   					var homeIfm = aud$getTabIframByTabId('home');
							if(homeIfm && homeIfm.projectAuditFirstPage){
		      					homeIfm.projectAuditFirstPage.toDoTable();
							}
						}catch(e){}
						try{
							aud$closeParentDialog();
						}catch(e){}
						try{
							aud$closeTopDialog();
						}catch(e){}

					}
				},
				error:function(data){
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
	 }

});
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div region="north" border="0"  style='padding:0px;overflow:hidden;'>
		<div id='btnBar' style='text-align:right;padding-right:10px;margin-bottom:5px;border-bottom:1px solid #cccccc;width:100%;'>
			<a id='mPostBtn'    class="easyui-linkbutton" iconCls="icon-ok" style='border-width:0px;'>审批</a>
			<a id="completeBtn" class="easyui-linkbutton" iconCls="icon-ok" style='border-width:0px;'>完成</a>
	 		<a id='mCloseBtn'   class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>	
 		</div>
	</div>
	<div region="center" border="0">
		<form id="spaccountForm" name="spaccountForm" style='border-width:0px;'>
			<input type='hidden' id="spat_aid"   name="spat.aid"  value="${spat.aid}"  class="noborder editElement clear" />
			<input type='hidden' id="spat_said"  name="spat.said"  value="${spat.said}"  class="noborder editElement clear" />  
			<table class="ListTable" align="center" style='table-layout:fixed;' style='border-width:0px;'>
					<tr>
						<td class="EditHead"><font color='red' id="spat_nextPeopleR"><strong>*</strong></font>选择下一步处理人</td>
						<td class="editTd" colspan='3'>
							<input type='text' id='spat_nextPeople' name='spat.nextPeople' value="${spat.nextPeople}" readonly
							title='下一步处理人' class="noborder editElement clear required"/>
							<input type='hidden' id='spat_nextPeopleid' name='spat.nextPeopleid' title="下一步处理人ID"  value="${spat.nextPeopleid}"
							class="noborder editElement clear required" readonly/>
							<a id='' class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
								onclick="showSysTree(this,{
	                                  title:'下一步处理人选择',
									  param:{
									  	'rootParentId':'0',
					                    'beanName':'UOrganizationTree',
					                    'treeId'  :'fid',
					                    'treeText':'fname',
					                    'treeParentId':'fpid',
					                    'treeOrder':'fcode'
					                 },
					                 type:'treeAndUser',
					                 singleSelect:true
							})"></a>
							<span id='view_nextPeople' class="noborder viewElement clear" >${spat.nextPeople}</span>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%;" >审批内容</td>
							<td class="editTd"  colspan='3'>
								<textarea  id='spat_spcontent' name='spat.spcontent' class="noborder editElement clear" 
								style='border-width:0px;height:150px;width:99%;overflow:hidden;padding:5px;'>${spat.spcontent}</textarea>
								<textarea id='view_spcontent' class="noborder viewElement clear" 
								style='border-width:0px;height:150px;width:99%;overflow:hidden;padding:5px;' readonly>${spat.spcontent}</textarea>
							</td>
					</tr>
			</table>
		</form>	
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>