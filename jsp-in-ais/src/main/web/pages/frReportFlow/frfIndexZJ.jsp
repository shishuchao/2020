<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>铁路总局报表流程审批</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/pages/introcontrol/util/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/pages/introcontrol/util/themes/icon.css">
<script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${contextPath}/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/pages/frReportFlow/frReportFlow.js"></script>
<script type="text/javascript">
$(function(){  
	var warningMsg = "${warningMsg}";
	if(warningMsg){
        $('#frForm').hide();
        top.$.messager.alert('提示信息',warningMsg, 'warning', function(){
            parent.closeSelectedTab();
        });
	}
    
    $('#submitBtn').bind('click',function(){
    	var tid = "";
    	if($('#submitButton').length){
    		tid = "submitButton";
    	}else if($('#submitButton2Start').length){
    		tid = "submitButton2Start";
    	}
    	$('#'+tid).trigger('click')
        //$('#frFlowWin').dialog('open');
    });
    $('#frFlowWin').dialog({
        title:'报表流程信息',
        closed:true,
        modal:true,
        inline:true,
        width:$('body').width(),
        height:$('body').height(),
        toolbar:[{
             text:'关闭',
             iconCls:'icon-cancel',
             handler:function(){
                 $('#frFlowWin').dialog('close');
             }
         },'-']
    });
});

function checkForm(){
	return true;
}

function toSubmit(act){
    try{
        if(checkForm()){//提交前校验
            var isUseBpm = '${isUseBpm}';
            if(isUseBpm == 'true'){
                if(document.getElementsByName('isAutoAssign')[0].value=='false'){
                    var actor_name=document.getElementsByName('formInfo.toActorId_name')[0].value;
                    if(actor_name==''){
                    	top.$.messager.alert("提示信息",'下一步处理人不能为空！', 'error');
                        return false;
                    }
                }
            }
            if(confirm('确认提交吗?')){
                // 设置快照
                //var isFlowLastStep = frflow.isFlowLastStep(); 
                if(isUseBpm == 'true'){
                    frForm.action="<s:url action="submit" includeParams="none"/>";
                    frForm.submit();
                }else{
                    $.ajax({    
                        url:'${contextPath}/fr/report/flow/saveNoFlow.action',
                        data: $('#frForm').serialize(),   
                        type: "post",
                        success:function(data){    
                        	top.$.messager.alert("提示信息",data.msg, data.type, function(){
                                if(data.type != 'error'){
                                    parent.closeSelectedTab();
                                }
                            });  
                        },
                        error:function(xmlhttp,parseError,errorThrown){
                        	top.$.messager.alert('提示信息','请求失败！请检查网络配置或者与管理员联系！','error');
                        }    
                    });             
                }
                return true;
             }else{
                return false;
             }
        }
    }catch(e){
        alert('toSubmit:\n'+e.message);
    }
}

</script>
</head>
<s:if test="taskInstanceId!=null && taskInstanceId!=''">
	<body onload="end();" class="easyui-layout" data-options="fit:true">
</s:if>
<s:else>
	<body class="easyui-layout" data-options="fit:true">
</s:else>
	<div data-options="region:'center',title:'<span style=\'float:left\'>${crudObject.templateName}</span>',split:true" >
        <!-- 报表显示 -->
        <iframe id="showReportIfr" name="showReportIfr"  src="${crudObject.reportUrl}"  width="100%" height="100%" frameborder="0">
        </iframe>
        <!-- end -->
	</div>
    
    
    
	<div id="frFlowWin" name="frFlowWin"
            style='border-bottom:1px solid #cccccc;overflow:auto;padding:10px;'>
		<!-- 流程表单，必须配置 -->
		<s:form id="frForm" action="submit" namespace="/fr/report/flow/zj">
			<!-- 流程表单字段  工作流默认每次都要对crudObject对象进行save，如果对象为空会清空记录 -->
			<s:hidden name="crudObject.formId" />
			<s:hidden name="crudObject.sformId"/>
			<s:hidden name="crudObject.templateId" />
			<s:hidden name="crudObject.templateName" />
			<s:hidden name="crudObject.templateFileName" />
            <s:textarea name="crudObject.reportContent" id='reportContent' cssStyle='display:none;'/>
			<s:hidden name="crudObject.reportYear"/>
			<s:hidden name="crudObject.flowFormUrl" />
			<s:hidden name="crudObject.reportUrl" />
			<s:hidden name="crudObject.orgId" />
			<s:hidden name="crudObject.orgName" />
			<s:hidden name="crudObject.source" />
			<s:hidden name="crudObject.sourceName" />
			<s:hidden name="crudObject.status" />
			<s:hidden name="crudObject.statusName" />
			<s:hidden name="crudObject.creatorId" />
			<s:hidden name="crudObject.creator" />
			<s:hidden name="crudObject.createTime" />
			<s:hidden name="crudObject.informantId"/>
			<s:hidden name="crudObject.informant"/>
			<s:hidden name="crudObject.informantTime"/>
			<!-- end -->
            <!-- 引入工作流  -->
            <div align ="center">
                <!-- 显示流程流转信息 -->
                <jsp:include flush ="true"  page="/pages/bpm/list_taskinstanceinfo.jsp" />
                <!-- 显示流程处理意见，催办时间，下一步处理环节，下一步处理人；启动流程后有内容显示(taskIntanceId != 0) -->
                <jsp:include flush ="false" page= "/pages/bpm/list_transition.jsp" />  
                <!-- 显示流程相关的按钮 -->
                <jsp:include flush="true"   page="/pages/bpm/list_toBeStart.jsp" />
            </div>
            <!-- end -->
		</s:form>
	</div>
    
    <span style='position:absolute; top:2px; right:5px;'>
		<a class='easyui-linkbutton' iconCls='icon-folderGo' href='javascript:void(0)' id='submitBtn'>启动流程</a>
    </span>
</body>
</html>
