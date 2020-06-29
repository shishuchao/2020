<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>档案信息</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">

		<script type="text/javascript">
		 	/*
		 	 *查看归档的详细信息
		 	 */
		 	function archivesPigeonholeDetail(project_id,formId){
		 	    var url = "${contextPath}/archives/pigeonhole/archivesPigeonholeDetail.action?project_id=" 
		 	    		+ project_id + "&&crudId=" + formId;
		 		window.location = url;
		 	}	
		 	/*
		 	 *查看档案借阅信息
		 	 */
		 	function singleArchivesBorrowLog(archives_id){
		 	 	var url = "${contextPath}/archives/borrow/singleArchivesBorrowLog.action?archives_id="+archives_id;
		 		window.location = url;
		 	}		
		</script>
	</head>
	<body>
		<center>
			<s:form action="archivesByPlanCode"
				namespace="/archives/pigeonhole" name="form">

				<display:table name="archivesPigeonholeList" id="row"
					requestURI="/archives/pigeonhole/archivesByPlanCode.action"
					 class="its">
					<display:column property="project_code" title="项目编号"
						 style="WHITE-SPACE: nowrap" headerClass="center" class="center"></display:column>
					<display:column property="project_name" title="项目名称"
						 style="WHITE-SPACE: nowrap;width:120" headerClass="center" class="center" maxLength="30"></display:column>
					<display:column property="archives_name" title="档案名称"
						 style="WHITE-SPACE: nowrap;width:120" headerClass="center" class="center" maxLength="30"></display:column>
					<display:column title="操作" headerClass="center" class="center"
						style="WHITE-SPACE: nowrap" media="html">
						    <a
								href="javascript:void(0);"
								onclick="archivesPigeonholeDetail('${row.project_id}','${row.formId}');">归档详细</a>	
								
						<s:if test="${row.archives_status=='3'}">
							<a
								href="javascript:void(0);"
								onclick="singleArchivesBorrowLog('${row.formId}');">借阅日志</a>
						</s:if>
					</display:column>				
					
				</display:table>


				<div align="center">
				<s:button  value="关 闭"  onclick="javascript:window.close();" />
				</div>
			</s:form>
		</center>
	</body>
</html>
