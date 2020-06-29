<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>工程项目-frame</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){	
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
	$('#parentTabId').val(parentTabId);
	var isView = "${view}" == "true" || "${view}" == true ? true : false;

	$('#qtab').tabs({
		fit:true,
		border:0,
		onSelect:function(title, index){
			var projectId = "";
			if(index > 0){
				var projectInfoWin = $("#projectInfo").get(0).contentWindow;
				if(projectInfoWin){
					projectId = projectInfoWin.$('#proInfo_pid').val();
					projectId = !projectId ? "${param.pid}" : projectId;
				}
			}else{
				projectId =  "${param.pid}" ;
			}
			if(index == '1' && !$('#proApv').data('isload')){//项目批复
				$('#proApv').attr('src', '${contextPath}/ea/project/showApv.action?view=${view}&pid='+projectId+'&parentTabId='+curTabId);
				$('#proApv').data('isload',true);
			}else if(index == '2' && !$('#tenderInfo').data('isload')){  //招标信息
				$('#tenderInfo').attr('src', '${contextPath}/ea/tenderInfo/initPage.action?view=${view}&pid='+projectId+'&parentTabId='+curTabId);
				$('#tenderInfo').data('isload',true);
			}else if(index == '3' && !$('#contractInfo').data('isload')){  //合同信息
				$('#contractInfo').attr('src', '${contextPath}/ea/contractInfo/initPage.action?view=${view}&pid='+projectId+'&parentTabId='+curTabId);
				$('#contractInfo').data('isload',true);
			}
		}
	});
	$('#qtab').tabs('enableTab',1);
	$('#qtab').tabs('enableTab',2);
	$('#qtab').tabs('enableTab',3);
	//一定要放在$('#qtab').tabs初始化之后，否则url会被调用四次
	$('#projectInfo').attr('src', '${contextPath}/ea/project/editProInfo.action?view=${view}&pid=${param.pid}&parentTabId=${parentTabId}');
	$('#projectInfo').data('isload',true);
	
});
</script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div region="center" border="0">   
	    <div id="qtab"  border="0">  
	       <div title='项目信息' id='tab1' border="0" style='overflow:hidden;'>
	           <iframe id='projectInfo' name='projectInfo'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="项目批复" id='tab2' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='proApv' name='proApv'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="招标信息" id='tab3' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='tenderInfo' name='tenderInfo'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	      <div title="合同信息" id='tab3' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='contractInfo' name='contractInfo'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	    </div>
	</div>
</body>
</html>