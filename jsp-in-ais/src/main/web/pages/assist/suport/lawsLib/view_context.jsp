<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: sunyang
  Date: 2019-08-06
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>法律法规查看</title>
</head>
<body>
<div >
    <table cellpadding=0 cellspacing=0 border=0  class="ListTable" style="width:100%;">
        <tr>
            <td class="editTd" style="width:35%;word-break:break-all;">文号：<s:property value = "assistSuportLawslib.codification" escape="false"></s:property></td>
            <td class="editTd" style="width:25%;word-break:break-all;">&nbsp;&nbsp;&nbsp;&nbsp;发文单位：<s:property value = "assistSuportLawslib.promulgationDept" escape="false"></s:property></td>
            <td class="editTd" style="width:25%;word-break:break-all;">&nbsp;&nbsp;&nbsp;&nbsp;发文时间：<s:property value = "assistSuportLawslib.promulgationDate" escape="false"></s:property></td>

            <td class="editTd" style="width:25%;word-break:break-all;">&nbsp;&nbsp;&nbsp;&nbsp;效力级别:<s:property value = "assistSuportLawslib.summary" escape="false"></s:property></td>
        </tr>

        <tr>
            <td colspan="4"><hr style="height:1px;border:none;border-top:1px solid #ccc;" /></td>
        </tr>
        <tr>
            <td colspan="4"><br><h3 align="center"><s:property value = "assistSuportLawslib.title" ></s:property></h3><br></td>
        </tr>
        <tr>
            <td colspan="4" >
                <s:property value = "assistSuportLawslib.content" escape="false"></s:property>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                附件：
            </td>
        <tr/>
        <s:iterator value="fileList" id="file">
        <tr>
            <td colspan="4">
                   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);"
                       onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=<s:property value="#file.getFileId()"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"><s:property value="#file.getFileName()"/></a>
            </td>
        </tr>
        </s:iterator>
    </table>

</div>


</body>
</html>
