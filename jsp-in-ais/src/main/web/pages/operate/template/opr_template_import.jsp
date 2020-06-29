<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
   String s = (String)request.getAttribute("success");
   //System.out.print(s);
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>导入</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	</head>
	<body onload="test(<%=s%>)" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<br>
		<div region="center">
			<s:form id="importForm" action="importExcel" namespace="/operate/template"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="interCtrl" value="${interCtrl}"/>
				<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
					<tr >
						<td class="EditHead" colspan="4">
							<font style="float: left;">&nbsp;导入方案：新导入的方案将替换原有的方案</font>
						</td>
					</tr>
					<tr >
						<td class="EditHead">
							选择文件：
						</td>
						<td class="editTd">
							<s:file name="storeFile" size="50%" />
						</td>   
						<s:hidden name="audTemplateId" />
					</tr>
				</table>
				<div style="text-align:center;padding:5px;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-download'" onclick="load()">下载模板</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-import'" onclick="wait()">导入</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWindow()">关闭</a>&nbsp;&nbsp;
					<br>
				</div>
			</s:form>
		    <div id="layer" style="display:none">
				<img src="${contextPath}/images/uploading.gif">
				<br>
				正在读取，请稍候... ...
			</div>
			<div align="center" id="errorInfo1">
				<br>
				<% if(s!=null&&!"".equals(s)&&!"true".equals(s)){%>
				<%=s %>
				<% }%>
				<% if("true".equals(s)){%>

				<% }%>
			</div>
		</div>
		<script type="text/javascript">
			function test(s){
				if(s==true){
					showMessage1('导入成功！');
				}else{

				}
			}
			function add(){
				window.location.href='<s:url action="edit" includeParams="none"></s:url>';
			}	
			function closeWindow(){
				window.parent.closeGenW();
				window.close();
			}
			//提交导入的excel
			function wait(){
				var v_3 = "storeFile";  // field
				var title_3 = '文件';// field name
				var notNull = 'true'; // notnull
				if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
					showMessage1(title_3+"不能为空!");
					bool = false;
					document.getElementById(v_3).focus();
					return false;
				}
				if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
					showMessage1(title_3+"不能为空!");
					bool = false;
					document.getElementById(v_3).focus();
					return false;
				}
			//	document.getElementById("submitButton").disabled=true;
				document.getElementById("layer").style.display="";
				document.getElementById("errorInfo1").style.display="none";
				importForm.submit();
			}
			function load(){
				window.location.href='${contextPath}/operate/doubt/downloadTemplate.action';  
			}
		</script>
	</body>
</html>
