<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
		<title>增加、修改扩展内容</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">	
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script language="javascript">			
			function myCheck(){				
				n=$_name('auditImportantExtra.importantContentExtraName');			
				if(empty(n)){
					$.messager.show({title:'提示信息',msg:'名称是必填项!'});
					return false;
				}				
				return true;
			}
			function gback(){  
				window.history.back();				
			}
			function $_name(n){return document.getElementsByName(n)[0];}
			function empty(n){if(n.value==''){n.focus();n.select(); return true;}return false;}
			function empty2(n){if(n.value==''){n.focus(); return true;}return false;}
			function isNum(obj) {b=(new RegExp(/^[0-9]+$/).test(obj.value)); if(!b){obj.focus();obj.select();}return b;}
			
			function saveEXtra(){				
				if(!myCheck()){
					return false;
				}
				document.getElementById("myform").submit();
				gback();
			}
		</script>
	</head>
<body >
		<div class="easyui-panel" title="${name}" fit=true style="overflow: visibility ;">		
		<s:form id="myform" name="myform"  namespace="/auditImportantContent" action="saveExtra"  onsubmit="return myCheck();" theme="simple">		
			<input name="auditImportant.importantContentId" value="${param.importantContentId}" type="hidden"/>			
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;名称
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder"  name="auditImportantExtra.importantContentExtraName" />
					</td>					
				</tr>
				
			</table>			
			<s:hidden name="auditImportantExtra.importantContentExtraId" />
			<s:hidden name="auditImportantExtra.importantExtraId" />						
			<br>
				<div style="margin-top:10px;text-align:center"> 
							<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveEXtra()">保存</a>&nbsp;&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="gback()">返回</a>&nbsp;&nbsp;
						</div>
		</s:form>
	</div>
	</body>
</html>
