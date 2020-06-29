<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>送审项目-frame</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){	
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
	$('#parentTabId').val(parentTabId);
	var clsAttachId = "${clsAttachId}";
	var isView = "${view}" == "true" || "${view}" == true ? true : false;
	if(isView){
		$('#dvSave, #dvSave2, #dvSubmit, #dvRetreat').hide();
	}else{
		$('#dvSave').bind('click', function(){
			// 调用项目信息页签里面的保存方法
			var dvWin = aud$getIframeWin('dvAudProject');
			dvWin.dvSave();
		});
		
		$('#dvSave2').bind('click', function(){
			// 调用项目信息页签里面的保存方法
			var dvWin = aud$getIframeWin('dvAudProject');
			dvWin.dvSave(true)
		});
		//提交按钮
		$('#dvSubmit').hide().bind('click', function(){
			//调用送审项目编辑页面里的提交方法
			var dvWin = aud$getIframeWin('dvAudProject');
			dvWin.dvSubmit(true);
		});
		
		//项目受理时退回到项目送审
		$('#dvRetreat').bind('click', function(){
			//调用送审项目编辑页面里的退回方法
			var dvWin = aud$getIframeWin('dvAudProject');
			dvWin.dvRetreat();
		});
	}
	
	//注册事件方法
	$('#dvClose').bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});

	$('#qtab').tabs({
		fit:true,
		border:0,
		onSelect:function(title, index){
			if(index == '1' && !$('#audDatum').data('isload')){//送审资料
				var audDatumUrl = '${contextPath}/ea/dvAudProject/editAd.action?view=${view}' + $('#audDatumParam').val();
				//alert(audDatumUrl)
				$('#audDatum').attr('src', audDatumUrl);
				$('#audDatum').data('isload',true);
			}else if(index == '2' && !$('#audAccount').data('isload')){  //项目台账
				$('#audAccount').attr('src', '${contextPath}/ea/audAccount/initPage.action?view=${view}&parentTabId='+curTabId+ $('#audDatumParam').val());
				$('#audAccount').data('isload',true);
			}else if(index == '3' && !$('#audConclusion').data('isload')){  //审计结论
				$('#audConclusion').attr('src', '${contextPath}/ea/audAccount/initClusionPage.action?view=${view}&parentTabId='+curTabId+$('#audDatumParam').val());
				$('#audConclusion').data('isload',true);
			}
		}
	});
	$('#qtab').tabs('disableTab',1);
	$('#qtab').tabs('disableTab',2);
	$('#qtab').tabs('disableTab',3);
	//一定要放在$('#qtab').tabs初始化之后，否则url会被调用四次
	$('#dvAudProject').attr('src', '${contextPath}/ea/dvAudProject/editAp.action?view=${view}&apId=${apId}&parentTabId=${parentTabId}&clsAttachId='+clsAttachId+'&apStatusCode=${param.apStatusCode}');
	$('#dvAudProject').data('isload',true);
	
});
//设置台账、审计结论页签状态
//是否到了实施阶段，如果到了则显示“项目台账”和“审计结论”页签
function aud$setConclustionTab(apStatusCode){
	try{
		if(apStatusCode == '3' || '${view}'){//审计结论附件ID
			$('#tab3,#tab4').show();
			$('#qtab').tabs('enableTab',2);
			$('#qtab').tabs('enableTab',3);
		}
	}catch(e){
		alert("setConclustionTab error:"+e.messsage);
	}
}

</script>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div style="overflow:hidden;position:absolute;top:0px;right:0px;z-index:99999;" >		
		<input type="hidden" id="parentTabId"   name="parentTabId"/>
		<input type='hidden' id='audDatumParam' name='audDatumParam'/>
		<a href="javascript:void(0)" id='dvSave' class="easyui-splitbutton" style="display:none;"   
        data-options="menu:'#muItem',iconCls:'icon-save'">保存</a>   
		<div id="muItem" style="width:100px;">   
		    <div id='dvSave2' data-options="iconCls:'icon-save'">保存并关闭</div>
		</div>
		<a id='dvSubmit'  class="easyui-linkbutton" iconCls="icon-ok"      style='border-width:0px;'>送审</a> 
		<a id='dvRetreat' class="easyui-linkbutton" iconCls="icon-return"  style='border-width:0px;display:none;'>退回</a>  
		<a id='dvClose'   class="easyui-linkbutton"  iconCls="icon-cancel" style='border-width:0px;'>关闭</a>	
	</div>

	<div region="center" border="0">   
	    <div id="qtab"  border="0">  
	       <div title='项目信息' id='tab1' border="0" style='overflow:hidden;'>
	           <iframe id='dvAudProject' name='dvAudProject'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="送审资料清单" id='tab2' border="0" style='overflow:hidden;'>  	    	 	
	           <iframe id='audDatum' name='audDatum'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="项目台帐" id='tab3' border="0" style='overflow:hidden;display:none;'>
	           <iframe id='audAccount' name='audAccount'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>
	       </div>
	       <div title="审计结论" id='tab4' border="0" style='overflow:hidden;display:none;'>
	        	<iframe id='audConclusion' name='audConclusion'
	           	width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden"></iframe>  	    	 	
	       </div>
	    </div>
	</div>
</body>
</html>