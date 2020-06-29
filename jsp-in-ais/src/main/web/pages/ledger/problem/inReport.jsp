<!DOCTYPE HTML>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>入报告问题</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>

	<script type="text/javascript">	
		function myCheck(){
			var isReport = $('#isReport').val();
			var remarks = $('#remarks').val();
			var inReport_id = '${str}';
			if(isReport == '否'){
				 if($.trim(remarks) == ""){
					 $.messager.show({
		            		title:"提示信息",
		            		msg:"备注说明不能为空,请完善信息!",
		            		timeout:5000,
		            		showType:'slide'
		            	});
		    		return false;
				 }
			 }
            //ajax实时验证
			$.ajax({
				   type: "POST",
				   url: "${contextPath}/proledger/problem/checkinReportCondition.action",
				   data: {"ids":inReport_id},
				   success: function(returnValue){
				   		if(returnValue=='3'){
			            	window.parent.$.messger.show({
			            		title:"提示信息",
			            		msg:"所选问题已入报告，请重新选择!",
			            		timeout:5000,
			            		showType:'slide'
			            	});
			            	return;
			            }else{
									$.ajax({
										type: "POST",
										dataType:'json',
										url : "/ais/proledger/problem/doInReport.action",
										data:{
											'ledgerProblem.remarks':remarks,
											'ledgerProblem.isInReport':isReport,
											'str':inReport_id
										},
										success: function(data){
											if(data.type == 'ok'){
												window.parent.saveCloseWin();
											}else{
												showMessage1("保存失败！");
											}		
										},
										error:function(data){
											showMessage1("请求失败！");
										}
									});				            	
			            	
			            }
				   }
			});	   
			 
		}
		function doClear(){
			window.parent.closeWin();
		}
		function changeStatus(values){
			if(values=="否"){
		        document.getElementById("remarkColour").style.display="";
		    }else{
		        document.getElementById("remarkColour").style.display="none";
		    }
		}
		function isChage(){
			var val = '${ledgerProblem.isInReport}';
			if(val=="否"){
		        document.getElementById("remarkColour").style.display="";
		    }else{
		        document.getElementById("remarkColour").style.display="none";
		    }
		}
	</script>
</head>
<!-- <body bgcolor="#DEE7FF" topmargin=8 leftmargin=8 rightmargin="8" onload="afterSave()"> -->
<body onload="isChage();" >
<div id="inReport" title="入报告问题" style='overflow:hidden;padding:0px;'>
			<s:form id="sendBackForm" action="" namespace="" method="post" >
					<table class="ListTable" align="center" >
						<tr class="listtablehead">
							<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 10%">
								是否入报告：
							</td>
							<td class="editTd" style="width: 90%">
								<s:select name="ledgerProblem.isInReport" id="isReport"
									list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" listKey="key" listValue="value" onchange="changeStatus(this.value);" />
							</td>
						</tr>
						<tr class="listtablehead">
							<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 10%"><span id="remarkColour" style="color:red;">*</span>
								备注说明：
							</td>
							<td class="editTd" style="width: 90%">
								<s:textarea id="remarks" name="ledgerProblem.remarks" cssStyle="width:350" />
							</td>
						</tr>
					</table>
				</s:form>
				<input  type="hidden" name="ledgerProblem.inReport_id" id="inReport_id"/>
				<div style='text-align:center;' id='InReportBtnDiv' style='padding:10px;'>
	        		<a  id='saveId'  class="easyui-linkbutton"  iconCls="icon-save" onclick=" myCheck()">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<a  id='closeInReport' class="easyui-linkbutton"  iconCls="icon-cancel" onclick="doClear()">关闭</a>							        
			    </div>
		</div>
</body>
</html>
