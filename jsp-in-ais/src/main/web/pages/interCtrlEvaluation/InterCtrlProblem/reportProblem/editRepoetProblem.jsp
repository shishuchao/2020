<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML >
<html>
<title>修改内控缺陷</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
$(function(){
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();

	var fileContainer = 'edit_attachFile';
	var fileGuid = "${reportProblem.attachmentId}";
	//$('#reportProblem_attachmentId').val(fileGuid);
	// 附件上传初始化
/*     $('#'+fileContainer).fileUpload({
        fileGuid:fileGuid,                                            
        isAdd:true,
        isEdit:true,
        isDel:true,
        isView:true,
        isDownload:true,
        isdebug:false
    }); */
	
	// 初始化附件上传
    $('#defectAttachment').fileUpload({
    	fileGuid:$('#reportProblem_attachmentId').val(),
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
        isDel:true,
        isEdit:true
    })
	
	$("#epCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	//保存缺陷
	$("#epSaveBtn").bind('click',function(){
		var defectName = document.getElementsByName("reportProblem.defectName")[0].value;//内控缺陷名称
		if (defectName == null || defectName == ""){
			top.$.messager.show({title:'提示信息',msg:'内控缺陷名称不能为空'});
			return false;
		}
		
		var  mendAdviceCode = document.getElementsByName("reportProblem.mendAdviceCode")[0].value;//整改建议
		if ( mendAdviceCode == null ||  mendAdviceCode == ""){
			top.$.messager.show({title:'提示信息',msg:'整改建议不能为空'});
			return false;
		}
		
		var  checkPeople = document.getElementsByName("reportProblem.checkPeople")[0].value;// 监督检查人
		if ( checkPeople == null ||  checkPeople == ""){
			top.$.messager.show({title:'提示信息',msg:' 监督检查人不能为空'});
			return false;
		}
		
		var mendDeadlineStart = document.getElementsByName("reportProblem.mendDeadlineStart")[0].value;//整改开始时间
		if (mendDeadlineStart == null || mendDeadlineStart == ""){
			top.$.messager.show({title:'提示信息',msg:'整改开始时间不能为空！'});
			return false;
		}

		var mendDeadlineEnd = document.getElementsByName("reportProblem.mendDeadlineEnd")[0].value;//整改结束时间
		if (mendDeadlineEnd == null || mendDeadlineEnd == ""){
			top.$.messager.show({title:'提示信息',msg:'整改结束时间不能为空'});
			return false;
		}
		
		var controlName = document.getElementsByName("reportProblem.controlName")[0].value; // 控制点不能为空
		if (controlName == null || controlName == ""){
			top.$.messager.show({title:'提示信息',msg:'控制点不能为空'});
			return false;
		}


		var evaDept = document.getElementsByName("reportProblem.evaDept")[0].value;//被评价单位不能为空
		if (evaDept == null || evaDept == ""){
			top.$.messager.show({title:'提示信息',msg:'被评价单位不能为空'});
			return false;
		}
		
		var defectTypeCode = document.getElementsByName("reportProblem.defectTypeCode")[0].value;//缺陷类型
		if (defectTypeCode == null || defectTypeCode == ""){
			top.$.messager.show({title:'提示信息',msg:'缺陷类型不能为空'});
			return false;
		}
		
		var defineResultCode = document.getElementsByName("reportProblem.defineResultCode")[0].value;//认定结果
		if (defineResultCode == null || defineResultCode == ""){
			top.$.messager.show({title:'提示信息',msg:'认定结果不能为空'});
			return false;
		}

/* 		var relateLoss = document.getElementsByName("reportProblem.relateLoss")[0].value;//认定结果
		if (relateLoss != null && relateLoss != ""){
	 		var exp = /^([1-9][\d]{0,12}|0)(\.[\d]{1,2})?$/;
			if(! exp.test(num)){
				top.$.messager.show({title:'提示信息',msg:'认定结果不能为空'});
				return false;
			} 

		} */
		

		
		// 缺陷类型
	 	var defectTypeName = $("#defectTypeCode").combobox('getText');
		$("#defectTypeName").val(defectTypeName);
		
		//认定结果
	/*	var defineResult = $('#defineResultCode').combobox('getText');
		$('#defineResult').val(defineResult); */
		
		//整改建议
		var mendAdvice = $('#mendAdviceCode').combobox('getText');
		$('#mendAdvice').val(mendAdvice);

		//整改方式
		/* var mendMethod = $('#mendMethodCode').combobox('getText');
		$('#mendMethod').val(mendMethod); */
	
		var checkMethod = $('#checkMethodCode').combobox('getText');
		$('#checkMethod').val(checkMethod);

		
		if(!chkPhone()){
			return false;
		}
	   	 aud$saveForm('evaReportProblemForm', "${contextPath}/intctet/reportProblem/saveRepoetProblem.action",  function(data){
    		 if(data){
    			
    		 }
		 });
		
	});
	//处理double金额显示的科学计数法, 并转换成千分位显示
	aud$handleMoneyEFormat("",["relateLoss"]);
});

function aud$saveForm(formId, formUrl, callbackFn){
	try{
		if(formId && formUrl){
			$.ajax({
				url : formUrl,
				dataType:'json',
				type: "post",
				data: $('#'+formId).serialize(),
				success: function(data){
					try{
						if(data.reportProblemIds){
							var Rpid = data.reportProblemIds;
							$('#reportProblemIds').val(Rpid);	
							var t = top.Addtabs.options.obj.children(".tab-content");
							var k = "${parentTabId}";
		    	            var tabIfm = t.find('#'+k).find('.iframeClass');
		    	            if(tabIfm.length){
		    		            var ifmWin = tabIfm.get(0).contentWindow;
		    		            ifmWin.aud$reportProblemGrid ?  ifmWin.refresh() : null;
		    	            }
						}						
					}catch(e){}
					top.$.messager.show({title:'提示信息',msg:data.successMsg});
					$('#epCloseBtn').trigger('click');
				},
				error:function(data){
					top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
				}
			});
		}else{
			throw new Error("formId or formUrl is null.");
		}
	}catch(e){
		//isdebug ? alert('aud$saveForm:\n'+e.message) : null;
	}
}

// 控制点
function getControl(){
    var Url  = "<%=request.getContextPath()%>/intctet/prepare/assessScheme/initjzReport.action?projectId=${reportProblem.proId}";
	aud$openNewTab('${lastlevelName}选择',Url,true);
}

$(function(){
 	    genMatrixLevelTd("${matrixLevelNames}", $('#sonCircuitName').val(), $('#sonCircuitCode').val(), $('#matrixLevelInfo')[0],
 			  function(index, len, title){
 				var a = [];
 				a.push("所属");
 				a.push(title);
 				a.push("名称");
 				return a.join(''); 
 			}); 
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
// 校验涉及金额
 function chkIt(){
	var relateLoss = document.getElementById("relateLoss");
	if (isNaN(relateLoss.value)) {
		top.$.messager.show({title:'提示信息',msg:'只能是数字和小数点!'});
		relateLoss.value = "";
		relateLoss.focus();
	}
} 
  
  function chkPhone(){
	  var telephone = document.getElementById("telephone").value;
	  if (telephone != null && telephone != ""){
		  var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
		  var phone = /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i;
		  var mobile = /^(13|15|18)\d{9}$/i;
		  if (!patrn.exec(telephone)){
			  top.$.messager.show({title:'提示信息',msg:'联系电话只能是数字!'});
			  telephone.value = "";
			  telephone.focus();
			  return false 
		  }
		  if(!phone.exec(telephone)){
			  if(!mobile.exec(telephone)){
				  top.$.messager.show({title:'提示信息',msg:'联系电话只能是电话或者手机!'});
				  telephone.value = "";
				  telephone.focus();
				  return false 
			  }
		  }
		
		  return true 
	  }
	  return true 
  }

</script>

</head>

<body style='padding:0px;margin:0px;overflow:hidden;' id="eplayout" class='easyui-layout' border='0' fit='true'>
<div region='north' border='0' style='padding:0px;margin:0px;overflow:hidden;'>
	<div id='btnBar' style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>	
   		<a id='epSaveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>
    	<a id='epCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a> 
	</div>
</div>		
<div region="center" border='0'>	
  <form  id='evaReportProblemForm' name='tenderInfoForm' method="POST" style="margin:0px;padding:0px;width:100%;" >
	        <input type="hidden" id="sonCircuitName" name="reportProblem.sonCircuitName" value="${reportProblem.sonCircuitName}"/>
			<input type="hidden" id="sonCircuitCode" name="reportProblem.sonCircuitCode" value="${reportProblem.sonCircuitCode}"/>
			<input type="hidden" id="circuitName" name="reportProblem.circuitName" value="${reportProblem.circuitName}"/>
			<input type="hidden" id="circuitCode" name="reportProblem.circuitCode" value="${reportProblem.circuitCode}"/>
			<input type="hidden" id="manu_manuId" name="reportProblem.manuId" value="${reportProblem.manuId}"/>

			<table id="matrixLevelInfo" 
				class="ListTable" align="center" style='table-layout:fixed;margin:0px 0px -2px 0px;width:100%;padding:0px;'>
			</table>
            <table class="ListTable" align="center" style='table-layout:fixed;margin-top:0px;width:100%;padding:0px;'>
				<tr style="height:0px;">
					<td style="width:18%;"></td><td style="width:32%;"></td>
					<td style="width:18%;"></td><td style="width:32%;"></td>
				</tr>
				<tr>
					<td class="EditHead" style="width: 15%">
					   <font color="red">*</font>所属${lastlevelName} 
					</td>
					<td class="editTd"   style="width: 35%" colspan='3'>
						<s:textfield name="reportProblem.controlName" id="controlName" 
						cssClass="noborder"  readonly="true" cssStyle="width:90%;"/> 
					   <img alt="" src="<%=request.getContextPath()%>/resources/images/s_search.gif" onclick="getControl()" border=0 style="cursor: pointer">
					   <s:hidden name="reportProblem.controlCode" id="controlCode"></s:hidden> 
					   <s:hidden />
					 </td>
				</tr>
				<tr>   
					   <td class="EditHead" style="width: 15%">
					     <font color="red">*</font>内控缺陷编号
					   </td>
					   <td class="editTd"   style="width: 35%">
					     <!-- <s:textfield name="reportProblem.defectCode"  cssClass="noborder" readonly="true" maxlength="500" title="内控缺陷编号"
					     	cssStyle="border:0px;width:70%;"
					     /> -->
					     ${reportProblem.defectCode} 
					   </td>
					   <td class="EditHead" style="width: 15%">
						   <font color="red">*</font>被评价单位
						</td>
					  	<td class="editTd" style="width:35%;">
							<input type='text' id='evaDept' name='reportProblem.evaDept' title="被评价单位" value="${reportProblem.evaDept}"
							 class="noborder editElement clear required" readonly style="width:70%;"/>
							<input type='hidden' id='reportProblem_evaDeptCode' name='reportProblem.evaDeptCode' title="被评价单位ID"  value="${reportProblem.evaDeptCode}"
							class="noborder editElement clear"/>
							<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class="editElement"
								onclick="showSysTree(this,{
	                                  title:'被评价单位选择',
									  param:{
									  	'rootParentId':'0',
					                    'beanName':'UOrganizationTree',
					                    'treeId'  :'fid',
					                    'treeText':'fname',
					                    'treeParentId':'fpid',
					                    'treeOrder':'fcode'
					                 }                                  
							})"></img>
					  </td>
					</tr>
					<tr>
					  <td class="EditHead" style="width: 15%"><font color="red">*</font>内控缺陷名称 </td>
					  <td class="editTd"   style="width: 35%">
					    <s:textfield name="reportProblem.defectName"  cssClass="noborder" maxlength="500" title="内控缺陷名称" cssStyle="width:70%;"/> 
					  </td>
					  <td class="EditHead" style="width: 15%">涉及单位及部门</td>
					  <td class="editTd"   style="width: 35%">
					    <s:textfield name="reportProblem.involveDept"  cssClass="noborder" maxlength="100" title="涉及单位及部门" cssStyle="width:70%;"/>
					     <s:hidden name="reportProblem.involveDeptCode"></s:hidden>  
					  </td>
					</tr>
					 <tr>
					<td class="EditHead"> 内控缺陷描述<div><font color=DarkGray>(限1000字)</font></div></td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" title="内控缺陷描述" name="reportProblem.defectDescription" id='defectDescription'
						value="${reportProblem.defectDescription}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;border:0px;" />
						<input type="hidden" id="reportProblem.defectDescription.maxlength" value="5000">
					</td>
				</tr>
				
				<tr>
					<td class="EditHead">缺陷成因<div><font color=DarkGray>(限1000字)</font></div></td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" title="缺陷成因" name="reportProblem.defectCause" id='defectCause'
						value="${reportProblem.defectCause}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;border:0px;" />
						<input type="hidden" id="reportProblem.defectCause.maxlength" value="5000">
					</td>
				</tr>
					<tr>
					  <td class="EditHead" style="width: 15%"><font color="red">*</font>缺陷类型 </td>
					  <td class="editTd"   style="width: 35%">
					       <select id="defectTypeCode" class="easyui-combobox" name="reportProblem.defectTypeCode" 
					       title="缺陷类型" style="width:70%;" data-options="panelHeight:'auto',editable:false" >
						      <option value="">&nbsp;</option>
						      <s:iterator value="basicUtil.evadefectTypeList" id="entry">
						       <s:if test="${reportProblem.defectTypeCode == id }">
						         <option selected="selected" value="<s:property value="id"/>"><s:property value="name"/></option>
						       </s:if>
						       <s:else>
						       <option value="<s:property value="id"/>"><s:property value="name"/>
						       </s:else>
						      </s:iterator>
						    </select> 
						    <s:hidden name="reportProblem.defectTypeName" id="defectTypeName"/>
					    </td>
					    <td class="EditHead" style="width: 15%" >涉及的损失/错报的金额</td>
					    <td class="editTd"   style="width: 35%" >
					    	<input type="text" name="reportProblem.relateLoss" id="relateLoss" 
					   		 class="noborder" onkeyup="chkIt()" title="涉及的损失/错报的金额（万元）" maxlength="15" 
					   		 style="width:70%;" value="${reportProblem.relateLoss}"/>万元
					    </td>
				</tr>
				<tr>
						<td class="EditHead">风险及影响<div><font color=DarkGray>(限1000字)</font></div></td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" title="风险及影响" name="reportProblem.riskEffect" id='riskEffect'
							value="${reportProblem.riskEffect}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;border:0px;" />
							<input type="hidden" id="reportProblem.riskEffect.maxlength" value="2000">
						</td>
					</tr>
					<tr>
					  <td class="EditHead" style="width: 15%"><font color="red">*</font>认定结果 </td>
					  <td class="editTd"   style="width: 35%">
						 <input type='text' id='defect_defineResult' name='reportProblem.defineResult' value="${reportProblem.defineResult}" 
						 title='认定结果' class="noborder editElement clear required" readonly style="width:70%;"/>
						 <input type='hidden' id='defect_defineResultCode' name='reportProblem.defineResultCode' value="${reportProblem.defineResultCode}" 
						 title='认定结果Code' class="noborder editElement clear required" readonly/>
						 <a  class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
								  title:'认定结果选择',
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
			
						<a id='view_defectLevel' title="缺陷等级标准查看" class="easyui-linkbutton" iconCls="icon-view" 
						style='border-width:0px;'></a>
					  </td>
				  	  <td class="EditHead" style="width: 15%"><font color="red">*</font>整改建议</td>
					  <td class="editTd"   style="width: 35%">
					    <select class="easyui-combobox" style="width:70%;" data-options="panelHeight:'auto',editable:false" 
					    name="reportProblem.mendAdviceCode" id="mendAdviceCode">
					    <option value="">&nbsp;</option>
					     <s:iterator value="basicUtil.evamendAdviceList">
					       <s:if test="${reportProblem.mendAdviceCode ==id }">
					       <option selected="selected" value='<s:property value="id"/>'><s:property value="name"/> </option>
					       </s:if>
					       <s:else>
					     <option  value='<s:property value="id"/>'><s:property value="name"/> </option>
					     </s:else>
					     </s:iterator>
					    </select>
					    <s:hidden name="reportProblem.mendAdvice"  id="mendAdvice"></s:hidden>
					  </td>
				</tr>
				<tr>
					<td class="EditHead">整改建议描述<div><font color=DarkGray>(限1000字)</font></div></td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" title="整改建议描述" name="reportProblem.suggestDescription" id='suggestDescription'
						value="${reportProblem.suggestDescription}" rows="5" cssStyle="width:100%;overflow:hidden;line-height:150%;border:0px;" />
						<input type="hidden" id="reportProblem.suggestDescription.maxlength" value="2000">
					</td>
				</tr>
				<tr>
					  <td class="EditHead" style="width: 15%">整改责任单位 </td>
					  <td class="editTd"   style="width: 35%">
					    <s:textfield name="reportProblem.accountabilityUnit"  title="整改责任单位" id="accountabilityUnit" cssStyle="width:70%;" cssClass="noborder" maxlength="100" /> 
					    <s:hidden name="reportProblem.accountabilityUnitCode" id="accountabilityUnitCode"></s:hidden>
					  </td>
					  <td class="EditHead" style="width: 15%">整改主责部门 </td>
					  <td class="editTd"   style="width: 35%">
					    <input type='text' id='reportProblem_accountabilityDept' name='reportProblem.accountabilityDept' 
					    value="${reportProblem.accountabilityDept}" readonly style="width:70%;"
						class="noborder editElement clear "/>
						<input type='hidden' id='reportProblem_accountabilityDeptCode' name='reportProblem.accountabilityDeptCode' title="审计单位ID"  
						value="${reportProblem.accountabilityDeptCode}" readonly
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
						
					  </td>
					</tr>
					<tr>
					  <td class="EditHead" style="width: 15%">整改责任人 </td>
					  <td class="editTd"   style="width: 35%">
					     <s:textfield name="reportProblem.personLiable"  cssClass="noborder" maxlength="100" cssStyle="width:70%;"/> 
					     <s:hidden name="reportProblem.personLiableId"></s:hidden>
					  </td>
					  <td class="EditHead" style="width: 15%">联系电话</td>
					  <td class="editTd"   style="width: 35%">
					    <s:textfield name="reportProblem.telephone"  cssClass="noborder" id="telephone" maxlength="15" cssStyle="width:70%;"/>
					  </td>
					</tr>
					<tr>
					  	<td class="EditHead" style="width: 15%"><font color="red">*</font>整改期限 </td>
						<td class="editTd"  style="width: 35%" colspan='3'>
					 		<span class='editElement'>
								<input type='text' id='reportProblem_mendDeadlineStart' name='reportProblem.mendDeadlineStart'   value="${reportProblem.mendDeadlineStart}"
								title="整改期限-开始" class="easyui-datebox noborder clear required" editable="false"
								style="width:110px;"/>
							</span>	
							<span class='editElement'>&nbsp;至&nbsp;</span>
							<span class='editElement'>	
								<input type='text' id='reportProblem_mendDeadlineEnd' name='reportProblem.mendDeadlineEnd' compareval="gte&reportProblem_mendDeadlineStart"  value="${reportProblem.mendDeadlineEnd}"
								title="整改期限-结束" class="easyui-datebox noborder clear required" editable="false"
								compareval="gte&reportProblem_mendDeadlineStart"
								style="width:110px;" />
							</span> 
						</td>
					</tr>
					<tr>
					  <td class="EditHead" style="width: 15%"> <font color="red">*</font>监督检查人 </td>
					  <td class="editTd"   style="width: 35%">
					   <input type='text' id='reportProblem_checkPeople' name='reportProblem.checkPeople' value="${reportProblem.checkPeople}"
						 title="监督检查人" class="noborder editElement clear required"  readonly style="width:70%;"/>
						<input type='hidden' id='reportProblem_checkPeopleCode' name='reportProblem.checkPeopleCode' value="${reportProblem.checkPeopleCode}" 
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
						
							
					  </td>
					  <td class="EditHead" style="width: 15%">检查方式</td>
					  <td class="editTd"   style="width: 35%">
					   <select class="easyui-combobox" style="width:70%;" data-options="panelHeight:'auto',editable:false" name="reportProblem.checkMethodCode" id="checkMethodCode">
					    <option value="">&nbsp;</option>
					     <s:iterator value="basicUtil.evacheckMethodList">
					       <s:if test="${reportProblem.checkMethodCode ==id }">
					       <option selected="selected" value='<s:property value="id"/>'><s:property value="name"/> </option>
					       </s:if>
					       <s:else>
					        <option  value='<s:property value="id"/>'><s:property value="name"/> </option>
					       </s:else>
					    
					     </s:iterator>
					    </select>
					    <s:hidden name="reportProblem.checkMethod" id="checkMethod"></s:hidden>
					  </td>
					</tr>
				
				<tr>
					<td class="EditHead"  nowrap>缺陷分类</td>
					<td class="editTd"   >
						<input type='text' id='reportProblem_defectClasf' name='reportProblem.defectClasf' value="${reportProblem.defectClasf}"
						 title="缺陷分类" class="noborder editElement clear "  style='width:70%;' readonly/>
						<input type='hidden' id='reportProblem_defectClasfCode' name='reportProblem.defectClasfCode' value="${reportProblem.defectClasfCode}" 
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
				               	  			$('#reportProblem_defectClasf').removeAttr('readonly');
				               	  		}else{
				               	  			$('#reportProblem_defectClasf').attr('readonly', 'readonly');
				               	  		}
				               	  	}     	  	
				                  }
						})"></a>
							
					</td>
					<td class="EditHead"  nowrap>所属内控要素</td>
					<td class="editTd"   >
						<input type='text' id='reportProblem_blInnerCtrlEle' name='reportProblem.blInnerCtrlEle' value="${reportProblem.blInnerCtrlEle}" 
						 title='所属内控要素' class="noborder editElement clear " style='width:70%;' readonly/>
						<input type='hidden' id='reportProblem_blInnerCtrlEleCode' name='reportProblem.blInnerCtrlEleCode' value="${reportProblem.blInnerCtrlEleCode}" 
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
							
					</td>
				</tr>	
				
				
				<s:hidden  name="reportProblem.id" id="reportProblemIds"/>
				<s:hidden  name="reportProblem.proId"/>
				<s:hidden  name="reportProblem.proCode"/>
				<s:hidden  name="project_id"/>
				<input type="hidden" id="manuscriptIndex" name="reportProblem.manuscriptIndex" value="${reportProblem.manuscriptIndex }"/>
				<%-- <s:hidden  name="reportProblem.attachmentId"/> --%>
			<tr>
					<td class="EditHead" style="width:15%;" nowrap>附件</br>
						<div id="fileUploadBtn"></div>
					</td>
					<td class="editTd"  colspan="3">
						<input type="hidden" id="reportProblem_attachmentId" name="reportProblem.attachmentId" value="${reportProblem.attachmentId}" />
						<div id="defectAttachment" style="height:150px;overflow:auto;"></div>
					</td>
			</tr>	
       </table>
	</form>	
</div>

	
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" /> 
   <script type="text/javascript">
   
   $(function(){

 		$('#defectDescription').attr('maxlength',1000); //内控缺陷描述
 		$('#defectCause').attr('maxlength',1000);//缺陷成因
 		$('#riskEffect').attr('maxlength',1000);//风险及影响
 		$('#suggestDescription').attr('maxlength',1000); // 整改建议描述

		$("#evaReportProblemForm").find("textarea").each(function(){
			autoTextarea(this);
		});
		//查看缺陷等级
		$('#view_defectLevel').bind('click', function(){
			new aud$createTopDialog({
				title:'缺陷等级标准查看',
				url:'${contextPath}/intctet/sysManage/defectLevel/initDefectPage.action?view=true'
			}).open();
		});
   });
   
   </script>
</body>
</html>