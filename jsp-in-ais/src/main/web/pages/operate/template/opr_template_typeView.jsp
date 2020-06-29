<!DOCTYPE HTML >
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<html>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<s:head />
		<style type='text/css'>
			textarea { border-width:0px}
		</style>
	</head>
<body  class="easyui-layout">
	<div region="north" border="0" style="height:150px; overflow:auto;">
		<s:form id="myform" onsubmit="return true;" action="/ais/operate/template" method="post">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width: 20%">
						    事项名称
						</td>
						<td class="editTd" colspan="3">
						<s:property value="audTaskTemplate.taskName"/>
						</td>
					</tr>
					<!--标题栏-->
					<s:hidden name="audTaskTemplate.taskTemplateId" />
					<s:hidden name="audTaskTemplate.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTaskTemplate.templateId" />
					<s:hidden name="audTaskTemplate.template_type" value="1" />

					<tr style='display:none;'>
						<td class="EditHead">
							事项序号
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:property value="audTaskTemplate.taskOrder" />
							<!--一般文本框-->
						</td>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead">
							事项编码
						</td>
						<!--标题栏-->
						<td class="editTd" colspan="3">
							<s:property value="audTaskTemplate.taskCode" />
							<s:hidden name="audTaskTemplate.taskCode" />
						</td>
					</tr>
					<s:if test="'enabled' == '${shenjichengxu}'">
						<tr>
							<td class="EditHead">
								前置事项名称
							</td>
							<td class="editTd">
								<s:property value="audTaskTemplate.taskBeforeName" />
							</td>
							<td class="EditHead">
								前置事项编码
							</td>
							<!--标题栏-->
							<td class="editTd">
								<s:property value="audTaskTemplate.taskBeforeCode" />
								<!--一般文本框-->
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								&nbsp;&nbsp;&nbsp;是否必做
							</td>
							<!--标题栏-->
							<td class="editTd">
								<s:if test="${audTaskTemplate.taskMust=='1'}">
							 是 
                        </s:if>
								<s:else> 
                                 否
						</s:else>
							</td>
							<td>
							</td>
							<!--标题栏-->
							<td>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								审计目的
							</td>
							<td class="editTd" colspan="3">
							</td>
						</tr>
						<tr>
							<td class="editTd" colspan="4">
								<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
								<s:textarea name="audTaskTemplate.taskTarget" readonly="true"
									cssStyle="width:100%;height:70;" />
							</td>
						</tr>
						</tr>
						<tr>
							<td class="EditHead">
								备注
							</td>
							<td cclass="editTd" colspan="3">
							</td>
						</tr>
						<tr>
							<td class="editTd" colspan="4">

								<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

								<s:textarea name="audTaskTemplate.taskFile" readonly="true"
									cssStyle="width:100%;height:70;" />
							</td>
						</tr>
					</s:if>
				</table>
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audTemplate.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
				<s:hidden name="path" />
				<s:hidden name="node" />
			</s:form>
		</div>
		<div region="center" border="0">
			<table id="listTaskDiv" ></table>
		</div>
	</body>
	<script>
	 	$(function(){
			// 初始化生成表格
			$('#listTaskDiv').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/showContentTypeViewByUi.action?taskTemplateId=${taskTemplateId}&project_id=${project_id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination: false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
					{field:'taskName',
						title:'事项名称',
						width:200,
						align:'left', 
						sortable:true
					},
					{field:'taskNametype',
						title:'类别名称',
						width:150,
						sortable:true, 
						align:'left',
						haling:'center',
						sortable:true
					},
					{field:'taskCode',
						 title:'事项编码',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 hidden:true,
					},
					{field:'taskOther',
						 title:'审计程序和方法',
						 width:150, 
						 align:'left', 
						 sortable:true
					},
					{field:'law',
						 title:'相关法律法规和监管规定',
						 width:150, 
						 align:'left', 
						 sortable:false
					},
					{field:'taskMethod',
						 title:'审计查证要点',
						 width:150, 
						 align:'left', 
						 sortable:false
					},
					{field:'pointContent',
						 title:'重点关注内容',
						 width:150, 
						 align:'left', 
						 sortable:false
					}
					/**,
					{field:'taskStartTime',
						 title:'事项开始时间',
						 width:80, 
						 align:'center', 
						 sortable:false
					},
					{field:'taskEndTime',
						 title:'事项结束时间',
						 width:80, 
						 align:'center', 
						 sortable:false
					}**/
				]]   
			}); 
		});
	</script>
</html>
