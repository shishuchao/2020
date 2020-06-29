<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>添加模板</title>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
    
    <link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/swfload/uploadFile.js"></script>
    
    <s:head theme="ajax"/>
    <style type="text/css">
        .ListTableTr2 {
            BACKGROUND-COLOR: #ffffff;
            height: 20;
            padding-left: 5px;
        }

        .1_lan {
            font-size: 13px;
            height: 20;
            font-family: "simsun";
            color: #007FFF
        }

        .titletable1 {
            background-color: #EEF7FF;
        }

        .edithead {
            background-image: url(/ais/images/ais/bg1a.jpg);
            background-repeat: repeat;
            height: 26px;
            text-align: left;
            vertical-align: middle;
            font-size: 13px;
            font-family: "simsun";
            font-weight: bold;
            color: #007FFF;
            background-repeat: repeat;
        }

        .ListTableFile {
            background-color: #7CA4E9;
            font-size: 13px;
            border: 0px;
            width: 97%;
            margin: 10px 10px 10px 10px;
        }

        .listtablehead {
            background-image: url(/ais/images/ais/bg1a.jpg);
            background-repeat: repeat;
            height: 26px;
            text-align: left;
        }

        input {
            font-family: 宋 体;
            font-size: 11pt;
            padding-top: 1px;
            border: 1pt solid #99cccc;
            text-indent: 1px;
        }

        .ListTableTr11 {
            BACKGROUND-COLOR: #F5F5F5;
            width: 8%;
            height: 20;
            vertical-align: middle;
            text-align: right;
        }

        .ListTable {
            background-color: #7CA4E9;
            font-size: 13px;
            border: 0px;
            width: 100%;
            margin: -10px -10px -10px -10px;
        }

        .ListTableTr22 {
            BACKGROUND-COLOR: #ffffff;
            width: 35%;
            height: 20;
            padding-left: 5px;
        }

        a:link { color: #004080; text-decoration: none}
        a:visited { color: #800080; text-decoration: none}
        a:hover { color: #800080; text-decoration: underline}
        a:active { color: #800080; text-decoration: underline}

    </style>
    
    <script language="javascript">
        function doNotDelete() {
            var divObj = document.getElementById("accelerys");
            if (divObj) {
                var aHrefList = divObj.getElementsByTagName("A");
                for (var i = 0; i < aHrefList.length; i++) {
                    if (aHrefList[i].innerText == '删除') {
                        aHrefList[i].style.display = 'none';
                    }
                }
            }
        }

        function $(nodename) {
            return document.getElementsByName(nodename)[0];
        }

        function $$(nodeid) {
            return document.getElementById(nodeid);
        }

        /*
         *上传附件
        */
        function Upload(idName) {
            var contextPath = '${contextPath}';
			var deletePermission = 'true';
			var isEdit = "false";
			var width = 500;
			var height = 450;
            uploadFileModel(contextPath,deletePermission,isEdit,idName,width,height);
        }

        /*
        * 删除附件
        */
        function deleteFile(fileId, guid, accessoryId, isDelete, isEdit, appType, title) {
            var boolFlag = window.confirm("确认删除吗?");
            if (boolFlag) {
            	DWREngine.setAsync(false);
                DWREngine.setAsync(false);DWRActionUtil.execute(
                { namespace:'/auditAccessoryList', action:'deleteTemplate', executeResult:'false' },
                {'fileId':fileId, 'accessoryId':accessoryId,'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
                        xxx);
                function xxx(data) {
                    document.getElementById('accelerys').innerHTML = data['accessoryList'];
                }
            }
        }
        <s:if test="uploadRole==2">
        window.attachEvent('onload', doNotDelete);
        </s:if>
    </script>
</head>

<body>

<table id="auditAccessoryListTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" width="100%"
       class="ListTable">
    <tr>
        <td align="left" class="listtabletr11" style="text-align:left;width:15%">
            <s:if test="uploadRole==1">
                <input type="button" value="上传模板" onclick="Upload('accelerys')"/>
            </s:if>
        </td>
        <td class="ListTableTr22" style="width:85%">
            <div id="accelerys" align="center">
                <s:property escape="false" value="accessoryList"/>
            </div>
        </td>
    </tr>
</table>
</body>
</html>