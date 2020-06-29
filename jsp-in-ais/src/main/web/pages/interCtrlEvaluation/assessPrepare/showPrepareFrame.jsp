<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<head>
<title>内控-准备阶段</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>	
<s:head theme="ajax" />
</head>
<script type="text/javascript">
$(function(){
	var busBaseUrl = "${contextPath}/intctet/prepare/assessScheme";
	var projectId  = '${projectId}';
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
	$('#parentTabId').val(parentTabId);
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	if(isView){
		$('#submitButton').remove();
	}else{
		$('#submitButton').bind('click', aud$checkPost);
		
		//评价方案提交前，检查评价范围、评价内容、分组、组员是否已经添加  checkPostPrepare
		function aud$checkPost(){
		    $.ajax({
		        url: busBaseUrl + "/checkPostPrepare.action",
		        dataType: 'json',
		        type: "post",
		        data: {
		            'projectId': "${projectId}"
		        },
		        beforeSend: function() {
		            aud$loadOpen();
		            return true;
		        },
		        success: function(data) {
		            aud$loadClose();
		            if(data.type != "info"){
		                top.$.messager.alert("提示信息", data.msg, data.type, function(){
		                    var tabIndex = data.tabIndex;
		                    if(tabIndex){
		                        $('#qtab').tabs('enableTab', tabIndex);
		                        $('#qtab').tabs('select', tabIndex);
		                    }
		                });
		            }else{
		            	alert('submit')
		            }
		        },
		        error: function(data) {
		            aud$loadClose();
		            top.$.messager.show({
		                title: '提示信息',
		                msg: '请求失败！请检查网络配置或者与管理员联系！'
		            });
		        }
		    });
		}
	}
	$('#qtab').tabs({
		fit:true,
		border:0,
		onSelect:function(title, index){
			if(index == '0' && !$('#assessPrepare').data('isload')){//评价方案
				//var url = "${contextPath}/operate/template/listAll.action?interCtrl=true&project_id=${projectId}";
				var action = isView ? "viewEvaProgrammeList.action" : "showEvaProgrammeList.action";
				var url = busBaseUrl + "/" + action + "?view=${view}&projectId=${projectId}";
				$('#assessPrepare').attr('src', url);
				$('#assessPrepare').data('isload',true);
			}else if(index == '1' && !$('#sureFw').data('isload')){//确定评价范围
				var sureFwUrl = busBaseUrl +  '/initSurefw.action?view=${view}&parentTabId='+curTabId+'&projectId=${projectId}';
				$('#sureFw').attr('src', sureFwUrl);
				$('#sureFw').data('isload',true);
			}else if(index == '2' && !$('#sureTeam').data('isload')){  //确定评价组织
				var url = busBaseUrl +  '/initSureTeaem.action?view=${view}&parentTabId='+curTabId+'&projectId=${projectId}';
				$('#sureTeam').attr('src', url);
				$('#sureTeam').data('isload',true);
			}else if(index == '3' && !$('#sureDivision').data('isload')){//评价分工
				var url = busBaseUrl +  '/initSureContent.action?view=${view}&parentTabId='+curTabId+'&projectId=${projectId}';
				$('#sureDivision').attr('src',url); 
				$('#sureDivision').data('isload',true);
			}
			
			/*
			else if(index == '3' && !$('#sureContent').data('isload')){//确定评价内容
				$('#sureContent').attr('src', busBaseUrl +  '/initSureContent.action?view=${view}&parentTabId='+curTabId+'&projectId='+projectId);
				$('#sureContent').data('isload',true);
			}*/
		}
	});
	$('#qtab').tabs('disableTab',1);
	$('#qtab').tabs('disableTab',2);
	$('#qtab').tabs('disableTab',3);	
});


// 外层窗口要调用的iframe对象(dom)
function aud$calledIfm(type){
	var ifmId = null;
	if(type == 'fa'){
		ifmId = "assessPrepare";
	}else if(type == 'fw'){
		ifmId = "sureFw";
	}else if(type == 'zz'){
		ifmId = "sureTeam";
	}else if(type == 'fg'){
		ifmId = "sureDivision";
	}
	//alert(ifmId)
	return ifmId ? $('#'+ifmId).get(0) : null;
}

</script>
<body class="easyui-layout" data-options="fit:true">
	<div region="center" border="0">  
	    <div id="qtab"  border="0">  
	        <div title='创建方案' id='tab1' border="0" style='overflow:hidden;'>
	           <iframe id='assessPrepare' name='assessPrepare'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="确定评价范围" id='tab2' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='sureFw' name='sureFw'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <!--  
	       <div title="确定评价内容" id='tab3' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='sureContent' name='sureContent'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       -->
	       <div title="确定评价组织" id='tab4' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='sureTeam' name='sureTeam'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="确定评价分工" id='tab5' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='sureDivision' name='sureDivision'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
    	</div>
	</div>
	
	<div id='submitButton' style="position:absolute;z-index:99999;top:-1px;right:3px;">
		<a class="easyui-linkbutton" iconCls="icon-ok">提交评价方案</a>
	</div>
</body>
</html>