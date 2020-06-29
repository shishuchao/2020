<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>修改内控缺陷</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var fileContainer =  'view_attachFile' ;
	var fileGuid = "${fileGuid}" || "${reportProblem.attachmentId}";
	$('#reportProblem_attachmentId').val(fileGuid);
	// 附件上传初始化
    $('#'+fileContainer).fileUpload({
        fileGuid:fileGuid,
        isView:true,
        isEdit:false,
        isDel:false,
        isAdd:false,
        isDownload:true,
        isdebug:false
    }); 


	    genMatrixLevelTd("${matrixLevelNames}", $('#sonCircuitName').val(), $('#sonCircuitCode').val(), $('#matrixLevelInfo')[0],
			  function(index, len, title){
				var a = [];
				a.push("所属");
				a.push(title);
				a.push("名称");
				return a.join(''); 
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
	        isDel:false,
	        isEdit:false
	    })
	    
	    
		//处理double金额显示的科学计数法
		aud$handleMoneyEFormat("", "relateLoss", true);
});


//生成矩阵层级的tr，td
function genMatrixLevelTd(titles, titleValues, titleCodes, target, formatFn){


	try{
		
		
	var mArr = titles.split(","); // 获取标题
	var mLen = mArr.length; // 获取数量
	var tdcount = 2;
	var tId = "superior_"; // id 
	
	if (mLen > 1){
		mArr = mArr.slice(0,mLen-1); // 去除最后一个
		mLen = mArr.length;
	}
	var lastColSpan = mLen%2 == 0 ? 1 : tdcount + 1; // 最后一行是否需要跨行
	
 	if(titles && titleValues && titleCodes && target){  // 编辑 
		var vArr = titleValues.split(",");
		var cArr = titleCodes.split(",");
		var vLen = vArr.length;
		if(vLen <= mLen){				
			var curTr = null;
			$.each(vArr, function(i, titleVal){
				var t = i%tdcount;
				var titleTd = null, valTd = null;
				var title = mArr[i];
				var isLast = i == vLen -1; // 是否是最后一行
			
                if(t == 0){
                    curTr = document.createElement('tr');
                    $(target).append(curTr);
                }
                if(t == 0 || t == 1){                  	
                    titleTd = $("<td class='EditHead' nowrap style='width:18%;border-bottom-width:0px;'>"+(formatFn ? formatFn(i, mLen, title) : title)+"</td>").appendTo(curTr);
                    valTd = $("<td class='editTd' nowrap colSpan="+(isLast ? lastColSpan : 1)+" id="+(tId+i)+" style='width:32%;border-bottom-width:0px;'>"+titleVal+"</td>").appendTo(curTr);
                    /*   $("<span title='单击查看["+title+"]' style='cursor:pointer;color:blue;'>"+titleVal+"</span>")
                     .attr('isLast', isLast).appendTo(valTd[0]).bind('click', function(etobj){
                    	viewMatrixLevel(etobj, title, cArr[i])
                    });  */
                 
                }
			});
		}
	}else if (titles  && target){  //新增
		$.each(mArr, function(i, titles){
			var t = i%tdcount;
			var titleTd = null, valTd = null;
			var title = mArr[i];
			var isLast = i == mLen-1;  // 是否是最后一行
	        if(t == 0){
                curTr = document.createElement('tr');
                $(target).append(curTr);
            }
            if(t == 0 || t == 1){                  	
            	   titleTd = $("<td class='EditHead' nowrap style='width:18%;border-bottom-width:0px;'>"+(formatFn ? formatFn(i, mLen, title) : title)+"</td>").appendTo(curTr);
                    valTd = $("<td class='editTd' nowrap  colSpan="+(isLast ? lastColSpan : 1)+"  style='width:32%;border-bottom-width:0px;' ><span id="+(tId+i)+"><span></td>").appendTo(curTr);
            }
		});
	} 

}catch(e){
	alert("genMatrixLevelTd:\n"+e.message)
}

}
</script>

</head>

