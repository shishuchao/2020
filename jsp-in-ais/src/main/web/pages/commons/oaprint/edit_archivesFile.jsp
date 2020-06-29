<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>提取文书</title>
<!-- <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
</head>
<body >
	<div>
	<div>
	
	</div>
	<div region="north" >
	<table class="easyui-datagrid" data-options="fit:false,fitColumns:true,nowrap:false,striped:true,border:false">
		<thead>
			<tr>
				<th data-options="field:'fileType',width:'16%',halign:'center'">文件类型</th>
				<th data-options="field:'fileName',width:'16%',halign:'center'">文件名称</th>
				<th data-options="field:'operate',width:'20%',halign:'center',align:'center'">操作</th>
			</tr>
		</thead>
<%-- 		<tbody>
			<tr>
				<td>单项底稿</td>
				<td>单项底稿.doc</td>
				<td>
					<s:if test="${null!=af.unitermFileId }">
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.unitermFileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.unitermFileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
					</s:if>
					<s:else>
						<a href="javascript:;" onclick="archivesUniterm('uniterm')">提取</a>
					</s:else>
				</td>
			</tr>
		</tbody>
		<tbody>
			<tr>
				<td>综合底稿</td>
				<td>综合底稿.doc</td>
				<td>
					<s:if test="${null!=af.comprehensiveFileId}">
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.comprehensiveFileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.comprehensiveFileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
					</s:if>
					<s:else>
						<a href="javascript:;" onclick="archivesUniterm('comprehensive')">提取</a>
					</s:else>
				</td>
			</tr>
		</tbody> --%>
		<s:if test="${''!=af.evidenceIds}">
		<tbody>
			<tr>
				<td>取证记录</td>
				<td>取证记录.doc</td>
				<td>
					<s:if test="${null!=af.evidenceFileId}">
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.evidenceFileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.evidenceFileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
					</s:if>
					<s:else>
						<a href="javascript:void(0);" onclick="archivesUniterm('evidence')">提取</a>
					</s:else>
				</td>
			</tr>
		</tbody>
		</s:if><s:else>
		<tbody>
			<!-- 没有对应的取证记录不需要提取操作！ -->
		</tbody>
		</s:else>
		<s:if test="${''!=af.audBookIds}">
		<tbody>
			<tr>
				<td>审计查询书</td>
				<td>审计查询书.doc</td>
				<td>
					<s:if test="${null!=af.audBookFileId}">
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.audBookFileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
						<a href="javascript:void(0);"
							onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="af.audBookFileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
					</s:if>
					<s:else>
						<a href="javascript:void(0);" onclick="archivesUniterm('book')">提取</a>
					</s:else>
				</td>
			</tr>
		</tbody>
		</s:if>
		<s:else>
		<tbody>
			<!-- 没有对应的审计查询书不需要提取操作！ -->
		</tbody>
		</s:else>
	</table>
	</div>
	<div region="south" style="text-align:right;width: 53%;">
		<button class="easyui-linkbutton" iconCls="icon-folderGo" onclick="archivesFile()">提取文件</button>&nbsp;&nbsp;
	</div>
	</div>
<iframe id="dx" src="" style="display:none;"></iframe>
<script type="text/javascript">

	/*
	 * 提取提取文书
	 */
	function archivesUniterm(type) {
		 var manuIds='';
		 var templateId='';
		 if('uniterm'==type){
			 manuIds='${af.unitermIds}';
			 templateId='${af.unitermTemplateId}';
		 }else if('comprehensive'==type){
			 manuIds='${af.comprehensiveIds}';
			 templateId='${af.comprehensiveTemplateId}';
		 }else if('evidence'==type){
			 manuIds='${af.evidenceIds}';
			 templateId='${af.evidenceTemplateId}';
		 }else{
			 manuIds='${af.audBookIds}';
			 templateId='${af.audBookTemplateId}';
		 }
		var project_id='${af.project_id}';
		var archives_form_id='${af.archives_form_id}';
	    $("#dx").attr("src","");
	    var uniterm_url = "${contextPath}/archives/workprogram/pigeonhole/archivesAllWriter.action?manuIds=" + manuIds
      		 + "&project_id=" + project_id+ "&templateId=" + templateId+ "&type="+type+"&archives_form_id="+archives_form_id;
	    $("#dx").attr("src",uniterm_url);
	}
	/*
	 * 提取提取文书
	 */
	function archivesFile() {
		var project_id='${af.project_id}';
		var archives_form_id='${af.archives_form_id}';
		parent.archivesWriterClose();
		parent.archivesFile(archives_form_id,project_id)
	}
	

</script>
</body>
</html>
