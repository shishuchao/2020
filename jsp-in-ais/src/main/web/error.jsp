<%@ page contentType="text/html; charset=utf-8" %>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/styles/portal/ext-all.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/styles/portal/examples.css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>

<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 	
<script>
var msg= '您没有授权！</p>点击<a href="javascript:void(0);" onclick="history.back();">此处</a>返回，或者点击<a href="<%=request.getContextPath()%>/j_acegi_logout">此处</a>注销系统。';

Ext.onReady(function(){
    var p = new Ext.Panel({
        title: '出错信息窗口',
        collapsible:false,
        renderTo: document.body,
        width:400,
        html:  msg
    });
});
</script>