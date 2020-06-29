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
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div region="center">
	<c:if test="${not empty pso and pso.is_closed eq 'running' and canClose}">
		<div class="row" style="padding-bottom: 20px;">
			<div class="col-md-12">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" id="closeBtn">关闭项目</a>
<%--				<h5 style="color: red;">温馨提示：项目关闭后将无法再对此项目做任何操作，请确保项目已经归档！</h5>--%>
			</div>
		</div>
	</c:if>
	<div class="panel panel-success">
		<div class="panel-heading">
			<p class="panel-title">审计报告</p>
		</div>
		<div class="panel-body">
			<c:choose>
				<c:when test="${not empty fileBeans}">
					<c:forEach begin="1" end="${fileRows}" var="index">
						<div class="row">
							<c:forEach items="${fileBeans}" begin="${(index-1)*fn:length(fileBeans)}" end="${(fn:length(fileBeans) gt index*5) ? (index*5):fn:length(fileBeans)}" var="file">
								<div class="col-md-2 text-center" style="cursor: pointer;" onclick="window.open('${contextPath}/commonPlug/downloadFiles.action?commonFileUpload_fileIds=${file.fileId}&commonFileUpload_zipFile=false&commonFileUpload_packageName=${file.fileName}')">
									<c:choose>
										<c:when test="${file.fileExtension eq 'doc' or file.fileExtension eq 'docx'}">
											<p style="font-size: 2em;color:blue;">
												<i class="fa fa-file-word-o"></i>
											</p>
										</c:when>
										<c:when test="${file.fileExtension eq 'xls' or file.fileExtension eq 'xlsx'}">
											<p style="font-size: 2em;color:green;">
												<i class="fa fa-file-excel-o"></i>
											</p>
										</c:when>
										<c:when test="${file.fileExtension eq 'ppt' or file.fileExtension eq 'pptx'}">
											<p style="font-size: 2em;color:orangered;">
												<i class="fa fa-file-powerpoint-o"></i>
											</p>
										</c:when>
										<c:when test="${file.fileExtension eq 'pdf'}">
											<p style="font-size: 2em;color:yellowgreen;">
												<i class="fa fa-file-pdf-o"></i>
											</p>
										</c:when>
										<c:when test="${file.fileExtension eq 'png' or file.fileExtension eq 'jpg' or file.fileExtension eq 'gif'}">
											<p style="font-size: 2em;color:red;">
												<i class="fa fa-file-image-o"></i>
											</p>
										</c:when>
										<c:when test="${file.fileExtension eq 'zip' or file.fileExtension eq 'rar' or file.fileExtension eq '7z'}">
											<p style="font-size: 2em;color:orange;">
												<i class="fa fa-file-archive-o"></i>
											</p>
										</c:when>
										<c:otherwise>
											<p style="font-size: 2em;color:wheat;">
												<i class="fa fa-file-o"></i>
											</p>
										</c:otherwise>
									</c:choose>
									<p>${file.fileName}</p>
								</div>
							</c:forEach>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h4>没有报告及相关附件</h4>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="panel panel-info">
		<div class="panel-heading">
			<p class="panel-title">审计底稿</p>
		</div>
		<div class="panel-body">
			<c:choose>
				<c:when test="${not empty manuList}">
					<c:forEach begin="1" end="${manuRows}" var="index">
						<div class="row">
							<c:forEach items="${manuList}" begin="${(index-1)*fn:length(manuList)}" end="${(fn:length(manuList) gt index*5) ? (index*5):fn:length(manuList)}" var="manu">
								<div class="col-md-2 text-center" style="cursor: pointer;" onclick="aud$openNewTab('${manu.ms_name}','${contextPath}/operate/manu/view.action?view=view&projectview=view&pageview=pageview&crudId=${manu.formId}&project_id=${manu.project_id}',true)">
									<p style="font-size: 2em;color:blue;">
										<i class="fa fa-file-word-o"></i>
									</p>
									<p>${manu.ms_name}</p>
								</div>
							</c:forEach>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h4>没有审计底稿</h4>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<p class="panel-title">审计问题</p>
		</div>
		<div class="panel-body">
			<c:choose>
				<c:when test="${not empty problemList}">
					<c:forEach begin="1" end="${proRows}" var="index">
						<div class="row">
							<c:forEach items="${problemList}" begin="${(index-1)*fn:length(problemList)}" end="${(fn:length(problemList) gt index*5) ? (index*5):fn:length(problemList)}" var="pro">
								<div class="col-md-2 text-center" style="cursor: pointer;" onclick="aud$openNewTab('${pro.audit_con}','${contextPath}/proledger/problem/viewSimplifiedProblem.action?problemId=${pro.id}',true)">
									<p style="font-size: 2em;color:green;">
										<i class="fa fa-file-excel-o"></i>
									</p>
									<p>${pro.audit_con}</p>
								</div>
							</c:forEach>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h4>没有审计问题</h4>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<script type="text/javascript">
	function closeProject() {
	    top.$.messager.confirm('确认','确认要关闭此项目吗？',function (r) {
			if(r){
                $.ajax({
                    url:'${contextPath}/project/closeProject.action',
                    data:{
                        'crudId':'${projectId}',
                        'source':'simplified'
                    },
                    type:'POST',
                    dataType:'json',
                    success:function(data){
                        if(data.status == 'success'){
                            showMessage1('关闭项目成功');
                            window.parent.location.reload();
                        } else {
							showMessage1('关闭项目失败！' + data.msg);
						}
                    }
                });
			}
        });
    }

    $(function(){
        $('#closeBtn').click(function () {
			closeProject();
        });
	})
</script>
</body>
</html>
