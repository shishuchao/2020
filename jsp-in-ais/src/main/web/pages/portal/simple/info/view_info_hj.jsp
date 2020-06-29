<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>通知公告</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
</head>
<body style="background: white;">
<div class="container-fluid" style="margin-top: 10px;">
    <div class="row">
        <div class="col-md-4 col-md-offset-4" style="text-align: center;">
            <h2>${information.title}</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4" style="height: 10px;text-align: center;color: darkgrey;font-size:10px;">
            创建人：${information.createManName}&nbsp;&nbsp;创建时间：${information.createdate}
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" style="height: 1px;background: grey;margin-top: 15px;">
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 col-md-offset-2" style="min-height: 450px;padding: 10px;">
            ${information.content}
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div data-options="fileGuid:'${information.uuid}',isAdd:false,isDel:false,isEdit:false"  class="easyui-fileUpload"></div>
        </div>
    </div>
</div>
</body>
</html>
