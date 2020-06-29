<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>离线采集数据管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <s:head theme="ajax"/>
    <script>
        $(function () {
            $('#test').tabs({
                border: false,
                onSelect: function (title, index) {
                    if (title =='本级及下级采集数据查看') {
                        $('#cascade_iframe').attr('src', '<%=request.getContextPath()%>/mng/audobj/data/listAuditObjectData.action?root_audit_object=<%=request.getParameter("root_audit_object")%>&view=true&download=true');
                    }
                }
            });
        });
    </script>
</head>
<body>
<div class='easyui-tabs' fit='true' id='test'>
    <div title="本级采集数据管理" style="width: 100%;overflow:hidden;">
        <iframe id="self_iframe"
                src="<%=request.getContextPath()%>/mng/audobj/data/listAuditObjectData.action?root_audit_object=<%=request.getParameter("root_audit_object")%>&exclude_child=true&download=true"
                frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
    </div>
    <div title="本级及下级采集数据查看" style="width: 100%;overflow:hidden;">
        <iframe id="cascade_iframe"
                src=""
                frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
    </div>
</div>
</body>
</html>
