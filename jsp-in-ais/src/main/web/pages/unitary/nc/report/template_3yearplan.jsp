<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
String _ServerName = request.getServerName();
int _ServerPort = request.getServerPort();
String _CtxPath = request.getContextPath();
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>三年计划导出模板</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>

	</head>
	<body>
		<s:form id="webform" name="webform" action="saveTemplate" namespace="/unitary/nc/autoreport">
			<table cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center" style="width: 95%;">
				<tr>
					<td colspan="2">
						<s:if test="${isView != 'view'}">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveTemplate()">保存</a>
						</s:if>
						&nbsp;&nbsp;&nbsp;&nbsp;模板名称:
						<input type="text" class="noborder" id="name"/>
					</td>
				</tr>
				</table>
				<table cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center" style="width: 95%;">
				<tr>
					<td class="editTd" style="width:95%;height:100%;">
						<s:hidden id="templateId" />
						<s:hidden id="id" />
						<s:hidden id="fromType" />
							<script type="text/javascript" src="${contextPath}/pages/commons/file/iWebOffice2003.js"></script>
					</td>
					<s:if test="${isView != 'view'}">
					<td class="editTd" style="width:5%;" nowrap="nowrap">
						<div align="center">
						<font size="4">公式列表</font>
						</div>
						<s:select id="formulaList" name="formula.id" cssStyle="width:150px;height:500px;"
								list="formulaList" listKey="name" listValue="name"
								disabled="false" theme="ufaud_simple"
								templateDir="/strutsTemplate" multiple="true" ondblclick="insertFormula(this.value)"/>
					</s:if>
					</td>
				</tr>
			</table>
		</s:form>
		<script type="text/javascript">
			$(function(){
				editTemplate('${fromType}');
				
				$('#DivID').height($('body').height());
			});
			function editTemplate(type){
				try{
					var template = null;
					$.ajax({
						url:'${contextPath}/unitary/nc/autoreport/editTemplate.action',
						type:'post',
						dataType:'json',
						async:false,
						data:{
							'template.id':'${templateId}',
							'fromType':'${fromType}'
						},
						success:function(data){
							template = data;
						}
					});
					document.getElementById('id').value=template.id;
					document.getElementById('templateId').value=template.templateId;
					$('#name').val(template.name);

                    webform.WebOffice.WebUrl="<%=url_prefix%>/iweb/file"+template.templateId;
					webform.WebOffice.RecordID=template.templateId;   //RecordID:项目编码
					webform.WebOffice.FileName=template.templateId+"_三年计划导出模板.doc";
					webform.WebOffice.FileType=".doc";   //FileType:文档类型  .doc  .xls  .wps
					webform.WebOffice.EditType="1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
					webform.WebOffice.ShowMenu="0";
					webform.WebOffice.WebOpen();
				}catch(e){
                    top.$.messager.show({title:'提示信息',msg:e.message});
				}
			}
			
			/**
			*	插入指定公式到光标位置
			*/
			function insertFormula(formulaName){
				 webform.WebOffice.WebObject.Application.Selection.Range.InsertBefore('{'+formulaName+'}');
			}
			
			/**
			*	保存模板
			*/
			function saveTemplate(){
				
			  //首先保存word文档内容
			  if (!webform.WebOffice.WebSave(true)){
			     top.$.messager.show({title:'提示信息',msg:'Word正文保存到服务器过程中发生未知错误!'});
			     return false;
			  }	

			  $.ajax({
				  url:'${contextPath}/unitary/nc/autoreport/saveTemplate.action',
				  type:'post',
				  data:{
                      'template.id':$('#id').val(),
                      'template.templateId':$('#templateId').val(),
                      'template.name':$('#name').val(),
                      'fromType':'${fromType}'
				  },
				  dataType:'json',
				  success:function(data){
				      showMessage1(data.ajaxMessage);
				  }
			  });
			}
		</script>

	</body>
</html>
