<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目管理-项目终结</title>
		<s:head theme="ajax" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
	</head>

	<body>
			<div class="easyui-tabs" id='reportPanel' style="overflow:visible;" fit="true">
				<div id='reportDocumentDiv' title='审计报告'
					>
					<table  class="its" align="center">
						<tr class=listtablehead>
							<td class="edithead" colspan="7" style='text-align:left;'>
								审计报告初稿
							</td>
						</tr>
						<tr class="titletable1">
							<th><center>文件类型</center></th>
							<th><center>文件名称</center></th>
							<th><center>创建日期</center></th>
							<th><center>创建人</center></th>
							<th><center>最后编辑日期</center></th>
							<th><center>最后编辑人</center></th>
							<th><center>操作</center></th>
						</tr>
						<%--

						<tr class="listtabletr2">
							<td><center>审计报告素材</center></td>
							<td><s:property value="sucai.fileName"/></td>
							<td><center><s:property value="sucai.fileTime"/></center></td>
							<td><center><s:property value="sucai.uploader_name"/></center></td>
							<td><center><s:property value="sucai.fileEditTime"/></center></td>
							<td><center><s:property value="sucai.remark_name"/></center></td>
							<td>
								<center>
									<s:if test="sucai!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/commons/file/downloadFile.action?fileId=<s:property value="sucai.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									</s:if>
								</center>
							</td>
						</tr> -->
						
						<tr class="listtabletr2">
							<td><center>审计报告草稿</center></td>
							<td><s:property value="caogao.fileName"/></td>
							<td><center><s:property value="caogao.fileTime"/></center></td>
							<td><center><s:property value="caogao.uploader_name"/></center></td>
							<td><center><s:property value="caogao.fileEditTime"/></center></td>
							<td><center><s:property value="caogao.remark_name"/></center></td>
							<td>
								<center>
									<s:if test="caogao!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/commons/file/downloadFile.action?fileId=<s:property value="caogao.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									</s:if>
								</center>
							</td>
						</tr>
						 --%>
						<tr class="listtabletr2">
							<td><center>审计报告初稿</center></td>
							<td><s:property value="chugao.fileName"/></td>
							<td><center><s:property value="chugao.fileTime"/></center></td>
							<td><center><s:property value="chugao.uploader_name"/></center></td>
							<td><center><s:property value="chugao.fileEditTime"/></center></td>
							<td><center><s:property value="chugao.remark_name"/></center></td>
							<td>
								<center>
									<s:if test="chugao!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/commons/file/downloadFile.action?fileId=<s:property value="chugao.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									</s:if>
								</center>
							</td>
						</tr>
						
					</table>
					<table  class=its align="center">
						<tr class=listtablehead>
							<td class="edithead" colspan="7" style='text-align:left'>
								审计报告定稿
							</td>
						</tr>
						<tr class="titletable1">
							<th><center>文件类型</center></th>
							<th><center>文件名称</center></th>
							<th><center>创建日期</center></th>
							<th><center>创建人</center></th>
							<th><center>最后编辑日期</center></th>
							<th><center>最后编辑人</center></th>
							<th><center>操作</center></th>
						</tr>
						<tr class="listtabletr2">
							<td><center>审计报告征求意见稿</center></td>
							<td><s:property value="nidinggao.fileName"/></td>
							<td><center><s:property value="nidinggao.fileTime"/></center></td>
							<td><center><s:property value="nidinggao.uploader_name"/></center></td>
							<td><center><s:property value="nidinggao.fileEditTime"/></center></td>
							<td><center><s:property value="nidinggao.remark_name"/></center></td>
							<td>
								<center>
									<s:if test="nidinggao!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/commons/file/downloadFile.action?fileId=<s:property value="nidinggao.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									</s:if>
								</center>
							</td>
						</tr>
						<tr class="listtabletr2">
							<td><center>审计报告定稿</center></td>
							<td><s:property value="dinggao.fileName"/></td>
							<td><center><s:property value="dinggao.fileTime"/></center></td>
							<td><center><s:property value="dinggao.uploader_name"/></center></td>
							<td><center><s:property value="dinggao.fileEditTime"/></center></td>
							<td><center><s:property value="dinggao.remark_name"/></center></td>
							<td>
								<center>
									<s:if test="dinggao!=null">
										<a href="javascript:;" onclick="window.open('${contextPath}/commons/file/downloadFile.action?fileId=<s:property value="dinggao.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
									</s:if>
								</center>
							</td>
						</tr>
					</table>
					
					<div id="accelerys" align="center">
						<s:property escape="false" value="accessoryList" />
					</div>
					
				</div>
				<div id='feedbackDiv' title='征求及反馈意见'
					>
					<iframe id="feedbackFrame"
							src="${pageContext.request.contextPath}/project/feedback/online/issueList.action?view=view&formId=<s:property value="crudObject.formId"/>
								&project_id=<s:property value="crudObject.project_id"/>&project_code=<s:property value="crudObject.project_code"/>
								&processType=report"
							frameborder="0" width="100%" height="400" scrolling="auto"></iframe>
					
				</div>
				<div id='resultDiv' title='处理意见'
					>
					<iframe id="resultFrame"
							src="${pageContext.request.contextPath}/project/feedback/idea/feedbackInFlowManual.action?view=view&formId=<s:property value="crudObject.formId"/>
								&project_id=<s:property value="crudObject.project_id"/>&project_code=<s:property value="crudObject.project_code"/>
								&processType=report&viewPermission=${viewPermission}"
							frameborder="0" width="100%" height="400" scrolling="auto"></iframe>
				</div>
                <div id='auditWorkProgramPrepare' title='补充性审计文书' 
                        >
                   <iframe id="prepareWorkProgram"
                       src="${contextPath}/workprogram/viewWorkProgramProjectDetail.action?projectid=<s:property value="crudObject.project_id" />&wpd_stagecode=report"
                       frameborder="0" width="100%" height="440" scrolling="auto"></iframe>
                </div>
                <div id='mendLedgerList' title='整改信息设定' 
                        >
                   <iframe id="mendLedgerList"
                       src="${contextPath}/proledger/problem/mendLedgerList.action?project_id=<s:property value="crudObject.project_id" />&wpd_stagecode=report&isEdit=false&permission=full"
                       frameborder="0" width="100%" height="440" scrolling="auto"></iframe>
				</div>
				<div id='projectMemberDiv' title='成员信息' >
					<div align="center">
						<iframe id="projectMemberFrame"
							src="${contextPath}/project/members/listMembers.action?projectFormId=<s:property value="crudObject.project_id" />"
							frameborder="0" width="100%" height="440"></iframe>
					</div>
				</div>
				<s:if test="varMap['modifyZJSQRead']==null?true:varMap['modifyZJSQRead']">
						<div id='auditResultPermission' title='审计成果组间授权' 
							>
							<iframe id="auditResultPermissionFrame"
								src="${contextPath}/project/permission/edit.action?pso.formId=<s:property value="crudObject.project_id" />"
								frameborder="0" width="100%" height="320" scrolling="auto"></iframe>
						</div>
				</s:if><%--
				<s:if test="${projectStartObject.superviserId==user.floginname}">
						<div id='supervisionInfo' title='督导项目专用'>
							<iframe id="projectInfoFrame"
							src="${contextPath}/project/start/listSupervision.action?project_id=<s:property value="crudObject.project_id"/>&type=view"
							frameborder="0" width="100%" height="500"></iframe>
						</div>
				</s:if>--%>
			</div>
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
	</body>
</html>
