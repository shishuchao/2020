<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <title>查看中介机构</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true" border='0'>
<div region="center" border='0'>
    <div class="easyui-tabs" fit="true" id="tabDiv" border='0'>
        <div id="maintainInfo" title="基本信息" style="overflow:hidden;">
            <iframe id="maintainInfoFrame" src="<%=request.getContextPath()%>/agency/maintain/viewMaintain.action?formId=${formId}" style="overflow:hidden;" frameborder="0" width="100%" height="100%"></iframe>
        </div>
        <div id="maintainProject" title="服务项目" style="overflow:hidden;">
            <iframe id="maintainProjectFrame" src="" style="overflow:hidden;" frameborder="0" width="100%" height="100%"></iframe>
        </div>
    </div>
</div>
<script type="text/javascript">
    function doAutoHeight1() {
        if(document.body.clientHeight>165)
            document.all.maintainInfoFrame.style.height = document.body.clientHeight-110;
    }

    function doAutoHeight2() {
        if(document.body.clientHeight>165)
            document.all.maintainProjectFrame.style.height = document.body.clientHeight-110;
    }
    $(function(){
        $('#tabDiv').tabs({
            border:false,
            onSelect:function(title,index){
                if(index == 1){
                    var src = $('#maintainProjectFrame').attr('src');
                    if(src == ''){
                        $('#maintainProjectFrame').attr('src','<%=request.getContextPath()%>/agency/maintain/viewMaintainProject.action?formId=${formId}');
                    }
                }
            }
        });
    });
</script>
</body>
</html>