<body style='padding:0px;margin:0px;' id="eplayout" >


            <input type="hidden" id="sonCircuitName" name="reportProblem.sonCircuitName" value="${reportProblem.sonCircuitName}"/>
			<input type="hidden" id="sonCircuitCode" name="reportProblem.sonCircuitCode" value="${reportProblem.sonCircuitCode}"/>

      		<table id="matrixLevelInfo" 
				class="ListTable" align="center" style='table-layout:fixed;margin:0px 0px -2px 0px;width:100%;'>
			</table>
            <table class="ListTable" align="center" style=' table-layout:fixed;margin:0px;width:100%;'>
				<tr style="height:0px;">
					<td style="width:18%;"></td><td style="width:32%;"></td>
					<td style="width:18%;"></td><td style="width:32%;"></td>
				</tr>
				<tr>
					  <td class="EditHead" style="width: 15%">
					    所属控制点 
					  </td>
					  <td class="editTd"   style="width: 35%" colspan='3'>
                      	<s:property value="reportProblem.controlName"/>
					  </td>
				</tr>
				<tr>
					  <td class="EditHead" style="width: 15%">
					     内控缺陷编号
					  </td>
					  <td class="editTd"   style="width: 35%">
					     <s:property value="reportProblem.defectCode"/>
					  </td>
					  <td class="EditHead" style="width: 15%">
					                   被评价单位
					  </td>
					  <td class="editTd"   style="width: 35%">
					     <s:property value="reportProblem.accountabilityUnit"/>
					  </td>
				</tr>
					
				<tr>
					  <td class="EditHead" style="width: 15%">
					      内控缺陷名称
					  </td>
					  <td class="editTd"   style="width: 35%">
					    <s:property value="reportProblem.defectName"/>
					  </td>
					  
					  <td class="EditHead" style="width: 15%">
					        涉及单位及部门
					  </td>
					  <td class="editTd"   style="width: 35%">
				      <s:property value="reportProblem.involveDept"/> 
					  </td>
					</tr>
					 <tr>
					<td class="EditHead">
                                                                             内控缺陷描述
						<div><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" title="内控缺陷描述" name="reportProblem.defectDescription" id='defectDescription' readonly="true"
					value="${reportProblem.defectDescription}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
					</td>
				</tr>
				
				<tr>
					<td class="EditHead">
                                                                            缺陷成因
						<div><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" title="缺陷成因" name="reportProblem.defectCause" id='defectCause' readonly="true"
					value="${reportProblem.defectCause}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
					</td>
				</tr>
					
						<tr>
					  <td class="EditHead" style="width: 15%">
					       缺陷类型
					  </td>
					  <td class="editTd"   style="width: 35%">
					     <s:property value="reportProblem.defectTypeName"/>
					  </td>
					  
					  <td class="EditHead" style="width: 15%">
					          涉及的损失/错报的金额
					  </td>
					  <td class="editTd"   style="width: 35%">
					    <span id="view_relateLoss">${reportProblem.relateLoss}</span>万元
					  </td>
					</tr>
					<tr>
					<td class="EditHead">
                                                                           风险及影响
						<div><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" title="风险及影响" name="reportProblem.riskEffect" id='riskEffect' readonly="true"
					value="${reportProblem.riskEffect}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
					</td>
				   </tr>
					
						<tr>
					  <td class="EditHead" style="width: 15%">
					       认定结果
					  </td>
					  <td class="editTd"   style="width: 35%">
					     <s:property value="reportProblem.defineResult"/>
					  </td>
					   <td class="EditHead" style="width: 15%">
					        整改建议
					  </td>
					  <td class="editTd"   style="width: 35%">
					     <s:property value="reportProblem.mendAdvice"/>
					  </td>
				
					</tr>
					<tr>
					<td class="EditHead">
                                                                           整改建议描述
						<div><font color=DarkGray>(限1000字)</font></div>
					</td>
					<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" title="整改建议描述" name="reportProblem.suggestDescription" id='suggestDescription' readonly="true"
					value="${reportProblem.suggestDescription}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;" />
					</td>
				</tr>
					
						<tr>
					  <td class="EditHead" style="width: 15%">
					       
                                                                            整改责任单位
					  </td>
					  <td class="editTd"   style="width: 35%">
					    <s:property value="reportProblem.accountabilityUnit"/>
					  </td>
					  
					  <td class="EditHead" style="width: 15%">
					         整改主责部门
					  </td>
					  <td class="editTd"   style="width: 35%">
					   <s:property value="reportProblem.accountabilityDept"/>
					  </td>
					</tr>
					
				
					<tr>
					  <td class="EditHead" style="width: 15%">
					          整改责任人
					  </td>
					  <td class="editTd"   style="width: 35%">
					     <s:property value="reportProblem.personLiable"/>
					  </td>
					  
					  <td class="EditHead" style="width: 15%">
					       联系电话
					  </td>
					  <td class="editTd"   style="width: 35%">
					    <s:property value="reportProblem.telephone"/>
					  </td>
					</tr>

					<tr>
					 <td class="EditHead" style="width: 15%">
					      整改开始时间
					  </td>
					  <td class="editTd"   style="width: 35%" colspan='3'>
					 	<span id='view_mendDeadlineBegin' class="noborder viewElement clear">
						${reportProblem.mendDeadlineStart}&nbsp;至&nbsp;${reportProblem.mendDeadlineEnd}</span>
					  </td>
					</tr>
					<tr>
					  <td class="EditHead" style="width: 15%">
					      监督检查人
					  </td>
					  <td class="editTd"   style="width: 35%">
					  <s:property value="reportProblem.checkPeople"/> 
					  </td>
					  
					  <td class="EditHead" style="width: 15%">
					          检查方式
					  </td>
					  <td class="editTd"   style="width: 35%">
					    <s:property value="reportProblem.checkMethod"/>
					  </td>
					</tr>
					<tr>
						<td class="EditHead"  nowrap>缺陷分类</td>
						<td class="editTd"   >
							<span id='view_defectClasf' class="noborder  viewElement clear" >${reportProblem.defectClasf}</span>
						</td>	
						<td class="EditHead"  nowrap>所属内控要素</td>
						<td class="editTd"   >
							<span id='view_blInnerCtrlEle' class="noborder viewElement clear" >${reportProblem.blInnerCtrlEle}</span>
						</td>					
					</tr>
					<tr>
					<td class="EditHead" style="width:15%;" nowrap>附件</br>
						<!-- <div id="fileUploadBtn"></div> -->
					</td>
					<td class="editTd"  colspan="3">
						<input type="hidden" id="defect_attachmentId" name="reportProblem.attachmentId" value="${reportProblem.attachmentId}" />
						<div id="defectAttachment" style="height:150px;overflow:auto;"></div>
					</td>
				</tr>	
			
				
       </table>		

</body>
</html>