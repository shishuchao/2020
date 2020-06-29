<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="java.net.URLEncoder" />
<jsp:directive.page import="java.io.File" />
<jsp:directive.page import="ais.sysparam.util.SysParamUtil" />
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<base target="_self">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>上传附件-Server</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/blue/ufaud.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/displaytag/maven-base.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/maven-theme.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/site.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/screen.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/print.css"
			rel="stylesheet" type="text/css">
		<SCRIPT type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/ais_functions.js"></SCRIPT>
		<script>
function validate(myform)
{
	if(!hasSelect2(myform,'canonicalPaths'))
	{
		alert("请选择要操作的记录！");
		return false;
	}
	if(!confirm("确认执行这项操作吗？"))
	{
		return false;
	}
	else
	{
		document.getElementById("submitButton").disabled=true;
		document.getElementById("closeButton").style.display="none";
		document.getElementById("submitButton").value="正在保存... ...";
		document.getElementsByName("myForm")[0].action="${pageContext.request.contextPath}/commons/file/uploadFromServer.action";
		document.getElementsByName("myForm")[0].submit();
	}
	return true;
}
function selfSubmit(directory)
{
	document.getElementsByName("directory")[0].value=directory;
	document.getElementsByName("myForm")[0].action="${pageContext.request.contextPath}/commons/file/listFilesFromServer.action";
	document.getElementsByName("myForm")[0].submit();
}
//LIHAIFENG---2007-07-27

function onloadPage(){
	var arg = window.dialogArguments;
	if(document.getElementById('rewrite').value==null||document.getElementById('rewrite').value==''||document.getElementById('rewrite').value!='true'){
		arg.innerHTML='<s:property escape="false" value="accessoryList"/>';
	    //准备阶段上传审计方案的其他附件		
         if(arg!=undefined && arg.fun!=undefined){
                  arg.fun.call();
                    }
	}
	else{
		arg.location.reload();
	} 

}

/*
function send(){
var arg = window.dialogArguments;
arg.innerHTML="<s:property escape="false" value="accessoryList"/>";
window.close();
}*/
</script>

	</head>
	<body onload="onloadPage()">
		<center>
			<!-- 附件上传的jsp注意!
     在upload.jsp中，先将表单的提交方式设为POST(method="POST")，
     然后将enctype设为multipart/form-data，这并没有什么特别之处 -->
			<s:form name="myForm" action="uploadFromServer" method="POST"
				namespace="/commons/file">
				<s:hidden name="deletePermission" />
				<!-- 删除 -->
				<s:hidden name="isEdit" />
				<!-- 编辑 -->
				<s:hidden name="isEdit2" />
				<s:hidden name="fileId" />
				<s:hidden name="fromCheckFile" />
				<!-- 审计方案 -->
				<s:hidden name="title" />
				<!-- 标题 -->
				<s:hidden name="checkFileType" />
				<!-- 指定上传附件类型 -->
				<s:hidden name="sideRemark" />
				<!-- 侧边提示 -->
				<s:hidden name="guid" />
				<!-- 限制只能上传一个附件 LIHAIFENG 2008-01-08 -->
				<s:hidden id="onlyOne" name="onlyOne" />
				<!-- 是否允许向父窗口回写附件列表 LIHAIFENG 2008-01-10 -->
				<s:hidden id="rewrite" name="rewrite" />
				<s:hidden name="directory" value="${directory}" />
			当前服务器端目录：<%
							String directory4URI = String.class.cast(request
							.getAttribute("directory4URI"));
					if (directory4URI.equals(SysParamUtil
							.getSysParam("ais.mng.server.file.directory")))
						out.print("根目录");
					else
						out.print(directory4URI);
				%>
				<display:table name="fs" id="row"
					requestURI="${contextPath}/commons/file/listFilesFromServer.action"
					class="its" export="false" pagesize="10" size="100%">
					<display:column title="选择" headerClass="center" class="center">
						<c:choose>
							<c:when test="${row.file}">
								<input name="canonicalPaths" type="checkbox"
									value="${row.canonicalPath}" />
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="类型" sortable="true" headerClass="center"
						class="center">
						<c:choose>
							<c:when test="${row.file}">
								<img
									src="${pageContext.request.contextPath}/pages/commons/fileFromServer/leaf.gif"
									alt="文件" />
							</c:when>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/pages/commons/fileFromServer/folder-open.gif"
									alt="文件夹" />
							</c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="文件" sortable="true" headerClass="center"
						class="center">
						<c:choose>
							<c:when test="${row.directory}">
								<a style="cursor:hand"
									onclick="selfSubmit('<%=URLEncoder.encode(File.class.cast(
									pageContext.getAttribute("row"))
									.getCanonicalPath(), "UTF-8")%>')">${row.name}</a>
							</c:when>
							<c:otherwise>${row.name}</c:otherwise>
						</c:choose>
					</display:column>
				</display:table>
				<br />
				<div id="myButton" align="center">
					<s:submit id="submitButton" value="提 交"
						onclick="return validate(myForm)"></s:submit>
					&nbsp;
					<s:button id="closeButton" value="关 闭" onclick="window.close();" />
				</div>
			</s:form>
		</center>
	</body>
</html>
