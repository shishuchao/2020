<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

    
<div id="ajaxloading"  name="ajaxloading" style='overflow:hidden;'>   
    <div style="padding:10px;text-align:center;overflow:hidden;">
    	<span style="font-weight:bold;font-size:17px;">正在处理，请稍后&nbsp;<span>
    	<span style='display:none2;'>(<label name='passtime' id='passtime' style='width:30px;color:red;text-align:center;'>0</label>s)</span>    	
    	<img src="${contextPath}/images/portal/default/shared/loading-balls.gif">
    	<img src="${contextPath}/easyui/1.4/themes/icons/delete_small_16px.png" class='ajaxloadingClose' style='cursor:pointer; float:right;padding-top:2px;'>
    	
    </div>    
</div> 

<script type="text/javascript">
$('#ajaxloading').dialog({    
    title : '提示信息',    
    width : 330,    
    height: 40,    
    closed: true,     
    noheader:true,
    modal : true,
    zIndex:99999999,
    onOpen:function(){
    	
    }
});
var passtimecount = 0;
var maxPasstimecount = 300;
function frloadOpen(c){
	var timeoutCount = c ? c : maxPasstimecount;
	if(!$('#ajaxloading').data('isOpened')){	
		$('#ajaxloading').dialog('open');
		$('#ajaxloading').data('isOpened', true);
		window.passInterval = window.setInterval(function(){
			if(passtimecount >= timeoutCount){
				frloadClose();
				//top.$.messager.alert('提示信息',"请求等待超时",'info')
			}
			passtimecount++;
			$('#passtime').text(passtimecount);
		},1000);
	}
}
function frloadClose(){
	try{//alert('call frloadClose')
		$('#ajaxloading').data('isOpened', false);
		$('#ajaxloading').dialog('close');
		passtimecount = 0;
		$('#passtime').text(passtimecount);
		passInterval ? clearInterval(passInterval) : null;		
	}catch(e){
		setTimeout(function(){
			$('#ajaxloading').data('isOpened', false);
			$('#ajaxloading').dialog('close');
			passtimecount = 0;
			$('#passtime').text(passtimecount);
			passInterval ? clearInterval(passInterval) : null;	
		},1000);
	}
}

$(function(){
	$('.ajaxloadingClose').bind('click', frloadClose);
});
</script>


