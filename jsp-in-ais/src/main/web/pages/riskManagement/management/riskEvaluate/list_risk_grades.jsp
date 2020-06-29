<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>获取风险等级矩阵</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
var colorArray = [{"value":"#00FF00","text":"绿色"},{"value":"#FFFF00","text":"黄色"},{"value":"#FF0000","text":"红色"},{"value":"#FFFFFF","text":"白色"}];
$(function(){
    autoTextarea($('#answerAdvice')[0]);
})
</script>

<style type="text/css">
			#MatrixTable {
				border-collapse:collapse;
				border:solid black; 
				border-width:0 0 0 1px;
				width: 700px;
			}
			#MatrixTable td {border:solid black;border-width:0 1px 1px 0;padding:2px;text-align: center;}
			#MatrixTable .xType{
				background-color: #F2DDDC;
				font-weight: bold;
				border-width:1px 1px 1px 0;
				height: 50;
				cursor: pointer;
			}
			#MatrixTable .yType{
				background-color: #FEFE9A;
				font-weight: bold;
				border-width:1px 1px 1px 0;
				height: 50;
				cursor: pointer;
			}
			#MatrixTable .autoValue{
				cursor: pointer;
				border-width:1px 1px 1px 1px;
			}
		</style>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>
    	<div region="center" id="createtable" style="height:"100%";width:700px;overflow:auto" align="center">
    		<br/>
    		<span style="font-size:20px;font-weight:bold;">评估结果:如下图所示</span>
	   		<table style="width:700px;font-size:20px;font-weight:bold;" cellpadding=1 cellspacing=1 border=0 class="ListTable">
	   		   <tr>
	   				<td class="EditHead">可能性得分</td>
	   				<td class="editTd">
	   					${riskEvaluateDetail.possibleScore}&nbsp;分
	   				</td>
	   				<td class="EditHead">影响程度得分</td>
	   				<td class="editTd">
	   					${riskEvaluateDetail.affectScore}&nbsp;分<br/>
	   				</td>
	   			</tr>
	   			<tr>
	   				<td class="EditHead">综合得分</td>
	   				<td class="editTd">
	   					${riskEvaluateDetail.possibleScore*riskEvaluateDetail.affectScore}&nbsp;分<br/>
	   				</td>
	   				<td class="EditHead"><span style="font-size:16px;color:red;font-weight:bold;">风险等级</span></td>
	   				<td class="editTd">
	   					<s:if test="${riskEvaluateDetail.affectScore * riskEvaluateDetail.possibleScore} == 0 ">
    					  		<span style="font-size:16px;color:red;font-weight:bold;">NA</span>
    					  </s:if>
    					  <s:elseif test="${riskEvaluateDetail.affectScore * riskEvaluateDetail.possibleScore} <=3">
    					  		<span style="font-size:16px;color:red;font-weight:bold;">低</span>
    					  </s:elseif>
    					  <s:elseif test="${riskEvaluateDetail.affectScore * riskEvaluateDetail.possibleScore} <=6">
    					  		<span style="font-size:16px;color:red;font-weight:bold;">中</span>
    					  </s:elseif>
    					  <s:elseif test="${riskEvaluateDetail.affectScore * riskEvaluateDetail.possibleScore} <=16">
    					  		<span style="font-size:16px;color:red;font-weight:bold;">高</span>
    					  </s:elseif>
	   				</td>
	   			</tr>
	   		</table>
    		<br/>
    		<table id="matrixTable">
					<tr>
						<td style="border-width:1 1 1 0;text-align: center;font-size: 16px;font: bolder;">风险等级矩阵</td>
						<s:iterator value="idList">
							<td class="xType"><s:property value="name"></s:property></td>
						</s:iterator>
					</tr>
					<s:iterator value="psList" status="knxStatus">
						<tr>
							<td class="yType" title="${psList[knxStatus.index].code}"><s:property value="name" /></td>
							<s:iterator value="idList" status="yxdjStatus">
								<s:iterator value="riskGrades" status="fxdjStatus">
									<s:if
										test="psList[#knxStatus.index].code*idList[#yxdjStatus.index].code>riskGrades[#fxdjStatus.index].startValue&&psList[#knxStatus.index].code*idList[#yxdjStatus.index].code<=riskGrades[#fxdjStatus.index].endValue">
										<td class="autoValue"
											bgcolor="${riskGrades[fxdjStatus.index].color}">
											<s:if test="psList[#knxStatus.index].code == riskEvaluateDetail.possibleScore && idList[#yxdjStatus.index].code == riskEvaluateDetail.affectScore">
												${riskGrades[fxdjStatus.index].rlName} ① 
											</s:if>
											<s:else>
												${riskGrades[fxdjStatus.index].rlName}
											</s:else>
										</td>
									</s:if>
								</s:iterator>
							</s:iterator>
						</tr>
					</s:iterator>
				</table>
			<div>
				<br/>
				<s:if test="isView != 'Y'">
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveAnswerAdvice()" id="save_id">保&nbsp;&nbsp;存</a>&nbsp;&nbsp;
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="submitAnswerAdvice()" id="save_id">提&nbsp;&nbsp;交</a>
				</s:if>
				<s:form id="myForm">
					<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
						<tr>
							<td class="EditHead">
								<font color="red">*</font>建议风险应对策略及措施<font color="red">（2000字以内）</font>
							</td>
							<td class="editTd" colspan="3">
							<textarea type='text'  id='answerAdvice' name='riskEvaluateDetail.answerAdvice'
									  class="noborder editElement clear len2000" style='border-width:0px;height:100px;width:99%;overflow:hidden;' >${riskEvaluateDetail.answerAdvice}</textarea>
							</td>
						</tr>
					</table>
				</s:form>
			</div>
    	</div>
    </div>
    <script type="text/javascript">
    	function saveAnswerAdvice(){
    		
    		var riskWaitId = "${riskWaitId}";
    		var answerAdvice = $("#answerAdvice").val();
    		if(answerAdvice != '') {
    			$.ajax({
                	url:'${contextPath}/riskManagement/management/riskImplement/saveAnswerAdvice.action',
                	async:false,
                	type:'POST',
                	data:{'answerAdvice':answerAdvice,'riskWaitId':riskWaitId},
                	success:function(data) {
                		if(data == '1') {
                			showMessage1('保存成功！');
                		}
                	}
                });
    		}else{
    			showMessage1('建议风险应对策略及措施不能为空！');
    		}
            
    	}
    	
		function submitAnswerAdvice(){
    		var riskWaitId = "${riskWaitId}";
    		var answerAdvice = $("#answerAdvice").val();
    		
    		var possibleScore = '${riskEvaluateDetail.possibleScore}';
    		if(possibleScore == null || possibleScore == '') {
    			showMessage1('可能性得分不能为空！');
    			return false;
    		}
    		
    		var affectScore = '${riskEvaluateDetail.affectScore}';
    		if(affectScore == null || affectScore == '') {
    			showMessage1('影响程度得分不能为空！');
    			return false;
    		}
    			
    		if(answerAdvice != '') {
            	$.ajax({
            		url:'${contextPath}/riskManagement/management/riskImplement/submitAnswerAdvice.action',
            		async:false,
            		type:'POST',
            		data:{'answerAdvice':answerAdvice,'riskWaitId':riskWaitId},
            		success:function(data) {
            			if(data == '1') {
            				showMessage1('提交成功！');
            				parent.closeWindow();
            			}
            		}
            	});
    		}else{
    			showMessage1('建议风险应对策略及措施不能为空！');
    		}
    	}
    </script>
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
