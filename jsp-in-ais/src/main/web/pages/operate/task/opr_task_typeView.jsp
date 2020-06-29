<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%@page import="ais.user.model.UUser"%>
<s:text id="title" name="'查看审计事项'"></s:text>
<%
UUser user = (UUser) session.getAttribute("user");
%>


<html>
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='/ais/dwr/engine.js'></script>
<script type='text/javascript' src='/ais/dwr/util.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>
	<body  class="easyui-layout">
	<div region="north" style="height:200px; overflow:hidden;">
		<s:form id="myform" onsubmit="return true;" action="/ais/operate/task" method="post">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 20%" ><font color="red">*</font>&nbsp;
						事项类别名称</td>
					<td colspan="3" class="editTd">
					<s:property value="audTask.taskName"/>
					</td>
				</tr>
				<s:hidden name="audTask.taskTemplateId" />
				<s:hidden name="audTask.taskPid" />
				<s:hidden name="audTemplateId" />
				<s:hidden name="taskTemplateId" />
				<s:hidden name="audTask.templateId" />
				<s:hidden name="audTask.id" />
				<s:hidden name="audTask.project_id" />
				
				
				<tr>
						<td style="width: 20%" class="EditHead" >
											<font color="red">*</font>&nbsp;&nbsp;事项序号
										</td>
										<td class="editTd">
										<s:property value="audTask.taskOrder"/>
									</td>							
							<td style="width: 20%" class="EditHead">
								<font color="red">*</font>&nbsp;事项编码
							</td>
							<td style="width: 30%" class="editTd">
							<s:property value="audTask.taskCode"/>
							</td>					
				</tr>
				<tr>
					<td class="EditHead"><s:if test="${team=='1'}">
							<font color="red"></font>&nbsp;&nbsp;&nbsp;执行小组
		                        </s:if> <s:else>
							<font color="red"></font>&nbsp;&nbsp;&nbsp;执行人
								</s:else></td>

					<!--标题栏-->
					<td colspan="3" class="editTd">
						<s:if test="${team=='1'}">
							<s:property value="audTask.taskGroupAssignName"/>
						</s:if>
						<s:else>
							<s:property value="audTask.taskAssignName"/>
						</s:else>
					</td>
				</tr>
				
			 	<tr>
					<td style="width: 20%;" class="EditHead">
						事项开始时间
					</td>
					<td class="editTd">
					<s:property value="audTask.taskStartTime"/>
					</td>
					<td style="width: 20%;" class="EditHead">
						事项结束时间
					</td>
					<td class="editTd">
					<s:property value="audTask.taskEndTime"/>
					</td>
				</tr> 				
				<s:if test="'enabled' == '${shenjichengxu}'">

					<tr>


						<td class="EditHead"><font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项名称:</td>
						<td class="editTd"><s:textfield name="audTask.taskBeforeName"
								cssStyle="width:80%;background-color:#EEF7FF" readonly="true" />
						</td>

						<td class="EditHead"><font color="red"></font>&nbsp;&nbsp;&nbsp;前置事项编码:</td>
						<!--标题栏-->
						<td class="editTd"><s:textfield name="audTask.taskBeforeCode"
								cssStyle="width:80%" readonly="true" /> <img
							src="<%=request.getContextPath()%>/resources/images/s_search.gif"
							onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/task/showTreeListSelect.action&a=a&code=${audTask.taskCode}&project_id=${project_id}&paraname=audTask.taskBeforeName&paraid=audTask.taskBeforeCode',500,330,'前置事项选择')"
							border=0 style="cursor: hand"></td>
						</td>

					</tr>

					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;是否必做:</td>
						<!--标题栏-->
						<td class="editTd"><s:if test="${audTask.taskMust=='1'}">
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust">否
		                        </s:if> <s:else>
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust" checked="checked">否
								</s:else></td>
					</tr>
					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;审计目的:</td>
						<td class="editTd" colspan="3"></td>

					</tr>
					<tr>
						<td class="editTd" colspan="4">
						 <s:textarea name="audTask.taskTarget"
								cssStyle="width:100%;height:90;" />
						</td>
					</tr>

					</tr>

					<tr>
						<td class="EditHead">&nbsp;&nbsp;&nbsp;备注:</td>
						<td class="editTd" colspan="3"></td>

					</tr>
					<tr>

						<td class="editTd" colspan="4">
							<s:textarea name="audTask.taskFile"
								cssStyle="width:100%;height:90;" />

						</td>
					</tr>
				</s:if>
			</table>

			<s:hidden name="newDoubt_type" />
			<s:hidden name="audTemplate.doubt_id" />
			<s:hidden name="audTask.haveLevel" />
			<s:hidden name="doubt_id" />
			<s:hidden name="type" />
			<s:hidden name="project_id" />
			<s:hidden name="team" />
			<s:hidden name="audTask.cat_name" />
			<s:hidden name="audTask.cat_code" />
			<s:hidden name="audTask.taskPcode" />
			<s:hidden name="audTask.template_type" />
			<s:hidden name="path" />
			<s:hidden name="node" />
		</s:form>
	</div>
		<div region="center">
			<table id="listTaskDiv"></table>
		</div>
	<script>
	 $(function(){
			// 初始化生成表格
			$('#listTaskDiv').datagrid({
				url : "<%=request.getContextPath()%>/operate/task/showContentTypeEditByUi.action?taskTemplateId=${audTask.taskTemplateId}&project_id=${project_id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
							{field:'taskName',
									title:'事项名称',
									width:"30%",
									align:'left',
									halign:'center',
									sortable:true
							},
							{field:'taskNametype',
								title:'类别名称',
								width:"25%",
								sortable:true, 
								align:'center'
							},
							{field:'taskCode',
								 title:'事项编码',
								 width:"70px",
								 align:'center', 
								 sortable:true,
								 hidden:true,
							},
							{field:'taskOther',
								 title:'审计程序和方法',
								 width:"20%", 
								 align:'center', 
								 sortable:true
							},
							{field:'law',
								 title:'相关法律法规和监管规定',
								 width:"20%",
								 align:'center', 
								 sortable:false
							},
							{field:'taskMethod',
								 title:'审计查证要点',
								 width:"20%",
								 align:'center', 
								 sortable:false
							},
							{field:'pointContent',
								 title:'重点关注内容',
								 width:"15%",
								 align:'center', 
								 sortable:false
							},
							{field:'taskStartTime',
								 title:'事项开始时间',
								 width:"120px", 
								 align:'center', 
								 sortable:false
							},
							{field:'taskEndTime',
								 title:'事项结束时间',
								 width:"120px", 
								 align:'center', 
								 sortable:false
							}
						]] 
			}); 
		});
	</script>
</body>
</html>
