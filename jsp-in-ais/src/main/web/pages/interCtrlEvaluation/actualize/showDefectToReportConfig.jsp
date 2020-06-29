<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<title>内控评价-入报告设置</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){	

	$('#saveBtn').bind('click', function(){
	     var parentWin = aud$parentDialogWin();
	     if(parentWin){	    	 
			 var cdIds = parentWin.aud$getCheckRows(true);
			 if(cdIds && cdIds.length){			 
				 $('#cdIds').val(cdIds.join(','));
			   	 aud$saveForm('reportConfigForm', "${contextPath}/intctet/evaluationActualize/defectJoinReport.action", function(data){
					 if(data){
						 data.msg ? showMessage1(data.msg) : null;	
						 if(data.type == 'info'){					
							 parentWin.refresh();
							 $('#closeBtn').trigger('click');
						 }
					 }
				 });
			 }else{
				 showMessage1("请选择内控缺陷记录!");
				 $('#closeBtn').trigger('click');
			 }
	     }else{
			 showMessage1("无法获得父窗口或者页签对象");
			 $('#closeBtn').trigger('click');
	     }
	});
	
	$('#closeBtn').bind('click', function(){
		aud$closeTopDialog();
	});
	
	$('input:radio[name="inReportCodeRadio"]').bind('click', function(){		
		$('#inReport').val($(this).attr('mc'));
		$('#inReportCode').val($(this).val());		
	});
	
	$('#inReport').val("是");
	$('#inReportCode').val("1");	
	
});
</script>
</head>
<body style='margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div style='text-align:right;border-bottom:1px solid #cccccc;width:100%;'> 
			<a id='saveBtn'  class="easyui-linkbutton" iconCls="icon-save"   style='border-width:0px;'>保存</a>
 			<a id='closeBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>	
	</div>
	<div region='center' border='0' style='overflow:hidden;'>
		<form id="reportConfigForm" name="reportConfigForm">
			<input type="hidden" id="cdIds" name="cdIds" value=""/>
			<input type="hidden" id="projectId" name="projectId" value="${projectId}"/>
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:25%;" nowrap><font class='editElement' color='red'>*</font>是否入报告</td>
					<td class="editTd"   colSpan="3">
						<div>						
							<label style='cursor:pointer;'><input type='radio' name='inReportCodeRadio' value="1"  mc="是" checked />是</label>
							<label style='cursor:pointer;'><input type='radio' name='inReportCodeRadio' value="0"  mc="否"/>否</label>
						</div>
						<input type='hidden' id='inReport' name='inReport' value=""
						 title="是否入报告" class="noborder editElement clear required" />
						<input type='hidden' id='inReportCode' name='inReportCode' value=""
						 title="是否入报告Code" class="noborder editElement clear required" />
					</td>
				</tr>
				<tr>
					<td class="EditHead"  nowrap><font class='editElement' color='red'>*</font>备注说明
					</br><font class='editElement' color='red'>（1000字以内）</font></td>
					<td class="editTd"   colSpan="3">
						<textarea  title="备注说明" id='remark' name='remark'
						 class="noborder editElement clear required len1000" 
						style='border-width:0px;height:110px;width:100%;padding:5px;'></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>

