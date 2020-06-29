<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
          type="text/css">
    <s:head theme="simple"/>
    <title>审计单位资料</title>
</head>
<body>
<script type="text/javascript">
    function deleteAuditList(uuid) {
        if (uuid) {
            window.location = '${contextPath}/auditAccessoryList/deleteAccessory.action?auditUuid=' + uuid;
        }
    }
    function editAuditList(uuid) {
        if (uuid) {
            window.location = '${contextPath}/auditAccessoryList/editAccessory.action?auditUuid=' + uuid;
        }
    }
</script>
<table cellpadding=1 cellspacing=1 border=0 bgcolor=#409cce class=ListTableFile>
    <tr class="listtablehead">
        <td align="left" class="edithead">
            <div style="display: inline;width:80%;">
                被审计单位资料收集
            </div>
        </td>
    </tr>
</table>
 <table id="aaList" cellpadding=0 cellspacing=1 border=0
                bgcolor="#409cce" class="ListTable" align="center">
    <tr>
        <td  class="ListTableTrStageT">
            资料清单
        </td>
        <td  class="ListTableTrStageT">
            是否必传
        </td>
        <td  class="ListTableTrStageT">
            模板列表
        </td>
        <td align="center" class="ListTableTrStageT">
            操作
        </td>
    </tr>
    <c:forEach items="${resultSet}" var="aaBean">
        <tr>
            <td  class="ListTableTrStageF">
            ${aaBean.auditProgram}
            </td>
            <td  class="ListTableTrStageF">
             ${aaBean.needDo}
            </td>
            <td  class="ListTableTrStageF">
                <c:forEach items="${aaBean.templateList}" var="fileBean">
                    <a href='${contextPath}/commons/file/downloadFile.action?fileId=${fileBean.fileId}'>${fileBean.fileName}</a><br>
                </c:forEach>
            </td>
            <td align="center" class="ListTableTrStageF">
                <center>
                <input type="button" value="修  改" onclick="editAuditList('${aaBean.aaid}')"/>
                <input type="button" value="删  除" onclick="deleteAuditList('${aaBean.aaid}')"/>
                </center>
            </td>
        </tr>
    </c:forEach>
</table>
<table>
    <tr>
        <td align="left" class="listtabletr11">
            <input type="button" value="增  加"
                   onclick="window.open('${contextPath}/auditAccessoryList/addAccessory.action','_blank','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"/>
        </td>
    </tr>
</table>
</body>
</html>