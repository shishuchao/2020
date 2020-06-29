<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>导入</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<%
	   		String s = (String)request.getAttribute("success");
	    %>
	</head>
 	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form id="myForm" action="generateTemplate" namespace="/operate/task" method="post">
			<div region="center" >
				<table ccellpadding=0 cellspacing=0 border=0  class="ListTable" align="center">
					<tr>
						<td class="EditHead">
							方案名称
						</td>
						<td class="editTd">
							<s:textfield name="title" cssStyle="width:160px;"/>
							<s:hidden name="project_id"/>
						</td>
					</tr>
				</table>
			</div>
			<div region="south" border="false" style="text-align:right;padding-right:20px;">
				<div style="display: inline;" align="right">
					<a id="submitButton" class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="wait()">回传</a>
					&nbsp;&nbsp;
					<a id="exitButton" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="window.parent.closedlg();">取消</a>
				</div>
			</div>
		</s:form>

		 <div id="layer" style="display:none">
				<img src="${contextPath}/images/uploading.gif">
				<br>
				正在读取，请稍候... ...
			</div>
			<div align="center" id="errorInfo1">
				  <% if(s!=null&&!"".equals(s)&&!"true".equals(s)){%>
				  <%=s %>
				  <% }%>
				  <% if("true".equals(s)){%>
				   回传成功!
				  <% }%>
			</div>
<script type="text/javascript">
function wait()
{    
    if($("#myForm_title").val().replace(/\s+$|^\s+/g,"")==""){
		$.messager.show({
			title:'提示信息',
			msg:'请输入回传方案名称！',
			timeout:5000,
			showType:'slide'
		});
    	return false;
    }
    $('#submitButton').linkbutton('disable');
    $("#layer").css("display","");
	//document.getElementById("errorInfo1").style.display="none";
	$('#myForm').form('submit',{
   		onSubmit:function(){
       		return true; //当表单验证不通过的时候 必须要return false 
       	},
        success:function(result){
        	window.parent.closedlg();
			window.parent.$.messager.show({
				title:'提示信息',
				msg:'回传成功！',
				timeout:5000,
				showType:'slide'
			});
        }
    });
}
function add()
{
	window.location.href='<s:url action="edit" includeParams="none"></s:url>';
}	
function load()
{
	window.location.href='${contextPath}/operate/doubt/downloadTemplate.action';
     
}
</script>
</body>
</html>
