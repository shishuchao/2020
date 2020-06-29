<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%
    String _ServerName = request.getServerName();
    int _ServerPort = request.getServerPort();
    String _CtxPath = request.getContextPath();
    String url_prefix = "http://" + _ServerName + ":" + _ServerPort + _CtxPath;
%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>审计报告</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/commons/file/WebOffice.js"></script>
	<script type="text/javascript">
		var WebOffice = new WebOffice2015(); //创建WebOffice对象
	</script>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
		html, body, form, table {
			margin: 0;
			padding: 0;
		}
        html, body, form {
            width: 100%;
            height: 100%;
        }
		.ListTable {
            margin: 0;
        }
    </style>
</head>
<body>
<s:form id="webform" name="webform" action="saveTemplate" namespace="/unitary/nc/autoreport">
<table class="ListTable" style="width:100%;height:100%;" align="center">
    <tr style="height:50px;">
        <td colspan="2">
            <s:if test="${isView != 'view'}">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveTemplate()">保存</a>
            </s:if>
            &nbsp;&nbsp;&nbsp;&nbsp;模板名称:
            <input type="text" class="noborder" id="name"/>
        </td>
    </tr>
	<tr style="height:auto;">
		<td style="">
            <s:hidden id="projectTypeCode"/>
            <s:hidden id="templateId" />
            <s:hidden id="id" />
            <s:hidden id="fromType" />
            <div id="webOfficeDiv" style="height:100%;width:100%;">
				<script type="text/javascript" src="${contextPath}/pages/commons/file/iWebOffice2015.js"></script>
			</div>
        </td>
        <s:if test="${isView != 'view'}">
        <td style="width:200px;vertical-align:top;">
            <div align="center">
                <font size="4">公式列表</font>
            </div>
            <s:select id="formulaList" name="formula.id" cssStyle="width:100%;height:500px;"
                      list="formulaList" listKey="name" listValue="name"
                      disabled="false" theme="ufaud_simple"
                      templateDir="/strutsTemplate" multiple="true" ondblclick="insertFormula(this.value)"/>
        </td>
        </s:if>
	</tr>
</table>
</s:form>

<script type="text/javascript">
    $(function(){
        editTemplate('${fromType}');
        $('#DivID').height('100%');
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
					'fromType':'${fromType}',
					'template.projectTypeCode':'${projectTypeCode}'
				},
				success:function(data){
					template = data;
				}
			});
			document.getElementById('id').value=template.id;
			document.getElementById('projectTypeCode').value='${projectTypeCode}';
			document.getElementById('templateId').value=template.templateId;
			$('#name').val(template.name);
			WebOffice.setObj(document.getElementById('WebOffice'));//给2015对象赋值
			WebOffice.ShowTitleBar(false);
			WebOffice.ShowStatusBar(true);
			$('#table2').height($(document).height()-$('#table1').height());
			$('#webOfficeDiv').height($('#objectTD').height());

			WebOffice.WebUrl="<%=url_prefix%>/iweb/file"+template.templateId;
			WebOffice.RecordID=template.templateId;   //RecordID:项目编码
			WebOffice.FileName=template.templateId+"_项目报告模板.doc";
			WebOffice.FileType=".doc";   //FileType:文档类型  .doc  .xls  .wps
			WebOffice.setEditType("1");   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			WebOffice.EditType='1';
			WebOffice.UserName='${user.floginname}';
			WebOffice.HookEnabled();
			WebOffice.WebOpen(true);
			WebOffice.ShowCustomToolbar(false);
		    WebOffice.ShowMenuBar(false);
			WebOffice.WebShow(false);
		}catch(e){
			StatusMsg(e.message);
		}
    }

    /**
     *	插入指定公式到光标位置
     */
    function insertFormula(formulaName){
    	WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertBefore('{'+formulaName+'}');
    }

    /**
     *	保存模板
     */
    function saveTemplate(){

		//首先保存word文档内容
		if (!WebOffice.WebSave()){
			StatusMsg('Word正文保存到服务器过程中发生未知错误!');
			return false;
		}

		//然后保存模板相关信息
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);
		DWRActionUtil.execute(
				{ namespace:'/unitary/nc/autoreport', action:'saveTemplate', executeResult:'false' },
				{'template.projectTypeCode':document.getElementById('projectTypeCode').value,
					'template.id':document.getElementById('id').value,
					'template.templateId':document.getElementById('templateId').value,
					'template.name':$('#name').val(),
					'fromType':'${fromType}'},
				xxx);
		function xxx(data){
			StatusMsg(data['ajaxMessage']);
		}

    }
    
	//设置页面中的状态值
	function StatusMsg(mValue){
		try{
			document.getElementById('state').innerHTML = mValue;
		}catch(e){
			return false;
		}
	}
</script>
</body>
</html>
