<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>简易流程-项目完成</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div region="north" data-options="height:30">
	<form action="${contextPath}/archives/workprogram/pigeonhole/projectAttachments.action" id="fileForm">
		<input type="hidden" name="projectId" value="${projectId}"/>
		<label for="fileName">文件名：</label><input type="text" id="fileName" class="noborder" maxlength="100" name="fileName" value="${fileName}"/>&nbsp;&nbsp;<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" id="searchBtn" onclick="$('#fileForm').submit();">搜索</a>
	</form>
</div>
<div region="center">
	<div class="easyui-panel" title="审计报告及附件" data-options="border:false">
		<table class="easyui-datagrid" data-options="fit:false,fitColumns:true,nowrap:false,striped:true,border:true">
			<thead>
			<tr>
				<th data-options="field:'fileType',width:'10%',halign:'center'">文件类型</th>
				<th data-options="field:'fileName',width:'15%',halign:'center'">文件名称</th>
				<th data-options="field:'createDate',width:'12%',halign:'center',align:'center'">创建日期</th>
				<th data-options="field:'creator',width:'8%',halign:'center',align:'center'">创建人</th>
				<th data-options="field:'updated',width:'11%',halign:'center',align:'center'">最后编辑日期</th>
				<th data-options="field:'updator',width:'8%',halign:'center',align:'center'">最后编辑人</th>
				<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
				<th data-options="field:'attachments',width:'20%',halign:'center',align:'left'">附件</td>
			</tr>
			</thead>
			<tbody>
			<c:if test="${not empty dinggaoName and (not empty redinggao or not empty shenjizuList)}">
				<tr>
					<td>${dinggaoName}</td>
					<td>${redinggao.fileName}</td>
					<td>${redinggao.fileTime}</td>
					<td>${redinggao.uploader_name}</td>
					<td>${redinggao.fileEditTime}</td>
					<td>${redinggao.remark_name}</td>
					<td>
						<c:if test="${not empty redinggao}">
							<a href="javascript:;"
							   onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=${redinggao.fileId}&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
							<a href="${contextPath}/commons/file/downloadFile.action?fileId=${redinggao.fileId}">下载</a>
						</c:if>
					</td>
					<td>
						<div id="shenjizuFiles"></div>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty shanghuiName and (not empty shanghui or not empty shanghuiList)}">
				<tr>
					<td>${shanghuiName}</td>
					<td>${shanghui.fileName}</td>
					<td>${shanghui.fileTime}</td>
					<td>${shanghui.uploader_name}</td>
					<td>${shanghui.fileEditTime}</td>
					<td>${shanghui.remark_name}</td>
					<td>
						<c:if test="${not empty shanghui}">
							<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=${shanghui.fileId}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
							<a href="${contextPath}/commons/file/downloadFile.action?fileId=${shanghui.fileId}">下载</a>
						</c:if>
					</td>
					<td>
						<div id="shanghuiFiles"></div>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty shenjijureportName and (not empty shenjijureport or not empty shenjijureportList)}">
				<tr >
					<td>${shenjijureportName}</td>
					<td>${shenjijureport.fileName}</td>
					<td>${shenjijureport.fileTime}</td>
					<td>${shenjijureport.uploader_name}</td>
					<td>${shenjijureport.fileEditTime}</td>
					<td>${shenjijureport.remark_name}</td>
					<td>
						<c:if test="${not empty shenjijureport}">
							<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=${shenjijureport.fileId}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
							<a href="${contextPath}/commons/file/downloadFile.action?fileId=${shenjijureport.fileId}">下载</a>
						</c:if>
					</td>
					<td>
						<div id="shenjijureportFiles"></div>
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty juedingshuName and (not empty juedingshu or not empty juedingshuList)}">
				<tr>
					<td>${juedingshuName}</td>
					<td>${juedingshu.fileName}</td>
					<td>${juedingshu.fileTime}</td>
					<td>${juedingshu.uploader_name}</td>
					<td>${juedingshu.fileEditTime}</td>
					<td>${juedingshu.remark_name}</td>
					<td>
						<c:if test="${not empty juedingshu}">
							<a href="javascript:;" onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?r=t&fileId=${juedingshu.fileId}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
							<a href="${contextPath}/commons/file/downloadFile.action?fileId=${juedingshu.fileId}">下载</a>
						</c:if>
					</td>
					<td>
						<div id="juedingshuFiles"></div>
					</td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>
	<hr>
	<div class="easyui-panel" title="审计底稿附件" data-options="border:false" style="padding-top: 10px;">
		<table class="easyui-datagrid" data-options="fit:false,fitColumns:true,nowrap:false,striped:true,border:true">
			<thead>
			<tr>
				<th data-options="field:'ms_name',width:'20%',halign:'center'">底稿名称</th>
				<th data-options="field:'ms_date',width:'15%',halign:'center',align:'center'">创建日期</th>
				<th data-options="field:'ms_author_name',width:'10%',halign:'center',align:'center'">创建人</th>
				<th data-options="field:'attachments',width:'40%',halign:'center',align:'left'">底稿附件</td>
			</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty manuList}">
						<c:forEach items="${manuList}" var="manu" varStatus="st">
							<tr>
								<td>${manu.ms_name}</td>
								<td>${manu.ms_date}</td>
								<td>${manu.ms_author_name}</td>
								<td>
									<div id="manuFile_${st.index}" fileGuid="${manu.file_id}"></div>
								</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>

			</tbody>
		</table>
	</div>
</div>
<script type="text/javascript">
    $(function(){
        if($('#shenjizuFiles').length > 0){
            $('#shenjizuFiles').fileUpload({
                fileGuid:'${reportObject.shenjizu_accessory}',
                echoType:2,
                isDel:false,
                isAdd:false,
                isEdit:false,
                uploadFace:1
            });
        }
        if($('#shanghuiFiles').length > 0){
            $('#shanghuiFiles').fileUpload({
                fileGuid:'${reportObject.shanghui_accessory}',
                echoType:2,
                isDel:false,
                isEdit:false,
                isAdd:false,
                uploadFace:1
            });
        }
        if($('#shenjijureportFiles').length > 0){
            $('#shenjijureportFiles').fileUpload({
                fileGuid:'${reportObject.shenjijureport_accessory}',
                echoType:2,
                isDel:false,
                isEdit:false,
                isAdd:false,
                uploadFace:1
            });
        }
        if($('#juedingshuFiles').length > 0){
            $('#juedingshuFiles').fileUpload({
                fileGuid:'${reportObject.juedingshu_accessory}',
                echoType:2,
                isDel:false,
                isEdit:false,
                isAdd:false,
                uploadFace:1
            });
        }

        var manuSize = parseInt('${manuSize}');
        if(manuSize > 0){
            for(var i = 0;i < manuSize;i++){
                initFileUpload(i);
            }
        }
    });

    function initFileUpload(index){
        $('#manuFile_'+index).fileUpload({
            fileGuid:$('#manuFile_'+index).prop('fileGuid'),
            echoType:2,
            isDel:false,
            isEdit:false,
            isAdd:false
        });
	}
</script>
</body>
</html>
