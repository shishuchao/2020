<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!-- 选择合同 招标 项目 的公共窗口 -->
<div id="aud_openEaInfo" style='overflow:hidden;padding:0px;margin:0px;' ></div>

<script type="text/javascript">
function aud$openSelectWin(title,url){
	$('#aud_openEaInfo').window({   
       title:title ?  title  : '请选择',
       modal:true,
       minimizable:false,
       maximizable:false,
       collapsible:false,
       closable:true,
       closed:false,
       width:'90%',
       height:370,
       top:20,
       content : '<iframe src="'+url+'" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>'
    });
}

function aud$closeSelectWin(){
	$('#aud_openEaInfo').window('close');
} 
</script>