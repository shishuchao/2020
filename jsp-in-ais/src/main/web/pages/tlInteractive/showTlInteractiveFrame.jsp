<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>两级交互-配置主页面</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script> 
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript">
$(function(){
    var tlerrorMsg = "${tlerrorMsg}";
    var isAdmin = "${isAdmin}" == 'true' ? true :  false;
    if(tlerrorMsg){
        top.$.messager.alert('提示信息', tlerrorMsg, 'error', function(){
            var selectedTab = top.$('#tabs').tabs('getSelected');
            if(selectedTab){
                var tabIndex = top.$('#tabs').tabs('getTabIndex', selectedTab);
                top.$('#tabs').tabs('close', tabIndex);
            }
        });
        $('body').html('');
        return;
    }
	$('#qtab').tabs({
		onSelect:function(title, index){	
			//alert(title +', '+ index)
			if(title == '交互服务' && !$('#webAdressifm').data('isload')){
				$('#webAdressifm').attr('src', '${contextPath}/fr/report/flow/zj/showWebAdressList.action');
				$('#webAdressifm').data('isload',true);
			}else if(title == '交互数据' && !$('#dbTableIfm').data('isload')){
				$('#dbTableIfm').attr('src', '${contextPath}/tlInteractive/showTlTableList.action');
				$('#dbTableIfm').data('isload',true);
			}else if(title == '交互任务' && !$('#tlTemplateIfm').data('isload')){
				$('#tlTemplateIfm').attr('src', '${contextPath}/tlInteractive/showTlTemplateList.action?editable=${editable}');
				$('#tlTemplateIfm').data('isload',true);
			}else if(title == '交互日志' && !$('#tlLogIfm').data('isload')){
				$('#tlLogIfm').attr('src', '${contextPath}/tlInteractive/showTlLogList.action');
				$('#tlLogIfm').data('isload',true);
			}
		}
	});
	
	//$('#qtab').tabs('select', 0);
	
	$('#webAdressifm').attr('src', '${contextPath}/fr/report/flow/zj/showWebAdressList.action');
	$('#webAdressifm').data('isload',true);
});
</script>
</head>
<body class='easyui-layout' fit='true' border="0">	
	<div region="center" border="0">   
	    <div id="qtab" class="easyui-tabs"  fit="true" border="0">  
	       <div title='交互服务' id='tab3' border="0" style='overflow:hidden;'>
	           <iframe id='webAdressifm' name='webAdressifm'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="交互数据" id='tab1' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='dbTableIfm' name='dbTableIfm'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="交互任务" id='tab2' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='tlTemplateIfm' name='tlTemplateIfm'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title='交互日志' id='tab4' border="0" style='overflow:hidden;'>
	           <iframe id='tlLogIfm' name='tlLogIfm'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	    </div>
	</div>
	<input type='text' id='isAdmin' name='isAdmin' value="${isAdmin }"/>
</body>
</html>