<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>		
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>自定义台帐</title>
<script type="text/javascript">
$(function(){

	var apId = "${param.apId}";
	var parentTabId ="${param.parentTabId}";
	
	var isView = "${view}" == "true" || "${view}" == true;
	
	setTimeout(function(){
		var topDialogTargetId = parent.$('body').attr("topDialogTargetId");
		if(topDialogTargetId){
			$('body').attr("topDialogTargetId", topDialogTargetId);
		}
		var isFromtodo = "${fromtodo}" == "true" || "${fromtodo}" == true;
		if(isFromtodo){
			$('#saveBtn,#approveBtn').show();
		}else{			
			var accountState = parent.$('#dvAccountState').val();
			//alert(accountState)
			if(accountState == '1' || accountState == '2'){
				isView = true;
				$('#saveBtn,#approveBtn').remove();
			}else{
				$('#saveBtn,#approveBtn').show();
			}
	
			if(isView){			
				readonlyFormView();
			}
		}
		if("${isHaveData}" == "true"){
			$('#approveBtn').show();
		}else{
			$('#approveBtn').hide();
		}
	},0);
	
	
	//审批
	$('#approveBtn').hide().bind('click',function(){
		new aud$createTopDialog({
			title:'台帐审批',
			width:800,
			height:450,
			zIndex:9011,
			url:'${contextPath}/ea/audAccount/spAccount.action?fromtodo=${fromtodo}&oldSaid=${oldSaid}&apId='+apId+'&parentTabId='+parentTabId+'&type=account',
			onClose:function(){},
			onOpen:function(){}
		}).open();
	});
	

	
	//页面只读
	function readonlyFormView(){
		$('#saveBtn,#approveBtn').remove();
		$('#myform').find("input[type='text']").css({
			'border':'0px'
		}).attr('readonly', true).wrap(function(){
			return "<span>"+$(this).hide().val()+"</span>"
		});	
	}
	window.aud$readonlyFormView = readonlyFormView;

	
})
function sucFun(){
  		if($("#sucFlag").val()=='1'){
  			parent.location.reload();
  			$("#sucFlag").val('');
  			showMessage1('保存成功！');
  		}        		
 		}
function JHshNumberText(){
	if ( !(((window.event.keyCode >= 48) && (window.event.keyCode <= 57)) 
	|| (window.event.keyCode == 13) || (window.event.keyCode == 46) 
	|| (window.event.keyCode == 45))){
		window.event.keyCode = 0 ;
		showMessage1('只能输入数字！');
	}
} 

function validate(key,name){
	var value=document.getElementsByName("ledger_"+key)[0].value;
	if(!isMoneyNum(value)){
		showMessage1(name+" 输入错误！");
		//document.getElementsByName('ledger_'+key)[0].focus;
		var aa="ledger_"+key;
		window.setTimeout("document.getElementsByName('"+aa+"')[0].focus();", 50);  
		//event.returnValue=false;
		return false;
	}
}
function isMoneyNum(str){
	return (new RegExp( /(^-?(?:(?:\d{0,3}(?:,\d{3})*)|\d*))(\.\d{1,2})?$/).test(str));
      }
function backList(){
	var url = "${pageContext.request.contextPath}/ledger/prjledger/projectLedgerNew/createLedgerExcel.action";
	myform.action = url;
	myform.submit();
}
function toSave() {
	var url = "${pageContext.request.contextPath}/ea/audAccount/saveLedger.action";
	myform.action = url;
	myform.submit();
}
</script>
<s:property value="javaScript" escape="false" />
</head>
<body onload="sucFun();">
	<s:form id="myform" name="form" action="save" namespace="/ledger/customledger">
		<div style='text-align:right;'>
			<span id="saveBtn"     class="easyui-linkbutton" onclick="toSave();" data-options="iconCls:'icon-save'" style='display:none;'>保存</span>
			<span id="approveBtn"  class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style='display:none;'>审批</span>
			<!-- <a id="btn" href="javascript:void(0);" class="easyui-linkbutton" onclick="backList();" data-options="iconCls:'icon-export'">导出</a> -->
		</div>
		<s:hidden name="apId" />
		<input type="hidden" name="sucFlag" id="sucFlag" value="${tip}"/>
		<s:hidden name="p_subject" id="p_subject" />
		<s:property value="str" escape="false" />
	</s:form>
	<!-- 引入公共文件 -->
 	<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>